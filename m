Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC394C433EF
	for <linux-block@archiver.kernel.org>; Thu, 27 Jan 2022 17:28:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233995AbiA0R20 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Jan 2022 12:28:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240928AbiA0R2Z (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Jan 2022 12:28:25 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B06A1C061747
        for <linux-block@vger.kernel.org>; Thu, 27 Jan 2022 09:28:24 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id h7so4450315iof.3
        for <linux-block@vger.kernel.org>; Thu, 27 Jan 2022 09:28:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NiHrTM8m6eB81b1pCE7srDrvMUba4g0skB5zfMI0lrw=;
        b=JTdiPiRz3TEJdVVOZBIwh6J2HR7uxIGsNCLo2suPO+UCntkps90II56CuW9TwsGDY9
         WPsAw+JgVZwEP7zBRT2VMZhYzfR34HDwCcZQkO+owhgbvI9DnzwPZ7Uvb6CHr8zfFtaS
         V46vw8MIXsxuuRTOKMJsAyA9nHhQ6h3gnghE68EAhdlJY4kghFzVgK+w+1hAojsjV+9x
         NwBLaSKcFoHk3GacoxvDpRGWuuuGFwJzXV4IeOamgTZEfz6cTkR7AkMa2E4f0t/lQnvM
         fnL3TAlx7vnr81fecbLHb1YYLyPw6lJJDxAk7hSw8mAdHPV0MVfGNXHO3YM2fwgWk8bR
         PiFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NiHrTM8m6eB81b1pCE7srDrvMUba4g0skB5zfMI0lrw=;
        b=ejYI17UTJ7V6uxlo3dRIHT3lY4iXva5BODk6XH7twF5FyrwloL2H00zHYOCzdIh3mr
         ooLVfmBJCPFzRGtHA0btllFia3U1K9n5kfUzw33nUG9LWVKZ0y88q6cE6qfnyCrsZ6PK
         v5wEunuW8wsIwPNED6hrNfug74tqP3nrz1FzQDCxVkl1BmDkktlfyRDsGArqM/ueAnDp
         IkPvu9Qqg+dVWcZzNf21hlBQW5SZF8IWjiq2/D1tGwBEfWB8+2ebefVqFaIqgmT+dshh
         Cek/K7A1XOvLgAbcuAADzyxERAoUCFBRk/rCQaN8jRTVi3L7mB75Az5ZTw4i/KEihnU0
         GJ6Q==
X-Gm-Message-State: AOAM5334yE+LvAEtkj6TtYFFQchXnOmO0eHi5VioyrchQRFZ+q7t5l0w
        cD+B37CjJvwmy+zqlFH2ff6srA==
X-Google-Smtp-Source: ABdhPJwBcX5RQUdOi1bACPk4RQbIXtNWPZgPMzjdQ6FuG+c3n9alVtT2kKIy9lzWbmeLrFJeWk5I4g==
X-Received: by 2002:a5e:dd41:: with SMTP id u1mr2594293iop.217.1643304504096;
        Thu, 27 Jan 2022 09:28:24 -0800 (PST)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id m14sm11636401iov.0.2022.01.27.09.28.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jan 2022 09:28:23 -0800 (PST)
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
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <bb1c7c15-ef4e-8c2f-4c01-758bf186e010@kernel.dk>
Date:   Thu, 27 Jan 2022 10:28:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20220127013238.GA1478141@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/26/22 6:32 PM, Guenter Roeck wrote:
> Hi,
> 
> On Thu, Jan 13, 2022 at 10:55:36AM +0800, Laibin Qiu wrote:
>> In case of shared tags, there might be more than one hctx which
>> allocates from the same tags, and each hctx is limited to allocate at
>> most:
>>         hctx_max_depth = max((bt->sb.depth + users - 1) / users, 4U);
>>
>> tag idle detection is lazy, and may be delayed for 30sec, so there
>> could be just one real active hctx(queue) but all others are actually
>> idle and still accounted as active because of the lazy idle detection.
>> Then if wake_batch is > hctx_max_depth, driver tag allocation may wait
>> forever on this real active hctx.
>>
>> Fix this by recalculating wake_batch when inc or dec active_queues.
>>
>> Fixes: 0d2602ca30e41 ("blk-mq: improve support for shared tags maps")
>> Suggested-by: Ming Lei <ming.lei@redhat.com>
>> Suggested-by: John Garry <john.garry@huawei.com>
>> Signed-off-by: Laibin Qiu <qiulaibin@huawei.com>
> 
> I understand this problem has been reported already, but still:
> 
> This patch causes a hang in several of my qemu emulations when
> trying to boot from usb. Reverting it fixes the problem. Bisect log
> is attached.
> 
> Boot logs are available at
> https://kerneltests.org/builders/qemu-arm-aspeed-master/builds/230/steps/qemubuildcommand/logs/stdio
> but don't really show much: the affected tests simply hang until they
> are aborted.

This one got reported a few days ago, can you check if applying:

https://git.kernel.dk/cgit/linux-block/commit/?h=block-5.17&id=10825410b956dc1ed8c5fbc8bbedaffdadde7f20

fixes it for you?

-- 
Jens Axboe

