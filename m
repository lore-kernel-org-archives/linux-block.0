Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09C92C07E96
	for <linux-block@archiver.kernel.org>; Fri,  9 Jul 2021 00:50:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D85EA61464
	for <linux-block@archiver.kernel.org>; Fri,  9 Jul 2021 00:50:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbhGIAw4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 8 Jul 2021 20:52:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50209 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229637AbhGIAwz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 8 Jul 2021 20:52:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625791812;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LT1OUQIRT9x4UNZQgTUwxS3/kHnBRplw+Byqjig8gR0=;
        b=dojc/WOmoWmWallvHE+bX6hoYqCyAnYSpvduQ/X/qic8ESsufouL7rGQL5MF/ZCT8+YmZM
        AktQuyE7CA5VOtwAiZg4iPijZu6oF6PoaGHs1nWPmVg5q0hPPJ79wuXNFfpsPBGke5uISe
        iLv/cFDWHGJYRplcGg+uFCJd++vIIh8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-364-m_HgjgDNMj-NYpcxBy_tXQ-1; Thu, 08 Jul 2021 20:50:11 -0400
X-MC-Unique: m_HgjgDNMj-NYpcxBy_tXQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7566E362FB;
        Fri,  9 Jul 2021 00:50:10 +0000 (UTC)
Received: from T590 (ovpn-12-111.pek2.redhat.com [10.72.12.111])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7E9045C1D5;
        Fri,  9 Jul 2021 00:50:00 +0000 (UTC)
Date:   Fri, 9 Jul 2021 08:49:55 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Dan Schatzberg <schatzberg.dan@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Subject: Re: [PATCH 6/6] loop: don't add worker into idle list
Message-ID: <YOedM4dWA3j6i4rk@T590>
References: <20210705102607.127810-1-ming.lei@redhat.com>
 <20210705102607.127810-7-ming.lei@redhat.com>
 <YORg2KYF7X1ZYJPG@dschatzberg-fedora-PC0Y6AEN>
 <YOUdMjAzEw6JQjKG@T590>
 <YOWyVnrOTHvMB7A3@dschatzberg-fedora-PC0Y6AEN>
 <YOaiHLD74VG5I5cD@T590>
 <YOcI0hr3k5q+/zQ4@dschatzberg-fedora-PC0Y6AEN>
 <YOcTYuT4GoIhugDx@T590>
 <YOcWgR7Pi4+XvRZv@dschatzberg-fedora-PC0Y6AEN>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YOcWgR7Pi4+XvRZv@dschatzberg-fedora-PC0Y6AEN>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jul 08, 2021 at 11:15:13AM -0400, Dan Schatzberg wrote:
> On Thu, Jul 08, 2021 at 11:01:54PM +0800, Ming Lei wrote:
> > On Thu, Jul 08, 2021 at 10:16:50AM -0400, Dan Schatzberg wrote:
> > > On Thu, Jul 08, 2021 at 02:58:36PM +0800, Ming Lei wrote:
> > > > On Wed, Jul 07, 2021 at 09:55:34AM -0400, Dan Schatzberg wrote:
> > > > > On Wed, Jul 07, 2021 at 11:19:14AM +0800, Ming Lei wrote:
> > > > > > On Tue, Jul 06, 2021 at 09:55:36AM -0400, Dan Schatzberg wrote:
> > > > > > > On Mon, Jul 05, 2021 at 06:26:07PM +0800, Ming Lei wrote:
> > > > > > > >  	}
> > > > > > > > +
> > > > > > > > +	spin_lock(lock);
> > > > > > > >  	list_add_tail(&cmd->list_entry, cmd_list);
> > > > > > > > +	spin_unlock(lock);
> > > > > > > >  	queue_work(lo->workqueue, work);
> > > > > > > > -	spin_unlock(&lo->lo_work_lock);
> > > > > > > >  }
> > > > > > > >  
> > > > > > > >  static void loop_update_rotational(struct loop_device *lo)
> > > > > > > > @@ -1131,20 +1159,18 @@ static void loop_set_timer(struct loop_device *lo)
> > > > > > > >  
> > > > > > > >  static void __loop_free_idle_workers(struct loop_device *lo, bool force)
> > > > > > > >  {
> > > > > > > > -	struct loop_worker *pos, *worker;
> > > > > > > > +	struct loop_worker *worker;
> > > > > > > > +	unsigned long id;
> > > > > > > >  
> > > > > > > >  	spin_lock(&lo->lo_work_lock);
> > > > > > > > -	list_for_each_entry_safe(worker, pos, &lo->idle_worker_list,
> > > > > > > > -				idle_list) {
> > > > > > > > +	xa_for_each(&lo->workers, id, worker) {
> > > > > > > >  		if (!force && time_is_after_jiffies(worker->last_ran_at +
> > > > > > > >  						LOOP_IDLE_WORKER_TIMEOUT))
> > > > > > > >  			break;
> > > > > > > > -		list_del(&worker->idle_list);
> > > > > > > > -		xa_erase(&lo->workers, worker->blkcg_css->id);
> > > > > > > > -		css_put(worker->blkcg_css);
> > > > > > > > -		kfree(worker);
> > > > > > > > +		if (refcount_dec_and_test(&worker->refcnt))
> > > > > > > > +			loop_release_worker(worker);
> > > > > > > 
> > > > > > > This one is puzzling to me. Can't you hit this refcount decrement
> > > > > > > superfluously each time the loop timer fires?
> > > > > > 
> > > > > > Not sure I get your point.
> > > > > > 
> > > > > > As I mentioned above, this one is the counter pair of INIT reference,
> > > > > > but one new lo_cmd may just grab it when queueing rq before erasing the
> > > > > > worker from xarray, so we can't release worker here until the command is
> > > > > > completed.
> > > > > 
> > > > > Suppose at this point there's still an outstanding loop_cmd to be
> > > > > serviced for this worker. The refcount_dec_and_test should decrement
> > > > > the refcount and then fail the conditional, not calling
> > > > > loop_release_worker. What happens if __loop_free_idle_workers fires
> > > > > again before the loop_cmd is processed? Won't you decrement the
> > > > > refcount again, and then end up calling loop_release_worker before the
> > > > > loop_cmd is processed?
> > > >  
> > > > Good catch!
> > > > 
> > > > The following one line change should avoid the issue:
> > > > 
> > > > diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> > > > index 146eaa03629b..3cd51bddfec9 100644
> > > > --- a/drivers/block/loop.c
> > > > +++ b/drivers/block/loop.c
> > > > @@ -980,7 +980,6 @@ static struct loop_worker *loop_alloc_or_get_worker(struct loop_device *lo,
> > > >  
> > > >  static void loop_release_worker(struct loop_worker *worker)
> > > >  {
> > > > -	xa_erase(&worker->lo->workers, worker->blkcg_css->id);
> > > >  	css_put(worker->blkcg_css);
> > > >  	kfree(worker);
> > > >  }
> > > > @@ -1167,6 +1166,7 @@ static void __loop_free_idle_workers(struct loop_device *lo, bool force)
> > > >  		if (!force && time_is_after_jiffies(worker->last_ran_at +
> > > >  						LOOP_IDLE_WORKER_TIMEOUT))
> > > >  			break;
> > > > +		xa_erase(&worker->lo->workers, worker->blkcg_css->id);
> > > >  		if (refcount_dec_and_test(&worker->refcnt))
> > > >  			loop_release_worker(worker);
> > > >  	}
> > > 
> > > Yeah, I think this resolves the issue. You could end up repeatedly
> > > allocating workers for the same blkcg in the event that you're keeping
> > > the worker busy for the entire LOOP_IDLE_WORKER_TIMEOUT (since it only
> > > updates the last_ran_at when idle). You may want to add a racy check
> > > if the refcount is > 1 to avoid that.
> > 
> > Given the event is very unlikely to trigger, I think we can live
> > with that.
> 
> It doesn't seem unlikely to me - any workload that saturates the
> backing device would keep the loop worker constantly with at least one
> loop_cmd queued and trigger a free and allocate every
> LOOP_IDLE_WORKER_TIMEOUT. Another way to solve this is to just update
> last_ran_at before or after each loop_cmd. In any event, I'll defer to
> your decision, it's not a critical difference.

Sorry, I missed that ->last_ran_at is only set when the work isn't
pending, then we can cleanup/simplify the reclaim a bit by:

1) keep lo->idle_work to be scheduled in 60 period if there is any
active worker allocated, which is scheduled when allocating/reclaiming
one worker

2) always set ->last_ran_at after retrieving the worker from xarray,
which can be done lockless via WRITE_ONCE(), and it is cheap

3) inside __loop_free_idle_workers(), reclaim one worker only if the
worker is expired and hasn't commands in worker->cmd_list

> 
> > 
> > > 
> > > I think there might be a separate issue with the locking here though -
> > > you acquire the lo->lo_work_lock in __loop_free_idle_workers and then
> > > check worker->last_ran_at for each worker. However you only protect
> > > the write to worker->last_ran_at (in loop_process_work) with the
> > > worker->lock which I think means there's a potential data race on
> > > worker->last_ran_at.
> > 
> > It should be fine since both WRITE and READ on worker->last_ran_at is
> > atomic. Even though the race is triggered, we still can live with that.
> 
> True, though in this case I think last_ran_at should be atomic_t with
> atomic_set and atomic_read.

I think READ_ONCE()/WRITE_ONCE() should be enough, and we can set/get
last_ran_at lockless.

> 
> > 
> > 
> > On Thu, Jul 8, 2021 at 10:41 PM Dan Schatzberg <schatzberg.dan@gmail.com> wrote:
> > >
> > > On Thu, Jul 08, 2021 at 02:58:36PM +0800, Ming Lei wrote:
> > ...
> > > Another thought - do you need to change the kfree here to kfree_rcu?
> > > I'm concerned about the scenario where loop_queue_work's xa_load finds
> > > the worker and subsequently __loop_free_idle_workers erases and calls
> > > loop_release_worker. If the worker is freed then the subsequent
> > > refcount_inc_not_zero in loop_queue_work would be a use after free.
> > 
> > Good catch, will fix it in next version.
> 
> Thanks, you can go ahead and add my Acked-by to the updated version of
> this patch as well.

Thanks for the review!

-- 
Ming

