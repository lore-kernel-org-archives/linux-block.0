Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9EA9C433FE
	for <linux-block@archiver.kernel.org>; Wed,  5 Oct 2022 05:08:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbiJEFI3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Oct 2022 01:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbiJEFIL (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Oct 2022 01:08:11 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AAB7754A0
        for <linux-block@vger.kernel.org>; Tue,  4 Oct 2022 22:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1664946370; x=1696482370;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0pE8SWk3gn49XyZ2JaOcaJZ30Oakt5RO9wh2Pd4mYno=;
  b=ONNmazvLB+DrA4JPT/WbS7Zqjk5WGq12jwN3oAo+wUQ9jPfJHB9Ib4dV
   ydRJWT5qThcLmtC9PtSnzajYDICwwkFM8KYl6DQNQ/wVdSe7gCYoboby2
   vt06fFLVvrrtrAHsH/Ef8PttoaLYFps+B/whH05YBGBYVYFxactuwiY8L
   7SBx3SucMAekHf5X1v+0FPHrk8VZkIrrljT6kvzPbaVEdtHSxzrRSEixb
   iVM5o4gL7QMjzlE5idyjR4cweP6PmEln6Zflz3lczhjoPKx5igU/v5M/w
   11kb983/6LhuN+1BcdjWvRfesR6l4CgepRAmSZPkeVGmSojxvWbhGiyKh
   Q==;
X-IronPort-AV: E=Sophos;i="5.95,159,1661788800"; 
   d="scan'208";a="218194853"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 05 Oct 2022 13:06:03 +0800
IronPort-SDR: 6M2kB4ib5J7B16Zn23kzqVuU2ZIe0Kg5KHr92juXqK3tHnZcqHGWflxkZv0QPc+H37x+GICXaZ
 yANHGeC4I/AyoLxJvd9hk15QQjGKjSgJaL5y9+7Z1qI9P684vDRUNzpfm6L/a3qKWDN4JlamMO
 uB1JDVqlOLLQM480GbWeMIglTQJQhgNGIyOhun1EYswu3pEX2nsVFAIGzGSiEdFRL0U9Ots/6b
 bUMTvzsoXRV2QiU1VFHfYKO8qFUXzrlxfKW6D1V7ShVB/hZ/7f+Ui720Ge67RMEl4pPALe4SMB
 +aO3Xgwkja+LQPjl3Hfy+7EC
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Oct 2022 21:20:16 -0700
IronPort-SDR: mA4dXgOubl1DpyCd6lxxSI4Wk+3oOKS2wOsETfAAwUxnmpqyV5hNhkZqddvdnmZhJatbUiYeKc
 SIMpofp8uK5D5CqZkXD92PBN9wyiF0ZledA7V1E1F7rQq/decDgZwQVbu6A7L7NX6fdONofOvj
 xEGHG8RZtl3xfxTvA+9kvkQ//hXyp4dU3KECzVlYzmGDWIVe6mbW6Vh+Mk3/5tX0z+LckeP0kZ
 dFyth5YB5DufA5J4YP+vFDmj0to4ThkMavKTeGtFecSn4u1ACWFJhiSf7TQGUdAkkxGElDyuEk
 YQc=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Oct 2022 22:06:04 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Mj2bG5d2wz1Rwt8
        for <linux-block@vger.kernel.org>; Tue,  4 Oct 2022 22:06:02 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1664946361; x=1667538362; bh=0pE8SWk3gn49XyZ2JaOcaJZ30Oakt5RO9wh
        2Pd4mYno=; b=eFfu9R9RykT/OwoQ6/Mvm+LYmnCmmSgUx6ePeitFiBKdVqF2zyJ
        /1r2/RwxJoQ3h/hhEnJiYbT/RjlckZJs/T3DbPNYAFqQ4wbwvzXEVugdml19+PCj
        0W99jvpjy/7aHE9Q4lD3EkTY5YFIkLN9vHIyB8zTezoGmAD6Yc7w+uX322ZcKF9W
        HN8ZebWjCuhAu1Q7xWIy+XrvVQZvQnGzadVri9imjUuqfg6m2T08BiuLYu/OdoNc
        O3sTLjAiLIZx8NQLALtqnW+YpEDsivWEQeRqHSt5Vn+tkrXLaEcD0qk53muLvw2A
        pTZIW8285ZKDcZLv3SYQS6sBcaFuLxS4hsA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Hxq2wWt-TzZB for <linux-block@vger.kernel.org>;
        Tue,  4 Oct 2022 22:06:01 -0700 (PDT)
Received: from [10.225.163.106] (unknown [10.225.163.106])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Mj2bD3hMqz1RvLy;
        Tue,  4 Oct 2022 22:06:00 -0700 (PDT)
Message-ID: <0e3894bf-7d06-bac9-8efc-fa73bf3fb902@opensource.wdc.com>
Date:   Wed, 5 Oct 2022 14:05:59 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 5/6] null_blk: don't use magic numbers in the code
Content-Language: en-US
To:     Chaitanya Kulkarni <kch@nvidia.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     axboe@kernel.dk, johannes.thumshirn@wdc.com, bvanassche@acm.org,
        ming.lei@redhat.com, shinichiro.kawasaki@wdc.com,
        vincent.fu@samsung.com, yukuai3@huawei.com
References: <20221005031701.79077-1-kch@nvidia.com>
 <20221005031701.79077-6-kch@nvidia.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20221005031701.79077-6-kch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/5/22 12:17, Chaitanya Kulkarni wrote:
> Insteasd of using the hardcoded value use meaningful macro for tag
> available value of -1U in get_tag() and __alloc_cmd().
> 
> While at it return early on error to get rid of the extra indentation
> in __alloc_cmd().
> 
> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

> ---
>  drivers/block/null_blk/main.c | 30 +++++++++++++++---------------
>  1 file changed, 15 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
> index 765c1ca0edf5..eda5050d6dee 100644
> --- a/drivers/block/null_blk/main.c
> +++ b/drivers/block/null_blk/main.c
> @@ -24,6 +24,8 @@
>  #define TICKS_PER_SEC		50ULL
>  #define TIMER_INTERVAL		(NSEC_PER_SEC / TICKS_PER_SEC)
>  
> +#define NULL_REQ_TAG_NOT_AVAILABLE (-1U)
> +
>  #ifdef CONFIG_BLK_DEV_NULL_BLK_FAULT_INJECTION
>  static DECLARE_FAULT_ATTR(null_timeout_attr);
>  static DECLARE_FAULT_ATTR(null_requeue_attr);
> @@ -730,7 +732,7 @@ static unsigned int get_tag(struct nullb_queue *nq)
>  	do {
>  		tag = find_first_zero_bit(nq->tag_map, nq->queue_depth);
>  		if (tag >= nq->queue_depth)
> -			return -1U;
> +			return NULL_REQ_TAG_NOT_AVAILABLE;
>  	} while (test_and_set_bit_lock(tag, nq->tag_map));
>  
>  	return tag;
> @@ -749,21 +751,19 @@ static struct nullb_cmd *__alloc_cmd(struct nullb_queue *nq, struct bio *bio)
>  	unsigned int tag;
>  
>  	tag = get_tag(nq);
> -	if (tag != -1U) {
> -		cmd = &nq->cmds[tag];
> -		cmd->tag = tag;
> -		cmd->error = BLK_STS_OK;
> -		cmd->nq = nq;
> -		cmd->bio = bio;
> -		if (nq->dev->irqmode == NULL_IRQ_TIMER) {
> -			hrtimer_init(&cmd->timer, CLOCK_MONOTONIC,
> -				     HRTIMER_MODE_REL);
> -			cmd->timer.function = null_cmd_timer_expired;
> -		}
> -		return cmd;
> +	if (tag == NULL_REQ_TAG_NOT_AVAILABLE)
> +		return NULL;
> +	cmd = &nq->cmds[tag];
> +	cmd->tag = tag;
> +	cmd->error = BLK_STS_OK;
> +	cmd->nq = nq;
> +	cmd->bio = bio;
> +	if (nq->dev->irqmode == NULL_IRQ_TIMER) {
> +		hrtimer_init(&cmd->timer, CLOCK_MONOTONIC,
> +				HRTIMER_MODE_REL);
> +		cmd->timer.function = null_cmd_timer_expired;
>  	}
> -
> -	return NULL;
> +	return cmd;
>  }
>  
>  static struct nullb_cmd *alloc_cmd(struct nullb_queue *nq, struct bio *bio)

-- 
Damien Le Moal
Western Digital Research

