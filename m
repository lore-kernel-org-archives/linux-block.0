Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0133FC04A68
	for <linux-block@archiver.kernel.org>; Thu, 28 Jul 2022 15:19:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231564AbiG1PT2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 Jul 2022 11:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231674AbiG1PT1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Jul 2022 11:19:27 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1597F57207
        for <linux-block@vger.kernel.org>; Thu, 28 Jul 2022 08:19:27 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id r186so1792323pgr.2
        for <linux-block@vger.kernel.org>; Thu, 28 Jul 2022 08:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc;
        bh=pQ1fJw+UH4q0bslSdkcMAKD/A55dsZAH6NsrWi3ntuY=;
        b=lHihWsOpVjf6EcqoO9LBYCjWooUzhQfnbOPhyA5hCudUs13WOxgUXL4V4Lvf8mLrk6
         8/Uv06Jg14plBHZ2nuL7ubV197+fwPnciw2AR6/BnDaNs4/R2ZIEHgT2k0S4R4AHE4vc
         4OJXqyfMII+YC+tqJUjTEuSl0fBtGEolMNui7PDXyJ+n5HVyeZnHAL/wy4SqEfSrkR5c
         2+SV5zoYu0aPHB/aU2gQa0DeNfW3nEeBUu0QabL39BSHHyiSaCevkuDC+4HUu14/T+Lt
         naEFfdglwRfAi31CI6tWknkVI7qjdBl12fDnZPu9WrLPjF4wR+pTXJVsNx8uxLPzINkm
         Sh4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=pQ1fJw+UH4q0bslSdkcMAKD/A55dsZAH6NsrWi3ntuY=;
        b=1/TrzFOES43S3FeonIKCZVFHTkW3WaefXz9yogKYoGRl6GsT4WDYHspNo0SSzHR6zO
         4BQ7hFFOHgWWD7gsZutQtuNSuGxIfBYSnt+9Q+7jY2paBb5FKK4yzFP5ZtAG/vWN/P8K
         FScDCflT0R70SlXUv273uxPjR4k2YPO1yyHoWfDoe4NCYsoFqaHvBDGacAwUogUQvIST
         6ENxIW6nhQG/nF0zT4m5SMVRM382Fm0kx3bV2x2SUBz7e8ZwGgTbcmXTESl4vh2knaSQ
         yO6vR870LNWZC67H6BoeevyYQx2TrFtyekP2R7A8WJFRrESgx+df4XA9If/WvGckNGVU
         uXaw==
X-Gm-Message-State: AJIora/2Vy3A87qZqqW0YzxZ6CuGl53bzRjdwwR1euEbR4kzxMaEzh7r
        n+nc7Xj73VANUeASALyx/fs8kw==
X-Google-Smtp-Source: AGRyM1uiE5loJGnLpiRRHlyA820KFf+7q1Uek3db/YZiwO8yNQb8Kd1rb7tFROXcy/mXpMQrBBH5cg==
X-Received: by 2002:a63:5b5e:0:b0:41a:5e8f:b127 with SMTP id l30-20020a635b5e000000b0041a5e8fb127mr22670240pgm.104.1659021566293;
        Thu, 28 Jul 2022 08:19:26 -0700 (PDT)
Received: from ?IPV6:2601:1c0:4c00:ad20:feaa:14ff:fe3a:b225? ([2601:1c0:4c00:ad20:feaa:14ff:fe3a:b225])
        by smtp.gmail.com with ESMTPSA id r17-20020aa79ed1000000b00528c26c84a3sm917844pfq.64.2022.07.28.08.19.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jul 2022 08:19:25 -0700 (PDT)
Message-ID: <94c6cdb7-7884-b95e-da32-9e46756f6cdb@linaro.org>
Date:   Thu, 28 Jul 2022 08:19:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@lst.de>
Cc:     stable@vger.kernel.org, linux-block@vger.kernel.org,
        dm-devel@redhat.com,
        syzbot+4f441e6ca0fcad141421@syzkaller.appspotmail.com,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Jens Axboe <axboe@kernel.dk>
References: <20220718211226.506362-1-tadeusz.struk@linaro.org>
 <YtwM3uHugOOdDQZT@kroah.com> <YuKgW9BCNl8ChT/v@kroah.com>
 <20220728144520.GA18285@lst.de> <YuKkgPx2XF6rQnLq@kroah.com>
From:   Tadeusz Struk <tadeusz.struk@linaro.org>
Subject: Re: [PATCH 5.10 1/2] block: split bio_kmalloc from bio_alloc_bioset
In-Reply-To: <YuKkgPx2XF6rQnLq@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/28/22 08:00, Greg KH wrote:
> On Thu, Jul 28, 2022 at 04:45:20PM +0200, Christoph Hellwig wrote:
>> On Thu, Jul 28, 2022 at 04:42:35PM +0200, Greg KH wrote:
>>>>> Link:https://syzkaller.appspot.com/bug?id=a3416231e37024a75f2b95bd95db0d8ce8132a84
>>>> Both now queued up, thanks.
>>> As was just reported, this breaks things all over the place:
>>> 	https://lore.kernel.org/r/219030d8-3408-cc9d-7aec-1fb14ab891ce@roeck-us.net
>>>
>>> Note, I also had to add lots of fix-up patches on top of these two that
>>> you missed, so odds are there are other fix-ups that I also missed.
>>>
>>> Please go and test this again, and submit ALL patches that are needed
>>> after they pass the proper testing and I will be glad to reconsider them
>>> again.
>> Why did this even get backported?  It was a cleanup that required a lot
>> of prep work, and should not by itself fix anything.
> Looks like syzkaller is reporting something odd...
> 
> Tadeusz, how was this tested?

Yes, I tested it with syzbot and locally and it fixed the syzbot reported
"kernel BUG at block/blk-mq.c:567" issue:

https://syzkaller.appspot.com/bug?id=a3416231e37024a75f2b95bd95db0d8ce8132a84

I only tested it with booting from ext4 fs, as I don't have any btrfs setup.

-- 
Thanks,
Tadeusz
