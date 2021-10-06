Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA28FC433EF
	for <linux-block@archiver.kernel.org>; Wed,  6 Oct 2021 17:32:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98A1F6117A
	for <linux-block@archiver.kernel.org>; Wed,  6 Oct 2021 17:32:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234560AbhJFRd5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 Oct 2021 13:33:57 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:50248 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238116AbhJFRdv (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Oct 2021 13:33:51 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id CDA762256C;
        Wed,  6 Oct 2021 17:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1633541517; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8gJc4Kjzq6efjMtvdEW4yNaQaDKWgD8Tt8ivJ20I73w=;
        b=1dN/lBXxs6dWuQV5Z0UyuX9pLjIofJfyJiB0NzH7rRJgc5z06NDpoOo3Pj9eCL+ZZlP19l
        Djs7p+NBr7kJfd20xrmEFsQ2xwukwoUhAj0/q38cKHixSk0a5FprDIPqTM+bUsJF6wGnPL
        WHQGR/U5lUNGC1zkQiJbfTGa7zq2+V0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1633541517;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8gJc4Kjzq6efjMtvdEW4yNaQaDKWgD8Tt8ivJ20I73w=;
        b=cY5FYQzJ/cYratiq5qtC3vEK99HRcJwj9GS5U78avhCR65q9OkP+oPXP1bDWi4wRo/EaVh
        qgJgvUNZXx/0zyAA==
Received: from quack2.suse.cz (unknown [10.163.28.18])
        by relay2.suse.de (Postfix) with ESMTP id B4FBBA3B8A;
        Wed,  6 Oct 2021 17:31:57 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 61C1C1F2C96; Wed,  6 Oct 2021 19:31:57 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     <linux-block@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>,
        =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH 2/8] bfq: Track number of allocated requests in bfq_entity
Date:   Wed,  6 Oct 2021 19:31:41 +0200
Message-Id: <20211006173157.6906-2-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211006164110.10817-1-jack@suse.cz>
References: <20211006164110.10817-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3252; h=from:subject; bh=nE1Pgob+FcOETPoHQx5WX3CJpLvFgGAQQLuIEdwgsqA=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBhXd19HE8X0u2ZnTb9+e8l9dCiIxSg8SttTYmmkkF9 3Z7SlUmJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYV3dfQAKCRCcnaoHP2RA2VQwCA DdSmsq6VMH3kbxqQgtskvD8jGSlmxS9Lat0RqcQMurvfwGE89ytlkpO1dwdfciM5YK85QsNYF+l3lp ZPiL4YsEWHWOqWagRZrlLudaT22lORZoMypMFxdd5RPGAwqrxAjQTQPNBPeT8ZGpSc57Lae4Moh8fq 72g/RRxFB37gFnAXOITorSFmn/k8f5exiUNBZNemqsK9Pr1U/8cVZbkLdCGV2UNi2Ic/oAB67NphqZ 9VxSYuV1WWHzkQknBDiBM22TD1lo0jVjLIAl4VhOuFj2GJxTplpQ9f8nmAm+MCYsTEqTnL2GLR6wXl nTScXrhgNb/ct8spAaGtPwS6LCOg5p
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
index 480e1a134859..4d9e04edb614 100644
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
 
@@ -6672,7 +6688,7 @@ static struct bfq_queue *bfq_init_rq(struct request *rq)
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

