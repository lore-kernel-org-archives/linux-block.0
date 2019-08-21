Return-Path: <SRS0=wMiD=WR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 865E5C3A5A0
	for <linux-block@archiver.kernel.org>; Wed, 21 Aug 2019 19:09:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54F0D22DD3
	for <linux-block@archiver.kernel.org>; Wed, 21 Aug 2019 19:09:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728984AbfHUTJG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Aug 2019 15:09:06 -0400
Received: from mga14.intel.com ([192.55.52.115]:63958 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727685AbfHUTJG (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Aug 2019 15:09:06 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Aug 2019 12:09:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,412,1559545200"; 
   d="scan'208";a="169519739"
Received: from unknown (HELO revanth-X299-AORUS-Gaming-3-Pro.lm.intel.com) ([10.232.116.91])
  by orsmga007.jf.intel.com with ESMTP; 21 Aug 2019 12:09:04 -0700
From:   Revanth Rajashekar <revanth.rajashekar@intel.com>
To:     <linux-block@vger.kernel.org>
Cc:     Jonathan Derrick <jonathan.derrick@intel.com>,
        Scott Bauer <sbauer@plzdonthack.me>,
        Revanth Rajashekar <revanth.rajashekar@intel.com>
Subject: [PATCH 2/3] block: sed-opal: Generalizing write data to any opal table
Date:   Wed, 21 Aug 2019 13:10:50 -0600
Message-Id: <20190821191051.3535-3-revanth.rajashekar@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190821191051.3535-1-revanth.rajashekar@intel.com>
References: <20190821191051.3535-1-revanth.rajashekar@intel.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch refactors the existing "write_shadowmbr" func and
creates a new generalized function "generic_table_write_data",
to write data to any opal table

Signed-off-by: Revanth Rajashekar <revanth.rajashekar@intel.com>
---
 block/sed-opal.c | 138 +++++++++++++++++++++++++----------------------
 1 file changed, 74 insertions(+), 64 deletions(-)

diff --git a/block/sed-opal.c b/block/sed-opal.c
index f04b83eae407..7179582730b6 100644
--- a/block/sed-opal.c
+++ b/block/sed-opal.c
@@ -1068,11 +1068,11 @@ static int generic_get_column(struct opal_dev *dev, const u8 *table,
  *
  * the result is provided in dev->resp->tok[4]
  */
-static int generic_get_table_info(struct opal_dev *dev, enum opal_uid table,
+static int generic_get_table_info(struct opal_dev *dev, const u8 *table_uid,
 				  u64 column)
 {
 	u8 uid[OPAL_UID_LENGTH];
-	const unsigned int half = OPAL_UID_LENGTH/2;
+	const unsigned int half = OPAL_UID_LENGTH_HALF;

 	/* sed-opal UIDs can be split in two halves:
 	 *  first:  actual table index
@@ -1081,7 +1081,7 @@ static int generic_get_table_info(struct opal_dev *dev, enum opal_uid table,
 	 * first part of the target table as relative index into that table
 	 */
 	memcpy(uid, opaluid[OPAL_TABLE_TABLE], half);
-	memcpy(uid+half, opaluid[table], half);
+	memcpy(uid + half, table_uid, half);

 	return generic_get_column(dev, uid, column);
 }
@@ -1150,6 +1150,75 @@ static int get_active_key(struct opal_dev *dev, void *data)
 	return get_active_key_cont(dev);
 }

+static int generic_table_write_data(struct opal_dev *dev, const u64 data, u64 offset,
+				    u64 size, const u8 *uid)
+{
+	const u8 __user *src;
+	u8 *dst;
+	u64 len;
+	size_t off = 0;
+	int err = 0;
+
+	/* do we fit in the available space? */
+	err = generic_get_table_info(dev, uid, OPAL_TABLE_ROWS);
+	if (err) {
+		pr_debug("Couldn't get the table size\n");
+		return err;
+	}
+
+	len = response_get_u64(&dev->parsed, 4);
+	if (size > len || offset > len - size) {
+		pr_debug("Does not fit in the table (%llu vs. %llu)\n",
+			  offset + size, len);
+		return -ENOSPC;
+	}
+
+	/* do the actual transmission(s) */
+	src = (u8 __user *)(uintptr_t)data;
+	while (off < size) {
+		err = cmd_start(dev, uid, opalmethod[OPAL_SET]);
+		add_token_u8(&err, dev, OPAL_STARTNAME);
+		add_token_u8(&err, dev, OPAL_WHERE);
+		add_token_u64(&err, dev, offset + off);
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
+			  (size_t)(size - off));
+		pr_debug("Write bytes %zu+%llu/%llu\n",
+			  off, len, size);
+
+		dst = add_bytestring_header(&err, dev, len);
+		if (!dst)
+			break;
+
+		if (copy_from_user(dst, src + off, len))
+			err = -EFAULT;
+
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
+
+	return err;
+}
+
 static int generic_lr_enable_disable(struct opal_dev *dev,
 				     u8 *uid, bool rle, bool wle,
 				     bool rl, bool wl)
@@ -1512,68 +1581,9 @@ static int set_mbr_enable_disable(struct opal_dev *dev, void *data)
 static int write_shadow_mbr(struct opal_dev *dev, void *data)
 {
 	struct opal_shadow_mbr *shadow = data;
-	const u8 __user *src;
-	u8 *dst;
-	size_t off = 0;
-	u64 len;
-	int err = 0;
-
-	/* do we fit in the available shadow mbr space? */
-	err = generic_get_table_info(dev, OPAL_MBR, OPAL_TABLE_ROWS);
-	if (err) {
-		pr_debug("MBR: could not get shadow size\n");
-		return err;
-	}
-
-	len = response_get_u64(&dev->parsed, 4);
-	if (shadow->size > len || shadow->offset > len - shadow->size) {
-		pr_debug("MBR: does not fit in shadow (%llu vs. %llu)\n",
-			 shadow->offset + shadow->size, len);
-		return -ENOSPC;
-	}

-	/* do the actual transmission(s) */
-	src = (u8 __user *)(uintptr_t)shadow->data;
-	while (off < shadow->size) {
-		err = cmd_start(dev, opaluid[OPAL_MBR], opalmethod[OPAL_SET]);
-		add_token_u8(&err, dev, OPAL_STARTNAME);
-		add_token_u8(&err, dev, OPAL_WHERE);
-		add_token_u64(&err, dev, shadow->offset + off);
-		add_token_u8(&err, dev, OPAL_ENDNAME);
-
-		add_token_u8(&err, dev, OPAL_STARTNAME);
-		add_token_u8(&err, dev, OPAL_VALUES);
-
-		/*
-		 * The bytestring header is either 1 or 2 bytes, so assume 2.
-		 * There also needs to be enough space to accommodate the
-		 * trailing OPAL_ENDNAME (1 byte) and tokens added by
-		 * cmd_finalize.
-		 */
-		len = min(remaining_size(dev) - (2+1+CMD_FINALIZE_BYTES_NEEDED),
-			  (size_t)(shadow->size - off));
-		pr_debug("MBR: write bytes %zu+%llu/%llu\n",
-			 off, len, shadow->size);
-
-		dst = add_bytestring_header(&err, dev, len);
-		if (!dst)
-			break;
-		if (copy_from_user(dst, src + off, len))
-			err = -EFAULT;
-		dev->pos += len;
-
-		add_token_u8(&err, dev, OPAL_ENDNAME);
-		if (err)
-			break;
-
-		err = finalize_and_send(dev, parse_and_check_status);
-		if (err)
-			break;
-
-		off += len;
-	}
-
-	return err;
+	return generic_table_write_data(dev, shadow->data, shadow->offset,
+					shadow->size, opaluid[OPAL_MBR]);
 }

 static int generic_pw_cmd(u8 *key, size_t key_len, u8 *cpin_uid,
--
2.17.1

