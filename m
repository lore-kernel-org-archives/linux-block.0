Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E092C433FE
	for <linux-block@archiver.kernel.org>; Mon,  3 Oct 2022 08:52:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbiJCIwe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 3 Oct 2022 04:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbiJCIwE (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 3 Oct 2022 04:52:04 -0400
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B72B57BC7
        for <linux-block@vger.kernel.org>; Mon,  3 Oct 2022 01:35:56 -0700 (PDT)
Received: by mail-wr1-f51.google.com with SMTP id c11so15587759wrp.11
        for <linux-block@vger.kernel.org>; Mon, 03 Oct 2022 01:35:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=8DszboK9P2kLc+x/fwfSaNitxkx4T0tjN4W158nD7RQ=;
        b=HTWy5yVVYJvJUzBzdlwDUidbqnaipP+qMJkqCMRWLGUC1py4tgZirjC0UvQILVzNgb
         bthT7Fx2nnH5yO3QLNOW5/V/smr6FLlqrohgnBN4jRuhlyi2WACV+qCzSTZSadtqGF+S
         LkSd6e09HkdsbAvJ5YrEMR8vhwRS7rZMfFRa7ZMo4LTcFPQvq1kvOhx4Flx6mGUUc0SJ
         SaC/bXxRR43GYPAXNaMFM5NchzSBT7/YWPN1Pgqr5g7vKxgzFFTRaGNHv1sqnrCxfmK5
         QmKdBeqeKYxJdCWU5x8a6HFueTwBlyLOyyw+Yf7W4xNB/u4OpwZVUSQLmh+k+FNidqGo
         wO7g==
X-Gm-Message-State: ACrzQf1cldBPIoWtNQhMpS5P7i3oiULN+dTrijjQIG99A9XwoHdUoNl9
        KzHDRlVwMJaFHhhyA7e8uoA=
X-Google-Smtp-Source: AMsMyM5Gdpr6jmN+kyU1bDODzWukh5kcVfipr95CpDmAmdt4r58YxyMU7t3c5bzfSTdXVMkBt5OUdQ==
X-Received: by 2002:adf:fb84:0:b0:21a:10f2:1661 with SMTP id a4-20020adffb84000000b0021a10f21661mr12048882wrr.2.1664786154968;
        Mon, 03 Oct 2022 01:35:54 -0700 (PDT)
Received: from [192.168.64.53] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id l18-20020a05600c2cd200b003a63a3b55c3sm16720637wmc.14.2022.10.03.01.35.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Oct 2022 01:35:54 -0700 (PDT)
Message-ID: <20de260f-2cf4-4308-ba9b-5e75abde0342@grimberg.me>
Date:   Mon, 3 Oct 2022 11:35:52 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH rfc] nvme: support io stats on the mpath device
Content-Language: en-US
To:     Jens Axboe <axboe@kernel.dk>, Max Gurtovoy <mgurtovoy@nvidia.com>,
        linux-nvme@lists.infradead.org
Cc:     Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        linux-block@vger.kernel.org, Hannes Reinecke <hare@suse.de>
References: <20220928195510.165062-1-sagi@grimberg.me>
 <20220928195510.165062-2-sagi@grimberg.me>
 <760a7129-945c-35fa-6bd6-aa315d717bc5@nvidia.com>
 <a3d619a3-ccae-69ea-3e2c-9acff7b97d92@grimberg.me>
 <04b39974-6b55-7aca-70de-4a567f2eac8f@kernel.dk>
 <91ebc84d-c0e3-b792-4f92-79612271eb91@grimberg.me>
 <c2cab5be-658d-3c50-b1a0-1d7d86e12e0b@kernel.dk>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <c2cab5be-658d-3c50-b1a0-1d7d86e12e0b@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 9/30/22 03:08, Jens Axboe wrote:
> On 9/29/22 10:25 AM, Sagi Grimberg wrote:
>>
>>>>> 3. Do you have some performance numbers (we're touching the fast path here) ?
>>>>
>>>> This is pretty light-weight, accounting is per-cpu and only wrapped by
>>>> preemption disable. This is a very small price to pay for what we gain.
>>>
>>> Is it? Enabling IO stats for normal devices has a very noticeable impact
>>> on performance at the higher end of the scale.
>>
>> Interesting, I didn't think this would be that noticeable. How much
>> would you quantify the impact in terms of %?
> 
> If we take it to the extreme - my usual peak benchmark, which is drive
> limited at 122M IOPS, run at 113M IOPS if I have iostats enabled. If I
> lower the queue depth (128 -> 16), then peak goes from 46M to 44M. Not
> as dramatic, but still quite noticeable. This is just using a single
> thread on a single CPU core per drive, so not throwing tons of CPU at
> it.
> 
> Now, I have no idea how well nvme multipath currently scales or works.

Should be pretty scalable and efficient. There is no bio cloning and
the only shared state is an srcu wrapping the submission path and path
lookup.

> Would be interesting to test that separately. But if you were to double
> (or more, I guess 3x if you're doing the exposed device and then adding
> stats to at least two below?) the overhead, that'd certainly not be
> free.

It is not 3x, in the patch nvme-multipath is accounting separately from
the bottom devices, so each request is accounted once for the bottom
device and once for the upper device.

But again, my working assumption is that IO stats must be exposed for
a nvme-multipath device (unless the user disabled them). So it is a
matter of weather we take a simple approach, where nvme-multipath does
"double" accounting or, we come up with a scheme that allows the driver
to collect stats on behalf of the block layer, and then add non-trivial
logic to combine stats like iops/bw/latency accurately from the bottom
devices.

My vote would be to go with the former.

>> I don't have any insight on this for blk-mq, probably because I've never
>> seen any user turn IO stats off (or at least don't remember).
> 
> Most people don't care, but some certainly do. As per the above, it's
> noticeable enough that it makes a difference if you're chasing latencies
> or peak performance.
> 
>> My (very limited) testing did not show any noticeable differences for
>> nvme-loop. All I'm saying that we need to have IO stats for the mpath
>> device node. If there is a clever way to collect this from the hidden
>> devices just for nvme, great, but we need to expose these stats.
> 
>   From a previous message, sounds like that's just some qemu setup? Hard
> to measure anything there with precision in my experience, and it's not
> really peak performance territory either.

It's not qemu, it is null_blk exported over nvme-loop (nvmet loop
device). so it is faster, but definitely not something that can provide
insight in the realm of real HW.
