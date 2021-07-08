Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1077C07E96
	for <linux-block@archiver.kernel.org>; Thu,  8 Jul 2021 15:15:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACC1561414
	for <linux-block@archiver.kernel.org>; Thu,  8 Jul 2021 15:15:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231849AbhGHPR7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 8 Jul 2021 11:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbhGHPR7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 8 Jul 2021 11:17:59 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 883CDC061574
        for <linux-block@vger.kernel.org>; Thu,  8 Jul 2021 08:15:16 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id z12so5073606qtj.3
        for <linux-block@vger.kernel.org>; Thu, 08 Jul 2021 08:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nZmeif0+dO/gCppEiVHJPKNDHfZkNHwAKTBKNNHFTX0=;
        b=GHDRo66h/ZHdiRietj7GT81fGnTG9Cc9E69RoaY4TayfTco1XLRJzRVjtTdqyQTd43
         J3Jafh0jwiYysKCv4UDdppD1tHX8DbsrIPxtcMRVZ0Tl7bA0ecMZQkrVH/aTj69qtmTi
         DEsoXJp7hytxFW35E4mqd0/PcJk023L47x1PXMtgTV4Kn5vKh4T8oyVn5rgZ12G3FWyS
         6gelt26qsyfBXoJfsrs6CK+PLNk96+WG6LD6lR0ZvKUvFXwY2mLY9w6YCXpvKykPr157
         kq9l5LXhDTQnVhQJKfaG2x0udsfYVfN3LO5q905/lEH+hxiOwDXZQddoSxVZl5d8tPho
         Kt8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nZmeif0+dO/gCppEiVHJPKNDHfZkNHwAKTBKNNHFTX0=;
        b=nGwi97L0EseZGgjESNpQHbaNSLg6520tk0iGNfycKYbLR5KmoUPvLjtIORS4lHvXUW
         gY3ML4b/HUuEuuNVYSq/BgJvT9834IYfyxcnGFU676abBx7xoFGf2GX0ZZEN0Q+fqlUX
         CUc9w9PtCg7HilAR1KC6vyM+chJS73SYonmRTzmtAQYcjJXSZPdVSnwoKSJedrBD8V8/
         doq0DwrtA8walrYpNtYtcGXzLd3gHGJP4xCuYgQKm293sboQPCdaUBbjjcosP+KPFDVZ
         PgdclqOPFSukzC4B6yJjK11q8b9b92oGL5nOJOCiqP8GET2fqVeSsaNcMg2I2RJtP31y
         bINA==
X-Gm-Message-State: AOAM532d6XbpZgFrtJgiq/O3KWRa0QtGTCpMwSASgnm93wPExSuavNMC
        /rC4gY2LwORzcEHB7D8cjoQ=
X-Google-Smtp-Source: ABdhPJx3lRrpSEFZ8hDi09zi5jc7lCV3BRbLAcsfjyOZBLHswT329iGG/0+g4pzUe8paTxPDn8xkRw==
X-Received: by 2002:aed:306f:: with SMTP id 102mr28680511qte.197.1625757315703;
        Thu, 08 Jul 2021 08:15:15 -0700 (PDT)
Received: from dschatzberg-fedora-PC0Y6AEN ([2620:10d:c091:480::1:ee15])
        by smtp.gmail.com with ESMTPSA id x16sm1086849qkn.130.2021.07.08.08.15.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jul 2021 08:15:15 -0700 (PDT)
Date:   Thu, 8 Jul 2021 11:15:13 -0400
From:   Dan Schatzberg <schatzberg.dan@gmail.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Subject: Re: [PATCH 6/6] loop: don't add worker into idle list
Message-ID: <YOcWgR7Pi4+XvRZv@dschatzberg-fedora-PC0Y6AEN>
References: <20210705102607.127810-1-ming.lei@redhat.com>
 <20210705102607.127810-7-ming.lei@redhat.com>
 <YORg2KYF7X1ZYJPG@dschatzberg-fedora-PC0Y6AEN>
 <YOUdMjAzEw6JQjKG@T590>
 <YOWyVnrOTHvMB7A3@dschatzberg-fedora-PC0Y6AEN>
 <YOaiHLD74VG5I5cD@T590>
 <YOcI0hr3k5q+/zQ4@dschatzberg-fedora-PC0Y6AEN>
 <YOcTYuT4GoIhugDx@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YOcTYuT4GoIhugDx@T590>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jul 08, 2021 at 11:01:54PM +0800, Ming Lei wrote:
> On Thu, Jul 08, 2021 at 10:16:50AM -0400, Dan Schatzberg wrote:
> > On Thu, Jul 08, 2021 at 02:58:36PM +0800, Ming Lei wrote:
> > > On Wed, Jul 07, 2021 at 09:55:34AM -0400, Dan Schatzberg wrote:
> > > > On Wed, Jul 07, 2021 at 11:19:14AM +0800, Ming Lei wrote:
> > > > > On Tue, Jul 06, 2021 at 09:55:36AM -0400, Dan Schatzberg wrote:
> > > > > > On Mon, Jul 05, 2021 at 06:26:07PM +0800, Ming Lei wrote:
> > > > > > >  	}
> > > > > > > +
> > > > > > > +	spin_lock(lock);
> > > > > > >  	list_add_tail(&cmd->list_entry, cmd_list);
> > > > > > > +	spin_unlock(lock);
> > > > > > >  	queue_work(lo->workqueue, work);
> > > > > > > -	spin_unlock(&lo->lo_work_lock);
> > > > > > >  }
> > > > > > >  
> > > > > > >  static void loop_update_rotational(struct loop_device *lo)
> > > > > > > @@ -1131,20 +1159,18 @@ static void loop_set_timer(struct loop_device *lo)
> > > > > > >  
> > > > > > >  static void __loop_free_idle_workers(struct loop_device *lo, bool force)
> > > > > > >  {
> > > > > > > -	struct loop_worker *pos, *worker;
> > > > > > > +	struct loop_worker *worker;
> > > > > > > +	unsigned long id;
> > > > > > >  
> > > > > > >  	spin_lock(&lo->lo_work_lock);
> > > > > > > -	list_for_each_entry_safe(worker, pos, &lo->idle_worker_list,
> > > > > > > -				idle_list) {
> > > > > > > +	xa_for_each(&lo->workers, id, worker) {
> > > > > > >  		if (!force && time_is_after_jiffies(worker->last_ran_at +
> > > > > > >  						LOOP_IDLE_WORKER_TIMEOUT))
> > > > > > >  			break;
> > > > > > > -		list_del(&worker->idle_list);
> > > > > > > -		xa_erase(&lo->workers, worker->blkcg_css->id);
> > > > > > > -		css_put(worker->blkcg_css);
> > > > > > > -		kfree(worker);
> > > > > > > +		if (refcount_dec_and_test(&worker->refcnt))
> > > > > > > +			loop_release_worker(worker);
> > > > > > 
> > > > > > This one is puzzling to me. Can't you hit this refcount decrement
> > > > > > superfluously each time the loop timer fires?
> > > > > 
> > > > > Not sure I get your point.
> > > > > 
> > > > > As I mentioned above, this one is the counter pair of INIT reference,
> > > > > but one new lo_cmd may just grab it when queueing rq before erasing the
> > > > > worker from xarray, so we can't release worker here until the command is
> > > > > completed.
> > > > 
> > > > Suppose at this point there's still an outstanding loop_cmd to be
> > > > serviced for this worker. The refcount_dec_and_test should decrement
> > > > the refcount and then fail the conditional, not calling
> > > > loop_release_worker. What happens if __loop_free_idle_workers fires
> > > > again before the loop_cmd is processed? Won't you decrement the
> > > > refcount again, and then end up calling loop_release_worker before the
> > > > loop_cmd is processed?
> > >  
> > > Good catch!
> > > 
> > > The following one line change should avoid the issue:
> > > 
> > > diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> > > index 146eaa03629b..3cd51bddfec9 100644
> > > --- a/drivers/block/loop.c
> > > +++ b/drivers/block/loop.c
> > > @@ -980,7 +980,6 @@ static struct loop_worker *loop_alloc_or_get_worker(struct loop_device *lo,
> > >  
> > >  static void loop_release_worker(struct loop_worker *worker)
> > >  {
> > > -	xa_erase(&worker->lo->workers, worker->blkcg_css->id);
> > >  	css_put(worker->blkcg_css);
> > >  	kfree(worker);
> > >  }
> > > @@ -1167,6 +1166,7 @@ static void __loop_free_idle_workers(struct loop_device *lo, bool force)
> > >  		if (!force && time_is_after_jiffies(worker->last_ran_at +
> > >  						LOOP_IDLE_WORKER_TIMEOUT))
> > >  			break;
> > > +		xa_erase(&worker->lo->workers, worker->blkcg_css->id);
> > >  		if (refcount_dec_and_test(&worker->refcnt))
> > >  			loop_release_worker(worker);
> > >  	}
> > 
> > Yeah, I think this resolves the issue. You could end up repeatedly
> > allocating workers for the same blkcg in the event that you're keeping
> > the worker busy for the entire LOOP_IDLE_WORKER_TIMEOUT (since it only
> > updates the last_ran_at when idle). You may want to add a racy check
> > if the refcount is > 1 to avoid that.
> 
> Given the event is very unlikely to trigger, I think we can live
> with that.

It doesn't seem unlikely to me - any workload that saturates the
backing device would keep the loop worker constantly with at least one
loop_cmd queued and trigger a free and allocate every
LOOP_IDLE_WORKER_TIMEOUT. Another way to solve this is to just update
last_ran_at before or after each loop_cmd. In any event, I'll defer to
your decision, it's not a critical difference.

> 
> > 
> > I think there might be a separate issue with the locking here though -
> > you acquire the lo->lo_work_lock in __loop_free_idle_workers and then
> > check worker->last_ran_at for each worker. However you only protect
> > the write to worker->last_ran_at (in loop_process_work) with the
> > worker->lock which I think means there's a potential data race on
> > worker->last_ran_at.
> 
> It should be fine since both WRITE and READ on worker->last_ran_at is
> atomic. Even though the race is triggered, we still can live with that.

True, though in this case I think last_ran_at should be atomic_t with
atomic_set and atomic_read.

> 
> 
> On Thu, Jul 8, 2021 at 10:41 PM Dan Schatzberg <schatzberg.dan@gmail.com> wrote:
> >
> > On Thu, Jul 08, 2021 at 02:58:36PM +0800, Ming Lei wrote:
> ...
> > Another thought - do you need to change the kfree here to kfree_rcu?
> > I'm concerned about the scenario where loop_queue_work's xa_load finds
> > the worker and subsequently __loop_free_idle_workers erases and calls
> > loop_release_worker. If the worker is freed then the subsequent
> > refcount_inc_not_zero in loop_queue_work would be a use after free.
> 
> Good catch, will fix it in next version.

Thanks, you can go ahead and add my Acked-by to the updated version of
this patch as well.
