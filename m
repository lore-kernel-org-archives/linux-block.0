Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96472C00144
	for <linux-block@archiver.kernel.org>; Tue, 26 Jul 2022 23:27:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbiGZX1d (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Jul 2022 19:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiGZX1c (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Jul 2022 19:27:32 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B4C037F90
        for <linux-block@vger.kernel.org>; Tue, 26 Jul 2022 16:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1658878051; x=1690414051;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=h0hKiHyjmXsR1/Q+YLMtobTL5UDspKnBiO+ob2kcAaY=;
  b=FUED54v3IaVCFbSoMhqWhVBWBEDzjnuRlgnY6gVN40ppeBYMUwh8Qk0s
   yZydglJOlM1raMBL8RKKpt422VPr7NiUaaCN/iortiJLcnWmbHCPBUYFj
   uodY3DHgK4b2LanNw+AG0JCLEcec3RRqZbs4+/SrSNzgx2R/TNa7Hiymd
   4hjP0c+gba8ndpBRh6pbN2Sz2BahgsCSHMHfzozD9zDmNm3tgPb0XCDPg
   tzJWwe/7FBvGT8BCAk4eRLu7SGkZvFob3FE9IP/LdTg+s70O8tNqDhqAm
   sXUx/eeQySm9wBNwQ0FUZFok8ICeL/fRWySaFGzH9Vwc04lVtDl1EiyXn
   A==;
X-IronPort-AV: E=Sophos;i="5.93,194,1654531200"; 
   d="scan'208";a="211928828"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 27 Jul 2022 07:27:30 +0800
IronPort-SDR: bbs7ha/FCRu3R0AA2yHZpWOI37LleWyXuWDz5Z3CpVZvjZaXJk9Gt16UvWVmwQ72kydOy5hhI2
 YkUofsRid7NI2xUJOZnlsr27psqdSnA7JK5CE/XbzmeY6nxOwKEqo/LOWtPtJdOpLqhA2ZuvB/
 O4yJ1g02l1aTpwgKNvqupR6RY0WlogYBxUyzV/wrbu9KtupHUKi2waqEwc1rZdXeu9DUlhqq4s
 BhjOhgOi0LanxAysQm5ULORABngQZTjADPHKZMjmDt0LaXgSgjNRloNPCXu8a72V+N/HFREn3C
 /8kw481u/1IHU35Z+MxaArko
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Jul 2022 15:48:43 -0700
IronPort-SDR: +myV2Cgtun2Iy2E8Ay2lbJae4NCTha4KAIw5OTl0noSATuKVGtAiIL/w/tjynfBCUPb5sH36KT
 QRh3HAm3cj+XZy3jxaRBEH26j1rZ2NXlszKm4mXFzzBbak7dVXNogWKdH0/BY+Die83gVIUO3d
 fO7XApKW8eTOGgvZdN3RLUdwzq58OJY33biJ16BMLEiyE2W+Ftf0CPntbZxkQoGhzY64eTyFCi
 63nKJx3EaSu2SeuxcOYT7W8UvZZeQUjWvw62x2dbGA8yvLPPIqDdbbXFJ+U3azaswy04Qk0D2H
 J0k=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Jul 2022 16:27:31 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LstNz1hSJz1Rwnl
        for <linux-block@vger.kernel.org>; Tue, 26 Jul 2022 16:27:31 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1658878050; x=1661470051; bh=h0hKiHyjmXsR1/Q+YLMtobTL5UDspKnBiO+
        ob2kcAaY=; b=XFb86IV28141059gu1kdxVMlTvKHeL8UNVy5e/AwdGW1i2mXSZQ
        jiE+RQb5wOwQ6pqmJR+m9eUrqfH/9eerh/zwqCDPsvCVgDp6tVqo1KPumabU8o2i
        VDFt/B+GLByXkl+HwbpdJDgnKs4CqeaMCh5NfTI/URcAUdfpzhrRVvcRv/lOFo7K
        8WQa7zBIZ4KSibK0IDnqlIj7r0yb29Yt3/D/50U1sO9YgRPtr0XDOagSPW6Bn4vv
        yN2znOwoBAXr0ZL/UokII2SZzZqss8RtqClqW8c1ewDD8xmJLRNYwS7EerG94eTd
        xw+/ja8TEmRiCdnOc0b3bPNCWp3ZucNMitw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id gpa3SIgFRe5H for <linux-block@vger.kernel.org>;
        Tue, 26 Jul 2022 16:27:30 -0700 (PDT)
Received: from [10.225.163.14] (unknown [10.225.163.14])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LstNy1wQvz1RtVk;
        Tue, 26 Jul 2022 16:27:30 -0700 (PDT)
Message-ID: <abb727a0-bdd9-7131-d363-0728815daeb7@opensource.wdc.com>
Date:   Wed, 27 Jul 2022 08:27:29 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/6] block: change the blk_queue_bounce calling convention
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
References: <20220726183029.2950008-1-hch@lst.de>
 <20220726183029.2950008-3-hch@lst.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220726183029.2950008-3-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/27/22 03:30, Christoph Hellwig wrote:
> The double indirect bio leads to somewhat suboptimal code generation.
> Instead return the (original or split) bio, and make sure the
> request_queue arguments to the lower level helpers is passed after the
> bio to avoid constant reshuffling of the argument passing registers.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks OK to me.

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

> ---
>  block/blk-mq.c |  2 +-
>  block/blk.h    | 10 ++++++----
>  block/bounce.c | 26 +++++++++++++-------------
>  3 files changed, 20 insertions(+), 18 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 790f55453f1b1..7adba3eeba1c6 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2815,7 +2815,7 @@ void blk_mq_submit_bio(struct bio *bio)
>  	unsigned int nr_segs = 1;
>  	blk_status_t ret;
>  
> -	blk_queue_bounce(q, &bio);
> +	bio = blk_queue_bounce(bio, q);
>  	if (bio_may_exceed_limits(bio, q))
>  		bio = __bio_split_to_limits(bio, q, &nr_segs);
>  
> diff --git a/block/blk.h b/block/blk.h
> index 623be4c2e60c1..f50c8fcded99e 100644
> --- a/block/blk.h
> +++ b/block/blk.h
> @@ -378,7 +378,7 @@ static inline void blk_throtl_bio_endio(struct bio *bio) { }
>  static inline void blk_throtl_stat_add(struct request *rq, u64 time) { }
>  #endif
>  
> -void __blk_queue_bounce(struct request_queue *q, struct bio **bio);
> +struct bio *__blk_queue_bounce(struct bio *bio, struct request_queue *q);
>  
>  static inline bool blk_queue_may_bounce(struct request_queue *q)
>  {
> @@ -387,10 +387,12 @@ static inline bool blk_queue_may_bounce(struct request_queue *q)
>  		max_low_pfn >= max_pfn;
>  }
>  
> -static inline void blk_queue_bounce(struct request_queue *q, struct bio **bio)
> +static inline struct bio *blk_queue_bounce(struct bio *bio,
> +		struct request_queue *q)
>  {
> -	if (unlikely(blk_queue_may_bounce(q) && bio_has_data(*bio)))
> -		__blk_queue_bounce(q, bio);	
> +	if (unlikely(blk_queue_may_bounce(q) && bio_has_data(bio)))
> +		return __blk_queue_bounce(bio, q);
> +	return bio;
>  }
>  
>  #ifdef CONFIG_BLK_CGROUP_IOLATENCY
> diff --git a/block/bounce.c b/block/bounce.c
> index c8f487af7be37..7cfcb242f9a11 100644
> --- a/block/bounce.c
> +++ b/block/bounce.c
> @@ -199,24 +199,24 @@ static struct bio *bounce_clone_bio(struct bio *bio_src)
>  	return NULL;
>  }
>  
> -void __blk_queue_bounce(struct request_queue *q, struct bio **bio_orig)
> +struct bio *__blk_queue_bounce(struct bio *bio_orig, struct request_queue *q)
>  {
>  	struct bio *bio;
> -	int rw = bio_data_dir(*bio_orig);
> +	int rw = bio_data_dir(bio_orig);
>  	struct bio_vec *to, from;
>  	struct bvec_iter iter;
>  	unsigned i = 0, bytes = 0;
>  	bool bounce = false;
>  	int sectors;
>  
> -	bio_for_each_segment(from, *bio_orig, iter) {
> +	bio_for_each_segment(from, bio_orig, iter) {
>  		if (i++ < BIO_MAX_VECS)
>  			bytes += from.bv_len;
>  		if (PageHighMem(from.bv_page))
>  			bounce = true;
>  	}
>  	if (!bounce)
> -		return;
> +		return bio_orig;
>  
>  	/*
>  	 * Individual bvecs might not be logical block aligned. Round down
> @@ -225,13 +225,13 @@ void __blk_queue_bounce(struct request_queue *q, struct bio **bio_orig)
>  	 */
>  	sectors = ALIGN_DOWN(bytes, queue_logical_block_size(q)) >>
>  			SECTOR_SHIFT;
> -	if (sectors < bio_sectors(*bio_orig)) {
> -		bio = bio_split(*bio_orig, sectors, GFP_NOIO, &bounce_bio_split);
> -		bio_chain(bio, *bio_orig);
> -		submit_bio_noacct(*bio_orig);
> -		*bio_orig = bio;
> +	if (sectors < bio_sectors(bio_orig)) {
> +		bio = bio_split(bio_orig, sectors, GFP_NOIO, &bounce_bio_split);
> +		bio_chain(bio, bio_orig);
> +		submit_bio_noacct(bio_orig);
> +		bio_orig = bio;
>  	}
> -	bio = bounce_clone_bio(*bio_orig);
> +	bio = bounce_clone_bio(bio_orig);
>  
>  	/*
>  	 * Bvec table can't be updated by bio_for_each_segment_all(),
> @@ -254,7 +254,7 @@ void __blk_queue_bounce(struct request_queue *q, struct bio **bio_orig)
>  		to->bv_page = bounce_page;
>  	}
>  
> -	trace_block_bio_bounce(*bio_orig);
> +	trace_block_bio_bounce(bio_orig);
>  
>  	bio->bi_flags |= (1 << BIO_BOUNCED);
>  
> @@ -263,6 +263,6 @@ void __blk_queue_bounce(struct request_queue *q, struct bio **bio_orig)
>  	else
>  		bio->bi_end_io = bounce_end_io_write;
>  
> -	bio->bi_private = *bio_orig;
> -	*bio_orig = bio;
> +	bio->bi_private = bio_orig;
> +	return bio;
>  }


-- 
Damien Le Moal
Western Digital Research
