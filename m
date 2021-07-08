Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C911EC07E96
	for <linux-block@archiver.kernel.org>; Thu,  8 Jul 2021 14:16:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5357613C2
	for <linux-block@archiver.kernel.org>; Thu,  8 Jul 2021 14:16:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231951AbhGHOTi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 8 Jul 2021 10:19:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231828AbhGHOTi (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 8 Jul 2021 10:19:38 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CEA3C061574
        for <linux-block@vger.kernel.org>; Thu,  8 Jul 2021 07:16:55 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id d2so2862093qvh.2
        for <linux-block@vger.kernel.org>; Thu, 08 Jul 2021 07:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=d5d/GxLmbKfY+XWVcKletUVIjk4gicqC51q3HxHrwVs=;
        b=YGO5yj+sW1ldFLeWUq2sjY+JCHJIwjbP8HAOHYGDG3d1g4TKrWpA1QutuAtqlECRNe
         IQajJFVRn2GE50Cx2nYEZ5/mG5x1UO4GrDKmTrX7SURJq26rbnrtwGggrBkgxHtz4QSP
         EgEG7IpahnUtpWvO80llJPBP3MC+XYz76gpY5R7UugyGZlC/y0Mr6sRNkhCkFdlyWAG+
         xlpJaqJMP8EMOdxq95EUhmzlfyLeDOOWxNdrlEKpkFePAgnWwS4Q1hVw2sxkVF4sG/b0
         XCFTLOueoPJ+6TUAZY5kebl+LeKos6hc7gfiapFA3t4Cc8mx502QAN12rC+sfzNdjJ75
         29ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=d5d/GxLmbKfY+XWVcKletUVIjk4gicqC51q3HxHrwVs=;
        b=WUndePapaRMcWpTUokPi8rDhxpWO9ldr8hL5pRFiPjQR5NdmtYneho6+XfWES6sriD
         27vSNo9LEgWQxnkWbtiXPXEYAD0PhY2VOlBYRnhtI4l4yFj+WHI2cgmcNmQT1u9tuMpa
         IcF8YbnOb/zOWFRAfTz4fldIr28NFSCN0L/2L+hsj5eLfILsk8FdyEGiaBhySnUK+Ott
         7/XRYlZZMqQrCXmLgOrXLfZlWeUQD7e0Dlue1L3HMsE05UqAKbj0BeZHwatFLdq5R7y3
         me+599ajhfuclVfdMTMg7YCqgqX9ElMxh/ESBhiKBGQj4AJWCYqaMML8yXpbiR6EUxJ4
         h7og==
X-Gm-Message-State: AOAM5328Tn80rZ8eVkLQtc2XRY90Ym1H1UiV5t4NTxKh1GqV5ipKvJT1
        fWNFrWS1pLlBKwKUnn0BFrM=
X-Google-Smtp-Source: ABdhPJwMVaTpCtyZBV+aK+xIQoiCueEh3Bvznmah/MIuius/653uRAFVir9C9xLHKJ8Mi4Di4VNZYg==
X-Received: by 2002:a0c:cb8f:: with SMTP id p15mr30697827qvk.13.1625753814345;
        Thu, 08 Jul 2021 07:16:54 -0700 (PDT)
Received: from dschatzberg-fedora-PC0Y6AEN ([2620:10d:c091:480::1:ee15])
        by smtp.gmail.com with ESMTPSA id b7sm1011938qti.21.2021.07.08.07.16.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jul 2021 07:16:52 -0700 (PDT)
Date:   Thu, 8 Jul 2021 10:16:50 -0400
From:   Dan Schatzberg <schatzberg.dan@gmail.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Subject: Re: [PATCH 6/6] loop: don't add worker into idle list
Message-ID: <YOcI0hr3k5q+/zQ4@dschatzberg-fedora-PC0Y6AEN>
References: <20210705102607.127810-1-ming.lei@redhat.com>
 <20210705102607.127810-7-ming.lei@redhat.com>
 <YORg2KYF7X1ZYJPG@dschatzberg-fedora-PC0Y6AEN>
 <YOUdMjAzEw6JQjKG@T590>
 <YOWyVnrOTHvMB7A3@dschatzberg-fedora-PC0Y6AEN>
 <YOaiHLD74VG5I5cD@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YOaiHLD74VG5I5cD@T590>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jul 08, 2021 at 02:58:36PM +0800, Ming Lei wrote:
> On Wed, Jul 07, 2021 at 09:55:34AM -0400, Dan Schatzberg wrote:
> > On Wed, Jul 07, 2021 at 11:19:14AM +0800, Ming Lei wrote:
> > > On Tue, Jul 06, 2021 at 09:55:36AM -0400, Dan Schatzberg wrote:
> > > > On Mon, Jul 05, 2021 at 06:26:07PM +0800, Ming Lei wrote:
> > > > >  	}
> > > > > +
> > > > > +	spin_lock(lock);
> > > > >  	list_add_tail(&cmd->list_entry, cmd_list);
> > > > > +	spin_unlock(lock);
> > > > >  	queue_work(lo->workqueue, work);
> > > > > -	spin_unlock(&lo->lo_work_lock);
> > > > >  }
> > > > >  
> > > > >  static void loop_update_rotational(struct loop_device *lo)
> > > > > @@ -1131,20 +1159,18 @@ static void loop_set_timer(struct loop_device *lo)
> > > > >  
> > > > >  static void __loop_free_idle_workers(struct loop_device *lo, bool force)
> > > > >  {
> > > > > -	struct loop_worker *pos, *worker;
> > > > > +	struct loop_worker *worker;
> > > > > +	unsigned long id;
> > > > >  
> > > > >  	spin_lock(&lo->lo_work_lock);
> > > > > -	list_for_each_entry_safe(worker, pos, &lo->idle_worker_list,
> > > > > -				idle_list) {
> > > > > +	xa_for_each(&lo->workers, id, worker) {
> > > > >  		if (!force && time_is_after_jiffies(worker->last_ran_at +
> > > > >  						LOOP_IDLE_WORKER_TIMEOUT))
> > > > >  			break;
> > > > > -		list_del(&worker->idle_list);
> > > > > -		xa_erase(&lo->workers, worker->blkcg_css->id);
> > > > > -		css_put(worker->blkcg_css);
> > > > > -		kfree(worker);
> > > > > +		if (refcount_dec_and_test(&worker->refcnt))
> > > > > +			loop_release_worker(worker);
> > > > 
> > > > This one is puzzling to me. Can't you hit this refcount decrement
> > > > superfluously each time the loop timer fires?
> > > 
> > > Not sure I get your point.
> > > 
> > > As I mentioned above, this one is the counter pair of INIT reference,
> > > but one new lo_cmd may just grab it when queueing rq before erasing the
> > > worker from xarray, so we can't release worker here until the command is
> > > completed.
> > 
> > Suppose at this point there's still an outstanding loop_cmd to be
> > serviced for this worker. The refcount_dec_and_test should decrement
> > the refcount and then fail the conditional, not calling
> > loop_release_worker. What happens if __loop_free_idle_workers fires
> > again before the loop_cmd is processed? Won't you decrement the
> > refcount again, and then end up calling loop_release_worker before the
> > loop_cmd is processed?
>  
> Good catch!
> 
> The following one line change should avoid the issue:
> 
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index 146eaa03629b..3cd51bddfec9 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -980,7 +980,6 @@ static struct loop_worker *loop_alloc_or_get_worker(struct loop_device *lo,
>  
>  static void loop_release_worker(struct loop_worker *worker)
>  {
> -	xa_erase(&worker->lo->workers, worker->blkcg_css->id);
>  	css_put(worker->blkcg_css);
>  	kfree(worker);
>  }
> @@ -1167,6 +1166,7 @@ static void __loop_free_idle_workers(struct loop_device *lo, bool force)
>  		if (!force && time_is_after_jiffies(worker->last_ran_at +
>  						LOOP_IDLE_WORKER_TIMEOUT))
>  			break;
> +		xa_erase(&worker->lo->workers, worker->blkcg_css->id);
>  		if (refcount_dec_and_test(&worker->refcnt))
>  			loop_release_worker(worker);
>  	}

Yeah, I think this resolves the issue. You could end up repeatedly
allocating workers for the same blkcg in the event that you're keeping
the worker busy for the entire LOOP_IDLE_WORKER_TIMEOUT (since it only
updates the last_ran_at when idle). You may want to add a racy check
if the refcount is > 1 to avoid that.

I think there might be a separate issue with the locking here though -
you acquire the lo->lo_work_lock in __loop_free_idle_workers and then
check worker->last_ran_at for each worker. However you only protect
the write to worker->last_ran_at (in loop_process_work) with the
worker->lock which I think means there's a potential data race on
worker->last_ran_at.
