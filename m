Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDE02C433EF
	for <linux-block@archiver.kernel.org>; Fri, 24 Jun 2022 00:15:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbiFXAPl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Jun 2022 20:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiFXAPk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Jun 2022 20:15:40 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CA3C56C0E
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 17:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1656029739; x=1687565739;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ne/mDkV9rKiRrWhJ9a7jcSfgam23R3y0W+jr48OcqMY=;
  b=pLjjPxUQA8Wc6KIcEiKCf0SeLYmxuFk2OcF27ULcSnRBFTxEUhR5zdKj
   Ce9/FJ9PUyHq2w8kN3VL/KVrAW0cO8krs0Zlrr4RI1q9Lrg9ZcE1HxTFH
   3aAHzUe7vaPqahpAQicz58AN16kiehc9nsy3D39P2p7qJS5oAlLAamU9G
   pQzZ/K1reLzo2XGoDckC5WhSb72UjQbm+F6NAaLBQxxKd6avzFOUxuaID
   jS8+XXrSLeugRxPzbpQpzpmdkRAVSkyd7uuWMfNQrYYJ3HI9vpiG4xSfO
   hhe78NWqPBMXjivZSrboKQBZg3x0HKiDCG28qBn+xKMtiTYVwh0dalVjq
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,217,1650902400"; 
   d="scan'208";a="202655096"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 24 Jun 2022 08:15:38 +0800
IronPort-SDR: 28/xTgfnt0AIXB1QDxitgOf1wfo9XCcm0HgHjH9tB4U8gtcJllo00D45HTUBGu34BZmOvQ4o+b
 7uA9qzpOAD3+ZgITaflesVVCumXvBNSs096rDBAyZJbYLxMoKo4lCk+j874z9Cfh742C5QBqbr
 ZuYo3OZveZa1RV8fqisDiEXkIJFJVzLAbpgE0cMorVRuf6xgmhZ9pFH1GjeSI7wV29AaAGICky
 e5b3f6JSY0BeUK9WqPUfvOkmGr9WG8hnaOn4WxIxbwTrTNLx3WenHANtC4ZAE5ytAo3ug4M05P
 T2f0hl7QSj7N2sErgdBYAD1Z
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Jun 2022 16:38:05 -0700
IronPort-SDR: Wowyk3tvizwphXX5LBK1ttaaSWJ9i3Uu1QbjLAeqwIERB9vxr3u2qFyjvcdymwkSYpix41gd7r
 uq+tEdlSCJsgf2n6YyK9+A7BW4dfFBcZ9iSPmg8aubgOJFeUSNLW3fHZiAdgQs455NRKM3RRlO
 cFyA/LYNLyY6D5Lj/G2opT08tuP0IYDUkvgJppvXMvk5Y33hojYRMEdaAvESJbzqA5ESOm+zY8
 JWvqZGDGSfK3AftptO6MgU8yEQp+ytzI0jTzbj+A8DCpYtGWy+AFezAsNcXOKiY5s9FGlQTme+
 LBo=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Jun 2022 17:15:39 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LTd1k2rYHz1Rwnm
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 17:15:38 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1656029737; x=1658621738; bh=ne/mDkV9rKiRrWhJ9a7jcSfgam23R3y0W+j
        r48OcqMY=; b=VDUSwG/4rJj+NCvdi4y8/dhVflA+OYbsLzHRgY8bKZZjjEZNHwG
        bZW/FXtI8Yys4IwOrC6H9xlfxeMm/3qptVMowppcNDEKk3vihFmyCpJSIsXer+4k
        iE+yy725MCsS9KiU9kf+KdlRrNJPhN63GY3JcNJFrxjVsFuFhwUTgHkGCmxWaAMu
        kWtm/vczb5d/YAsGZ3w6HAWoHtViycklaKtt+BfidySKK8NXYGoYPuy4dvH4oyFV
        Q2D2M8YM4mmGKsA2+x0xgxuaZB0h/9HKnq79pWMZ6WpX+mcuCEcuCRfBSVnOxIKE
        OnNKhDppd3rCCHv0CSbnQE9DPwAy/uRRB+w==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id LGnzTBloPKPb for <linux-block@vger.kernel.org>;
        Thu, 23 Jun 2022 17:15:37 -0700 (PDT)
Received: from [10.225.163.93] (unknown [10.225.163.93])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LTd1h69lQz1RtVk;
        Thu, 23 Jun 2022 17:15:36 -0700 (PDT)
Message-ID: <c73a499e-0c9a-f47c-509c-56b972438b41@opensource.wdc.com>
Date:   Fri, 24 Jun 2022 09:15:35 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 2/6] block: Introduce the blk_rq_is_zoned_seq_write()
 function
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <20220623232603.3751912-1-bvanassche@acm.org>
 <20220623232603.3751912-3-bvanassche@acm.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220623232603.3751912-3-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/24/22 08:25, Bart Van Assche wrote:
> Introduce a function that makes it easy to verify whether a write
> request is for a sequential write required or sequential write preferred
> zone. Simplify blk_req_needs_zone_write_lock() by using the new function.
> 
> Cc: Damien Le Moal <damien.lemoal@wdc.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Looks good.

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

> ---
>  block/blk-zoned.c      | 14 +-------------
>  include/linux/blk-mq.h | 23 +++++++++++++++++++++++
>  2 files changed, 24 insertions(+), 13 deletions(-)
> 
> diff --git a/block/blk-zoned.c b/block/blk-zoned.c
> index 38cd840d8838..cafcbc508dfb 100644
> --- a/block/blk-zoned.c
> +++ b/block/blk-zoned.c
> @@ -57,19 +57,7 @@ EXPORT_SYMBOL_GPL(blk_zone_cond_str);
>   */
>  bool blk_req_needs_zone_write_lock(struct request *rq)
>  {
> -	if (!rq->q->seq_zones_wlock)
> -		return false;
> -
> -	if (blk_rq_is_passthrough(rq))
> -		return false;
> -
> -	switch (req_op(rq)) {
> -	case REQ_OP_WRITE_ZEROES:
> -	case REQ_OP_WRITE:
> -		return blk_rq_zone_is_seq(rq);
> -	default:
> -		return false;
> -	}
> +	return rq->q->seq_zones_wlock && blk_rq_is_zoned_seq_write(rq);
>  }
>  EXPORT_SYMBOL_GPL(blk_req_needs_zone_write_lock);
>  
> diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
> index 909d47e34b7c..d5930797b84d 100644
> --- a/include/linux/blk-mq.h
> +++ b/include/linux/blk-mq.h
> @@ -1136,6 +1136,24 @@ static inline unsigned int blk_rq_zone_is_seq(struct request *rq)
>  	return blk_queue_zone_is_seq(rq->q, blk_rq_pos(rq));
>  }
>  
> +/**
> + * blk_rq_is_zoned_seq_write() - Whether @rq is a write request for a sequential zone.
> + * @rq: Request to examine.
> + *
> + * In this context sequential zone means either a sequential write required or
> + * a sequential write preferred zone.
> + */
> +static inline bool blk_rq_is_zoned_seq_write(struct request *rq)
> +{
> +	switch (req_op(rq)) {
> +	case REQ_OP_WRITE:
> +	case REQ_OP_WRITE_ZEROES:
> +		return blk_rq_zone_is_seq(rq);
> +	default:
> +		return false;
> +	}
> +}
> +
>  bool blk_req_needs_zone_write_lock(struct request *rq);
>  bool blk_req_zone_write_trylock(struct request *rq);
>  void __blk_req_zone_write_lock(struct request *rq);
> @@ -1166,6 +1184,11 @@ static inline bool blk_req_can_dispatch_to_zone(struct request *rq)
>  	return !blk_req_zone_is_write_locked(rq);
>  }
>  #else /* CONFIG_BLK_DEV_ZONED */
> +static inline bool blk_rq_is_zoned_seq_write(struct request *rq)
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
