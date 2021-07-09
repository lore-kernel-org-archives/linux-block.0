Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8348C07E99
	for <linux-block@archiver.kernel.org>; Fri,  9 Jul 2021 13:47:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C701061380
	for <linux-block@archiver.kernel.org>; Fri,  9 Jul 2021 13:47:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231622AbhGINu3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 9 Jul 2021 09:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231572AbhGINu3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 9 Jul 2021 09:50:29 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A127DC0613DD
        for <linux-block@vger.kernel.org>; Fri,  9 Jul 2021 06:47:45 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id b18so9326490qkc.5
        for <linux-block@vger.kernel.org>; Fri, 09 Jul 2021 06:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EQUeRKfr59EhNaXqx/238AuLWVll4VFVIL4GFqoBf7k=;
        b=iVBTjPuD4qf+tTpCOK1WoaFE8JKIXoxmtXGEm9P2QY/5u9oOxiKVghtaOdrsqyizoj
         WwgjqzYs+zvh8Q12D/YqbDTRWwQGLMdg2/CbWxBFAXuw7ggLvBqlo3x88AdqWIISY0Gg
         9Ki3GfKV+i8Dr0nwW+BOBxAhKdyDwMTMJVvVPVxgVbAzlkqZ2Q4y0KZv7plS65SInuTQ
         Xa9QQ7cHz3gHWh440YAU2jto4SR3Y4eyIM6AbblqG72CG2E0/jkb3jya1KaAnGgu11x9
         nnd47EqOdmkty2RXbcrdZ/XXJp/k7teJ4ihtLeVH2qZtEyf6C1k4l1iX/umByjEpsHKq
         0U3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EQUeRKfr59EhNaXqx/238AuLWVll4VFVIL4GFqoBf7k=;
        b=MCbGGFMjUAuDjBEQN6RvIOytyT5i/3FQTe1x/QK+Ouf/bPRPMBoEZy+knu2Q05gIb1
         xtC/gZDKg3vNmpcB+4hRq3nYHqO8YYBeKINmPKPe/HcH7SWZlUGlZSprjCNuX43F3Ib8
         D9X3/q4Amc6b4czYgwU/o3v0x1ptQoWE0lTQXvq+qIqJ2xB0T7468B+vAPD4DCnotDSx
         tP/aLOABGHChsXce0lCoUb/CwIr+X9qgYWf/3fIfyOiIczcGaRfMO2cWeQRMyhiFHvxl
         l/A7O7WAZZTGsN5DASTmBsfD63l0ImtAVKazd0dIl0tOaM6lB5TZ6NNIJSjZX+SLFLI+
         OxJw==
X-Gm-Message-State: AOAM5308VZmvk3sPNV4F/04Pt3xktNi0bL+EKCl86Z7ave2lDP5ey06s
        y65HT7Q76bctoYZqQewDZRA=
X-Google-Smtp-Source: ABdhPJz9Rre5TNQRA0YQZHDJhxc+uRithR40Lfww3HewpS+oi0CDB2Jr2LRLOkqBQVOE1mXWgjvZEw==
X-Received: by 2002:a05:620a:1233:: with SMTP id v19mr764840qkj.33.1625838464879;
        Fri, 09 Jul 2021 06:47:44 -0700 (PDT)
Received: from dschatzberg-fedora-PC0Y6AEN ([2620:10d:c091:480::1:48a0])
        by smtp.gmail.com with ESMTPSA id l206sm2436503qke.80.2021.07.09.06.47.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jul 2021 06:47:44 -0700 (PDT)
Date:   Fri, 9 Jul 2021 09:47:42 -0400
From:   Dan Schatzberg <schatzberg.dan@gmail.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Subject: Re: [PATCH 6/6] loop: don't add worker into idle list
Message-ID: <YOhTfvXURjn81E2j@dschatzberg-fedora-PC0Y6AEN>
References: <20210705102607.127810-1-ming.lei@redhat.com>
 <20210705102607.127810-7-ming.lei@redhat.com>
 <YORg2KYF7X1ZYJPG@dschatzberg-fedora-PC0Y6AEN>
 <YOUdMjAzEw6JQjKG@T590>
 <YOWyVnrOTHvMB7A3@dschatzberg-fedora-PC0Y6AEN>
 <YOaiHLD74VG5I5cD@T590>
 <YOcI0hr3k5q+/zQ4@dschatzberg-fedora-PC0Y6AEN>
 <YOcTYuT4GoIhugDx@T590>
 <YOcWgR7Pi4+XvRZv@dschatzberg-fedora-PC0Y6AEN>
 <YOedM4dWA3j6i4rk@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YOedM4dWA3j6i4rk@T590>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jul 09, 2021 at 08:49:55AM +0800, Ming Lei wrote:
> On Thu, Jul 08, 2021 at 11:15:13AM -0400, Dan Schatzberg wrote:
> > On Thu, Jul 08, 2021 at 11:01:54PM +0800, Ming Lei wrote:
> > > On Thu, Jul 08, 2021 at 10:16:50AM -0400, Dan Schatzberg wrote:
> > > > On Thu, Jul 08, 2021 at 02:58:36PM +0800, Ming Lei wrote:
> > > > > On Wed, Jul 07, 2021 at 09:55:34AM -0400, Dan Schatzberg wrote:
> > > > > > On Wed, Jul 07, 2021 at 11:19:14AM +0800, Ming Lei wrote:
> > > > > > > On Tue, Jul 06, 2021 at 09:55:36AM -0400, Dan Schatzberg wrote:
> > > > > > > > On Mon, Jul 05, 2021 at 06:26:07PM +0800, Ming Lei wrote:
> > > > > > > > >  	}
> > > > > > > > > +
> > > > > > > > > +	spin_lock(lock);
> > > > > > > > >  	list_add_tail(&cmd->list_entry, cmd_list);
> > > > > > > > > +	spin_unlock(lock);
> > > > > > > > >  	queue_work(lo->workqueue, work);
> > > > > > > > > -	spin_unlock(&lo->lo_work_lock);
> > > > > > > > >  }
> > > > > > > > >  
> > > > > > > > >  static void loop_update_rotational(struct loop_device *lo)
> > > > > > > > > @@ -1131,20 +1159,18 @@ static void loop_set_timer(struct loop_device *lo)
> > > > > > > > >  
> > > > > > > > >  static void __loop_free_idle_workers(struct loop_device *lo, bool force)
> > > > > > > > >  {
> > > > > > > > > -	struct loop_worker *pos, *worker;
> > > > > > > > > +	struct loop_worker *worker;
> > > > > > > > > +	unsigned long id;
> > > > > > > > >  
> > > > > > > > >  	spin_lock(&lo->lo_work_lock);
> > > > > > > > > -	list_for_each_entry_safe(worker, pos, &lo->idle_worker_list,
> > > > > > > > > -				idle_list) {
> > > > > > > > > +	xa_for_each(&lo->workers, id, worker) {
> > > > > > > > >  		if (!force && time_is_after_jiffies(worker->last_ran_at +
> > > > > > > > >  						LOOP_IDLE_WORKER_TIMEOUT))
> > > > > > > > >  			break;
> > > > > > > > > -		list_del(&worker->idle_list);
> > > > > > > > > -		xa_erase(&lo->workers, worker->blkcg_css->id);
> > > > > > > > > -		css_put(worker->blkcg_css);
> > > > > > > > > -		kfree(worker);
> > > > > > > > > +		if (refcount_dec_and_test(&worker->refcnt))
> > > > > > > > > +			loop_release_worker(worker);
> > > > > > > > 
> > > > > > > > This one is puzzling to me. Can't you hit this refcount decrement
> > > > > > > > superfluously each time the loop timer fires?
> > > > > > > 
> > > > > > > Not sure I get your point.
> > > > > > > 
> > > > > > > As I mentioned above, this one is the counter pair of INIT reference,
> > > > > > > but one new lo_cmd may just grab it when queueing rq before erasing the
> > > > > > > worker from xarray, so we can't release worker here until the command is
> > > > > > > completed.
> > > > > > 
> > > > > > Suppose at this point there's still an outstanding loop_cmd to be
> > > > > > serviced for this worker. The refcount_dec_and_test should decrement
> > > > > > the refcount and then fail the conditional, not calling
> > > > > > loop_release_worker. What happens if __loop_free_idle_workers fires
> > > > > > again before the loop_cmd is processed? Won't you decrement the
> > > > > > refcount again, and then end up calling loop_release_worker before the
> > > > > > loop_cmd is processed?
> > > > >  
> > > > > Good catch!
> > > > > 
> > > > > The following one line change should avoid the issue:
> > > > > 
> > > > > diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> > > > > index 146eaa03629b..3cd51bddfec9 100644
> > > > > --- a/drivers/block/loop.c
> > > > > +++ b/drivers/block/loop.c
> > > > > @@ -980,7 +980,6 @@ static struct loop_worker *loop_alloc_or_get_worker(struct loop_device *lo,
> > > > >  
> > > > >  static void loop_release_worker(struct loop_worker *worker)
> > > > >  {
> > > > > -	xa_erase(&worker->lo->workers, worker->blkcg_css->id);
> > > > >  	css_put(worker->blkcg_css);
> > > > >  	kfree(worker);
> > > > >  }
> > > > > @@ -1167,6 +1166,7 @@ static void __loop_free_idle_workers(struct loop_device *lo, bool force)
> > > > >  		if (!force && time_is_after_jiffies(worker->last_ran_at +
> > > > >  						LOOP_IDLE_WORKER_TIMEOUT))
> > > > >  			break;
> > > > > +		xa_erase(&worker->lo->workers, worker->blkcg_css->id);
> > > > >  		if (refcount_dec_and_test(&worker->refcnt))
> > > > >  			loop_release_worker(worker);
> > > > >  	}
> > > > 
> > > > Yeah, I think this resolves the issue. You could end up repeatedly
> > > > allocating workers for the same blkcg in the event that you're keeping
> > > > the worker busy for the entire LOOP_IDLE_WORKER_TIMEOUT (since it only
> > > > updates the last_ran_at when idle). You may want to add a racy check
> > > > if the refcount is > 1 to avoid that.
> > > 
> > > Given the event is very unlikely to trigger, I think we can live
> > > with that.
> > 
> > It doesn't seem unlikely to me - any workload that saturates the
> > backing device would keep the loop worker constantly with at least one
> > loop_cmd queued and trigger a free and allocate every
> > LOOP_IDLE_WORKER_TIMEOUT. Another way to solve this is to just update
> > last_ran_at before or after each loop_cmd. In any event, I'll defer to
> > your decision, it's not a critical difference.
> 
> Sorry, I missed that ->last_ran_at is only set when the work isn't
> pending, then we can cleanup/simplify the reclaim a bit by:
> 
> 1) keep lo->idle_work to be scheduled in 60 period if there is any
> active worker allocated, which is scheduled when allocating/reclaiming
> one worker

Makes sense, and you should have lo_work_lock held at both points so
this is safe.

> 
> 2) always set ->last_ran_at after retrieving the worker from xarray,
> which can be done lockless via WRITE_ONCE(), and it is cheap

Yes, or in loop_process_work, doesn't really matter where you do it so
long as it is per-cmd. I think this change alone resolves the issue.

> 
> 3) inside __loop_free_idle_workers(), reclaim one worker only if the
> worker is expired and hasn't commands in worker->cmd_list

Be careful here - the current locking doesn't allow for this because
you don't acquire the per-worker lock in __loop_free_idle_workers, so
accessing worker->cmd_list is a data-race. This is why I suggested
reading the refcount instead as it can be done without holding a lock.

> 
> > 
> > > 
> > > > 
> > > > I think there might be a separate issue with the locking here though -
> > > > you acquire the lo->lo_work_lock in __loop_free_idle_workers and then
> > > > check worker->last_ran_at for each worker. However you only protect
> > > > the write to worker->last_ran_at (in loop_process_work) with the
> > > > worker->lock which I think means there's a potential data race on
> > > > worker->last_ran_at.
> > > 
> > > It should be fine since both WRITE and READ on worker->last_ran_at is
> > > atomic. Even though the race is triggered, we still can live with that.
> > 
> > True, though in this case I think last_ran_at should be atomic_t with
> > atomic_set and atomic_read.
> 
> I think READ_ONCE()/WRITE_ONCE() should be enough, and we can set/get
> last_ran_at lockless.

Makes sense to me
