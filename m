Return-Path: <linux-block-owner@vger.kernel.org>
Received: from userp2130.oracle.com ([156.151.31.86]:42432 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726503AbeHZGW2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 26 Aug 2018 02:22:28 -0400
From: "Martin K. Petersen" <martin.petersen@oracle.com>
To: herbert@gondor.apana.org.au
Cc: Jeff.Lien@wdc.com, ard.biesheuvel@linaro.org,
        david.darrington@wdc.com, hch@infradead.org, jeff.furlong@wdc.com,
        linux-block@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        martin.petersen@oracle.com, tim.c.chen@linux.intel.com
Subject: [PATCH 3/4] crc-t10dif: Allow current transform to be inspected in sysfs
Date: Sat, 25 Aug 2018 22:40:05 -0400
Message-Id: <20180826024006.13800-3-martin.petersen@oracle.com>
In-Reply-To: <20180826024006.13800-1-martin.petersen@oracle.com>
References: <20180825061205.ygrjjazkooqghrqy@gondor.apana.org.au>
 <20180826024006.13800-1-martin.petersen@oracle.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Add a way to print the currently active CRC algorithm in:

	/sys/module/crc_t10dif/parameters/transform

Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
---
 lib/crc-t10dif.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/lib/crc-t10dif.c b/lib/crc-t10dif.c
index 72076a902df5..21c9b35a656f 100644
--- a/lib/crc-t10dif.c
+++ b/lib/crc-t10dif.c
@@ -107,6 +107,17 @@ static void __exit crc_t10dif_mod_fini(void)
 module_init(crc_t10dif_mod_init);
 module_exit(crc_t10dif_mod_fini);
 
+static int crc_t10dif_transform_show(char *buffer, const struct kernel_param *kp)
+{
+	if (static_key_false(&crct10dif_fallback))
+		return sprintf(buffer, "fallback\n");
+
+	return sprintf(buffer, "%s\n",
+		crypto_tfm_alg_driver_name(crypto_shash_tfm(crct10dif_tfm)));
+}
+
+module_param_call(transform, NULL, crc_t10dif_transform_show, NULL, 0644);
+
 MODULE_DESCRIPTION("T10 DIF CRC calculation");
 MODULE_LICENSE("GPL");
 MODULE_SOFTDEP("pre: crct10dif");
-- 
2.17.1
