Return-Path: <SRS0=lHMQ=S2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20C04C282E1
	for <linux-block@archiver.kernel.org>; Wed, 24 Apr 2019 18:00:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA5F020652
	for <linux-block@archiver.kernel.org>; Wed, 24 Apr 2019 18:00:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389700AbfDXRX3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:23:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:38518 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389695AbfDXRX3 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Apr 2019 13:23:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DD1E2AD21;
        Wed, 24 Apr 2019 17:23:26 +0000 (UTC)
From:   Coly Li <colyli@suse.de>
To:     linux-bcache@vger.kernel.org
Cc:     linux-block@vger.kernel.org, Coly Li <colyli@suse.de>
Subject: [PATCH] bcache: add alloc_thread_running to struct cache
Date:   Thu, 25 Apr 2019 01:25:39 +0800
Message-Id: <20190424172539.4991-1-colyli@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

During the process to run a cache set, bch_btree_check() may consume too
many memory to fail bch_cache_allocator_start() to create and run
ca->alloc_thread. If bch_cache_allocator_start() fails, run_cache_set()
will fail too and the cache set won't start to work.

If the allocator thread is created before calling bch_btree_check(),
there will be enough memory for bch_cache_allocator_start(). This is
the major idea how this patch fixes the above issue.

This patch adds a bool variable 'alloc_thread_running' in struct cache.
If caller of bch_allocator_thread() sets 'wait' parameter to true, then
inside bch_allocator_thread(), ca->alloc_thread_running will be set to
false. Which means after the allocator thread starts, it will wait on
allocator_wait() before go into thread main loop, until
ca->alloc_thread_running is set to true.

Then we can call bch_cache_allocator_start() before calling
bch_btree_check() to get enough memory to create allocator thread.
Because ca->alloc_thread_running is initialized to false, we are sure it
won't do real work before being waken up later (at the location where
bch_cache_allocator_start() was originally called in run_cache_set())

If the cache device is not in sync state, all existing data will be
invalid and bch_btree_check() won't be called, for such condition,
'wait' parameter will be set to false to bch_cache_allocator_start(),
then ca->alloc_thread_running will be initialized to true, kernel thread
routine bch_allocator_thread() will not wait and directly go into the
thread main loop. 

Now we can avoid cache set start failure in extreme memory pressure
situation, and not change current cache set start procedure.

Signed-off-by: Coly Li <colyli@suse.de>
---
 drivers/md/bcache/alloc.c  | 14 ++++++++++----
 drivers/md/bcache/bcache.h |  3 ++-
 drivers/md/bcache/super.c  | 16 ++++++++++++----
 3 files changed, 24 insertions(+), 9 deletions(-)

diff --git a/drivers/md/bcache/alloc.c b/drivers/md/bcache/alloc.c
index f8986effcb50..c7bb913735d8 100644
--- a/drivers/md/bcache/alloc.c
+++ b/drivers/md/bcache/alloc.c
@@ -321,6 +321,8 @@ static int bch_allocator_thread(void *arg)
 
 	mutex_lock(&ca->set->bucket_lock);
 
+	allocator_wait(ca, ca->alloc_thread_running == true);
+
 	while (1) {
 		/*
 		 * First, we pull buckets off of the unused and free_inc lists,
@@ -719,12 +721,16 @@ int bch_open_buckets_alloc(struct cache_set *c)
 	return 0;
 }
 
-int bch_cache_allocator_start(struct cache *ca)
+int bch_cache_allocator_start(struct cache *ca, bool wait)
 {
-	struct task_struct *k = kthread_run(bch_allocator_thread,
-					    ca, "bcache_allocator");
-	if (IS_ERR(k))
+	struct task_struct *k;
+
+	ca->alloc_thread_running = (wait == true) ? false : true;
+	k = kthread_run(bch_allocator_thread, ca, "bcache_allocator");
+	if (IS_ERR(k)) {
+		pr_err("kthread_run() error: %p", k);
 		return PTR_ERR(k);
+	}
 
 	ca->alloc_thread = k;
 	return 0;
diff --git a/drivers/md/bcache/bcache.h b/drivers/md/bcache/bcache.h
index fdf75352e16a..385c6555ee93 100644
--- a/drivers/md/bcache/bcache.h
+++ b/drivers/md/bcache/bcache.h
@@ -454,6 +454,7 @@ struct cache {
 
 	struct journal_device	journal;
 
+	bool			alloc_thread_running;
 	/* The rest of this all shows up in sysfs */
 #define IO_ERROR_SHIFT		20
 	atomic_t		io_errors;
@@ -1019,7 +1020,7 @@ void bch_moving_init_cache_set(struct cache_set *c);
 int bch_open_buckets_alloc(struct cache_set *c);
 void bch_open_buckets_free(struct cache_set *c);
 
-int bch_cache_allocator_start(struct cache *ca);
+int bch_cache_allocator_start(struct cache *ca, bool wait);
 
 void bch_debug_exit(void);
 void bch_debug_init(void);
diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index d9f9d701669f..8e6bcde08122 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -1844,6 +1844,12 @@ static int run_cache_set(struct cache_set *c)
 		if (err)
 			goto err;
 
+		err = "error starting allocator thread";
+		for_each_cache(ca, c, i)
+			/* wait until ca->alloc_thread_running set to true */
+			if (bch_cache_allocator_start(ca, true))
+				goto err;
+
 		err = "error in recovery";
 		if (bch_btree_check(c))
 			goto err;
@@ -1859,10 +1865,11 @@ static int run_cache_set(struct cache_set *c)
 		 */
 		bch_journal_next(&c->journal);
 
-		err = "error starting allocator thread";
 		for_each_cache(ca, c, i)
-			if (bch_cache_allocator_start(ca))
-				goto err;
+			if (!IS_ERR(ca->alloc_thread)) {
+				ca->alloc_thread_running = true;
+				wake_up_process(ca->alloc_thread);
+			}
 
 		/*
 		 * First place it's safe to allocate: btree_check() and
@@ -1897,7 +1904,8 @@ static int run_cache_set(struct cache_set *c)
 
 		err = "error starting allocator thread";
 		for_each_cache(ca, c, i)
-			if (bch_cache_allocator_start(ca))
+			/* start without waiting for ca->alloc_thread_running */
+			if (bch_cache_allocator_start(ca, false))
 				goto err;
 
 		mutex_lock(&c->bucket_lock);
-- 
2.16.4

