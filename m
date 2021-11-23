Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBE84C433F5
	for <linux-block@archiver.kernel.org>; Tue, 23 Nov 2021 16:41:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235834AbhKWQow (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Nov 2021 11:44:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235742AbhKWQoq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Nov 2021 11:44:46 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91B31C06174A
        for <linux-block@vger.kernel.org>; Tue, 23 Nov 2021 08:41:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RaHtB32ggyD5nAFwuZTY9Zw9tmP1D0k5vRNWl6iycxM=; b=M0SlQjErRoyrv/pHvDFZ9Daone
        Xjmv9ugGNr55UMVw+eg05JX3DyKReYv8d4t6MpJwDPuDYS9yhFidvosb0CNjdI2wCfdsDw2FR4SSO
        pqLzIH8sXoQKAXlOeiNeTG2zSEhPaQxc5rGzYDYF6VyYkt9ZLbeiswIwNYm/lNVDGmzzw/TRneMFl
        U06BOo7h1uZ5F7cXmDgYc0U6+EhvNBRzncFnv9RvOqq6kjhK8/MLLhgO5ewiNzoFQIsp0q8ROz3K9
        qbcQphhuAwYoftXNam6T3BNbmjD2UIVUQWXRMBgeW+x1w77TxI9aNW8sz2a/2cKuWMK6xplRfwl6C
        ZFnN+FaA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mpYrM-002x1D-8c; Tue, 23 Nov 2021 16:41:32 +0000
Date:   Tue, 23 Nov 2021 08:41:32 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: Re: [PATCH 3/3] block: only allocate poll_stats if there's a user of
 them
Message-ID: <YZ0ZvJMKlHOjMckv@infradead.org>
References: <20211123161813.326307-1-axboe@kernel.dk>
 <20211123161813.326307-4-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211123161813.326307-4-axboe@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Nov 23, 2021 at 09:18:13AM -0700, Jens Axboe wrote:
> This is essentially never used, yet it's about 1/3rd of the total
> queue size. Allocate it when needed, and don't embed it in the queue.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>  block/blk-mq.c         | 20 ++++++++++++++++++--
>  block/blk-stat.c       |  6 ------
>  block/blk-sysfs.c      |  1 +
>  include/linux/blkdev.h |  9 +++++++--
>  4 files changed, 26 insertions(+), 10 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 20a6445f6a01..cb41c441aa8f 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -4577,9 +4577,25 @@ EXPORT_SYMBOL_GPL(blk_mq_update_nr_hw_queues);
>  /* Enable polling stats and return whether they were already enabled. */
>  static bool blk_poll_stats_enable(struct request_queue *q)
>  {
> -	if (test_bit(QUEUE_FLAG_POLL_STATS, &q->queue_flags) ||
> -	    blk_queue_flag_test_and_set(QUEUE_FLAG_POLL_STATS, q))
> +	struct blk_rq_stat *poll_stat;
> +
> +	if (test_bit(QUEUE_FLAG_POLL_STATS, &q->queue_flags))
>  		return true;

Can't we replace the checks for QUEUE_FLAG_POLL_STATS with checks for
q->poll_stat now?
