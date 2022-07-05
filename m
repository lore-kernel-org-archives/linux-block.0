Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 842C5C43334
	for <linux-block@archiver.kernel.org>; Tue,  5 Jul 2022 02:26:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234572AbiGEC0i (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Jul 2022 22:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234470AbiGEC0h (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Jul 2022 22:26:37 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A30BEA470
        for <linux-block@vger.kernel.org>; Mon,  4 Jul 2022 19:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1656987994; x=1688523994;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=VEo1U38lZifgVX/C/QfJsivX3yshQFhlwAOpNUkJGpE=;
  b=qAv7vt4weDQVEhGsDiNMwZ6IKqD06wNBCD2u8cOdStpNalObOG3KG7kH
   +PuegfKPPcpfLVzGM4jfSqythjuDZGMnbDA8yNhTleGbbiRZTWZYxvPNh
   c+peR0SMDcMo9SV871l0mLQ9NN/6JaaOhkKd30EDwnuB4KWtvYEvsfR/7
   58w9xHxzDMrlFLx2tYRgRg7ktKcaoI5opTU2ruNa03h9ZzsPMxs5mNdY2
   RNA+2qV9xveK3rYiCRdaBjpi/gu2s+QaIqnb75qx9AdnKSGZPWumzRs6m
   0IPHT658gGpSrjtV+Kq28EPAy9ITwd4DQkGoS6tjSIfiz/ELhOex4eMpQ
   w==;
X-IronPort-AV: E=Sophos;i="5.92,245,1650902400"; 
   d="scan'208";a="209698787"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 05 Jul 2022 10:26:35 +0800
IronPort-SDR: 5TOPNCHvQkVzlkWhOumsg3k6sPo83IJmCd8l9Sc4lz8ciyPirC7USVnPHnJJExF1V1q7gcswaD
 S9giHtRmluHpgnwqocUr1rXcpmHBsfLK1P0nqWFCphnusx4/IWdpzDcByoBX+ftCoUsk+LeNwX
 cXASDL7afqqvOKHi5LPHEp//gtho7USg26fqKWn7JoqEB9BytUGkPjVJvPBorkefWTHTVC3tnR
 eW/07a3upoNn15UstZEVoeF9KP0UZH9sdSoTttur7AKejUpkOETxW9DtwvFlH3lV5m/X/qUCOc
 oC5/599G05/UaoJQvKLMH/As
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Jul 2022 18:43:54 -0700
IronPort-SDR: OQz9w/0sT56yTJhpVusiNY663rPMnrP1oaFumkJgKtnL0as/FYunKLv3tM/RDdqWeCWOOi4mRF
 ui4WhXAmYp2Fn2+d4f1k61AA+mTNybFSqd89kaFlTjmmz0KKSNbKwecHag6YbUWQKRt2JaiKpM
 U/jTBNKPFi2oFokbpaCIlErX2J58XcKM+DG09PN1ROl91iVIVdqqLvOX/jlRmdtqNeEeCeTHdA
 mm66EoRj1ilh0txQ8Kwst0N/aG+lP9VrOdHaUVmiEuIXFNK3T5QlITB1X4CuDdW1EoVT9/ucTO
 79A=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Jul 2022 19:26:36 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LcRPl4mRwz1Rwnm
        for <linux-block@vger.kernel.org>; Mon,  4 Jul 2022 19:26:35 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1656987995; x=1659579996; bh=VEo1U38lZifgVX/C/QfJsivX3yshQFhlwAO
        pNUkJGpE=; b=QPBNupleFdg5rjY4nn3+iZEtHgP/8ZnS/N3S0RmZFXPhE+gEyfw
        XtsrovW3DugFQmBhSJYdjn1S/0XmA6JPAea8g3+fv6IvvpheiVktUnJa6cFAbWJl
        ZWzoMv93zI4QSpBByd3GhMdaBlZVSDqqpmjr1oH8LT9lqpRXeLoS4g06AI6Uc1el
        9tGHLjFwHii0kNI8suSz38UQ6m2wJtA5vKTjSAmSybgtFfKsbeO0uaTzr75IvmWK
        tF2yt4WUjm3Fb52tgSb7ZeCItHXhqjS5JWC6i2M9CchBFd1tdTIBruOOdHk0Wnbx
        1UFF50Zr3DU/AISjUvdI1DmgHnv79Yrg9vg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id xBzaC89WTsCL for <linux-block@vger.kernel.org>;
        Mon,  4 Jul 2022 19:26:35 -0700 (PDT)
Received: from [10.225.163.105] (unknown [10.225.163.105])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LcRPk0fwcz1RtVk;
        Mon,  4 Jul 2022 19:26:33 -0700 (PDT)
Message-ID: <cf7b3c89-b820-9b27-b3ed-b9b625e59482@opensource.wdc.com>
Date:   Tue, 5 Jul 2022 11:26:32 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 01/17] block: remove a superflous ifdef in blkdev.h
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org
References: <20220704124500.155247-1-hch@lst.de>
 <20220704124500.155247-2-hch@lst.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220704124500.155247-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/4/22 21:44, Christoph Hellwig wrote:
> It doesn't hurt to lways have the blk_zone_cond_str prototype, and the

s/lways/always

> two inlines can also be defined unconditionally.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  include/linux/blkdev.h | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index b9a94c53c6cd3..270cd0c552924 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -899,8 +899,6 @@ static inline struct request_queue *bdev_get_queue(struct block_device *bdev)
>  	return bdev->bd_queue;	/* this is never NULL */
>  }
>  
> -#ifdef CONFIG_BLK_DEV_ZONED
> -
>  /* Helper to convert BLK_ZONE_ZONE_XXX to its string format XXX */
>  const char *blk_zone_cond_str(enum blk_zone_cond zone_cond);

This is defined in block/blk-zoned.c and so not compiled if
CONFIG_BLK_DEV_ZONED is not defined. But I guess this should be fine since
if there is a user of this function with !CONFIG_BLK_DEV_ZONED, a build
should fail anyway.

>  
> @@ -915,7 +913,6 @@ static inline unsigned int bio_zone_is_seq(struct bio *bio)
>  	return blk_queue_zone_is_seq(bdev_get_queue(bio->bi_bdev),
>  				     bio->bi_iter.bi_sector);
>  }
> -#endif /* CONFIG_BLK_DEV_ZONED */
>  
>  /*
>   * Return how much of the chunk is left to be used for I/O at a given offset.

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

-- 
Damien Le Moal
Western Digital Research
