Return-Path: <SRS0=Oz1R=QV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E29A4C43381
	for <linux-block@archiver.kernel.org>; Thu, 14 Feb 2019 00:17:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B126821920
	for <linux-block@archiver.kernel.org>; Thu, 14 Feb 2019 00:17:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fjfi.cvut.cz header.i=@fjfi.cvut.cz header.b="CZO5QDIs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733227AbfBNARP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Feb 2019 19:17:15 -0500
Received: from mailgw1.fjfi.cvut.cz ([147.32.9.3]:47664 "EHLO
        mailgw1.fjfi.cvut.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404809AbfBNARL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Feb 2019 19:17:11 -0500
Received: from localhost (localhost [127.0.0.1])
        by mailgw1.fjfi.cvut.cz (Postfix) with ESMTP id 630C1AA28C;
        Thu, 14 Feb 2019 01:17:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fjfi.cvut.cz;
        s=20151024; t=1550103428; i=@fjfi.cvut.cz;
        bh=ReCOEEtqsUKK6QafIUcV8mQ+jtiyjIElJ8VpdQ1Aqtc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=CZO5QDIs0ECta7nIcZqxaX7ya88bU0DkWgzkeb1oe+CfoafVYrmpMrPrG2aG9Gdrx
         v2woV7djSQUOtvT2m1AYAukZZ6B3+M2RltQxSoBiGLfaVYTAJgnMP3XgQIDZ+ZUmWM
         5ED+fFYbtbloEwbFQ9jYVgF4HMOZ7ShSRtxyCuVE=
X-CTU-FNSPE-Virus-Scanned: amavisd-new at fjfi.cvut.cz
Received: from mailgw1.fjfi.cvut.cz ([127.0.0.1])
        by localhost (mailgw1.fjfi.cvut.cz [127.0.0.1]) (amavisd-new, port 10022)
        with ESMTP id Im0dCcd75nVj; Thu, 14 Feb 2019 01:17:00 +0100 (CET)
Received: from linux.fjfi.cvut.cz (linux.fjfi.cvut.cz [147.32.5.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailgw1.fjfi.cvut.cz (Postfix) with ESMTPS id A16C7AA26F;
        Thu, 14 Feb 2019 01:17:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailgw1.fjfi.cvut.cz A16C7AA26F
Received: by linux.fjfi.cvut.cz (Postfix, from userid 1001)
        id 74AE46004E; Thu, 14 Feb 2019 01:17:00 +0100 (CET)
From:   David Kozub <zub@linux.fjfi.cvut.cz>
To:     Jens Axboe <axboe@kernel.dk>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        Scott Bauer <sbauer@plzdonthack.me>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>,
        David Kozub <zub@linux.fjfi.cvut.cz>
Subject: [PATCH 11/16] block: sed-opal: add token for OPAL_LIFECYCLE
Date:   Thu, 14 Feb 2019 01:16:03 +0100
Message-Id: <1550103368-4605-12-git-send-email-zub@linux.fjfi.cvut.cz>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1550103368-4605-1-git-send-email-zub@linux.fjfi.cvut.cz>
References: <1550103368-4605-1-git-send-email-zub@linux.fjfi.cvut.cz>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Define OPAL_LIFECYCLE token and use it instead of literals in
get_lsp_lifecycle.

Signed-off-by: David Kozub <zub@linux.fjfi.cvut.cz>
---
 block/opal_proto.h | 2 ++
 block/sed-opal.c   | 4 ++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/block/opal_proto.h b/block/opal_proto.h
index e20be8258854..b6e352cfe982 100644
--- a/block/opal_proto.h
+++ b/block/opal_proto.h
@@ -170,6 +170,8 @@ enum opal_token {
 	OPAL_READLOCKED = 0x07,
 	OPAL_WRITELOCKED = 0x08,
 	OPAL_ACTIVEKEY = 0x0A,
+	/* lockingsp table */
+	OPAL_LIFECYCLE = 0x06,
 	/* locking info table */
 	OPAL_MAXRANGES = 0x04,
 	 /* mbr control */
diff --git a/block/sed-opal.c b/block/sed-opal.c
index ad66d1dc725a..7f02e50e2bce 100644
--- a/block/sed-opal.c
+++ b/block/sed-opal.c
@@ -1786,12 +1786,12 @@ static int get_lsp_lifecycle(struct opal_dev *dev, void *data)
 
 	add_token_u8(&err, dev, OPAL_STARTNAME);
 	add_token_u8(&err, dev, 3); /* Start Column */
-	add_token_u8(&err, dev, 6); /* Lifecycle Column */
+	add_token_u8(&err, dev, OPAL_LIFECYCLE);
 	add_token_u8(&err, dev, OPAL_ENDNAME);
 
 	add_token_u8(&err, dev, OPAL_STARTNAME);
 	add_token_u8(&err, dev, 4); /* End Column */
-	add_token_u8(&err, dev, 6); /* Lifecycle Column */
+	add_token_u8(&err, dev, OPAL_LIFECYCLE);
 	add_token_u8(&err, dev, OPAL_ENDNAME);
 
 	add_token_u8(&err, dev, OPAL_ENDLIST);
-- 
2.20.1

