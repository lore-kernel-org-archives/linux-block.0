Return-Path: <SRS0=9mBv=RD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7B15C43381
	for <linux-block@archiver.kernel.org>; Thu, 28 Feb 2019 21:02:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 745F420C01
	for <linux-block@archiver.kernel.org>; Thu, 28 Feb 2019 21:02:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="nMQARGob"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387485AbfB1VC2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 Feb 2019 16:02:28 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:40144 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726414AbfB1VC1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Feb 2019 16:02:27 -0500
Received: by mail-it1-f195.google.com with SMTP id l139so15840512ita.5
        for <linux-block@vger.kernel.org>; Thu, 28 Feb 2019 13:02:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8Q4IlRFb3II5g75+tKQPGccCTKZOT3OhG4z1W8CF+9E=;
        b=nMQARGob3rHYDzCA9Y5fJ3qyEegfq/A7bp4k3ryfAnaJZ+TbtqCOgbzuEiTg6B9LnF
         FAXrDhuCkjtfAhIYagpalbpMPGdqPJcJ9Z8q063ymjUOLgbQLP9nr9qqgK4I4yg/n722
         k1xki66XR8jay/8MdrBIfMna00J5UaONZFrWeOmAgSq37pMVw9cbrrxjDPvfWHy8WVgZ
         w4XTVC+WZGvOOeWaQs1tAfhFvSELqYlrgVCm7b9iHT1PhYplAgbRhYtvUBKLhh9AyCSZ
         IkbxjqJamulhWv3BMwAnsSBUNxRwkYgQdMp7cfQf9wQkGfA8e0F9geM/ZRSblZesjmgV
         AnOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8Q4IlRFb3II5g75+tKQPGccCTKZOT3OhG4z1W8CF+9E=;
        b=cNOJdK/SaiwK22+KEapi38p+0wQAez0O74BgIovaoAtZKUot6EMU5VyP1uee2Axw0d
         nIo78Qb2gLxQdT1b/wgUtlpmBCQl5Dl9ASYzffnbwLSN/ifWL9DV7EA9tcuamoHNXYgX
         bPESEmfX5IlLu+WCgoerFPUcRpyhtf22L+dyVR1kkMb4EfJOYNLcNupCCTl3UvIkgIgP
         8AlXARS/lJVvz0TZ65tqchpKPBEMNMnNzZHwAPrfwyvbf8eSt9ZAzaIarevybOa5o8jc
         WIO9nY4RjSvzn9uC2THRN/GKeJFKrXSASodUli+O9p/S/MOt1Odyh60IGA7anuddc0aD
         W2xA==
X-Gm-Message-State: APjAAAUjnhyo8zhDFTRzBslaQGZJhl+DsaMi6tHyPvnGxvZibsGmb5aP
        +PhlxMLx8BFar6ONMjbS1T7dsvhHCSBCVQ==
X-Google-Smtp-Source: APXvYqyc4j2cXS/xA6pyyBYyRH1iFXcC8NVqunvq1lKFChOW6Wka8zWFEDngjlwNvkH7hmsyQ5SR8w==
X-Received: by 2002:a24:ccc5:: with SMTP id x188mr1183331itf.123.1551387746677;
        Thu, 28 Feb 2019 13:02:26 -0800 (PST)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id w19sm3310095ita.33.2019.02.28.13.02.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Feb 2019 13:02:25 -0800 (PST)
Subject: Re: [PATCH 0/1] Fix NULL pointer dereference in register_disk
To:     zhengbin <zhengbin13@huawei.com>, linux-block@vger.kernel.org
Cc:     houtao1@huawei.com, yi.zhang@huawei.com
References: <1550669225-77623-1-git-send-email-zhengbin13@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b88dc434-5e47-f446-896c-b1b75acefa11@kernel.dk>
Date:   Thu, 28 Feb 2019 14:02:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <1550669225-77623-1-git-send-email-zhengbin13@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/20/19 6:27 AM, zhengbin wrote:
> When I use syzkaller test kernel, there is a NULL pointer dereference
> in register_disk. The better solution is add return code to
> __device_add_disk. There is a patchset(http://lists.infradead.org/pipermail
> /linux-nvme/2016-August/005860.html) from Fam Zheng, int this patchset, the
> modify is as follows:
>  int device_add_disk() {
>         ...alloc A...
>         retval = alloc B
>         if (retval)
>             goto fail;
>         ...
> 	fail:
> 	    return retval;  --->did not free A
>    }
> There are many callers, ie:
> loop_add-->add_disk-->device_add_disk-->__device_add_disk
> loop_remove-->del_gendisk
> ----->This will free all resources, inclue B(free fail)
> 
> Maybe the better way is that if device_add_disk return fail, it should
> free all resources? This needs to modify all the callers(Otherwise the
> callers will double free), unfortunately, I am not very familiar with it.

That can/should be done when we actually deal with error handling properly
in this path. I have applied your patch.

-- 
Jens Axboe

