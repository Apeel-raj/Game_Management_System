package com.gamevault.util;
import org.mindrot.jbcrypt.BCrypt;
public class TestHash {
    public static void main(String[] args) {
        System.out.println("HASH_START:" + BCrypt.hashpw("admin", BCrypt.gensalt()) + ":HASH_END");
    }
}
