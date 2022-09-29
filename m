Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1DA9C04A95
	for <linux-block@archiver.kernel.org>; Thu, 29 Sep 2022 08:15:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235229AbiI2IPm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Sep 2022 04:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234845AbiI2IPi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Sep 2022 04:15:38 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B33C130BCC
        for <linux-block@vger.kernel.org>; Thu, 29 Sep 2022 01:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1664439334; x=1695975334;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zFlfMdi3Da6RsWnIANK01fGaWY3v/lhWq/v9KEeyLyk=;
  b=bW46R3HPUMzBxSXDPhXWr+WQGbunjxURLpWddo9qJUmYzHw3+btk7ZgR
   E+rkpNjWR07WYJegtTvtC8MxQ4nh88Vm43MfYbhbmHWAPqBlewV0Y4ERO
   fQMInoQnGsVAke6ClsKaemB6Au/I9j+W9a83S0v6fCfSZ0u1qz49WPQy6
   ecAS7yv5HMCBx4wIeczpB59DqIHj6bolFDXPD0WWZXuKkF8vBQTnZ7Ziv
   7HCBIM3T5xD2HfzFkkqhA/2rev56kAuHADdD4SmuL2yNZZEJRMIqU7TOJ
   vdsI5Jfyf+QPZp/sZf3CkCeRaTIiWeAo+K5wdIV97tgurvUNOQk+7+kN+
   A==;
X-IronPort-AV: E=Sophos;i="5.93,354,1654531200"; 
   d="scan'208";a="212562179"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 29 Sep 2022 16:15:33 +0800
IronPort-SDR: SBARXcCpGPUhqxxnGXT8Ilf69kgd1x8wkE+0QkNFPmWmQNbUwsAA6EXjayrPq6iNcgTrerZ9di
 Ch3/W1oXPDSyxKicKwvfR4RNgrrDGR+qV6wfGcJMp567aKksySZL9u6PXA0wLCcDy/RP3Y8X89
 q2ZApHgh7up+74xpa68EtL9g2BWsfCxH2tRgy5J2clUHL8O0ph9JW4vkNt/Jl7+7BPVnswr2D0
 ujlkk/uhdEw6qjS2B72qaANzSj9WktVRXZj7kzXmeioqi6NCMtlPzG+r+vEc0X9P28YXr7h9C4
 X6YIvCXV8XNhxpEgOkORHUc6
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Sep 2022 00:29:56 -0700
IronPort-SDR: lLgGv23XOQ0Q5l2mhA8pRgdZJNqfORtAa7sC3iBSlLhyWGmMFQbxMP9ks2/90QQgNccBqKJj1v
 f+VeJ64JlUHlLn9TaYoteAopc/N46ybDJ3YWNQVfLeQOYifekIg3xDuk0qdWNsahioiLupEad9
 sb6FjY5xeZNsUUbqaFRDsEZg6GpY/Jc4jryKWY7GoOdPVhKtEPckgymoQdJVdep6kJ2d9dpBn1
 c7jBlKg7hMkm2/SliZHoMEZ1R63WcsTnXLJRDLuF9u9mDHO1A6t5NPQGEmWzsWjci3sKFDri+u
 hpc=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Sep 2022 01:15:34 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MdR4h6nC2z1RvTr
        for <linux-block@vger.kernel.org>; Thu, 29 Sep 2022 01:15:32 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1664439332; x=1667031333; bh=zFlfMdi3Da6RsWnIANK01fGaWY3v/lhWq/v
        9KEeyLyk=; b=aMxaQrGcORBHea41JwD2ooxZaDkM1zh19Hw/EwNyuGaYbWMBi9d
        K1r99e1H9fRh5HmYYNUP8CBt15HaxMtYnuyZK0b5k/GDEY/u5lXjQpTmetppxb2O
        BoyR2z4uBNP5jk4dJQAMX3sM1wmYyCUaJbxHATcTTlSAyOPprj8nbjqZT78boHdj
        Zyj/Xz2+/B0XzM5OYKGfu0To8yVAPk/k1Pv2j+zTR97ppyjCfGTaD3pZ0pfVwASq
        WyjeIJDNTrK9v7VnvD4DI96HebdOdFugi8YgeG9ldjW1q3KIygHrrY3YXaaZ5F9Q
        P9gY3j8c/tkYBfJ7F1eUVOS0GpKj7m1R/5g==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id MBHR7r2Cmpqg for <linux-block@vger.kernel.org>;
        Thu, 29 Sep 2022 01:15:32 -0700 (PDT)
Received: from [10.225.163.96] (unknown [10.225.163.96])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MdR4g5SGMz1RvLy;
        Thu, 29 Sep 2022 01:15:31 -0700 (PDT)
Message-ID: <6e4efa73-7488-cd38-0726-35114039a253@opensource.wdc.com>
Date:   Thu, 29 Sep 2022 17:15:30 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v3 2/2] block: use blk_mq_plug() wrapper consistently in
 the block layer
Content-Language: en-US
To:     Pankaj Raghav <p.raghav@samsung.com>, axboe@kernel.dk, hch@lst.de
Cc:     gost.dev@samsung.com, linux-block@vger.kernel.org
References: <20220929074745.103073-1-p.raghav@samsung.com>
 <CGME20220929074749eucas1p206ebab35a37e629ed49924506e325554@eucas1p2.samsung.com>
 <20220929074745.103073-3-p.raghav@samsung.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220929074745.103073-3-p.raghav@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/29/22 16:47, Pankaj Raghav wrote:
> Use blk_mq_plug() wrapper to get the plug instead of directly accessing
> it in the block layer.
> 
> Either of the changes should not have led to a bug in zoned devices:
> 
> - blk_execute_rq_nowait:
>   Only passthrough requests can use this function, and plugging can be
>   performed on those requests in zoned devices. So no issues directly
>   accessing the plug.
> 
> - blk_flush_plug in bio_poll:
>   As we don't plug the requests that require a zone lock in the first
>   place, flushing should not have any impact. So no issues directly
>   accessing the plug.
> 
> This is just a cleanup patch to use this wrapper to get the plug
> consistently across the block layer.
> 
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>


> ---
>  block/blk-core.c | 2 +-
>  block/blk-mq.c   | 6 ++++--
>  2 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 203be672da52..d0e97de216db 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -850,7 +850,7 @@ int bio_poll(struct bio *bio, struct io_comp_batch *iob, unsigned int flags)
>  	    !test_bit(QUEUE_FLAG_POLL, &q->queue_flags))
>  		return 0;
>  
> -	blk_flush_plug(current->plug, false);
> +	blk_flush_plug(blk_mq_plug(bio), false);
>  
>  	if (bio_queue_enter(bio))
>  		return 0;
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index c11949d66163..5bf245c4bf0a 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -1209,12 +1209,14 @@ static void blk_add_rq_to_plug(struct blk_plug *plug, struct request *rq)
>   */
>  void blk_execute_rq_nowait(struct request *rq, bool at_head)
>  {
> +	struct blk_plug *plug = blk_mq_plug(rq->bio);
> +
>  	WARN_ON(irqs_disabled());
>  	WARN_ON(!blk_rq_is_passthrough(rq));
>  
>  	blk_account_io_start(rq);
> -	if (current->plug)
> -		blk_add_rq_to_plug(current->plug, rq);
> +	if (plug)
> +		blk_add_rq_to_plug(plug, rq);
>  	else
>  		blk_mq_sched_insert_request(rq, at_head, true, false);
>  }

-- 
Damien Le Moal
Western Digital Research

