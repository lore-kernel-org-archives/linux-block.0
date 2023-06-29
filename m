Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C8A7EB64D9
	for <linux-block@archiver.kernel.org>; Thu, 29 Jun 2023 05:32:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbjF2FcM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Jun 2023 01:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbjF2FcG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Jun 2023 01:32:06 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B129C1BE8;
        Wed, 28 Jun 2023 22:32:05 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2102F67373; Thu, 29 Jun 2023 07:32:02 +0200 (CEST)
Date:   Thu, 29 Jun 2023 07:32:01 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     chengming.zhou@linux.dev
Cc:     axboe@kernel.dk, tj@kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhouchengming@bytedance.com,
        ming.lei@redhat.com, hch@lst.de
Subject: Re: [PATCH v3 3/3] blk-mq: fix start_time_ns and alloc_time_ns for
 pre-allocated rq
Message-ID: <20230629053201.GF16819@lst.de>
References: <20230628124546.1056698-1-chengming.zhou@linux.dev> <20230628124546.1056698-4-chengming.zhou@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230628124546.1056698-4-chengming.zhou@linux.dev>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> +/* Set rq alloc and start time when pre-allocated rq is actually used */
> +static inline void blk_mq_rq_time_init(struct request_queue *q, struct request *rq)
> +{
> +	if (blk_mq_need_time_stamp(rq->rq_flags)) {
> +		u64 now = ktime_get_ns();
> +
> +#ifdef CONFIG_BLK_RQ_ALLOC_TIME
> +		/*
> +		 * alloc time is only used by iocost for now,
> +		 * only possible when blk_mq_need_time_stamp().
> +		 */
> +		if (blk_queue_rq_alloc_time(q))
> +			rq->alloc_time_ns = now;
> +#endif
> +		rq->start_time_ns = now;
> +	}
> +}

No need to pass q separately here, you can just use rq->q.

While you're at it please capitalize the first letter of block comments.

