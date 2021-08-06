Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC89EC4320E
	for <linux-block@archiver.kernel.org>; Fri,  6 Aug 2021 08:04:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B173D611C9
	for <linux-block@archiver.kernel.org>; Fri,  6 Aug 2021 08:04:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243121AbhHFIEj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 6 Aug 2021 04:04:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41001 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243337AbhHFIEf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 6 Aug 2021 04:04:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628237059;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=axcrOTPspsxc//4CJB46sRE7onovD3PWDix9en5iZbE=;
        b=CCdBQ/FXg/oa0YMFhZ9rCmxKw+4q+5V0crTbjbpC7lKf05kWqlLKkO8+CfiLyI8NwH/+fp
        ciaDebcvpXowJNh7WWS+mROgJojb6bGpjNzBnjtzclQHFHRtmcCuy+/xk8wGG2lE2uajoA
        eQ65BoW8Hb/bjrha3lB43Kl+LHJqTeU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-203-FFcKHg5QOZuQMCFHzdnLew-1; Fri, 06 Aug 2021 04:04:18 -0400
X-MC-Unique: FFcKHg5QOZuQMCFHzdnLew-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D6D21107ACF5;
        Fri,  6 Aug 2021 08:04:16 +0000 (UTC)
Received: from localhost (ovpn-13-152.pek2.redhat.com [10.72.13.152])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8F62619C44;
        Fri,  6 Aug 2021 08:04:12 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Dan Schatzberg <schatzberg.dan@gmail.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V4 7/7] loop: don't add worker into idle list
Date:   Fri,  6 Aug 2021 16:03:02 +0800
Message-Id: <20210806080302.298297-8-ming.lei@redhat.com>
In-Reply-To: <20210806080302.298297-1-ming.lei@redhat.com>
References: <20210806080302.298297-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We can retrieve any workers via xarray, so not add it into idle list.
Meantime reduce .lo_work_lock coverage, especially we don't need that
in IO path except for adding/deleting worker into xarray.

Also replace .last_ran_at with .reclaim_time, which is set when adding
loop command into worker->cmd_list. Meantime reclaim the worker when
the worker is expired and no any pending commands.

Acked-by: Dan Schatzberg <schatzberg.dan@gmail.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/loop.c | 178 ++++++++++++++++++++++++++-----------------
 1 file changed, 108 insertions(+), 70 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index f77fa9e5eb49..93a3350ac175 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -973,10 +973,11 @@ static void loop_config_discard(struct loop_device *lo)
 struct loop_worker {
 	struct work_struct work;
 	struct list_head cmd_list;
-	struct list_head idle_list;
 	struct loop_device *lo;
 	struct cgroup_subsys_state *blkcg_css;
-	unsigned long last_ran_at;
+	unsigned long reclaim_time;
+	spinlock_t lock;
+	refcount_t refcnt;
 };
 
 static void loop_workfn(struct work_struct *work);
@@ -1024,63 +1025,95 @@ static struct cgroup_subsys_state *loop_rq_get_memcg_css(
 	return NULL;
 }
 
-static void loop_queue_work(struct loop_device *lo, struct loop_cmd *cmd)
+static struct loop_worker *loop_alloc_or_get_worker(struct loop_device *lo,
+		struct cgroup_subsys_state *blkcg_css)
 {
-	struct loop_worker *worker = NULL;
-	struct work_struct *work;
-	struct list_head *cmd_list;
-	struct cgroup_subsys_state *blkcg_css = loop_rq_blkcg_css(cmd);
 	gfp_t gfp = GFP_NOWAIT | __GFP_NOWARN;
+	struct loop_worker *worker = kzalloc(sizeof(*worker), gfp);
+	struct loop_worker *worker_old;
 
-	spin_lock(&lo->lo_work_lock);
-
-	if (queue_on_root_worker(blkcg_css))
-		goto queue_work;
-
-	/* css->id is unique in each cgroup subsystem */
-	worker = xa_load(&lo->workers, loop_blkcg_css_id(blkcg_css));
-	if (worker)
-		goto queue_work;
-
-	worker = kzalloc(sizeof(*worker), gfp);
-	/*
-	 * In the event we cannot allocate a worker, just queue on the
-	 * rootcg worker and issue the I/O as the rootcg
-	 */
 	if (!worker)
-		goto queue_work;
+		return NULL;
 
 	worker->blkcg_css = blkcg_css;
-	css_get(worker->blkcg_css);
 	INIT_WORK(&worker->work, loop_workfn);
 	INIT_LIST_HEAD(&worker->cmd_list);
-	INIT_LIST_HEAD(&worker->idle_list);
 	worker->lo = lo;
+	spin_lock_init(&worker->lock);
+	refcount_set(&worker->refcnt, 2);	/* INIT + INC */
 
-	if (xa_err(xa_store(&lo->workers, loop_blkcg_css_id(blkcg_css),
-			    worker, gfp))) {
+	spin_lock(&lo->lo_work_lock);
+	/* maybe someone is storing a new worker */
+	worker_old = xa_load(&lo->workers, loop_blkcg_css_id(blkcg_css));
+	if (!worker_old || !refcount_inc_not_zero(&worker_old->refcnt)) {
+		if (xa_err(xa_store(&lo->workers,
+				    loop_blkcg_css_id(blkcg_css),
+				    worker, gfp))) {
+			kfree(worker);
+			worker = NULL;
+		} else {
+			if (!work_pending(&lo->idle_work.work))
+				schedule_delayed_work(&lo->idle_work,
+						LOOP_IDLE_WORKER_TIMEOUT);
+			css_get(worker->blkcg_css);
+		}
+	} else {
 		kfree(worker);
-		worker = NULL;
+		worker = worker_old;
 	}
+	spin_unlock(&lo->lo_work_lock);
 
-queue_work:
-	if (worker) {
+	return worker;
+}
+
+static void loop_release_worker(struct loop_worker *worker)
+{
+	css_put(worker->blkcg_css);
+	kfree_rcu(worker);
+}
+
+static void loop_queue_work(struct loop_device *lo, struct loop_cmd *cmd)
+{
+	struct loop_worker *worker = NULL;
+	struct work_struct *work;
+	struct list_head *cmd_list;
+	struct cgroup_subsys_state *blkcg_css = loop_rq_blkcg_css(cmd);
+	spinlock_t	*lock;
+
+	if (!queue_on_root_worker(blkcg_css)) {
+		int ret = 0;
+
+		rcu_read_lock();
+		/* css->id is unique in each cgroup subsystem */
+		worker = xa_load(&lo->workers, loop_blkcg_css_id(blkcg_css));
+		if (worker)
+			ret = refcount_inc_not_zero(&worker->refcnt);
+		rcu_read_unlock();
+
+		if (!worker || !ret)
+			worker = loop_alloc_or_get_worker(lo, blkcg_css);
 		/*
-		 * We need to remove from the idle list here while
-		 * holding the lock so that the idle timer doesn't
-		 * free the worker
+		 * In the event we cannot allocate a worker, just queue on the
+		 * rootcg worker and issue the I/O as the rootcg
 		 */
-		if (!list_empty(&worker->idle_list))
-			list_del_init(&worker->idle_list);
+	}
+
+	if (worker) {
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
+	if (worker)
+		worker->reclaim_time = jiffies + LOOP_IDLE_WORKER_TIMEOUT;
+	spin_unlock(lock);
 	queue_work(lo->workqueue, work);
-	spin_unlock(&lo->lo_work_lock);
 }
 
 static void loop_update_rotational(struct loop_device *lo)
@@ -1202,28 +1235,39 @@ loop_set_status_from_info(struct loop_device *lo,
 	return 0;
 }
 
-static void loop_set_timer(struct loop_device *lo)
+static bool loop_need_reclaim_worker(struct loop_worker *worker)
 {
-	schedule_delayed_work(&lo->idle_work, LOOP_IDLE_WORKER_TIMEOUT);
+	bool reclaim;
+
+	spin_lock(&worker->lock);
+	if (list_empty(&worker->cmd_list) &&
+			time_is_before_jiffies(worker->reclaim_time))
+		reclaim = true;
+	else
+		reclaim = false;
+	spin_unlock(&worker->lock);
+
+	return reclaim;
 }
 
 static void __loop_free_idle_workers(struct loop_device *lo, bool force)
 {
-	struct loop_worker *pos, *worker;
+	struct loop_worker *worker;
+	unsigned long id;
 
 	spin_lock(&lo->lo_work_lock);
-	list_for_each_entry_safe(worker, pos, &lo->idle_worker_list,
-				idle_list) {
-		if (!force && time_is_after_jiffies(worker->last_ran_at +
-						LOOP_IDLE_WORKER_TIMEOUT))
-			break;
-		list_del(&worker->idle_list);
-		xa_erase(&lo->workers, loop_blkcg_css_id(worker->blkcg_css));
-		css_put(worker->blkcg_css);
-		kfree(worker);
-	}
-	if (!list_empty(&lo->idle_worker_list))
-		loop_set_timer(lo);
+	xa_for_each(&lo->workers, id, worker) {
+		if (!force && !loop_need_reclaim_worker(worker))
+			continue;
+
+		xa_erase(&worker->lo->workers,
+			 loop_blkcg_css_id(worker->blkcg_css));
+		if (refcount_dec_and_test(&worker->refcnt))
+			loop_release_worker(worker);
+	}
+	if (!xa_empty(&lo->workers))
+		schedule_delayed_work(&lo->idle_work,
+				LOOP_IDLE_WORKER_TIMEOUT);
 	spin_unlock(&lo->lo_work_lock);
 }
 
@@ -2235,42 +2279,36 @@ static void loop_handle_cmd(struct loop_cmd *cmd)
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
-
-	/*
-	 * We only add to the idle list if there are no pending cmds
-	 * *and* the worker will not run again which ensures that it
-	 * is safe to free any worker on the idle list
-	 */
-	if (worker && !work_pending(&worker->work)) {
-		worker->last_ran_at = jiffies;
-		list_add_tail(&worker->idle_list, &lo->idle_worker_list);
-		loop_set_timer(lo);
-	}
-	spin_unlock(&lo->lo_work_lock);
+	spin_unlock(lock);
 	current->flags = orig_flags;
+
+	if (worker && refcount_sub_and_test(cnt, &worker->refcnt))
+		loop_release_worker(worker);
 }
 
 static void loop_workfn(struct work_struct *work)
@@ -2285,11 +2323,11 @@ static void loop_workfn(struct work_struct *work)
 	if (memcg_css) {
 		old_memcg = set_active_memcg(
 				mem_cgroup_from_css(memcg_css));
-		loop_process_work(worker, &worker->cmd_list, worker->lo);
+		loop_process_work(worker, &worker->cmd_list, &worker->lock);
 		set_active_memcg(old_memcg);
 		css_put(memcg_css);
 	} else {
-		loop_process_work(worker, &worker->cmd_list, worker->lo);
+		loop_process_work(worker, &worker->cmd_list, &worker->lock);
 	}
 	kthread_associate_blkcg(NULL);
 }
@@ -2298,7 +2336,7 @@ static void loop_rootcg_workfn(struct work_struct *work)
 {
 	struct loop_device *lo =
 		container_of(work, struct loop_device, rootcg_work);
-	loop_process_work(NULL, &lo->rootcg_cmd_list, lo);
+	loop_process_work(NULL, &lo->rootcg_cmd_list, &lo->lo_work_lock);
 }
 
 static const struct blk_mq_ops loop_mq_ops = {
-- 
2.31.1

