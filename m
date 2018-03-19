Return-Path: <SRS0=7Bp6=PY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DATE_IN_PAST_96_XX,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE148C43387
	for <linux-block@archiver.kernel.org>; Wed, 16 Jan 2019 23:04:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D6E020840
	for <linux-block@archiver.kernel.org>; Wed, 16 Jan 2019 23:04:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731770AbfAPXEa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Jan 2019 18:04:30 -0500
Received: from mailgw1.fjfi.cvut.cz ([147.32.9.3]:45730 "EHLO
        mailgw1.fjfi.cvut.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728639AbfAPXD7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Jan 2019 18:03:59 -0500
Received: from localhost (localhost [127.0.0.1])
        by mailgw1.fjfi.cvut.cz (Postfix) with ESMTP id 830A9B0433;
        Wed, 16 Jan 2019 23:55:47 +0100 (CET)
X-CTU-FNSPE-Virus-Scanned: amavisd-new at fjfi.cvut.cz
Received: from mailgw1.fjfi.cvut.cz ([127.0.0.1])
        by localhost (mailgw1.fjfi.cvut.cz [127.0.0.1]) (amavisd-new, port 10022)
        with ESMTP id At6GMvediolp; Wed, 16 Jan 2019 23:55:43 +0100 (CET)
Received: from linux.fjfi.cvut.cz (linux.fjfi.cvut.cz [147.32.5.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailgw1.fjfi.cvut.cz (Postfix) with ESMTPS id 913E1AFD58;
        Wed, 16 Jan 2019 23:55:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailgw1.fjfi.cvut.cz 913E1AFD58
Received: by linux.fjfi.cvut.cz (Postfix, from userid 1001)
        id 740856004E; Wed, 16 Jan 2019 23:55:42 +0100 (CET)
From:   Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Date:   Mon, 19 Mar 2018 19:36:47 +0100
Subject: [PATCH 08/16] block: sed-opal: print failed function address
To:     Jens Axboe <axboe@kernel.dk>, Scott Bauer <scott.bauer@intel.com>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Message-Id: <20190116225542.740856004E@linux.fjfi.cvut.cz>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add function address (and if available its symbol) to the message if a
step function fails.

Signed-off-by: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
---
 block/sed-opal.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/sed-opal.c b/block/sed-opal.c
index 1332547e5a99..4225f23b2165 100644
--- a/block/sed-opal.c
+++ b/block/sed-opal.c
@@ -394,8 +394,8 @@ static int next(struct opal_dev *dev)
 
 		error = step->fn(dev, step->data);
 		if (error) {
-			pr_debug("Error on step function: %d with error %d: %s\n",
-				 state, error,
+			pr_debug("Step %d (%pS) failed wit error %d: %s\n",
+				 state, step->fn, error,
 				 opal_error_to_human(error));
 
 			/* For each OPAL command we do a discovery0 then we
-- 
2.20.1

