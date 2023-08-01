Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9A19C04E69
	for <linux-block@archiver.kernel.org>; Tue,  1 Aug 2023 00:28:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229379AbjHAA2H (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 31 Jul 2023 20:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231450AbjHAA2B (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 31 Jul 2023 20:28:01 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCE521716
        for <linux-block@vger.kernel.org>; Mon, 31 Jul 2023 17:27:59 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1bba9539a23so6744905ad.1
        for <linux-block@vger.kernel.org>; Mon, 31 Jul 2023 17:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1690849679; x=1691454479;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NF/EZl9ssiFsilyYni0qa8S7le0pWtfJhEYQNYvUAjE=;
        b=PrAT7ua2gCGDJhhlzzFedFjOQ1rgS5iQPOz6SH/WQxrs18n2SgKhu8IFVp3TOh99A/
         wZD4PLISKHdZRXzRStEC4NAW38Lao4WhpC7U4Ox4YMfcugKDAv21KjtBqFf2u3j56g0l
         FBqZkDxqxH10HNmR5p8NnvuBabifIvb27GuzKe+8XoWi1MuQ5mtqWtRU061YHulMjOUt
         NzF6StfZ27iqeVy+6V4vlbFHJlqEhdMk4QJUtswPuAVwCC6b9/01XFUYtJgQbC/KyhYf
         yBzgyvvaaGh+6xGTi8CgUomxzR6wMgV35diqln94FsRlMN95Mem5RCjpqJZPgLnVU/sh
         mVUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690849679; x=1691454479;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NF/EZl9ssiFsilyYni0qa8S7le0pWtfJhEYQNYvUAjE=;
        b=Z719q14K3WiT+gj8JfViAw/egZuJjpfr0BGrRIDa9KcoRwjaDoRVqPKrr/uByjPmQX
         fvQjtBlDSdGq92JaNdU391FrgU/7G8vpH21i44wFLpOkm8G4nuN9hraAB698MrF2C2ot
         pksS9569CqxMeU7tIXURuhGWbeZsMfMafdCwLRJlJnmJJ60NajsVXJnVDfzDhfHREE29
         I1YN/k1f+R1kq8PtFhuLGCenDKTSs+gXYS++xUznG/4Cd9qTl01V81KlpCjwpDvKTS3h
         Z0sHddFN1nX7eqmBKA+TsaXSdkTz+8OChe8tGgFMKnnHG7smqRtPkUXmjKrPNf9DRwLp
         TxSQ==
X-Gm-Message-State: ABy/qLZ9ejzcQZ3w4MviE0yj1zLqce7bRmH76+pIN8BF1+Ggqpf1MNzh
        l1e9KWPwy7X31RJyqDzYe0CVgQ==
X-Google-Smtp-Source: APBJJlH2P/5iANAMJoJKWLbhhq7n9F8dLn8jScovcsOH2t8Kn7FLvtHkglJN8cWwsKNDVrbHuwcEOw==
X-Received: by 2002:a17:902:db0f:b0:1b8:b0c4:2e3d with SMTP id m15-20020a170902db0f00b001b8b0c42e3dmr10066614plx.4.1690849679397;
        Mon, 31 Jul 2023 17:27:59 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id iw14-20020a170903044e00b001bb54abfc07sm9083987plb.252.2023.07.31.17.27.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jul 2023 17:27:58 -0700 (PDT)
Message-ID: <1b67a9dd-c28a-661a-3a46-dab509d4c34e@kernel.dk>
Date:   Mon, 31 Jul 2023 18:27:57 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH -next] nbd: get config_lock before sock_shutdown
Content-Language: en-US
To:     Zhong Jinghua <zhongjinghua@huaweicloud.com>, josef@toxicpanda.com
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yukuai3@huawei.com
References: <20230707062256.1271948-1-zhongjinghua@huaweicloud.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230707062256.1271948-1-zhongjinghua@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/7/23 12:22?AM, Zhong Jinghua wrote:
> Config->socks in sock_shutdown may trigger a UAF problem.
> The reason is that sock_shutdown does not hold the config_lock,
> so that nbd_ioctl can release config->socks at this time.
> 
> T0: NBD_SET_SOCK
> T1: NBD_DO_IT
> 
> T0						T1
> 
> nbd_ioctl
>   mutex_lock(&nbd->config_lock)
>   // get lock
>   __nbd_ioctl
>     nbd_start_device_ioctl
>       nbd_start_device
>        mutex_unlock(&nbd->config_lock)
>          // relase lock
>          wait_event_interruptible
>          (kill, enter sock_shutdown)
>          sock_shutdown
> 					nbd_ioctl
> 					  mutex_lock(&nbd->config_lock)
> 					  // get lock
> 					  __nbd_ioctl
> 					    nbd_add_socket
> 					      krealloc
> 						kfree(p)
> 					        //config->socks is NULL
>            nbd_sock *nsock = config->socks // error
> 
> Fix it by moving config_lock up before sock_shutdown.
> 
> Signed-off-by: Zhong Jinghua <zhongjinghua@huaweicloud.com>
> ---
>  drivers/block/nbd.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> index c410cf29fb0c..accbe99ebb7e 100644
> --- a/drivers/block/nbd.c
> +++ b/drivers/block/nbd.c
> @@ -1428,13 +1428,18 @@ static int nbd_start_device_ioctl(struct nbd_device *nbd)
>  	mutex_unlock(&nbd->config_lock);
>  	ret = wait_event_interruptible(config->recv_wq,
>  					 atomic_read(&config->recv_threads) == 0);
> +
> +	/*
> +	 * recv_work in flush_workqueue will not get this lock, because nbd_open
> +	 * will hold nbd->config_refs
> +	 */
> +	mutex_lock(&nbd->config_lock);
>  	if (ret) {
>  		sock_shutdown(nbd);
>  		nbd_clear_que(nbd);
>  	}
>  
>  	flush_workqueue(nbd->recv_workq);
> -	mutex_lock(&nbd->config_lock);

Feels pretty iffy to hold config_lock over the flush. If anything off
recv_work() ever grabs it, we'd be stuck. Your comment assumes that the
only case this will currently happen is if we drop the last ref, or at
least that's the case that'd do it even if you don't mention it
explicitly.

Maybe this is all fine, but recv_work() should have a comment matching
this one, and this comment should be more descriptive as well.

-- 
Jens Axboe

