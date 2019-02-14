Return-Path: <SRS0=Oz1R=QV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1BE3C43381
	for <linux-block@archiver.kernel.org>; Thu, 14 Feb 2019 00:16:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A34F12146E
	for <linux-block@archiver.kernel.org>; Thu, 14 Feb 2019 00:16:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fjfi.cvut.cz header.i=@fjfi.cvut.cz header.b="Zjb6hNty"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404623AbfBNAQl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Feb 2019 19:16:41 -0500
Received: from mailgw1.fjfi.cvut.cz ([147.32.9.3]:47178 "EHLO
        mailgw1.fjfi.cvut.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbfBNAQl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Feb 2019 19:16:41 -0500
Received: from localhost (localhost [127.0.0.1])
        by mailgw1.fjfi.cvut.cz (Postfix) with ESMTP id BAF2BAA230;
        Thu, 14 Feb 2019 01:16:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fjfi.cvut.cz;
        s=20151024; t=1550103397; i=@fjfi.cvut.cz;
        bh=zhyW1qjEm7GKf1p0kEpQjvfSBMsodQlUnddUok6KFLA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Zjb6hNtyBR3v4NGGMxM+hMeCjPQxrKx2ZUKo2cJicVZ2x0bVaGuGd7SNuiJar8MkE
         G9iAR4E/9j+Gu85SeHWpzjBCp0DnTmiz8fE/b2QdrTggJGSd4+RjJ59m8gcyfzv3nW
         s2Za9kpABAWC3cmZIW/3WHvX5KG5734lzKLE5T4I=
X-CTU-FNSPE-Virus-Scanned: amavisd-new at fjfi.cvut.cz
Received: from mailgw1.fjfi.cvut.cz ([127.0.0.1])
        by localhost (mailgw1.fjfi.cvut.cz [127.0.0.1]) (amavisd-new, port 10022)
        with ESMTP id vL2cAQ5wNTrP; Thu, 14 Feb 2019 01:16:33 +0100 (CET)
Received: from linux.fjfi.cvut.cz (linux.fjfi.cvut.cz [147.32.5.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailgw1.fjfi.cvut.cz (Postfix) with ESMTPS id EEA59AA26F;
        Thu, 14 Feb 2019 01:16:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailgw1.fjfi.cvut.cz EEA59AA26F
Received: by linux.fjfi.cvut.cz (Postfix, from userid 1001)
        id D092A6004E; Thu, 14 Feb 2019 01:16:32 +0100 (CET)
From:   David Kozub <zub@linux.fjfi.cvut.cz>
To:     Jens Axboe <axboe@kernel.dk>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        Scott Bauer <sbauer@plzdonthack.me>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>,
        David Kozub <zub@linux.fjfi.cvut.cz>
Subject: [PATCH 01/16] block: sed-opal: fix IOC_OPAL_ENABLE_DISABLE_MBR
Date:   Thu, 14 Feb 2019 01:15:53 +0100
Message-Id: <1550103368-4605-2-git-send-email-zub@linux.fjfi.cvut.cz>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1550103368-4605-1-git-send-email-zub@linux.fjfi.cvut.cz>
References: <1550103368-4605-1-git-send-email-zub@linux.fjfi.cvut.cz>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The implementation of IOC_OPAL_ENABLE_DISABLE_MBR handled the value
opal_mbr_data.enable_disable incorrectly: enable_disable is expected
to be one of OPAL_MBR_ENABLE(0) or OPAL_MBR_DISABLE(1). enable_disable
was passed directly to set_mbr_done and set_mbr_enable_disable where
is was interpreted as either OPAL_TRUE(1) or OPAL_FALSE(0). The end
result was that calling IOC_OPAL_ENABLE_DISABLE_MBR with OPAL_MBR_ENABLE
actually disabled the shadow MBR and vice versa.

This patch adds correct conversion from OPAL_MBR_DISABLE/ENABLE to
OPAL_FALSE/TRUE. The change affects existing programs using
IOC_OPAL_ENABLE_DISABLE_MBR but this is typically used only once when
setting up an Opal drive.

Signed-off-by: David Kozub <zub@linux.fjfi.cvut.cz>
Acked-by: Jon Derrick <jonathan.derrick@intel.com>
---
 block/sed-opal.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/block/sed-opal.c b/block/sed-opal.c
index e0de4dd448b3..119640897293 100644
--- a/block/sed-opal.c
+++ b/block/sed-opal.c
@@ -2095,13 +2095,16 @@ static int opal_erase_locking_range(struct opal_dev *dev,
 static int opal_enable_disable_shadow_mbr(struct opal_dev *dev,
 					  struct opal_mbr_data *opal_mbr)
 {
+	u8 enable_disable = opal_mbr->enable_disable == OPAL_MBR_ENABLE ?
+		OPAL_TRUE : OPAL_FALSE;
+
 	const struct opal_step mbr_steps[] = {
 		{ opal_discovery0, },
 		{ start_admin1LSP_opal_session, &opal_mbr->key },
-		{ set_mbr_done, &opal_mbr->enable_disable },
+		{ set_mbr_done, &enable_disable },
 		{ end_opal_session, },
 		{ start_admin1LSP_opal_session, &opal_mbr->key },
-		{ set_mbr_enable_disable, &opal_mbr->enable_disable },
+		{ set_mbr_enable_disable, &enable_disable },
 		{ end_opal_session, },
 		{ NULL, }
 	};
@@ -2221,7 +2224,7 @@ static int __opal_lock_unlock(struct opal_dev *dev,
 
 static int __opal_set_mbr_done(struct opal_dev *dev, struct opal_key *key)
 {
-	u8 mbr_done_tf = 1;
+	u8 mbr_done_tf = OPAL_TRUE;
 	const struct opal_step mbrdone_step [] = {
 		{ opal_discovery0, },
 		{ start_admin1LSP_opal_session, key },
-- 
2.20.1

