Return-Path: <SRS0=7Bp6=PY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DATE_IN_PAST_96_XX,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB1B1C43387
	for <linux-block@archiver.kernel.org>; Wed, 16 Jan 2019 23:04:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6A9B2086D
	for <linux-block@archiver.kernel.org>; Wed, 16 Jan 2019 23:04:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fjfi.cvut.cz header.i=@fjfi.cvut.cz header.b="p7uVIJRW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730489AbfAPXEK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Jan 2019 18:04:10 -0500
Received: from mailgw1.fjfi.cvut.cz ([147.32.9.3]:45736 "EHLO
        mailgw1.fjfi.cvut.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729055AbfAPXEA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Jan 2019 18:04:00 -0500
Received: from localhost (localhost [127.0.0.1])
        by mailgw1.fjfi.cvut.cz (Postfix) with ESMTP id 59DA0B042E;
        Wed, 16 Jan 2019 23:55:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fjfi.cvut.cz;
        s=20151024; t=1547679346; i=@fjfi.cvut.cz;
        bh=uX2eDIOSDa5Anhf6mUlNXG64ORX24xhnNJO0u9bCxaY=;
        h=From:Date:Subject:To:Cc;
        b=p7uVIJRW48gqhERmOO9/6vZjF1XDRMdY4sz6KHfMXjxmYrRcz+2oGJ4ZMf0CnOzmL
         iPBphdgmf8jUY8mbwaixooveHWJ2YUCcYJoEya5Y3Fcv10cDLn1fblgkknA6C2mqxY
         gFa+DcxSfkF9j3pWw1hbVmz7X/zkBhBODsjMr8f8=
X-CTU-FNSPE-Virus-Scanned: amavisd-new at fjfi.cvut.cz
Received: from mailgw1.fjfi.cvut.cz ([127.0.0.1])
        by localhost (mailgw1.fjfi.cvut.cz [127.0.0.1]) (amavisd-new, port 10022)
        with ESMTP id yHHLb1xw5yOb; Wed, 16 Jan 2019 23:55:41 +0100 (CET)
Received: from linux.fjfi.cvut.cz (linux.fjfi.cvut.cz [147.32.5.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailgw1.fjfi.cvut.cz (Postfix) with ESMTPS id 864B0AEFB1;
        Wed, 16 Jan 2019 23:55:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailgw1.fjfi.cvut.cz 864B0AEFB1
Received: by linux.fjfi.cvut.cz (Postfix, from userid 1001)
        id 5D5986004E; Wed, 16 Jan 2019 23:55:41 +0100 (CET)
From:   David Kozub <zub@linux.fjfi.cvut.cz>
Date:   Thu, 15 Nov 2018 21:35:20 +0100
Subject: [PATCH 07/16] block: sed-opal: reuse response_get_token to decrease
 code duplication
To:     Jens Axboe <axboe@kernel.dk>, Scott Bauer <scott.bauer@intel.com>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Message-Id: <20190116225541.5D5986004E@linux.fjfi.cvut.cz>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

response_get_token had already been in place, its functionality had
been duplicated within response_get_{u64,bytestring} with the same error
handling. Unify the handling by reusing response_get_token within the
other functions.

Co-authored-by: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Signed-off-by: David Kozub <zub@linux.fjfi.cvut.cz>
Signed-off-by: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
---
 block/sed-opal.c | 46 +++++++++++++++-------------------------------
 1 file changed, 15 insertions(+), 31 deletions(-)

diff --git a/block/sed-opal.c b/block/sed-opal.c
index 537cd73ea88a..1332547e5a99 100644
--- a/block/sed-opal.c
+++ b/block/sed-opal.c
@@ -889,27 +889,19 @@ static size_t response_get_string(const struct parsed_resp *resp, int n,
 				  const char **store)
 {
 	u8 skip;
-	const struct opal_resp_tok *token;
+	const struct opal_resp_tok *tok;
 
 	*store = NULL;
-	if (!resp) {
-		pr_debug("Response is NULL\n");
-		return 0;
-	}
-
-	if (n >= resp->num) {
-		pr_debug("Response has %d tokens. Can't access %d\n",
-			 resp->num, n);
+	tok = response_get_token(resp, n);
+	if (IS_ERR(tok))
 		return 0;
-	}
 
-	token = &resp->toks[n];
-	if (token->type != OPAL_DTA_TOKENID_BYTESTRING) {
+	if (tok->type != OPAL_DTA_TOKENID_BYTESTRING) {
 		pr_debug("Token is not a byte string!\n");
 		return 0;
 	}
 
-	switch (token->width) {
+	switch (tok->width) {
 	case OPAL_WIDTH_TINY:
 	case OPAL_WIDTH_SHORT:
 		skip = 1;
@@ -925,37 +917,29 @@ static size_t response_get_string(const struct parsed_resp *resp, int n,
 		return 0;
 	}
 
-	*store = token->pos + skip;
-	return token->len - skip;
+	*store = tok->pos + skip;
+	return tok->len - skip;
 }
 
 static u64 response_get_u64(const struct parsed_resp *resp, int n)
 {
-	if (!resp) {
-		pr_debug("Response is NULL\n");
-		return 0;
-	}
+	const struct opal_resp_tok *tok;
 
-	if (n >= resp->num) {
-		pr_debug("Response has %d tokens. Can't access %d\n",
-			 resp->num, n);
+	tok = response_get_token(resp, n);
+	if (IS_ERR(tok))
 		return 0;
-	}
 
-	if (resp->toks[n].type != OPAL_DTA_TOKENID_UINT) {
-		pr_debug("Token is not unsigned it: %d\n",
-			 resp->toks[n].type);
+	if (tok->type != OPAL_DTA_TOKENID_UINT) {
+		pr_debug("Token is not unsigned int: %d\n", tok->type);
 		return 0;
 	}
 
-	if (!(resp->toks[n].width == OPAL_WIDTH_TINY ||
-	      resp->toks[n].width == OPAL_WIDTH_SHORT)) {
-		pr_debug("Atom is not short or tiny: %d\n",
-			 resp->toks[n].width);
+	if (tok->width != OPAL_WIDTH_TINY && tok->width != OPAL_WIDTH_SHORT) {
+		pr_debug("Atom is not short or tiny: %d\n", tok->width);
 		return 0;
 	}
 
-	return resp->toks[n].stored.u;
+	return tok->stored.u;
 }
 
 static bool response_token_matches(const struct opal_resp_tok *token, u8 match)
-- 
2.20.1

