Return-Path: <SRS0=7Bp6=PY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DATE_IN_PAST_96_XX,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDE33C43387
	for <linux-block@archiver.kernel.org>; Wed, 16 Jan 2019 23:03:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3A3B20840
	for <linux-block@archiver.kernel.org>; Wed, 16 Jan 2019 23:03:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727245AbfAPXDy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Jan 2019 18:03:54 -0500
Received: from mailgw1.fjfi.cvut.cz ([147.32.9.3]:45656 "EHLO
        mailgw1.fjfi.cvut.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbfAPXDx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Jan 2019 18:03:53 -0500
Received: from localhost (localhost [127.0.0.1])
        by mailgw1.fjfi.cvut.cz (Postfix) with ESMTP id 9FDEBAE1CB;
        Wed, 16 Jan 2019 23:55:58 +0100 (CET)
X-CTU-FNSPE-Virus-Scanned: amavisd-new at fjfi.cvut.cz
Received: from mailgw1.fjfi.cvut.cz ([127.0.0.1])
        by localhost (mailgw1.fjfi.cvut.cz [127.0.0.1]) (amavisd-new, port 10022)
        with ESMTP id Axleq1gCdoIk; Wed, 16 Jan 2019 23:55:51 +0100 (CET)
Received: from linux.fjfi.cvut.cz (linux.fjfi.cvut.cz [147.32.5.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailgw1.fjfi.cvut.cz (Postfix) with ESMTPS id 2048CB0435;
        Wed, 16 Jan 2019 23:55:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailgw1.fjfi.cvut.cz 2048CB0435
Received: by linux.fjfi.cvut.cz (Postfix, from userid 1001)
        id E5E1D6004E; Wed, 16 Jan 2019 23:55:47 +0100 (CET)
From:   Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Date:   Mon, 19 Mar 2018 19:36:52 +0100
Subject: [PATCH 13/16] block: sed-opal: check size of shadow mbr
To:     Jens Axboe <axboe@kernel.dk>, Scott Bauer <scott.bauer@intel.com>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Message-Id: <20190116225547.E5E1D6004E@linux.fjfi.cvut.cz>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

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

