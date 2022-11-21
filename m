Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12C33C4332F
	for <linux-block@archiver.kernel.org>; Mon, 21 Nov 2022 14:30:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbiKUOaw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Nov 2022 09:30:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbiKUOat (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Nov 2022 09:30:49 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FD23AB0C0
        for <linux-block@vger.kernel.org>; Mon, 21 Nov 2022 06:30:47 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id y10so9547559plp.3
        for <linux-block@vger.kernel.org>; Mon, 21 Nov 2022 06:30:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fKdPBgf4F1DbPho+543ze8p/JJM5iKRRHyH33ew0++Y=;
        b=jrZpJYDRNZTvL91G/bFgw/1STzMW33rYKTqBLYy3vYffZlw43RahxhV6wxQRpWZIxX
         x6HipJ6s1wVjbg2BH9m2MwYh8gKj0JTDaxUmGi1o5nakjAaUciEROc15usDK0vKqyhOl
         9L7usg5AghzAPNpNNYrHDerJTUfeA1BB08UKuRUzfDCVZWX65+0/8j9Y54d4vjEVy8vJ
         921jD7JwFe6auLnSeXFhtVGp8RvIuE0XdQmcpeaEyKdtvhjB40A7Ef/vjR69OgPMAtrt
         HqjR+34LdHESiPMp+x6DE+vgGi2UGolxpohdnwzGLJ6mkV/cPANuyPR+RgqjiZKvK7Ll
         MXmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fKdPBgf4F1DbPho+543ze8p/JJM5iKRRHyH33ew0++Y=;
        b=DyiqrSRPQzLWFL9PrIcBSpAO6RXZsdYDktcdYrXKGJXUmvbifhIA/Av3DkNgQk4xPI
         sXpDAZ1sE4BcWrFnSUYZY4PvqTuFiiL6HQn7+7XWmJi9NNfRnQ39Tg8sTrpB4AjghAsI
         wM1pg0e5a38/VjaC3m9Junqo2yKunwsy4YZCtpbcEcbhk9cZQCyydEbNuY9o21CUsCT7
         3tfHWU6QML1Gim7o+vny+dAGOFL7OrcbnbYwYk8Umjkv0BbAlKBic/4RHwV5p7Y5dws7
         XoAN3I4RUuTK+29ACxHoOTQMtSBtPqORHR8rj1ySRO2vnvS0zkluTGXeF5S3T19TSOS8
         hZxQ==
X-Gm-Message-State: ANoB5pnqbMjIsV/lGRcSFl9ukhWhT5tdNjPCe/k3oI/UFYTGXWURC/oD
        zbHJ8DEW3ebR+Mqy22aoxO7xQg==
X-Google-Smtp-Source: AA0mqf6/+g7r5XsHDkk4PBUMLfIhfGYA2phFatP0/v3K1w6nUxS3oOR1xEvbfvt5d9rob8XbgwhAWw==
X-Received: by 2002:a17:90a:8c96:b0:218:7e9d:8d0a with SMTP id b22-20020a17090a8c9600b002187e9d8d0amr17088134pjo.41.1669041046463;
        Mon, 21 Nov 2022 06:30:46 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id z2-20020a626502000000b0057255b7c8easm8776251pfb.33.2022.11.21.06.30.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 06:30:46 -0800 (PST)
Message-ID: <c0e639ea-caa0-f76c-c369-0d22a49047ca@kernel.dk>
Date:   Mon, 21 Nov 2022 07:30:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [RESEND PATCH] drbd: destroy workqueue when drbd device was freed
Content-Language: en-US
To:     Wang ShaoBo <bobo.shaobowang@huawei.com>
Cc:     liwei391@huawei.com, linux-block@vger.kernel.org,
        drbd-dev@lists.linbit.com, christoph.boehmwalder@linbit.com
References: <20221121115047.3828385-1-bobo.shaobowang@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20221121115047.3828385-1-bobo.shaobowang@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/21/22 4:50 AM, Wang ShaoBo wrote:
> A submitter workqueue is dynamically allocated by init_submitter()
> called by drbd_create_device(), we should destroy it when this
> device is not needed or destroyed.
> 
> Fixes: 113fef9e20e0 ("drbd: prepare to queue write requests on a submit worker")
> Signed-off-by: Wang ShaoBo <bobo.shaobowang@huawei.com>
> ---
> 
> Changes in RESEND:
>   put destroy_workqueue() before memset(device, ...)
> 
>  drivers/block/drbd/drbd_main.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
> index 8532b839a343..082bc34cd317 100644
> --- a/drivers/block/drbd/drbd_main.c
> +++ b/drivers/block/drbd/drbd_main.c
> @@ -2217,7 +2217,12 @@ void drbd_destroy_device(struct kref *kref)
>  		kref_put(&peer_device->connection->kref, drbd_destroy_connection);
>  		kfree(peer_device);
>  	}
> +
> +	if (device->submit.wq)
> +		destroy_workqueue(device->submit.wq);
> +
>  	memset(device, 0xfd, sizeof(*device));
> +
>  	kfree(device);

Maybe you can send a separate patch killing that very odd (and useless)
memset as well?

-- 
Jens Axboe


