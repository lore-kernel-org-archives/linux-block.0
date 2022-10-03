Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8156C433F5
	for <linux-block@archiver.kernel.org>; Mon,  3 Oct 2022 09:39:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbiJCJjx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 3 Oct 2022 05:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbiJCJjS (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 3 Oct 2022 05:39:18 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58A0ADF3A
        for <linux-block@vger.kernel.org>; Mon,  3 Oct 2022 02:34:42 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id f11so13155778wrm.6
        for <linux-block@vger.kernel.org>; Mon, 03 Oct 2022 02:34:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=iuAFOrGO0x1a74yJsh51r5/pnODrj5Z9lxoSgcX0Www=;
        b=EVsDiWwq5fnn6gzplNlUOoPqCwAWhg5kTh040YUi//gJhLGQ21ZkOY6ZCU4rBqKpJx
         eKr1hmLlo1Jhe+xZsj4HKMt2k5wN8nU3A8leHbZCLs6CRt1gOQ42Ew4dnW8HJjSvn/PA
         OS9WyOQTAXQuzpRr6axEKnX9kvDfe2T8cgthxuN9hy2d04QixYeoZ40mkHEOgTtHox1y
         dEyuWKobdSFPRi4Q71PkULuK7POiXAP+SPfmdUJHhY4hxXeruhR/k72rHMjjtHTV0lCz
         xfAgUVFHoUO6l827LAQmARlCAO5vlSE1Bb1eP+ucx7fhCyIjDwk3xORXOxrcT3fdutee
         pOLw==
X-Gm-Message-State: ACrzQf0HCVh6m9+DMqXFlj3Q9deeI+i6P6mgSZg5MAEeRnqdypQ96rx3
        eXVg//5CCMEcwB6ro1DaD7M=
X-Google-Smtp-Source: AMsMyM4tbT7tRLGC/xMWM7isBXOpX9K3M1K9MYMrL0fahfaOfjd+IKul0xAFAxxmyGyu2crmfkXawg==
X-Received: by 2002:a5d:62d2:0:b0:22e:4a7:1ab6 with SMTP id o18-20020a5d62d2000000b0022e04a71ab6mr7751475wrv.334.1664789556529;
        Mon, 03 Oct 2022 02:32:36 -0700 (PDT)
Received: from [192.168.64.53] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id m7-20020a05600c3b0700b003a1980d55c4sm17154501wms.47.2022.10.03.02.32.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Oct 2022 02:32:35 -0700 (PDT)
Message-ID: <60a07961-0311-3c11-26b4-efa8da43d9d7@grimberg.me>
Date:   Mon, 3 Oct 2022 12:32:34 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH rfc] nvme: support io stats on the mpath device
Content-Language: en-US
From:   Sagi Grimberg <sagi@grimberg.me>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Max Gurtovoy <mgurtovoy@nvidia.com>,
        linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Hannes Reinecke <hare@suse.de>
References: <20220928195510.165062-1-sagi@grimberg.me>
 <20220928195510.165062-2-sagi@grimberg.me>
 <760a7129-945c-35fa-6bd6-aa315d717bc5@nvidia.com>
 <a3d619a3-ccae-69ea-3e2c-9acff7b97d92@grimberg.me>
 <YzWzvOKgoAqltAA0@kbusch-mbp.dhcp.thefacebook.com>
 <e5299b5e-5e9a-5a2a-b7dc-30de2bf43adc@grimberg.me>
 <YzcINzNpZ+4zkupd@kbusch-mbp.dhcp.thefacebook.com>
 <cef09c04-17d6-c588-be9f-b33e36dfce1a@grimberg.me>
In-Reply-To: <cef09c04-17d6-c588-be9f-b33e36dfce1a@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 10/3/22 11:02, Sagi Grimberg wrote:
> 
>>>>>> 3. Do you have some performance numbers (we're touching the fast path
>>>>>> here) ?
>>>>>
>>>>> This is pretty light-weight, accounting is per-cpu and only wrapped by
>>>>> preemption disable. This is a very small price to pay for what we 
>>>>> gain.
>>>>
>>>> It does add up, though, and some environments disable stats to skip the
>>>> overhead. At a minimum, you need to add a check for 
>>>> blk_queue_io_stat() before
>>>> assuming you need to account for stats.
>>>
>>> But QUEUE_FLAG_IO_STAT is set by nvme-mpath itself?
>>> You mean disable IO stats in runtime?
>>
>> Yes, the user can disable it at any time. That actually makes things a 
>> bit
>> tricky since it can be enabled at the start of an IO and disabled by 
>> the time
>> it completes.
> 
> That is what blk_do_io_stat is for, we can definitely export that.

Actually, blk_do_io_stat refers to the bottom request queue. you're
right, we can do the same trick for nvme.
