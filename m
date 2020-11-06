Return-Path: <SRS0=ZSeo=EM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4819C2D0A3
	for <linux-block@archiver.kernel.org>; Fri,  6 Nov 2020 13:55:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BCA120735
	for <linux-block@archiver.kernel.org>; Fri,  6 Nov 2020 13:55:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="k16552k0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727317AbgKFNzf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 6 Nov 2020 08:55:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727093AbgKFNzf (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 6 Nov 2020 08:55:35 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 197F1C0613CF
        for <linux-block@vger.kernel.org>; Fri,  6 Nov 2020 05:55:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YLDzNESoEgKE1MzhkwepgEKB6SaZ/weGVd8fm6priQM=; b=k16552k0mzEOJReuMq3lkLtqUE
        16j/0qAT1BZvTmRGnYCX6LxOKmE3ehUYDFNdjjXMGAL/F4P17U/sy8OS/mDEscvzxT7Jg8pQnWQ7G
        32utRcIveVGJF+Svo7jE2VABBVDc2j+aInfUF6ljO/W5iVc87pXYhyML4nhmv3ktNpptdmQpFMMi+
        pm6+FG+Av8pcqekHEScUhLZn6tG238C1JTUAIX3S9NPqOcRjKghJvFoLGRKJB/1RHgb/e9TKl0q06
        D0dkLdPX5d/+L3w/LmN/9o+YvrhFBDt0pUZ36+qnYTLXZU02p+IQ8SzSvNPlB81PewLjY8F/YA25f
        ykzYzEhg==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kb2DE-0004cf-4b; Fri, 06 Nov 2020 13:55:32 +0000
Date:   Fri, 6 Nov 2020 13:55:32 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Damien Le Moal <damien.lemoal@wdc.com>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] null_blk: Fix scheduling in atomic with zoned mode
Message-ID: <20201106135532.GA16634@infradead.org>
References: <20201106110141.5887-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201106110141.5887-1-damien.lemoal@wdc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Nov 06, 2020 at 08:01:41PM +0900, Damien Le Moal wrote:
> Commit aa1c09cb65e2 ("null_blk: Fix locking in zoned mode") changed
> zone locking to using the potentially sleeping wait_on_bit_io()
> function. This is acceptable when memory backing is enabled as the
> device queue is in that case marked as blocking, but this triggers a
> scheduling while in atomic context with memory backing disabled.
> 
> Fix this by relying solely on the device zone spinlock for zone
> information protection without temporarily releasing this lock around
> null_process_cmd() execution in null_zone_write(). This is OK to do
> since when memory backing is disabled, command processing does not
> block and the memory backing lock nullb->lock is unused. This solution
> avoids the overhead of having to mark a zoned null_blk device queue as
> blocking when memory backing is unused.
> 
> This patch also adds comments to the zone locking code to explain the
> unusual locking scheme.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Fixes: aa1c09cb65e2 ("null_blk: Fix locking in zoned mode")
> Cc: stable@vger.kernel.org
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
> ---
>  drivers/block/null_blk.h       |  2 +-
>  drivers/block/null_blk_zoned.c | 47 ++++++++++++++++++++++------------
>  2 files changed, 32 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/block/null_blk.h b/drivers/block/null_blk.h
> index cfd00ad40355..c24d9b5ad81a 100644
> --- a/drivers/block/null_blk.h
> +++ b/drivers/block/null_blk.h
> @@ -47,7 +47,7 @@ struct nullb_device {
>  	unsigned int nr_zones_closed;
>  	struct blk_zone *zones;
>  	sector_t zone_size_sects;
> -	spinlock_t zone_dev_lock;
> +	spinlock_t zone_lock;
>  	unsigned long *zone_locks;
>  
>  	unsigned long size; /* device size in MB */
> diff --git a/drivers/block/null_blk_zoned.c b/drivers/block/null_blk_zoned.c
> index 8775acbb4f8f..beb34b4f76b0 100644
> --- a/drivers/block/null_blk_zoned.c
> +++ b/drivers/block/null_blk_zoned.c
> @@ -46,11 +46,20 @@ int null_init_zoned_dev(struct nullb_device *dev, struct request_queue *q)
>  	if (!dev->zones)
>  		return -ENOMEM;
>  
> -	spin_lock_init(&dev->zone_dev_lock);
> -	dev->zone_locks = bitmap_zalloc(dev->nr_zones, GFP_KERNEL);
> -	if (!dev->zone_locks) {
> -		kvfree(dev->zones);
> -		return -ENOMEM;
> +	/*
> +	 * With memory backing, the zone_lock spinlock needs to be temporarily
> +	 * released to avoid scheduling in atomic context. To guarantee zone
> +	 * information protection, use a bitmap to lock zones with
> +	 * wait_on_bit_lock_io(). Sleeping on the lock is OK as memory backing
> +	 * implies that the queue is marked with BLK_MQ_F_BLOCKING.
> +	 */
> +	spin_lock_init(&dev->zone_lock);
> +	if (dev->memory_backed) {
> +		dev->zone_locks = bitmap_zalloc(dev->nr_zones, GFP_KERNEL);
> +		if (!dev->zone_locks) {
> +			kvfree(dev->zones);
> +			return -ENOMEM;
> +		}
>  	}
>  
>  	if (dev->zone_nr_conv >= dev->nr_zones) {
> @@ -137,12 +146,17 @@ void null_free_zoned_dev(struct nullb_device *dev)
>  
>  static inline void null_lock_zone(struct nullb_device *dev, unsigned int zno)
>  {
> -	wait_on_bit_lock_io(dev->zone_locks, zno, TASK_UNINTERRUPTIBLE);
> +	if (dev->memory_backed)
> +		wait_on_bit_lock_io(dev->zone_locks, zno, TASK_UNINTERRUPTIBLE);
> +	spin_lock_irq(&dev->zone_lock);
>  }
>  
>  static inline void null_unlock_zone(struct nullb_device *dev, unsigned int zno)
>  {
> -	clear_and_wake_up_bit(zno, dev->zone_locks);
> +	spin_unlock_irq(&dev->zone_lock);
> +
> +	if (dev->memory_backed)
> +		clear_and_wake_up_bit(zno, dev->zone_locks);
>  }
>  
>  int null_report_zones(struct gendisk *disk, sector_t sector,
> @@ -322,7 +336,6 @@ static blk_status_t null_zone_write(struct nullb_cmd *cmd, sector_t sector,
>  		return null_process_cmd(cmd, REQ_OP_WRITE, sector, nr_sectors);
>  
>  	null_lock_zone(dev, zno);
> -	spin_lock(&dev->zone_dev_lock);
>  
>  	switch (zone->cond) {
>  	case BLK_ZONE_COND_FULL:
> @@ -375,9 +388,17 @@ static blk_status_t null_zone_write(struct nullb_cmd *cmd, sector_t sector,
>  	if (zone->cond != BLK_ZONE_COND_EXP_OPEN)
>  		zone->cond = BLK_ZONE_COND_IMP_OPEN;
>  
> -	spin_unlock(&dev->zone_dev_lock);
> +	/*
> +	 * Memory backing allocation may sleep: release the zone_lock spinlock
> +	 * to avoid scheduling in atomic context. Zone operation atomicity is
> +	 * still guaranteed through the zone_locks bitmap.
> +	 */
> +	if (dev->memory_backed)
> +		spin_unlock_irq(&dev->zone_lock);
>  	ret = null_process_cmd(cmd, REQ_OP_WRITE, sector, nr_sectors);
> -	spin_lock(&dev->zone_dev_lock);
> +	if (dev->memory_backed)
> +		spin_lock_irq(&dev->zone_lock);

Do we actually need to take zone_lock at all for the memory_backed
case?  Should the !memory_backed just use a per-zone spinlock?
