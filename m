Return-Path: <SRS0=YNow=BH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F6FBC433E1
	for <linux-block@archiver.kernel.org>; Tue, 28 Jul 2020 10:57:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 365A6204EA
	for <linux-block@archiver.kernel.org>; Tue, 28 Jul 2020 10:57:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728688AbgG1K5o (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Jul 2020 06:57:44 -0400
Received: from verein.lst.de ([213.95.11.211]:47766 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728588AbgG1K5o (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Jul 2020 06:57:44 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id AC52D68C4E; Tue, 28 Jul 2020 12:57:41 +0200 (CEST)
Date:   Tue, 28 Jul 2020 12:57:41 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Chao Leng <lengchao@huawei.com>,
        Keith Busch <kbusch@kernel.org>, Ming Lin <mlin@kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v5 1/2] blk-mq: add tagset quiesce interface
Message-ID: <20200728105741.GA29763@lst.de>
References: <20200727231022.307602-1-sagi@grimberg.me> <20200727231022.307602-2-sagi@grimberg.me> <20200728071859.GA21629@lst.de> <20200728091633.GB1326626@T590> <b1e7c2c5-dad5-778c-f397-6530766a0150@grimberg.me> <20200728093326.GC1326626@T590> <44f07df6-3107-3e7f-ee02-7bc43293ee6b@grimberg.me> <6a678d5d-22b2-5238-92c5-d68e2aafeb9e@grimberg.me> <20200728101042.GA1336890@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200728101042.GA1336890@T590>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jul 28, 2020 at 06:10:42PM +0800, Ming Lei wrote:
> +	struct blk_mq_hw_ctx *hctx = (void *)srcu -
> +		sizeof(struct blk_mq_hw_ctx);

I think this should use container_of.

> +{
> +	struct blk_mq_hw_ctx *hctx;
> +	unsigned int i;
> +
> +	blk_mq_quiesce_queue_nowait(q);
> +
> +	queue_for_each_hw_ctx(q, hctx, i) {
> +		WARN_ON_ONCE(!(hctx->flags & BLK_MQ_F_BLOCKING));
> +		init_rcu_head(&hctx->srcu->head);

We only need to initialize the rcu head once when we allocate the hctx.

> +	mutex_lock(&set->tag_list_lock);
> +	if (set->flags & BLK_MQ_F_BLOCKING) {
> +		int count = 0;
> +
> +		list_for_each_entry(q, &set->tag_list, tag_set_list)
> +			count++;
> +
> +		atomic_set(&set->quiesce_count, count);
> +		init_completion(&set->quiesce_completion);
> +
> +		list_for_each_entry(q, &set->tag_list, tag_set_list)
> +			blk_mq_quiesce_blocking_queue_async(q);
> +		wait_for_completion(&set->quiesce_completion);
> +	} else {
> +		list_for_each_entry(q, &set->tag_list, tag_set_list)
> +			blk_mq_quiesce_queue_nowait(q);
> +		synchronize_rcu();
> +	}
> +	mutex_unlock(&set->tag_list_lock);

It would be great to do the wait_for_completion and synchronize_rcu
outside the lock.  Also I think the blocking case probably wants to be
split into a separate little helper.
