Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02751C43334
	for <linux-block@archiver.kernel.org>; Fri, 24 Jun 2022 00:26:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbiFXA0U (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Jun 2022 20:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiFXA0U (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Jun 2022 20:26:20 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AEA252E41
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 17:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1656030379; x=1687566379;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=PcaUG0kfL6OsScSuPNGcU3VZ0nhk6izhqMoFBTs8Jqc=;
  b=l/Oi3jiOK48QqE8cImoWDaqHk1cLqlyS0UXYu/6vIDokxwsVJYaxiI2I
   bUBhWapQ4k0HkRkcb0v8L+kYBEf4c8KTJGXAIObkvcR+vZw3B1CGuXXAA
   1wEPH1HYkzIM6PhC/aXm+cdF0TLmecY6CI36JqIYO0xKn1C6X+EW4RNy2
   wQo6HJjtKP0dFxIgCrxswy5BUedJ5uEsriQISOKcQzLDKDnLI8vP752L/
   MPsBsryd58pJUPj5vKE2GCcww2c8Y3PMiVjgLqzXonCirI+CaukIJqO4z
   uITglaodo1c42LKg2wtJ3hXS/iI0RChcvrwTqhXKLH7GRbS9s44Z/eaTP
   g==;
X-IronPort-AV: E=Sophos;i="5.92,217,1650902400"; 
   d="scan'208";a="308293950"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 24 Jun 2022 08:26:18 +0800
IronPort-SDR: Z0ru4S9tRQ3MWr7s4bfzmG/CzrQDYyGcbKgSoPDv4wLpLKN+RHbBJQchtnkm3wv+V/e19/uKpK
 t3iqiC8bLI4I6uHTWYfKVRZnZQVywjPjOhrpnUqsRdwk6I4KOq+VwEv1JAsWw+ArnQKnZ6u+tx
 9vOlPQk4RDWRt1S33kAx7v/19Yx254BlBj1Z3CRanYhzlCg1Dn6fo02jO1BVIX9+uKGLas0dfV
 7uxbn4hn3XR7uaAqBNWoijJ89csmy1QshFX6wApxm9EdXJP9pXgCBaS97wAUnceG0I0eK931NE
 ULYA/ERcVJhAwu7dCiTsaebE
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Jun 2022 16:48:45 -0700
IronPort-SDR: awtqvPJm5X6LVnDtID5gt79BiwRsZ2Oq/4IdWwZwbFKHJqjR8lbx+31D13zvzyTG7wfJusUTLo
 QlgSLNEpXp2x6vgKN80wL8APttS8ackxFhk8EmW/SlPlRUY8g4SzoNb9o8t4duVk1hwNlvmq0W
 xqwXmOrr+7L1Zm1/uvNnQGBYd8lmVdKe2JvcRRYxSAvDOivUht0M2mwG+hevOiDcSaqLlhfbo1
 hFgiF9WtFTWx8iHga/d4Vb4+JPsj3Wx/6GRwM9Uq1GBZl+H/u/e9khbgJRxlBIWyTTcoujkzd5
 SS4=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Jun 2022 17:26:18 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LTdG171gqz1Rwnx
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 17:26:17 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1656030377; x=1658622378; bh=PcaUG0kfL6OsScSuPNGcU3VZ0nhk6izhqMo
        FBTs8Jqc=; b=chwhW5o+izRAQDlUwNu46AIgT4qfVCduu1eBxZKXYOY5e2Vw1G6
        xMZhrQbCtng2zkhW+T7xccdDXY2gSZsCTNv22hYxTs0hejb3x5lhw/dO0m1FmULa
        MbySRfY3Y2OtBdtFGBbjhsJ7olFwZp9qtVcq6LMoAR3RMsZbrQ3UOylQEn0AoQDs
        lIhNJ3fOWKjpLWRkuiLXCjtnP9amQe44kspPplpD1pJe1D1DOOGPC6S0haiLYNpE
        8huYB03/1hExQl6HBDMuStQB4Ilmx8cqbLpxUr4x3QcUye/RnyM0T1FF/vKaf39P
        aKAyqys1/v8rfXJpmEQV9lyKKjLkJ87WCow==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id nJsjguPaKIZk for <linux-block@vger.kernel.org>;
        Thu, 23 Jun 2022 17:26:17 -0700 (PDT)
Received: from [10.225.163.93] (unknown [10.225.163.93])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LTdG036F7z1RtVk;
        Thu, 23 Jun 2022 17:26:16 -0700 (PDT)
Message-ID: <e583d9d5-6b4e-ee0a-12ec-63aaa5f83df5@opensource.wdc.com>
Date:   Fri, 24 Jun 2022 09:26:15 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 5/6] block/null_blk: Refactor null_queue_rq()
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <20220623232603.3751912-1-bvanassche@acm.org>
 <20220623232603.3751912-6-bvanassche@acm.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220623232603.3751912-6-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/24/22 08:26, Bart Van Assche wrote:
> Introduce a local variable for the expression bd->rq since that expression
> occurs multiple times. This patch does not change any functionality.
> 
> Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Looks good. Completely independent from the series goal though, so this
can be applied independently I think.

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

> ---
>  drivers/block/null_blk/main.c | 21 +++++++++++----------
>  1 file changed, 11 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
> index 6b67088f4ea7..fd68e6f4637f 100644
> --- a/drivers/block/null_blk/main.c
> +++ b/drivers/block/null_blk/main.c
> @@ -1609,10 +1609,11 @@ static enum blk_eh_timer_return null_timeout_rq(struct request *rq, bool res)
>  static blk_status_t null_queue_rq(struct blk_mq_hw_ctx *hctx,
>  			 const struct blk_mq_queue_data *bd)
>  {
> -	struct nullb_cmd *cmd = blk_mq_rq_to_pdu(bd->rq);
> +	struct request *rq = bd->rq;
> +	struct nullb_cmd *cmd = blk_mq_rq_to_pdu(rq);
>  	struct nullb_queue *nq = hctx->driver_data;
> -	sector_t nr_sectors = blk_rq_sectors(bd->rq);
> -	sector_t sector = blk_rq_pos(bd->rq);
> +	sector_t nr_sectors = blk_rq_sectors(rq);
> +	sector_t sector = blk_rq_pos(rq);
>  	const bool is_poll = hctx->type == HCTX_TYPE_POLL;
>  
>  	might_sleep_if(hctx->flags & BLK_MQ_F_BLOCKING);
> @@ -1621,14 +1622,14 @@ static blk_status_t null_queue_rq(struct blk_mq_hw_ctx *hctx,
>  		hrtimer_init(&cmd->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
>  		cmd->timer.function = null_cmd_timer_expired;
>  	}
> -	cmd->rq = bd->rq;
> +	cmd->rq = rq;
>  	cmd->error = BLK_STS_OK;
>  	cmd->nq = nq;
> -	cmd->fake_timeout = should_timeout_request(bd->rq);
> +	cmd->fake_timeout = should_timeout_request(rq);
>  
> -	blk_mq_start_request(bd->rq);
> +	blk_mq_start_request(rq);
>  
> -	if (should_requeue_request(bd->rq)) {
> +	if (should_requeue_request(rq)) {
>  		/*
>  		 * Alternate between hitting the core BUSY path, and the
>  		 * driver driven requeue path
> @@ -1637,21 +1638,21 @@ static blk_status_t null_queue_rq(struct blk_mq_hw_ctx *hctx,
>  		if (nq->requeue_selection & 1)
>  			return BLK_STS_RESOURCE;
>  		else {
> -			blk_mq_requeue_request(bd->rq, true);
> +			blk_mq_requeue_request(rq, true);
>  			return BLK_STS_OK;
>  		}
>  	}
>  
>  	if (is_poll) {
>  		spin_lock(&nq->poll_lock);
> -		list_add_tail(&bd->rq->queuelist, &nq->poll_list);
> +		list_add_tail(&rq->queuelist, &nq->poll_list);
>  		spin_unlock(&nq->poll_lock);
>  		return BLK_STS_OK;
>  	}
>  	if (cmd->fake_timeout)
>  		return BLK_STS_OK;
>  
> -	return null_handle_cmd(cmd, sector, nr_sectors, req_op(bd->rq));
> +	return null_handle_cmd(cmd, sector, nr_sectors, req_op(rq));
>  }
>  
>  static void cleanup_queue(struct nullb_queue *nq)


-- 
Damien Le Moal
Western Digital Research
