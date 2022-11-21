Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A82FC4332F
	for <linux-block@archiver.kernel.org>; Mon, 21 Nov 2022 01:01:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbiKUBBP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 20 Nov 2022 20:01:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbiKUBBO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 20 Nov 2022 20:01:14 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 460C42716B
        for <linux-block@vger.kernel.org>; Sun, 20 Nov 2022 17:01:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1668992473; x=1700528473;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=nqZwB4mUx5KtpzA6T+C4d6z/dqxxnpNbzXCnsfbUA04=;
  b=L6yClymG154weV5s9Img3H6uHf8pdDylzOAM6gG0PVxKfrZ22qtdarIu
   u5DBgHpr8upJxcu8HKWrlsV93d22YtUkK63Z3ISXw1WGy01y0ff9si95U
   0efDD/PTqQHc9eLq3Zxo8H2UMhxUk8x/cnQWTcjBX7Or2TuSDGCAy6yi8
   Qyfoclhr09dfIx8sjK0VhFygdjM1AC20NCS7yJRmZ6Cg3x/wJMALP07V/
   wKXYR0XTKxWRGkrtvzso+lkckjtboMQDswBOyx0sVs+2mpNSzXYPAOIRQ
   saOiEjxRDLVt+BQkecSf8Rdz2NQJo3z9LG43qZjNgauTQ4+j6RweaCvxF
   g==;
X-IronPort-AV: E=Sophos;i="5.96,180,1665417600"; 
   d="scan'208";a="216740453"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 21 Nov 2022 09:01:12 +0800
IronPort-SDR: Wyb8xAuTYAqQBSsdI1uJHhN7YxIQbJseGSc7FX3f0aHTNtw82ykMX3cPbrwxLWo/qHHFhfxyis
 r6rHaQKtGup73kC4f8EXdtWFGxZzjEqMrVgbvMIssphb8B9r6BYOOccn08lHMRtDz35cADpFj5
 QvmZ0pkdKruucgFl38Wl71CY3VSGDNzOx0w2vi9AoVJZUb3RkMZCVEI/jCGRAHo5uB/ypBBFNn
 1UkX1F7mNrsl4SASF4WaZuR7d1rulfJIUYxKuT8pdMPKPUwrafq3rfpoYrPff6AR8ogK59kbxG
 IRM=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Nov 2022 16:14:18 -0800
IronPort-SDR: vcXRBrCqbWjsM9CT34g+lI3TFLPkJIfTbjrSAsQVQ+eBW75SWb6EOyJ7tee55raKl8mlzVVdyk
 /jT+1wSN2ss8ZHsQkSek/iOPBs1qHf7wBcfWLoQP1jg/U1ZIaSxriFaHoN3rIhSMtS2HS4/EsJ
 NdI70Ipaea6lk8X+H4eqYuwlQVZYIrYgm8/iWXl0qgBdz2W5erIDYu9UmyyhYTQ5Cmst0PiHwb
 fiYZEQSn3waMCN93wlA3chWnx8yiIDBOap2WPD5b76UZEApKREmKOcpWxyyAF7nAXpJXutKLrD
 6D4=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Nov 2022 17:01:13 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NFpx43TtGz1RvTr
        for <linux-block@vger.kernel.org>; Sun, 20 Nov 2022 17:01:12 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1668992471; x=1671584472; bh=nqZwB4mUx5KtpzA6T+C4d6z/dqxxnpNbzXC
        nsfbUA04=; b=QRgGHXST91rVQRzoT0CMFD1RxF9sloXcoL2DuuMlEam6hYIbPMC
        hTZg+Y8k60Dv3VPhKkCUbBJitEzP+h0VIRkIJTja3ihtjjgyPTmWUr1PMgpVe2Vm
        D8Y1SrgUafCig8DxyhYjE3whmzRe8msWR9Q6LX77BnjfCOpWFhPRj8zwh60pFXcm
        G3hfN/ktvct1HvDlZUhwL+JjSALlAglXhR+1dhzV4HhAf/92GUDfb09wxYq/EKgS
        lk/3Img2NEDLoZDXkqIWP/XVU8DkdIZcEitJFgONzmPrdhu31hpPx58OaEsekrNd
        NhDVMXGOo2NDCuIAbZn2/60u0OKr3JGHAVg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id y7Z1T5eVQOQa for <linux-block@vger.kernel.org>;
        Sun, 20 Nov 2022 17:01:11 -0800 (PST)
Received: from [10.225.163.53] (unknown [10.225.163.53])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NFpx21vDGz1RvLy;
        Sun, 20 Nov 2022 17:01:10 -0800 (PST)
Message-ID: <5d062001-2fff-35e5-d951-a61b510727d9@opensource.wdc.com>
Date:   Mon, 21 Nov 2022 10:01:08 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH V6 6/8] block, bfq: retrieve independent access ranges
 from request queue
Content-Language: en-US
To:     Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        arie.vanderhoeven@seagate.com, rory.c.chen@seagate.com,
        Federico Gavioli <f.gavioli97@gmail.com>
References: <20221103162623.10286-1-paolo.valente@linaro.org>
 <20221103162623.10286-7-paolo.valente@linaro.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20221103162623.10286-7-paolo.valente@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/4/22 01:26, Paolo Valente wrote:
> From: Federico Gavioli <f.gavioli97@gmail.com>
> 
> This patch implements the code to gather the content of the
> independent_access_ranges structure from the request_queue and copy
> it into the queue's bfq_data. This copy is done at queue initialization.
> 
> We copy the access ranges into the bfq_data to avoid taking the queue
> lock each time we access the ranges.
> 
> This implementation, however, puts a limit to the maximum independent
> ranges supported by the scheduler. Such a limit is equal to the constant
> BFQ_MAX_ACTUATORS. This limit was placed to avoid the allocation of
> dynamic memory.
> 
> Co-developed-by: Rory Chen <rory.c.chen@seagate.com>
> Signed-off-by: Rory Chen <rory.c.chen@seagate.com>
> Signed-off-by: Federico Gavioli <f.gavioli97@gmail.com>
> Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
> ---
>  block/bfq-iosched.c | 54 ++++++++++++++++++++++++++++++++++++++-------
>  block/bfq-iosched.h |  5 +++++
>  2 files changed, 51 insertions(+), 8 deletions(-)
> 
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index c94b80e3f685..106c8820cc5c 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -1831,10 +1831,26 @@ static bool bfq_bfqq_higher_class_or_weight(struct bfq_queue *bfqq,
>  /* get the index of the actuator that will serve bio */
>  static unsigned int bfq_actuator_index(struct bfq_data *bfqd, struct bio *bio)
>  {
> -	/*
> -	 * Multi-actuator support not complete yet, so always return 0
> -	 * for the moment.
> -	 */
> +	struct blk_independent_access_range *iar;
> +	unsigned int i;
> +	sector_t end;
> +
> +	/* no search needed if one or zero ranges present */
> +	if (bfqd->num_actuators < 2)
> +		return 0;
> +
> +	/* bio_end_sector(bio) gives the sector after the last one */
> +	end = bio_end_sector(bio) - 1;
> +
> +	for (i = 0; i < bfqd->num_actuators; i++) {
> +		iar = &(bfqd->ia_ranges[i]);
> +		if (end >= iar->sector && end < iar->sector + iar->nr_sectors)
> +			return i;
> +	}
> +
> +	WARN_ONCE(true,
> +		  "bfq_actuator_index: bio sector out of ranges: end=%llu\n",
> +		  end);
>  	return 0;
>  }
>  
> @@ -2479,7 +2495,6 @@ static void bfq_remove_request(struct request_queue *q,
>  
>  	if (rq->cmd_flags & REQ_META)
>  		bfqq->meta_pending--;
> -

whiteline change

>  }
>  
>  static bool bfq_bio_merge(struct request_queue *q, struct bio *bio,
> @@ -7144,6 +7159,8 @@ static int bfq_init_queue(struct request_queue *q, struct elevator_type *e)
>  {
>  	struct bfq_data *bfqd;
>  	struct elevator_queue *eq;
> +	unsigned int i;
> +	struct blk_independent_access_ranges *ia_ranges = q->disk->ia_ranges;
>  
>  	eq = elevator_alloc(q, e);
>  	if (!eq)
> @@ -7187,10 +7204,31 @@ static int bfq_init_queue(struct request_queue *q, struct elevator_type *e)
>  	bfqd->queue = q;
>  
>  	/*
> -	 * Multi-actuator support not complete yet, default to single
> -	 * actuator for the moment.
> +	 * If the disk supports multiple actuators, we copy the independent
> +	 * access ranges from the request queue structure.
>  	 */
> -	bfqd->num_actuators = 1;
> +	spin_lock_irq(&q->queue_lock);
> +	if (ia_ranges) {
> +		/*
> +		 * Check if the disk ia_ranges size exceeds the current bfq
> +		 * actuator limit.
> +		 */
> +		if (ia_ranges->nr_ia_ranges > BFQ_MAX_ACTUATORS) {
> +			pr_crit("nr_ia_ranges higher than act limit: iars=%d, max=%d.\n",
> +				ia_ranges->nr_ia_ranges, BFQ_MAX_ACTUATORS);
> +			pr_crit("Falling back to single actuator mode.\n");
> +			bfqd->num_actuators = 0;
> +		} else {
> +			bfqd->num_actuators = ia_ranges->nr_ia_ranges;
> +
> +			for (i = 0; i < bfqd->num_actuators; i++)
> +				bfqd->ia_ranges[i] = ia_ranges->ia_range[i];
> +		}
> +	} else {
> +		bfqd->num_actuators = 0;

That is very weird. The default should be 1 actuator.
ia_ranges->nr_ia_ranges is 0 when the disk does not provide any range
information, meaning it is a regular disk with a single actuator.

> +	}
> +
> +	spin_unlock_irq(&q->queue_lock);
>  
>  	INIT_LIST_HEAD(&bfqd->dispatch);
>  
> diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
> index f1c2e77cbf9a..90130a893c8f 100644
> --- a/block/bfq-iosched.h
> +++ b/block/bfq-iosched.h
> @@ -811,6 +811,11 @@ struct bfq_data {
>  	 */
>  	unsigned int num_actuators;
>  
> +	/*
> +	 * Disk independent access ranges for each actuator
> +	 * in this device.
> +	 */
> +	struct blk_independent_access_range ia_ranges[BFQ_MAX_ACTUATORS];

I fail to see how keeping this information is useful, especially given
that this struct contains a kobj. Why not just copy the sector &
nr_sectors fields into struct bfq_queue ? That would also work for the
single actuator case as then sector will be 0 and nr_sectors will be the
disk total capacity.

I think this patch should be first in the series. That will avoid having
the empty bfq_actuator_index() function.

>  };
>  
>  enum bfqq_state_flags {

-- 
Damien Le Moal
Western Digital Research

