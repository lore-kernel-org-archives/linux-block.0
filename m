Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A03EDC433E0
	for <linux-block@archiver.kernel.org>; Tue, 26 Jan 2021 05:33:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DD21229C4
	for <linux-block@archiver.kernel.org>; Tue, 26 Jan 2021 05:33:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731533AbhAZFdm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Jan 2021 00:33:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727472AbhAZBcX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Jan 2021 20:32:23 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CA51C061226
        for <linux-block@vger.kernel.org>; Mon, 25 Jan 2021 16:52:15 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id j21so4122460pls.7
        for <linux-block@vger.kernel.org>; Mon, 25 Jan 2021 16:52:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=D3jPNTYhrIxrX4H/Bz2CWIz5jRxLbk7blKyKqQ1JDpo=;
        b=LKcUVdvEzOmxeYA3vu7HPUTya6UHwtIgF3ymsagxdFZmQeaDU+yuxvOp72YzfbSWLf
         YVimj9mREiq+GO8RVAMrgGn00N6l4x86MLdnBMfRC8TI/5VISkU02XF+NOh6uvcdqqAJ
         7vVhecU05cWTqxjVRfwZCYJvybHmEAu9RGNiso4G7vKNHZ0fi8DJgGxgdqD9w3f7kNxY
         7vGI8KMv8vlPDj/5s091d/Te9CBP8UWGZNVSrui13kCnSysNn4nSWZS0ZOl+kAe1Lnc1
         zK146/hZpwDsZZcNsOYzof1oyCgLXBFYotdgVd/3kpqz7DFW1B20gVOLIogzs9IydycV
         9V1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=D3jPNTYhrIxrX4H/Bz2CWIz5jRxLbk7blKyKqQ1JDpo=;
        b=cU6iNhj+SsRhU196pUW+fDieX4G8PNDqIr3Eu3vkLlP4JU6lIjYXUrZjJpWFtCpq2r
         FwrlTN3gYg+JWCbDj3eDtkqxQhhSXp/MP3XdIUngXx1ebWZIZSlDQ0yMfCs8Qv8zJq09
         qFqpDK0kGSTgXUhbu4z0/AYOmWoH4ofh15TQ7oQ7MsE+bn70tfV3amqlqbHiWHjKLkuj
         vq4enWi/NlEQmB+2/9mMyITfa4AzGtHKLFrPC6ZgvHlqwcVSJOzY2NvjQRaSUTx2LJx0
         xj9FHEJ9UYuP4bNoIQxfvgWxRmxaFMCnw9GELijE8+KApbRQtpTAswSO7Cq1PW9tlQ29
         Zqnw==
X-Gm-Message-State: AOAM531U3NzYvl69kkYGP2GNbG6uT1aTThC6MLuRKpqDMLHrOOGbjd+m
        44Pn1V3hPPhPa9iZNNI/8vy19g==
X-Google-Smtp-Source: ABdhPJzJAJXcVAwbnQsX7li30Ext+hUqlTUC4FsKKHPtCu6xVYdkIktiqvbNpqLznTw0AWEy317+iQ==
X-Received: by 2002:a17:902:d70f:b029:de:b33a:891a with SMTP id w15-20020a170902d70fb02900deb33a891amr3098526ply.70.1611622333769;
        Mon, 25 Jan 2021 16:52:13 -0800 (PST)
Received: from [10.8.1.5] ([185.125.207.232])
        by smtp.gmail.com with ESMTPSA id v2sm16948930pgs.50.2021.01.25.16.52.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Jan 2021 16:52:13 -0800 (PST)
Subject: Re: [PATCH RESEND] drbd: remove unused argument from
 drbd_request_prepare and __drbd_make_request
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        drbd-dev@lists.linbit.com
References: <20210121142150.12998-1-guoqing.jiang@cloud.ionos.com>
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <11599fea-e0e8-f6c8-5931-0c37491ee6d7@cloud.ionos.com>
Date:   Tue, 26 Jan 2021 01:52:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210121142150.12998-1-guoqing.jiang@cloud.ionos.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Ping

On 1/21/21 15:21, Guoqing Jiang wrote:
> We can remove start_jif since it is not used by drbd_request_prepare,
> then remove it from __drbd_make_request further.
> 
> Cc: Philipp Reisner <philipp.reisner@linbit.com>
> Cc: Lars Ellenberg <lars.ellenberg@linbit.com>
> Cc: drbd-dev@lists.linbit.com
> Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
> ---
>   drivers/block/drbd/drbd_int.h  |  2 +-
>   drivers/block/drbd/drbd_main.c |  3 +--
>   drivers/block/drbd/drbd_req.c  | 11 ++++-------
>   3 files changed, 6 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
> index 8f879e5c2f67..8faa31a17b8f 100644
> --- a/drivers/block/drbd/drbd_int.h
> +++ b/drivers/block/drbd/drbd_int.h
> @@ -1449,7 +1449,7 @@ extern void conn_free_crypto(struct drbd_connection *connection);
>   
>   /* drbd_req */
>   extern void do_submit(struct work_struct *ws);
> -extern void __drbd_make_request(struct drbd_device *, struct bio *, unsigned long);
> +extern void __drbd_make_request(struct drbd_device *, struct bio *);
>   extern blk_qc_t drbd_submit_bio(struct bio *bio);
>   extern int drbd_read_remote(struct drbd_device *device, struct drbd_request *req);
>   extern int is_valid_ar_handle(struct drbd_request *, sector_t);
> diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
> index 1c8c18b2a25f..7e5fcce812e1 100644
> --- a/drivers/block/drbd/drbd_main.c
> +++ b/drivers/block/drbd/drbd_main.c
> @@ -2288,7 +2288,6 @@ static void do_retry(struct work_struct *ws)
>   	list_for_each_entry_safe(req, tmp, &writes, tl_requests) {
>   		struct drbd_device *device = req->device;
>   		struct bio *bio = req->master_bio;
> -		unsigned long start_jif = req->start_jif;
>   		bool expected;
>   
>   		expected =
> @@ -2323,7 +2322,7 @@ static void do_retry(struct work_struct *ws)
>   		/* We are not just doing submit_bio_noacct(),
>   		 * as we want to keep the start_time information. */
>   		inc_ap_bio(device);
> -		__drbd_make_request(device, bio, start_jif);
> +		__drbd_make_request(device, bio);
>   	}
>   }
>   
> diff --git a/drivers/block/drbd/drbd_req.c b/drivers/block/drbd/drbd_req.c
> index 330f851cb8f0..5e5602af9643 100644
> --- a/drivers/block/drbd/drbd_req.c
> +++ b/drivers/block/drbd/drbd_req.c
> @@ -1188,7 +1188,7 @@ static void drbd_queue_write(struct drbd_device *device, struct drbd_request *re
>    * Returns ERR_PTR(-ENOMEM) if we cannot allocate a drbd_request.
>    */
>   static struct drbd_request *
> -drbd_request_prepare(struct drbd_device *device, struct bio *bio, unsigned long start_jif)
> +drbd_request_prepare(struct drbd_device *device, struct bio *bio)
>   {
>   	const int rw = bio_data_dir(bio);
>   	struct drbd_request *req;
> @@ -1416,9 +1416,9 @@ static void drbd_send_and_submit(struct drbd_device *device, struct drbd_request
>   		complete_master_bio(device, &m);
>   }
>   
> -void __drbd_make_request(struct drbd_device *device, struct bio *bio, unsigned long start_jif)
> +void __drbd_make_request(struct drbd_device *device, struct bio *bio)
>   {
> -	struct drbd_request *req = drbd_request_prepare(device, bio, start_jif);
> +	struct drbd_request *req = drbd_request_prepare(device, bio);
>   	if (IS_ERR_OR_NULL(req))
>   		return;
>   	drbd_send_and_submit(device, req);
> @@ -1596,19 +1596,16 @@ void do_submit(struct work_struct *ws)
>   blk_qc_t drbd_submit_bio(struct bio *bio)
>   {
>   	struct drbd_device *device = bio->bi_disk->private_data;
> -	unsigned long start_jif;
>   
>   	blk_queue_split(&bio);
>   
> -	start_jif = jiffies;
> -
>   	/*
>   	 * what we "blindly" assume:
>   	 */
>   	D_ASSERT(device, IS_ALIGNED(bio->bi_iter.bi_size, 512));
>   
>   	inc_ap_bio(device);
> -	__drbd_make_request(device, bio, start_jif);
> +	__drbd_make_request(device, bio);
>   	return BLK_QC_T_NONE;
>   }
>   
> 
