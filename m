Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8D8DC433EF
	for <linux-block@archiver.kernel.org>; Wed, 29 Jun 2022 07:08:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232684AbiF2HIg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Jun 2022 03:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232758AbiF2HId (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Jun 2022 03:08:33 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 478C0BC28
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 00:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1656486512; x=1688022512;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=iriYOZNJIo1Z6zmc5yrhbZqNaft8Wlp3sgU6ZIH07TA=;
  b=CerIDbIfKQfS8S37hXhOMkAALrqj3ISvJEJaPjrzQsB3x8DUEw3GKzpt
   ekqVa/6AEYceE+a7qyKfCKuawcA/BOLMmPyCDHeX4rZb+1YxRTQhGJVvc
   irC/s7nPPWAmnhQubo2UNTsrASk0Wa8qEU16GxZNynSKnIDtEuVSxWVez
   FmhZPdCronlx1acj7V5C11HERC2efLGf4x9N20tFuL7qdHH/YfgwEL0Fl
   MpOiNt9laSId27q7IB2XNNtqgt2x8fpnb/tR7R7LUq19vNcAC+bFY7r6o
   y5K+4+Cn5+PvzkkpNqzqPv0kBG7yjhgmJ8SRJyiNAKO1ZIN7MSU8S4z7n
   w==;
X-IronPort-AV: E=Sophos;i="5.92,230,1650902400"; 
   d="scan'208";a="205091563"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 29 Jun 2022 15:08:31 +0800
IronPort-SDR: DegBka3Lbklg/XREA1p/zGDC0N+gxJEvVaKCKLbjZZgJbx2bwxFytNDNFN3tkPnDuTuPu1d3so
 4P8og9PUq9nxVmhUuRYDgsPC7c4yY9M+j+S3PQh7y3WTTCYMUHNi45skqJXS3BYeHC7GH3jH2g
 9LVbv/BRa6y7k8WqtxhdrfE7rRTr60xtA2x/BM5l1LEsZhVLvtZIOin8iheVEP1jHPKwK2fMqH
 lZNEld84HFO5UElBeAGcl4eKRR8kFtF2cekLje24bqOneCLNtoRQEhHmvrn0wFUAy8hPbaemeZ
 WTsSLFgiU3RSChKFqojp7fH9
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Jun 2022 23:26:11 -0700
IronPort-SDR: n4R/kaqRLBuBiRPMraJzTHeS2iiKHtCaHK6mdpTZRvq0+EbRpzexoNsTWAQHr0fd4Owsy29RcN
 l4bpz/92YcyZZfUSX1af8aI7enH2vFMOt476QxnHzreuoJvT7oyL4WKaoRbc2YUaQ/BUDyupVC
 gnuAnDL8kdQR/T3monuUZVWGhAkA67dLTWdBZQwVfBei7UGRdBTvCdi+DloHSeH9wCYhGq84jR
 0SxUw7PJWOpoG5IAXbT4WTNKkw2iLo/rroNeIuDO6BHZUmdPnrUanZ5Ah9gPmctvL0wG/aXw2W
 DfU=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Jun 2022 00:08:32 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LXsxq3vYCz1Rwnm
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 00:08:31 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1656486511; x=1659078512; bh=iriYOZNJIo1Z6zmc5yrhbZqNaft8Wlp3sgU
        6ZIH07TA=; b=PDBx96akxepP1mV56knc1KOuyliRpYm3RQANoN0XYkVta1z7qqd
        ls6huBvOGJaAn+Dpa8fJYNiDiSgwBa/PbzC0RWYyB+jrqlm0iuz0qW/nfQX9c8k9
        T84I99XqvNkqrs1Bjqp1u4itCofGPQTE2Luo1Kz0uc/7ONfQTuerzw9KuQ7kQM+t
        Fzl1/onkk8rnW2Pf309uduWRXOpCdNeGnKmEgpwdi9M3eXN5727W/BnRbgyITQA5
        gI1WG5SnPOcrG9vTrjpmMV4laoFvpqbsXD1LKfcbNDTHjsItGd/n1i8gBlMG6NPe
        NuBm1MZsf7IlQS4tTOyf+NxFEbWHSaDGI3w==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id aEFJvpOQxKi4 for <linux-block@vger.kernel.org>;
        Wed, 29 Jun 2022 00:08:31 -0700 (PDT)
Received: from [10.225.163.99] (unknown [10.225.163.99])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LXsxp3gKwz1RtVk;
        Wed, 29 Jun 2022 00:08:30 -0700 (PDT)
Message-ID: <36d397c2-3cfd-4872-1baa-f375d50aa6ba@opensource.wdc.com>
Date:   Wed, 29 Jun 2022 16:08:29 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 1/2] block: move ->ia_ranges from the request_queue to the
 gendisk
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
References: <20220629062013.1331068-1-hch@lst.de>
 <20220629062013.1331068-2-hch@lst.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220629062013.1331068-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/29/22 15:20, Christoph Hellwig wrote:
> Independent access ranges only matter for file system I/O and are only
> valid with a registered gendisk, so move them there.

Would this potentially affect the use of ranges in DM ? E.g. exposing a
dm-linear device targets as ranges. I do not think so but I did not check
the details.

> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/blk-ia-ranges.c  | 18 +++++++++---------
>  include/linux/blkdev.h | 12 ++++++------
>  2 files changed, 15 insertions(+), 15 deletions(-)
> 
> diff --git a/block/blk-ia-ranges.c b/block/blk-ia-ranges.c
> index 47c89e65b57fa..c1bf14bcd15f4 100644
> --- a/block/blk-ia-ranges.c
> +++ b/block/blk-ia-ranges.c
> @@ -106,7 +106,7 @@ static struct kobj_type blk_ia_ranges_ktype = {
>   *
>   * Register with sysfs a set of independent access ranges for @disk.
>   * If @new_iars is not NULL, this set of ranges is registered and the old set
> - * specified by q->ia_ranges is unregistered. Otherwise, q->ia_ranges is
> + * specified by disk->ia_ranges is unregistered. Otherwise, disk->ia_ranges is
>   * registered if it is not already.
>   */
>  int disk_register_independent_access_ranges(struct gendisk *disk,
> @@ -121,12 +121,12 @@ int disk_register_independent_access_ranges(struct gendisk *disk,
>  
>  	/* If a new range set is specified, unregister the old one */
>  	if (new_iars) {
> -		if (q->ia_ranges)
> +		if (disk->ia_ranges)
>  			disk_unregister_independent_access_ranges(disk);
> -		q->ia_ranges = new_iars;
> +		disk->ia_ranges = new_iars;
>  	}
>  
> -	iars = q->ia_ranges;
> +	iars = disk->ia_ranges;
>  	if (!iars)
>  		return 0;
>  
> @@ -138,7 +138,7 @@ int disk_register_independent_access_ranges(struct gendisk *disk,
>  	ret = kobject_init_and_add(&iars->kobj, &blk_ia_ranges_ktype,
>  				   &q->kobj, "%s", "independent_access_ranges");
>  	if (ret) {
> -		q->ia_ranges = NULL;
> +		disk->ia_ranges = NULL;
>  		kobject_put(&iars->kobj);
>  		return ret;
>  	}
> @@ -164,7 +164,7 @@ int disk_register_independent_access_ranges(struct gendisk *disk,
>  void disk_unregister_independent_access_ranges(struct gendisk *disk)
>  {
>  	struct request_queue *q = disk->queue;
> -	struct blk_independent_access_ranges *iars = q->ia_ranges;
> +	struct blk_independent_access_ranges *iars = disk->ia_ranges;
>  	int i;
>  
>  	lockdep_assert_held(&q->sysfs_dir_lock);
> @@ -182,7 +182,7 @@ void disk_unregister_independent_access_ranges(struct gendisk *disk)
>  		kfree(iars);
>  	}
>  
> -	q->ia_ranges = NULL;
> +	disk->ia_ranges = NULL;
>  }
>  
>  static struct blk_independent_access_range *
> @@ -242,7 +242,7 @@ static bool disk_check_ia_ranges(struct gendisk *disk,
>  static bool disk_ia_ranges_changed(struct gendisk *disk,
>  				   struct blk_independent_access_ranges *new)
>  {
> -	struct blk_independent_access_ranges *old = disk->queue->ia_ranges;
> +	struct blk_independent_access_ranges *old = disk->ia_ranges;
>  	int i;
>  
>  	if (!old)
> @@ -331,7 +331,7 @@ void disk_set_independent_access_ranges(struct gendisk *disk,
>  	if (blk_queue_registered(q)) {
>  		disk_register_independent_access_ranges(disk, iars);
>  	} else {
> -		swap(q->ia_ranges, iars);
> +		swap(disk->ia_ranges, iars);
>  		kfree(iars);
>  	}
>  
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 22b12531aeb71..b9a94c53c6cd3 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -171,6 +171,12 @@ struct gendisk {
>  	struct badblocks *bb;
>  	struct lockdep_map lockdep_map;
>  	u64 diskseq;
> +
> +	/*
> +	 * Independent sector access ranges. This is always NULL for
> +	 * devices that do not have multiple independent access ranges.
> +	 */
> +	struct blk_independent_access_ranges *ia_ranges;
>  };
>  
>  static inline bool disk_live(struct gendisk *disk)
> @@ -539,12 +545,6 @@ struct request_queue {
>  
>  	bool			mq_sysfs_init_done;
>  
> -	/*
> -	 * Independent sector access ranges. This is always NULL for
> -	 * devices that do not have multiple independent access ranges.
> -	 */
> -	struct blk_independent_access_ranges *ia_ranges;
> -
>  	/**
>  	 * @srcu: Sleepable RCU. Use as lock when type of the request queue
>  	 * is blocking (BLK_MQ_F_BLOCKING). Must be the last member


-- 
Damien Le Moal
Western Digital Research
