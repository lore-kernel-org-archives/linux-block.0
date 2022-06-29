Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 258E5C43334
	for <linux-block@archiver.kernel.org>; Wed, 29 Jun 2022 08:37:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbiF2Ihu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Jun 2022 04:37:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232821AbiF2Ihr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Jun 2022 04:37:47 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 741433C738
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 01:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1656491865; x=1688027865;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=kezbHxfNzbR5iY5/NhbYEP+PF0RaMJ4op2b1525COrM=;
  b=T2B8oI+XYxWQ54nT9sOIIK/Z9yg8bBTIU8FKwyIf6f1Kx8E0egXicU9i
   Yy0d9OWFGPPKhTHvT5I4pTyX/4wjG7IyH3U4Sz6WjhgHwo2Z7tLeuaOLY
   yAPv7JKGRkBN29lCwD30lx4AIa0EaHSuvdaNKkstXqbljIW3AC5y3glUE
   dSNGaITeZFX1BR4XLIasDMsL2Kd4rvbqJu4ku0HcWYHlb/I0QE262UKTZ
   njszUaPLiG65qNMwRy84nr29twWt+DDOhtLjuvgjRKklht35z+Vag8XEq
   MQtLlxHi7Awlgwm5YxB5yWDxJ2oQJnf9p2KkIkwEGXYwrI2XWpNReGNuL
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,231,1650902400"; 
   d="scan'208";a="209239688"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 29 Jun 2022 16:37:45 +0800
IronPort-SDR: zCS0gLuRwfjYU6aTteldYyy4MZiyNdAOwb2OvhhUnzxxGWIGa0z3mIIPGU8OHiTPxi9WH/1SD3
 nNnd9Z8EpIvEHUBd/NTqSnKEkKe9GsmzHZziXNZJScGKLFBxIOjl81r+YfLIyMBMmX/2BBPEM1
 lj511sVzk5jbFhCJbMc1HZMEP+7aCIsRg/zSF/gXojSwhMAYUudHCGVAbAZX476G2PT9iD9CZP
 JyM6B7iktNWpHowyvd8tsmp+FLwcrWa0eGxuDo9MTKe+g3TMVye3ZlVwAVep4H+Jdm+h9cAr/p
 bDxgbI6vHwBg6bra1Bkn5KRF
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Jun 2022 00:55:24 -0700
IronPort-SDR: TqWJY+4Yl5YEpcTjabOOaDsC/7GzJG/o4RobW1sPOdf1yT1QIMoJ61TTwpKRz5e6vE4bw8wLNF
 IMsLMZG30KjlxYucvJ6D543ieZy1zqifk+tbAcZBOnNGKiga9HFTMhpJq2M/AhRAqHNUss/N/H
 5tQ8jUJbBzvwa2gdMF91DMHiOJXA9oS+DrwW6fB4EGu28XAAHvhCtXgyHm0gdXtiSP/NIOl4Dw
 JACcycgreQ4TxH29rV10za9WN9xBAvTE5YF/x6fod0Yjrhdz+n9hogqjFkHx5bLzUm3D7+Vapc
 N/M=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Jun 2022 01:37:46 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LXvwn3Yjpz1Rwnm
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 01:37:45 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1656491864; x=1659083865; bh=kezbHxfNzbR5iY5/NhbYEP+PF0RaMJ4op2b
        1525COrM=; b=b+V0kGi/2Pi/KH54WFNc7SOUsenyzPgsgnM7iZdLAFCwil0UwpO
        kF/6jMh3uaGOCj8WjvrwkWrJ6r0w8P1lJ+iD42pklngJO3CbIz33kWVahyyxJqf9
        WwqsZ3wItosqdQDiPtOajQSPcndhAsntReFqYOUU7dGchriGxPZ31+h6lCVPT80T
        n/KMrdye2GtYLxaHUBM0MVzS9ccFTvi3USlFGiV8ykPoYxgn+awuHdCrFs//3zhS
        f5tuxk2NeO6Xu5ghhWsPLGn9temzuNkycVcALcFK1LOqGRPU868HBVDsxp2y6+sd
        urhRL3AXjg5cMpriYq06cohAUWmgk4svGhw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 5M_F8ZYLgOzm for <linux-block@vger.kernel.org>;
        Wed, 29 Jun 2022 01:37:44 -0700 (PDT)
Received: from [10.225.163.99] (unknown [10.225.163.99])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LXvwm38cRz1Rw4L;
        Wed, 29 Jun 2022 01:37:44 -0700 (PDT)
Message-ID: <b3459202-62d1-ac5c-67e4-3b36f13dd824@opensource.wdc.com>
Date:   Wed, 29 Jun 2022 17:37:43 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 2/2] block: simplify disk_set_independent_access_ranges
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
References: <20220629062013.1331068-1-hch@lst.de>
 <20220629062013.1331068-3-hch@lst.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220629062013.1331068-3-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/29/22 15:20, Christoph Hellwig wrote:
> Lift setting disk->ia_ranges from disk_register_independent_access_ranges
> into disk_set_independent_access_ranges, and make the behavior the same
> for the registered vs non-registered queue cases.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

> ---
>  block/blk-ia-ranges.c | 57 ++++++++++++-------------------------------
>  block/blk-sysfs.c     |  2 +-
>  block/blk.h           |  3 +--
>  3 files changed, 18 insertions(+), 44 deletions(-)
> 
> diff --git a/block/blk-ia-ranges.c b/block/blk-ia-ranges.c
> index c1bf14bcd15f4..2bd1d311033b5 100644
> --- a/block/blk-ia-ranges.c
> +++ b/block/blk-ia-ranges.c
> @@ -102,31 +102,18 @@ static struct kobj_type blk_ia_ranges_ktype = {
>   * disk_register_independent_access_ranges - register with sysfs a set of
>   *		independent access ranges
>   * @disk:	Target disk
> - * @new_iars:	New set of independent access ranges
>   *
>   * Register with sysfs a set of independent access ranges for @disk.
> - * If @new_iars is not NULL, this set of ranges is registered and the old set
> - * specified by disk->ia_ranges is unregistered. Otherwise, disk->ia_ranges is
> - * registered if it is not already.
>   */
> -int disk_register_independent_access_ranges(struct gendisk *disk,
> -				struct blk_independent_access_ranges *new_iars)
> +int disk_register_independent_access_ranges(struct gendisk *disk)
>  {
> +	struct blk_independent_access_ranges *iars = disk->ia_ranges;
>  	struct request_queue *q = disk->queue;
> -	struct blk_independent_access_ranges *iars;
>  	int i, ret;
>  
>  	lockdep_assert_held(&q->sysfs_dir_lock);
>  	lockdep_assert_held(&q->sysfs_lock);
>  
> -	/* If a new range set is specified, unregister the old one */
> -	if (new_iars) {
> -		if (disk->ia_ranges)
> -			disk_unregister_independent_access_ranges(disk);
> -		disk->ia_ranges = new_iars;
> -	}
> -
> -	iars = disk->ia_ranges;
>  	if (!iars)
>  		return 0;
>  
> @@ -210,6 +197,9 @@ static bool disk_check_ia_ranges(struct gendisk *disk,
>  	sector_t sector = 0;
>  	int i;
>  
> +	if (WARN_ON_ONCE(!iars->nr_ia_ranges))
> +		return false;
> +
>  	/*
>  	 * While sorting the ranges in increasing LBA order, check that the
>  	 * ranges do not overlap, that there are no sector holes and that all
> @@ -298,25 +288,15 @@ void disk_set_independent_access_ranges(struct gendisk *disk,
>  {
>  	struct request_queue *q = disk->queue;
>  
> -	if (WARN_ON_ONCE(iars && !iars->nr_ia_ranges)) {
> +	mutex_lock(&q->sysfs_dir_lock);
> +	mutex_lock(&q->sysfs_lock);
> +	if (iars && !disk_check_ia_ranges(disk, iars)) {
>  		kfree(iars);
>  		iars = NULL;
>  	}
> -
> -	mutex_lock(&q->sysfs_dir_lock);
> -	mutex_lock(&q->sysfs_lock);
> -
> -	if (iars) {
> -		if (!disk_check_ia_ranges(disk, iars)) {
> -			kfree(iars);
> -			iars = NULL;
> -			goto reg;
> -		}
> -
> -		if (!disk_ia_ranges_changed(disk, iars)) {
> -			kfree(iars);
> -			goto unlock;
> -		}
> +	if (iars && !disk_ia_ranges_changed(disk, iars)) {
> +		kfree(iars);
> +		goto unlock;
>  	}
>  
>  	/*
> @@ -324,17 +304,12 @@ void disk_set_independent_access_ranges(struct gendisk *disk,
>  	 * revalidation. If that is the case, we need to unregister the old
>  	 * set of independent access ranges and register the new set. If the
>  	 * queue is not registered, registration of the device request queue
> -	 * will register the independent access ranges, so only swap in the
> -	 * new set and free the old one.
> +	 * will register the independent access ranges.
>  	 */
> -reg:
> -	if (blk_queue_registered(q)) {
> -		disk_register_independent_access_ranges(disk, iars);
> -	} else {
> -		swap(disk->ia_ranges, iars);
> -		kfree(iars);
> -	}
> -
> +	disk_unregister_independent_access_ranges(disk);
> +	disk->ia_ranges = iars;
> +	if (blk_queue_registered(q))
> +		disk_register_independent_access_ranges(disk);
>  unlock:
>  	mutex_unlock(&q->sysfs_lock);
>  	mutex_unlock(&q->sysfs_dir_lock);
> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
> index 85ea43eff094c..58cb9cb9f48cd 100644
> --- a/block/blk-sysfs.c
> +++ b/block/blk-sysfs.c
> @@ -832,7 +832,7 @@ int blk_register_queue(struct gendisk *disk)
>  		blk_mq_debugfs_register(q);
>  	mutex_unlock(&q->debugfs_mutex);
>  
> -	ret = disk_register_independent_access_ranges(disk, NULL);
> +	ret = disk_register_independent_access_ranges(disk);
>  	if (ret)
>  		goto put_dev;
>  
> diff --git a/block/blk.h b/block/blk.h
> index 74d59435870cb..58ad50cacd2d5 100644
> --- a/block/blk.h
> +++ b/block/blk.h
> @@ -459,8 +459,7 @@ long compat_blkdev_ioctl(struct file *file, unsigned cmd, unsigned long arg);
>  
>  extern const struct address_space_operations def_blk_aops;
>  
> -int disk_register_independent_access_ranges(struct gendisk *disk,
> -				struct blk_independent_access_ranges *new_iars);
> +int disk_register_independent_access_ranges(struct gendisk *disk);
>  void disk_unregister_independent_access_ranges(struct gendisk *disk);
>  
>  #ifdef CONFIG_FAIL_MAKE_REQUEST


-- 
Damien Le Moal
Western Digital Research
