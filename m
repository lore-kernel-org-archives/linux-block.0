Return-Path: <SRS0=mhrr=QI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25368C282D8
	for <linux-block@archiver.kernel.org>; Fri,  1 Feb 2019 20:51:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7771218F0
	for <linux-block@archiver.kernel.org>; Fri,  1 Feb 2019 20:51:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fjfi.cvut.cz header.i=@fjfi.cvut.cz header.b="tXzmL0SZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730448AbfBAUv1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 1 Feb 2019 15:51:27 -0500
Received: from mailgw1.fjfi.cvut.cz ([147.32.9.3]:33562 "EHLO
        mailgw1.fjfi.cvut.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730131AbfBAUv1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 1 Feb 2019 15:51:27 -0500
Received: from localhost (localhost [127.0.0.1])
        by mailgw1.fjfi.cvut.cz (Postfix) with ESMTP id F247CAD135;
        Fri,  1 Feb 2019 21:51:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fjfi.cvut.cz;
        s=20151024; t=1549054285; i=@fjfi.cvut.cz;
        bh=KRpiKQ1FHw5beJvLyBOUCDazpOTPgfGwzmOFdWGHs2w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=tXzmL0SZQY7B1/lJJ1EGykksjgvjcx6lur3KbCqhCs8Exv5bJQ+zuGuA0MDGWPM5p
         e29wYaW24mmesOYyhTOTmhffLFWmLcE7/9yzJ39sxuiplOtsDEazhzg68a0k2Gd+qL
         /26DekzqtTPxnpDvL/Ml9P+2J0zqnMOhv0hkl1VU=
X-CTU-FNSPE-Virus-Scanned: amavisd-new at fjfi.cvut.cz
Received: from mailgw1.fjfi.cvut.cz ([127.0.0.1])
        by localhost (mailgw1.fjfi.cvut.cz [127.0.0.1]) (amavisd-new, port 10022)
        with ESMTP id I7eLcuvEgH3K; Fri,  1 Feb 2019 21:51:17 +0100 (CET)
Received: from linux.fjfi.cvut.cz (linux.fjfi.cvut.cz [147.32.5.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailgw1.fjfi.cvut.cz (Postfix) with ESMTPS id 56E8BAD11E;
        Fri,  1 Feb 2019 21:50:50 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailgw1.fjfi.cvut.cz 56E8BAD11E
Received: by linux.fjfi.cvut.cz (Postfix, from userid 1001)
        id 3EB7D6004E; Fri,  1 Feb 2019 21:50:50 +0100 (CET)
From:   David Kozub <zub@linux.fjfi.cvut.cz>
To:     Jens Axboe <axboe@kernel.dk>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        Scott Bauer <sbauer@plzdonthack.me>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>,
        David Kozub <zub@linux.fjfi.cvut.cz>
Subject: [PATCH v4 06/16] block: sed-opal: unify error handling of responses
Date:   Fri,  1 Feb 2019 21:50:13 +0100
Message-Id: <1549054223-12220-7-git-send-email-zub@linux.fjfi.cvut.cz>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1549054223-12220-1-git-send-email-zub@linux.fjfi.cvut.cz>
References: <1549054223-12220-1-git-send-email-zub@linux.fjfi.cvut.cz>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

response_get_{string,u64} include error handling for argument resp being
NULL but response_get_token does not handle this.

Make all three of response_get_{string,u64,token} handle NULL resp in
the same way.

Co-authored-by: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Signed-off-by: David Kozub <zub@linux.fjfi.cvut.cz>
Signed-off-by: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Reviewed-by: Scott Bauer <sbauer@plzdonthack.me>
---
 block/sed-opal.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/block/sed-opal.c b/block/sed-opal.c
index e29cb2f445ff..537cd73ea88a 100644
--- a/block/sed-opal.c
+++ b/block/sed-opal.c
@@ -702,6 +702,11 @@ static const struct opal_resp_tok *response_get_token(
 {
 	const struct opal_resp_tok *tok;
 
+	if (!resp) {
+		pr_debug("Response is NULL\n");
+		return ERR_PTR(-EINVAL);
+	}
+
 	if (n >= resp->num) {
 		pr_debug("Token number doesn't exist: %d, resp: %d\n",
 			 n, resp->num);
-- 
2.20.1

