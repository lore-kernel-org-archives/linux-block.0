Return-Path: <SRS0=sC6v=PZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01EA2C43444
	for <linux-block@archiver.kernel.org>; Thu, 17 Jan 2019 21:33:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C526D20859
	for <linux-block@archiver.kernel.org>; Thu, 17 Jan 2019 21:33:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fjfi.cvut.cz header.i=@fjfi.cvut.cz header.b="jTtuRZi5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727559AbfAQVdX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Jan 2019 16:33:23 -0500
Received: from mailgw1.fjfi.cvut.cz ([147.32.9.3]:35376 "EHLO
        mailgw1.fjfi.cvut.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729734AbfAQVdX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Jan 2019 16:33:23 -0500
Received: from localhost (localhost [127.0.0.1])
        by mailgw1.fjfi.cvut.cz (Postfix) with ESMTP id C0901A399F;
        Thu, 17 Jan 2019 22:33:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fjfi.cvut.cz;
        s=20151024; t=1547760800; i=@fjfi.cvut.cz;
        bh=ChqJxv6/eOGSectyjcyY3gftnaRFtHmHahcZEa1R51I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=jTtuRZi56m43TZEtpHHLeDvpeyv+2oXq+jMxkGXbnjwqjwjQzyV6zemhdPcTMF49c
         IOAOJTnzAOgRmgWi+NGTQFFJuKMD/ori+8wHru+wEm7u7nlOrEB2sEcpVGRVPkQcun
         X+7bz0uOa2h4TmCJm/Joj9aDGBGFPpwGQN+WlQgc=
X-CTU-FNSPE-Virus-Scanned: amavisd-new at fjfi.cvut.cz
Received: from mailgw1.fjfi.cvut.cz ([127.0.0.1])
        by localhost (mailgw1.fjfi.cvut.cz [127.0.0.1]) (amavisd-new, port 10022)
        with ESMTP id CnPkVwDhMkJq; Thu, 17 Jan 2019 22:33:12 +0100 (CET)
Received: from linux.fjfi.cvut.cz (linux.fjfi.cvut.cz [147.32.5.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailgw1.fjfi.cvut.cz (Postfix) with ESMTPS id 2ABC7A3958;
        Thu, 17 Jan 2019 22:33:08 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailgw1.fjfi.cvut.cz 2ABC7A3958
Received: by linux.fjfi.cvut.cz (Postfix, from userid 1001)
        id F25646004E; Thu, 17 Jan 2019 22:33:07 +0100 (CET)
From:   David Kozub <zub@linux.fjfi.cvut.cz>
To:     Jens Axboe <axboe@kernel.dk>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>,
        David Kozub <zub@linux.fjfi.cvut.cz>
Subject: [PATCH v2 06/16] block: sed-opal: unify error handling of responses
Date:   Thu, 17 Jan 2019 22:31:46 +0100
Message-Id: <1547760716-7304-7-git-send-email-zub@linux.fjfi.cvut.cz>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1547760716-7304-1-git-send-email-zub@linux.fjfi.cvut.cz>
References: <1547760716-7304-1-git-send-email-zub@linux.fjfi.cvut.cz>
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

