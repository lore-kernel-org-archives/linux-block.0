Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9748C07E96
	for <linux-block@archiver.kernel.org>; Wed,  7 Jul 2021 03:19:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C26CA61C99
	for <linux-block@archiver.kernel.org>; Wed,  7 Jul 2021 03:19:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbhGGDWL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 6 Jul 2021 23:22:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34534 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229989AbhGGDWK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 6 Jul 2021 23:22:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625627970;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BsHne6gAY0F55fynmE1bp2vAH6rhT09nZuEZZRKRf8I=;
        b=TTVKmVEq9nRr5+XRhVrAmE3qWh8U3ANuWjVEUvogz1pZWs0V5KomGVqphxPuzqBnBwEWqh
        cOJ3sBgMShiPSoX4aNfoXjvOkQGREJMevC+nH8rJAZ/mGbewuYD+98NR6mq10hzupER4vb
        v228JYgXWnaAORKBAt7LBUI2jfnVyJY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-21-aWbUtYrYOUGHGwlOlqv-jw-1; Tue, 06 Jul 2021 23:19:27 -0400
X-MC-Unique: aWbUtYrYOUGHGwlOlqv-jw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4D43A100C661;
        Wed,  7 Jul 2021 03:19:26 +0000 (UTC)
Received: from T590 (ovpn-12-27.pek2.redhat.com [10.72.12.27])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 725DD10016F4;
        Wed,  7 Jul 2021 03:19:19 +0000 (UTC)
Date:   Wed, 7 Jul 2021 11:19:14 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Dan Schatzberg <schatzberg.dan@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Subject: Re: [PATCH 6/6] loop: don't add worker into idle list
Message-ID: <YOUdMjAzEw6JQjKG@T590>
References: <20210705102607.127810-1-ming.lei@redhat.com>
 <20210705102607.127810-7-ming.lei@redhat.com>
 <YORg2KYF7X1ZYJPG@dschatzberg-fedora-PC0Y6AEN>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YORg2KYF7X1ZYJPG@dschatzberg-fedora-PC0Y6AEN>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jul 06, 2021 at 09:55:36AM -0400, Dan Schatzberg wrote:
> On Mon, Jul 05, 2021 at 06:26:07PM +0800, Ming Lei wrote:
> > We can retrieve any workers via xarray, so not add it into idle list.
> > Meantime reduce .lo_work_lock coverage, especially we don't need that
> > in IO path except for adding/deleting worker into xarray.
> > 
> > Also simplify code a bit.
> > 
> > Cc: Michal Koutný <mkoutny@suse.com>
> > Cc: Dan Schatzberg <schatzberg.dan@gmail.com>
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >  drivers/block/loop.c | 138 ++++++++++++++++++++++++++-----------------
> >  1 file changed, 84 insertions(+), 54 deletions(-)
> > 
> > diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> > index 6e9725521330..146eaa03629b 100644
> > --- a/drivers/block/loop.c
> > +++ b/drivers/block/loop.c
> > @@ -920,10 +920,11 @@ static void loop_config_discard(struct loop_device *lo)
> >  struct loop_worker {
> >  	struct work_struct work;
> >  	struct list_head cmd_list;
> > -	struct list_head idle_list;
> >  	struct loop_device *lo;
> >  	struct cgroup_subsys_state *blkcg_css;
> >  	unsigned long last_ran_at;
> > +	spinlock_t lock;
> > +	refcount_t refcnt;
> >  };
> >  
> >  static void loop_workfn(struct work_struct *work);
> > @@ -941,13 +942,56 @@ static inline int queue_on_root_worker(struct cgroup_subsys_state *css)
> >  }
> >  #endif
> >  
> > +static struct loop_worker *loop_alloc_or_get_worker(struct loop_device *lo,
> > +		struct cgroup_subsys_state *blkcg_css)
> > +{
> > +	gfp_t gfp = GFP_NOWAIT | __GFP_NOWARN;
> > +	struct loop_worker *worker = kzalloc(sizeof(*worker), gfp);
> > +	struct loop_worker *worker_old;
> > +
> > +	if (!worker)
> > +		return NULL;
> > +
> > +	worker->blkcg_css = blkcg_css;
> > +	INIT_WORK(&worker->work, loop_workfn);
> > +	INIT_LIST_HEAD(&worker->cmd_list);
> > +	worker->lo = lo;
> > +	spin_lock_init(&worker->lock);
> > +	refcount_set(&worker->refcnt, 2);	/* INIT + INC */
> 
> Can you elaborate on the reference counting a bit more here? I notice
> you have a reference per loop_cmd, but there are a couple extra
> refcounts that aren't obvious to me. Having a comment describing it
> might be useful.

One reference is for INIT, another is for INC, so initialized as 2.

The counter pair of INIT reference is refcount_dec_and_test()
in __loop_free_idle_workers(), and it is per-worker.

The counter pair of INC reference is refcount_sub_and_test() in
loop_process_work(), and it is per-cmd.

> 
> > +
> > +	spin_lock(&lo->lo_work_lock);
> > +	/* maybe someone is storing a new worker */
> > +	worker_old = xa_load(&lo->workers, blkcg_css->id);
> > +	if (!worker_old || !refcount_inc_not_zero(&worker_old->refcnt)) {
> 
> I gather you increment the refcount here under lo_work_lock to ensure
> the worker isn't destroyed before queueing the cmd on it.

Right.

> 
> > +		if (xa_err(xa_store(&lo->workers, blkcg_css->id, worker, gfp))) {
> > +			kfree(worker);
> > +			worker = NULL;
> > +		} else {
> > +			css_get(worker->blkcg_css);
> > +		}
> > +	} else {
> > +		kfree(worker);
> > +		worker = worker_old;
> > +	}
> > +	spin_unlock(&lo->lo_work_lock);
> > +
> > +	return worker;
> > +}
> > +
> > +static void loop_release_worker(struct loop_worker *worker)
> > +{
> > +	xa_erase(&worker->lo->workers, worker->blkcg_css->id);
> > +	css_put(worker->blkcg_css);
> > +	kfree(worker);
> > +}
> > +
> >  static void loop_queue_work(struct loop_device *lo, struct loop_cmd *cmd)
> >  {
> >  	struct loop_worker *worker = NULL;
> >  	struct work_struct *work;
> >  	struct list_head *cmd_list;
> >  	struct cgroup_subsys_state *blkcg_css = NULL;
> > -	gfp_t gfp = GFP_NOWAIT | __GFP_NOWARN;
> > +	spinlock_t	*lock;
> >  #ifdef CONFIG_BLK_CGROUP
> >  	struct request *rq = blk_mq_rq_from_pdu(cmd);
> >  
> > @@ -955,54 +999,38 @@ static void loop_queue_work(struct loop_device *lo, struct loop_cmd *cmd)
> >  		blkcg_css = &bio_blkcg(rq->bio)->css;
> >  #endif
> >  
> > -	spin_lock(&lo->lo_work_lock);
> > -
> > -	if (queue_on_root_worker(blkcg_css))
> > -		goto queue_work;
> > -
> > -	/* css->id is unique in each cgroup subsystem */
> > -	worker = xa_load(&lo->workers, blkcg_css->id);
> > -	if (worker)
> > -		goto queue_work;
> > -
> > -	worker = kzalloc(sizeof(*worker), gfp);
> > -	/*
> > -	 * In the event we cannot allocate a worker, just queue on the
> > -	 * rootcg worker and issue the I/O as the rootcg
> > -	 */
> > -	if (!worker)
> > -		goto queue_work;
> > +	if (!queue_on_root_worker(blkcg_css)) {
> > +		int ret = 0;
> >  
> > -	worker->blkcg_css = blkcg_css;
> > -	css_get(worker->blkcg_css);
> > -	INIT_WORK(&worker->work, loop_workfn);
> > -	INIT_LIST_HEAD(&worker->cmd_list);
> > -	INIT_LIST_HEAD(&worker->idle_list);
> > -	worker->lo = lo;
> > +		rcu_read_lock();
> > +		/* css->id is unique in each cgroup subsystem */
> > +		worker = xa_load(&lo->workers, blkcg_css->id);
> > +		if (worker)
> > +			ret = refcount_inc_not_zero(&worker->refcnt);
> > +		rcu_read_unlock();
> 
> I don't follow the refcount decrement here. Also, what's the purpose
> of the rcu critical section here?

xa_load() requires rcu readlock, and the rcu can guarantee that the
'worker' won't be released when grabbing its reference.

> 
> >  
> > -	if (xa_err(xa_store(&lo->workers, blkcg_css->id, worker, gfp))) {
> > -		kfree(worker);
> > -		worker = NULL;
> > +		if (!worker || !ret)
> > +			worker = loop_alloc_or_get_worker(lo, blkcg_css);
> > +		/*
> > +		 * In the event we cannot allocate a worker, just queue on the
> > +		 * rootcg worker and issue the I/O as the rootcg
> > +		 */
> >  	}
> >  
> > -queue_work:
> >  	if (worker) {
> > -		/*
> > -		 * We need to remove from the idle list here while
> > -		 * holding the lock so that the idle timer doesn't
> > -		 * free the worker
> > -		 */
> > -		if (!list_empty(&worker->idle_list))
> > -			list_del_init(&worker->idle_list);
> >  		work = &worker->work;
> >  		cmd_list = &worker->cmd_list;
> > +		lock = &worker->lock;
> >  	} else {
> >  		work = &lo->rootcg_work;
> >  		cmd_list = &lo->rootcg_cmd_list;
> > +		lock = &lo->lo_work_lock;
> 
> Is lo_work_lock special here or is it just because the root "worker"
> lacks a lock itself? I wonder if a separate spinlock is more clear.

'->rootcg_cmd_list' is one per-loop-device list, so it needs one
per-loop-device lock. Yeah, in theory, we can add one lock just for
protecting the list, but it is fine to reuse it since the only extra
use is to reclaim worker which is definitely in slow path, so no
necessary to add a new one, IMO.

> 
> >  	}
> > +
> > +	spin_lock(lock);
> >  	list_add_tail(&cmd->list_entry, cmd_list);
> > +	spin_unlock(lock);
> >  	queue_work(lo->workqueue, work);
> > -	spin_unlock(&lo->lo_work_lock);
> >  }
> >  
> >  static void loop_update_rotational(struct loop_device *lo)
> > @@ -1131,20 +1159,18 @@ static void loop_set_timer(struct loop_device *lo)
> >  
> >  static void __loop_free_idle_workers(struct loop_device *lo, bool force)
> >  {
> > -	struct loop_worker *pos, *worker;
> > +	struct loop_worker *worker;
> > +	unsigned long id;
> >  
> >  	spin_lock(&lo->lo_work_lock);
> > -	list_for_each_entry_safe(worker, pos, &lo->idle_worker_list,
> > -				idle_list) {
> > +	xa_for_each(&lo->workers, id, worker) {
> >  		if (!force && time_is_after_jiffies(worker->last_ran_at +
> >  						LOOP_IDLE_WORKER_TIMEOUT))
> >  			break;
> > -		list_del(&worker->idle_list);
> > -		xa_erase(&lo->workers, worker->blkcg_css->id);
> > -		css_put(worker->blkcg_css);
> > -		kfree(worker);
> > +		if (refcount_dec_and_test(&worker->refcnt))
> > +			loop_release_worker(worker);
> 
> This one is puzzling to me. Can't you hit this refcount decrement
> superfluously each time the loop timer fires?

Not sure I get your point.

As I mentioned above, this one is the counter pair of INIT reference,
but one new lo_cmd may just grab it when queueing rq before erasing the
worker from xarray, so we can't release worker here until the command is
completed.

> 
> >  	}
> > -	if (!list_empty(&lo->idle_worker_list))
> > +	if (!xa_empty(&lo->workers))
> >  		loop_set_timer(lo);
> >  	spin_unlock(&lo->lo_work_lock);
> >  }
> > @@ -2148,27 +2174,29 @@ static void loop_handle_cmd(struct loop_cmd *cmd)
> >  }
> >  
> >  static void loop_process_work(struct loop_worker *worker,
> > -			struct list_head *cmd_list, struct loop_device *lo)
> > +			struct list_head *cmd_list, spinlock_t *lock)
> >  {
> >  	int orig_flags = current->flags;
> >  	struct loop_cmd *cmd;
> >  	LIST_HEAD(list);
> > +	int cnt = 0;
> >  
> >  	current->flags |= PF_LOCAL_THROTTLE | PF_MEMALLOC_NOIO;
> >  
> > -	spin_lock(&lo->lo_work_lock);
> > +	spin_lock(lock);
> >   again:
> >  	list_splice_init(cmd_list, &list);
> > -	spin_unlock(&lo->lo_work_lock);
> > +	spin_unlock(lock);
> >  
> >  	while (!list_empty(&list)) {
> >  		cmd = list_first_entry(&list, struct loop_cmd, list_entry);
> >  		list_del_init(&cmd->list_entry);
> >  
> >  		loop_handle_cmd(cmd);
> > +		cnt++;
> >  	}
> >  
> > -	spin_lock(&lo->lo_work_lock);
> > +	spin_lock(lock);
> >  	if (!list_empty(cmd_list))
> >  		goto again;
> >  
> > @@ -2179,11 +2207,13 @@ static void loop_process_work(struct loop_worker *worker,
> >  	 */
> >  	if (worker && !work_pending(&worker->work)) {
> >  		worker->last_ran_at = jiffies;
> > -		list_add_tail(&worker->idle_list, &lo->idle_worker_list);
> > -		loop_set_timer(lo);
> > +		loop_set_timer(worker->lo);
> >  	}
> > -	spin_unlock(&lo->lo_work_lock);
> > +	spin_unlock(lock);
> >  	current->flags = orig_flags;
> > +
> > +	if (worker && refcount_sub_and_test(cnt, &worker->refcnt))
> > +		loop_release_worker(worker);
> >  }
> >  
> >  static void loop_workfn(struct work_struct *work)
> > @@ -2202,7 +2232,7 @@ static void loop_workfn(struct work_struct *work)
> >  		old_memcg = set_active_memcg(
> >  				mem_cgroup_from_css(memcg_css));
> >  
> > -	loop_process_work(worker, &worker->cmd_list, worker->lo);
> > +	loop_process_work(worker, &worker->cmd_list, &worker->lock);
> >  
> >  	kthread_associate_blkcg(NULL);
> >  	if (memcg_css) {
> > @@ -2215,7 +2245,7 @@ static void loop_rootcg_workfn(struct work_struct *work)
> >  {
> >  	struct loop_device *lo =
> >  		container_of(work, struct loop_device, rootcg_work);
> > -	loop_process_work(NULL, &lo->rootcg_cmd_list, lo);
> > +	loop_process_work(NULL, &lo->rootcg_cmd_list, &lo->lo_work_lock);
> >  }
> >  
> >  static const struct blk_mq_ops loop_mq_ops = {
> > -- 
> > 2.31.1
> > 
> 
> The rest of this patch series looks great. Feel free to add my
> Acked-by to the others.

Thanks for your review!


Thanks,
Ming

