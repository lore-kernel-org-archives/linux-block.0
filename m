Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 587F3C433EF
	for <linux-block@archiver.kernel.org>; Thu, 27 Jan 2022 18:07:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236657AbiA0SHA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Jan 2022 13:07:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238956AbiA0SHA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Jan 2022 13:07:00 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 172F7C061714
        for <linux-block@vger.kernel.org>; Thu, 27 Jan 2022 10:07:00 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id d188so4585281iof.7
        for <linux-block@vger.kernel.org>; Thu, 27 Jan 2022 10:07:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ne/jFXVftIORN5xO4ovrttNELmxztmZyP5gO/6HLWHQ=;
        b=s5c0jC5e6bKpWTieJBzBxuTlaTcifGLmV/bCDAxTK0t1rBEaSTZfKHb/LSP7HGmTRb
         g0+7VK6G3W4VHIyyfyJy9qPlvfHnS9Pbqao60eniVW+Tif29MG5rO81WmAgIW9Hd5uLE
         U8l+tvveukKDMsdlzhKnfieYC0u1QnUaH3WwRv/VQsaXQGBGrM9ucu0bIXjz2fz31E8O
         JNlNMFLrBXqgyWsLhER8fg77N7eujOlpvPZcEvvHNTRR5NmO+ocW/fuoZGKgnzshY5ky
         x0nHtuuWPz3T1Ete6dwzvWmwRP21If3AT3x6i8KRrBo1MmJpFOluCB17yR6sVFyuMgtH
         Jr5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ne/jFXVftIORN5xO4ovrttNELmxztmZyP5gO/6HLWHQ=;
        b=qH1bX3O7+anI02Q+idUC6pNsxLuUKQFes2YvC5YKTRun2+XwYevoMQ3vHOzhWvuEGO
         fVCKEdOFT4Kb0fkTJl7AxDe/8xUKwZ4kXfrIpA8PZT8nqnZYJ7Sl3oK8UDwGb3A2X5jQ
         gY7Wpis9FEM4WXnRbsY/TIBoyTt8iabGB2ti7AV9Vq6iBaOYJUgpSwMJm6s98lqA6MrB
         k1Vjodk2CPcuTIUqj3qVYovHH0BuiWHOkbJvz9uSINmj6839IvjnzDyKtAh0flNqCVAy
         VY4fKgrYH0lLyZJI/sHADPjXwBt9ryvww3EcQPfBhM3xczmLmuyCAjtOq/DI+lJTEtap
         zgeQ==
X-Gm-Message-State: AOAM532fNwS0rzEt/BU+4bnobmp10R4DyhFfWZusk/coLUusoe1+H5yA
        soF/g8VYCqjK3M2RHb2WgPUQNg==
X-Google-Smtp-Source: ABdhPJzAhUi/LI6aAfZeUoA661XBpaTaRQmW7hClw2nxYDmXXn7UaQFB3utRYIdLANZRzqzyuJsEDQ==
X-Received: by 2002:a02:95e7:: with SMTP id b94mr2371314jai.106.1643306819442;
        Thu, 27 Jan 2022 10:06:59 -0800 (PST)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id c3sm13126449iow.28.2022.01.27.10.06.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jan 2022 10:06:59 -0800 (PST)
Subject: Re: [PATCH -next V5] blk-mq: fix tag_get wait task can't be awakened
To:     Guenter Roeck <linux@roeck-us.net>,
        Laibin Qiu <qiulaibin@huawei.com>
Cc:     ming.lei@redhat.com, john.garry@huawei.com,
        martin.petersen@oracle.com, hare@suse.de,
        akpm@linux-foundation.org, bvanassche@acm.org,
        andriy.shevchenko@linux.intel.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220113025536.1479653-1-qiulaibin@huawei.com>
 <20220127013238.GA1478141@roeck-us.net>
 <bb1c7c15-ef4e-8c2f-4c01-758bf186e010@kernel.dk>
 <30d998f5-15d5-c867-3c45-49aba1fb8fbc@roeck-us.net>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ad4fac09-9a35-97a3-2e0a-c3f60c50d29a@kernel.dk>
Date:   Thu, 27 Jan 2022 11:06:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <30d998f5-15d5-c867-3c45-49aba1fb8fbc@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/27/22 11:04 AM, Guenter Roeck wrote:
> On 1/27/22 09:28, Jens Axboe wrote:
>> On 1/26/22 6:32 PM, Guenter Roeck wrote:
>>> Hi,
>>>
>>> On Thu, Jan 13, 2022 at 10:55:36AM +0800, Laibin Qiu wrote:
>>>> In case of shared tags, there might be more than one hctx which
>>>> allocates from the same tags, and each hctx is limited to allocate at
>>>> most:
>>>>          hctx_max_depth = max((bt->sb.depth + users - 1) / users, 4U);
>>>>
>>>> tag idle detection is lazy, and may be delayed for 30sec, so there
>>>> could be just one real active hctx(queue) but all others are actually
>>>> idle and still accounted as active because of the lazy idle detection.
>>>> Then if wake_batch is > hctx_max_depth, driver tag allocation may wait
>>>> forever on this real active hctx.
>>>>
>>>> Fix this by recalculating wake_batch when inc or dec active_queues.
>>>>
>>>> Fixes: 0d2602ca30e41 ("blk-mq: improve support for shared tags maps")
>>>> Suggested-by: Ming Lei <ming.lei@redhat.com>
>>>> Suggested-by: John Garry <john.garry@huawei.com>
>>>> Signed-off-by: Laibin Qiu <qiulaibin@huawei.com>
>>>
>>> I understand this problem has been reported already, but still:
>>>
>>> This patch causes a hang in several of my qemu emulations when
>>> trying to boot from usb. Reverting it fixes the problem. Bisect log
>>> is attached.
>>>
>>> Boot logs are available at
>>> https://kerneltests.org/builders/qemu-arm-aspeed-master/builds/230/steps/qemubuildcommand/logs/stdio
>>> but don't really show much: the affected tests simply hang until they
>>> are aborted.
>>
>> This one got reported a few days ago, can you check if applying:
>>
>> https://git.kernel.dk/cgit/linux-block/commit/?h=block-5.17&id=10825410b956dc1ed8c5fbc8bbedaffdadde7f20
>>
>> fixes it for you?
>>
> Yes, it does.

Great, thanks for reporting/testing.

-- 
Jens Axboe

