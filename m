Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16017C07E95
	for <linux-block@archiver.kernel.org>; Wed,  7 Jul 2021 13:55:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED22A61C9D
	for <linux-block@archiver.kernel.org>; Wed,  7 Jul 2021 13:55:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231685AbhGGN6S (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 7 Jul 2021 09:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231472AbhGGN6S (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 7 Jul 2021 09:58:18 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2ECBC061574
        for <linux-block@vger.kernel.org>; Wed,  7 Jul 2021 06:55:37 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id d2so1055798qvh.2
        for <linux-block@vger.kernel.org>; Wed, 07 Jul 2021 06:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TcKifhriFJuDa96QDzjjusft+tYNy8HINE20CAdfktI=;
        b=PVYGBDZx8rvf5qyrSI5a5JROVUAogityQXvyuvZRzh0rCi3PPp/GA6HqEnr3pu0b7D
         WaQIf/u3VVDK097+9M/IOVTXlpkUnltIEB3R5AJKjPSbP8mmra8EB16cm0YjMchSQ2/Z
         uE+FjCKiOoE3JkVG6h/gNBWq8+7TbacalO0aNZ4YZkFA6tloER7tYPCBMwq74zyErtuK
         9z1L5Slm0lbPJRdw6oFSWOOTyWBdBaKa1e9lj+CC5wmVo6O0Dt5nOcefXGhNPVYWZC0d
         C455YNkfDCWVEWHAxiczj6EblLF1DYmrYoigzZydjlM6X2pxlS/2I5jNihzEuEF8Ep53
         4dmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TcKifhriFJuDa96QDzjjusft+tYNy8HINE20CAdfktI=;
        b=Sr6Pcn4X6FI+XBy9yexaRTlsqYxAeVy0WQ92WXVWdHXcV8GVAOHmTZReeSTX5bwbeB
         V1mRIYdBiiykDKvL+4z/yw/QtNecWi5fdF9xCXNAOfe60iKpJjtjJlXsxRIboro0M+/U
         wQXo0Crk165QkyeTToWANEeJYgDmkLhOIvIDOs7W0OSUg7mQB7V/zkK0RmIGIyQat2Dr
         QiN1ay7P6iXCLSPaJz1bfEkPPs8mtUl3G5TnTauGrwAumTnCVtMATBUEghQeEj9qI1ad
         0Bucg39s+QxhY/tiEhK57TNHrJjGSsswpqFEFsKdx4GNmk39h26TG7IxyhQtO0VdQarb
         dacw==
X-Gm-Message-State: AOAM533NxJQPbDTJMn6JYx9/eh8vEYk6WwHZCUEmRTW9Rm8ZIsc4D1jN
        bbygdTNJEFFtu6cfoQFhxdjnTLl83Cs=
X-Google-Smtp-Source: ABdhPJw9khmOyA3TijG31yTb1uUMTAGKr0gk84qB9Ym3ysF28ZpMKmeArziIRCYBtSE8lplsTWl9Gw==
X-Received: by 2002:a0c:ef48:: with SMTP id t8mr23789641qvs.6.1625666137052;
        Wed, 07 Jul 2021 06:55:37 -0700 (PDT)
Received: from dschatzberg-fedora-PC0Y6AEN ([2620:10d:c091:480::1:3074])
        by smtp.gmail.com with ESMTPSA id l190sm6523593qkc.120.2021.07.07.06.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jul 2021 06:55:36 -0700 (PDT)
Date:   Wed, 7 Jul 2021 09:55:34 -0400
From:   Dan Schatzberg <schatzberg.dan@gmail.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Subject: Re: [PATCH 6/6] loop: don't add worker into idle list
Message-ID: <YOWyVnrOTHvMB7A3@dschatzberg-fedora-PC0Y6AEN>
References: <20210705102607.127810-1-ming.lei@redhat.com>
 <20210705102607.127810-7-ming.lei@redhat.com>
 <YORg2KYF7X1ZYJPG@dschatzberg-fedora-PC0Y6AEN>
 <YOUdMjAzEw6JQjKG@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YOUdMjAzEw6JQjKG@T590>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jul 07, 2021 at 11:19:14AM +0800, Ming Lei wrote:
> On Tue, Jul 06, 2021 at 09:55:36AM -0400, Dan Schatzberg wrote:
> > On Mon, Jul 05, 2021 at 06:26:07PM +0800, Ming Lei wrote:
> > >  	}
> > > +
> > > +	spin_lock(lock);
> > >  	list_add_tail(&cmd->list_entry, cmd_list);
> > > +	spin_unlock(lock);
> > >  	queue_work(lo->workqueue, work);
> > > -	spin_unlock(&lo->lo_work_lock);
> > >  }
> > >  
> > >  static void loop_update_rotational(struct loop_device *lo)
> > > @@ -1131,20 +1159,18 @@ static void loop_set_timer(struct loop_device *lo)
> > >  
> > >  static void __loop_free_idle_workers(struct loop_device *lo, bool force)
> > >  {
> > > -	struct loop_worker *pos, *worker;
> > > +	struct loop_worker *worker;
> > > +	unsigned long id;
> > >  
> > >  	spin_lock(&lo->lo_work_lock);
> > > -	list_for_each_entry_safe(worker, pos, &lo->idle_worker_list,
> > > -				idle_list) {
> > > +	xa_for_each(&lo->workers, id, worker) {
> > >  		if (!force && time_is_after_jiffies(worker->last_ran_at +
> > >  						LOOP_IDLE_WORKER_TIMEOUT))
> > >  			break;
> > > -		list_del(&worker->idle_list);
> > > -		xa_erase(&lo->workers, worker->blkcg_css->id);
> > > -		css_put(worker->blkcg_css);
> > > -		kfree(worker);
> > > +		if (refcount_dec_and_test(&worker->refcnt))
> > > +			loop_release_worker(worker);
> > 
> > This one is puzzling to me. Can't you hit this refcount decrement
> > superfluously each time the loop timer fires?
> 
> Not sure I get your point.
> 
> As I mentioned above, this one is the counter pair of INIT reference,
> but one new lo_cmd may just grab it when queueing rq before erasing the
> worker from xarray, so we can't release worker here until the command is
> completed.

Suppose at this point there's still an outstanding loop_cmd to be
serviced for this worker. The refcount_dec_and_test should decrement
the refcount and then fail the conditional, not calling
loop_release_worker. What happens if __loop_free_idle_workers fires
again before the loop_cmd is processed? Won't you decrement the
refcount again, and then end up calling loop_release_worker before the
loop_cmd is processed?
