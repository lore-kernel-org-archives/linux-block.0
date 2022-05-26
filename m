Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E08FFC433F5
	for <linux-block@archiver.kernel.org>; Thu, 26 May 2022 01:57:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234950AbiEZB5g (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 25 May 2022 21:57:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiEZB5f (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 May 2022 21:57:35 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AFE2BA997
        for <linux-block@vger.kernel.org>; Wed, 25 May 2022 18:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1653530254; x=1685066254;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1kUl0vd3SSUgn63Ct2ExgU44F74GMaQ+B5yJLGmFXog=;
  b=Y9J0CYPTBpC58C8YI+EGlsJby6KdVKEM2QxcglkIaRqelEec02X6MsSL
   4pR3xCYCNn2ZZm5vW3I0SyFP10kOGddIzyQ44p6oDpWsonxTUmsp5aoWT
   UmihvoFLd7IL9eyGVhgJs2kiu/1qR1tLkV3RoTVFeNqFol82EPk+2yjtT
   Wdp0+mnxGbrDWnO7p4ZJh/7F5akdkj499EoRJQKn6zpOmesm3w63ubTJm
   LQNQDtcToi0H8/LIc63zxFWXPtH9/h+6r/xa88YiKC8YvL+A4jXXOwMQE
   WoxNA6RgKRgkVt+9HBRFmhMz0lQPWCiuCNAmJpnzb9/JRVae3bN+qR2pU
   g==;
X-IronPort-AV: E=Sophos;i="5.91,252,1647273600"; 
   d="scan'208";a="206332908"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 May 2022 09:57:34 +0800
IronPort-SDR: GFnzM+Eb2YSjfDdwnLy7YNj+OTSiFCKe6Bzq2hdvgqOOWwsGn+HKhMQw7EEBuuPdQaKbXSM/xE
 5kVx1JBItDzc+7L/o8FWfED61IGgb0xk3DaVbFbEl8FRletGefMyaVObar7dggPnEDTX/doV2g
 A03AgQcO82vdnzKEdlh2WlOjmOIVAROF9qqDVPMdMh6cUR2d7upC7BcvMD/G19g7QP8e7n+lYn
 EcFAsejysf/ffMogd2JdkpbTv/NC0ACDwAi+p2tp4YU4ZkRXyesy9dvnsYzbz9G+/wxdXkNBzu
 xla+9TQqzhU54ONjck2QQ+wC
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 May 2022 18:21:29 -0700
IronPort-SDR: 9utkOToLeN2HWVCh227mQnH8JgEqCmdWW434IinqoAfR0zN4rQXVcrf2rcSMA9oGbTUi/32CJx
 SHv2L+a7QPgTkQW2dpmpt8vQXmBF+7DMjIZwAKxGRXHbT3WBKdiYtn3H9A/QEvli2GreCgx+Nn
 LW87fbzF4/pgkdaGwcX5jFTlPmfwdSpX+f/j8mue+JoVZ5pDd9FczcdzLFjOWVLA0DmFGP3MrJ
 /hfFH2OEBTDxu7AzWiDRfrpbEMDKN4QsUYxDKXpvBI1HJj6LDeQJ0RW9xe7S78teaNUaMiEMjT
 igk=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 May 2022 18:57:35 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4L7rfj6lp8z1SVp2
        for <linux-block@vger.kernel.org>; Wed, 25 May 2022 18:57:33 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1653530253; x=1656122254; bh=1kUl0vd3SSUgn63Ct2ExgU44F74GMaQ+B5y
        JLGmFXog=; b=TKaB4WeXk1Np5GlMjS07FnPZv+ZMqUnZ1ALmEckILBTDkKx4KlT
        DhBAgJ6Ciqfo8us7xwkiJolLR7tTqDuD2g1JIR+skqJ2jY1zaYJLs86NJVzJ3XYQ
        KVMqQlMOQsXSU99gGS2sHiOfS827fH4ZClT18OoOBNa96FQ54QXx43X3y8+vemNX
        KtE5RJTokdzKMtVC/3MONRVni6intfkKORNKMp80F1G66YFyfFWIPJxG+i61s5aw
        QUZ0I6XsOuJD2boXyG5fQaSXAyFKEB5BGiXcUN82NUDjtDa6IENXULZP+2H9gGez
        T4fZjz6rbDhp4r9gPlvi48u30Ta7J3tIcTQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id sI-vDLzj7kr7 for <linux-block@vger.kernel.org>;
        Wed, 25 May 2022 18:57:33 -0700 (PDT)
Received: from [10.225.54.48] (unknown [10.225.54.48])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4L7rfg0Hwnz1Rvlc;
        Wed, 25 May 2022 18:57:30 -0700 (PDT)
Message-ID: <8bb77bc7-eb64-d257-5c91-9ecced282596@opensource.wdc.com>
Date:   Thu, 26 May 2022 10:57:29 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.1
Subject: Re: [PATCHv4 6/9] block/merge: count bytes instead of sectors
Content-Language: en-US
To:     Keith Busch <kbusch@fb.com>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, Kernel Team <Kernel-team@fb.com>, hch@lst.de,
        bvanassche@acm.org, ebiggers@kernel.org, pankydev8@gmail.com,
        Keith Busch <kbusch@kernel.org>
References: <20220526010613.4016118-1-kbusch@fb.com>
 <20220526010613.4016118-7-kbusch@fb.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220526010613.4016118-7-kbusch@fb.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2022/05/26 10:06, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> Individual bv_len's may not be a sector size.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
> v3->v4:
> 
>   Use sector shift
> 
>   Add comment explaing the ALIGN_DOWN
> 
>  block/blk-merge.c | 41 ++++++++++++++++++++++++-----------------
>  1 file changed, 24 insertions(+), 17 deletions(-)
> 
> diff --git a/block/blk-merge.c b/block/blk-merge.c
> index 7771dacc99cb..9ff0cb9e4840 100644
> --- a/block/blk-merge.c
> +++ b/block/blk-merge.c
> @@ -201,11 +201,11 @@ static inline unsigned get_max_segment_size(const struct request_queue *q,
>   * @nsegs:    [in,out] Number of segments in the bio being built. Incremented
>   *            by the number of segments from @bv that may be appended to that
>   *            bio without exceeding @max_segs
> - * @sectors:  [in,out] Number of sectors in the bio being built. Incremented
> - *            by the number of sectors from @bv that may be appended to that
> - *            bio without exceeding @max_sectors
> + * @bytes:    [in,out] Number of bytes in the bio being built. Incremented
> + *            by the number of bytes from @bv that may be appended to that
> + *            bio without exceeding @max_bytes
>   * @max_segs: [in] upper bound for *@nsegs
> - * @max_sectors: [in] upper bound for *@sectors
> + * @max_bytes: [in] upper bound for *@bytes
>   *
>   * When splitting a bio, it can happen that a bvec is encountered that is too
>   * big to fit in a single segment and hence that it has to be split in the
> @@ -216,10 +216,10 @@ static inline unsigned get_max_segment_size(const struct request_queue *q,
>   */
>  static bool bvec_split_segs(const struct request_queue *q,
>  			    const struct bio_vec *bv, unsigned *nsegs,
> -			    unsigned *sectors, unsigned max_segs,
> -			    unsigned max_sectors)
> +			    unsigned *bytes, unsigned max_segs,
> +			    unsigned max_bytes)
>  {
> -	unsigned max_len = (min(max_sectors, UINT_MAX >> 9) - *sectors) << 9;
> +	unsigned max_len = min(max_bytes, UINT_MAX) - *bytes;
>  	unsigned len = min(bv->bv_len, max_len);
>  	unsigned total_len = 0;
>  	unsigned seg_size = 0;
> @@ -237,7 +237,7 @@ static bool bvec_split_segs(const struct request_queue *q,
>  			break;
>  	}
>  
> -	*sectors += total_len >> 9;
> +	*bytes += total_len;
>  
>  	/* tell the caller to split the bvec if it is too big to fit */
>  	return len > 0 || bv->bv_len > max_len;
> @@ -269,8 +269,8 @@ static struct bio *blk_bio_segment_split(struct request_queue *q,
>  {
>  	struct bio_vec bv, bvprv, *bvprvp = NULL;
>  	struct bvec_iter iter;
> -	unsigned nsegs = 0, sectors = 0;
> -	const unsigned max_sectors = get_max_io_size(q, bio);
> +	unsigned nsegs = 0, bytes = 0;
> +	const unsigned max_bytes = get_max_io_size(q, bio) << 9;

You missed one SECTOR_SHIFT here :)

Also, this get_max_io_size() function is now super confusing. It really should
be get_max_io_sectors() and we could add also get_max_io_bytes(), no ?

>  	const unsigned max_segs = queue_max_segments(q);
>  
>  	bio_for_each_bvec(bv, bio, iter) {
> @@ -282,12 +282,12 @@ static struct bio *blk_bio_segment_split(struct request_queue *q,
>  			goto split;
>  
>  		if (nsegs < max_segs &&
> -		    sectors + (bv.bv_len >> 9) <= max_sectors &&
> +		    bytes + bv.bv_len <= max_bytes &&
>  		    bv.bv_offset + bv.bv_len <= PAGE_SIZE) {
>  			nsegs++;
> -			sectors += bv.bv_len >> 9;
> -		} else if (bvec_split_segs(q, &bv, &nsegs, &sectors, max_segs,
> -					 max_sectors)) {
> +			bytes += bv.bv_len;
> +		} else if (bvec_split_segs(q, &bv, &nsegs, &bytes, max_segs,
> +					   max_bytes)) {
>  			goto split;
>  		}
>  
> @@ -300,13 +300,20 @@ static struct bio *blk_bio_segment_split(struct request_queue *q,
>  split:
>  	*segs = nsegs;
>  
> +	/*
> +	 * Individual bvecs may not be logical block aligned, so round down to
> +	 * that size to ensure both sides of the split bio are appropriately
> +	 * sized.
> +	 */
> +	bytes = ALIGN_DOWN(bytes, queue_logical_block_size(q));
> +
>  	/*
>  	 * Bio splitting may cause subtle trouble such as hang when doing sync
>  	 * iopoll in direct IO routine. Given performance gain of iopoll for
>  	 * big IO can be trival, disable iopoll when split needed.
>  	 */
>  	bio_clear_polled(bio);
> -	return bio_split(bio, sectors, GFP_NOIO, bs);
> +	return bio_split(bio, bytes >> SECTOR_SHIFT, GFP_NOIO, bs);
>  }
>  
>  /**
> @@ -375,7 +382,7 @@ EXPORT_SYMBOL(blk_queue_split);
>  unsigned int blk_recalc_rq_segments(struct request *rq)
>  {
>  	unsigned int nr_phys_segs = 0;
> -	unsigned int nr_sectors = 0;
> +	unsigned int bytes = 0;
>  	struct req_iterator iter;
>  	struct bio_vec bv;
>  
> @@ -398,7 +405,7 @@ unsigned int blk_recalc_rq_segments(struct request *rq)
>  	}
>  
>  	rq_for_each_bvec(bv, rq, iter)
> -		bvec_split_segs(rq->q, &bv, &nr_phys_segs, &nr_sectors,
> +		bvec_split_segs(rq->q, &bv, &nr_phys_segs, &bytes,
>  				UINT_MAX, UINT_MAX);
>  	return nr_phys_segs;
>  }


-- 
Damien Le Moal
Western Digital Research
