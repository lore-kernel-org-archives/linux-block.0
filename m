Return-Path: <SRS0=Ef4g=6A=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68658C2BB85
	for <linux-block@archiver.kernel.org>; Thu, 16 Apr 2020 08:35:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52CCA216FD
	for <linux-block@archiver.kernel.org>; Thu, 16 Apr 2020 08:35:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439552AbgDPIev (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Apr 2020 04:34:51 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2381 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2502445AbgDPIe2 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Apr 2020 04:34:28 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id D4369D718DC70E64E64B;
        Thu, 16 Apr 2020 16:34:17 +0800 (CST)
Received: from [10.166.215.172] (10.166.215.172) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.487.0; Thu, 16 Apr 2020 16:34:14 +0800
Subject: Re: [PATCH 3/8] bdi: add a ->dev_name field to struct
 backing_dev_info
To:     Christoph Hellwig <hch@lst.de>, <axboe@kernel.dk>
CC:     <tj@kernel.org>, <jack@suse.cz>, <bvanassche@acm.org>,
        <tytso@mit.edu>, <gregkh@linuxfoundation.org>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20200416071519.807660-1-hch@lst.de>
 <20200416071519.807660-4-hch@lst.de>
From:   Yufen Yu <yuyufen@huawei.com>
Message-ID: <5bfcd35a-2463-3769-be93-911c4e3c38bb@huawei.com>
Date:   Thu, 16 Apr 2020 16:34:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200416071519.807660-4-hch@lst.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.166.215.172]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

On 2020/4/16 15:15, Christoph Hellwig wrote:
> Cache a copy of the name for the life time of the backing_dev_info
> structure so that we can reference it even after unregistering.
> 
> Fixes: 68f23b89067f ("memcg: fix a crash in wb_workfn when a device disappears")
> Reported-by: Yufen Yu <yuyufen@huawei.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   include/linux/backing-dev-defs.h |  1 +
>   mm/backing-dev.c                 | 13 ++++++++++---
>   2 files changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/backing-dev-defs.h b/include/linux/backing-dev-defs.h
> index 4fc87dee005a..249590bcccf7 100644
> --- a/include/linux/backing-dev-defs.h
> +++ b/include/linux/backing-dev-defs.h
> @@ -220,6 +220,7 @@ struct backing_dev_info {
>   	wait_queue_head_t wb_waitq;
>   
>   	struct device *dev;
> +	const char *dev_name;
>   	struct device *owner;
>   
>   	struct timer_list laptop_mode_wb_timer;
> diff --git a/mm/backing-dev.c b/mm/backing-dev.c
> index c2c44c89ee5d..4f6c05df72f9 100644
> --- a/mm/backing-dev.c
> +++ b/mm/backing-dev.c
> @@ -938,9 +938,15 @@ int bdi_register_va(struct backing_dev_info *bdi, const char *fmt, va_list args)
>   	if (bdi->dev)	/* The driver needs to use separate queues per device */
>   		return 0;
>   
> -	dev = device_create_vargs(bdi_class, NULL, MKDEV(0, 0), bdi, fmt, args);
> -	if (IS_ERR(dev))
> +	bdi->dev_name = kvasprintf(GFP_KERNEL, fmt, args);
> +	if (!bdi->dev_name)
> +		return -ENOMEM;
> +
> +	dev = device_create(bdi_class, NULL, MKDEV(0, 0), bdi, bdi->dev_name);
> +	if (IS_ERR(dev)) {
> +		kfree(bdi->dev_name);
>   		return PTR_ERR(dev);
> +	}
>   
>   	cgwb_bdi_register(bdi);
>   	bdi->dev = dev;
> @@ -1034,6 +1040,7 @@ static void release_bdi(struct kref *ref)
>   	WARN_ON_ONCE(bdi->dev);
>   	wb_exit(&bdi->wb);
>   	cgwb_bdi_exit(bdi);
> +	kfree(bdi->dev_name);
>   	kfree(bdi);
>   }


When driver try to to re-register bdi but without release_bdi(), the old dev_name
will be cover directly by the newer in bdi_register_va(). So, I am not sure whether
it can cause memory leak for bdi->dev_name.

Thanks,
Yufen

>   
> @@ -1047,7 +1054,7 @@ const char *bdi_dev_name(struct backing_dev_info *bdi)
>   {
>   	if (!bdi || !bdi->dev)
>   		return bdi_unknown_name;
> -	return dev_name(bdi->dev);
> +	return bdi->dev_name;
>   }
>   EXPORT_SYMBOL_GPL(bdi_dev_name);




