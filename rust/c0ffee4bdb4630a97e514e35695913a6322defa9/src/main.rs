extern crate sha1;

fn hash(sha: &mut sha1::Sha1, str: &String) -> String {
    sha.reset();
    sha.update(str.as_bytes());
    return sha.hexdigest();
}

fn main() {
    let mut sha = sha1::Sha1::new();

    for i in 0..u64::max_value() {
        let mail = format!("example+{}@example.com", i);
        let hex = hash(&mut sha, &mail);

        if &hex[..6] == "c0ffee" {
            println!("Found {} with hash {} after {} tries", mail, hex, i);
            break;
        }
    }
}
