Return-Path: <linux-block-owner@vger.kernel.org>
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:55018 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933456AbeF2VmL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 Jun 2018 17:42:11 -0400
Date: Fri, 29 Jun 2018 14:41:56 -0700
From: Liu Bo <bo.liu@linux.alibaba.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Subject: Re: [PATCH] Block: initialize bio_cnt_ret_time for the first time
Message-ID: <20180629214156.3dasxt5t4cvfnxan@US-160370MP2.local>
Reply-To: bo.liu@linux.alibaba.com
References: <1529550424-105210-1-git-send-email-bo.liu@linux.alibaba.com>
 <17ed5986-02c8-42be-f832-04594a3bc202@kernel.dk>
 <20180629202338.vsnfx6wdy7zcjq6w@US-160370MP2.local>
 <49be208d-db81-b6ac-eaa9-161d17e84a3c@kernel.dk>
 <20180629204332.svgockhyhzr6xazl@US-160370MP2.local>
 <c68e7055-4f0c-9910-c924-7006ec67789c@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <c68e7055-4f0c-9910-c924-7006ec67789c@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Jun 29, 2018 at 02:46:27PM -0600, Jens Axboe wrote:
> On 6/29/18 2:43 PM, Liu Bo wrote:
> > On Fri, Jun 29, 2018 at 02:26:07PM -0600, Jens Axboe wrote:
> >> On 6/29/18 2:23 PM, Liu Bo wrote:
> >>> On Fri, Jun 29, 2018 at 02:00:01PM -0600, Jens Axboe wrote:
> >>>> On 6/20/18 9:07 PM, Liu Bo wrote:
> >>>>> When a new tg is created, tg->bio_cnt_ret_time is 0, so if the first
> >>>>> IO going thru this tg turns out to be a bad one, we fail to record it
> >>>>> in tg->bad_bio_cnt as
> >>>>>
> >>>>> if (jiffies > bio_cnt_ret_time) {
> >>>>> 	tg->bad_bio_cnt /= 2;
> >>>>> }
> >>>>
> >>>> Shouldn't we rather ensure that ->bio_cnt_ret_time is initialized to
> >>>> jiffies?
> >>>>
> >>>
> >>> Indeed, it's what the patch does, i.e. initialize tg->bio_cnt_reset_time to
> >>> jiffies on the first use.
> >>
> >> You do it on the first use, on the hot path, presumable. My suggestion
> >> was to do it when tg is instantiated instead. From a quick look, that
> >> would appear to be in throtl_pd_alloc().
> >>
> > 
> > Doing it when tg is instantiated would end up with the same problem.
> > 
> > 1) tg is instantiated, tg->bio_cnt_reset_time is set to jiffies.
> > (after a few jiffies...)
> > 2) the 1st IO gets dispatched and reaches endio.
> >   2.1) tg->bad_bio_cnt++ #if the IO's latency > threshold.
> >   2.2) if (jiffies > bio_cnt_reset_time)
> > 
> > At 2.2), (the jiffies at this point > tg->bio_cnt_reset_time).  If
> > this IO is a bad one, then tg->bad_bio_cnt would become 0 instead of 1
> > since we do tg->bad_bio_cnt /= 2 in the if statement.
> 
> That's kind of an ugly way to use it. How is it any different from when
> the tg has been idle for a while? There shouldn't be a need to special
> case this.

Yes, we can leave this corner case alone.

thanks,
-liubo
