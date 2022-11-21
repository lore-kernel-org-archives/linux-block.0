Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5419EC4332F
	for <linux-block@archiver.kernel.org>; Mon, 21 Nov 2022 11:51:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230442AbiKULvl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Nov 2022 06:51:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbiKULvj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Nov 2022 06:51:39 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6FB9286DA
        for <linux-block@vger.kernel.org>; Mon, 21 Nov 2022 03:51:37 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id kt23so27888725ejc.7
        for <linux-block@vger.kernel.org>; Mon, 21 Nov 2022 03:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q+H0cjFSbZ2NYb5IOmqZhEkYfmqZxas//5HpSyQajMM=;
        b=SHV0eCpZqjwnUaMw04SDLes0LCt6CEx/9ClffLY20Cz0aH+xHM2BjEOrdhS2651Mz/
         dRGchDq+loJGLlUACmo3bf8c3kKUM41rUBbxhQYbeZl860bwog4aSEZVR6UGssPfvl0v
         mWdrUtgHOmpj+1gEdj0ngyBPWaaZHwjgQ1xv/FMeds+Y6LxzCA1qZQNjNyoK8QHVLRRW
         kWwSUSHu1h7ANGCuLrLTAKgHITw4guqVjcLEmyrsAS8gJVWRls8S8sN3j5lkWGytoDcu
         CjArIFf4ARk9xKC+N2ZOESWk0Ki4R/2RhvpY5vWYvp5LsFxjAJUU9nwIE3J7+iF3LtS2
         +8yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q+H0cjFSbZ2NYb5IOmqZhEkYfmqZxas//5HpSyQajMM=;
        b=0HMz6JDWtHOuElSfhVxvJilzCfU04Z/XfAOEALbGeDsl9LqRhgpAbQaI19DCEGSf7g
         j4Bj5+yuT9M79Vg41oPMWxAfop5RIgIeQyrHaoVjk88IJDzbIvca1evShZK4fU1Nc7nr
         OgTQNqq9bli2vg6JKi9cvPCtnwWVdRAyNEjUiDWdlTALNdyU0GNsNushNQtoylkKxlDR
         o91CCn6/FNXb0CdaJ+pDyM+6nm8Z3SdIxJdemlGqFsqTuI/TW42wKEM8pQTZGjD5KlzP
         FwdkkK0GN8eySfT9TL/rAcXH8nSc9WLEUKaIOlCmmHrI4LFDot9L3ePXZurz8ik06CAy
         dvqw==
X-Gm-Message-State: ANoB5pkAsfgEg5KDnKRDeWwbHwEDID0LeSJiPDUcY5E5CC/HLpv1nQRg
        GCzLNRkB8BJ67he/gSKi9I2i6C86TD7p5A==
X-Google-Smtp-Source: AA0mqf40LwWPAZsMgJuW1DO7GYQI5qt7733/8RiNE/Z0spkiNSRxXsspRKdks236/YaTyeBjewz2bw==
X-Received: by 2002:a17:906:3289:b0:78d:4cb3:f65d with SMTP id 9-20020a170906328900b0078d4cb3f65dmr4177725ejw.79.1669031496137;
        Mon, 21 Nov 2022 03:51:36 -0800 (PST)
Received: from [192.168.178.55] (h082218028181.host.wavenet.at. [82.218.28.181])
        by smtp.gmail.com with ESMTPSA id kw10-20020a170907770a00b0078d4ee47c82sm4914081ejc.129.2022.11.21.03.51.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 03:51:35 -0800 (PST)
Message-ID: <3603e71c-cd9d-fd27-7c52-1eed263e8717@linbit.com>
Date:   Mon, 21 Nov 2022 12:51:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH] drbd: destroy workqueue when drbd device was freed
Content-Language: en-US
To:     Wang ShaoBo <bobo.shaobowang@huawei.com>
Cc:     liwei391@huawei.com, linux-block@vger.kernel.org,
        drbd-dev@lists.linbit.com, axboe@kernel.dk
References: <20221121111138.3665586-1-bobo.shaobowang@huawei.com>
From:   =?UTF-8?Q?Christoph_B=c3=b6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
In-Reply-To: <20221121111138.3665586-1-bobo.shaobowang@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Am 21.11.22 um 12:11 schrieb Wang ShaoBo:
> A submitter workqueue is dynamically allocated by init_submitter()
> called by drbd_create_device(), we should destroy it when this
> device was not needed or destroyed.
> 
> Fixes: 113fef9e20e0 ("drbd: prepare to queue write requests on a submit worker")
> Signed-off-by: Wang ShaoBo <bobo.shaobowang@huawei.com>
> ---
>  drivers/block/drbd/drbd_main.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
> index 8532b839a343..467c498e3add 100644
> --- a/drivers/block/drbd/drbd_main.c
> +++ b/drivers/block/drbd/drbd_main.c
> @@ -2218,6 +2218,9 @@ void drbd_destroy_device(struct kref *kref)
>  		kfree(peer_device);
>  	}
>  	memset(device, 0xfd, sizeof(*device));
> +
> +	if (device->submit.wq)
> +		destroy_workqueue(device->submit.wq);
>  	kfree(device);
>  	kref_put(&resource->kref, drbd_destroy_resource);
>  }
> @@ -2810,6 +2813,8 @@ enum drbd_ret_code drbd_create_device(struct drbd_config_context *adm_ctx, unsig
>  	put_disk(disk);
>  out_no_disk:
>  	kref_put(&resource->kref, drbd_destroy_resource);
> +	if (device->submit.wq)
> +		destroy_workqueue(device->submit.wq);
>  	kfree(device);
>  	return err;
>  }

Thanks for the patch.

Unfortunately, (at least) the first hunk is buggy: we memset() the
device to all 0xfd, and try to access it immediately afterwards.

This obviously leads to invalid memory access.

-- 
Christoph Böhmwalder
LINBIT | Keeping the Digital World Running
DRBD HA —  Disaster Recovery — Software defined Storage
