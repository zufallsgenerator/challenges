extern crate sha1;

pub fn main() {
    let mut m = ::sha1::Sha1::new();
    let mut cont = true;
    let mut n = 0u64;
    while cont {
        n += 1;
        let email = format!("benjamin.bollen.{}@seetale.com", n);
        let data = email.as_bytes();

        m.reset();
        m.update(data);
        let hh = m.hexdigest();

        let beginning : String = hh.chars().take(6).collect();
        if "c0ffee" == beginning {
            println!("sha1sum for {} is {}", email, hh);
            cont = false;
        };
    }
}


// from https://github.com/mitsuhiko/rust-sha1
#[test]
fn ref_challenge() {
    let tests = [
        ("example+1899634@example.com",
         "c0ffee9c56ed151525700240ccb034ab34f27239"),
        ("The quick brown fox jumps over the lazy dog",
         "2fd4e1c67a2d28fced849ee1bb76e7391b93eb12"),
        ("The quick brown fox jumps over the lazy cog",
         "de9f2c7fd25e1b3afad3e85a0bd17d9b100db4b3"),
        ("", "da39a3ee5e6b4b0d3255bfef95601890afd80709"),
        ("testing\n", "9801739daae44ec5293d4e1f53d3f4d2d426d91c"),
        ("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
         "025ecbd5d70f8fb3c5457cd96bab13fda305dc59"),
    ];

    let mut m = ::sha1::Sha1::new();
    for &(s, ref h) in tests.iter() {
        let data = s.as_bytes();

        m.reset();
        m.update(data);
        let hh = m.hexdigest();

        assert_eq!(hh.len(), h.len());
		assert_eq!(hh, *h);
    }
}
