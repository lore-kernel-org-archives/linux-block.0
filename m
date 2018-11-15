Return-Path: <SRS0=7Bp6=PY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DATE_IN_PAST_96_XX,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FF4CC43387
	for <linux-block@archiver.kernel.org>; Wed, 16 Jan 2019 23:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3389E20675
	for <linux-block@archiver.kernel.org>; Wed, 16 Jan 2019 23:05:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fjfi.cvut.cz header.i=@fjfi.cvut.cz header.b="FV+TR4b7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbfAPXFB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Jan 2019 18:05:01 -0500
Received: from mailgw1.fjfi.cvut.cz ([147.32.9.3]:45724 "EHLO
        mailgw1.fjfi.cvut.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728384AbfAPXD6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Jan 2019 18:03:58 -0500
Received: from localhost (localhost [127.0.0.1])
        by mailgw1.fjfi.cvut.cz (Postfix) with ESMTP id 0ECCCB03EB;
        Wed, 16 Jan 2019 23:55:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fjfi.cvut.cz;
        s=20151024; t=1547679345; i=@fjfi.cvut.cz;
        bh=ChqJxv6/eOGSectyjcyY3gftnaRFtHmHahcZEa1R51I=;
        h=From:Date:Subject:To:Cc;
        b=FV+TR4b7dBVd0KZX/qxxU8bTzEJvs4twG8TGt2mcqizKKwSy1OtiH4/RQjCpknDdY
         Peu/XFq3o2VFlazQl4nJrx3uBq1gzif13Jl5DhILIXVcm7KKn38cl67IkNNYcF+E50
         WAIpYYCw5JjscD5gL+YXE1ebl3SpvY/BJMGKaknE=
X-CTU-FNSPE-Virus-Scanned: amavisd-new at fjfi.cvut.cz
Received: from mailgw1.fjfi.cvut.cz ([127.0.0.1])
        by localhost (mailgw1.fjfi.cvut.cz [127.0.0.1]) (amavisd-new, port 10022)
        with ESMTP id 1guFEIq8BTH0; Wed, 16 Jan 2019 23:55:40 +0100 (CET)
Received: from linux.fjfi.cvut.cz (linux.fjfi.cvut.cz [147.32.5.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailgw1.fjfi.cvut.cz (Postfix) with ESMTPS id 61BA8AE1CB;
        Wed, 16 Jan 2019 23:55:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailgw1.fjfi.cvut.cz 61BA8AE1CB
Received: by linux.fjfi.cvut.cz (Postfix, from userid 1001)
        id 470186004E; Wed, 16 Jan 2019 23:55:40 +0100 (CET)
From:   David Kozub <zub@linux.fjfi.cvut.cz>
Date:   Thu, 15 Nov 2018 21:33:33 +0100
Subject: [PATCH 06/16] block: sed-opal: unify error handling of responses
To:     Jens Axboe <axboe@kernel.dk>, Scott Bauer <scott.bauer@intel.com>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Message-Id: <20190116225540.470186004E@linux.fjfi.cvut.cz>
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

