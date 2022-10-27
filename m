Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C3C8FA3743
	for <linux-block@archiver.kernel.org>; Thu, 27 Oct 2022 12:12:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235475AbiJ0MMp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Oct 2022 08:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235478AbiJ0MMn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Oct 2022 08:12:43 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 173E9D18F6
        for <linux-block@vger.kernel.org>; Thu, 27 Oct 2022 05:12:42 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id e19so835653ili.4
        for <linux-block@vger.kernel.org>; Thu, 27 Oct 2022 05:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YatRoCHU/prBuQvhSuWxys1gjK3BiZzhdawxQF0M6F4=;
        b=B1N6OX1U1cX5YvB7aP1R+VTu7TtGkXtGL9wAXu12pynVNaoQnFk4SWKvkjYhQ8FuQn
         1h9qSDpGHif3jet0wA8OuvjUGNyHEw3kbolGqJ/kMWl26OhTFlX29MCqkFwI0ZlR+Wjy
         y5rOBZID8+nu/AnKslAryElPRIjSPje0CIem8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YatRoCHU/prBuQvhSuWxys1gjK3BiZzhdawxQF0M6F4=;
        b=SgwGvAkd0mobKwlZkpbnRZHy3sISaytArNMl1mgMSmxbl7CP3Vn4Oejxd18nwT/iA8
         oIlaL89n+dyza4FmKsEh5OHHle04N4JCM//Od16lCoSZRD4whjMbAkYERD3rzeX+fUoy
         FG2ZMi2V9PwYOX6X5W8NUsPrQ243ViYsd8WrsobXMfBu/cgV6KQO6arT3MTfbUfwVlu2
         fZveJ0IWOXfHaatk7OzxDua+kyKcOb6fEulsbEAzaD8qNnydld+gInEPWQkC+7ZuHcRU
         5cegAEmZcNtUmuDzzasSph/DSTEU6XyiN+TLya3TPObHiHgsvxRXCBStZ7U9pwgNHQvc
         fDhg==
X-Gm-Message-State: ACrzQf2TFeAHHe3vivleoSRL5sS1yG2ftVacFvqd4peoKJiVOravgABC
        4v4n0mZMCE0F54vPnU1+z97jEw==
X-Google-Smtp-Source: AMsMyM50E3Zi2Pi2Qi15nwMvBIFqLj3tfj/bD2I2FXiF+frDTWgfyyRlmXYx8MSzxyAyNPLyHC0hiQ==
X-Received: by 2002:a92:c548:0:b0:2f9:fe3f:f4c2 with SMTP id a8-20020a92c548000000b002f9fe3ff4c2mr29477770ilj.180.1666872761398;
        Thu, 27 Oct 2022 05:12:41 -0700 (PDT)
Received: from [172.22.22.4] ([98.61.227.136])
        by smtp.googlemail.com with ESMTPSA id g26-20020a05663810fa00b003717c1df569sm506543jae.165.2022.10.27.05.12.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Oct 2022 05:12:40 -0700 (PDT)
Message-ID: <e3d2e090-8349-927a-9d47-3c6c121c43a7@ieee.org>
Date:   Thu, 27 Oct 2022 07:12:39 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] rbd: fix possible memory leak in rbd_sysfs_init()
Content-Language: en-US
To:     Yang Yingliang <yangyingliang@huawei.com>,
        ceph-devel@vger.kernel.org, linux-block@vger.kernel.org
Cc:     idryomov@gmail.com, dongsheng.yang@easystack.cn, axboe@kernel.dk,
        yehuda@hq.newdream.net
References: <20221027091918.2294132-1-yangyingliang@huawei.com>
From:   Alex Elder <elder@ieee.org>
In-Reply-To: <20221027091918.2294132-1-yangyingliang@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/27/22 4:19 AM, Yang Yingliang wrote:
> If device_register() returns error in rbd_sysfs_init(), name of kobject
> which is allocated in dev_set_name() called in device_add() is leaked.
> 
> As comment of device_add() says, it should call put_device() to drop
> the reference count that was set in device_initialize() when it fails,
> so the name can be freed in kobject_cleanup().
> 
> Fault injection test can trigger this problem:
> 
> unreferenced object 0xffff88810173aa78 (size 8):
>    comm "modprobe", pid 247, jiffies 4294714278 (age 31.789s)
>    hex dump (first 8 bytes):
>      72 62 64 00 81 88 ff ff                          rbd.....
>    backtrace:
>      [<00000000f58fae56>] __kmalloc_node_track_caller+0x44/0x1b0
>      [<00000000bdd44fe7>] kstrdup+0x3a/0x70
>      [<00000000f7844d0b>] kstrdup_const+0x63/0x80
>      [<000000001b0a0eeb>] kvasprintf_const+0x10b/0x190
>      [<00000000a47bd894>] kobject_set_name_vargs+0x56/0x150
>      [<00000000d5edbf18>] dev_set_name+0xab/0xe0
>      [<00000000f5153e80>] device_add+0x106/0x1f20
> 
> Fixes: dfc5606dc513 ("rbd: replace the rbd sysfs interface")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>

This looks right to me.

Reviewed-by: Alex Elder <elder@linaro.org>

> ---
>   drivers/block/rbd.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index f9e39301c4af..04453f4a319c 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -7222,8 +7222,10 @@ static int __init rbd_sysfs_init(void)
>   	int ret;
>   
>   	ret = device_register(&rbd_root_dev);
> -	if (ret < 0)
> +	if (ret < 0) {
> +		put_device(&rbd_root_dev);
>   		return ret;
> +	}
>   
>   	ret = bus_register(&rbd_bus_type);
>   	if (ret < 0)

