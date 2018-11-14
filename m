Return-Path: <SRS0=CiZa=NZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AD31C43441
	for <linux-block@archiver.kernel.org>; Wed, 14 Nov 2018 08:43:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F80A223DD
	for <linux-block@archiver.kernel.org>; Wed, 14 Nov 2018 08:43:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dHMvJcA8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F80A223DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727558AbeKNSpj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Nov 2018 13:45:39 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:52568 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727154AbeKNSpi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Nov 2018 13:45:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=KIpbN9opBYgxsa2QRZ3iWjgDy+QUvrhkoRzPxZ4J0z8=; b=dHMvJcA8p0PpcCIYrEGdp0xlK
        RImYUjy4UcnbBVeRtAUEEGzryNP7OW9WNK7/HeKNl1DlM6eH/AOFxEW7nx3PJBSX+dA+yI6E5vewx
        oTjWQoA6SqRVa0ERlvfdS/KwnpYk5FowHmu/Xm8z+fPa15AmecvtxuUS3OnV5rZoUMBvmXIzQz7Kn
        Nq/WKgfH8tbrK3VWFtg0Uu+ZaEqiNmrRnIqDMVo5uwCOiPr5ZYnRocDkHUhe9I9rBQ5DpVznAczuy
        5yZy/qiJJAoeCAHTTovxARdfQm5gBIOgLVUB0CyTbQZJi514w2+TjH80flUwy7K/D+EjmJsdaYSpm
        RVDhOcvCw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gMqle-0003tJ-Q1; Wed, 14 Nov 2018 08:43:22 +0000
Date:   Wed, 14 Nov 2018 00:43:22 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Keith Busch <keith.busch@intel.com>,
        linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/6] nvme: don't disable local ints for polled queue
Message-ID: <20181114084322.GA14954@infradead.org>
References: <20181110151317.3813-1-axboe@kernel.dk>
 <20181110151317.3813-2-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181110151317.3813-2-axboe@kernel.dk>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 6aa86dfcb32c..a6e3fbddfadf 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -1061,15 +1061,26 @@ static irqreturn_t nvme_irq_check(int irq, void *data)
>  
>  static int __nvme_poll(struct nvme_queue *nvmeq, unsigned int tag)
>  {
> +	unsigned long flags = 0; /* gcc 7.x fail */
>  	u16 start, end;
> -	bool found;
> +	bool found, has_irq;
>  
>  	if (!nvme_cqe_pending(nvmeq))
>  		return 0;
>  
> -	spin_lock_irq(&nvmeq->cq_lock);
> +	/*
> +	 * Polled queue doesn't have an IRQ, no need to disable ints
> +	 */
> +	has_irq = !nvmeq->polled;
> +	if (has_irq)
> +		local_irq_save(flags);
> +
> +	spin_lock(&nvmeq->cq_lock);
>  	found = nvme_process_cq(nvmeq, &start, &end, tag);
> -	spin_unlock_irq(&nvmeq->cq_lock);
> +	spin_unlock(&nvmeq->cq_lock);
> +
> +	if (has_irq)
> +		local_irq_restore(flags);

Eww, this just looks ugly.  Given that we are micro-optimizing here
I'd rather just use a different ->poll implementation and thus blk_mq_ops
if we have a separate poll code.  Then we could leave the existing
__nvme_poll as-is and have a new nvme_poll_noirq something like this:

static int nvme_poll_noirq(struct blk_mq_hw_ctx *hctx, unsigned int tag)
{
        struct nvme_queue *nvmeq = hctx->driver_data;
>  	u16 start, end;
	bool found;
>  
>  	if (!nvme_cqe_pending(nvmeq))
>  		return 0;
>  
> +	spin_lock(&nvmeq->cq_lock);
>  	found = nvme_process_cq(nvmeq, &start, &end, tag);
> +	spin_unlock(&nvmeq->cq_lock);
> +
>  	nvme_complete_cqes(nvmeq, start, end);
>  	return found;

And while we are at it:  I think for the irq-driven queuest in a
separate queue for poll setup we might not even need to take the
CQ lock.  Which might be an argument for only allowing polling
if we have the separate queues just to keep everything simple.
