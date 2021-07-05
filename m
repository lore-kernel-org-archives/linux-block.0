Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD5DEC07E99
	for <linux-block@archiver.kernel.org>; Mon,  5 Jul 2021 10:26:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7448613E7
	for <linux-block@archiver.kernel.org>; Mon,  5 Jul 2021 10:26:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbhGEK3f (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 5 Jul 2021 06:29:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46107 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230504AbhGEK3f (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 5 Jul 2021 06:29:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625480818;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Hn8pfomgO0pK1pLJQsbkCNtKcqXVx3AR2wNfde8uERo=;
        b=C4E+1I79oIHQ/ov7BgHO4/twLOoCMnJQGxqBG0Z/awJBABXD+2Kc4+T2jF7Za7fYgjo906
        AuwMc51w8zY5/RUT3wgD5/T8lZR30x2rjGdscz9eI32hMGjvCepbtAyhqlkrgi0dLc+lpj
        M7UBqCTKBlF4ZjJb8mdblzii4r4Z7gY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-466-G6fjmY5vPFqhIotmfQpqyA-1; Mon, 05 Jul 2021 06:26:56 -0400
X-MC-Unique: G6fjmY5vPFqhIotmfQpqyA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A6CF7100B3AC;
        Mon,  5 Jul 2021 10:26:55 +0000 (UTC)
Received: from localhost (ovpn-13-193.pek2.redhat.com [10.72.13.193])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C832217C5F;
        Mon,  5 Jul 2021 10:26:54 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>,
        =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
        Dan Schatzberg <schatzberg.dan@gmail.com>
Subject: [PATCH 6/6] loop: don't add worker into idle list
Date:   Mon,  5 Jul 2021 18:26:07 +0800
Message-Id: <20210705102607.127810-7-ming.lei@redhat.com>
In-Reply-To: <20210705102607.127810-1-ming.lei@redhat.com>
References: <20210705102607.127810-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We can retrieve any workers via xarray, so not add it into idle list.
Meantime reduce .lo_work_lock coverage, especially we don't need that
in IO path except for adding/deleting worker into xarray.

Also simplify code a bit.

Cc: Michal Koutný <mkoutny@suse.com>
Cc: Dan Schatzberg <schatzberg.dan@gmail.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/loop.c | 138 ++++++++++++++++++++++++++-----------------
 1 file changed, 84 insertions(+), 54 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 6e9725521330..146eaa03629b 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -920,10 +920,11 @@ static void loop_config_discard(struct loop_device *lo)
 struct loop_worker {
 	struct work_struct work;
 	struct list_head cmd_list;
-	struct list_head idle_list;
 	struct loop_device *lo;
 	struct cgroup_subsys_state *blkcg_css;
 	unsigned long last_ran_at;
+	spinlock_t lock;
+	refcount_t refcnt;
 };
 
 static void loop_workfn(struct work_struct *work);
@@ -941,13 +942,56 @@ static inline int queue_on_root_worker(struct cgroup_subsys_state *css)
 }
 #endif
 
+static struct loop_worker *loop_alloc_or_get_worker(struct loop_device *lo,
+		struct cgroup_subsys_state *blkcg_css)
+{
+	gfp_t gfp = GFP_NOWAIT | __GFP_NOWARN;
+	struct loop_worker *worker = kzalloc(sizeof(*worker), gfp);
+	struct loop_worker *worker_old;
+
+	if (!worker)
+		return NULL;
+
+	worker->blkcg_css = blkcg_css;
+	INIT_WORK(&worker->work, loop_workfn);
+	INIT_LIST_HEAD(&worker->cmd_list);
+	worker->lo = lo;
+	spin_lock_init(&worker->lock);
+	refcount_set(&worker->refcnt, 2);	/* INIT + INC */
+
+	spin_lock(&lo->lo_work_lock);
+	/* maybe someone is storing a new worker */
+	worker_old = xa_load(&lo->workers, blkcg_css->id);
+	if (!worker_old || !refcount_inc_not_zero(&worker_old->refcnt)) {
+		if (xa_err(xa_store(&lo->workers, blkcg_css->id, worker, gfp))) {
+			kfree(worker);
+			worker = NULL;
+		} else {
+			css_get(worker->blkcg_css);
+		}
+	} else {
+		kfree(worker);
+		worker = worker_old;
+	}
+	spin_unlock(&lo->lo_work_lock);
+
+	return worker;
+}
+
+static void loop_release_worker(struct loop_worker *worker)
+{
+	xa_erase(&worker->lo->workers, worker->blkcg_css->id);
+	css_put(worker->blkcg_css);
+	kfree(worker);
+}
+
 static void loop_queue_work(struct loop_device *lo, struct loop_cmd *cmd)
 {
 	struct loop_worker *worker = NULL;
 	struct work_struct *work;
 	struct list_head *cmd_list;
 	struct cgroup_subsys_state *blkcg_css = NULL;
-	gfp_t gfp = GFP_NOWAIT | __GFP_NOWARN;
+	spinlock_t	*lock;
 #ifdef CONFIG_BLK_CGROUP
 	struct request *rq = blk_mq_rq_from_pdu(cmd);
 
@@ -955,54 +999,38 @@ static void loop_queue_work(struct loop_device *lo, struct loop_cmd *cmd)
 		blkcg_css = &bio_blkcg(rq->bio)->css;
 #endif
 
-	spin_lock(&lo->lo_work_lock);
-
-	if (queue_on_root_worker(blkcg_css))
-		goto queue_work;
-
-	/* css->id is unique in each cgroup subsystem */
-	worker = xa_load(&lo->workers, blkcg_css->id);
-	if (worker)
-		goto queue_work;
-
-	worker = kzalloc(sizeof(*worker), gfp);
-	/*
-	 * In the event we cannot allocate a worker, just queue on the
-	 * rootcg worker and issue the I/O as the rootcg
-	 */
-	if (!worker)
-		goto queue_work;
+	if (!queue_on_root_worker(blkcg_css)) {
+		int ret = 0;
 
-	worker->blkcg_css = blkcg_css;
-	css_get(worker->blkcg_css);
-	INIT_WORK(&worker->work, loop_workfn);
-	INIT_LIST_HEAD(&worker->cmd_list);
-	INIT_LIST_HEAD(&worker->idle_list);
-	worker->lo = lo;
+		rcu_read_lock();
+		/* css->id is unique in each cgroup subsystem */
+		worker = xa_load(&lo->workers, blkcg_css->id);
+		if (worker)
+			ret = refcount_inc_not_zero(&worker->refcnt);
+		rcu_read_unlock();
 
-	if (xa_err(xa_store(&lo->workers, blkcg_css->id, worker, gfp))) {
-		kfree(worker);
-		worker = NULL;
+		if (!worker || !ret)
+			worker = loop_alloc_or_get_worker(lo, blkcg_css);
+		/*
+		 * In the event we cannot allocate a worker, just queue on the
+		 * rootcg worker and issue the I/O as the rootcg
+		 */
 	}
 
-queue_work:
 	if (worker) {
-		/*
-		 * We need to remove from the idle list here while
-		 * holding the lock so that the idle timer doesn't
-		 * free the worker
-		 */
-		if (!list_empty(&worker->idle_list))
-			list_del_init(&worker->idle_list);
 		work = &worker->work;
 		cmd_list = &worker->cmd_list;
+		lock = &worker->lock;
 	} else {
 		work = &lo->rootcg_work;
 		cmd_list = &lo->rootcg_cmd_list;
+		lock = &lo->lo_work_lock;
 	}
+
+	spin_lock(lock);
 	list_add_tail(&cmd->list_entry, cmd_list);
+	spin_unlock(lock);
 	queue_work(lo->workqueue, work);
-	spin_unlock(&lo->lo_work_lock);
 }
 
 static void loop_update_rotational(struct loop_device *lo)
@@ -1131,20 +1159,18 @@ static void loop_set_timer(struct loop_device *lo)
 
 static void __loop_free_idle_workers(struct loop_device *lo, bool force)
 {
-	struct loop_worker *pos, *worker;
+	struct loop_worker *worker;
+	unsigned long id;
 
 	spin_lock(&lo->lo_work_lock);
-	list_for_each_entry_safe(worker, pos, &lo->idle_worker_list,
-				idle_list) {
+	xa_for_each(&lo->workers, id, worker) {
 		if (!force && time_is_after_jiffies(worker->last_ran_at +
 						LOOP_IDLE_WORKER_TIMEOUT))
 			break;
-		list_del(&worker->idle_list);
-		xa_erase(&lo->workers, worker->blkcg_css->id);
-		css_put(worker->blkcg_css);
-		kfree(worker);
+		if (refcount_dec_and_test(&worker->refcnt))
+			loop_release_worker(worker);
 	}
-	if (!list_empty(&lo->idle_worker_list))
+	if (!xa_empty(&lo->workers))
 		loop_set_timer(lo);
 	spin_unlock(&lo->lo_work_lock);
 }
@@ -2148,27 +2174,29 @@ static void loop_handle_cmd(struct loop_cmd *cmd)
 }
 
 static void loop_process_work(struct loop_worker *worker,
-			struct list_head *cmd_list, struct loop_device *lo)
+			struct list_head *cmd_list, spinlock_t *lock)
 {
 	int orig_flags = current->flags;
 	struct loop_cmd *cmd;
 	LIST_HEAD(list);
+	int cnt = 0;
 
 	current->flags |= PF_LOCAL_THROTTLE | PF_MEMALLOC_NOIO;
 
-	spin_lock(&lo->lo_work_lock);
+	spin_lock(lock);
  again:
 	list_splice_init(cmd_list, &list);
-	spin_unlock(&lo->lo_work_lock);
+	spin_unlock(lock);
 
 	while (!list_empty(&list)) {
 		cmd = list_first_entry(&list, struct loop_cmd, list_entry);
 		list_del_init(&cmd->list_entry);
 
 		loop_handle_cmd(cmd);
+		cnt++;
 	}
 
-	spin_lock(&lo->lo_work_lock);
+	spin_lock(lock);
 	if (!list_empty(cmd_list))
 		goto again;
 
@@ -2179,11 +2207,13 @@ static void loop_process_work(struct loop_worker *worker,
 	 */
 	if (worker && !work_pending(&worker->work)) {
 		worker->last_ran_at = jiffies;
-		list_add_tail(&worker->idle_list, &lo->idle_worker_list);
-		loop_set_timer(lo);
+		loop_set_timer(worker->lo);
 	}
-	spin_unlock(&lo->lo_work_lock);
+	spin_unlock(lock);
 	current->flags = orig_flags;
+
+	if (worker && refcount_sub_and_test(cnt, &worker->refcnt))
+		loop_release_worker(worker);
 }
 
 static void loop_workfn(struct work_struct *work)
@@ -2202,7 +2232,7 @@ static void loop_workfn(struct work_struct *work)
 		old_memcg = set_active_memcg(
 				mem_cgroup_from_css(memcg_css));
 
-	loop_process_work(worker, &worker->cmd_list, worker->lo);
+	loop_process_work(worker, &worker->cmd_list, &worker->lock);
 
 	kthread_associate_blkcg(NULL);
 	if (memcg_css) {
@@ -2215,7 +2245,7 @@ static void loop_rootcg_workfn(struct work_struct *work)
 {
 	struct loop_device *lo =
 		container_of(work, struct loop_device, rootcg_work);
-	loop_process_work(NULL, &lo->rootcg_cmd_list, lo);
+	loop_process_work(NULL, &lo->rootcg_cmd_list, &lo->lo_work_lock);
 }
 
 static const struct blk_mq_ops loop_mq_ops = {
-- 
2.31.1

