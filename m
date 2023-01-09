Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A271AC54EBD
	for <linux-block@archiver.kernel.org>; Mon,  9 Jan 2023 23:38:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235360AbjAIXiz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Jan 2023 18:38:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231509AbjAIXio (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Jan 2023 18:38:44 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E22F9F46
        for <linux-block@vger.kernel.org>; Mon,  9 Jan 2023 15:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1673307522; x=1704843522;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=tI5VC2Yz8xg2kx/p1cNh+gU2tPUeca64KZi91EVFsXo=;
  b=H3BfDB8Mi/GBEOu9s6hNBC01iLBHMUOKAswvzan+bGMPF5OcRwPD7KgK
   yPsf6EO1k5UuGGRvKHah36uGE8NQrU8agdRLW5tdoq3TS4ke40FPa7jrV
   xmCd4Vl+SLSm9ODg+BkSPXDpbVGVCvdkExy83Fd6LjeTR/bHqqvbcLeD0
   ZE7D5qY5DNwD/Yp1g3IWG0tLsosOsJzGArKU2/Z2A1rpMgkfwsFOidJuX
   GMqVln9C/z48G8SOC+JGUBSAdompNBAr2N9YNmjGMnWDsO9ophfvN1EN8
   AL0EtvQl8gGAI24m7+QYafSdQHBxF6M+BNlKJ5B+gayDtLmeLCuDGs5aC
   A==;
X-IronPort-AV: E=Sophos;i="5.96,313,1665417600"; 
   d="scan'208";a="324688224"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jan 2023 07:38:41 +0800
IronPort-SDR: CrT+1r5rp//QJThUTX4HqYgkxMLYpBNmUy80Quu1IXL6TW/6rhTzT73NXvX6G12KRglTSUrpeJ
 cuTqW2kI7C3gWLx9q7wyLWQIYaARU3VB7wTgayuy2PECnYwU45KwDTzAzYOMciPsXmAfCUnQQH
 nedlT2zSGZT4EimgXxTuZI1UD3Uv64Scu2C+wSGkqrdZ73qSgY+IqQWMZw5Q46BPbA1J03xFIx
 B2gokjCVMN2DuqpuNrFfRkxKH3l/Ohba0rHkQfMwvdY+oPSbBrU60xnXCG69pyMf5wqoY7AK3T
 S0o=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Jan 2023 14:50:47 -0800
IronPort-SDR: I1hCadYlV85aXZTARxa8MUm7CTmCv2coO0PNUB9VCBKnC3zqn65/8IyUXNJ/hg5cywEDFDi67B
 TBpWnSQN7VTJ5Fmg3li5+bxv+Tw3UyzT/d7KrLZo5gs+TGH7rZLnora6e3ckf5e0Kk/iobV7Gh
 pPtrfXuWrRdeoyYbcybXuZ14ykr5ijtMLb6mKjZYp4Ab+qhNsH/mn4chdelSp9O6i0Z4iLV1Hj
 qemWTMhJVLSOROOF22lB9HXnEeOIhDEaMPSab+7HfYcs6loiiKxGuSwk+4ByUyoPgHpnAdPa8A
 mjI=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Jan 2023 15:38:43 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NrVkn1zLCz1RvTp
        for <linux-block@vger.kernel.org>; Mon,  9 Jan 2023 15:38:41 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1673307520; x=1675899521; bh=tI5VC2Yz8xg2kx/p1cNh+gU2tPUeca64KZi
        91EVFsXo=; b=WQugQqM0K97orq3PbtyeVhLVKuGyr79H0nnhrwHENafcsRGuNqs
        Owy56U3Ns7Bima1PvR9IsUm2TAH5EYn6TLAnfswAM5lDI7QpJZB3+jRpmBEEtHLm
        gFW7Cu8dF0hsezvg3N5rHLblcErkd9dCQ2V1xnXUkPXh4d/5gSq+/FUkgkwVIrhI
        c9ldqlSVlNb/QBCFyrjmLKemMnf2VMW/hNj/4QtKvF5S4LjVQJukq3Q4ytqUSEia
        NHBfh9DpUEiRk1iAtXVy6/+1Pv9TChzfO721PhBML9EDKZaFSpuwOIP2H8I2uxW7
        5Tkd+DxZyrMXCSxgTOnTsHpsk6u/lIysAOw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id OvhCzyjFSfzr for <linux-block@vger.kernel.org>;
        Mon,  9 Jan 2023 15:38:40 -0800 (PST)
Received: from [10.225.163.12] (unknown [10.225.163.12])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NrVkm0Xklz1RvLy;
        Mon,  9 Jan 2023 15:38:39 -0800 (PST)
Message-ID: <7b90e9e6-4a32-eb0d-bb42-8cd0a75159f9@opensource.wdc.com>
Date:   Tue, 10 Jan 2023 08:38:38 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 2/8] block: Introduce the blk_rq_is_seq_zone_write()
 function
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Avri Altman <avri.altman@wdc.com>
References: <20230109232738.169886-1-bvanassche@acm.org>
 <20230109232738.169886-3-bvanassche@acm.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20230109232738.169886-3-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/10/23 08:27, Bart Van Assche wrote:
> Introduce a function that makes it easy to verify whether a write
> request is for a sequential write required or sequential write preferred
> zone.
> 
> Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  include/linux/blk-mq.h | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
> index 6735db1ad24d..29f834e5c3a9 100644
> --- a/include/linux/blk-mq.h
> +++ b/include/linux/blk-mq.h
> @@ -1167,6 +1167,24 @@ static inline unsigned int blk_rq_zone_is_seq(struct request *rq)
>  	return disk_zone_is_seq(rq->q->disk, blk_rq_pos(rq));
>  }
>  
> +/**
> + * blk_rq_is_seq_zone_write() - Whether @rq is a write request for a sequential zone.
> + * @rq: Request to examine.
> + *
> + * In this context sequential zone means either a sequential write required or
> + * to a sequential write preferred zone.

...means either a sequential write required zone or a sequential write
preferred zone.

> + */
> +static inline bool blk_rq_is_seq_zone_write(struct request *rq)
> +{
> +	switch (req_op(rq)) {
> +	case REQ_OP_WRITE:
> +	case REQ_OP_WRITE_ZEROES:

REQ_OP_ZONE_APPEND ?

> +		return blk_rq_zone_is_seq(rq);
> +	default:
> +		return false;
> +	}
> +}
> +
>  bool blk_req_needs_zone_write_lock(struct request *rq);
>  bool blk_req_zone_write_trylock(struct request *rq);
>  void __blk_req_zone_write_lock(struct request *rq);
> @@ -1197,6 +1215,11 @@ static inline bool blk_req_can_dispatch_to_zone(struct request *rq)
>  	return !blk_req_zone_is_write_locked(rq);
>  }
>  #else /* CONFIG_BLK_DEV_ZONED */
> +static inline bool blk_rq_is_seq_zone_write(struct request *rq)
> +{
> +	return false;
> +}
> +
>  static inline bool blk_req_needs_zone_write_lock(struct request *rq)
>  {
>  	return false;

-- 
Damien Le Moal
Western Digital Research

