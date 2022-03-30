Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B501C433EF
	for <linux-block@archiver.kernel.org>; Wed, 30 Mar 2022 01:20:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241601AbiC3BWX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Mar 2022 21:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241600AbiC3BWW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Mar 2022 21:22:22 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF84D47393
        for <linux-block@vger.kernel.org>; Tue, 29 Mar 2022 18:20:37 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id f3so16200627pfe.2
        for <linux-block@vger.kernel.org>; Tue, 29 Mar 2022 18:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=x6rv08fpwpzLso4SC/yKscWicPs6HNkxCkCPxl5J16Q=;
        b=XO9Kzh+W10rhwsTvM+KAuFjAIudNiX4KiGdCKDAfRXWGbemz7HiLQHdk3SPWpFVkAV
         yrgFN66DdNUw3hlngalgpAnB0BhVJfBGFF/8bMUJrFuSytAsaQEb26AFoRegx8XzElJR
         UMYg4lhP6KMmzu9ZU6L8WYn1ThUi4dlDpqzqHAyU0m+UAAC1kfpqTnnY9Rxc7WppVAUS
         lLv6ft+V20F6U1hOCVkH8JmJu6u8T0Shm9zO9f6nuOm9YAnhHJqZkrgth1no4s6oBhfr
         9CdrTfnwvo423WEDEt1G++JyYzeGPauED/SYVm7r27MhnxlF5KY71ZK1JT4nKwmIDCTK
         F0fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=x6rv08fpwpzLso4SC/yKscWicPs6HNkxCkCPxl5J16Q=;
        b=oCshpdya+8n5AVFE+3uPQIWIBdhZVcpppD1tiIgvr9bh15sv79iOeF6xob5oC2QBxS
         aj2J7z+kIyWUErmvGUSt6OzwqZ1lCkWqfITx0+JQr7IC5CXkDzm2wZ5b+193AXksUt02
         rirO3bQm5cDnO6l/7LNZWTDkjfvjYwAt+In3iZg5al2DIy7dEIXdH2+hEkUPkZLI+cEm
         sjrSdi1Hujmh2iQP4EgfdMo/oSOjF62Skq4X87DdEyU024Hrwfc2sAS8+3fT82oh1Wwu
         3gs7dreg/QAJc28dXaDuJE+qd2qsa7y4hIwUor9YoiJbQ8RJ8YBiSbmy1X9IlMT1Sesk
         +8Wg==
X-Gm-Message-State: AOAM5326ItZLSQNtCPeBOeIzABChZ5vSS/xN3mdsG943OgeRgRg81zkK
        hTK78dSwkHkjfsez2K04EsMTnQ==
X-Google-Smtp-Source: ABdhPJwoW1nC8CwsoiAcRDjUEwAq3FLPOf8WeO7J4R5TTOmsQ664cFp/eYXChsf5S/H73HJRyPqt9A==
X-Received: by 2002:a63:35c1:0:b0:386:3620:3c80 with SMTP id c184-20020a6335c1000000b0038636203c80mr4063284pga.327.1648603236862;
        Tue, 29 Mar 2022 18:20:36 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id a11-20020a63cd4b000000b00378b9167493sm17373638pgj.52.2022.03.29.18.20.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Mar 2022 18:20:36 -0700 (PDT)
Message-ID: <5bafff4a-e3f8-82eb-f8e8-486c877518ad@kernel.dk>
Date:   Tue, 29 Mar 2022 19:20:35 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH -next RFC 1/6] blk-mq: add a new flag
 'BLK_MQ_F_NO_TAG_PREEMPTION'
Content-Language: en-US
To:     "yukuai (C)" <yukuai3@huawei.com>,
        andriy.shevchenko@linux.intel.com, john.garry@huawei.com,
        ming.lei@redhat.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
References: <20220329094048.2107094-1-yukuai3@huawei.com>
 <20220329094048.2107094-2-yukuai3@huawei.com>
 <190625d8-ed84-f657-6058-2d151f6d4caa@kernel.dk>
 <f83ea9d7-bc89-6855-f9a6-c42f4647d383@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <f83ea9d7-bc89-6855-f9a6-c42f4647d383@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/29/22 7:18 PM, yukuai (C) wrote:
> On 2022/03/29 20:44, Jens Axboe wrote:
>> On 3/29/22 3:40 AM, Yu Kuai wrote:
>>> Tag preemption is the default behaviour, specifically blk_mq_get_tag()
>>> will try to get tag unconditionally, which means a new io can preempt tag
>>> even if there are lots of ios that are waiting for tags.
>>>
>>> This patch introduce a new flag, prepare to disable such behaviour, in
>>> order to optimize io performance for large random io for HHD.
>>
>> Not sure why we need a flag for this behavior. Does it ever make sense
>> to allow preempting waiters, jumping the queue?
>>
> 
> Hi,
> 
> I was thinking using the flag to control the new behavior, in order to
> reduce the impact on general path.
> 
> If wake up path is handled properly, I think it's ok to disable
> preempting tags.

If we hit tag starvation, we are by definition out of the fast path.
That doesn't mean that scalability should drop to the floor, something
that often happened before blk-mq and without the rolling wakeups. But
it does mean that we can throw a bit more smarts at it, if it improves
fairness/performance in that situation.

-- 
Jens Axboe

