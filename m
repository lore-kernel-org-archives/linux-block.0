Return-Path: <SRS0=2amJ=TA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC141C04AA8
	for <linux-block@archiver.kernel.org>; Tue, 30 Apr 2019 23:31:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B7C5217D4
	for <linux-block@archiver.kernel.org>; Tue, 30 Apr 2019 23:31:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fjfi.cvut.cz header.i=@fjfi.cvut.cz header.b="DxOHSarE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726086AbfD3Xa7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Apr 2019 19:30:59 -0400
Received: from mailgw2.fjfi.cvut.cz ([147.32.9.131]:59488 "EHLO
        mailgw2.fjfi.cvut.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726412AbfD3Xa6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Apr 2019 19:30:58 -0400
Received: from localhost (localhost [127.0.0.1])
        by mailgw2.fjfi.cvut.cz (Postfix) with ESMTP id 059E8A022D;
        Wed,  1 May 2019 01:21:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fjfi.cvut.cz;
        s=20151024; t=1556666471; i=@fjfi.cvut.cz;
        bh=jpNFd3cEl9rt88T8uD0VgyCxWvsA+VMlhWgH2FK84n0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=DxOHSarED2aSd6G7DXLOetKundFejVe23sOot7aUTTfUcDlWZr4GaRN4LPu/FVIXk
         o58OXxC677Uy+TMxVGYNViQJ4YJKfwCs7l+/5zHIaZXHPCJY3ZEcJHSqwOFk4DhY+J
         Nc0xtgpzgtS4IWErZdhdSQEtgP8S8DPlo6obBYOw=
X-CTU-FNSPE-Virus-Scanned: amavisd-new at fjfi.cvut.cz
Received: from mailgw2.fjfi.cvut.cz ([127.0.0.1])
        by localhost (mailgw2.fjfi.cvut.cz [127.0.0.1]) (amavisd-new, port 10022)
        with ESMTP id CEJRMcjzKhjy; Wed,  1 May 2019 01:21:00 +0200 (CEST)
Received: from linux.fjfi.cvut.cz (linux.fjfi.cvut.cz [147.32.5.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailgw2.fjfi.cvut.cz (Postfix) with ESMTPS id BB2FCA02B0;
        Wed,  1 May 2019 01:20:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailgw2.fjfi.cvut.cz BB2FCA02B0
Received: by linux.fjfi.cvut.cz (Postfix, from userid 1001)
        id 7541A6004E; Wed,  1 May 2019 01:20:59 +0200 (CEST)
From:   David Kozub <zub@linux.fjfi.cvut.cz>
To:     Jens Axboe <axboe@kernel.dk>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        Scott Bauer <sbauer@plzdonthack.me>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Subject: [PATCH 2/3] block: sed-opal: ioctl for writing to shadow mbr
Date:   Wed,  1 May 2019 01:20:58 +0200
Message-Id: <1556666459-17948-3-git-send-email-zub@linux.fjfi.cvut.cz>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1556666459-17948-1-git-send-email-zub@linux.fjfi.cvut.cz>
References: <1556666459-17948-1-git-send-email-zub@linux.fjfi.cvut.cz>
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
 block/sed-opal.c              | 94 ++++++++++++++++++++++++++++++++++-
 include/linux/sed-opal.h      |  1 +
 include/uapi/linux/sed-opal.h |  8 +++
 3 files changed, 101 insertions(+), 2 deletions(-)

diff --git a/block/sed-opal.c b/block/sed-opal.c
index f1eb9c18e335..5acb873e9037 100644
--- a/block/sed-opal.c
+++ b/block/sed-opal.c
@@ -34,6 +34,9 @@
 #define IO_BUFFER_LENGTH 2048
 #define MAX_TOKS 64
 
+/* Number of bytes needed by cmd_finalize. */
+#define CMD_FINALIZE_BYTES_NEEDED 7
+
 struct opal_step {
 	int (*fn)(struct opal_dev *dev, void *data);
 	void *data;
@@ -531,12 +534,17 @@ static int opal_discovery0_step(struct opal_dev *dev)
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
@@ -682,7 +690,11 @@ static int cmd_finalize(struct opal_dev *cmd, u32 hsn, u32 tsn)
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
@@ -1533,6 +1545,58 @@ static int set_mbr_enable_disable(struct opal_dev *dev, void *data)
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
@@ -2010,6 +2074,29 @@ static int opal_set_mbr_done(struct opal_dev *dev,
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
+	if (!access_ok((void __user *)(uintptr_t)info->data, info->size))
+		return -EFAULT;
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
@@ -2326,6 +2413,9 @@ int sed_ioctl(struct opal_dev *dev, unsigned int cmd, void __user *arg)
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
index 42b2ce5da7b3..fb5bf6138a98 100644
--- a/include/linux/sed-opal.h
+++ b/include/linux/sed-opal.h
@@ -48,6 +48,7 @@ static inline bool is_sed_ioctl(unsigned int cmd)
 	case IOC_OPAL_ERASE_LR:
 	case IOC_OPAL_SECURE_ERASE_LR:
 	case IOC_OPAL_MBR_DONE:
+	case IOC_OPAL_WRITE_SHADOW_MBR:
 		return true;
 	}
 	return false;
diff --git a/include/uapi/linux/sed-opal.h b/include/uapi/linux/sed-opal.h
index 81dd0e8886a1..9c83785f0a2a 100644
--- a/include/uapi/linux/sed-opal.h
+++ b/include/uapi/linux/sed-opal.h
@@ -115,6 +115,13 @@ struct opal_mbr_done {
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
@@ -128,5 +135,6 @@ struct opal_mbr_done {
 #define IOC_OPAL_ERASE_LR           _IOW('p', 230, struct opal_session_info)
 #define IOC_OPAL_SECURE_ERASE_LR    _IOW('p', 231, struct opal_session_info)
 #define IOC_OPAL_MBR_DONE           _IOW('p', 232, struct opal_mbr_done)
+#define IOC_OPAL_WRITE_SHADOW_MBR   _IOW('p', 233, struct opal_shadow_mbr)
 
 #endif /* _UAPI_SED_OPAL_H */
-- 
2.20.1

