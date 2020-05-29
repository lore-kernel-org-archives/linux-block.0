Return-Path: <SRS0=yryn=7L=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD74AC433E0
	for <linux-block@archiver.kernel.org>; Fri, 29 May 2020 08:01:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93C1A208E4
	for <linux-block@archiver.kernel.org>; Fri, 29 May 2020 08:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590739263;
	bh=giR0IE67Snxey442VeABKQMcdqXUCCAfFzi0OqjBjlc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QKz5M/3YUaC+HRUD4M3+GlN1L0RfI4wXkI4nGVyh/PkkN9cAf3XMFIYpwloeMQUKy
	 LFn2kqh0WgssniAUooLsccZq0Sj476FMN5YWzk+AOzSqrqgUOQY/Xt7Zpl7DLvCMUs
	 p6qqr0GVAquRVWJQU/t1zv1RDkII+NbwUwif2Qp4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725306AbgE2IBB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 29 May 2020 04:01:01 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45724 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbgE2IBA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 May 2020 04:01:00 -0400
Received: by mail-pf1-f195.google.com with SMTP id z26so902416pfk.12
        for <linux-block@vger.kernel.org>; Fri, 29 May 2020 01:00:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zF2XyT+TD5AITbLfdEj+W1NTO5kNEdekbAm269lHPhI=;
        b=MjcGIOMIYl0kA7cu6avWERln8sT8b0IxEkBwUhRMMOCDB5etOlmnFL2y8nfEXyN5fM
         F0M9rHCxwyV4ElyLByT5rCR1nmHsibq6yWBxZppShVa4wMFaZqPRSfWiIwQyKZvqwx/4
         Snju6JihqT8fg4IFfz381NIHdxO+nqO+xcucX3FX8DEJeLHMo3y/3xtPQfb9FwH0dRG5
         o7g+F1as1Jap8qZe8/K+emxofP1EJhCeiSZYe07ze74J27mbmKjx+hmEjHAIKBYh/8UG
         IYUjTKtUWeXGRTRaAAzWmsg4YaFs7ddsMemdl3qMV/kBIBxNy7T2LUWIawQsb5B+QkFl
         l/Cg==
X-Gm-Message-State: AOAM531EwJL73Yldk4oqcckarLySNpnJuamF71faV5m59wuLoyYjnWuZ
        2rPqMDjMPlPkjsVdUVNZkXo=
X-Google-Smtp-Source: ABdhPJy+ukA6q22WpA8MwurXBNtikjDsd81z/hJNbttqq8IT9TSqLSUUduE8Wp3qaeYGULbjdrGPhA==
X-Received: by 2002:a63:7d4e:: with SMTP id m14mr7256948pgn.391.1590739259369;
        Fri, 29 May 2020 01:00:59 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id d22sm6332696pgh.64.2020.05.29.01.00.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 01:00:58 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id EC3734046C; Fri, 29 May 2020 08:00:56 +0000 (UTC)
Date:   Fri, 29 May 2020 08:00:56 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] blktrace: Avoid sparse warnings when assigning
 q->blk_trace
Message-ID: <20200529080056.GY11244@42.do-not-panic.com>
References: <20200528092910.11118-1-jack@suse.cz>
 <298af02a-3b58-932a-8769-72dcc52750ad@acm.org>
 <20200528183152.GH14550@quack2.suse.cz>
 <20200528184333.GU11244@42.do-not-panic.com>
 <20200528185539.GJ14550@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528185539.GJ14550@quack2.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, May 28, 2020 at 08:55:39PM +0200, Jan Kara wrote:
> On Thu 28-05-20 18:43:33, Luis Chamberlain wrote:
> > On Thu, May 28, 2020 at 08:31:52PM +0200, Jan Kara wrote:
> > > On Thu 28-05-20 07:44:38, Bart Van Assche wrote:
> > > > (+Luis)
> > > > 
> > > > On 2020-05-28 02:29, Jan Kara wrote:
> > > > > Mostly for historical reasons, q->blk_trace is assigned through xchg()
> > > > > and cmpxchg() atomic operations. Although this is correct, sparse
> > > > > complains about this because it violates rcu annotations. Furthermore
> > > > > there's no real need for atomic operations anymore since all changes to
> > > > > q->blk_trace happen under q->blk_trace_mutex. So let's just replace
> > > > > xchg() with rcu_replace_pointer() and cmpxchg() with explicit check and
> > > > > rcu_assign_pointer(). This makes the code more efficient and sparse
> > > > > happy.
> > > > > 
> > > > > Reported-by: kbuild test robot <lkp@intel.com>
> > > > > Signed-off-by: Jan Kara <jack@suse.cz>
> > > > 
> > > > How about adding a reference to commit c780e86dd48e ("blktrace: Protect
> > > > q->blk_trace with RCU") in the description of this patch?
> > > 
> > > Yes, that's probably a good idea.
> > > 
> > > > > @@ -1669,10 +1672,7 @@ static int blk_trace_setup_queue(struct request_queue *q,
> > > > >  
> > > > >  	blk_trace_setup_lba(bt, bdev);
> > > > >  
> > > > > -	ret = -EBUSY;
> > > > > -	if (cmpxchg(&q->blk_trace, NULL, bt))
> > > > > -		goto free_bt;
> > > > > -
> > > > > +	rcu_assign_pointer(q->blk_trace, bt);
> > > > >  	get_probe_ref();
> > > > >  	return 0;
> > > > 
> > > > This changes a conditional assignment of q->blk_trace into an
> > > > unconditional assignment. Shouldn't q->blk_trace only be assigned if
> > > > q->blk_trace == NULL?
> > > 
> > > Yes but both callers of blk_trace_setup_queue() actually check that
> > > q->blk_trace is NULL before calling blk_trace_setup_queue() and since we
> > > hold blk_trace_mutex all the time, the value of q->blk_trace cannot change.
> > > So the conditional assignment was just bogus.
> > 
> > If you run a blktrace against a different partition the check does have
> > an effect today. This is because the request_queue is shared between
> > partitions implicitly, even though they end up using a different struct
> > dentry. So the check is actually still needed, however my change adds
> > this check early as well so we don't do a memory allocation just to
> > throw it away.
> 
> I'm not sure we are speaking about the same check but I might be missing
> something. blk_trace_setup_queue() is only called from
> sysfs_blk_trace_attr_store(). That does:
> 
>         mutex_lock(&q->blk_trace_mutex);
> 
>         bt = rcu_dereference_protected(q->blk_trace,
>                                        lockdep_is_held(&q->blk_trace_mutex));
>         if (attr == &dev_attr_enable) {
>                 if (!!value == !!bt) {
>                         ret = 0;
>                         goto out_unlock_bdev;
>                 }
> 
> 		^^^ So if 'bt' is non-NULL, and we are enabling, we bail
> instead of calling blk_trace_setup_queue().
> 
> Similarly later:
> 
>         if (bt == NULL) {
>                 ret = blk_trace_setup_queue(q, bdev);
> 	...
> so we again call blk_trace_setup_queue() only if bt is NULL. So IMO the
> cmpxchg() in blk_trace_setup_queue() could never fail to set the value.
> Am I missing something?

I believe we are talking about the same check indeed. Consider the
situation not as a race, but instead consider the state machine of
the ioctl. The BLKTRACESETUP goes first, and when that is over we
have not ran BLKTRACESTART. So, prior to BLKTRACESTART we can have
another BLKTRACESETUP run but against another partition. At that
point we have two cases trying to use the same request_queue and
the same q->blk_trace, even though this was well protected with
the mutex.

And so the final check is needed to ensure we only give one of
the users the right to blktrace.

Did I misunderstand the check though?

  Luis
