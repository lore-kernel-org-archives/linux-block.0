Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AADBC04A95
	for <linux-block@archiver.kernel.org>; Thu, 29 Sep 2022 08:14:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234751AbiI2IOp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Sep 2022 04:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234300AbiI2IOn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Sep 2022 04:14:43 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B67C2E9F8
        for <linux-block@vger.kernel.org>; Thu, 29 Sep 2022 01:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1664439281; x=1695975281;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bPvXx1IBWj8zwZgi3W5b2Zypc5YABKrQo7Sgo/pPgCU=;
  b=G8JRexe8C2XfZqvFYciVOn4he4RelZIN9PtQ/o5Kml5NUliUWcrFhj+Q
   AnerWsIOFwCn7x9IHc4/VNZoo42naICoSfc/jU1eDsh28Z5ZRJ60aVR49
   tW7M9WQKlTvTyImoKzmLOQHmF+Uit1cXbzhhY2LkRN0EM8tf0YCSbs2IU
   vyN7xn7avlIO4aEj9ifOZq4uHQmQM89qM93iDa3fd5owVRIdMAKdllb1O
   VgkezmSU+I0LPPmKu162XMNkuhmS4gBLURgFUwidYGE9XE6QfhtggBrCm
   YP5S1/NXGTG2qRL02WCR691JWsYAKQ2mESPXHey5v4S+I8Nweue7xsG+9
   g==;
X-IronPort-AV: E=Sophos;i="5.93,354,1654531200"; 
   d="scan'208";a="210917720"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 29 Sep 2022 16:14:40 +0800
IronPort-SDR: ZjS0T9abitHroWzoEQGKBkKQYZb1znG7eTbaXHTJSl5sLfdUXxUEdicOapHefUhKdS+E4UJ0n9
 MtPyAG6PtT2+gyf8mXsF78S/I6lpz5FncqiZBpZsx+d1gl+dW+oLZWotXDySHyue3XJ+WaPM87
 FcVKNQLUH7ciPFmeoFcyPeNzmD66/LIywWO+O0G/VZ0qaXvX4YpfWpwNnlQzGh/wZHZ9q3+Z9S
 UG5gno/5GI5bIYiPMmqFy45BQ7tY7DA1LpDlkmetPAfIKyNmUvYU2kNlldl1qbI0QQ0pSQTi7D
 o8nwcWKvYdYN3pt8Meb5hc9F
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Sep 2022 00:34:34 -0700
IronPort-SDR: 7tjrJMM6/hYRdOmGa9wiMm37DtPdBhNt+iES/tyihhrW9Mv/aziACOm3dC7SfCPF7BzDXsxJKC
 FnOGBp9Ty9xz5pvwdUkOK60rh0ddjhH/teVZjujAT218ugQovaqZRd+9WmcabhYqyyzydTJQ2v
 yUQkKoL7I+kNEmhOLSaHV8VCHzXShqOXEGf+P1pO1luxZMM2Nd5KVYVzedbhNULb+Qj5S0m126
 2OeWNc2DXnKrkTxQEBuPO3CpCxmclSly4Sm6PBmXQa2RAOJ0SV/ldUExENHo789TL8jCJI4GBP
 J4I=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Sep 2022 01:14:41 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MdR3g4hd2z1Rwt8
        for <linux-block@vger.kernel.org>; Thu, 29 Sep 2022 01:14:39 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1664439279; x=1667031280; bh=bPvXx1IBWj8zwZgi3W5b2Zypc5YABKrQo7S
        go/pPgCU=; b=VXIPQRHR1BIpQSM1qGsexB2AdnOCv5cslZ5HeyTvi61AYVkQHYv
        3idY4y0gzNtoICNbl+V/k1CSVrqgYQHqbyx6+UP/SyyxWfHnwI238pvktZoAySFP
        ylzoGBCRdOzBksq5WKIfuUcQ7hCMhlKVAMMFFNleQ4WtmfkxCAaHj4xXvbNHkk4X
        pK0ifwVGblOl9azXJxoMch4UlgV8DNVun5pjUb7suyCae1kmld36Hp+7jBkdm0Ou
        8aES5qRZK6huWjSkgAfpNMeOo+RRhHg49vxz4SakbqdpXtEiftXTmiByO3rcVJAv
        34c1ovSTHZgck+6qDJU6GU3YhX3/ErByqBQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id vdU6EeZ5bG4G for <linux-block@vger.kernel.org>;
        Thu, 29 Sep 2022 01:14:39 -0700 (PDT)
Received: from [10.225.163.96] (unknown [10.225.163.96])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MdR3f2FFvz1RvLy;
        Thu, 29 Sep 2022 01:14:38 -0700 (PDT)
Message-ID: <c34ce7f3-8bf2-99c0-9c82-ea6691f762ef@opensource.wdc.com>
Date:   Thu, 29 Sep 2022 17:14:37 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v3 1/2] block: adapt blk_mq_plug() to not plug for writes
 that require a zone lock
Content-Language: en-US
To:     Pankaj Raghav <p.raghav@samsung.com>, axboe@kernel.dk, hch@lst.de
Cc:     gost.dev@samsung.com, linux-block@vger.kernel.org
References: <20220929074745.103073-1-p.raghav@samsung.com>
 <CGME20220929074748eucas1p1145790d433b4f57cc9e9238df480091b@eucas1p1.samsung.com>
 <20220929074745.103073-2-p.raghav@samsung.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220929074745.103073-2-p.raghav@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/29/22 16:47, Pankaj Raghav wrote:
> The current implementation of blk_mq_plug() disables plugging for all
> operations that involves a transfer to the device as we just check if
> the last bit in op_is_write() function.
> 
> Modify blk_mq_plug() to disable plugging only for REQ_OP_WRITE and
> REQ_OP_WRITE_ZEROS as they might require a zone lock.
> 
> Suggested-by: Christoph Hellwig <hch@lst.de>
> Suggested-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

> ---
>  block/blk-mq.h         | 3 ++-
>  block/blk-zoned.c      | 9 +++------
>  include/linux/blkdev.h | 9 +++++++++
>  3 files changed, 14 insertions(+), 7 deletions(-)
> 
> diff --git a/block/blk-mq.h b/block/blk-mq.h
> index 8ca453ac243d..0b2870839cdd 100644
> --- a/block/blk-mq.h
> +++ b/block/blk-mq.h
> @@ -312,7 +312,8 @@ static inline void blk_mq_clear_mq_map(struct blk_mq_queue_map *qmap)
>  static inline struct blk_plug *blk_mq_plug( struct bio *bio)
>  {
>  	/* Zoned block device write operation case: do not plug the BIO */
> -	if (bdev_is_zoned(bio->bi_bdev) && op_is_write(bio_op(bio)))
> +	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) &&
> +	    bdev_op_is_zoned_write(bio->bi_bdev, bio_op(bio)))
>  		return NULL;
>  
>  	/*
> diff --git a/block/blk-zoned.c b/block/blk-zoned.c
> index a264621d4905..db829401d8d0 100644
> --- a/block/blk-zoned.c
> +++ b/block/blk-zoned.c
> @@ -63,13 +63,10 @@ bool blk_req_needs_zone_write_lock(struct request *rq)
>  	if (!rq->q->disk->seq_zones_wlock)
>  		return false;
>  
> -	switch (req_op(rq)) {
> -	case REQ_OP_WRITE_ZEROES:
> -	case REQ_OP_WRITE:
> +	if (bdev_op_is_zoned_write(rq->q->disk->part0, req_op(rq)))
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
> index 8038c5fbde40..74bc30c680d6 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -1300,6 +1300,15 @@ static inline bool bdev_is_zoned(struct block_device *bdev)
>  	return false;
>  }
>  
> +static inline bool bdev_op_is_zoned_write(struct block_device *bdev,
> +					  blk_opf_t op)
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

-- 
Damien Le Moal
Western Digital Research

