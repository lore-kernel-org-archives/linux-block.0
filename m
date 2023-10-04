Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF331E7C4F6
	for <linux-block@archiver.kernel.org>; Wed,  4 Oct 2023 20:20:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244499AbjJDUUu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 4 Oct 2023 16:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244503AbjJDUU3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 4 Oct 2023 16:20:29 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2F0FBF
        for <linux-block@vger.kernel.org>; Wed,  4 Oct 2023 13:20:24 -0700 (PDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 394KCvBC031189;
        Wed, 4 Oct 2023 20:20:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=d3Q0t3vOd0JeTtWcQ6bFRKuZpMU0wg3lJ7ULat7PT70=;
 b=HUybFeYyGq3lrdQDwoV3doJUT3xauFp6gqsqa+0xpTogy9qD3aaUhWZ+ExKTDJ2BH9oc
 dWo27mOkkfXKVQfIU9Qz124q2n+u2PGwEUylS8yfb5Q8LFu+NlJ0Q7ZSAnDTd5Ms3zri
 dfEG1Q7T4lrFIZUukdlzkOZBm5l2l1LbtgK8pFA/ag6j+IEp4vzEYcIxz4d1np39pwxT
 kdZyNPW/1RdRJe2E6xBBOMPZf75A5UE3gbEFbKXj26yKzivSdHBVpA7nE70f96v/Zezl
 FS8NrTHG8shcmE2XIwSlVvsL952HgaJqWVuN/v2RT1GyspETe+n542zAYD8ZzPOjixPH ww== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3thevu050m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Oct 2023 20:20:02 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 394KEAaD001604;
        Wed, 4 Oct 2023 20:20:01 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3thevu0503-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Oct 2023 20:20:01 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 394JYA1N025047;
        Wed, 4 Oct 2023 20:20:00 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3texcykugb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Oct 2023 20:20:00 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
        by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 394KK03735389820
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 4 Oct 2023 20:20:00 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4D0785804B;
        Wed,  4 Oct 2023 20:20:00 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9D29B58055;
        Wed,  4 Oct 2023 20:19:59 +0000 (GMT)
Received: from rhel-laptop.ibm.com (unknown [9.61.54.52])
        by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Wed,  4 Oct 2023 20:19:59 +0000 (GMT)
From:   gjoyce@linux.vnet.ibm.com
To:     linux-block@vger.kernel.org, axboe@kernel.dk
Cc:     linuxppc-dev@lists.ozlabs.org, jonathan.derrick@linux.dev,
        brking@linux.vnet.ibm.com, msuchanek@suse.de, mpe@ellerman.id.au,
        nayna@linux.ibm.com, akpm@linux-foundation.org,
        gjoyce@linux.vnet.ibm.com, ndesaulniers@google.com,
        nathan@kernel.org, jarkko@kernel.org, okozina@redhat.com
Subject: [PATCH v8 2/3] block: sed-opal: keystore access for SED Opal keys
Date:   Wed,  4 Oct 2023 15:19:56 -0500
Message-Id: <20231004201957.1451669-3-gjoyce@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231004201957.1451669-1-gjoyce@linux.vnet.ibm.com>
References: <20231004201957.1451669-1-gjoyce@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: CAFRSuVQSDd0nd0zXw6GyMW1d1oB6Rsj
X-Proofpoint-GUID: tveLyCOb7ab05caua_femed8dxHw3XVs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-04_10,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 bulkscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0 suspectscore=0
 adultscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310040148
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Greg Joyce <gjoyce@linux.vnet.ibm.com>

Allow for permanent SED authentication keys by
reading/writing to the SED Opal non-volatile keystore.

Signed-off-by: Greg Joyce <gjoyce@linux.vnet.ibm.com>
Reviewed-by: Jonathan Derrick <jonathan.derrick@linux.dev>
---
 block/sed-opal.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/block/sed-opal.c b/block/sed-opal.c
index 6d7f25d1711b..fa23a6a60485 100644
--- a/block/sed-opal.c
+++ b/block/sed-opal.c
@@ -18,6 +18,7 @@
 #include <linux/uaccess.h>
 #include <uapi/linux/sed-opal.h>
 #include <linux/sed-opal.h>
+#include <linux/sed-opal-key.h>
 #include <linux/string.h>
 #include <linux/kdev_t.h>
 #include <linux/key.h>
@@ -3019,7 +3020,13 @@ static int opal_set_new_pw(struct opal_dev *dev, struct opal_new_pw *opal_pw)
 	if (ret)
 		return ret;
 
-	/* update keyring with new password */
+	/* update keyring and key store with new password */
+	ret = sed_write_key(OPAL_AUTH_KEY,
+			    opal_pw->new_user_pw.opal_key.key,
+			    opal_pw->new_user_pw.opal_key.key_len);
+	if (ret != -EOPNOTSUPP)
+		pr_warn("error updating SED key: %d\n", ret);
+
 	ret = update_sed_opal_key(OPAL_AUTH_KEY,
 				  opal_pw->new_user_pw.opal_key.key,
 				  opal_pw->new_user_pw.opal_key.key_len);
@@ -3292,6 +3299,8 @@ EXPORT_SYMBOL_GPL(sed_ioctl);
 static int __init sed_opal_init(void)
 {
 	struct key *kr;
+	char init_sed_key[OPAL_KEY_MAX];
+	int keylen = OPAL_KEY_MAX - 1;
 
 	kr = keyring_alloc(".sed_opal",
 			   GLOBAL_ROOT_UID, GLOBAL_ROOT_GID, current_cred(),
@@ -3304,6 +3313,11 @@ static int __init sed_opal_init(void)
 
 	sed_opal_keyring = kr;
 
-	return 0;
+	if (sed_read_key(OPAL_AUTH_KEY, init_sed_key, &keylen) < 0) {
+		memset(init_sed_key, '\0', sizeof(init_sed_key));
+		keylen = OPAL_KEY_MAX - 1;
+	}
+
+	return update_sed_opal_key(OPAL_AUTH_KEY, init_sed_key, keylen);
 }
 late_initcall(sed_opal_init);
-- 
gjoyce@linux.vnet.ibm.com

