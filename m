Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11787C4338F
	for <linux-block@archiver.kernel.org>; Fri, 30 Jul 2021 16:52:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDD756054E
	for <linux-block@archiver.kernel.org>; Fri, 30 Jul 2021 16:52:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbhG3QxA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Jul 2021 12:53:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbhG3QxA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Jul 2021 12:53:00 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AD22C06175F;
        Fri, 30 Jul 2021 09:52:55 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id a19so6865143qtx.1;
        Fri, 30 Jul 2021 09:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gjkve8bUiatta8OufkYLnqL7fS603o77qgIPZx9ORHY=;
        b=jrg5lZYhtyScc5c17GnVQApwPUwhWswcA8Or5GXT9D9aC7bNyNgiVx90E/eVgb+YRK
         qF2Unri9hze6vigkNyh63mJixoEj/qrzRrh4U1iix/IHoVX3Eewzrfc8geCG6NMUfqQc
         D2XG1ndTGtNE8jPTivPP1Kx8Ac+00Ukm0YUcBvGKiCq9w/cuq/ZsmXr8ZzfuBbEj9SVv
         NQBPE0IPXyQDStr0pwTULsAazD+FB9nfYTAroJJgeWF6U40k3AJe6S41zK2w6lgLHoaS
         tnZThp3R6RtGKAHbrR49rXhNns3G2qpWaMRvd3jDpyHvld+v+RG7dLwQBYK8Q2EIRJYS
         3M/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gjkve8bUiatta8OufkYLnqL7fS603o77qgIPZx9ORHY=;
        b=DCufRmADt2hUBafmt6kG4CyG2wyt8hFX+qj+hp6O0ElWS6gz0Z7hQSw6sPLb1A7qFw
         MEaTZEjWt2E/Bu2vLwGIUbBFLsdR1DDOEf4gU3OoO2tHFQn4N54mzZ6a1ETawJGPY9Cb
         tfhlT5ZxbfMSsNMaHD9kGnVAf6CCIedxQ5Nwb1+YcxvVDWRK3Ts5BClYHbadbOQvktnN
         JzEYncs8tRFyy6teOS+5hyGGhvTClj6WE00fDL+rSnI2VeaSONhOO99TBt2tNYa5GvZn
         RS4snRpWx9Qg3lIuCG3XGG4Ga577Du+kSOXKSioCglvzoCF/u2ULmAWJrB16MqA+a1SU
         R5fA==
X-Gm-Message-State: AOAM530oUlFgjqbUs/BcHVAj7RCN5gvvt7xKyEFt0lGlhRH1EHYsy8K+
        eDHihi3uhzll11zGakUGivs=
X-Google-Smtp-Source: ABdhPJyHRr4EvZW88CqJeNk5UMg01JenBt1t0BVKYVJhASiF6G/ZyEzGFO/eLS5opVE2HQDy+B5wxw==
X-Received: by 2002:ac8:5bca:: with SMTP id b10mr3031646qtb.278.1627663974436;
        Fri, 30 Jul 2021 09:52:54 -0700 (PDT)
Received: from dschatzberg-fedora-PC0Y6AEN.dhcp.thefacebook.com ([2620:10d:c091:480::1:9360])
        by smtp.gmail.com with ESMTPSA id f13sm1162738qkk.29.2021.07.30.09.52.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 09:52:53 -0700 (PDT)
Date:   Fri, 30 Jul 2021 12:52:51 -0400
From:   Dan Schatzberg <schatzberg.dan@gmail.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V2 7/7] loop: don't add worker into idle list
Message-ID: <YQQuY+d+/Bh9l/IV@dschatzberg-fedora-PC0Y6AEN.dhcp.thefacebook.com>
References: <20210728081638.1500953-1-ming.lei@redhat.com>
 <20210728081638.1500953-8-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210728081638.1500953-8-ming.lei@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jul 28, 2021 at 04:16:38PM +0800, Ming Lei wrote:
> We can retrieve any workers via xarray, so not add it into idle list.
> Meantime reduce .lo_work_lock coverage, especially we don't need that
> in IO path except for adding/deleting worker into xarray.
> 
> Also replace .last_ran_at with .reclaim_time, which is set when adding
> loop command into worker->cmd_list. Meantime reclaim the worker when
> the worker is expired and no any pending commands.
> 
> Cc: Dan Schatzberg <schatzberg.dan@gmail.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  drivers/block/loop.c | 172 ++++++++++++++++++++++++++-----------------
>  1 file changed, 104 insertions(+), 68 deletions(-)
> 
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index 9b22e5469ed3..e4b292b2d8f4 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -920,10 +920,11 @@ static void loop_config_discard(struct loop_device *lo)
>  struct loop_worker {
>  	struct work_struct work;
>  	struct list_head cmd_list;
> -	struct list_head idle_list;
>  	struct loop_device *lo;
>  	struct cgroup_subsys_state *blkcg_css;
> -	unsigned long last_ran_at;
> +	unsigned long reclaim_time;
> +	spinlock_t lock;
> +	refcount_t refcnt;
>  };
>  
>  static void loop_workfn(struct work_struct *work);
> @@ -963,62 +964,93 @@ static struct cgroup_subsys_state *loop_rq_get_memcg_css(
>  	return NULL;
>  }
>  
> -static void loop_queue_work(struct loop_device *lo, struct loop_cmd *cmd)
> +static struct loop_worker *loop_alloc_or_get_worker(struct loop_device *lo,
> +		struct cgroup_subsys_state *blkcg_css)
>  {
> -	struct loop_worker *worker = NULL;
> -	struct work_struct *work;
> -	struct list_head *cmd_list;
> -	struct cgroup_subsys_state *blkcg_css = loop_rq_blkcg_css(cmd);
>  	gfp_t gfp = GFP_NOWAIT | __GFP_NOWARN;
> +	struct loop_worker *worker = kzalloc(sizeof(*worker), gfp);
> +	struct loop_worker *worker_old;
>  
> -	spin_lock(&lo->lo_work_lock);
> -
> -	if (queue_on_root_worker(blkcg_css))
> -		goto queue_work;
> -
> -	/* css->id is unique in each cgroup subsystem */
> -	worker = xa_load(&lo->workers, blkcg_css->id);
> -	if (worker)
> -		goto queue_work;
> -
> -	worker = kzalloc(sizeof(*worker), gfp);
> -	/*
> -	 * In the event we cannot allocate a worker, just queue on the
> -	 * rootcg worker and issue the I/O as the rootcg
> -	 */
>  	if (!worker)
> -		goto queue_work;
> +		return NULL;
>  
>  	worker->blkcg_css = blkcg_css;
> -	css_get(worker->blkcg_css);
>  	INIT_WORK(&worker->work, loop_workfn);
>  	INIT_LIST_HEAD(&worker->cmd_list);
> -	INIT_LIST_HEAD(&worker->idle_list);
>  	worker->lo = lo;
> +	spin_lock_init(&worker->lock);
> +	refcount_set(&worker->refcnt, 2);	/* INIT + INC */
>  
> -	if (xa_err(xa_store(&lo->workers, blkcg_css->id, worker, gfp))) {
> +	spin_lock(&lo->lo_work_lock);
> +	/* maybe someone is storing a new worker */
> +	worker_old = xa_load(&lo->workers, blkcg_css->id);
> +	if (!worker_old || !refcount_inc_not_zero(&worker_old->refcnt)) {
> +		if (xa_err(xa_store(&lo->workers, blkcg_css->id, worker, gfp))) {
> +			kfree(worker);
> +			worker = NULL;
> +		} else {
> +			if (!work_pending(&lo->idle_work.work))
> +				schedule_delayed_work(&lo->idle_work,
> +						LOOP_IDLE_WORKER_TIMEOUT);
> +			css_get(worker->blkcg_css);
> +		}
> +	} else {
>  		kfree(worker);
> -		worker = NULL;
> +		worker = worker_old;
>  	}
> +	spin_unlock(&lo->lo_work_lock);
>  
> -queue_work:
> -	if (worker) {
> +	return worker;
> +}
> +
> +static void loop_release_worker(struct loop_worker *worker)
> +{
> +	css_put(worker->blkcg_css);
> +	kfree_rcu(worker);
> +}
> +
> +static void loop_queue_work(struct loop_device *lo, struct loop_cmd *cmd)
> +{
> +	struct loop_worker *worker = NULL;
> +	struct work_struct *work;
> +	struct list_head *cmd_list;
> +	struct cgroup_subsys_state *blkcg_css = loop_rq_blkcg_css(cmd);
> +	spinlock_t	*lock;
> +
> +	if (!queue_on_root_worker(blkcg_css)) {
> +		int ret = 0;
> +
> +		rcu_read_lock();
> +		/* css->id is unique in each cgroup subsystem */
> +		worker = xa_load(&lo->workers, blkcg_css->id);
> +		if (worker)
> +			ret = refcount_inc_not_zero(&worker->refcnt);
> +		rcu_read_unlock();
> +
> +		if (!worker || !ret)
> +			worker = loop_alloc_or_get_worker(lo, blkcg_css);
>  		/*
> -		 * We need to remove from the idle list here while
> -		 * holding the lock so that the idle timer doesn't
> -		 * free the worker
> +		 * In the event we cannot allocate a worker, just queue on the
> +		 * rootcg worker and issue the I/O as the rootcg
>  		 */
> -		if (!list_empty(&worker->idle_list))
> -			list_del_init(&worker->idle_list);
> +	}
> +
> +	if (worker) {
>  		work = &worker->work;
>  		cmd_list = &worker->cmd_list;
> +		lock = &worker->lock;
>  	} else {
>  		work = &lo->rootcg_work;
>  		cmd_list = &lo->rootcg_cmd_list;
> +		lock = &lo->lo_work_lock;
>  	}
> +
> +	spin_lock(lock);
>  	list_add_tail(&cmd->list_entry, cmd_list);
> +	if (worker)
> +		worker->reclaim_time = jiffies + LOOP_IDLE_WORKER_TIMEOUT;
> +	spin_unlock(lock);
>  	queue_work(lo->workqueue, work);
> -	spin_unlock(&lo->lo_work_lock);
>  }
>  
>  static void loop_update_rotational(struct loop_device *lo)
> @@ -1140,28 +1172,38 @@ loop_set_status_from_info(struct loop_device *lo,
>  	return 0;
>  }
>  
> -static void loop_set_timer(struct loop_device *lo)
> +static bool loop_need_reclaim_worker(struct loop_worker *worker)
>  {
> -	schedule_delayed_work(&lo->idle_work, LOOP_IDLE_WORKER_TIMEOUT);
> +	bool reclaim = false;

You don't need both this initialization and the else block below. I
think it's easier to read if you just remove one of them.

> +
> +	spin_lock(&worker->lock);
> +	if (list_empty(&worker->cmd_list) &&
> +			time_is_before_jiffies(worker->reclaim_time))
> +		reclaim = true;
> +	else
> +		reclaim = false;
> +	spin_unlock(&worker->lock);
> +
> +	return reclaim;
>  }
>  
>  static void __loop_free_idle_workers(struct loop_device *lo, bool force)
>  {
> -	struct loop_worker *pos, *worker;
> +	struct loop_worker *worker;
> +	unsigned long id;
>  
>  	spin_lock(&lo->lo_work_lock);
> -	list_for_each_entry_safe(worker, pos, &lo->idle_worker_list,
> -				idle_list) {
> -		if (!force && time_is_after_jiffies(worker->last_ran_at +
> -						LOOP_IDLE_WORKER_TIMEOUT))
> -			break;
> -		list_del(&worker->idle_list);
> -		xa_erase(&lo->workers, worker->blkcg_css->id);
> -		css_put(worker->blkcg_css);
> -		kfree(worker);
> +	xa_for_each(&lo->workers, id, worker) {
> +		if (!force && !loop_need_reclaim_worker(worker))
> +			continue;
> +
> +		xa_erase(&worker->lo->workers, worker->blkcg_css->id);
> +		if (refcount_dec_and_test(&worker->refcnt))
> +			loop_release_worker(worker);
>  	}
> -	if (!list_empty(&lo->idle_worker_list))
> -		loop_set_timer(lo);
> +	if (!xa_empty(&lo->workers))
> +		schedule_delayed_work(&lo->idle_work,
> +				LOOP_IDLE_WORKER_TIMEOUT);
>  	spin_unlock(&lo->lo_work_lock);
>  }
>  
> @@ -2162,42 +2204,36 @@ static void loop_handle_cmd(struct loop_cmd *cmd)
>  }
>  
>  static void loop_process_work(struct loop_worker *worker,
> -			struct list_head *cmd_list, struct loop_device *lo)
> +			struct list_head *cmd_list, spinlock_t *lock)
>  {
>  	int orig_flags = current->flags;
>  	struct loop_cmd *cmd;
>  	LIST_HEAD(list);
> +	int cnt = 0;
>  
>  	current->flags |= PF_LOCAL_THROTTLE | PF_MEMALLOC_NOIO;
>  
> -	spin_lock(&lo->lo_work_lock);
> +	spin_lock(lock);
>   again:
>  	list_splice_init(cmd_list, &list);
> -	spin_unlock(&lo->lo_work_lock);
> +	spin_unlock(lock);
>  
>  	while (!list_empty(&list)) {
>  		cmd = list_first_entry(&list, struct loop_cmd, list_entry);
>  		list_del_init(&cmd->list_entry);
>  
>  		loop_handle_cmd(cmd);
> +		cnt++;
>  	}
>  
> -	spin_lock(&lo->lo_work_lock);
> +	spin_lock(lock);
>  	if (!list_empty(cmd_list))
>  		goto again;
> -
> -	/*
> -	 * We only add to the idle list if there are no pending cmds
> -	 * *and* the worker will not run again which ensures that it
> -	 * is safe to free any worker on the idle list
> -	 */
> -	if (worker && !work_pending(&worker->work)) {
> -		worker->last_ran_at = jiffies;
> -		list_add_tail(&worker->idle_list, &lo->idle_worker_list);
> -		loop_set_timer(lo);
> -	}
> -	spin_unlock(&lo->lo_work_lock);
> +	spin_unlock(lock);
>  	current->flags = orig_flags;
> +
> +	if (worker && refcount_sub_and_test(cnt, &worker->refcnt))
> +		loop_release_worker(worker);
>  }
>  
>  static void loop_workfn(struct work_struct *work)
> @@ -2212,11 +2248,11 @@ static void loop_workfn(struct work_struct *work)
>  	if (memcg_css) {
>  		old_memcg = set_active_memcg(
>  				mem_cgroup_from_css(memcg_css));
> -		loop_process_work(worker, &worker->cmd_list, worker->lo);
> +		loop_process_work(worker, &worker->cmd_list, &worker->lock);
>  		set_active_memcg(old_memcg);
>  		css_put(memcg_css);
>  	} else {
> -		loop_process_work(worker, &worker->cmd_list, worker->lo);
> +		loop_process_work(worker, &worker->cmd_list, &worker->lock);
>  	}
>  	kthread_associate_blkcg(NULL);
>  }
> @@ -2225,7 +2261,7 @@ static void loop_rootcg_workfn(struct work_struct *work)
>  {
>  	struct loop_device *lo =
>  		container_of(work, struct loop_device, rootcg_work);
> -	loop_process_work(NULL, &lo->rootcg_cmd_list, lo);
> +	loop_process_work(NULL, &lo->rootcg_cmd_list, &lo->lo_work_lock);
>  }
>  
>  static const struct blk_mq_ops loop_mq_ops = {
> -- 
> 2.31.1
> 

This is all great.

Acked-by: Dan Schatzberg <schatzberg.dan@gmail.com>
