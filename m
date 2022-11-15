Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22882C433FE
	for <linux-block@archiver.kernel.org>; Tue, 15 Nov 2022 14:06:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbiKOOGC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Nov 2022 09:06:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238408AbiKOOFu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Nov 2022 09:05:50 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 107A62B248
        for <linux-block@vger.kernel.org>; Tue, 15 Nov 2022 06:05:49 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id i21so22000078edj.10
        for <linux-block@vger.kernel.org>; Tue, 15 Nov 2022 06:05:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f7WFciVvNJW7kEDkH94rbryN71vzfH3OABZXCo397cs=;
        b=ROtTyEPYbFH/w4ZblcsCZ+Sxy8nc+iKOmY5mKS0BFp/MGlPuoaBsfFwY2vt7ZRLqAy
         8bVe6U94REHuHKNmJ9ckXPjlvZfQbaPfeFklKJPJjaR5188C+ZSoRbgFTe7NeP12XHx4
         X5kkYusxFJpbKrMMKsCbbRjr7C37mNwqlwMtKCxCWj7qPNYEkePyPs7q3A24rqEwXwoC
         KjAZ6C/L6K/1h5z1LU1EOy3Jy+pTV8xtSLtXFFcC0UvRFOQPzWryDdQNKi3+L3j/KLXm
         xQEXg6Kp+P99RqNWLFTgEhH3W0KV9/3kq2fhwNmQzhXotFSLKjvhv0g1vGeBFok8z5mc
         SW9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f7WFciVvNJW7kEDkH94rbryN71vzfH3OABZXCo397cs=;
        b=qbvcoAygVl+XWaSTuePHqezE2CEUVZecBJeFPVwhEkgtL4/37w2IcjWPcbS6yuGMc6
         gDMNJprAotqQFhvNTs+sbCNdidQIB5vRQNtmof0ojos1wx1SYmEcW5Zfkk4wu99ys+GU
         RrQ5UmOFdj6YACPxJxfhkSFcWWmLD202rQ06mdeZN0yrvvYrdJNkoLEWpDBwbKjU/3qq
         YFGuTffb1m/6VDRHwXF6G1mSC6CGcK8u4hexJouA6VNPNk3TCEWqnFT6wdF0islx3KkI
         52JmJFKN4GapKwOKyqEx5KqqRySLUzQPfUA8jHmlwf1evlFWlgdVoSgGLzU5q/4kI6mb
         ljaA==
X-Gm-Message-State: ANoB5plS4IPtlLy2l/i2Aj1YtdKjOLobC0aG5q6lle6DcWWkztQ4cFaI
        /jBI/WVXzzvqEoOrj+QWQysK5w==
X-Google-Smtp-Source: AA0mqf7oxrRdM64h8FAoN9EbCTeSOds03YFY2tUoVdCPVV0reOQy2CW6ku26YqTBbiFTvwmZuBSx1Q==
X-Received: by 2002:aa7:da13:0:b0:461:ed76:cb42 with SMTP id r19-20020aa7da13000000b00461ed76cb42mr15587691eds.229.1668521147538;
        Tue, 15 Nov 2022 06:05:47 -0800 (PST)
Received: from [192.168.178.55] (h082218028181.host.wavenet.at. [82.218.28.181])
        by smtp.gmail.com with ESMTPSA id cf6-20020a170906b2c600b007ad94fd48dfsm5509478ejb.139.2022.11.15.06.05.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Nov 2022 06:05:47 -0800 (PST)
Message-ID: <d0ff33bf-d39b-005c-ab62-42cae97e3b8c@linbit.com>
Date:   Tue, 15 Nov 2022 15:05:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH] drbd: use after free in drbd_create_device()
To:     Dan Carpenter <error27@gmail.com>
Cc:     Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Jens Axboe <axboe@kernel.dk>,
        Andreas Gruenbacher <agruen@linbit.com>,
        drbd-dev@lists.linbit.com, linux-block@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <Y3Jd5iZRbNQ9w6gm@kili>
Content-Language: en-US
From:   =?UTF-8?Q?Christoph_B=c3=b6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
In-Reply-To: <Y3Jd5iZRbNQ9w6gm@kili>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Am 15.11.22 um 14:16 schrieb Dan Carpenter:
> The drbd_destroy_connection() frees the "connection" so use the _safe()
> iterator to prevent a use after free.
> 
> Fixes: b6f85ef9538b ("drbd: Iterate over all connections")
> Signed-off-by: Dan Carpenter <error27@gmail.com>
> ---
> Smatch assumes that kref_put() generally calls the free function so it
> gets very confused by drbd_delete_device() which calls:
> 
> 	kref_put(&device->kref, drbd_destroy_device);
> 
> Four times in a row.  (Smatch has some checking for incremented
> reference counts but even there it assumes that people are going to hold
> one reference and not four).
> 
> drivers/block/drbd/drbd_main.c:2831 drbd_delete_device() error: dereferencing freed memory 'device'
> drivers/block/drbd/drbd_main.c:2833 drbd_delete_device() warn: passing freed memory 'device'
> drivers/block/drbd/drbd_main.c:2835 drbd_delete_device() error: dereferencing freed memory 'device'
> 
> The drbd_adm_get_status_all() function makes me itch as well.  It seems
> like we drop a reference and then take it again?
> 
> drivers/block/drbd/drbd_nl.c:4019 drbd_adm_get_status_all() warn: 'resource' was already freed.
> drivers/block/drbd/drbd_nl.c:4021 drbd_adm_get_status_all() warn: 'resource' was already freed.
> 
>  drivers/block/drbd/drbd_main.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
> index f3e4db16fd07..8532b839a343 100644
> --- a/drivers/block/drbd/drbd_main.c
> +++ b/drivers/block/drbd/drbd_main.c
> @@ -2672,7 +2672,7 @@ static int init_submitter(struct drbd_device *device)
>  enum drbd_ret_code drbd_create_device(struct drbd_config_context *adm_ctx, unsigned int minor)
>  {
>  	struct drbd_resource *resource = adm_ctx->resource;
> -	struct drbd_connection *connection;
> +	struct drbd_connection *connection, *n;
>  	struct drbd_device *device;
>  	struct drbd_peer_device *peer_device, *tmp_peer_device;
>  	struct gendisk *disk;
> @@ -2789,7 +2789,7 @@ enum drbd_ret_code drbd_create_device(struct drbd_config_context *adm_ctx, unsig
>  	return NO_ERROR;
>  
>  out_idr_remove_from_resource:
> -	for_each_connection(connection, resource) {
> +	for_each_connection_safe(connection, n, resource) {
>  		peer_device = idr_remove(&connection->peer_devices, vnr);
>  		if (peer_device)
>  			kref_put(&connection->kref, drbd_destroy_connection);

Thanks!

Reviewed-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>

-- 
Christoph Böhmwalder
LINBIT | Keeping the Digital World Running
DRBD HA —  Disaster Recovery — Software defined Storage
