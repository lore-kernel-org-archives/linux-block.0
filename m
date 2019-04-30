Return-Path: <SRS0=2amJ=TA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04A90C43219
	for <linux-block@archiver.kernel.org>; Tue, 30 Apr 2019 23:31:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7F142087B
	for <linux-block@archiver.kernel.org>; Tue, 30 Apr 2019 23:31:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fjfi.cvut.cz header.i=@fjfi.cvut.cz header.b="XeYbulpF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbfD3XbB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Apr 2019 19:31:01 -0400
Received: from mailgw2.fjfi.cvut.cz ([147.32.9.131]:59486 "EHLO
        mailgw2.fjfi.cvut.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726559AbfD3Xa7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Apr 2019 19:30:59 -0400
Received: from localhost (localhost [127.0.0.1])
        by mailgw2.fjfi.cvut.cz (Postfix) with ESMTP id 01D7AA02AE;
        Wed,  1 May 2019 01:21:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fjfi.cvut.cz;
        s=20151024; t=1556666467; i=@fjfi.cvut.cz;
        bh=z950GQ09xqDj1VQ8RNlQ970vQnKiBdyxx8mQuvYI/WE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=XeYbulpF02/B+BotL1jrRAAWR2oWx9UOG1q6wYhoGQ435DWqxyd+7GDvgNj/C4aLd
         lLSHAenFeR7nMVm8kJol6dMCDq5pb07QSB/6jh7+wW6LdZNr0RIGUsyX0KCWve/WBq
         s2SXQ62BEyH7MQClFUS3uYl9wNpI++sIDqOkZ/aI=
X-CTU-FNSPE-Virus-Scanned: amavisd-new at fjfi.cvut.cz
Received: from mailgw2.fjfi.cvut.cz ([127.0.0.1])
        by localhost (mailgw2.fjfi.cvut.cz [127.0.0.1]) (amavisd-new, port 10022)
        with ESMTP id M9myyxcmA_3j; Wed,  1 May 2019 01:21:00 +0200 (CEST)
Received: from linux.fjfi.cvut.cz (linux.fjfi.cvut.cz [147.32.5.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailgw2.fjfi.cvut.cz (Postfix) with ESMTPS id E5AABA02B8;
        Wed,  1 May 2019 01:20:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailgw2.fjfi.cvut.cz E5AABA02B8
Received: by linux.fjfi.cvut.cz (Postfix, from userid 1001)
        id A66A360050; Wed,  1 May 2019 01:20:59 +0200 (CEST)
From:   David Kozub <zub@linux.fjfi.cvut.cz>
To:     Jens Axboe <axboe@kernel.dk>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        Scott Bauer <sbauer@plzdonthack.me>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Subject: [PATCH 3/3] block: sed-opal: check size of shadow mbr
Date:   Wed,  1 May 2019 01:20:59 +0200
Message-Id: <1556666459-17948-4-git-send-email-zub@linux.fjfi.cvut.cz>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1556666459-17948-1-git-send-email-zub@linux.fjfi.cvut.cz>
References: <1556666459-17948-1-git-send-email-zub@linux.fjfi.cvut.cz>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>

Check whether the shadow mbr does fit in the provided space on the
target. Also a proper firmware should handle this case and return an
error we may prevent problems or even damage with crappy firmwares.

Signed-off-by: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Signed-off-by: David Kozub <zub@linux.fjfi.cvut.cz>
Reviewed-by: Scott Bauer <sbauer@plzdonthack.me>
Reviewed-by: Jon Derrick <jonathan.derrick@intel.com>
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
index 5acb873e9037..39e3eecca58d 100644
--- a/block/sed-opal.c
+++ b/block/sed-opal.c
@@ -138,6 +138,8 @@ static const u8 opaluid[][OPAL_UID_LENGTH] = {
 
 	/* tables */
 
+	[OPAL_TABLE_TABLE]
+		{ 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x01 },
 	[OPAL_LOCKINGRANGE_GLOBAL] =
 		{ 0x00, 0x00, 0x08, 0x02, 0x00, 0x00, 0x00, 0x01 },
 	[OPAL_LOCKINGRANGE_ACE_RDLOCKED] =
@@ -1139,6 +1141,29 @@ static int generic_get_column(struct opal_dev *dev, const u8 *table,
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
@@ -1554,6 +1579,20 @@ static int write_shadow_mbr(struct opal_dev *dev, void *data)
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
+	if (shadow->size > len || shadow->offset > len - shadow->size) {
+		pr_debug("MBR: does not fit in shadow (%llu vs. %llu)\n",
+			 shadow->offset + shadow->size, len);
+		return -ENOSPC;
+	}
+
 	/* do the actual transmission(s) */
 	src = (u8 __user *)(uintptr_t)shadow->data;
 	while (off < shadow->size) {
-- 
2.20.1

