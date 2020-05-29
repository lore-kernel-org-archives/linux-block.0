Return-Path: <SRS0=yryn=7L=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AA67C433E0
	for <linux-block@archiver.kernel.org>; Fri, 29 May 2020 12:22:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EC9C2075A
	for <linux-block@archiver.kernel.org>; Fri, 29 May 2020 12:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590754940;
	bh=YkqNpX0oyedM5g7n/ol6GTNbe4YUq1VBJxtnBbNd/Ck=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=L/UazYXoYXVDszVFyJkpcyip1AldIxOSTrhic72BGKS+YdAYdMCpECYXYHcUc8qz/
	 +Fk4aeoL1Iesz0JJRL9SAqEqkKWwy47MUFnBFFKcWJz8fdwvKj8lA3XLbnSgPn1nrv
	 UJpNnhYSmWfJliRimQtxbsX2Cgp97A58AgGXKvww=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbgE2MWT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 29 May 2020 08:22:19 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:38854 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbgE2MWT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 May 2020 08:22:19 -0400
Received: by mail-pj1-f66.google.com with SMTP id t8so1272426pju.3
        for <linux-block@vger.kernel.org>; Fri, 29 May 2020 05:22:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MUnkPDrIFOgms+kKu0LHdG3ZkjVsG15BXxGzvf8C1P8=;
        b=G0Vw8ro8t3oL2/BeCn+bl3mxP/dIZZALrPf9wnjeSvhXDskx90wvWY58Xa1KBi5DQt
         w2fGKskEsEexg4gP43rx08GPiZ7btS1b/RtJeZg7X08p1vFN8cyFuQTZvDFuCJvGkgI+
         0grSkpq6GwGWNOsMGnaQx6giuAA8V9+qBbNe4gToKPVIloQm13lFx5P+H+TNixdmXRbd
         Gq4ibiU4vJ/r9kh34uEVeiBjzbXQuBhPv3L/RwrC735bopVWztAt/TO8/ez8qvTPbtHe
         /4qsJO6iC+LeZxN0Gwb1DU8V+d5CfpxSjCzwPysFO3rlN384q3PJSbOXCylA2yXimq/W
         zA8g==
X-Gm-Message-State: AOAM530UGnID95hsv2J+1/w9atgnaV2lH849W+ZoCgc9Ew/1K4KdDel+
        Qa+a6obdGzM88KgAqWcCdM4=
X-Google-Smtp-Source: ABdhPJwlHm3+/1MP0MQ0MZTB0CtUQotHy5faO26KMCxCc2xLKimBVnfBenuOZy44qgPhcf+TgWNn6A==
X-Received: by 2002:a17:90b:41d5:: with SMTP id jm21mr8579981pjb.96.1590754938261;
        Fri, 29 May 2020 05:22:18 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id x132sm7346000pfd.214.2020.05.29.05.22.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 05:22:17 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 782434046C; Fri, 29 May 2020 12:22:16 +0000 (UTC)
Date:   Fri, 29 May 2020 12:22:16 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] blktrace: Avoid sparse warnings when assigning
 q->blk_trace
Message-ID: <20200529122216.GF11244@42.do-not-panic.com>
References: <20200528092910.11118-1-jack@suse.cz>
 <298af02a-3b58-932a-8769-72dcc52750ad@acm.org>
 <20200528183152.GH14550@quack2.suse.cz>
 <20200528184333.GU11244@42.do-not-panic.com>
 <20200528185539.GJ14550@quack2.suse.cz>
 <20200529080056.GY11244@42.do-not-panic.com>
 <20200529090448.GN14550@quack2.suse.cz>
 <20200529114300.GA11244@42.do-not-panic.com>
 <20200529121114.GR14550@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200529121114.GR14550@quack2.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, May 29, 2020 at 02:11:14PM +0200, Jan Kara wrote:
> On Fri 29-05-20 11:43:00, Luis Chamberlain wrote:
> > On Fri, May 29, 2020 at 11:04:48AM +0200, Jan Kara wrote:
> > > On Fri 29-05-20 08:00:56, Luis Chamberlain wrote:
> > > > On Thu, May 28, 2020 at 08:55:39PM +0200, Jan Kara wrote:
> > > > > On Thu 28-05-20 18:43:33, Luis Chamberlain wrote:
> > > > > > On Thu, May 28, 2020 at 08:31:52PM +0200, Jan Kara wrote:
> > > > > > > On Thu 28-05-20 07:44:38, Bart Van Assche wrote:
> > > > > > > > (+Luis)
> > > > > > > > 
> > > > > > > > On 2020-05-28 02:29, Jan Kara wrote:
> > > > > > > > > Mostly for historical reasons, q->blk_trace is assigned through xchg()
> > > > > > > > > and cmpxchg() atomic operations. Although this is correct, sparse
> > > > > > > > > complains about this because it violates rcu annotations. Furthermore
> > > > > > > > > there's no real need for atomic operations anymore since all changes to
> > > > > > > > > q->blk_trace happen under q->blk_trace_mutex. So let's just replace
> > > > > > > > > xchg() with rcu_replace_pointer() and cmpxchg() with explicit check and
> > > > > > > > > rcu_assign_pointer(). This makes the code more efficient and sparse
> > > > > > > > > happy.
> > > > > > > > > 
> > > > > > > > > Reported-by: kbuild test robot <lkp@intel.com>
> > > > > > > > > Signed-off-by: Jan Kara <jack@suse.cz>
> > > > > > > > 
> > > > > > > > How about adding a reference to commit c780e86dd48e ("blktrace: Protect
> > > > > > > > q->blk_trace with RCU") in the description of this patch?
> > > > > > > 
> > > > > > > Yes, that's probably a good idea.
> > > > > > > 
> > > > > > > > > @@ -1669,10 +1672,7 @@ static int blk_trace_setup_queue(struct request_queue *q,
> > > > > > > > >  
> > > > > > > > >  	blk_trace_setup_lba(bt, bdev);
> > > > > > > > >  
> > > > > > > > > -	ret = -EBUSY;
> > > > > > > > > -	if (cmpxchg(&q->blk_trace, NULL, bt))
> > > > > > > > > -		goto free_bt;
> > > > > > > > > -
> > > > > > > > > +	rcu_assign_pointer(q->blk_trace, bt);
> > > > > > > > >  	get_probe_ref();
> > > > > > > > >  	return 0;
> > > > > > > > 
> > > > > > > > This changes a conditional assignment of q->blk_trace into an
> > > > > > > > unconditional assignment. Shouldn't q->blk_trace only be assigned if
> > > > > > > > q->blk_trace == NULL?
> > > > > > > 
> > > > > > > Yes but both callers of blk_trace_setup_queue() actually check that
> > > > > > > q->blk_trace is NULL before calling blk_trace_setup_queue() and since we
> > > > > > > hold blk_trace_mutex all the time, the value of q->blk_trace cannot change.
> > > > > > > So the conditional assignment was just bogus.
> > > > > > 
> > > > > > If you run a blktrace against a different partition the check does have
> > > > > > an effect today. This is because the request_queue is shared between
> > > > > > partitions implicitly, even though they end up using a different struct
> > > > > > dentry. So the check is actually still needed, however my change adds
> > > > > > this check early as well so we don't do a memory allocation just to
> > > > > > throw it away.
> > > > > 
> > > > > I'm not sure we are speaking about the same check but I might be missing
> > > > > something. blk_trace_setup_queue() is only called from
> > > > > sysfs_blk_trace_attr_store(). That does:
> > > > > 
> > > > >         mutex_lock(&q->blk_trace_mutex);
> > > > > 
> > > > >         bt = rcu_dereference_protected(q->blk_trace,
> > > > >                                        lockdep_is_held(&q->blk_trace_mutex));
> > > > >         if (attr == &dev_attr_enable) {
> > > > >                 if (!!value == !!bt) {
> > > > >                         ret = 0;
> > > > >                         goto out_unlock_bdev;
> > > > >                 }
> > > > > 
> > > > > 		^^^ So if 'bt' is non-NULL, and we are enabling, we bail
> > > > > instead of calling blk_trace_setup_queue().
> > > > > 
> > > > > Similarly later:
> > > > > 
> > > > >         if (bt == NULL) {
> > > > >                 ret = blk_trace_setup_queue(q, bdev);
> > > > > 	...
> > > > > so we again call blk_trace_setup_queue() only if bt is NULL. So IMO the
> > > > > cmpxchg() in blk_trace_setup_queue() could never fail to set the value.
> > > > > Am I missing something?
> > > > 
> > > > I believe we are talking about the same check indeed. Consider the
> > > > situation not as a race, but instead consider the state machine of
> > > > the ioctl. The BLKTRACESETUP goes first, and when that is over we
> > > > have not ran BLKTRACESTART. So, prior to BLKTRACESTART we can have
> > > > another BLKTRACESETUP run but against another partition.
> > > 
> > > So first note that BLKTRACESETUP goes through do_blk_trace_setup() while
> > > 'echo 1 >/sys/block/../trace/enable' goes through blk_trace_setup_queue().
> > > Although these operations achieve a very similar things, they are completely
> > > separate code paths. I was speaking about the second case while you are now
> > > speaking about the first one.
> > > 
> > > WRT to your BLKTRACESETUP example, the first BLKTRACESETUP will end up
> > > setting q->blk_trace to 'bt' so the second BLKTRACESETUP will see
> > > q->blk_trace is not NULL (my patch adds this check to do_blk_trace_setup()
> > > so we bail out earlier than during cmpxchg()) and fails. Again I don't see
> > > any problem here...
> > 
> > Ah, the patch I was CC'd on didn't contain this hunk! It only had the
> > change from cmpxchg() to the rcu_assign_pointer(), so I misunderstood
> > your intention, sorry!
> 
> Good that we are on the same page now :)

Yay!

> > In that case, I already proposed a patch to do that, and it also adds
> > a tiny bit of verbiage given we currently don't inform the user about
> > why this fails [0].
> 
> Honestly, I'm not sure pr_warn() you've added is that useful. We usually
> don't spam logs due to someone trying to use already used resource. But
> anyway, I can see other people are fine with that so I don't insist.

Well I would typically agree... however... 

It is in no way shape or form, not even in the blktrace documentation
that the request_queue / and therefore blktrace is shared between
partitions. Likewise for scsi-generic and say its respective block
device for TYPE_BLOCK.

If it is not obvious to some developer, it won't be obvious to users.
So *why* this fails really today is a mystery to users.

These limitations to the design of blktrace is not well documented
at all.

> > Let me know how you folks would like to proceed.
> 
> I guess I can rebase my patch on top of your series since that seems pretty
> much done.

I think so as well.

> I was aware of it but didn't realize there's a conflict...

Thanks for Bart for pointing it out!

  Luis
