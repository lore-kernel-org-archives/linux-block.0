Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD392C433FE
	for <linux-block@archiver.kernel.org>; Tue, 22 Nov 2022 12:02:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbiKVMCG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Nov 2022 07:02:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233230AbiKVMB4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Nov 2022 07:01:56 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFAF52F647
        for <linux-block@vger.kernel.org>; Tue, 22 Nov 2022 04:01:54 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id e11so11453969wru.8
        for <linux-block@vger.kernel.org>; Tue, 22 Nov 2022 04:01:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qb4RJR8ylDg3gto72YXsWpWWkJFXTlWFNAJNj7lhF2c=;
        b=IlZaDJz1Pp3VXP8AR9lNUegK3XlNLzsrtowBNmH/uMteoUt3vouFTIWaD3E3SC2rjv
         PJKWOE1QyHTH/Ue1stpp9ZhZUKiuGRmRg9AZntzUbbWjKzMvmz1cvAJUVshYtho7b6TN
         mI2YKvpfZzvuZm4rCS7Q+5i2gnoMke7yqLm3vJ8XOlyiLpMbSKoOzN7sgUX9qo+lJjL3
         +fwj8odyIqRSn9fAkAF+zoCZayjFLT3VNX/fp5+7jN1AuAfzy87lSW3CTTUiG0TmpZdo
         zkK8nAAsvEui9nCbBNU6tm8eQ6FqQrJWs496XpbsvqM4eCg986k8M92YJsCTUM1qIC5g
         rXXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qb4RJR8ylDg3gto72YXsWpWWkJFXTlWFNAJNj7lhF2c=;
        b=DOsmVrupg5ujm+Kl88jCJrogwoC5yPcpblkqvy2ywnDWgjJUYQl9pfKim62Jdxa9Bj
         O8bFDKSemwmmqJlVOfs2CE6M5lBqwBF1wpdquOmmoGnLtdpWgAiMtzT/8X0jS5rPtgEm
         YIZlMoPd0iUd7o8RyXTgkhBr/KKK+5Z/upMH2WhakmOQyrzrs/WNqTSwyRi0+jv015et
         1UVlcedblyg/GPXsU7tA6m0PMBHq+bHKSzcF6stru1Pg1hGZ3oARpnP2FIrTULfjdeej
         FwuMBqBl8+7AyDBWP7vdk1t1ZSkiAXRjh43fcu6qKLQWvj/asXe+Yild8RI9wKAAtZl2
         xjlg==
X-Gm-Message-State: ANoB5plQIrwA59zeIQepyzCqLQUgIFq+0oxEDLvAlksILW81Xporqph2
        ozzlB6fimR5dj779xUEZYpfUhw==
X-Google-Smtp-Source: AA0mqf6ia2nZqMM6cTVqXCaMyp+QcMibSrdd2TYim5/9fDE0JEnPYYH3KTsM1Fat2m3lXTlVzvGtGQ==
X-Received: by 2002:a5d:430e:0:b0:241:bfb6:c6da with SMTP id h14-20020a5d430e000000b00241bfb6c6damr3253870wrq.204.1669118513405;
        Tue, 22 Nov 2022 04:01:53 -0800 (PST)
Received: from [192.168.178.55] (h082218028181.host.wavenet.at. [82.218.28.181])
        by smtp.gmail.com with ESMTPSA id m2-20020a1c2602000000b003cfd58409desm20448499wmm.13.2022.11.22.04.01.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Nov 2022 04:01:52 -0800 (PST)
Message-ID: <feff21b0-e583-4df3-7c38-4990ee60c3e4@linbit.com>
Date:   Tue, 22 Nov 2022 13:01:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v2 2/2] drbd: destroy workqueue when drbd device was freed
To:     Wang ShaoBo <bobo.shaobowang@huawei.com>
Cc:     liwei391@huawei.com, linux-block@vger.kernel.org,
        drbd-dev@lists.linbit.com, axboe@kernel.dk,
        lars.ellenberg@linbit.com
References: <20221122030427.731308-1-bobo.shaobowang@huawei.com>
 <20221122030427.731308-3-bobo.shaobowang@huawei.com>
Content-Language: en-US
From:   =?UTF-8?Q?Christoph_B=c3=b6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
In-Reply-To: <20221122030427.731308-3-bobo.shaobowang@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Am 22.11.22 um 04:04 schrieb Wang ShaoBo:
> A submitter workqueue is dynamically allocated by init_submitter()
> called by drbd_create_device(), we should destroy it when this
> device is not needed or destroyed.
> 
> Fixes: 113fef9e20e0 ("drbd: prepare to queue write requests on a submit worker")
> Signed-off-by: Wang ShaoBo <bobo.shaobowang@huawei.com>
> ---
>  drivers/block/drbd/drbd_main.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
> index 78cae4e75af1..2d6b6d1c5ff4 100644
> --- a/drivers/block/drbd/drbd_main.c
> +++ b/drivers/block/drbd/drbd_main.c
> @@ -2217,6 +2217,8 @@ void drbd_destroy_device(struct kref *kref)
>  		kref_put(&peer_device->connection->kref, drbd_destroy_connection);
>  		kfree(peer_device);
>  	}
> +	if (device->submit.wq)
> +		destroy_workqueue(device->submit.wq);
>  	kfree(device);
>  	kref_put(&resource->kref, drbd_destroy_resource);
>  }
> @@ -2807,6 +2809,8 @@ enum drbd_ret_code drbd_create_device(struct drbd_config_context *adm_ctx, unsig
>  	put_disk(disk);
>  out_no_disk:
>  	kref_put(&resource->kref, drbd_destroy_resource);
> +	if (device->submit.wq)
> +		destroy_workqueue(device->submit.wq);
>  	kfree(device);
>  	return err;
>  }

Thanks, that is better.

Just one more nitpick: in drbd_create_device, we usually order the
allocations/frees in a "last in, first out" fashion. That is, data
should be released in the reverse order that it was allocated. This also
helps with error handling, which is what the out_* labels are used for.

So maybe we can put that destroy_workqueue() under its own out_* label
and make sure it gets freed first in the cleanup section (since it gets
allocated last).

-- 
Christoph Böhmwalder
LINBIT | Keeping the Digital World Running
DRBD HA —  Disaster Recovery — Software defined Storage
