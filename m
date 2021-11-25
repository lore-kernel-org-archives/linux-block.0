Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A85DC4332F
	for <linux-block@archiver.kernel.org>; Thu, 25 Nov 2021 13:38:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355126AbhKYNmG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Nov 2021 08:42:06 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:58080 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355103AbhKYNkB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Nov 2021 08:40:01 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 26B7A21B36;
        Thu, 25 Nov 2021 13:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637847409; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pspeQ5O47o9ivLrZ7ySOESfJQ2W51Z3nyDReAIUeNG4=;
        b=W7ron2z/5KtILMgAKj4QQTzcYTpIvtmWv3kfAIn2ROBIFsqYZ+sjUEuErGKkgHOoAU0dZE
        1A9OOXc0S4GyIKdmNCFrxLXzKigvKus59YsTMY+JTwZi0MF0W1uOGUiUdWg1u/H3rTpFs9
        F8zULXl6MF9BpxBMF5BLYp4HgZRRSKk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637847409;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pspeQ5O47o9ivLrZ7ySOESfJQ2W51Z3nyDReAIUeNG4=;
        b=OcoiFCt3nmARuj4ildeyI1jl4DARc697ZpD/UirI2+I2nbHI6OxC/KlyAIX/5dlnP0DxoW
        NhaiZRxWpoVz14Dw==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 1A00EA3B8B;
        Thu, 25 Nov 2021 13:36:49 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id E5BEA1F2CE1; Thu, 25 Nov 2021 14:36:45 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     <linux-block@vger.kernel.org>,
        Paolo Valente <paolo.valente@linaro.org>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH 2/8] bfq: Track number of allocated requests in bfq_entity
Date:   Thu, 25 Nov 2021 14:36:35 +0100
Message-Id: <20211125133645.27483-2-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211125133131.14018-1-jack@suse.cz>
References: <20211125133131.14018-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3304; h=from:subject; bh=kBjxfIaLY/3HsqOpz6uuyns/2uF00arb0DZ4ivBTZPk=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBhn5FjSn/ZlC6yNdW4z9hxFQbwP+yqb+V8c32jQMfb 3m9e+cyJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYZ+RYwAKCRCcnaoHP2RA2RWYB/ sGoSxK0nLgxY1zHXtt6AzpwuHje68ReQUwtUdvH5gFQ8CIk6cYdekMACJNS6eRd3rONmzrE2eoJ6K3 VEC+SWulXj4uILoH6K0mik5OUDa5XYlFTYUqEwGGENg1IGb/JluicPELYwdoJzTwj0Zl5nTIYXODy7 RCM5bG7FwgdPh0WDngFC5s/SAxEsBczndvrmkUDLThJBFQK9Ba9ZB1dZjnMoAVNWq6nI/saOytD1CO E+bc6Chfue1pC2F6pq8aRfgK7oPZlkJv2sBdk6/Rbv/o2nyvGteY3avDIZTqaQ8LXWCNWmMLIQTRxi W/rDejByQw3bu9icQM0MEphFsTMrfj
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When we want to limit number of requests used by each bfqq and also
cgroup, we need to track also number of requests used by each cgroup.
So track number of allocated requests for each bfq_entity.

Acked-by: Paolo Valente <paolo.valente@linaro.org>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 block/bfq-iosched.c | 28 ++++++++++++++++++++++------
 block/bfq-iosched.h |  5 +++--
 2 files changed, 25 insertions(+), 8 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 1ce1a99a7160..1d564499614e 100644
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
 
@@ -5878,6 +5879,22 @@ static void bfq_rq_enqueued(struct bfq_data *bfqd, struct bfq_queue *bfqq,
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
@@ -5891,8 +5908,8 @@ static bool __bfq_insert_request(struct bfq_data *bfqd, struct request *rq)
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
@@ -6251,8 +6268,7 @@ static void bfq_completed_request(struct bfq_queue *bfqq, struct bfq_data *bfqd)
 
 static void bfq_finish_requeue_request_body(struct bfq_queue *bfqq)
 {
-	bfqq->allocated--;
-
+	bfqq_request_freed(bfqq);
 	bfq_put_queue(bfqq);
 }
 
@@ -6674,7 +6690,7 @@ static struct bfq_queue *bfq_init_rq(struct request *rq)
 		}
 	}
 
-	bfqq->allocated++;
+	bfqq_request_allocated(bfqq);
 	bfqq->ref++;
 	bfq_log_bfqq(bfqd, bfqq, "get_request %p: bfqq %p, %d",
 		     rq, bfqq, bfqq->ref);
diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index a73488eec8a4..3787cfb0febb 100644
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

