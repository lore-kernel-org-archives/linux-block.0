Return-Path: <SRS0=sC6v=PZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BDE3C43387
	for <linux-block@archiver.kernel.org>; Thu, 17 Jan 2019 21:34:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC73320859
	for <linux-block@archiver.kernel.org>; Thu, 17 Jan 2019 21:34:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fjfi.cvut.cz header.i=@fjfi.cvut.cz header.b="fM6jo/AM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729833AbfAQVdi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Jan 2019 16:33:38 -0500
Received: from mailgw1.fjfi.cvut.cz ([147.32.9.3]:35732 "EHLO
        mailgw1.fjfi.cvut.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729789AbfAQVdi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Jan 2019 16:33:38 -0500
Received: from localhost (localhost [127.0.0.1])
        by mailgw1.fjfi.cvut.cz (Postfix) with ESMTP id 65016A399F;
        Thu, 17 Jan 2019 22:33:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fjfi.cvut.cz;
        s=20151024; t=1547760815; i=@fjfi.cvut.cz;
        bh=D/5hwMyHQziEDtLKBLPdLZStwrox+oFJWQz+xrdz8/A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=fM6jo/AMA/BgfZew/XXvhObty0Bw1XhNiJHb81S7I79P0sL+shhkkDkyPDNy6COsC
         JKhkwhcVw18t4CU3Hbznx6oDf/gXytosb5HI6erL0IRZijYeO6bfmN1kPuhP2OEORS
         5vvq/y2JNMqipI113BR1ToMVkOs2/Qxj/3eQ8WXs=
X-CTU-FNSPE-Virus-Scanned: amavisd-new at fjfi.cvut.cz
Received: from mailgw1.fjfi.cvut.cz ([127.0.0.1])
        by localhost (mailgw1.fjfi.cvut.cz [127.0.0.1]) (amavisd-new, port 10022)
        with ESMTP id Vpb3gtORi7rl; Thu, 17 Jan 2019 22:33:28 +0100 (CET)
Received: from linux.fjfi.cvut.cz (linux.fjfi.cvut.cz [147.32.5.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailgw1.fjfi.cvut.cz (Postfix) with ESMTPS id C212DA398C;
        Thu, 17 Jan 2019 22:33:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailgw1.fjfi.cvut.cz C212DA398C
Received: by linux.fjfi.cvut.cz (Postfix, from userid 1001)
        id 9C0266004E; Thu, 17 Jan 2019 22:33:13 +0100 (CET)
From:   David Kozub <zub@linux.fjfi.cvut.cz>
To:     Jens Axboe <axboe@kernel.dk>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Subject: [PATCH v2 13/16] block: sed-opal: check size of shadow mbr
Date:   Thu, 17 Jan 2019 22:31:53 +0100
Message-Id: <1547760716-7304-14-git-send-email-zub@linux.fjfi.cvut.cz>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1547760716-7304-1-git-send-email-zub@linux.fjfi.cvut.cz>
References: <1547760716-7304-1-git-send-email-zub@linux.fjfi.cvut.cz>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>

Check whether the shadow mbr does fit in the provided space on the
target. Also a proper firmware should handle this case and return an
error we may prevent problems or even damage with crappy firmwares.

Signed-off-by: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
---
 block/opal_proto.h | 16 ++++++++++++++++
 block/sed-opal.c   | 39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+)

diff --git a/block/opal_proto.h b/block/opal_proto.h
index b6e352cfe982..5e8df3245eb0 100644
--- a/block/opal_proto.h
+++ b/block/opal_proto.h
@@ -106,6 +106,7 @@ enum opal_uid {
 	OPAL_ENTERPRISE_BANDMASTER0_UID,
 	OPAL_ENTERPRISE_ERASEMASTER_UID,
 	/* tables */
+	OPAL_TABLE_TABLE,
 	OPAL_LOCKINGRANGE_GLOBAL,
 	OPAL_LOCKINGRANGE_ACE_RDLOCKED,
 	OPAL_LOCKINGRANGE_ACE_WRLOCKED,
@@ -160,6 +161,21 @@ enum opal_token {
 	OPAL_STARTCOLUMN = 0x03,
 	OPAL_ENDCOLUMN = 0x04,
 	OPAL_VALUES = 0x01,
+	/* table table */
+	OPAL_TABLE_UID = 0x00,
+	OPAL_TABLE_NAME = 0x01,
+	OPAL_TABLE_COMMON = 0x02,
+	OPAL_TABLE_TEMPLATE = 0x03,
+	OPAL_TABLE_KIND = 0x04,
+	OPAL_TABLE_COLUMN = 0x05,
+	OPAL_TABLE_COLUMNS = 0x06,
+	OPAL_TABLE_ROWS = 0x07,
+	OPAL_TABLE_ROWS_FREE = 0x08,
+	OPAL_TABLE_ROW_BYTES = 0x09,
+	OPAL_TABLE_LASTID = 0x0A,
+	OPAL_TABLE_MIN = 0x0B,
+	OPAL_TABLE_MAX = 0x0C,
+
 	/* authority table */
 	OPAL_PIN = 0x03,
 	/* locking tokens */
diff --git a/block/sed-opal.c b/block/sed-opal.c
index 034cb940b34a..ad52091531f2 100644
--- a/block/sed-opal.c
+++ b/block/sed-opal.c
@@ -139,6 +139,8 @@ static const u8 opaluid[][OPAL_UID_LENGTH] = {
 
 	/* tables */
 
+	[OPAL_TABLE_TABLE]
+		{ 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x01 },
 	[OPAL_LOCKINGRANGE_GLOBAL] =
 		{ 0x00, 0x00, 0x08, 0x02, 0x00, 0x00, 0x00, 0x01 },
 	[OPAL_LOCKINGRANGE_ACE_RDLOCKED] =
@@ -1120,6 +1122,29 @@ static int generic_get_column(struct opal_dev *dev, const u8 *table,
 	return finalize_and_send(dev, parse_and_check_status);
 }
 
+/*
+ * see TCG SAS 5.3.2.3 for a description of the available columns
+ *
+ * the result is provided in dev->resp->tok[4]
+ */
+static int generic_get_table_info(struct opal_dev *dev, enum opal_uid table,
+				  u64 column)
+{
+	u8 uid[OPAL_UID_LENGTH];
+	const unsigned int half = OPAL_UID_LENGTH/2;
+
+	/* sed-opal UIDs can be split in two halves:
+	 *  first:  actual table index
+	 *  second: relative index in the table
+	 * so we have to get the first half of the OPAL_TABLE_TABLE and use the
+	 * first part of the target table as relative index into that table
+	 */
+	memcpy(uid, opaluid[OPAL_TABLE_TABLE], half);
+	memcpy(uid+half, opaluid[table], half);
+
+	return generic_get_column(dev, uid, column);
+}
+
 static int gen_key(struct opal_dev *dev, void *data)
 {
 	u8 uid[OPAL_UID_LENGTH];
@@ -1535,6 +1560,20 @@ static int write_shadow_mbr(struct opal_dev *dev, void *data)
 	u64 len;
 	int err = 0;
 
+	/* do we fit in the available shadow mbr space? */
+	err = generic_get_table_info(dev, OPAL_MBR, OPAL_TABLE_ROWS);
+	if (err) {
+		pr_debug("MBR: could not get shadow size\n");
+		return err;
+	}
+
+	len = response_get_u64(&dev->parsed, 4);
+	if (shadow->offset + shadow->size > len) {
+		pr_debug("MBR: does not fit in shadow (%llu vs. %llu)\n",
+			 shadow->offset + shadow->size, len);
+		return -ENOSPC;
+	}
+
 	/* do the actual transmission(s) */
 	src = (u8 *) shadow->data;
 	while (off < shadow->size) {
-- 
2.20.1

