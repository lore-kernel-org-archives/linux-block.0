Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F1A5C433EF
	for <linux-block@archiver.kernel.org>; Mon, 16 May 2022 13:54:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbiEPNy2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 16 May 2022 09:54:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiEPNyX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 May 2022 09:54:23 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADE81E99
        for <linux-block@vger.kernel.org>; Mon, 16 May 2022 06:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1652709261; x=1684245261;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xnJmZYtrUHPz/1pW+2iKsxdcyh17EmGmxKC7iEmOkHc=;
  b=FV7KmAtJkOu7kN7PbQS+O0KgT5pR1lBnrWkMWjbfZWjOOQgvKJdazMqx
   I0Bv1e8k1VxjVMmlyYFKKgwI1mGXORWD0uOPwCtZ3DZH8nPIHpD7zrk1R
   0Q8ZRyjlEdTFu55BM2c1iA5sFliF2Gye+Jh65610ep8A7lY1NTCEjZul7
   YPNJPz/yp3ixTNSY4vMwnbfqsJcb+umnsX9jyDIXScipR95m1QV16czMX
   ID9ISEMvgNRuNZ5HnEvCJ83Fdkpcp6YB8hnKkWM6OCCZUGZG6sF+o5V6m
   viPjdrljM8zqLK0Rsiv6uxSzOxoIKCfqflrPpJRIq5zcWMvAUn5xe85r4
   w==;
X-IronPort-AV: E=Sophos;i="5.91,229,1647273600"; 
   d="scan'208";a="199259472"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 16 May 2022 21:54:20 +0800
IronPort-SDR: OsLYlfgftFO92gl7bYCr1ZVr+mOPCiVEFWttpM3mhW+c3eXceAR/DLRvRRbP7Gd53ipvj9hX4Z
 yZFn+wIRN7uI38UuWsOoim2W+1EhxTDzbTdx/SVucUYytAgam3ctv6lixGUPbjpYr3y3kAXadS
 MPQI71BdQ0eV9Izu09hX6eKczGscm0KLNliNbBiOPFQN4e1EimcYKDicHHjbglcgECX9FJfGZa
 bybc3mHO5ufLrOxtynMcJHXLHneG89eVWsFMY2161SsXiksNAFIf7V8DXrs0DuMZkEWIC/OhuV
 vM5YSjnEoLgq4L7ipi+kNlAL
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 May 2022 06:18:13 -0700
IronPort-SDR: NbYEhkXgXYexdZVqtst/I0jCfJGmt517/a01g8evkqUQ9gyHu0mF6qh6uSP18tQf56TMBCDqFL
 ZprblnZWhNMw4+X6c/GEZpzrXY/wt+yF2pkCUnFtP8ZTSPNGEr+IUhWMfDvMQXudgPjuEY45zs
 YO13fHtK5vignikbsVKkdR0ghLEN2tiHL2dIZ1eSKpuNs3gF6gPdPDkpE2KeE8rpqzlH25Fy0z
 9MKf+mZf6d5nWBZNNsOjoynhS7a/cCKUPJpu/wzNnUpZzZ1CTJuQ3te/qp7D4RpN48H+LZZFSI
 DHw=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 May 2022 06:54:22 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4L212N3dVhz1Rwrw
        for <linux-block@vger.kernel.org>; Mon, 16 May 2022 06:54:20 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1652709259; x=1655301260; bh=xnJmZYtrUHPz/1pW+2iKsxdcyh17EmGmxKC
        7iEmOkHc=; b=UUHn+1Vyu14CMfOaCMgXraCj/MTu6WqTYOUVrT+4PUwPlX5ziiU
        pSIvphH10gCc67fVq3XGywhvUeUqkqYl3C+JIeYNZL256XrllrM58UhqzOZaujF3
        cbmBklJPJrOqfUwuSurt8JpO1UwMmikJGH4hvh5Qwx4pN/E2XnvxaPmNybMpFT83
        xSpG9RchPPentNTApEt/m2/xRnaVgRJJKjnepi11fq5V05sUwhnpCcvU0f61+fwA
        S+fDCn+IEtVKy285CWS8em7niz60i9Y+TCt+uHgrHXnSyVIC4Q8Mw6/XAy+RhYGq
        bnKvHkQ9zRQTWYTH/DZejGfNQWFm7h+DJZQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ATHLpSTexNm2 for <linux-block@vger.kernel.org>;
        Mon, 16 May 2022 06:54:19 -0700 (PDT)
Received: from [10.225.1.43] (unknown [10.225.1.43])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4L212D5R0Cz1Rvlc;
        Mon, 16 May 2022 06:54:12 -0700 (PDT)
Message-ID: <487c9368-36fe-25ec-7a76-f6aa50c4d3d5@opensource.wdc.com>
Date:   Mon, 16 May 2022 15:54:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH v4 01/13] block: make blkdev_nr_zones and
 blk_queue_zone_no generic for npo2 zsze
Content-Language: en-US
To:     Pankaj Raghav <p.raghav@samsung.com>, axboe@kernel.dk,
        naohiro.aota@wdc.com, Johannes.Thumshirn@wdc.com,
        snitzer@kernel.org, dsterba@suse.com, jaegeuk@kernel.org,
        hch@lst.de
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        jonathan.derrick@linux.dev, bvanassche@acm.org,
        Keith Busch <kbusch@kernel.org>, gost.dev@samsung.com,
        linux-nvme@lists.infradead.org,
        Johannes Thumshirn <jth@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        linux-block@vger.kernel.org, Alasdair Kergon <agk@redhat.com>,
        matias.bjorling@wdc.com, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>, dm-devel@redhat.com,
        jiangbo.365@bytedance.com, Chaitanya Kulkarni <kch@nvidia.com>,
        linux-fsdevel@vger.kernel.org, Chris Mason <clm@fb.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Hannes Reinecke <hare@suse.de>
References: <20220516133921.126925-1-p.raghav@samsung.com>
 <CGME20220516133924eucas1p1817f306e3f2442088bf49ab513657cbe@eucas1p1.samsung.com>
 <20220516133921.126925-2-p.raghav@samsung.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220516133921.126925-2-p.raghav@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2022/05/16 15:39, Pankaj Raghav wrote:
> Adapt blkdev_nr_zones and blk_queue_zone_no function so that it can
> also work for non-power-of-2 zone sizes.
> 
> As the existing deployments of zoned devices had power-of-2
> assumption, power-of-2 optimized calculation is kept for those devices.
> 
> There are no direct hot paths modified and the changes just
> introduce one new branch per call.
> 
> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
> Reviewed by: Adam Manzanares <a.manzanares@samsung.com>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>  block/blk-zoned.c      | 13 ++++++++++---
>  include/linux/blkdev.h |  8 +++++++-
>  2 files changed, 17 insertions(+), 4 deletions(-)
> 
> diff --git a/block/blk-zoned.c b/block/blk-zoned.c
> index 38cd840d8..140230134 100644
> --- a/block/blk-zoned.c
> +++ b/block/blk-zoned.c
> @@ -111,16 +111,23 @@ EXPORT_SYMBOL_GPL(__blk_req_zone_write_unlock);
>   * blkdev_nr_zones - Get number of zones
>   * @disk:	Target gendisk
>   *
> - * Return the total number of zones of a zoned block device.  For a block
> - * device without zone capabilities, the number of zones is always 0.
> + * Return the total number of zones of a zoned block device, including the
> + * eventual small last zone if present. For a block device without zone
> + * capabilities, the number of zones is always 0.
>   */
>  unsigned int blkdev_nr_zones(struct gendisk *disk)
>  {
>  	sector_t zone_sectors = blk_queue_zone_sectors(disk->queue);
> +	sector_t capacity = get_capacity(disk);
>  
>  	if (!blk_queue_is_zoned(disk->queue))
>  		return 0;
> -	return (get_capacity(disk) + zone_sectors - 1) >> ilog2(zone_sectors);
> +
> +	if (is_power_of_2(zone_sectors))
> +		return (capacity + zone_sectors - 1) >>
> +		       ilog2(zone_sectors);

Why the line break here ? This fits on one line, no ?

> +
> +	return div64_u64(capacity + zone_sectors - 1, zone_sectors);
>  }
>  EXPORT_SYMBOL_GPL(blkdev_nr_zones);
>  
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 1b24c1fb3..22fe512ee 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -675,9 +675,15 @@ static inline unsigned int blk_queue_nr_zones(struct request_queue *q)
>  static inline unsigned int blk_queue_zone_no(struct request_queue *q,
>  					     sector_t sector)
>  {
> +	sector_t zone_sectors = blk_queue_zone_sectors(q);
> +
>  	if (!blk_queue_is_zoned(q))
>  		return 0;
> -	return sector >> ilog2(q->limits.chunk_sectors);
> +
> +	if (is_power_of_2(zone_sectors))
> +		return sector >> ilog2(zone_sectors);
> +
> +	return div64_u64(sector, zone_sectors);
>  }
>  
>  static inline bool blk_queue_zone_is_seq(struct request_queue *q,


-- 
Damien Le Moal
Western Digital Research
