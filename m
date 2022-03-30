Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A679BC4332F
	for <linux-block@archiver.kernel.org>; Wed, 30 Mar 2022 12:45:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345841AbiC3MrN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 30 Mar 2022 08:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345488AbiC3Mqy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Mar 2022 08:46:54 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E76567DE2E
        for <linux-block@vger.kernel.org>; Wed, 30 Mar 2022 05:43:04 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 72B8D1F86E;
        Wed, 30 Mar 2022 12:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1648644181; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0wE+HnT1NzmRxFE6n4iI0AJWcg+fDvyQJY18TY/6yck=;
        b=Xen8v/79cJXaacu3rJt5uimlyD6fm9fjwyrx0X6XqW1OsTqHDQ+eM9nV4fa8D2uCThfOg/
        T24p30bB/mGxL8iSd7rfaDWDnusB4jLOI1k6zTXan0dKfnBl0iIEaMT3M45IwOo2VKEZvi
        gl3cV9B59A8LgyayJa3H86nI3sqgSZ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1648644181;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0wE+HnT1NzmRxFE6n4iI0AJWcg+fDvyQJY18TY/6yck=;
        b=YpDe6+uc7HYi+I+xtFYSEYy1hieSDwjpmMtmjHPhKrrbvarkZMYlli2XE8JQm6FYbJB595
        3poqDS1A14QyquAQ==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 60E52A3B9D;
        Wed, 30 Mar 2022 12:43:01 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 904DCA061E; Wed, 30 Mar 2022 14:42:56 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <linux-block@vger.kernel.org>
Cc:     Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>,
        "yukuai (C)" <yukuai3@huawei.com>, Jan Kara <jack@suse.cz>
Subject: [PATCH 8/9] bfq: Get rid of __bio_blkcg() usage
Date:   Wed, 30 Mar 2022 14:42:51 +0200
Message-Id: <20220330124255.24581-8-jack@suse.cz>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220330123438.32719-1-jack@suse.cz>
References: <20220330123438.32719-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6478; h=from:subject; bh=n+ahp18kHkoCcIYiZqMRynYyw9pppY5NnsV6SESkGwA=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBiRFBKbxDzYwSbJ7cK37Wq1qA6Qf2awFK/0kAByR1n oTGJbwGJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYkRQSgAKCRCcnaoHP2RA2XpICA CTRfHmQhpAZ++D/uJUObjlomHl9uR0QTbNe4nafL2kDhrslv51TfbYXaDnPk6PZ0KQYvNAxKYKIG3H E4AHZnCF2a34xVjjUJmYc1KiYfMcokNwNEaHo/Mv6lW4u+uPfWSUQUpxlgnT4KN+sW051WihU8E6NL J/8g4cBiyVaicNBB+JjCFJgeUD1ebOq0beVAgLJlLrmB4ygBiezrhkofKj794vqxusFPk3h9cjDl9v 3HeMaHR8BAlRbS+wxOZDx7czfV1dtOKQ7OFk1uy0PdxmJTjjTlkVFThIe/jZyutAMZarMpcsq1deVt z3ZNN8B759+8o/aw2uBjT+BKYt2TCg
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

BFQ usage of __bio_blkcg() is a relict from the past. Furthermore if bio
would not be associated with any blkcg, the usage of __bio_blkcg() in
BFQ is prone to races with the task being migrated between cgroups as
__bio_blkcg() calls at different places could return different blkcgs.

Convert BFQ to the new situation where bio->bi_blkg is initialized in
bio_set_dev() and thus practically always valid. This allows us to save
blkcg_gq lookup and noticeably simplify the code.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 block/bfq-cgroup.c  | 63 +++++++++++++++++----------------------------
 block/bfq-iosched.c | 11 +-------
 block/bfq-iosched.h |  3 +--
 3 files changed, 25 insertions(+), 52 deletions(-)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index 879380c2bc7e..32d2c2a47480 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -586,27 +586,11 @@ static void bfq_group_set_parent(struct bfq_group *bfqg,
 	entity->sched_data = &parent->sched_data;
 }
 
-static struct bfq_group *bfq_lookup_bfqg(struct bfq_data *bfqd,
-					 struct blkcg *blkcg)
+static void bfq_link_bfqg(struct bfq_data *bfqd, struct bfq_group *bfqg)
 {
-	struct blkcg_gq *blkg;
-
-	blkg = blkg_lookup(blkcg, bfqd->queue);
-	if (likely(blkg))
-		return blkg_to_bfqg(blkg);
-	return NULL;
-}
-
-struct bfq_group *bfq_find_set_group(struct bfq_data *bfqd,
-				     struct blkcg *blkcg)
-{
-	struct bfq_group *bfqg, *parent;
+	struct bfq_group *parent;
 	struct bfq_entity *entity;
 
-	bfqg = bfq_lookup_bfqg(bfqd, blkcg);
-	if (unlikely(!bfqg))
-		return NULL;
-
 	/*
 	 * Update chain of bfq_groups as we might be handling a leaf group
 	 * which, along with some of its relatives, has not been hooked yet
@@ -623,8 +607,15 @@ struct bfq_group *bfq_find_set_group(struct bfq_data *bfqd,
 			bfq_group_set_parent(curr_bfqg, parent);
 		}
 	}
+}
 
-	return bfqg;
+struct bfq_group *bfq_bio_bfqg(struct bfq_data *bfqd, struct bio *bio)
+{
+	struct blkcg_gq *blkg = bio->bi_blkg;
+
+	if (!blkg)
+		return bfqd->root_group;
+	return blkg_to_bfqg(blkg);
 }
 
 /**
@@ -714,25 +705,15 @@ void bfq_bfqq_move(struct bfq_data *bfqd, struct bfq_queue *bfqq,
  * Move bic to blkcg, assuming that bfqd->lock is held; which makes
  * sure that the reference to cgroup is valid across the call (see
  * comments in bfq_bic_update_cgroup on this issue)
- *
- * NOTE: an alternative approach might have been to store the current
- * cgroup in bfqq and getting a reference to it, reducing the lookup
- * time here, at the price of slightly more complex code.
  */
-static struct bfq_group *__bfq_bic_change_cgroup(struct bfq_data *bfqd,
-						struct bfq_io_cq *bic,
-						struct blkcg *blkcg)
+static void *__bfq_bic_change_cgroup(struct bfq_data *bfqd,
+				     struct bfq_io_cq *bic,
+				     struct bfq_group *bfqg)
 {
 	struct bfq_queue *async_bfqq = bic_to_bfqq(bic, 0);
 	struct bfq_queue *sync_bfqq = bic_to_bfqq(bic, 1);
-	struct bfq_group *bfqg;
 	struct bfq_entity *entity;
 
-	bfqg = bfq_find_set_group(bfqd, blkcg);
-
-	if (unlikely(!bfqg))
-		bfqg = bfqd->root_group;
-
 	if (async_bfqq) {
 		entity = &async_bfqq->entity;
 
@@ -784,20 +765,24 @@ static struct bfq_group *__bfq_bic_change_cgroup(struct bfq_data *bfqd,
 void bfq_bic_update_cgroup(struct bfq_io_cq *bic, struct bio *bio)
 {
 	struct bfq_data *bfqd = bic_to_bfqd(bic);
-	struct bfq_group *bfqg = NULL;
+	struct bfq_group *bfqg = bfq_bio_bfqg(bfqd, bio);
 	uint64_t serial_nr;
 
-	rcu_read_lock();
-	serial_nr = __bio_blkcg(bio)->css.serial_nr;
+	serial_nr = bfqg_to_blkg(bfqg)->blkcg->css.serial_nr;
 
 	/*
 	 * Check whether blkcg has changed.  The condition may trigger
 	 * spuriously on a newly created cic but there's no harm.
 	 */
 	if (unlikely(!bfqd) || likely(bic->blkcg_serial_nr == serial_nr))
-		goto out;
+		return;
 
-	bfqg = __bfq_bic_change_cgroup(bfqd, bic, __bio_blkcg(bio));
+	/*
+	 * New cgroup for this process. Make sure it is linked to bfq internal
+	 * cgroup hierarchy.
+	 */
+	bfq_link_bfqg(bfqd, bfqg);
+	__bfq_bic_change_cgroup(bfqd, bic, bfqg);
 	/*
 	 * Update blkg_path for bfq_log_* functions. We cache this
 	 * path, and update it here, for the following
@@ -850,8 +835,6 @@ void bfq_bic_update_cgroup(struct bfq_io_cq *bic, struct bio *bio)
 	 */
 	blkg_path(bfqg_to_blkg(bfqg), bfqg->blkg_path, sizeof(bfqg->blkg_path));
 	bic->blkcg_serial_nr = serial_nr;
-out:
-	rcu_read_unlock();
 }
 
 /**
@@ -1469,7 +1452,7 @@ void bfq_end_wr_async(struct bfq_data *bfqd)
 	bfq_end_wr_async_queues(bfqd, bfqd->root_group);
 }
 
-struct bfq_group *bfq_find_set_group(struct bfq_data *bfqd, struct blkcg *blkcg)
+struct bfq_group *bfq_bio_bfqg(struct bfq_data *bfqd, struct bio *bio)
 {
 	return bfqd->root_group;
 }
diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index d7cf930b47bb..e47c75f1fa0f 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -5726,14 +5726,7 @@ static struct bfq_queue *bfq_get_queue(struct bfq_data *bfqd,
 	struct bfq_queue *bfqq;
 	struct bfq_group *bfqg;
 
-	rcu_read_lock();
-
-	bfqg = bfq_find_set_group(bfqd, __bio_blkcg(bio));
-	if (!bfqg) {
-		bfqq = &bfqd->oom_bfqq;
-		goto out;
-	}
-
+	bfqg = bfq_bio_bfqg(bfqd, bio);
 	if (!is_sync) {
 		async_bfqq = bfq_async_queue_prio(bfqd, bfqg, ioprio_class,
 						  ioprio);
@@ -5779,8 +5772,6 @@ static struct bfq_queue *bfq_get_queue(struct bfq_data *bfqd,
 
 	if (bfqq != &bfqd->oom_bfqq && is_sync && !respawn)
 		bfqq = bfq_do_or_sched_stable_merge(bfqd, bfqq, bic);
-
-	rcu_read_unlock();
 	return bfqq;
 }
 
diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index 4664e2f3e828..978ef5d6fe6a 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -1009,8 +1009,7 @@ void bfq_bfqq_move(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 void bfq_init_entity(struct bfq_entity *entity, struct bfq_group *bfqg);
 void bfq_bic_update_cgroup(struct bfq_io_cq *bic, struct bio *bio);
 void bfq_end_wr_async(struct bfq_data *bfqd);
-struct bfq_group *bfq_find_set_group(struct bfq_data *bfqd,
-				     struct blkcg *blkcg);
+struct bfq_group *bfq_bio_bfqg(struct bfq_data *bfqd, struct bio *bio);
 struct blkcg_gq *bfqg_to_blkg(struct bfq_group *bfqg);
 struct bfq_group *bfqq_group(struct bfq_queue *bfqq);
 struct bfq_group *bfq_create_group_hierarchy(struct bfq_data *bfqd, int node);
-- 
2.34.1

