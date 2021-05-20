Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A16EC433ED
	for <linux-block@archiver.kernel.org>; Thu, 20 May 2021 22:34:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E7AF613AC
	for <linux-block@archiver.kernel.org>; Thu, 20 May 2021 22:34:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231565AbhETWfZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 May 2021 18:35:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:39202 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231533AbhETWfY (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 May 2021 18:35:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 90103ABF6;
        Thu, 20 May 2021 22:34:01 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 365C51F2C5D; Fri, 21 May 2021 00:34:01 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     <linux-block@vger.kernel.org>, Khazhy Kumykov <khazhy@google.com>,
        Paolo Valente <paolo.valente@linaro.org>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH 1/2] block: Do not merge recursively in elv_attempt_insert_merge()
Date:   Fri, 21 May 2021 00:33:52 +0200
Message-Id: <20210520223353.11561-2-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210520223353.11561-1-jack@suse.cz>
References: <20210520223353.11561-1-jack@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Most of the merging happens at bio level. There should not be much
merging happening at request level anymore. Furthermore if we backmerged
a request to the previous one, the chances to be able to merge the
result to even previous request are slim - that could succeed only if
requests were inserted in 2 1 3 order. Merging more requests in
elv_attempt_insert_merge() will be difficult to handle when we want to
pass requests to free back to the caller of
blk_mq_sched_try_insert_merge(). So just remove the possibility of
merging multiple requests in elv_attempt_insert_merge().

Signed-off-by: Jan Kara <jack@suse.cz>
---
 block/elevator.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/block/elevator.c b/block/elevator.c
index 440699c28119..098f4bd226f5 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -350,12 +350,11 @@ enum elv_merge elv_merge(struct request_queue *q, struct request **req,
  * we can append 'rq' to an existing request, so we can throw 'rq' away
  * afterwards.
  *
- * Returns true if we merged, false otherwise
+ * Returns true if we merged, false otherwise.
  */
 bool elv_attempt_insert_merge(struct request_queue *q, struct request *rq)
 {
 	struct request *__rq;
-	bool ret;
 
 	if (blk_queue_nomerges(q))
 		return false;
@@ -369,21 +368,13 @@ bool elv_attempt_insert_merge(struct request_queue *q, struct request *rq)
 	if (blk_queue_noxmerges(q))
 		return false;
 
-	ret = false;
 	/*
 	 * See if our hash lookup can find a potential backmerge.
 	 */
-	while (1) {
-		__rq = elv_rqhash_find(q, blk_rq_pos(rq));
-		if (!__rq || !blk_attempt_req_merge(q, __rq, rq))
-			break;
-
-		/* The merged request could be merged with others, try again */
-		ret = true;
-		rq = __rq;
-	}
-
-	return ret;
+	__rq = elv_rqhash_find(q, blk_rq_pos(rq));
+	if (!__rq || !blk_attempt_req_merge(q, __rq, rq))
+		return false;
+	return true;
 }
 
 void elv_merged_request(struct request_queue *q, struct request *rq,
-- 
2.26.2

