Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F29DC43219
	for <linux-block@archiver.kernel.org>; Wed, 23 Nov 2022 10:32:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236241AbiKWKcg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Nov 2022 05:32:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237424AbiKWKcF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Nov 2022 05:32:05 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8B3D5914D
        for <linux-block@vger.kernel.org>; Wed, 23 Nov 2022 02:16:39 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id bs21so28662968wrb.4
        for <linux-block@vger.kernel.org>; Wed, 23 Nov 2022 02:16:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SfSgzRdu52VXS9GHSMI5+bTUMj6/o+2tOE+xfBwsoLI=;
        b=vyoQ2dpNfzsrZ300v6wxqZnvPhVhRdPuHPQvGEbWYsQBoyRG8NPbYI76SriVBh+AYr
         cuQIkXiAUv0xfWdO4pVTfOWajTLifDHXY6AKmbmxMskHxz379ACEDgCMLHup7dHenRD2
         AWcHhy+LWODVy39Hlm++2R7aAGfQhCxH1NxPaBsOWhydPQCy67i2ZpPd5SQ/J1A2DiR3
         0slOLKfp5fB5utKW+bWmwrbaAQFOx2Nx8tf5UKyg43XexztDReg+cw+9EuS5I4mOcPMw
         nM1pxaKD3GCXEghPDWRdOqPL0+ehtTHpGFi1bfRVXB3fIk0r9Y4ZXhBtW/h3MAnMw5/u
         BsSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SfSgzRdu52VXS9GHSMI5+bTUMj6/o+2tOE+xfBwsoLI=;
        b=78U/6xpz0EnMJoXy6ZckcmYhzBQoxuEojZpRr4dApLbVBiSz3iEvz/6lL0WMNsLYgs
         jsJoeGQ8tiE9Yn1pFa1FgVnxCcqkSKXzpbpYr9bMg1h2ZUTzuKS8UwHma/MzzlPEA7JX
         ki3U+SVIfY7HePG+pv5tOmfv5TUC/ZpBZwAZ8cBGHcjqsIri/XP2v+KO9dAf384BoPE4
         rCy0R97is1xHJ6BMjzARRQWKdnwoMwV5qiPfgcfpIcuWyq52fHJcZke3cREN70grL7j7
         mCvE7KAnXGyJkrQHUaLrdwGveg9F2zZS0fD2ZqD/365HDjd3LZCffm2SU7oAtX8z3cF5
         or6A==
X-Gm-Message-State: ANoB5plaimZkt6CgeONlfqBarMz52K/2azEqQybAQu8TfGObVBx4yQ9y
        svS18rd3uTb4wSHaYhBoa4wdQpnDeJAndx1O
X-Google-Smtp-Source: AA0mqf6t1LjgypMVT8M/b/3MjMH25M3QL5zBf6bgM6451Mnv+JB0P9H15buIoAK2B/PKaNx72KFLCQ==
X-Received: by 2002:adf:e2ca:0:b0:22e:4ac2:aaa5 with SMTP id d10-20020adfe2ca000000b0022e4ac2aaa5mr16663662wrj.455.1669198598492;
        Wed, 23 Nov 2022 02:16:38 -0800 (PST)
Received: from [192.168.178.55] (h082218028181.host.wavenet.at. [82.218.28.181])
        by smtp.gmail.com with ESMTPSA id g16-20020adffc90000000b0022ae401e9e0sm16304581wrr.78.2022.11.23.02.16.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Nov 2022 02:16:38 -0800 (PST)
Message-ID: <e396a423-97e7-2b50-21e3-7ac4070b6d9a@linbit.com>
Date:   Wed, 23 Nov 2022 11:16:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v3 2/2] drbd: destroy workqueue when drbd device was freed
Content-Language: en-US
To:     Wang ShaoBo <bobo.shaobowang@huawei.com>
Cc:     liwei391@huawei.com, linux-block@vger.kernel.org,
        drbd-dev@lists.linbit.com, axboe@kernel.dk,
        lars.ellenberg@linbit.com
References: <20221123020355.2470160-1-bobo.shaobowang@huawei.com>
 <20221123020355.2470160-3-bobo.shaobowang@huawei.com>
From:   =?UTF-8?Q?Christoph_B=c3=b6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
In-Reply-To: <20221123020355.2470160-3-bobo.shaobowang@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Am 23.11.22 um 03:03 schrieb Wang ShaoBo:
> A submitter workqueue is dynamically allocated by init_submitter()
> called by drbd_create_device(), we should destroy it when this
> device is not needed or destroyed.
> 
> Fixes: 113fef9e20e0 ("drbd: prepare to queue write requests on a submit worker")
> Signed-off-by: Wang ShaoBo <bobo.shaobowang@huawei.com>
> ---
> 
> v3:
>   - add out_* label for destroy_workqueue().
> 
>  drivers/block/drbd/drbd_main.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
> index 78cae4e75af1..677240232684 100644
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
> @@ -2771,7 +2773,7 @@ enum drbd_ret_code drbd_create_device(struct drbd_config_context *adm_ctx, unsig
>  
>  	err = add_disk(disk);
>  	if (err)
> -		goto out_idr_remove_from_resource;
> +		goto out_destroy_workqueue;
>  
>  	/* inherit the connection state */
>  	device->state.conn = first_connection(resource)->cstate;
> @@ -2785,6 +2787,8 @@ enum drbd_ret_code drbd_create_device(struct drbd_config_context *adm_ctx, unsig
>  	drbd_debugfs_device_add(device);
>  	return NO_ERROR;
>  
> +out_destroy_workqueue:
> +	destroy_workqueue(device->submit.wq);
>  out_idr_remove_from_resource:
>  	for_each_connection_safe(connection, n, resource) {
>  		peer_device = idr_remove(&connection->peer_devices, vnr);

Thanks!

Reviewed-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>

-- 
Christoph Böhmwalder
LINBIT | Keeping the Digital World Running
DRBD HA —  Disaster Recovery — Software defined Storage
