Return-Path: <SRS0=fuqo=B3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EB70C433E1
	for <linux-block@archiver.kernel.org>; Mon, 17 Aug 2020 06:26:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8044520772
	for <linux-block@archiver.kernel.org>; Mon, 17 Aug 2020 06:26:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbgHQG0h (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Aug 2020 02:26:37 -0400
Received: from verein.lst.de ([213.95.11.211]:55179 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726451AbgHQG0h (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Aug 2020 02:26:37 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9A73468B05; Mon, 17 Aug 2020 08:26:34 +0200 (CEST)
Date:   Mon, 17 Aug 2020 08:26:34 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     axboe@kernel.dk, ming.lei@redhat.com, hch@lst.de,
        baolin.wang7@gmail.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND 3/5] block: Add a new helper to attempt to merge
 a bio
Message-ID: <20200817062634.GC12248@lst.de>
References: <cover.1597637287.git.baolin.wang@linux.alibaba.com> <5b932aa51fc2b46c381d7b83d591a6ddbf05b199.1597637287.git.baolin.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b932aa51fc2b46c381d7b83d591a6ddbf05b199.1597637287.git.baolin.wang@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Aug 17, 2020 at 12:09:17PM +0800, Baolin Wang wrote:
> There are lots of duplicated code when trying to merge a bio from
> plug list and sw queue, we can introduce a new helper to attempt
> to merge a bio, which can simplify the blk_mq_bio_list_merge()
> and blk_attempt_plug_merge().

Looks sensible, but two comments:

> +enum bio_merge_status blk_attempt_bio_merge(struct request_queue *q,
> +					    struct request *rq,
> +					    struct bio *bio,
> +					    unsigned int nr_segs)
> +{
> +	bool merged = false;
> +
> +	if (!blk_rq_merge_ok(rq, bio))
> +		return BIO_MERGE_NONE;
> +
> +	switch (blk_try_merge(rq, bio)) {
> +	case ELEVATOR_BACK_MERGE:
> +		merged = bio_attempt_back_merge(rq, bio, nr_segs);
> +		break;
> +	case ELEVATOR_FRONT_MERGE:
> +		merged = bio_attempt_front_merge(rq, bio, nr_segs);
> +		break;
> +	case ELEVATOR_DISCARD_MERGE:
> +		merged = bio_attempt_discard_merge(q, rq, bio);
> +		break;

Can't we also switch the bio_attempt_*merge helpers to return
enum bio_merge_status to simplify this a bit?

Also I think these helpers can be marked static now, although I didn't
actually apply your series, so I might have missed something.

> +++ b/block/blk-mq-sched.c
> @@ -391,31 +391,17 @@ bool blk_mq_bio_list_merge(struct request_queue *q, struct list_head *list,
>  {
>  	struct request *rq;
>  	int checked = 8;
> +	enum bio_merge_status merge;
>  
>  	list_for_each_entry_reverse(rq, list, queuelist) {
> -		bool merged = false;
> -
>  		if (!checked--)
>  			break;
>  
> +		merge = blk_attempt_bio_merge(q, rq, bio, nr_segs);
> +		if (merge == BIO_MERGE_NONE)
>  			continue;
>  
> +		return merge == BIO_MERGE_OK ? true: false;

Maybe write this a little more explicit:

		switch (blk_attempt_bio_merge(q, rq, bio, nr_segs)) {
		case BIO_MERGE_NONE:
			continue:
		case BIO_MERGE_OK:
			return true;
		case BIO_MERGE_FAILED:
			return false;
		}

>  enum elv_merge blk_try_merge(struct request *rq, struct bio *bio);
>  
> +enum bio_merge_status {
> +	BIO_MERGE_OK,
> +	BIO_MERGE_NONE,
> +	BIO_MERGE_FAILED,
> +};
> +
> +enum bio_merge_status blk_attempt_bio_merge(struct request_queue *q,
> +		struct request *rq, struct bio *bio, unsigned int nr_segs);
> +
>  int blk_dev_init(void);
>  
>  /*
> -- 
> 1.8.3.1
---end quoted text---
