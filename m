Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E73AC433EF
	for <linux-block@archiver.kernel.org>; Fri, 24 Jun 2022 00:24:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbiFXAYU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Jun 2022 20:24:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiFXAYS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Jun 2022 20:24:18 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AA97522F9
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 17:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1656030258; x=1687566258;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=rE5wHaFYlcKTzoSgEhSHrpfc4G4Shz8Bt8toNV+hjvs=;
  b=F3qENLr6cXvYE11s6AiXLV0QGNLZcrKBtliXQSV0+h1pwC3xD67zsY74
   sPyOcU8JixXgIarTm2U7Cxv7ooz9kdlvF34If++plcWAbvtXYmJQAjXyW
   jrR1fKztXKKlyBBCM3pbqKIZAggHjnPYT7YgwNJINjq/0+6XamAzVWGaj
   yxz5U0YNs57pHgtmORyzVHfyg+HqM+YmehfOQhmQeNppLb1l4ryit64VN
   fcWSr/HIcDSnhE61khZRnNinMX6UIKavl+TMQ73vsiPRrE3fs4+8DrYkM
   3QGjxA1FXe7gRsh17rqi3oPIRqGalPjK2G77XcxJh5DtDmTXnqgLpszQt
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,217,1650902400"; 
   d="scan'208";a="204716695"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 24 Jun 2022 08:24:18 +0800
IronPort-SDR: p+MSOTgo4XVYZfcsBz00T1roFLyAdlF54RIWSMaN4PVF1Mof8dUliVQvdZKD3Xndtm1Y7Vwa/r
 SEktNcLsPgJ37xR5AwyAERR2OAJLaiLu2hBjAk/9yJaRCqJxvOfrTUURy+qhX1vArPIl6IN0m9
 jJVwJo6v1Hayk8H313P3AevO3lN3RBI2RP2ABTQ/MP3ToKFpRKHHw14MAH8bRHcX80JyE7Mhg8
 1ae+29z4pZ4jsjPsmMnEVAzLs2Hdh/SgTZOKS5numNhCi4VyEVPBXz9KTMFPQx74Ipx2JLCmVv
 Fq/ESUtTSmd+QvgvA1abtkJG
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Jun 2022 16:46:44 -0700
IronPort-SDR: etidcaduFXgu/3lXKPx/uDtFNkjGMd5NU2jSng7q5TkcOCjv9/MwaWZdr4o0zxFIgqKlp0QrBx
 yy5AWM8dRquFc6ARStmO7MfJ+Fh5PiD4KH+8sQuACwJ2FjkAgRvCbIzsIyfVl6nVS0ybnKtDbF
 +ECOtNDHdcbRKIgVjG+On+GW9Kr93Mo0Yrl3UqMx+0ddQdtSV2GSQAKQyfTjQLTT92urrG4xxR
 DM2MPgUwrkxARREkopoY0BgLjy+e5AJZ2Vy0Xu1Z6gd1FhUTW9AWEvXjC3fMF4OQKf4lksc597
 HoA=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Jun 2022 17:24:17 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LTdCj28bRz1Rwnx
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 17:24:17 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1656030256; x=1658622257; bh=rE5wHaFYlcKTzoSgEhSHrpfc4G4Shz8Bt8t
        oNV+hjvs=; b=Z/qrglR+QLhWwH0AhO2izPNHtmOx6tTOUTlJ7TpXArEGQ47ANFn
        U3QautvsfLtzctqoTSGRw3LA9w7nE8wZLDMHHIWd90E7rtQvrgfv5RgFm9RRFACf
        2Gbm+q4pRuJpzrcGCdSZ97omhJLuIquqendD5jKjbL9uBe+Nr9+lYWpGicvW9mIC
        Ux2SIj2U9lhZITHDif/2JwXJeSQkHKS5gb4qQ8qE0ZxRndkMAXwZucWe4dykNP5x
        mHVeDa5Iei62fxYuv4B0WqjjCpy9WL8DQdzApsUDkWJamgpTK5vYTRF4SEoTzOuu
        /FYg0l7ttm5lCYggPvnZPNstM8pTA6BPozw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id I3mQub28cX1w for <linux-block@vger.kernel.org>;
        Thu, 23 Jun 2022 17:24:16 -0700 (PDT)
Received: from [10.225.163.93] (unknown [10.225.163.93])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LTdCg4Hdlz1RtVk;
        Thu, 23 Jun 2022 17:24:15 -0700 (PDT)
Message-ID: <67ca0af9-a128-5d35-8c10-163459935bf1@opensource.wdc.com>
Date:   Fri, 24 Jun 2022 09:24:14 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 4/6] block/mq-deadline: Only use zone locking if
 necessary
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <20220623232603.3751912-1-bvanassche@acm.org>
 <20220623232603.3751912-5-bvanassche@acm.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220623232603.3751912-5-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/24/22 08:26, Bart Van Assche wrote:
> Measurements have shown that limiting the queue depth to one for zoned
> writes has a significant negative performance impact on zoned UFS devices.
> Hence this patch that disables zone locking from the mq-deadline scheduler
> for storage controllers that support pipelining zoned writes. This patch is
> based on the following assumptions:
> - Applications submit write requests to sequential write required zones
>   in order.
> - The I/O priority of all pipelined write requests is the same per zone.
> - If such write requests get reordered by the software or hardware queue
>   mechanism, nr_hw_queues * nr_requests - 1 retries are sufficient to
>   reorder the write requests.
> - It happens infrequently that zoned write requests are reordered by the
>   block layer.
> - Either no I/O scheduler is used or an I/O scheduler is used that
>   submits write requests per zone in LBA order.
> 
> See also commit 5700f69178e9 ("mq-deadline: Introduce zone locking
> support").

I think this patch should be squashed together with the previous patch. It
would then be easier to see what effect the pipeline queue flag has.

> 
> Cc: Damien Le Moal <damien.lemoal@wdc.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  block/blk-zoned.c   |  3 ++-
>  block/mq-deadline.c | 15 +++++++++------
>  2 files changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/block/blk-zoned.c b/block/blk-zoned.c
> index cafcbc508dfb..88a0610ba0c3 100644
> --- a/block/blk-zoned.c
> +++ b/block/blk-zoned.c
> @@ -513,7 +513,8 @@ static int blk_revalidate_zone_cb(struct blk_zone *zone, unsigned int idx,
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
> index 1a9e835e816c..8ab9694c8f3a 100644
> --- a/block/mq-deadline.c
> +++ b/block/mq-deadline.c
> @@ -292,7 +292,7 @@ deadline_fifo_request(struct deadline_data *dd, struct dd_per_prio *per_prio,
>  		return NULL;
>  
>  	rq = rq_entry_fifo(per_prio->fifo_list[data_dir].next);
> -	if (data_dir == DD_READ || !blk_queue_is_zoned(rq->q))
> +	if (data_dir == DD_READ || blk_queue_pipeline_zoned_writes(rq->q))

This change seems wrong. Before: both read and writes can proceed for
regular disks. After, only read can proceed, assuming that the regular
device does not have pipeline zoned writes enabled.

>  		return rq;
>  
>  	/*
> @@ -326,7 +326,7 @@ deadline_next_request(struct deadline_data *dd, struct dd_per_prio *per_prio,
>  	if (!rq)
>  		return NULL;
>  
> -	if (data_dir == DD_READ || !blk_queue_is_zoned(rq->q))
> +	if (data_dir == DD_READ || blk_queue_pipeline_zoned_writes(rq->q))

same here.

>  		return rq;
>  
>  	/*
> @@ -445,8 +445,9 @@ static struct request *__dd_dispatch_request(struct deadline_data *dd,
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
> @@ -719,6 +720,8 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
>  	u8 ioprio_class = IOPRIO_PRIO_CLASS(ioprio);
>  	struct dd_per_prio *per_prio;
>  	enum dd_prio prio;
> +	bool pipelined_seq_write = blk_queue_pipeline_zoned_writes(q) &&
> +		blk_rq_is_zoned_seq_write(rq);
>  	LIST_HEAD(free);
>  
>  	lockdep_assert_held(&dd->lock);
> @@ -743,7 +746,7 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
>  
>  	trace_block_rq_insert(rq);
>  
> -	if (at_head) {
> +	if (at_head && !pipelined_seq_write) {
>  		list_add(&rq->queuelist, &per_prio->dispatch);
>  		rq->fifo_time = jiffies;
>  	} else {
> @@ -823,7 +826,7 @@ static void dd_finish_request(struct request *rq)
>  
>  	atomic_inc(&per_prio->stats.completed);
>  
> -	if (blk_queue_is_zoned(q)) {
> +	if (!blk_queue_pipeline_zoned_writes(q)) {
>  		unsigned long flags;
>  
>  		spin_lock_irqsave(&dd->zone_lock, flags);


-- 
Damien Le Moal
Western Digital Research
