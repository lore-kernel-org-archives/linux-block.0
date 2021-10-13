Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE6EDC433F5
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 07:13:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFDA560EDF
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 07:13:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbhJMHPk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Oct 2021 03:15:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbhJMHPk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Oct 2021 03:15:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BA4AC061570
        for <linux-block@vger.kernel.org>; Wed, 13 Oct 2021 00:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YIW8X/aLaMFY8kZSxmdCd4LemQb8nwnk4AXsiNFEflM=; b=WnXhX6ZX/9aqAevqNXG/HRhWtz
        uGrC6l+oQLo4lTQvnNR6QP7DKLDA4VOkjsxWHa+yxQE7GAsvN7RHsmtGgV/Jsz/yaDBpIXvzCscqr
        TGy+VYvKAjo3j7PMUA77AQ7g7P+O4e88QEZmFqD2W6/ITYw7Zkeow+teTJRUS5OpmZ7ekvwgPb8pA
        cQZ968gf+AmPvPyKKStm2Z2MbNPaAd4jehxhJOP9SDVHdpiPCLkM2VJqVDCHQgAcyk2yB3zv7h3z5
        tgWE/LFF8Q/J7AvsRiQW/fJwM3+hYnJ1U7h/PaMln5arwnUpYHbBQiclCgXjqPbOhfEwQHqOjrrQp
        OFfUOwOg==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1maYR7-007DBD-Fc; Wed, 13 Oct 2021 07:12:58 +0000
Date:   Wed, 13 Oct 2021 08:12:25 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: Re: [PATCH 9/9] nvme: wire up completion batching for the IRQ path
Message-ID: <YWaG2c9IAm1y3275@infradead.org>
References: <20211012181742.672391-1-axboe@kernel.dk>
 <20211012181742.672391-10-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211012181742.672391-10-axboe@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Oct 12, 2021 at 12:17:42PM -0600, Jens Axboe wrote:
> Trivial to do now, just need our own io_batch on the stack and pass that
> in to the usual command completion handling.
> 
> I pondered making this dependent on how many entries we had to process,
> but even for a single entry there's no discernable difference in
> performance or latency. Running a sync workload over io_uring:
> 
> t/io_uring -b512 -d1 -s1 -c1 -p0 -F1 -B1 -n2 /dev/nvme1n1 /dev/nvme2n1
> 
> yields the below performance before the patch:
> 
> IOPS=254820, BW=124MiB/s, IOS/call=1/1, inflight=(1 1)
> IOPS=251174, BW=122MiB/s, IOS/call=1/1, inflight=(1 1)
> IOPS=250806, BW=122MiB/s, IOS/call=1/1, inflight=(1 1)
> 
> and the following after:
> 
> IOPS=255972, BW=124MiB/s, IOS/call=1/1, inflight=(1 1)
> IOPS=251920, BW=123MiB/s, IOS/call=1/1, inflight=(1 1)
> IOPS=251794, BW=122MiB/s, IOS/call=1/1, inflight=(1 1)
> 
> which definitely isn't slower, about the same if you factor in a bit of
> variance. For peak performance workloads, benchmarking shows a 2%
> improvement.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>  drivers/nvme/host/pci.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 4713da708cd4..fb3de6f68eb1 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -1076,8 +1076,10 @@ static inline void nvme_update_cq_head(struct nvme_queue *nvmeq)
>  
>  static inline int nvme_process_cq(struct nvme_queue *nvmeq)
>  {
> +	struct io_batch ib;
>  	int found = 0;
>  
> +	ib.req_list = NULL;

Is this really more efficient than

	struct io_batch ib = { };

?
