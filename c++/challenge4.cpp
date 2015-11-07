#include <iostream>
#include <string>
#include <vector>
#include <sstream>
#include <openssl/sha.h>

class pattern_checker
{
public:
    pattern_checker(std::string pat)
    {
        if (pat.size() % 2 != 0) {
            pat += "0"; // also matches the pattern
        }
        auto it = pat.begin();
        while(it != pat.end()) {
            std::stringstream ss;
            ss << std::hex << *(it) << *(it+1);
            short s;
            ss >> s;
            _conv.push_back(s);
            ++it; ++it;
        }
    }

    bool check(const std::string& email)
    {
        SHA1((unsigned char *)email.c_str(), email.size(), m_hash);
        for (size_t i = 0; i < _conv.size(); ++i) {
            if (_conv[i] != m_hash[i]) return false;
        }
        return true;
    }

    std::string hex_hash()
    {
        std::stringstream ss;
        for(int i = 0; i < SHA_DIGEST_LENGTH; ++i) {
            ss << std::hex << short(m_hash[i]);
        }
        return ss.str();
    }

private:
    std::vector<unsigned char> _conv;
    unsigned char m_hash[SHA_DIGEST_LENGTH];
};

int main(int argc, char **argv)
{
    if ( argc != 3 ) {
        std::cout << "Usage: " << argv[0] << " email pattern" << std::endl;
        std::cout << "v.g.: " << argv[0] << " example@example.com c0ffee" << std::endl;
        return -1;
    }

    pattern_checker pc(argv[2]);

    std::string email = argv[1];
    std::size_t at = email.find("@");
    if (at == std::string::npos) {
        std::cout << "No @ in email " << email << std::endl;
        return -1;
    }
    std::string prefix = email.substr(0, at) + "+";
    std::string suffix = email.substr(at);

    int k=0;
    std::string em;
    while (true) {
        em  = prefix + std::to_string(k) + suffix;
        if (pc.check(em)) {
            std::cout << em << std::endl;
            std::cout << pc.hex_hash() << std::endl;
            break;
        }
        k++;
    }
    return 0;
}
