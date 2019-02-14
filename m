Return-Path: <SRS0=Oz1R=QV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11151C10F00
	for <linux-block@archiver.kernel.org>; Thu, 14 Feb 2019 00:17:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D38CB21920
	for <linux-block@archiver.kernel.org>; Thu, 14 Feb 2019 00:17:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fjfi.cvut.cz header.i=@fjfi.cvut.cz header.b="pPTBW83+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393621AbfBNARU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Feb 2019 19:17:20 -0500
Received: from mailgw1.fjfi.cvut.cz ([147.32.9.3]:47730 "EHLO
        mailgw1.fjfi.cvut.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393553AbfBNART (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Feb 2019 19:17:19 -0500
Received: from localhost (localhost [127.0.0.1])
        by mailgw1.fjfi.cvut.cz (Postfix) with ESMTP id 5CB63AA296;
        Thu, 14 Feb 2019 01:17:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fjfi.cvut.cz;
        s=20151024; t=1550103435; i=@fjfi.cvut.cz;
        bh=dpiqLyAophuh2bVRHti5Jn/xzPgbDMv/fyh/bRvlGU8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=pPTBW83+cIhwiGzYMEFhkm+vG8HnQJeV1GvqAY8tK+cte7LkwNSO1dbOHUlufnSx0
         whm4L4eSgHCTnGFC4OCHiLCiDCVD0ff9fiT9nf0IWl0yGH5hfayk4EAKK2T7/XVtFU
         3rkHECrwSQ0PptPOAPWyD+/68W4vLhfeBvCKMbP4=
X-CTU-FNSPE-Virus-Scanned: amavisd-new at fjfi.cvut.cz
Received: from mailgw1.fjfi.cvut.cz ([127.0.0.1])
        by localhost (mailgw1.fjfi.cvut.cz [127.0.0.1]) (amavisd-new, port 10022)
        with ESMTP id O83iY_czLD6G; Thu, 14 Feb 2019 01:17:06 +0100 (CET)
Received: from linux.fjfi.cvut.cz (linux.fjfi.cvut.cz [147.32.5.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailgw1.fjfi.cvut.cz (Postfix) with ESMTPS id 00CF8AA291;
        Thu, 14 Feb 2019 01:17:04 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailgw1.fjfi.cvut.cz 00CF8AA291
Received: by linux.fjfi.cvut.cz (Postfix, from userid 1001)
        id C6D156004F; Thu, 14 Feb 2019 01:17:03 +0100 (CET)
From:   David Kozub <zub@linux.fjfi.cvut.cz>
To:     Jens Axboe <axboe@kernel.dk>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        Scott Bauer <sbauer@plzdonthack.me>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>,
        David Kozub <zub@linux.fjfi.cvut.cz>
Subject: [PATCH 13/16] block: sed-opal: use named Opal tokens instead of integer literals
Date:   Thu, 14 Feb 2019 01:16:05 +0100
Message-Id: <1550103368-4605-14-git-send-email-zub@linux.fjfi.cvut.cz>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1550103368-4605-1-git-send-email-zub@linux.fjfi.cvut.cz>
References: <1550103368-4605-1-git-send-email-zub@linux.fjfi.cvut.cz>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Replace integer literals by Opal tokens defined in opal_proto.h where
possible.

Signed-off-by: David Kozub <zub@linux.fjfi.cvut.cz>
---
 block/sed-opal.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/block/sed-opal.c b/block/sed-opal.c
index 5395ab1c5248..be0d633783c8 100644
--- a/block/sed-opal.c
+++ b/block/sed-opal.c
@@ -1180,12 +1180,12 @@ static int generic_lr_enable_disable(struct opal_dev *dev,
 	add_token_u8(&err, dev, OPAL_STARTLIST);
 
 	add_token_u8(&err, dev, OPAL_STARTNAME);
-	add_token_u8(&err, dev, 5); /* ReadLockEnabled */
+	add_token_u8(&err, dev, OPAL_READLOCKENABLED);
 	add_token_u8(&err, dev, rle);
 	add_token_u8(&err, dev, OPAL_ENDNAME);
 
 	add_token_u8(&err, dev, OPAL_STARTNAME);
-	add_token_u8(&err, dev, 6); /* WriteLockEnabled */
+	add_token_u8(&err, dev, OPAL_WRITELOCKENABLED);
 	add_token_u8(&err, dev, wle);
 	add_token_u8(&err, dev, OPAL_ENDNAME);
 
@@ -1238,22 +1238,22 @@ static int setup_locking_range(struct opal_dev *dev, void *data)
 		add_token_u8(&err, dev, OPAL_STARTLIST);
 
 		add_token_u8(&err, dev, OPAL_STARTNAME);
-		add_token_u8(&err, dev, 3); /* Ranges Start */
+		add_token_u8(&err, dev, OPAL_RANGESTART);
 		add_token_u64(&err, dev, setup->range_start);
 		add_token_u8(&err, dev, OPAL_ENDNAME);
 
 		add_token_u8(&err, dev, OPAL_STARTNAME);
-		add_token_u8(&err, dev, 4); /* Ranges length */
+		add_token_u8(&err, dev, OPAL_RANGELENGTH);
 		add_token_u64(&err, dev, setup->range_length);
 		add_token_u8(&err, dev, OPAL_ENDNAME);
 
 		add_token_u8(&err, dev, OPAL_STARTNAME);
-		add_token_u8(&err, dev, 5); /*ReadLockEnabled */
+		add_token_u8(&err, dev, OPAL_READLOCKENABLED);
 		add_token_u64(&err, dev, !!setup->RLE);
 		add_token_u8(&err, dev, OPAL_ENDNAME);
 
 		add_token_u8(&err, dev, OPAL_STARTNAME);
-		add_token_u8(&err, dev, 6); /*WriteLockEnabled*/
+		add_token_u8(&err, dev, OPAL_WRITELOCKENABLED);
 		add_token_u64(&err, dev, !!setup->WLE);
 		add_token_u8(&err, dev, OPAL_ENDNAME);
 
@@ -1472,7 +1472,7 @@ static int set_mbr_done(struct opal_dev *dev, void *data)
 	add_token_u8(&err, dev, OPAL_VALUES);
 	add_token_u8(&err, dev, OPAL_STARTLIST);
 	add_token_u8(&err, dev, OPAL_STARTNAME);
-	add_token_u8(&err, dev, 2); /* Done */
+	add_token_u8(&err, dev, OPAL_MBRDONE);
 	add_token_u8(&err, dev, *mbr_done_tf); /* Done T or F */
 	add_token_u8(&err, dev, OPAL_ENDNAME);
 	add_token_u8(&err, dev, OPAL_ENDLIST);
@@ -1498,7 +1498,7 @@ static int set_mbr_enable_disable(struct opal_dev *dev, void *data)
 	add_token_u8(&err, dev, OPAL_VALUES);
 	add_token_u8(&err, dev, OPAL_STARTLIST);
 	add_token_u8(&err, dev, OPAL_STARTNAME);
-	add_token_u8(&err, dev, 1);
+	add_token_u8(&err, dev, OPAL_MBRENABLE);
 	add_token_u8(&err, dev, *mbr_en_dis);
 	add_token_u8(&err, dev, OPAL_ENDNAME);
 	add_token_u8(&err, dev, OPAL_ENDLIST);
@@ -1523,7 +1523,7 @@ static int generic_pw_cmd(u8 *key, size_t key_len, u8 *cpin_uid,
 	add_token_u8(&err, dev, OPAL_VALUES);
 	add_token_u8(&err, dev, OPAL_STARTLIST);
 	add_token_u8(&err, dev, OPAL_STARTNAME);
-	add_token_u8(&err, dev, 3); /* PIN */
+	add_token_u8(&err, dev, OPAL_PIN);
 	add_token_bytestring(&err, dev, key, key_len);
 	add_token_u8(&err, dev, OPAL_ENDNAME);
 	add_token_u8(&err, dev, OPAL_ENDLIST);
-- 
2.20.1

