Return-Path: <SRS0=CiZa=NZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 244D0C43441
	for <linux-block@archiver.kernel.org>; Wed, 14 Nov 2018 22:33:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6338208E7
	for <linux-block@archiver.kernel.org>; Wed, 14 Nov 2018 22:33:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6338208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388679AbeKOIjB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Nov 2018 03:39:01 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:52922 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726754AbeKOIjA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Nov 2018 03:39:00 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1gN3T7-0004vw-Ko; Wed, 14 Nov 2018 22:17:05 +0000
From:   Colin King <colin.king@canonical.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] block: clean up dead code that is now redundant
Date:   Wed, 14 Nov 2018 22:17:05 +0000
Message-Id: <20181114221705.17207-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The boolean next_sorted is set to false and is never changed, hence
the code that checks if it is true is dead code and can now be
removed.  This dead code occurred from a previous commit that cleaned
up the elevator and removed the setting of next_sorted to true.

Detected by CoverityScan, CID#1475401 ("'Constant' variable guards
dead code")

Fixes: a1ce35fa4985 ("block: remove dead elevator code")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 block/elevator.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/block/elevator.c b/block/elevator.c
index 19351ffa56b1..796436270682 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -394,18 +394,11 @@ void elv_merge_requests(struct request_queue *q, struct request *rq,
 			     struct request *next)
 {
 	struct elevator_queue *e = q->elevator;
-	bool next_sorted = false;
 
 	if (e->type->ops.requests_merged)
 		e->type->ops.requests_merged(q, rq, next);
 
 	elv_rqhash_reposition(q, rq);
-
-	if (next_sorted) {
-		elv_rqhash_del(q, next);
-		q->nr_sorted--;
-	}
-
 	q->last_merge = rq;
 }
 
-- 
2.19.1

