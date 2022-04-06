Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47403C4167B
	for <linux-block@archiver.kernel.org>; Wed,  6 Apr 2022 13:01:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231430AbiDFNDV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 Apr 2022 09:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232191AbiDFNCt (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Apr 2022 09:02:49 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 767585C3BED
        for <linux-block@vger.kernel.org>; Wed,  6 Apr 2022 02:28:46 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id b15so1885460edn.4
        for <linux-block@vger.kernel.org>; Wed, 06 Apr 2022 02:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:cc:from:in-reply-to:content-transfer-encoding;
        bh=m1koXNA33sdipTnmVFkmxpoeuENHnq+R7+Gd6wT13Zo=;
        b=NWouHQeNt4hQw32T8acQKzks+zM2N79/IkpDLXvK48lcAMKi+8Uy4PSYq+LYlKjD5Z
         NsIl4d+J1s05iIQwFnJp+eiWDEwHMvkNCpjs3BavtawrSq2abR72PTzoQLMVc9M4xVc4
         4Qi5I0l03lv3oirP+TCgrt8qkq6A0mjxzjVnxN0oX/4i/88C1igbJLTAlUHSxzbBMGI4
         Ie3hOyipeeenDoKUKdVsNrQ1UgXQeLtf87cLImm/Q7jZSEU+Sx5jPcLWH39I2QvORLXZ
         l7lVeq0tWqFpA6gDf45ln60rWi+tEHF4MFzkGmRVBGPyC/vwCw/GYxpJozuQ07I0xmJl
         eRrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:cc:from:in-reply-to
         :content-transfer-encoding;
        bh=m1koXNA33sdipTnmVFkmxpoeuENHnq+R7+Gd6wT13Zo=;
        b=cKv5nDUUjSwuGbvehBFs6bkUzlMLkKobgfzr+lHHfWuEptznb1L8QHhbMljDzd6hpe
         /0tceOTJ2hsapzvqsN7yBw6xQ59FVMJ9gUgGlPDCpf4YCA6/tDc8psl71QyjJ6g/9aS9
         620LPn3ITvz8Kbs5wy9qu/luGh30M/bf02mJPgPohqQ6djK6ljoz1b9aX3lT8Klc2jFv
         gUIMi24WdP1sjAyT1a8rpQPVlaLcIFccmroZ8MQj0qIPTQkiYT+HuX+jgOH58EYPPByI
         WHWq+SXkisKlXvuVw0L6ekznlrx5T0fYONfLJzgZ42qcBOJskZYaE+3HSKgkAGGOsoLd
         boFw==
X-Gm-Message-State: AOAM531Fwynl4fVZpDbgv+Qv6ubI3oASaydlHXYvNPfb4yz3bNvKPk6q
        Z5uq3fE5dZJP0JrmFzSLYmv1Yg==
X-Google-Smtp-Source: ABdhPJycY6Pftsk/QIJx8bKRTDQgJDs5fHB5Msx8yJlO/fWgITQKdsCJxZdv6ZCASK+pR5TLjzx96A==
X-Received: by 2002:aa7:cb93:0:b0:415:d57a:4603 with SMTP id r19-20020aa7cb93000000b00415d57a4603mr7743711edt.62.1649237318739;
        Wed, 06 Apr 2022 02:28:38 -0700 (PDT)
Received: from [192.168.178.55] (85-127-190-169.dsl.dynamic.surfer.at. [85.127.190.169])
        by smtp.gmail.com with ESMTPSA id v20-20020a056402349400b00419651e513asm7822259edc.45.2022.04.06.02.28.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Apr 2022 02:28:38 -0700 (PDT)
Message-ID: <57862355-5c67-804d-0e4f-7c10ad5d411d@linbit.com>
Date:   Wed, 6 Apr 2022 11:28:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [Drbd-dev] [PATCH 06/27] drbd: cleanup decide_on_discard_support
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
References: <20220406060516.409838-1-hch@lst.de>
 <20220406060516.409838-7-hch@lst.de>
Cc:     drbd-dev@lists.linbit.com, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
From:   =?UTF-8?Q?Christoph_B=c3=b6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
In-Reply-To: <20220406060516.409838-7-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Am 06.04.22 um 08:04 schrieb Christoph Hellwig:
> Sanitize the calling conventions and use a goto label to cleanup the
> code flow.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/block/drbd/drbd_nl.c | 68 +++++++++++++++++++-----------------
>  1 file changed, 35 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
> index 02030c9c4d3b1..40bb0b356a6d6 100644
> --- a/drivers/block/drbd/drbd_nl.c
> +++ b/drivers/block/drbd/drbd_nl.c
> @@ -1204,38 +1204,42 @@ static unsigned int drbd_max_discard_sectors(struct drbd_connection *connection)
>  }
>  
>  static void decide_on_discard_support(struct drbd_device *device,
> -			struct request_queue *q,
> -			struct request_queue *b,
> -			bool discard_zeroes_if_aligned)
> +		struct drbd_backing_dev *bdev)
>  {
> -	/* q = drbd device queue (device->rq_queue)
> -	 * b = backing device queue (device->ldev->backing_bdev->bd_disk->queue),
> -	 *     or NULL if diskless
> -	 */
> -	struct drbd_connection *connection = first_peer_device(device)->connection;
> -	bool can_do = b ? blk_queue_discard(b) : true;
> -
> -	if (can_do && connection->cstate >= C_CONNECTED && !(connection->agreed_features & DRBD_FF_TRIM)) {
> -		can_do = false;
> -		drbd_info(connection, "peer DRBD too old, does not support TRIM: disabling discards\n");
> -	}
> -	if (can_do) {
> -		/* We don't care for the granularity, really.
> -		 * Stacking limits below should fix it for the local
> -		 * device.  Whether or not it is a suitable granularity
> -		 * on the remote device is not our problem, really. If
> -		 * you care, you need to use devices with similar
> -		 * topology on all peers. */
> -		blk_queue_discard_granularity(q, 512);
> -		q->limits.max_discard_sectors = drbd_max_discard_sectors(connection);
> -		blk_queue_flag_set(QUEUE_FLAG_DISCARD, q);
> -		q->limits.max_write_zeroes_sectors = drbd_max_discard_sectors(connection);
> -	} else {
> -		blk_queue_flag_clear(QUEUE_FLAG_DISCARD, q);
> -		blk_queue_discard_granularity(q, 0);
> -		q->limits.max_discard_sectors = 0;
> -		q->limits.max_write_zeroes_sectors = 0;
> +	struct drbd_connection *connection =
> +		first_peer_device(device)->connection;
> +	struct request_queue *q = device->rq_queue;
> +
> +	if (bdev && !blk_queue_discard(bdev->backing_bdev->bd_disk->queue))
> +		goto not_supported;
> +
> +	if (connection->cstate >= C_CONNECTED &&
> +	    !(connection->agreed_features & DRBD_FF_TRIM)) {
> +		drbd_info(connection,
> +			"peer DRBD too old, does not support TRIM: disabling discards\n");
> +		goto not_supported;
>  	}
> +
> +	/*
> +	 * We don't care for the granularity, really.
> +	 *
> +	 * Stacking limits below should fix it for the local device.  Whether or
> +	 * not it is a suitable granularity on the remote device is not our
> +	 * problem, really. If you care, you need to use devices with similar
> +	 * topology on all peers.
> +	 */
> +	blk_queue_discard_granularity(q, 512);
> +	q->limits.max_discard_sectors = drbd_max_discard_sectors(connection);
> +	blk_queue_flag_set(QUEUE_FLAG_DISCARD, q);
> +	q->limits.max_write_zeroes_sectors =
> +		drbd_max_discard_sectors(connection);
> +	return;
> +
> +not_supported:
> +	blk_queue_flag_clear(QUEUE_FLAG_DISCARD, q);
> +	blk_queue_discard_granularity(q, 0);
> +	q->limits.max_discard_sectors = 0;
> +	q->limits.max_write_zeroes_sectors = 0;
>  }
>  
>  static void fixup_discard_if_not_supported(struct request_queue *q)
> @@ -1273,7 +1277,6 @@ static void drbd_setup_queue_param(struct drbd_device *device, struct drbd_backi
>  	unsigned int max_segments = 0;
>  	struct request_queue *b = NULL;
>  	struct disk_conf *dc;
> -	bool discard_zeroes_if_aligned = true;
>  
>  	if (bdev) {
>  		b = bdev->backing_bdev->bd_disk->queue;
> @@ -1282,7 +1285,6 @@ static void drbd_setup_queue_param(struct drbd_device *device, struct drbd_backi
>  		rcu_read_lock();
>  		dc = rcu_dereference(device->ldev->disk_conf);
>  		max_segments = dc->max_bio_bvecs;
> -		discard_zeroes_if_aligned = dc->discard_zeroes_if_aligned;
>  		rcu_read_unlock();
>  
>  		blk_set_stacking_limits(&q->limits);
> @@ -1292,7 +1294,7 @@ static void drbd_setup_queue_param(struct drbd_device *device, struct drbd_backi
>  	/* This is the workaround for "bio would need to, but cannot, be split" */
>  	blk_queue_max_segments(q, max_segments ? max_segments : BLK_MAX_SEGMENTS);
>  	blk_queue_segment_boundary(q, PAGE_SIZE-1);
> -	decide_on_discard_support(device, q, b, discard_zeroes_if_aligned);
> +	decide_on_discard_support(device, bdev);
>  
>  	if (b) {
>  		blk_stack_limits(&q->limits, &b->limits, 0);

Acked-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
