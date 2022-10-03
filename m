Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE2F0C433FE
	for <linux-block@archiver.kernel.org>; Mon,  3 Oct 2022 08:36:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbiJCIgr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 3 Oct 2022 04:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbiJCIgQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 3 Oct 2022 04:36:16 -0400
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B5362983B
        for <linux-block@vger.kernel.org>; Mon,  3 Oct 2022 01:09:10 -0700 (PDT)
Received: by mail-wr1-f43.google.com with SMTP id w18so6747349wro.7
        for <linux-block@vger.kernel.org>; Mon, 03 Oct 2022 01:09:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=7Cvz2njipUpf4SwCxzEiTXwyFELDSIGJ9mQRaHlNabY=;
        b=VC1CdH7X0BcDy1WzDf6TVmyTlphjpNPWMO9ANliGgKZIBtN4auDRtCvyvBMyOXyjZd
         mTcgmAeazC/WWe6xZpBC96BHpzXvdZjB1qrNu2YpsLfmjGb7kiL0WRtds4G9Mv1QW4gm
         DIObzO6WLnuO8Ti3HA1TQLJeN/BtjQN53Z3ZQOIu/uUy0KwlIzePJSa5BWiSc8ox2TM2
         ++nlAiH/qn0a1fjsYhB7Ezi9kzUqBYEo6TMy9kdgydXTrMPkPjfTngdtFdXdMew/Xebs
         xo8oG25aa63tL23FPowI/2dxUO6kui5qJHvLDFEEwD/Wi7SvN7AwRYp4sW2xrasPPGVu
         STkw==
X-Gm-Message-State: ACrzQf1y3YQ3VoRGCjVPsO2Dk2WeexUmdC+WL6QguIf9Q+rCw0ekWUNg
        rADdrgxjFxCMiROaq8FWJGw=
X-Google-Smtp-Source: AMsMyM4U2NhJ7SELnRkgkKzV+KrRSi9pXCSLIjhUuXOdhQoSrWCyBSBPl98HOe7T1ScpI8ClZvVgtg==
X-Received: by 2002:a05:6000:1f1d:b0:22a:feb9:18a7 with SMTP id bv29-20020a0560001f1d00b0022afeb918a7mr11478321wrb.152.1664784548417;
        Mon, 03 Oct 2022 01:09:08 -0700 (PDT)
Received: from [192.168.64.53] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id n186-20020a1ca4c3000000b003a8434530bbsm15449244wme.13.2022.10.03.01.09.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Oct 2022 01:09:07 -0700 (PDT)
Message-ID: <414f04b6-aeac-5492-c175-9624b91d21c9@grimberg.me>
Date:   Mon, 3 Oct 2022 11:09:06 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH rfc] nvme: support io stats on the mpath device
Content-Language: en-US
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
 <1b7feff8-48a4-6cd2-5a44-28a499630132@grimberg.me>
 <YzcJdeR82tHbFGAh@kbusch-mbp.dhcp.thefacebook.com>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <YzcJdeR82tHbFGAh@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>>>>> 3. Do you have some performance numbers (we're touching the fast path
>>>>> here) ?
>>>>
>>>> This is pretty light-weight, accounting is per-cpu and only wrapped by
>>>> preemption disable. This is a very small price to pay for what we gain.
>>>
>>> It does add up, though, and some environments disable stats to skip the
>>> overhead. At a minimum, you need to add a check for blk_queue_io_stat() before
>>> assuming you need to account for stats.
>>>
>>> Instead of duplicating the accounting, could you just have the stats file report
>>> the sum of its hidden devices?
>>
>> Interesting...
>>
>> How do you suggest we do that? .collect_stats() callout in fops?
> 
> Maybe, yeah. I think we'd need something to enumerate the HIDDEN disks that
> make up the multipath device. Only the low-level driver can do that right now,
> so perhaps either call into the driver to get all the block_device parts, or
> the gendisk needs to maintain a list of those parts itself.

I definitely don't think we want to propagate the device relationship to
blk-mq. But a callback to the driver also seems very niche to nvme 
multipath and is also kinda messy to combine calculations like
iops/bw/latency accurately which depends on the submission distribution
to the bottom devices which we would need to track now.

I'm leaning towards just moving forward with this, take the relatively
small hit, and if people absolutely care about the extra latency, then
they can disable it altogether (upper and/or bottom devices).
