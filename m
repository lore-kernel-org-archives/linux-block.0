Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8830C433EF
	for <linux-block@archiver.kernel.org>; Fri, 22 Jul 2022 06:10:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbiGVGKB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 Jul 2022 02:10:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiGVGKB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Jul 2022 02:10:01 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5119B54661
        for <linux-block@vger.kernel.org>; Thu, 21 Jul 2022 23:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1658470198; x=1690006198;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=lZhKBpJILZKSOmoH6Bcz73ueHklTBcFohHul94U2EN8=;
  b=SeUq8nfDmEkXwGkn4rAMN8u1ACfPU1hleS8ZWWN1jPPZhU9n71sZaKJE
   qQkUw52bCpp7GuKU3E6RcmZjdiLCnN1WFyII8F5LZWtTGvXJyiFy26+zA
   xaQc999qcuUBVm33LvcoopZjexcfKGDQOghGdfTTVulASINidnyitug2t
   qjNLv8gxTYUIhza0EWx+ol+kNLf8fQOQb7KHaDxhgUOGbsGO73G56kKOE
   wuczVIhjxq6QQO10Qq5oSrROwLmBtsdfnonWBmDjzzeO1quTV4CyDM9Hj
   cO5OHUcV1vaEXCuTmeNll6NYMY/ALqWUdIFhyYslNTuzBZoF6nZsoOgAV
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,184,1654531200"; 
   d="scan'208";a="206617377"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 22 Jul 2022 14:09:58 +0800
IronPort-SDR: EByEb6v74mfF4ipWamoWzVio+uMW9THsFg+aMfiMu5cTVz7wSuiaoRb2OK8bagVmpjBvYfS1bH
 XXa7fsoVbxqSyXIm71fvftkbEsGHFJZGzSy4OwqeixyQAaxaC2bf1R1ABIzsee5GSJTuQ6ycoJ
 HdwqS3PNE4WhEfIYivPu6lcxp+X7IPaKvK2sgbFxXlH8tOvr0fQaKN3++CsdRrePK2cBu21xy2
 Ab4KNzwYEf6nuj/FkK206mShP/puJ7QAKrZ1cbC7K29Hu5z5mcrW0/NgzSKKj5dxRbHcShdncI
 dApVPl6nfeXvsWx4Hf/FrA/q
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Jul 2022 22:31:18 -0700
IronPort-SDR: kodDXaOHUw73zX5zpS1Yj1vb5WcuGdy16LnUsxVHMl3d0poNbUKbkK+xA8uYwaVWyrT0kwNbId
 lA/dzmhyvIg2CEMUZgiApmmADB+zpFNFo2YaJdJ0qDuXyRO3SwM60d55orHSed740XIsK9fr9T
 Cek+vXoJ3KuVY8ESHjEJ5CliXmpshJ0+G/d6I3RJTkiYxScEr2ezlo1uTmmh4cB8bPiw/2TZfx
 eEztDSQLpgmi0gerDi1jJMuspAk0DxHLtR0aOWrSVAsYmReuP2hXmrEuhMeQAdKfocWU9hq5aB
 ztY=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Jul 2022 23:10:01 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LpzYg4znGz1Rwnm
        for <linux-block@vger.kernel.org>; Thu, 21 Jul 2022 23:09:59 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1658470199; x=1661062200; bh=lZhKBpJILZKSOmoH6Bcz73ueHklTBcFohHu
        l94U2EN8=; b=eRbiwgdX1UNQmUqPxKNPVlI6uHnKniJ3KVRLBuEJ9R2KswVG8Ck
        iSJpyKouX6i3GR9/+AAi5eWGAewWEj8KmoMuXliOMclR/Hn/ZErGwzc7gJFa35+X
        iBLg4diQ1XlLBBQhzn3tikxN1dRmsmmLoGkv1scQJ07GXIKCLvqNCfB+SefKdupc
        qfS+ihfvxeWF/n+dB//8k9ocPwDyKV8i7KWtsfT2Fe7ZTC4OBH8vCQWOFVtTK1OS
        ZYCb+AHDujbYktcfRYzHzRsZd5S3/D2sNWxo+XubX8PWKTMf1n7WPCin26kBBnzW
        Tq60gP7Zxf5bhvkZBKsF0d+KL4wiZeMPn6w==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id rcxbGrn7kq3S for <linux-block@vger.kernel.org>;
        Thu, 21 Jul 2022 23:09:59 -0700 (PDT)
Received: from [10.225.163.125] (unknown [10.225.163.125])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LpzYf5LXFz1RtVk;
        Thu, 21 Jul 2022 23:09:58 -0700 (PDT)
Message-ID: <133b4a85-7106-8cb0-94da-842d7744e19c@opensource.wdc.com>
Date:   Fri, 22 Jul 2022 15:09:57 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 3/5] block: move the call to get_max_io_size out of
 blk_bio_segment_split
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
References: <20220720142456.1414262-1-hch@lst.de>
 <20220720142456.1414262-4-hch@lst.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220720142456.1414262-4-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/20/22 23:24, Christoph Hellwig wrote:
> Prepare for reusing blk_bio_segment_split for (file system controlled)
> splits of REQ_OP_ZONE_APPEND bios by letting the caller control the
> maximum size of the bio.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good. Though I think this patch could wait for the actual users of
this change.

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

> ---
>  block/blk-merge.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/block/blk-merge.c b/block/blk-merge.c
> index e657f1dc824cb..1676a835b16e7 100644
> --- a/block/blk-merge.c
> +++ b/block/blk-merge.c
> @@ -252,11 +252,12 @@ static bool bvec_split_segs(const struct request_queue *q,
>   * @bio:  [in] bio to be split
>   * @bs:	  [in] bio set to allocate the clone from
>   * @segs: [out] number of segments in the bio with the first half of the sectors
> + * @max_bytes: [in] maximum number of bytes per bio
>   *
>   * Clone @bio, update the bi_iter of the clone to represent the first sectors
>   * of @bio and update @bio->bi_iter to represent the remaining sectors. The
>   * following is guaranteed for the cloned bio:
> - * - That it has at most get_max_io_size(@q, @bio) sectors.
> + * - That it has at most @max_bytes worth of data
>   * - That it has at most queue_max_segments(@q) segments.
>   *
>   * Except for discard requests the cloned bio will point at the bi_io_vec of
> @@ -266,14 +267,12 @@ static bool bvec_split_segs(const struct request_queue *q,
>   * split bio has finished.
>   */
>  static struct bio *blk_bio_segment_split(struct request_queue *q,
> -					 struct bio *bio,
> -					 struct bio_set *bs,
> -					 unsigned *segs)
> +		struct bio *bio, struct bio_set *bs, unsigned *segs,
> +		unsigned max_bytes)
>  {
>  	struct bio_vec bv, bvprv, *bvprvp = NULL;
>  	struct bvec_iter iter;
>  	unsigned nsegs = 0, bytes = 0;
> -	const unsigned max_bytes = get_max_io_size(q, bio) << 9;
>  	const unsigned max_segs = queue_max_segments(q);
>  
>  	bio_for_each_bvec(bv, bio, iter) {
> @@ -347,7 +346,8 @@ void __blk_queue_split(struct request_queue *q, struct bio **bio,
>  		split = blk_bio_write_zeroes_split(q, *bio, bs, nr_segs);
>  		break;
>  	default:
> -		split = blk_bio_segment_split(q, *bio, bs, nr_segs);
> +		split = blk_bio_segment_split(q, *bio, bs, nr_segs,
> +				get_max_io_size(q, *bio) << SECTOR_SHIFT);
>  		break;
>  	}
>  


-- 
Damien Le Moal
Western Digital Research
