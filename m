Return-Path: <SRS0=fuqo=B3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96889C433E1
	for <linux-block@archiver.kernel.org>; Mon, 17 Aug 2020 12:10:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77D4D2072E
	for <linux-block@archiver.kernel.org>; Mon, 17 Aug 2020 12:10:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727880AbgHQMKF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Aug 2020 08:10:05 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:48839 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726265AbgHQMKF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Aug 2020 08:10:05 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R801e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04427;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0U62Iq6A_1597666202;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0U62Iq6A_1597666202)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 17 Aug 2020 20:10:02 +0800
Date:   Mon, 17 Aug 2020 20:10:02 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, ming.lei@redhat.com, baolin.wang7@gmail.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND 3/5] block: Add a new helper to attempt to merge a
 bio
Message-ID: <20200817121002.GB79836@VM20190228-100.tbsite.net>
Reply-To: Baolin Wang <baolin.wang@linux.alibaba.com>
References: <cover.1597637287.git.baolin.wang@linux.alibaba.com>
 <5b932aa51fc2b46c381d7b83d591a6ddbf05b199.1597637287.git.baolin.wang@linux.alibaba.com>
 <20200817062634.GC12248@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200817062634.GC12248@lst.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Aug 17, 2020 at 08:26:34AM +0200, Christoph Hellwig wrote:
> On Mon, Aug 17, 2020 at 12:09:17PM +0800, Baolin Wang wrote:
> > There are lots of duplicated code when trying to merge a bio from
> > plug list and sw queue, we can introduce a new helper to attempt
> > to merge a bio, which can simplify the blk_mq_bio_list_merge()
> > and blk_attempt_plug_merge().
> 
> Looks sensible, but two comments:
> 
> > +enum bio_merge_status blk_attempt_bio_merge(struct request_queue *q,
> > +					    struct request *rq,
> > +					    struct bio *bio,
> > +					    unsigned int nr_segs)
> > +{
> > +	bool merged = false;
> > +
> > +	if (!blk_rq_merge_ok(rq, bio))
> > +		return BIO_MERGE_NONE;
> > +
> > +	switch (blk_try_merge(rq, bio)) {
> > +	case ELEVATOR_BACK_MERGE:
> > +		merged = bio_attempt_back_merge(rq, bio, nr_segs);
> > +		break;
> > +	case ELEVATOR_FRONT_MERGE:
> > +		merged = bio_attempt_front_merge(rq, bio, nr_segs);
> > +		break;
> > +	case ELEVATOR_DISCARD_MERGE:
> > +		merged = bio_attempt_discard_merge(q, rq, bio);
> > +		break;
> 
> Can't we also switch the bio_attempt_*merge helpers to return
> enum bio_merge_status to simplify this a bit?

Yes, will do.

> 
> Also I think these helpers can be marked static now, although I didn't
> actually apply your series, so I might have missed something.

Cause this function will be used by blk_mq_bio_list_merge() in
blk-mq-sched.c, it should be exported.

> 
> > +++ b/block/blk-mq-sched.c
> > @@ -391,31 +391,17 @@ bool blk_mq_bio_list_merge(struct request_queue *q, struct list_head *list,
> >  {
> >  	struct request *rq;
> >  	int checked = 8;
> > +	enum bio_merge_status merge;
> >  
> >  	list_for_each_entry_reverse(rq, list, queuelist) {
> > -		bool merged = false;
> > -
> >  		if (!checked--)
> >  			break;
> >  
> > +		merge = blk_attempt_bio_merge(q, rq, bio, nr_segs);
> > +		if (merge == BIO_MERGE_NONE)
> >  			continue;
> >  
> > +		return merge == BIO_MERGE_OK ? true: false;
> 
> Maybe write this a little more explicit:
> 
> 		switch (blk_attempt_bio_merge(q, rq, bio, nr_segs)) {
> 		case BIO_MERGE_NONE:
> 			continue:
> 		case BIO_MERGE_OK:
> 			return true;
> 		case BIO_MERGE_FAILED:
> 			return false;
> 		}

Sure.

> 
> >  enum elv_merge blk_try_merge(struct request *rq, struct bio *bio);
> >  
> > +enum bio_merge_status {
> > +	BIO_MERGE_OK,
> > +	BIO_MERGE_NONE,
> > +	BIO_MERGE_FAILED,
> > +};
> > +
> > +enum bio_merge_status blk_attempt_bio_merge(struct request_queue *q,
> > +		struct request *rq, struct bio *bio, unsigned int nr_segs);
> > +
> >  int blk_dev_init(void);
> >  
> >  /*
> > -- 
> > 1.8.3.1
> ---end quoted text---
