Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91B08C433EF
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 05:03:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B05961027
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 05:03:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbhJMFFl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Oct 2021 01:05:41 -0400
Received: from verein.lst.de ([213.95.11.211]:44134 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229603AbhJMFFk (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Oct 2021 01:05:40 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id AF98C67373; Wed, 13 Oct 2021 07:03:35 +0200 (CEST)
Date:   Wed, 13 Oct 2021 07:03:35 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Keith Busch <kbusch@kernel.org>
Cc:     linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
        axboe@kernel.dk, linux-block@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: calculate IO timeout
Message-ID: <20211013050335.GA24898@lst.de>
References: <20211013022744.1357498-1-kbusch@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211013022744.1357498-1-kbusch@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Oct 12, 2021 at 07:27:44PM -0700, Keith Busch wrote:
>  e) Increase IO Timeout
> 
> This RFC implements option 'e', increasing the timeout. The timeout is
> calculated based on the largest possible outstanding data transfer
> against the device's available bandwidth. The link time is arbitrarily
> doubled to allow for additional device side latency and potential link
> sharing with another device.
> 
> The obvious downside to this option means it may take a long time for
> the driver to notice a stuck controller.

Besides the timeout the amount of data in flight also means horrible
tail latencies.  I suspect in the short run decrementing both the
maximum I/O size and maximum queue depth might be a good idea, preferably
based on looking at the link speed as your patch already does.  That is
based on the max timeout make sure we're not likely to exceed it.

In the long run we need to be able to do some throttling based on the
amount of data in flight.  I suspect blk-qos or an I/O scheduler would
be the right place for that.

> 
> Any other ideas?
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>  drivers/nvme/host/pci.c | 43 ++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 42 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 7fc992a99624..556aba525095 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -2424,6 +2424,40 @@ static bool __nvme_disable_io_queues(struct nvme_dev *dev, u8 opcode)
>  	return true;
>  }
>  
> +static u32 nvme_calculate_timeout(struct nvme_dev *dev)
> +{
> +	u32 timeout;
> +
> +	u32 max_bytes = dev->ctrl.max_hw_sectors << SECTOR_SHIFT;
> +
> +	u32 max_prps = DIV_ROUND_UP(max_bytes, NVME_CTRL_PAGE_SIZE);
> +	u32 max_prp_lists = DIV_ROUND_UP(max_prps * sizeof(__le64),
> +					 NVME_CTRL_PAGE_SIZE);
> +	u32 max_prp_list_size = NVME_CTRL_PAGE_SIZE * max_prp_lists;
> +
> +	u32 total_depth = dev->tagset.nr_hw_queues * dev->tagset.queue_depth;
> +
> +	/* Max outstanding NVMe data transfer scenario in MiB */
> +	u32 max_xfer = (total_depth * (max_bytes +
> +			   sizeof(struct nvme_command) +
> +			   sizeof(struct nvme_completion) +
> +			   max_prp_list_size + 16)) >> 20;
> +
> +	u32 bw = pcie_bandwidth_available(to_pci_dev(dev->dev), NULL, NULL,
> +					  NULL);
> +
> +	/*
> +	 * PCIe overhead based on worst case MPS achieves roughy 86% link
> +	 * efficiency.
> +	 */
> +	bw = bw * 86/ 100;
> +	timeout = DIV_ROUND_UP(max_xfer, bw);
> +
> +	/* Double the time to generously allow for device side overhead */
> +	return (2 * timeout) * HZ;
> +
> +}
> +
>  static void nvme_dev_add(struct nvme_dev *dev)
>  {
>  	int ret;
> @@ -2434,7 +2468,6 @@ static void nvme_dev_add(struct nvme_dev *dev)
>  		dev->tagset.nr_maps = 2; /* default + read */
>  		if (dev->io_queues[HCTX_TYPE_POLL])
>  			dev->tagset.nr_maps++;
> -		dev->tagset.timeout = NVME_IO_TIMEOUT;
>  		dev->tagset.numa_node = dev->ctrl.numa_node;
>  		dev->tagset.queue_depth = min_t(unsigned int, dev->q_depth,
>  						BLK_MQ_MAX_DEPTH) - 1;
> @@ -2442,6 +2475,14 @@ static void nvme_dev_add(struct nvme_dev *dev)
>  		dev->tagset.flags = BLK_MQ_F_SHOULD_MERGE;
>  		dev->tagset.driver_data = dev;
>  
> +		dev->tagset.timeout = max_t(unsigned int,
> +					    nvme_calculate_timeout(dev),
> +					    NVME_IO_TIMEOUT);
> +
> +		if (dev->tagset.timeout > NVME_IO_TIMEOUT)
> +			dev_warn(dev->ctrl.device,
> +				 "max possible latency exceeds default timeout:%u; set to %u\n",
> +				 NVME_IO_TIMEOUT, dev->tagset.timeout);
>  		/*
>  		 * Some Apple controllers requires tags to be unique
>  		 * across admin and IO queue, so reserve the first 32
> -- 
> 2.25.4
---end quoted text---
