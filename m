Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40039C43334
	for <linux-block@archiver.kernel.org>; Wed, 29 Jun 2022 08:35:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbiF2IfG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Jun 2022 04:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231713AbiF2IfF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Jun 2022 04:35:05 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E6803B3F8
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 01:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1656491703; x=1688027703;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=rw6KD7JfOgyN6gzFHzD3edoh2EaBNGDNZ1IL/+jEMx4=;
  b=gISJaeOD5XZLQTWyf71cLf81tP6t5k4OOvjJnhmPiA+GsPRHRuTBc/t8
   7W2Hop4i5g7dgzkzuHFDI1W0bp2Hq2WBnKerEq4yNJ2EReHRpZa9Mbc3i
   andWaQ0vUS3Kw2BhrX3N1Tw6Dk9VST3Yv7pMbZgQfTp7XfS3lFasVQcSc
   2YNFJq693VavWSzp8AfqE8ajgni67cLGZa3aBElTVl4DxDSeVq5sBs8Lq
   tYYv3yrgeGsnSJXNz0D8d7MbenD2XcXd1dqTp1Aq9VyxBX6MTDoIqawjP
   V1ZsJkI1DdVCLzREgdYI9wLA3JYAFvUabRYTF7wtbKuEtHznWd7tEiEt9
   w==;
X-IronPort-AV: E=Sophos;i="5.92,231,1650902400"; 
   d="scan'208";a="204368316"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 29 Jun 2022 16:35:03 +0800
IronPort-SDR: aPFz7Y3HZgRyKiiK6isyhiRQWMrWDebypA+gM/ubAvyrW+wby2DnTK7gCXhqJRgHVagNn1n7pT
 AZLD50TFM34NlmkfzOQrVhUqjA2kG3FrzpXVWYPBTs+h5GyOaWGoUREIcHbndWxoyrXhAA3KUa
 Ll1UNvPND1FYg2MksXN+wCGmFxMfnOa3WDDL/7d5PT6xa7Yyx9CBPBV5HPwr35maL6ZM2cuA05
 txVAphv0AeqvIaDj5fv5kY7yS3QBoA4xXBNnu1ZJpX0B93afoHth3Rhp9SYe502X9zaOj6xvwG
 CidExoQML4HvkscGxONQKxtB
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Jun 2022 00:57:24 -0700
IronPort-SDR: +X2PwcwtuR/V1vbVraM2Jalt6MYuCKjasWyN5oFBDwjqb0Wk/X4G/lrXMGty0/vCQyV69E2CUL
 NwTWdemOHxNMHeLRiiaWEGnHnp0wxm7q1GPW7u7UF9HsORpMJkE3Co813r+m4QBYIvK7pqTZD5
 EtKyTsuwluPqLp2Ts6M1yiwekSayPDZZ66zs5WRZHBQj4g3gwTgNoSmGXmAesIAOoMMWBzBf5z
 GqhCYlIvSeSXI0BWiWC10q7WiMWeuFNvb9UCK7Tz3/8pPcGyBdJpSr2zzs+48jfE78pzdslUqr
 BqQ=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Jun 2022 01:35:04 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LXvsg59Q2z1Rw4L
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 01:35:03 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1656491703; x=1659083704; bh=rw6KD7JfOgyN6gzFHzD3edoh2EaBNGDNZ1I
        L/+jEMx4=; b=bFNsOWqpQonKg8Tdaw2Rbp1x2FD1ZyyXxLw1ld5utN8SEKPMw6a
        JzqjNMTxYUAi56nrMGSbkhLtGVP820QlrAQdNV6G5eA0jS/vEewm12oGuQ+Je02U
        D5ujwdogG5ajAOCMC7g1Bm8UgLsOLQM6bJiEg8+2K/SK2NdfR1f9J+mrOvpil4mo
        21TAn1xLXj0swcLDOJ6q3qwq+nYiTc9e05V/ia74qjwf/kqn+evfW4Yh+nlMaHoV
        jlnow48BoyVVVcQgKi1PeU7ktA1a+AaAaXwbzJ03KFgPVd2Rs8XXFdaS5ATgmsJe
        UehWMPfffmvyk89MlF0kcIBBXGjY4zxpBLw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id iWIa-6iVQBfP for <linux-block@vger.kernel.org>;
        Wed, 29 Jun 2022 01:35:03 -0700 (PDT)
Received: from [10.225.163.99] (unknown [10.225.163.99])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LXvsf4Mwkz1RtVk;
        Wed, 29 Jun 2022 01:35:02 -0700 (PDT)
Message-ID: <e7085740-5bcc-867d-5972-80350fb6dad7@opensource.wdc.com>
Date:   Wed, 29 Jun 2022 17:35:01 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 1/2] block: move ->ia_ranges from the request_queue to the
 gendisk
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Damien Le Moal <damien.lemoal@wdc.com>
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
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

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
