Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF147C433F5
	for <linux-block@archiver.kernel.org>; Thu, 26 May 2022 01:59:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345859AbiEZB7N (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 25 May 2022 21:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232245AbiEZB7B (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 May 2022 21:59:01 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7A69BCE84
        for <linux-block@vger.kernel.org>; Wed, 25 May 2022 18:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1653530340; x=1685066340;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Jfax4/+o7wWRlUxJ58mTLPx93F9LIro2F7EUGaGjyaQ=;
  b=cETZLQxizk02f3MsxxXd+JPOW9xrLyYkccCX14NYaG/uxRbBPg503CCd
   y8HcK/HuQ8nrElAK0u/R870wurH/4jITCM4uEQtnF7GC+f6DB2KJO3p7U
   m064DKeWdZdnaB4fLY+h83lQr3LzVrYDLxDOS5a2lj8DAcrwwOVLec6L3
   vKFKJVGaIOeVnk0KcqqGN8Y+WSk5yXFYz2uThkTf2pXL+gPdzS+uFeT/K
   flj16RRHX+wG1arKtk9dSCO58cz8bmiC5VVDU9UR+xJuB7hfFuv9i27fc
   ikSTv011HqXbErZUJlNhNvEmBbyM2fG81uDo1HhgHjxVAiuboF+6OJ4Sy
   A==;
X-IronPort-AV: E=Sophos;i="5.91,252,1647273600"; 
   d="scan'208";a="313462388"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 May 2022 09:58:59 +0800
IronPort-SDR: 5zI8YC4LDL+Md7lgiqGJcjgh+EogLmKq6O68qN1HmF/zZtm43MIZEaox1Oj02H7zTwexKQl9UK
 ihsrY6gl0n0Nni++Rfah5wpmrQr7YykUL3YYZJ1+27t3lVcA43eSlwmVmFTRxjDw93zF/flBDk
 uz4l6u0CsEQiUep9G5j3lrdb7TQGRhkq9TxbuHoFIbdkvRmOx9E785BjFvCwINcgpM35xiKqW/
 KDvwD1tgMtyyTouA27KEjffUWMgXrwYE6Drvq7Y6yEaoK7ExIz15kLKsCd1DxjNIV6pSNzqbmH
 TPBdzAF0glG6gaCKcrZhcHH2
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 May 2022 18:22:54 -0700
IronPort-SDR: nlDh3mxdm+MC7/BDRmT21JMu6fsXmuOodsKXR+0ngdaJB1TK2ncxCVbC37WNNQCd1kp0UEuWxm
 zhJ31c8qlKEEBmwy+rlNnYdmIVTFdx4fbyCBH2lX4gp+JRUEwJj5G9HG+SYBLFg8sud+4KusGT
 goy2EvXPI3c9CXx/gOeiA6epl3qCU8Z5haoyCPVotFY6t6dPvHVpavLlazFKfx2dPoxlBtfk1V
 IZTPqe8Iz9YvC3SAVrszZ0zp1E1qysDjRICTPaHVoOl0y5vUXLz4k7Rd14Ns/TrE6LwHAXihH6
 Yek=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 May 2022 18:59:00 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4L7rhL5S9qz1Rvlx
        for <linux-block@vger.kernel.org>; Wed, 25 May 2022 18:58:58 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1653530338; x=1656122339; bh=Jfax4/+o7wWRlUxJ58mTLPx93F9LIro2F7E
        UGaGjyaQ=; b=je4cUUhXcPquMpIdPRIPnEHSDzZ06F6IEND2ihyiFFwAi1inVXq
        YSl/oJgivbNBK15zDtuoli7n9u/nbew9lfAuFmXrvaxKaUw9p9KfLKywGsh3aPfQ
        4MIpQr5vMTEcLN8A1tKFduNDJ4OIUDhujXDYWc34jxD8fRygY2peBNGIhLeesFXg
        iYnIkzx1fqoMBSi93aFwDfCiMgqRtTIiYU0KK9v7Mw86+8kFM9agbTRJcuQgNKV9
        1V8fMANNSmsxzLcXtk6lAAf4iKI7N07v1DksW35JUAiWMVKhEcy2wxScD/EnQ9Bx
        JC0fy0+2zk6aMm4lpS2sxvtItTpwZmXIsXQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id QmkfYV9xvhlR for <linux-block@vger.kernel.org>;
        Wed, 25 May 2022 18:58:58 -0700 (PDT)
Received: from [10.225.54.48] (unknown [10.225.54.48])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4L7rhJ4wFBz1Rvlc;
        Wed, 25 May 2022 18:58:56 -0700 (PDT)
Message-ID: <2c3c98de-e9de-eebb-87b6-fa59cd2784c4@opensource.wdc.com>
Date:   Thu, 26 May 2022 10:58:55 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.1
Subject: Re: [PATCHv4 7/9] block/bounce: count bytes instead of sectors
Content-Language: en-US
To:     Keith Busch <kbusch@fb.com>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, Kernel Team <Kernel-team@fb.com>, hch@lst.de,
        bvanassche@acm.org, ebiggers@kernel.org, pankydev8@gmail.com,
        Keith Busch <kbusch@kernel.org>
References: <20220526010613.4016118-1-kbusch@fb.com>
 <20220526010613.4016118-8-kbusch@fb.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220526010613.4016118-8-kbusch@fb.com>
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
>   Use unsigned int type for counting bytes
> 
>  block/bounce.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/block/bounce.c b/block/bounce.c
> index 8f7b6fe3b4db..f6ae21ec2a70 100644
> --- a/block/bounce.c
> +++ b/block/bounce.c
> @@ -205,19 +205,25 @@ void __blk_queue_bounce(struct request_queue *q, struct bio **bio_orig)
>  	int rw = bio_data_dir(*bio_orig);
>  	struct bio_vec *to, from;
>  	struct bvec_iter iter;
> -	unsigned i = 0;
> +	unsigned i = 0, bytes = 0;
>  	bool bounce = false;
> -	int sectors = 0;
> +	int sectors;
>  
>  	bio_for_each_segment(from, *bio_orig, iter) {
>  		if (i++ < BIO_MAX_VECS)
> -			sectors += from.bv_len >> 9;
> +			bytes += from.bv_len;
>  		if (PageHighMem(from.bv_page))
>  			bounce = true;
>  	}
>  	if (!bounce)
>  		return;
>  
> +	/*
> +	 * If the original has more than BIO_MAX_VECS biovecs, the total bytes
> +	 * may not be block size aligned. Align down to ensure both sides of
> +	 * the split bio are appropriately sized.
> +	 */
> +	sectors = ALIGN_DOWN(bytes, queue_logical_block_size(q)) >> SECTOR_SHIFT;
>  	if (sectors < bio_sectors(*bio_orig)) {
>  		bio = bio_split(*bio_orig, sectors, GFP_NOIO, &bounce_bio_split);
>  		bio_chain(bio, *bio_orig);

Looks good.

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

-- 
Damien Le Moal
Western Digital Research
