Return-Path: <SRS0=cAVD=QH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A8F5C169C4
	for <linux-block@archiver.kernel.org>; Thu, 31 Jan 2019 09:26:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 032A120B1F
	for <linux-block@archiver.kernel.org>; Thu, 31 Jan 2019 09:26:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbfAaJ02 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 31 Jan 2019 04:26:28 -0500
Received: from mx2.suse.de ([195.135.220.15]:38478 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726172AbfAaJ02 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 31 Jan 2019 04:26:28 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B96B1AE04;
        Thu, 31 Jan 2019 09:26:26 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id BCADA1E3FFD; Thu, 31 Jan 2019 10:26:25 +0100 (CET)
Date:   Thu, 31 Jan 2019 10:26:25 +0100
From:   Jan Kara <jack@suse.cz>
To:     Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
Cc:     linux-block@vger.kernel.org, axboe@kernel.dk, jack@suse.cz
Subject: Re: [PATCH] blk-throttle: limit bios to fix amount of pages entering
 writeback prematurely
Message-ID: <20190131092625.GB19222@quack2.suse.cz>
References: <20181228115148.26474-1-xiaoguang.wang@linux.alibaba.com>
 <9d722c67-dfae-2ee4-74ef-504164fed0bf@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d722c67-dfae-2ee4-74ef-504164fed0bf@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi!

On Thu 31-01-19 10:03:34, Xiaoguang Wang wrote:
> > Currently in blk_throtl_bio(), if one bio exceeds its throtl_grp's bps
> > or iops limit, this bio will be queued throtl_grp's throtl_service_queue,
> > then obviously mm subsys will submit more pages, even underlying device
> > can not handle these io requests, also this will make large amount of pages
> > entering writeback prematurely, later if some process writes some of these
> > pages, it will wait for long time.
> > 
> > I have done some tests: one process does buffered writes on a 1GB file,
> > and make this process's blkcg max bps limit be 10MB/s, I observe this:
> > 	#cat /proc/meminfo  | grep -i back
> > 	Writeback:        900024 kB
> > 	WritebackTmp:          0 kB
> > 
> > I think this Writeback value is just too big, indeed many bios have been
> > queued in throtl_grp's throtl_service_queue, if one process try to write
> > the last bio's page in this queue, it will call wait_on_page_writeback(page),
> > which must wait the previous bios to finish and will take long time, we
> > have also see 120s hung task warning in our server.
> > 
> > To fix this issue, we can simply limit throtl_service_queue's max queued
> > bios, currently we limit it to throtl_grp's bps_limit or iops limit, if it
> > still exteeds, we just sleep for a while.
> Ping :)
> 
> The fix method in this patch is not good, I had written a new patch that
> uses wait queue, but do you think this is a blk-throttle design issue and
> needs fixing? thanks.

Well, essentially this is a priority inversion issue where low-priority
process submits writes and higher priority process blocks on those, isn't
it? I think the blk-wbt throttling was meant to address these issues by
throttling the process already when submitting bios (i.e. something similar
to what you propose in your patch). I'll defer to Jens as a maintainer
whether he wants to redirect users to blk-wbt or whether improving
blk-throttle to avoid similar issues is desirable. Jens?

								Honza

> > Signed-off-by: Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
> > ---
> >   block/blk-throttle.c       | 15 ++++++++++++++-
> >   include/linux/blk-cgroup.h | 15 ++++++++++++---
> >   2 files changed, 26 insertions(+), 4 deletions(-)
> > 
> > diff --git a/block/blk-throttle.c b/block/blk-throttle.c
> > index 627c40f89827..59fe58c3c411 100644
> > --- a/block/blk-throttle.c
> > +++ b/block/blk-throttle.c
> > @@ -81,6 +81,7 @@ struct throtl_service_queue {
> >   	 */
> >   	struct list_head	queued[2];	/* throtl_qnode [READ/WRITE] */
> >   	unsigned int		nr_queued[2];	/* number of queued bios */
> > +	unsigned int		nr_queued_bytes[2]; /* number of queued bytes */
> >   	/*
> >   	 * RB tree of active children throtl_grp's, which are sorted by
> > @@ -1251,6 +1252,7 @@ static void throtl_add_bio_tg(struct bio *bio, struct throtl_qnode *qn,
> >   	throtl_qnode_add_bio(bio, qn, &sq->queued[rw]);
> >   	sq->nr_queued[rw]++;
> > +	sq->nr_queued_bytes[rw] += throtl_bio_data_size(bio);
> >   	blkg_rwstat_add(&tg->total_bytes_queued, bio_op(bio), bio->bi_opf,
> >   			throtl_bio_data_size(bio));
> >   	blkg_rwstat_add(&tg->total_io_queued, bio_op(bio), bio->bi_opf, 1);
> > @@ -1307,6 +1309,7 @@ static void tg_dispatch_one_bio(struct throtl_grp *tg, bool rw)
> >   	 */
> >   	bio = throtl_pop_queued(&sq->queued[rw], &tg_to_put);
> >   	sq->nr_queued[rw]--;
> > +	sq->nr_queued_bytes[rw] -= throtl_bio_data_size(bio);
> >   	throtl_charge_bio(tg, bio);
> > @@ -2563,7 +2566,7 @@ static void blk_throtl_assoc_bio(struct throtl_grp *tg, struct bio *bio)
> >   }
> >   bool blk_throtl_bio(struct request_queue *q, struct blkcg_gq *blkg,
> > -		    struct bio *bio)
> > +		    struct bio *bio, unsigned long *wait)
> >   {
> >   	struct throtl_qnode *qn = NULL;
> >   	struct throtl_grp *orig_tg = blkg_to_tg(blkg ?: q->root_blkg);
> > @@ -2572,6 +2575,8 @@ bool blk_throtl_bio(struct request_queue *q, struct blkcg_gq *blkg,
> >   	bool rw = bio_data_dir(bio);
> >   	bool throttled = false;
> >   	struct throtl_data *td = tg->td;
> > +	u64 bps_limit;
> > +	unsigned int iops_limit;
> >   	WARN_ON_ONCE(!rcu_read_lock_held());
> > @@ -2654,6 +2659,14 @@ bool blk_throtl_bio(struct request_queue *q, struct blkcg_gq *blkg,
> >   		   sq->nr_queued[READ], sq->nr_queued[WRITE]);
> >   	td->nr_queued[rw]++;
> > +	bps_limit = tg_bps_limit(tg, rw);
> > +	if (bps_limit != U64_MAX && sq->nr_queued_bytes[rw] > bps_limit)
> > +		*wait = HZ * 90 / 100;
> > +
> > +	iops_limit = tg_iops_limit(tg, rw);
> > +	if (iops_limit != UINT_MAX && sq->nr_queued[rw] > iops_limit)
> > +		*wait = HZ * 90 / 100;
> > +
> >   	throtl_add_bio_tg(bio, qn, tg);
> >   	throttled = true;
> > diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
> > index 2634f3696ac2..dc2174330066 100644
> > --- a/include/linux/blk-cgroup.h
> > +++ b/include/linux/blk-cgroup.h
> > @@ -721,10 +721,13 @@ static inline void blkg_update_meta_stats(struct blkcg_gq *blkg)
> >   #ifdef CONFIG_BLK_DEV_THROTTLING
> >   extern bool blk_throtl_bio(struct request_queue *q, struct blkcg_gq *blkg,
> > -			   struct bio *bio);
> > +			   struct bio *bio, unsigned long *wait);
> >   #else
> >   static inline bool blk_throtl_bio(struct request_queue *q, struct blkcg_gq *blkg,
> > -				  struct bio *bio) { return false; }
> > +				  struct bio *bio, unsigned long *wait)
> > +{
> > +	return false;
> > +}
> >   #endif
> >   static inline bool blkcg_bio_issue_check(struct request_queue *q,
> > @@ -733,6 +736,7 @@ static inline bool blkcg_bio_issue_check(struct request_queue *q,
> >   	struct blkcg *blkcg;
> >   	struct blkcg_gq *blkg;
> >   	bool throtl = false;
> > +	unsigned long wait = 0;
> >   	rcu_read_lock();
> >   	blkcg = bio_blkcg(bio);
> > @@ -742,7 +746,7 @@ static inline bool blkcg_bio_issue_check(struct request_queue *q,
> >   	if (unlikely(IS_ERR(blkg)))
> >   		blkg = NULL;
> > -	throtl = blk_throtl_bio(q, blkg, bio);
> > +	throtl = blk_throtl_bio(q, blkg, bio, &wait);
> >   	spin_unlock_irq(q->queue_lock);
> >   	if (!throtl && !bio_flagged(bio, BIO_THROTL_COUNTED)) {
> > @@ -754,6 +758,11 @@ static inline bool blkcg_bio_issue_check(struct request_queue *q,
> >   	}
> >   	rcu_read_unlock();
> > +	if (wait > 0) {
> > +		__set_current_state(TASK_KILLABLE);
> > +		io_schedule_timeout(wait);
> > +	}
> > +
> >   	return !throtl;
> >   }
> > 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
