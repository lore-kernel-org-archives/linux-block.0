Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD5F8C1B08C
	for <linux-block@archiver.kernel.org>; Thu, 15 Jul 2021 13:30:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94B67608FE
	for <linux-block@archiver.kernel.org>; Thu, 15 Jul 2021 13:30:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237525AbhGONdV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Jul 2021 09:33:21 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:53872 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237360AbhGONdV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Jul 2021 09:33:21 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 635AA2278A;
        Thu, 15 Jul 2021 13:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1626355827; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TtT6HXecD3OMF37cBv9XBf+I51CDX6Q833fzzz8oFNc=;
        b=QebGYxTz432yuNkRwkqd0D2PGidZnGRhULotIohvElTpd6ke1bo6N0MlAfzIL7QT71nwQV
        +g9gvpPv+bmzOVSd800vwHuludWF4ii1O3M1w0HuXEMqrzPpfRn1k4sEHcAW2FMf8MhtpU
        8nF0cMk/CqL+OK2srP+MhMrwRws3VNI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1626355827;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TtT6HXecD3OMF37cBv9XBf+I51CDX6Q833fzzz8oFNc=;
        b=7gBOm4E1GP13jS9dv5lAcAyvhOnwwQ7+URK3KmRWyPKDHwc+tU1qSn9thTzPl/tJJ5GWyE
        3kjbl6pOLKmD4zAQ==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 52DB0A3B9A;
        Thu, 15 Jul 2021 13:30:27 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 359C71E0BF6; Thu, 15 Jul 2021 15:30:27 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     <linux-block@vger.kernel.org>,
        Paolo Valente <paolo.valente@linaro.org>,
        =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH 2/3] bfq: Track number of allocated requests in bfq_entity
Date:   Thu, 15 Jul 2021 15:30:18 +0200
Message-Id: <20210715133027.23975-2-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210715132047.20874-1-jack@suse.cz>
References: <20210715132047.20874-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3252; h=from:subject; bh=rlIMrQse0DymWFIikMEs/b6gQ7juS+LiMlbECXmQMQ8=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBg8DhqVsHyFnKZ3R1UWjiH1GHmy1+zJqsnN/ousr94 UWUqP1aJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYPA4agAKCRCcnaoHP2RA2VtkCA CyFG0nj5ukrYcTYBZoOYfjF1kMxGDeUa/0+Xv2A1NLNDrxC1sVvyciEdtQx4Z7jFjWJBlXaciEcmV2 E6Gb6H/yk6e54bJ6wnJwr/XXQMFIoPL+q8t77xY2hLjgxDAs51rG3mkDqb8OOUNcyURuOhWB/kX/eX e+8VN9ruQBNHNqamNMhyDyrLxZZAWCCNncLzu7hgscY3oL0xLmFOiQzv0qIdLxGde3p8ixosrILMOh vzM4ZnJ698KUzKcQ/g6wEBdC4YZZwMzPhmh/m98L+Xe3yNhqSX+GSuvMV19Y6T1uK+cyQFvpl4tG+I PZcHccK5uAivlLpW71abVZorXf7PYv
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When we want to limit number of requests used by each bfqq and also
cgroup, we need to track also number of requests used by each cgroup.
So track number of allocated requests for each bfq_entity.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 block/bfq-iosched.c | 28 ++++++++++++++++++++++------
 block/bfq-iosched.h |  5 +++--
 2 files changed, 25 insertions(+), 8 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 727955918563..9ef057dc0028 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -1113,7 +1113,8 @@ bfq_bfqq_resume_state(struct bfq_queue *bfqq, struct bfq_data *bfqd,
 
 static int bfqq_process_refs(struct bfq_queue *bfqq)
 {
-	return bfqq->ref - bfqq->allocated - bfqq->entity.on_st_or_in_serv -
+	return bfqq->ref - bfqq->entity.allocated -
+		bfqq->entity.on_st_or_in_serv -
 		(bfqq->weight_counter != NULL) - bfqq->stable_ref;
 }
 
@@ -5875,6 +5876,22 @@ static void bfq_rq_enqueued(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 	}
 }
 
+static void bfqq_request_allocated(struct bfq_queue *bfqq)
+{
+	struct bfq_entity *entity = &bfqq->entity;
+
+	for_each_entity(entity)
+		entity->allocated++;
+}
+
+static void bfqq_request_freed(struct bfq_queue *bfqq)
+{
+	struct bfq_entity *entity = &bfqq->entity;
+
+	for_each_entity(entity)
+		entity->allocated--;
+}
+
 /* returns true if it causes the idle timer to be disabled */
 static bool __bfq_insert_request(struct bfq_data *bfqd, struct request *rq)
 {
@@ -5888,8 +5905,8 @@ static bool __bfq_insert_request(struct bfq_data *bfqd, struct request *rq)
 		 * Release the request's reference to the old bfqq
 		 * and make sure one is taken to the shared queue.
 		 */
-		new_bfqq->allocated++;
-		bfqq->allocated--;
+		bfqq_request_allocated(new_bfqq);
+		bfqq_request_freed(bfqq);
 		new_bfqq->ref++;
 		/*
 		 * If the bic associated with the process
@@ -6248,8 +6265,7 @@ static void bfq_completed_request(struct bfq_queue *bfqq, struct bfq_data *bfqd)
 
 static void bfq_finish_requeue_request_body(struct bfq_queue *bfqq)
 {
-	bfqq->allocated--;
-
+	bfqq_request_freed(bfqq);
 	bfq_put_queue(bfqq);
 }
 
@@ -6669,7 +6685,7 @@ static struct bfq_queue *bfq_init_rq(struct request *rq)
 		}
 	}
 
-	bfqq->allocated++;
+	bfqq_request_allocated(bfqq);
 	bfqq->ref++;
 	bfq_log_bfqq(bfqd, bfqq, "get_request %p: bfqq %p, %d",
 		     rq, bfqq, bfqq->ref);
diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index 99c2a3cb081e..70d4a9b54613 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -170,6 +170,9 @@ struct bfq_entity {
 	/* budget, used also to calculate F_i: F_i = S_i + @budget / @weight */
 	int budget;
 
+	/* Number of requests allocated in the subtree of this entity */
+	int allocated;
+
 	/* device weight, if non-zero, it overrides the default weight of
 	 * bfq_group_data */
 	int dev_weight;
@@ -266,8 +269,6 @@ struct bfq_queue {
 	struct request *next_rq;
 	/* number of sync and async requests queued */
 	int queued[2];
-	/* number of requests currently allocated */
-	int allocated;
 	/* number of pending metadata requests */
 	int meta_pending;
 	/* fifo list of requests in sort_list */
-- 
2.26.2

