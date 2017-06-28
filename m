Return-Path: <linux-block-owner@vger.kernel.org>
Received: from iad1-shared-relay2.dreamhost.com ([208.113.157.41]:44079 "EHLO
        iad1-shared-relay2.dreamhost.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751870AbdF3KQ2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Jun 2017 06:16:28 -0400
Received: from iad1-shared-relay1.dreamhost.com (iad1-shared-relay1.dreamhost.com [208.113.157.50])
        by iad1-shared-relay2.dreamhost.com (Postfix) with ESMTP id A02A83E51F5
        for <linux-block@vger.kernel.org>; Thu, 29 Jun 2017 15:12:08 -0700 (PDT)
Received: from ware.dreamhost.com (ware.dreamhost.com [64.111.127.160])
        by iad1-shared-relay1.dreamhost.com (Postfix) with ESMTP id 8BAD9B40055
        for <linux-block@vger.kernel.org>; Thu, 29 Jun 2017 15:12:07 -0700 (PDT)
In-Reply-To: <20170629134510.GA32385@infradead.org>
References: <20170629134510.GA32385@infradead.org>
From: Tang Junhui <tang.junhui@zte.com.cn>
Date: Tue, 27 Jun 2017 17:41:35 -0700
Subject: [PATCH 17/19] bcache: fix for gc and write-back race
To: linux-block@vger.kernel.org
Message-Id: <20170629221207.7B796100127@ware.dreamhost.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

gc and write-back get raced (see the email "bcache get stucked" I sended
before):
gc thread						write-back thread
|							|bch_writeback_thread()
|bch_gc_thread()					|
|							|==>read_dirty()
|==>bch_btree_gc()					|
|==>btree_root() //get btree root			|
|			node write locker		|
|==>bch_btree_gc_root()					|
|							|==>read_dirty_submit()
|							|==>write_dirty()
|							|==>continue_at(cl, write_dirty_finish, system_wq);
|							|==>write_dirty_finish()//excute in system_wq
|							|==>bch_btree_insert()
|							|==>bch_btree_map_leaf_nodes()
|							|==>__bch_btree_map_nodes()
|							|==>btree_root //try to get btree root node read lock
|							|-----stuck here
|==>bch_btree_set_root()				|
|==>bch_journal_meta()					|
|==>bch_journal()					|
|==>journal_try_write()					|
|==>journal_write_unlocked() //journal_full(&c->journal) condition satisfied
|==>continue_at(cl, journal_write, system_wq); //try to excute journal_write in system_wq
|					//but work queue is excuting write_dirty_finish()
|==>closure_sync(); //wait journal_write execute over and wake up gc,
|			--stuck here
|==>release root node write locker

This patch alloc a separate work-queue for write-back thread to avoid such
race.

Signed-off-by: Tang Junhui <tang.junhui@zte.com.cn>
Cc: stable@vger.kernel.org
---
 drivers/md/bcache/bcache.h    | 1 +
 drivers/md/bcache/super.c     | 2 ++
 drivers/md/bcache/writeback.c | 8 ++++++--
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/md/bcache/bcache.h b/drivers/md/bcache/bcache.h
index 44123e4..deb0a6c 100644
--- a/drivers/md/bcache/bcache.h
+++ b/drivers/md/bcache/bcache.h
@@ -333,6 +333,7 @@ struct cached_dev {
 	/* Limit number of writeback bios in flight */
 	struct semaphore	in_flight;
 	struct task_struct	*writeback_thread;
+	struct workqueue_struct	*writeback_write_wq;
 
 	struct keybuf		writeback_keys;
 
diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index e06641e..24cb9b7 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -1063,6 +1063,8 @@ static void cached_dev_free(struct closure *cl)
 	cancel_delayed_work_sync(&dc->writeback_rate_update);
 	if (!IS_ERR_OR_NULL(dc->writeback_thread))
 		kthread_stop(dc->writeback_thread);
+	if (dc->writeback_write_wq)
+		destroy_workqueue(dc->writeback_write_wq);
 
 	mutex_lock(&bch_register_lock);
 
diff --git a/drivers/md/bcache/writeback.c b/drivers/md/bcache/writeback.c
index 4104eaa..4bc5daa 100644
--- a/drivers/md/bcache/writeback.c
+++ b/drivers/md/bcache/writeback.c
@@ -189,7 +189,7 @@ static void write_dirty(struct closure *cl)
 
 	closure_bio_submit(&io->bio, cl);
 
-	continue_at(cl, write_dirty_finish, system_wq);
+	continue_at(cl, write_dirty_finish, io->dc->writeback_write_wq);
 }
 
 static void read_dirty_endio(struct bio *bio)
@@ -209,7 +209,7 @@ static void read_dirty_submit(struct closure *cl)
 
 	closure_bio_submit(&io->bio, cl);
 
-	continue_at(cl, write_dirty, system_wq);
+	continue_at(cl, write_dirty, io->dc->writeback_write_wq);
 }
 
 static void read_dirty(struct cached_dev *dc)
@@ -527,6 +527,10 @@ void bch_cached_dev_writeback_init(struct cached_dev *dc)
 
 int bch_cached_dev_writeback_start(struct cached_dev *dc)
 {
+	dc->writeback_write_wq = alloc_workqueue("bcache_writeback_wq", WQ_MEM_RECLAIM, 0);
+	if (!dc->writeback_write_wq)
+		return -ENOMEM;
+
 	dc->writeback_thread = kthread_create(bch_writeback_thread, dc,
 					      "bcache_writeback");
 	if (IS_ERR(dc->writeback_thread))
-- 
1.8.3.1
