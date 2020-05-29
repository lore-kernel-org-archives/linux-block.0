Return-Path: <SRS0=yryn=7L=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77E7EC433DF
	for <linux-block@archiver.kernel.org>; Fri, 29 May 2020 12:11:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 518F42074D
	for <linux-block@archiver.kernel.org>; Fri, 29 May 2020 12:11:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbgE2MLR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 29 May 2020 08:11:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:39242 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726767AbgE2MLR (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 May 2020 08:11:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 01F14AD94;
        Fri, 29 May 2020 12:11:14 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 93B3C1E1289; Fri, 29 May 2020 14:11:14 +0200 (CEST)
Date:   Fri, 29 May 2020 14:11:14 +0200
From:   Jan Kara <jack@suse.cz>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Bart Van Assche <bvanassche@acm.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH] blktrace: Avoid sparse warnings when assigning
 q->blk_trace
Message-ID: <20200529121114.GR14550@quack2.suse.cz>
References: <20200528092910.11118-1-jack@suse.cz>
 <298af02a-3b58-932a-8769-72dcc52750ad@acm.org>
 <20200528183152.GH14550@quack2.suse.cz>
 <20200528184333.GU11244@42.do-not-panic.com>
 <20200528185539.GJ14550@quack2.suse.cz>
 <20200529080056.GY11244@42.do-not-panic.com>
 <20200529090448.GN14550@quack2.suse.cz>
 <20200529114300.GA11244@42.do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200529114300.GA11244@42.do-not-panic.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri 29-05-20 11:43:00, Luis Chamberlain wrote:
> On Fri, May 29, 2020 at 11:04:48AM +0200, Jan Kara wrote:
> > On Fri 29-05-20 08:00:56, Luis Chamberlain wrote:
> > > On Thu, May 28, 2020 at 08:55:39PM +0200, Jan Kara wrote:
> > > > On Thu 28-05-20 18:43:33, Luis Chamberlain wrote:
> > > > > On Thu, May 28, 2020 at 08:31:52PM +0200, Jan Kara wrote:
> > > > > > On Thu 28-05-20 07:44:38, Bart Van Assche wrote:
> > > > > > > (+Luis)
> > > > > > > 
> > > > > > > On 2020-05-28 02:29, Jan Kara wrote:
> > > > > > > > Mostly for historical reasons, q->blk_trace is assigned through xchg()
> > > > > > > > and cmpxchg() atomic operations. Although this is correct, sparse
> > > > > > > > complains about this because it violates rcu annotations. Furthermore
> > > > > > > > there's no real need for atomic operations anymore since all changes to
> > > > > > > > q->blk_trace happen under q->blk_trace_mutex. So let's just replace
> > > > > > > > xchg() with rcu_replace_pointer() and cmpxchg() with explicit check and
> > > > > > > > rcu_assign_pointer(). This makes the code more efficient and sparse
> > > > > > > > happy.
> > > > > > > > 
> > > > > > > > Reported-by: kbuild test robot <lkp@intel.com>
> > > > > > > > Signed-off-by: Jan Kara <jack@suse.cz>
> > > > > > > 
> > > > > > > How about adding a reference to commit c780e86dd48e ("blktrace: Protect
> > > > > > > q->blk_trace with RCU") in the description of this patch?
> > > > > > 
> > > > > > Yes, that's probably a good idea.
> > > > > > 
> > > > > > > > @@ -1669,10 +1672,7 @@ static int blk_trace_setup_queue(struct request_queue *q,
> > > > > > > >  
> > > > > > > >  	blk_trace_setup_lba(bt, bdev);
> > > > > > > >  
> > > > > > > > -	ret = -EBUSY;
> > > > > > > > -	if (cmpxchg(&q->blk_trace, NULL, bt))
> > > > > > > > -		goto free_bt;
> > > > > > > > -
> > > > > > > > +	rcu_assign_pointer(q->blk_trace, bt);
> > > > > > > >  	get_probe_ref();
> > > > > > > >  	return 0;
> > > > > > > 
> > > > > > > This changes a conditional assignment of q->blk_trace into an
> > > > > > > unconditional assignment. Shouldn't q->blk_trace only be assigned if
> > > > > > > q->blk_trace == NULL?
> > > > > > 
> > > > > > Yes but both callers of blk_trace_setup_queue() actually check that
> > > > > > q->blk_trace is NULL before calling blk_trace_setup_queue() and since we
> > > > > > hold blk_trace_mutex all the time, the value of q->blk_trace cannot change.
> > > > > > So the conditional assignment was just bogus.
> > > > > 
> > > > > If you run a blktrace against a different partition the check does have
> > > > > an effect today. This is because the request_queue is shared between
> > > > > partitions implicitly, even though they end up using a different struct
> > > > > dentry. So the check is actually still needed, however my change adds
> > > > > this check early as well so we don't do a memory allocation just to
> > > > > throw it away.
> > > > 
> > > > I'm not sure we are speaking about the same check but I might be missing
> > > > something. blk_trace_setup_queue() is only called from
> > > > sysfs_blk_trace_attr_store(). That does:
> > > > 
> > > >         mutex_lock(&q->blk_trace_mutex);
> > > > 
> > > >         bt = rcu_dereference_protected(q->blk_trace,
> > > >                                        lockdep_is_held(&q->blk_trace_mutex));
> > > >         if (attr == &dev_attr_enable) {
> > > >                 if (!!value == !!bt) {
> > > >                         ret = 0;
> > > >                         goto out_unlock_bdev;
> > > >                 }
> > > > 
> > > > 		^^^ So if 'bt' is non-NULL, and we are enabling, we bail
> > > > instead of calling blk_trace_setup_queue().
> > > > 
> > > > Similarly later:
> > > > 
> > > >         if (bt == NULL) {
> > > >                 ret = blk_trace_setup_queue(q, bdev);
> > > > 	...
> > > > so we again call blk_trace_setup_queue() only if bt is NULL. So IMO the
> > > > cmpxchg() in blk_trace_setup_queue() could never fail to set the value.
> > > > Am I missing something?
> > > 
> > > I believe we are talking about the same check indeed. Consider the
> > > situation not as a race, but instead consider the state machine of
> > > the ioctl. The BLKTRACESETUP goes first, and when that is over we
> > > have not ran BLKTRACESTART. So, prior to BLKTRACESTART we can have
> > > another BLKTRACESETUP run but against another partition.
> > 
> > So first note that BLKTRACESETUP goes through do_blk_trace_setup() while
> > 'echo 1 >/sys/block/../trace/enable' goes through blk_trace_setup_queue().
> > Although these operations achieve a very similar things, they are completely
> > separate code paths. I was speaking about the second case while you are now
> > speaking about the first one.
> > 
> > WRT to your BLKTRACESETUP example, the first BLKTRACESETUP will end up
> > setting q->blk_trace to 'bt' so the second BLKTRACESETUP will see
> > q->blk_trace is not NULL (my patch adds this check to do_blk_trace_setup()
> > so we bail out earlier than during cmpxchg()) and fails. Again I don't see
> > any problem here...
> 
> Ah, the patch I was CC'd on didn't contain this hunk! It only had the
> change from cmpxchg() to the rcu_assign_pointer(), so I misunderstood
> your intention, sorry!

Good that we are on the same page now :)

> In that case, I already proposed a patch to do that, and it also adds
> a tiny bit of verbiage given we currently don't inform the user about
> why this fails [0].

Honestly, I'm not sure pr_warn() you've added is that useful. We usually
don't spam logs due to someone trying to use already used resource. But
anyway, I can see other people are fine with that so I don't insist.

> Let me know how you folks would like to proceed.

I guess I can rebase my patch on top of your series since that seems pretty
much done. I was aware of it but didn't realize there's a conflict...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
