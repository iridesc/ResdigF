import Vue from 'vue'
import AES256 from "aes-everywhere";
export default {
    //加密
    encrypt(obj, key) {
        return AES256.encrypt(JSON.stringify(obj), key)
    },
    //解密
    decrypt(encryptoedStr, key) {
        return JSON.parse(AES256.decrypt(encryptoedStr, key))
    }
}
