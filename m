Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 142FCC32771
	for <linux-block@archiver.kernel.org>; Wed, 28 Sep 2022 22:19:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231340AbiI1WTO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Sep 2022 18:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232166AbiI1WTN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Sep 2022 18:19:13 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D818E6DE2
        for <linux-block@vger.kernel.org>; Wed, 28 Sep 2022 15:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1664403551; x=1695939551;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=b0F3Ylk86xoC5MPa+vNvCm+Rlr+a4d7Fvqg7VeBsskI=;
  b=U9oSewt4avtopBPk7xk1vFfFmDIke5lVLmdqV/G6sWmdp6/Ea+fiPRQS
   fXVruMEwqPYeh/+rGbUrcyA99NXh7nISkY0knTiyK9atIFQ42p/9LqmKS
   RztS3A0ji2C2d73DRs7Mq/cha2zBWjxHWZEMMQ+j/95n8+LDuEBFkAJiv
   DAvKqiXRLeTd+tAmwGLUam/gmgblPdNmAvuQywKPirGwyUmvUb5VbmoTz
   xcvc1pPJ90uqQxXM0C5rl8I5JA1CCxc+qe0yjroiCxhG92hresjIPQajh
   baNJ8jVuNw6bScBbDy+Gx0cWk4Pp+rSmlHc147IMKeMfSLl4nZPrNEe5n
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,353,1654531200"; 
   d="scan'208";a="316807423"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 29 Sep 2022 06:19:09 +0800
IronPort-SDR: Hmm1Oqf+T35yqTj+CRNkjxwNckYO65nN6c/ysy05q9P7hMyn1cRbu5GINrYhBjrTN4HMWGF8GM
 YXbRbPBtb6IrY4//qq94Nu0TfQzvY/RHXiJ7bZSVZus6FuMuD9kdkeKGWu8g9qIWiuSxgfaDAU
 3hffXs1WlN9+9VYPcLNLhhP7qm9zQeyqjO65zOVam2SCCxiYcrFbeqo7qCFSetaoalFsbomjvA
 sf7BjLCrSdPvreUcH/R6cD/gimNZlHp8IS4EEs8qvCrCWiSo+K7TWs8Myb0RrZHvWk/0acD7/p
 7NH2Ah1DQiiSTSbE6uS8BCyi
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Sep 2022 14:33:33 -0700
IronPort-SDR: ZLHcr8pI0BZehehfvUU6RfTlpAC6ydS01NDfM+73lJo2hAVYotz93enabkFIQwBrpTCFWaLyUg
 oOYCD3lhlorMK+KZ7cgaWLItbZ/BOwviC0xaJiUD61MqUeCOZr+lVRSDmH0cQihDqC4ZqHMAn8
 rfOErfdD6lZ14TOHiSMsm9hWlrasFTh8BrAmYT8FcbwAsaceCeZ6I/1JLz+VRWsAEceZ99nG0r
 Xldm7nf7dNKVLMa+Q2H0mx0gKIaHfH6q2iuR2lcia8eGH73Bb3LyyeX+Jxny1MfSk5Iwpmgh9R
 m1o=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Sep 2022 15:19:09 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Md9rY4sGHz1RwqL
        for <linux-block@vger.kernel.org>; Wed, 28 Sep 2022 15:19:09 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:content-language:references:to
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1664403549; x=1666995550; bh=b0F3Ylk86xoC5MPa+vNvCm+Rlr+a4d7Fvqg
        7VeBsskI=; b=HFBdej1HaKXa4ZAr1XFeANM/E067ZicRkSQD7hbndJsqOwGVQ2f
        aRaq8cpdByc+/PHqV05zDFP4qA4KJQU3aF8mzK5OoUs8CcO4G8NsP5krsJe4ayrD
        u+wXt77nUSDD3+bm5K7H0zZcukZ8nNvR1kURupqd2AOleYZoGuYY+Zqcn+SZG0p1
        KmXnwWBb/E44yeVoS9Ws5onuM8HV2eGeufYVueCrt+8aW1JrTlbYGBZXrWNcU8+W
        y7hLowCL7Y4d+hPwyS2QFcRZ0f9jTux3FtT0USiYvgYUszCECsoI8ejV+z3NWKqn
        aZh4I28zBvVQeKzGlyU/ozW0XJnOwdSIFng==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id K6p3PnWHVFxA for <linux-block@vger.kernel.org>;
        Wed, 28 Sep 2022 15:19:09 -0700 (PDT)
Received: from [10.89.80.74] (c02drav6md6t.dhcp.fujisawa.hgst.com [10.89.80.74])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Md9rX1sxPz1RvLy;
        Wed, 28 Sep 2022 15:19:08 -0700 (PDT)
Message-ID: <a0fd7220-c0e6-edb2-2683-f92610ad4959@opensource.wdc.com>
Date:   Thu, 29 Sep 2022 07:19:06 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.0
Subject: Re: [PATCH 1/2] block: modify blk_mq_plug() to allow only reads for
 zoned block devices
To:     Pankaj Raghav <p.raghav@samsung.com>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org, gost.dev@samsung.com
References: <CGME20220925185350eucas1p1fc354429027a88de7e548a3a4529b4ef@eucas1p1.samsung.com>
 <20220925185348.120964-2-p.raghav@samsung.com>
 <YzG5RgmWSsH6rX08@infradead.org>
 <d5975b62-f2e9-dcde-e332-a73cca1f7fbf@kernel.dk>
 <YzG6fZdz6XBDbrVB@infradead.org>
 <2ee6a897-87e7-0592-2482-9928a9a63ff6@kernel.dk>
 <a943acf8-f367-a1ba-0d57-2948a3ade6f4@samsung.com>
 <350366c3-1014-ac32-149f-689134631d73@kernel.dk>
 <6273f2c1-7889-1931-aec6-e567aa4d2d96@samsung.com>
 <fa80eef0-42a4-6ffc-cced-18ecbe5b1f5a@kernel.dk>
 <YzMp+SIsv6Aw4bFW@infradead.org>
 <3c6002c7-cd69-e020-24b8-650aaf9ad893@kernel.dk>
 <43776c04-8a84-a0e7-b77f-a0aa30fdc47f@samsung.com>
Content-Language: en-US
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <43776c04-8a84-a0e7-b77f-a0aa30fdc47f@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2022/09/28 20:57, Pankaj Raghav wrote:
> On 2022-09-27 18:52, Jens Axboe wrote:
>>> Well, the only opcodes we do zone locking for is REQ_OP_WRITE and
>>> REQ_OP_WRITE_ZEROES.  So this should be:
>>>
>>> 	if (zoned && (op == REQ_OP_WRITE || op == REQ_OP_WRITE_ZEROES))
>>> 		return NULL;
>>
>> I'd rather just make it explicit and use that. Pankaj, do you want
>> to spin a v2 with that?
>>
> 
> Based on all the suggestions:
> 
> block: adapt blk_mq_plug() to not plug for writes that require a zone lock
> 
> The current implementation of blk_mq_plug() disables plugging for all
> operations that involves a transfer to the device as we just check if
> the last bit in op_is_write() function.
> 
> Modify blk_mq_plug() to disable plugging only for REQ_OP_WRITE and
> REQ_OP_WRITE_ZEROS as they might require a zone lock.
> 
> Suggested-by: Christoph Hellwig <hch@infradead.org>
> Suggested-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> 
> diff --git a/block/blk-mq.h b/block/blk-mq.h
> index 8ca453ac243d..297289cdd521 100644
> --- a/block/blk-mq.h
> +++ b/block/blk-mq.h
> @@ -312,7 +312,8 @@ static inline void blk_mq_clear_mq_map(struct blk_mq_queue_map *qmap)
>  static inline struct blk_plug *blk_mq_plug( struct bio *bio)
>  {
>  	/* Zoned block device write operation case: do not plug the BIO */
> -	if (bdev_is_zoned(bio->bi_bdev) && op_is_write(bio_op(bio)))
> +	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) &&
> +	    blk_op_is_zoned_write(bio->bi_bdev, bio_op(bio)))
>  		return NULL;
> 
>  	/*
> diff --git a/block/blk-zoned.c b/block/blk-zoned.c
> index a264621d4905..fa926424edb6 100644
> --- a/block/blk-zoned.c
> +++ b/block/blk-zoned.c
> @@ -63,13 +63,10 @@ bool blk_req_needs_zone_write_lock(struct request *rq)
>  	if (!rq->q->disk->seq_zones_wlock)
>  		return false;
> 
> -	switch (req_op(rq)) {
> -	case REQ_OP_WRITE_ZEROES:
> -	case REQ_OP_WRITE:
> +	if (blk_op_is_zoned_write(rq->q->disk->part0, req_op(rq)))
>  		return blk_rq_zone_is_seq(rq);
> -	default:
> -		return false;
> -	}
> +
> +	return false;
>  }
>  EXPORT_SYMBOL_GPL(blk_req_needs_zone_write_lock);
> 
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 8038c5fbde40..719025028fa4 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -1300,6 +1300,15 @@ static inline bool bdev_is_zoned(struct block_device *bdev)
>  	return false;
>  }
> 
> +static inline bool blk_op_is_zoned_write(struct block_device *bdev,
> +					 blk_opf_t op)

To be consistent, I personally would prefer bdev_op_is_zoned_write() as the name
here (the first argument is a bdev).

> +{
> +	if (!bdev_is_zoned(bdev))
> +		return false;
> +
> +	return op == REQ_OP_WRITE || op == REQ_OP_WRITE_ZEROES;
> +}
> +
>  static inline sector_t bdev_zone_sectors(struct block_device *bdev)
>  {
>  	struct request_queue *q = bdev_get_queue(bdev);
> 
> 
> Does this look fine?

-- 
Damien Le Moal
Western Digital Research

