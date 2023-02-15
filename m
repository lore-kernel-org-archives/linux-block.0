Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B630DC636CC
	for <linux-block@archiver.kernel.org>; Wed, 15 Feb 2023 23:39:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbjBOXjo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Feb 2023 18:39:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjBOXjn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Feb 2023 18:39:43 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 866632E820
        for <linux-block@vger.kernel.org>; Wed, 15 Feb 2023 15:39:42 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id bt4-20020a17090af00400b002341621377cso4032182pjb.2
        for <linux-block@vger.kernel.org>; Wed, 15 Feb 2023 15:39:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1676504382;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O9o7UhOo7bTCDyYADxk9IKHNN7gMYX+EGR9EXQD6zLo=;
        b=2PdiYX/yLGcNk+6yiAdBIc9lRVlA1/HkOUL6hQwP0NG7tw1/bVZQrNk/gVPGQZ6byx
         JeLdmRCUKKM5HL3CbRzigaaCxH2Vv2L/etzJMjzbZCKoDJNfYQxoTcRuo9AzfiIzYHT8
         LZ3DVG0Vik7VKy98z8EM15RCVxt0ZDzNffWlfU3QnhL1x8iVzCirXbRnk07pxmHQFAl7
         X3yNPpKNae7r6ro03rUYH5ZBO8OrmiX8RhuDqrRBPFOYq1QnZlFN6z1u+sEvnEKH0r1y
         4VJv0mNpzk07obb53Q4r0AP8muhwZvewBVkZ3v5xMSvuzb9JbSaKVpRaO3jPy2aNRxwF
         jfZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676504382;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O9o7UhOo7bTCDyYADxk9IKHNN7gMYX+EGR9EXQD6zLo=;
        b=v78050Kt/4Q/Cs2mxA0y33zutvKmRa2eLWXuf35l70EPhi75u6O/tQmAh8wLilDefy
         FUM0gY/jIC30TRd7sguHpBya59i3qVhJUhDcX6F2K5Kefb3ircPRP0huVZYGrpYbZFb6
         5QmZRhGL6vh0o1sl7AMoR0Qz5TXAE7QWbBSaJLl3a3PW6Sh3iknn+8qsH6NZLITu6HoA
         zsBALsldtLjYpQ5AgDZ9P3PqaunuJufzP3fA7/utW9wAFxLtovuHqpa/ijj7C3qSSJOT
         t+5Ysenn1vXcJFzNm7pAZQv2zU+SOsGQINuky+o5Z93zcLwKRWtvleLt8cJZNhzDFNOp
         9abw==
X-Gm-Message-State: AO0yUKXTvLTOyPfPIeuGvZhjPW7oUGM0vKGTjCWYNxGIMLU1k9SsaIDt
        FUvAXvcM3sLhzTej0rXV2ksddYpttw4xa9gA
X-Google-Smtp-Source: AK7set/zJEFEHm1b5aybkvJXJu9VHnOtj/VezAy6tbjsu0/zdvs5Sz0aGhnNBX3165sh+SDWARygxQ==
X-Received: by 2002:a17:902:e80b:b0:19a:a2e7:64de with SMTP id u11-20020a170902e80b00b0019aa2e764demr4535597plg.0.1676504381899;
        Wed, 15 Feb 2023 15:39:41 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 13-20020a170902c20d00b0019aaba5c90bsm5373077pll.84.2023.02.15.15.39.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Feb 2023 15:39:41 -0800 (PST)
Message-ID: <61d93a99-ce94-f0ed-664a-e9d8784dc9a9@kernel.dk>
Date:   Wed, 15 Feb 2023 16:39:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH 0/1] improve brd performance with blk-mq
Content-Language: en-US
From:   Jens Axboe <axboe@kernel.dk>
To:     Pankaj Raghav <p.raghav@samsung.com>,
        Ming Lei <ming.lei@redhat.com>
Cc:     hch@lst.de, mcgrof@kernel.org, gost.dev@samsung.com,
        linux-block@vger.kernel.org
References: <CGME20230203103122eucas1p161c0f0b674d26e23cf38466d5415420e@eucas1p1.samsung.com>
 <20230203103005.31290-1-p.raghav@samsung.com> <Y+Gsu0PiXBIf8fFU@T590>
 <6035da22-5667-93d5-fe00-62b988425cb5@samsung.com> <Y+nwh7V5xehxMWDR@T590>
 <95506a88-c89c-0f41-3ab4-eb5741410c02@samsung.com>
 <7c28caf6-931e-0a7a-a3c0-e4a430f860ff@kernel.dk>
In-Reply-To: <7c28caf6-931e-0a7a-a3c0-e4a430f860ff@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/15/23 4:38?PM, Jens Axboe wrote:
> On 2/14/23 7:48?AM, Pankaj Raghav wrote:
>> Hi Ming,
>>
>> On 2023-02-13 13:40, Ming Lei wrote:
>>>>>
>>>>> Can you share perf data on other non-io_uring engine often used? The
>>>>> thing is that we still have lots of non-io_uring workloads, which can't
>>>>> be hurt now.
>>>>>
>>>> Sounds good. Does psync and libaio along with io_uring suffice?
>>>
>>> Yeah, it should be enough.
>>>
>>
>> Performance regression is noticed for libaio and psync. I did the same
>> tests on null_blk with bio and blk-mq backends, and noticed a similar pattern.
>>
>> Should we add a module parameter to switch between bio and blk-mq back-end
>> in brd, similar to null_blk? The default option would be bio to avoid
>> regression on existing workloads.
>>
>> There is a clear performance gain for some workloads with blk-mq support in
>> brd. Let me know your thoughts. See below the performance results.
>>
>> Results for brd with --direct enabled:
> 
> I think your numbers are skewed because brd isn't flagg nowait, can you
> try with this?
> 
> I ran some quick testing here, using the current tree:
> 
> 		without patch		with patch
> io_uring	~430K IOPS		~3.4M IOPS
> libaio		~895K IOPS		~895K IOPS
> 
> which is a pretty substantial difference...

And here's the actual patch. FWIW, this doesn't make a difference
for libaio, because aio doesn't really care if it blocks or not.

diff --git a/drivers/block/brd.c b/drivers/block/brd.c
index 20acc4a1fd6d..82419e345777 100644
--- a/drivers/block/brd.c
+++ b/drivers/block/brd.c
@@ -412,6 +412,7 @@ static int brd_alloc(int i)
 	/* Tell the block layer that this is not a rotational device */
 	blk_queue_flag_set(QUEUE_FLAG_NONROT, disk->queue);
 	blk_queue_flag_clear(QUEUE_FLAG_ADD_RANDOM, disk->queue);
+	blk_queue_flag_set(QUEUE_FLAG_NOWAIT, disk->queue);
 	err = add_disk(disk);
 	if (err)
 		goto out_cleanup_disk;

-- 
Jens Axboe

