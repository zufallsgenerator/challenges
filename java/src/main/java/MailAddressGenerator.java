import static org.apache.commons.codec.digest.DigestUtils.sha1Hex;

/**
 * @author egga
 */
public class MailAddressGenerator {

    private static final String DOMAIN = "gmail.com";
    private static final String PREFIX = "c0ffee";

    public static void main(String[] args) {
        for (String arg : args) {
            asd(arg);
        }
    }

    private static void asd(String username) {
        System.out.println("############################");
        System.out.println("Finding solution for user: " + username);
        for (Integer i = 0; i < 100000000; i++) {
            String postfix = i.toString();

            String mailAddress = username + "+" + postfix + "@" + DOMAIN;
            String sha1 = sha1Hex(mailAddress);

            if (sha1.startsWith(PREFIX)) {
                System.out.println("Mail Address: " + mailAddress);
                System.out.println("SHA1:         " + sha1);
                break;
            }
        }
    }

}
