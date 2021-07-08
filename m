Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E4C5C07E96
	for <linux-block@archiver.kernel.org>; Thu,  8 Jul 2021 15:02:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84DD4613C8
	for <linux-block@archiver.kernel.org>; Thu,  8 Jul 2021 15:02:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbhGHPEw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 8 Jul 2021 11:04:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47442 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229738AbhGHPEw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 8 Jul 2021 11:04:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625756530;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BEGwjh1UEHXwUY8m1x7a7ESan27Qj9tQDS8td/jgx9A=;
        b=e9jg2bCXApaBANWrbhJJAqyTbGLf1lAatqr+rC/XQGh7wnYnEq3q1EIUVIk1vwTcNF19TT
        6Jzx7C0DidJ/yHWRsqbz3ShWtN0+hvDZDKKl+FIAP1UWWfYbC9/CxDCaWVZaNyjqsJMG2W
        E1wU65h0QOC5hqlzx8EOvP1cywyHgaA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-175-zW7_GvXdODW6rf7LqK4vEw-1; Thu, 08 Jul 2021 11:02:06 -0400
X-MC-Unique: zW7_GvXdODW6rf7LqK4vEw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7F5B61084F4C;
        Thu,  8 Jul 2021 15:02:05 +0000 (UTC)
Received: from T590 (ovpn-12-93.pek2.redhat.com [10.72.12.93])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C45195C1C2;
        Thu,  8 Jul 2021 15:01:58 +0000 (UTC)
Date:   Thu, 8 Jul 2021 23:01:54 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Dan Schatzberg <schatzberg.dan@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Subject: Re: [PATCH 6/6] loop: don't add worker into idle list
Message-ID: <YOcTYuT4GoIhugDx@T590>
References: <20210705102607.127810-1-ming.lei@redhat.com>
 <20210705102607.127810-7-ming.lei@redhat.com>
 <YORg2KYF7X1ZYJPG@dschatzberg-fedora-PC0Y6AEN>
 <YOUdMjAzEw6JQjKG@T590>
 <YOWyVnrOTHvMB7A3@dschatzberg-fedora-PC0Y6AEN>
 <YOaiHLD74VG5I5cD@T590>
 <YOcI0hr3k5q+/zQ4@dschatzberg-fedora-PC0Y6AEN>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YOcI0hr3k5q+/zQ4@dschatzberg-fedora-PC0Y6AEN>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jul 08, 2021 at 10:16:50AM -0400, Dan Schatzberg wrote:
> On Thu, Jul 08, 2021 at 02:58:36PM +0800, Ming Lei wrote:
> > On Wed, Jul 07, 2021 at 09:55:34AM -0400, Dan Schatzberg wrote:
> > > On Wed, Jul 07, 2021 at 11:19:14AM +0800, Ming Lei wrote:
> > > > On Tue, Jul 06, 2021 at 09:55:36AM -0400, Dan Schatzberg wrote:
> > > > > On Mon, Jul 05, 2021 at 06:26:07PM +0800, Ming Lei wrote:
> > > > > >  	}
> > > > > > +
> > > > > > +	spin_lock(lock);
> > > > > >  	list_add_tail(&cmd->list_entry, cmd_list);
> > > > > > +	spin_unlock(lock);
> > > > > >  	queue_work(lo->workqueue, work);
> > > > > > -	spin_unlock(&lo->lo_work_lock);
> > > > > >  }
> > > > > >  
> > > > > >  static void loop_update_rotational(struct loop_device *lo)
> > > > > > @@ -1131,20 +1159,18 @@ static void loop_set_timer(struct loop_device *lo)
> > > > > >  
> > > > > >  static void __loop_free_idle_workers(struct loop_device *lo, bool force)
> > > > > >  {
> > > > > > -	struct loop_worker *pos, *worker;
> > > > > > +	struct loop_worker *worker;
> > > > > > +	unsigned long id;
> > > > > >  
> > > > > >  	spin_lock(&lo->lo_work_lock);
> > > > > > -	list_for_each_entry_safe(worker, pos, &lo->idle_worker_list,
> > > > > > -				idle_list) {
> > > > > > +	xa_for_each(&lo->workers, id, worker) {
> > > > > >  		if (!force && time_is_after_jiffies(worker->last_ran_at +
> > > > > >  						LOOP_IDLE_WORKER_TIMEOUT))
> > > > > >  			break;
> > > > > > -		list_del(&worker->idle_list);
> > > > > > -		xa_erase(&lo->workers, worker->blkcg_css->id);
> > > > > > -		css_put(worker->blkcg_css);
> > > > > > -		kfree(worker);
> > > > > > +		if (refcount_dec_and_test(&worker->refcnt))
> > > > > > +			loop_release_worker(worker);
> > > > > 
> > > > > This one is puzzling to me. Can't you hit this refcount decrement
> > > > > superfluously each time the loop timer fires?
> > > > 
> > > > Not sure I get your point.
> > > > 
> > > > As I mentioned above, this one is the counter pair of INIT reference,
> > > > but one new lo_cmd may just grab it when queueing rq before erasing the
> > > > worker from xarray, so we can't release worker here until the command is
> > > > completed.
> > > 
> > > Suppose at this point there's still an outstanding loop_cmd to be
> > > serviced for this worker. The refcount_dec_and_test should decrement
> > > the refcount and then fail the conditional, not calling
> > > loop_release_worker. What happens if __loop_free_idle_workers fires
> > > again before the loop_cmd is processed? Won't you decrement the
> > > refcount again, and then end up calling loop_release_worker before the
> > > loop_cmd is processed?
> >  
> > Good catch!
> > 
> > The following one line change should avoid the issue:
> > 
> > diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> > index 146eaa03629b..3cd51bddfec9 100644
> > --- a/drivers/block/loop.c
> > +++ b/drivers/block/loop.c
> > @@ -980,7 +980,6 @@ static struct loop_worker *loop_alloc_or_get_worker(struct loop_device *lo,
> >  
> >  static void loop_release_worker(struct loop_worker *worker)
> >  {
> > -	xa_erase(&worker->lo->workers, worker->blkcg_css->id);
> >  	css_put(worker->blkcg_css);
> >  	kfree(worker);
> >  }
> > @@ -1167,6 +1166,7 @@ static void __loop_free_idle_workers(struct loop_device *lo, bool force)
> >  		if (!force && time_is_after_jiffies(worker->last_ran_at +
> >  						LOOP_IDLE_WORKER_TIMEOUT))
> >  			break;
> > +		xa_erase(&worker->lo->workers, worker->blkcg_css->id);
> >  		if (refcount_dec_and_test(&worker->refcnt))
> >  			loop_release_worker(worker);
> >  	}
> 
> Yeah, I think this resolves the issue. You could end up repeatedly
> allocating workers for the same blkcg in the event that you're keeping
> the worker busy for the entire LOOP_IDLE_WORKER_TIMEOUT (since it only
> updates the last_ran_at when idle). You may want to add a racy check
> if the refcount is > 1 to avoid that.

Given the event is very unlikely to trigger, I think we can live
with that.

> 
> I think there might be a separate issue with the locking here though -
> you acquire the lo->lo_work_lock in __loop_free_idle_workers and then
> check worker->last_ran_at for each worker. However you only protect
> the write to worker->last_ran_at (in loop_process_work) with the
> worker->lock which I think means there's a potential data race on
> worker->last_ran_at.

It should be fine since both WRITE and READ on worker->last_ran_at is
atomic. Even though the race is triggered, we still can live with that.


On Thu, Jul 8, 2021 at 10:41 PM Dan Schatzberg <schatzberg.dan@gmail.com> wrote:
>
> On Thu, Jul 08, 2021 at 02:58:36PM +0800, Ming Lei wrote:
...
> Another thought - do you need to change the kfree here to kfree_rcu?
> I'm concerned about the scenario where loop_queue_work's xa_load finds
> the worker and subsequently __loop_free_idle_workers erases and calls
> loop_release_worker. If the worker is freed then the subsequent
> refcount_inc_not_zero in loop_queue_work would be a use after free.

Good catch, will fix it in next version.


Thanks,
Ming

