Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3804FC5479D
	for <linux-block@archiver.kernel.org>; Mon,  9 Jan 2023 23:48:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238051AbjAIXsQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Jan 2023 18:48:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238052AbjAIXsC (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Jan 2023 18:48:02 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E20B40870
        for <linux-block@vger.kernel.org>; Mon,  9 Jan 2023 15:46:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1673307985; x=1704843985;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7Y0j8xQglYV3RsMYVoxTtRNK0VqRZFLgEvMoFDz4ABg=;
  b=DgCx4zTHxixEOvQ+JwjGhS/SUiT7prlXwX3p4VbiYAkU4V+s9i9jzr2d
   1ECixI2zh8IPQciyf60hui7h8An1m3W/2ZwTz2a/Dxb5EYnflf1DCbEQC
   66WYYLqea92GXG384vKevfiRmHUzJgB+0iymKXXJbi0wyF3cNJKC4+R8H
   CqprscvVq7qvry5GiXlRnjEOlDIgrnovA+M7t7vunD2PGO+hNXzliS2E8
   zQUXx5MPl/iM0VzZJTYBJP3wPMc5ZYOCCCz7nj+5Js9SWWtvYPvGUMsrx
   iFgYCXpOC/D8CVhwUHofU789+KwuVNCcxIz+9mzwhiSstyIoVmIuOBTCf
   A==;
X-IronPort-AV: E=Sophos;i="5.96,313,1665417600"; 
   d="scan'208";a="218693444"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jan 2023 07:46:16 +0800
IronPort-SDR: ovFqMWUCQLBLue/g1ImircJ2KhWC0CnvHoU//3eeG+FEwUY2HhDLU4WhIebd2xSyJztxybNp3O
 Y6dzowCWm6WeR0TLoI5ItyxcnBKM+xCDbVn2q/V05QU/FHSOPJxbNVWVQBV1nyGXdaf+h8b26m
 83CXoeJXrI5JA/4IqCJ7GTF0t7kW1SFKRdq5pDNRJf7A7ElPpF7HGcHmmYl6YFDFsX/PVvKGvE
 DEws1crBtUrjvF58omHEJ/YrjWwZK2YBrT9EAmQ1B36MgllGMgHgvMQwu/jCrynLb+gUNPHSUo
 7zU=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Jan 2023 15:04:06 -0800
IronPort-SDR: sRlX6QN42g5+QaQqjwOcZB4w39wXENT++Ngx8Aiu9VpHJ/H5axjCMFKcUKOBSa6I8ZxyyPUpe9
 Scozd59wR0gA1Z0Bb7Bt9rT0RAOijS7yzouJjfDqR4p1XkbJOq8xB9E1s5SBJG1IaR+Sqb0Svb
 Iq4nv1cmCok/hExD80Kh7duMC915cxfYJSsuJ6h3r25G7eM2DQMA1ILq8VKYc4+H1XqI7+S+53
 q3xfvGUaEyFy11+NJUGhgsKPGN3EPyUf8Ckca7c/31ulGq9vDltX0dq5ba6A0IhkdeVnXpiS4N
 x6M=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Jan 2023 15:46:16 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NrVvW62dcz1Rwt8
        for <linux-block@vger.kernel.org>; Mon,  9 Jan 2023 15:46:15 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1673307975; x=1675899976; bh=7Y0j8xQglYV3RsMYVoxTtRNK0VqRZFLgEvM
        oFDz4ABg=; b=kjLxRjB6ldUcE5yNH/zVG76PvzNfw9WqDNJQcZz2KXCiOSFKoc+
        +Cya+EbnnPraKF5z90CtJBdQzkENvcoiN5VdPwSbMnGuxllwPrwp+rbPVL34G4qU
        vlj8YgV2Ego7u5vlcVHpX3Il49l7eY03i/xyapr535mCrJ5KkY2ohAwYQ311jKI/
        kHyiqAJoGKGu0KR0WU1yW1/bbZ3if7vTD8fBw4SrFkfaWRAy7JnDZqa5H8o1TVsJ
        X7IAfr5lW0SXGigNBrXCUiifTKSUn6CA2XLSz2vnjlTjc5yjG6GVkvjnjEMvDM4c
        u2mfF0lyRqi9BP0yR2h0yjMs6h08AZ5RWzQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 8sC8g9ggTIJp for <linux-block@vger.kernel.org>;
        Mon,  9 Jan 2023 15:46:15 -0800 (PST)
Received: from [10.225.163.12] (unknown [10.225.163.12])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NrVvV0f7Nz1RvLy;
        Mon,  9 Jan 2023 15:46:13 -0800 (PST)
Message-ID: <92096c6d-fe0a-7b5b-222f-c532286c0c8b@opensource.wdc.com>
Date:   Tue, 10 Jan 2023 08:46:12 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 4/8] block/mq-deadline: Only use zone locking if necessary
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Avri Altman <avri.altman@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>
References: <20230109232738.169886-1-bvanassche@acm.org>
 <20230109232738.169886-5-bvanassche@acm.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20230109232738.169886-5-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/10/23 08:27, Bart Van Assche wrote:
> Measurements have shown that limiting the queue depth to one for zoned
> writes has a significant negative performance impact on zoned UFS devices.
> Hence this patch that disables zone locking from the mq-deadline scheduler
> for storage controllers that support pipelining zoned writes. This patch is
> based on the following assumptions:
> - Applications submit write requests to sequential write required zones
>   in order.
> - It happens infrequently that zoned write requests are reordered by the
>   block layer.
> - The storage controller does not reorder write requests that have been
>   submitted to the same hardware queue. This is the case for UFS: the
>   UFSHCI specification requires that UFS controllers process requests in
>   order per hardware queue.
> - The I/O priority of all pipelined write requests is the same per zone.
> - Either no I/O scheduler is used or an I/O scheduler is used that
>   submits write requests per zone in LBA order.
> 
> If applications submit write requests to sequential write required zones
> in order, at least one of the pending requests will succeed. Hence, the
> number of retries that is required is at most (number of pending
> requests) - 1.

But if the mid-layer decides to requeue a write request, the workqueue
used in the mq block layer for requeuing is going to completely destroy
write ordering as that is outside of the submission path, working in
parallel with it... Does blk_queue_pipeline_zoned_writes() == true also
guarantee that a write request will *never* be requeued before hitting the
adapter/device ?

> 
> Cc: Damien Le Moal <damien.lemoal@wdc.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  block/blk-zoned.c   |  3 ++-
>  block/mq-deadline.c | 14 +++++++++-----
>  2 files changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/block/blk-zoned.c b/block/blk-zoned.c
> index db829401d8d0..158638091e39 100644
> --- a/block/blk-zoned.c
> +++ b/block/blk-zoned.c
> @@ -520,7 +520,8 @@ static int blk_revalidate_zone_cb(struct blk_zone *zone, unsigned int idx,
>  		break;
>  	case BLK_ZONE_TYPE_SEQWRITE_REQ:
>  	case BLK_ZONE_TYPE_SEQWRITE_PREF:
> -		if (!args->seq_zones_wlock) {
> +		if (!blk_queue_pipeline_zoned_writes(q) &&
> +		    !args->seq_zones_wlock) {
>  			args->seq_zones_wlock =
>  				blk_alloc_zone_bitmap(q->node, args->nr_zones);
>  			if (!args->seq_zones_wlock)
> diff --git a/block/mq-deadline.c b/block/mq-deadline.c
> index f10c2a0d18d4..e41808c0b007 100644
> --- a/block/mq-deadline.c
> +++ b/block/mq-deadline.c
> @@ -339,7 +339,8 @@ deadline_fifo_request(struct deadline_data *dd, struct dd_per_prio *per_prio,
>  		return NULL;
>  
>  	rq = rq_entry_fifo(per_prio->fifo_list[data_dir].next);
> -	if (data_dir == DD_READ || !blk_queue_is_zoned(rq->q))
> +	if (data_dir == DD_READ || !blk_queue_is_zoned(rq->q) ||
> +	    blk_queue_pipeline_zoned_writes(rq->q))
>  		return rq;
>  
>  	/*
> @@ -378,7 +379,8 @@ deadline_next_request(struct deadline_data *dd, struct dd_per_prio *per_prio,
>  	if (!rq)
>  		return NULL;
>  
> -	if (data_dir == DD_READ || !blk_queue_is_zoned(rq->q))
> +	if (data_dir == DD_READ || !blk_queue_is_zoned(rq->q) ||
> +	    blk_queue_pipeline_zoned_writes(rq->q))
>  		return rq;
>  
>  	/*
> @@ -503,8 +505,9 @@ static struct request *__dd_dispatch_request(struct deadline_data *dd,
>  	}
>  
>  	/*
> -	 * For a zoned block device, if we only have writes queued and none of
> -	 * them can be dispatched, rq will be NULL.
> +	 * For a zoned block device that requires write serialization, if we
> +	 * only have writes queued and none of them can be dispatched, rq will
> +	 * be NULL.
>  	 */
>  	if (!rq)
>  		return NULL;
> @@ -893,7 +896,8 @@ static void dd_finish_request(struct request *rq)
>  
>  	atomic_inc(&per_prio->stats.completed);
>  
> -	if (blk_queue_is_zoned(q)) {
> +	if (blk_queue_is_zoned(rq->q) &&
> +	    !blk_queue_pipeline_zoned_writes(q)) {
>  		unsigned long flags;
>  
>  		spin_lock_irqsave(&dd->zone_lock, flags);

-- 
Damien Le Moal
Western Digital Research

