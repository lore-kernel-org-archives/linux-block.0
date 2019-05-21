Return-Path: <SRS0=jUAw=TV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92A5DC16A69
	for <linux-block@archiver.kernel.org>; Tue, 21 May 2019 20:47:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DC8B217D7
	for <linux-block@archiver.kernel.org>; Tue, 21 May 2019 20:47:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fjfi.cvut.cz header.i=@fjfi.cvut.cz header.b="rwI5Gug1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbfEUUq4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 May 2019 16:46:56 -0400
Received: from mailgw1.fjfi.cvut.cz ([147.32.9.3]:56046 "EHLO
        mailgw1.fjfi.cvut.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726907AbfEUUqz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 May 2019 16:46:55 -0400
Received: from localhost (localhost [127.0.0.1])
        by mailgw1.fjfi.cvut.cz (Postfix) with ESMTP id C0F0EA004A;
        Tue, 21 May 2019 22:46:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fjfi.cvut.cz;
        s=20151024; t=1558471612; i=@fjfi.cvut.cz;
        bh=4RgUqqeUHWHgxEKWCBbvpisy8Y25KeBndYYjOulFN+s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=rwI5Gug1eIjvlXMhpOqFSvqq5MNVdJoJUcOOQMS1nkp+RDdfoMy+J3IWVMP/kD47T
         5EVH8sYa0G67a1M4g0Xcu6S/xl9KNuyvzVJ8hGWIBRuxWB85/q5PoeQ6X5c8rPgqjE
         4nH2e+bjoxjh4gYZC4kasVX67Ub7VFOJiR8bzz+E=
X-CTU-FNSPE-Virus-Scanned: amavisd-new at fjfi.cvut.cz
Received: from mailgw1.fjfi.cvut.cz ([127.0.0.1])
        by localhost (mailgw1.fjfi.cvut.cz [127.0.0.1]) (amavisd-new, port 10022)
        with ESMTP id y1YnxB_RTcMs; Tue, 21 May 2019 22:46:47 +0200 (CEST)
Received: from linux.fjfi.cvut.cz (linux.fjfi.cvut.cz [147.32.5.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailgw1.fjfi.cvut.cz (Postfix) with ESMTPS id 6A051A018B;
        Tue, 21 May 2019 22:46:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailgw1.fjfi.cvut.cz 6A051A018B
Received: by linux.fjfi.cvut.cz (Postfix, from userid 1001)
        id 4B28960050; Tue, 21 May 2019 22:46:47 +0200 (CEST)
From:   David Kozub <zub@linux.fjfi.cvut.cz>
To:     Jens Axboe <axboe@kernel.dk>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        Scott Bauer <sbauer@plzdonthack.me>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Subject: [PATCH v2 2/3] block: sed-opal: ioctl for writing to shadow mbr
Date:   Tue, 21 May 2019 22:46:45 +0200
Message-Id: <1558471606-25139-3-git-send-email-zub@linux.fjfi.cvut.cz>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1558471606-25139-1-git-send-email-zub@linux.fjfi.cvut.cz>
References: <1558471606-25139-1-git-send-email-zub@linux.fjfi.cvut.cz>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>

Allow modification of the shadow mbr. If the shadow mbr is not marked as
done, this data will be presented read only as the device content. Only
after marking the shadow mbr as done and unlocking a locking range the
actual content is accessible.

Co-authored-by: David Kozub <zub@linux.fjfi.cvut.cz>
Signed-off-by: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Signed-off-by: David Kozub <zub@linux.fjfi.cvut.cz>
Reviewed-by: Scott Bauer <sbauer@plzdonthack.me>
Reviewed-by: Jon Derrick <jonathan.derrick@intel.com>
---
 block/sed-opal.c              | 91 ++++++++++++++++++++++++++++++++++-
 include/linux/sed-opal.h      |  1 +
 include/uapi/linux/sed-opal.h |  8 +++
 3 files changed, 98 insertions(+), 2 deletions(-)

diff --git a/block/sed-opal.c b/block/sed-opal.c
index a330fc67f3a3..c13ac0ebd5e0 100644
--- a/block/sed-opal.c
+++ b/block/sed-opal.c
@@ -26,6 +26,9 @@
 #define IO_BUFFER_LENGTH 2048
 #define MAX_TOKS 64
 
+/* Number of bytes needed by cmd_finalize. */
+#define CMD_FINALIZE_BYTES_NEEDED 7
+
 struct opal_step {
 	int (*fn)(struct opal_dev *dev, void *data);
 	void *data;
@@ -523,12 +526,17 @@ static int opal_discovery0_step(struct opal_dev *dev)
 	return execute_step(dev, &discovery0_step, 0);
 }
 
+static size_t remaining_size(struct opal_dev *cmd)
+{
+	return IO_BUFFER_LENGTH - cmd->pos;
+}
+
 static bool can_add(int *err, struct opal_dev *cmd, size_t len)
 {
 	if (*err)
 		return false;
 
-	if (len > IO_BUFFER_LENGTH || cmd->pos > IO_BUFFER_LENGTH - len) {
+	if (remaining_size(cmd) < len) {
 		pr_debug("Error adding %zu bytes: end of buffer.\n", len);
 		*err = -ERANGE;
 		return false;
@@ -674,7 +682,11 @@ static int cmd_finalize(struct opal_dev *cmd, u32 hsn, u32 tsn)
 	struct opal_header *hdr;
 	int err = 0;
 
-	/* close the parameter list opened from cmd_start */
+	/*
+	 * Close the parameter list opened from cmd_start.
+	 * The number of bytes added must be equal to
+	 * CMD_FINALIZE_BYTES_NEEDED.
+	 */
 	add_token_u8(&err, cmd, OPAL_ENDLIST);
 
 	add_token_u8(&err, cmd, OPAL_ENDOFDATA);
@@ -1525,6 +1537,58 @@ static int set_mbr_enable_disable(struct opal_dev *dev, void *data)
 	return finalize_and_send(dev, parse_and_check_status);
 }
 
+static int write_shadow_mbr(struct opal_dev *dev, void *data)
+{
+	struct opal_shadow_mbr *shadow = data;
+	const u8 __user *src;
+	u8 *dst;
+	size_t off = 0;
+	u64 len;
+	int err = 0;
+
+	/* do the actual transmission(s) */
+	src = (u8 __user *)(uintptr_t)shadow->data;
+	while (off < shadow->size) {
+		err = cmd_start(dev, opaluid[OPAL_MBR], opalmethod[OPAL_SET]);
+		add_token_u8(&err, dev, OPAL_STARTNAME);
+		add_token_u8(&err, dev, OPAL_WHERE);
+		add_token_u64(&err, dev, shadow->offset + off);
+		add_token_u8(&err, dev, OPAL_ENDNAME);
+
+		add_token_u8(&err, dev, OPAL_STARTNAME);
+		add_token_u8(&err, dev, OPAL_VALUES);
+
+		/*
+		 * The bytestring header is either 1 or 2 bytes, so assume 2.
+		 * There also needs to be enough space to accommodate the
+		 * trailing OPAL_ENDNAME (1 byte) and tokens added by
+		 * cmd_finalize.
+		 */
+		len = min(remaining_size(dev) - (2+1+CMD_FINALIZE_BYTES_NEEDED),
+			  (size_t)(shadow->size - off));
+		pr_debug("MBR: write bytes %zu+%llu/%llu\n",
+			 off, len, shadow->size);
+
+		dst = add_bytestring_header(&err, dev, len);
+		if (!dst)
+			break;
+		if (copy_from_user(dst, src + off, len))
+			err = -EFAULT;
+		dev->pos += len;
+
+		add_token_u8(&err, dev, OPAL_ENDNAME);
+		if (err)
+			break;
+
+		err = finalize_and_send(dev, parse_and_check_status);
+		if (err)
+			break;
+
+		off += len;
+	}
+	return err;
+}
+
 static int generic_pw_cmd(u8 *key, size_t key_len, u8 *cpin_uid,
 			  struct opal_dev *dev)
 {
@@ -2002,6 +2066,26 @@ static int opal_set_mbr_done(struct opal_dev *dev,
 	return ret;
 }
 
+static int opal_write_shadow_mbr(struct opal_dev *dev,
+				 struct opal_shadow_mbr *info)
+{
+	const struct opal_step mbr_steps[] = {
+		{ start_admin1LSP_opal_session, &info->key },
+		{ write_shadow_mbr, info },
+		{ end_opal_session, }
+	};
+	int ret;
+
+	if (info->size == 0)
+		return 0;
+
+	mutex_lock(&dev->dev_lock);
+	setup_opal_dev(dev);
+	ret = execute_steps(dev, mbr_steps, ARRAY_SIZE(mbr_steps));
+	mutex_unlock(&dev->dev_lock);
+	return ret;
+}
+
 static int opal_save(struct opal_dev *dev, struct opal_lock_unlock *lk_unlk)
 {
 	struct opal_suspend_data *suspend;
@@ -2318,6 +2402,9 @@ int sed_ioctl(struct opal_dev *dev, unsigned int cmd, void __user *arg)
 	case IOC_OPAL_MBR_DONE:
 		ret = opal_set_mbr_done(dev, p);
 		break;
+	case IOC_OPAL_WRITE_SHADOW_MBR:
+		ret = opal_write_shadow_mbr(dev, p);
+		break;
 	case IOC_OPAL_ERASE_LR:
 		ret = opal_erase_locking_range(dev, p);
 		break;
diff --git a/include/linux/sed-opal.h b/include/linux/sed-opal.h
index 111dd893d45a..d7993be280db 100644
--- a/include/linux/sed-opal.h
+++ b/include/linux/sed-opal.h
@@ -40,6 +40,7 @@ static inline bool is_sed_ioctl(unsigned int cmd)
 	case IOC_OPAL_ERASE_LR:
 	case IOC_OPAL_SECURE_ERASE_LR:
 	case IOC_OPAL_MBR_DONE:
+	case IOC_OPAL_WRITE_SHADOW_MBR:
 		return true;
 	}
 	return false;
diff --git a/include/uapi/linux/sed-opal.h b/include/uapi/linux/sed-opal.h
index bd29fab60ef4..e204b1f8e8b8 100644
--- a/include/uapi/linux/sed-opal.h
+++ b/include/uapi/linux/sed-opal.h
@@ -106,6 +106,13 @@ struct opal_mbr_done {
 	__u8 __align[7];
 };
 
+struct opal_shadow_mbr {
+	struct opal_key key;
+	const __u64 data;
+	__u64 offset;
+	__u64 size;
+};
+
 #define IOC_OPAL_SAVE		    _IOW('p', 220, struct opal_lock_unlock)
 #define IOC_OPAL_LOCK_UNLOCK	    _IOW('p', 221, struct opal_lock_unlock)
 #define IOC_OPAL_TAKE_OWNERSHIP	    _IOW('p', 222, struct opal_key)
@@ -119,5 +126,6 @@ struct opal_mbr_done {
 #define IOC_OPAL_ERASE_LR           _IOW('p', 230, struct opal_session_info)
 #define IOC_OPAL_SECURE_ERASE_LR    _IOW('p', 231, struct opal_session_info)
 #define IOC_OPAL_MBR_DONE           _IOW('p', 232, struct opal_mbr_done)
+#define IOC_OPAL_WRITE_SHADOW_MBR   _IOW('p', 233, struct opal_shadow_mbr)
 
 #endif /* _UAPI_SED_OPAL_H */
-- 
2.20.1

