Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8828C4338F
	for <linux-block@archiver.kernel.org>; Sat, 21 Aug 2021 03:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBA5961183
	for <linux-block@archiver.kernel.org>; Sat, 21 Aug 2021 03:17:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231847AbhHUDRo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 20 Aug 2021 23:17:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231789AbhHUDRn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 20 Aug 2021 23:17:43 -0400
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13DDBC061575
        for <linux-block@vger.kernel.org>; Fri, 20 Aug 2021 20:17:05 -0700 (PDT)
Received: by mail-oo1-xc31.google.com with SMTP id f33-20020a4a89240000b029027c19426fbeso3479668ooi.8
        for <linux-block@vger.kernel.org>; Fri, 20 Aug 2021 20:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MSn7rAHilGstrynTKOQuRFaHHLuxeNAIbh4aZ/yLE2M=;
        b=b1cLw1NWAckGRZtttfnN7dH6CBO8ZJ4HEKbJjoytnyZrUasmEgvLn4FFFNPRk3FxW0
         T+/V6LjoBJJiFGzTROOJ/EFdQvxRfG0FR/PHtz1jDpejLtcO7ObJRMC5RewV7CncuVKK
         TNoYkPllS0Nu+CgW128gAHfCScGf4lv3aBa6vincwNHu455BYDC0gPg+Ymj/v0AcNyej
         p6wPmX+sXkGsOA6JnFn1SAsEGmjV6NKuV8oFu1gJpbLRhUVDcQxzhkKdGrGWeqghuQCr
         GSREUa8kZqcoGXqcfiM+UOMDe/SUXyBNSQhquy+aqR4fnnbLzmZnn76JyZfQXWoArtKd
         NijA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:to:cc:references:from:subject:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MSn7rAHilGstrynTKOQuRFaHHLuxeNAIbh4aZ/yLE2M=;
        b=n/Jr05mAD2H6D5/CLhC5aiDzg66hg5X/7UPaOoRriOI5f5emUqzrRHpkY8FdDtILbD
         hpmZey0/j1k1nM/ESXgxuFrc32sPrtc6ajuwi4+wRfCGsClIfeYbToUdhXv/b9h/Vp13
         FW4sQK54ijebgePh7JHJme5nEiZnj+a9RwmH5ww2m4BT2iWkds0skOZ0gESSSVbt+8eh
         PpLqaLih4FwRy7SQlGZbeJD6EzEc+FMhC55SBi+u3CjKrZuhSWSHHn5T1MS66yniouVC
         qtc8yglQ6dv2FAX3kyJZGNEldgD3LecsNUSxzdWkg92wHAsxN2PLFq+2Aofqm0tNwEEe
         B0yQ==
X-Gm-Message-State: AOAM533GMJoN+c2WTdYJYstjDnQznie5ayxoo+HjNXIJq8Iiax+J96TI
        VoOfmu6JiNOtcaDNm44U5bY=
X-Google-Smtp-Source: ABdhPJz5QoGE5JSa2c7qhLnCr2DfM5AAEX5WXbVUcUlWlBtw/2nBLJjOv+IU9Qi2MRv4sv3YLAZfdw==
X-Received: by 2002:a4a:8d41:: with SMTP id x1mr18707795ook.46.1629515824292;
        Fri, 20 Aug 2021 20:17:04 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s35sm1892362otv.44.2021.08.20.20.17.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Aug 2021 20:17:03 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Mike Snitzer <snitzer@redhat.com>,
        linux-block@vger.kernel.org, dm-devel@redhat.com
References: <20210804094147.459763-1-hch@lst.de>
 <20210804094147.459763-5-hch@lst.de> <20210814211309.GA616511@roeck-us.net>
 <20210815070724.GA23276@lst.de>
 <a8d66952-ee44-d3fa-d699-439415b9abfe@roeck-us.net>
 <20210816072158.GA27147@lst.de> <20210816141702.GA3449320@roeck-us.net>
 <20210820150803.GA490@lst.de>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [dm-devel] [PATCH 4/8] block: support delayed holder registration
Message-ID: <9c2943fd-b540-1f49-43c3-906cbaddd1a5@roeck-us.net>
Date:   Fri, 20 Aug 2021 20:17:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210820150803.GA490@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/20/21 8:08 AM, Christoph Hellwig wrote:
> Please try the patch below:
> 
> ---
>>From 7609266da56160d211662cd2fbe26570aad11b15 Mon Sep 17 00:00:00 2001
> From: Christoph Hellwig <hch@lst.de>
> Date: Fri, 20 Aug 2021 17:00:11 +0200
> Subject: mtd_blkdevs: don't hold del_mtd_blktrans_dev in
>   blktrans_{open,release}
> 
> There is nothing that this protects against except for slightly reducing
> the window when new opens can appear just before calling del_gendisk.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

A cautious

Tested-by: Guenter Roeck <linux@roeck-us.net>

Cautious because -next is a bit broken right now and I can not run a complete
test for all images.

Guenter

> ---
>   drivers/mtd/mtd_blkdevs.c | 5 -----
>   1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/mtd/mtd_blkdevs.c b/drivers/mtd/mtd_blkdevs.c
> index 44bea3f65060..6b81a1c9ccbe 100644
> --- a/drivers/mtd/mtd_blkdevs.c
> +++ b/drivers/mtd/mtd_blkdevs.c
> @@ -207,7 +207,6 @@ static int blktrans_open(struct block_device *bdev, fmode_t mode)
>   	if (!dev)
>   		return -ERESTARTSYS; /* FIXME: busy loop! -arnd*/
>   
> -	mutex_lock(&mtd_table_mutex);
>   	mutex_lock(&dev->lock);
>   
>   	if (dev->open)
> @@ -233,7 +232,6 @@ static int blktrans_open(struct block_device *bdev, fmode_t mode)
>   unlock:
>   	dev->open++;
>   	mutex_unlock(&dev->lock);
> -	mutex_unlock(&mtd_table_mutex);
>   	blktrans_dev_put(dev);
>   	return ret;
>   
> @@ -244,7 +242,6 @@ static int blktrans_open(struct block_device *bdev, fmode_t mode)
>   	module_put(dev->tr->owner);
>   	kref_put(&dev->ref, blktrans_dev_release);
>   	mutex_unlock(&dev->lock);
> -	mutex_unlock(&mtd_table_mutex);
>   	blktrans_dev_put(dev);
>   	return ret;
>   }
> @@ -256,7 +253,6 @@ static void blktrans_release(struct gendisk *disk, fmode_t mode)
>   	if (!dev)
>   		return;
>   
> -	mutex_lock(&mtd_table_mutex);
>   	mutex_lock(&dev->lock);
>   
>   	if (--dev->open)
> @@ -272,7 +268,6 @@ static void blktrans_release(struct gendisk *disk, fmode_t mode)
>   	}
>   unlock:
>   	mutex_unlock(&dev->lock);
> -	mutex_unlock(&mtd_table_mutex);
>   	blktrans_dev_put(dev);
>   }
>   
> 

