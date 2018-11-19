Return-Path: <SRS0=iXKq=N6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83169C43441
	for <linux-block@archiver.kernel.org>; Mon, 19 Nov 2018 08:02:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41965206BB
	for <linux-block@archiver.kernel.org>; Mon, 19 Nov 2018 08:02:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dAuMhzsY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41965206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbeKSSZY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Nov 2018 13:25:24 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:59920 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726458AbeKSSZY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Nov 2018 13:25:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=6ipobVuzT0wqA+JK/KPh5323HYIee/YWE+MC/GnzB+w=; b=dAuMhzsYFKridv9JSeJLzptzi
        PWaCq+Jya4qPrQ1NKAg82lK750ohr5QM4muc9ok0Am03p9rdBTM6toU0DIkNIvWW5FtLdA6GBpzFn
        Tlv4aqjrNbDf5xiR5lkSENSgawSLOCxXJ9DiG6CWqbKOkFSUy9cMUw22hKDlfIv1VuLyJJUpN+0Q1
        xUfa6Uo3sNviFdAgOBOnU5VtdcfCyTFo95FJ/5wsepVMPnpV7+4CJvTunNgaFYkeDa9TwpUkzy58n
        CRVe5AfJzWymPRTT+0png+2uUxMvUjCHqo2QaWVNwfyy5rIFYSKe2YcfJGvJSUnEo1KsxCDDu60aq
        mFtlM0ulw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gOeVt-0004ow-8f; Mon, 19 Nov 2018 08:02:33 +0000
Date:   Mon, 19 Nov 2018 00:02:33 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 4/7] blk-mq: when polling for IO, look for any completion
Message-ID: <20181119080233.GD9622@infradead.org>
References: <20181117214354.822-1-axboe@kernel.dk>
 <20181117214354.822-5-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181117214354.822-5-axboe@kernel.dk>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 52b1c97cd7c6..3ca00d712158 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -3266,9 +3266,7 @@ static bool blk_mq_poll_hybrid_sleep(struct request_queue *q,
>  	 *  0:	use half of prev avg
>  	 * >0:	use this specific value
>  	 */
> -	if (q->poll_nsec == -1)
> -		return false;
> -	else if (q->poll_nsec > 0)
> +	if (q->poll_nsec > 0)
>  		nsecs = q->poll_nsec;
>  	else
>  		nsecs = blk_mq_poll_nsecs(q, hctx, rq);

The above comment now doesn't match the code here as the -1 case
is handled elsewhere.

> +static int __blk_mq_poll(struct blk_mq_hw_ctx *hctx)
>  {
>  	struct request_queue *q = hctx->queue;
>  	long state;

Can you merge __blk_mq_poll into blk_mq_poll now that blk_mq_poll
is pretty trivial?

>  static void nvme_rdma_recv_done(struct ib_cq *cq, struct ib_wc *wc)
>  {
> -	__nvme_rdma_recv_done(cq, wc, -1);
> +	__nvme_rdma_recv_done(cq, wc);
>  }

__nvme_rdma_recv_done and nvme_rdma_recv_done can be merged now.

>  static int nvme_rdma_conn_established(struct nvme_rdma_queue *queue)
> @@ -1758,10 +1752,12 @@ static int nvme_rdma_poll(struct blk_mq_hw_ctx *hctx, unsigned int tag)
>  		struct ib_cqe *cqe = wc.wr_cqe;
>  
>  		if (cqe) {
> -			if (cqe->done == nvme_rdma_recv_done)
> -				found |= __nvme_rdma_recv_done(cq, &wc, tag);
> -			else
> +			if (cqe->done == nvme_rdma_recv_done) {
> +				__nvme_rdma_recv_done(cq, &wc);
> +				found++;
> +			} else {
>  				cqe->done(cq, &wc);
> +			}

And we should probably look into separate poll queues for RDMA as well
while we're at it.
