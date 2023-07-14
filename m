Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81114EB64DC
	for <linux-block@archiver.kernel.org>; Fri, 14 Jul 2023 14:43:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236128AbjGNOnx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 14 Jul 2023 10:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235136AbjGNOnv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Jul 2023 10:43:51 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36943134
        for <linux-block@vger.kernel.org>; Fri, 14 Jul 2023 07:43:50 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id ca18e2360f4ac-785ccd731a7so25724439f.0
        for <linux-block@vger.kernel.org>; Fri, 14 Jul 2023 07:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1689345829; x=1689950629;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dejGPXZJlM5BRQ/HIVPGPhqt4ApF8pZ0rT01yr91iIw=;
        b=y/tNTa4Th1EFRh9TixEREZnCULKHa33ztPlS01n895a9dpcF9hEhV43/TT1GYzmQyg
         UaqdB6LfKlrdiG+Q4PURAT5ZPDWEEBsglsuq7n9oOvbMz3eib6NVME7JMq8aL3XeVhzj
         VH+iBjOJzhhntewVqP+U6TshPE7SXP3rhCUToTn6aXPmbpaILU1zg/V8jOwZLsNVetJV
         5OzC7wT0Evz2eVMdOw8Lk2kqUuAec9eaY8B3xVbODA/KxGqfP0kz5loUBjLxsJy54ecc
         FZ8jMlZqeMajFNf2qOcM4B8iYGGzBXQu8l1LaG1aYBy/ltLaAp2DrQkPxjtzLot7yY0P
         Jqyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689345829; x=1689950629;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dejGPXZJlM5BRQ/HIVPGPhqt4ApF8pZ0rT01yr91iIw=;
        b=UGGqQMGmDex/H/GSBCFwO4h6+Lpyx9npzJCBbW+bRV+boJ1h4QcdDSw1Or+BtqDL7P
         oF/+hL7ZP938Az20g4tdbqOjYgE/GZIS6F2UC9HQ7o5xndRjyu8jpA9V5Z9dciS8v/xe
         pDxkUcJiPVdxWD1Y1d2xHBiOt6OKbZILYF/tDJb50uStzQwT85lEJETHXqSD2s+JFjBI
         WeCn2BjCVpm3wtBW9/Cb25PRfk3pdWWjNfiJQoS0xg7XRDixVmub8vpnVFh7r+8CpRlX
         CU5wCde4s+IZCzCEDpX9o1qY+CjL0yyJliX3+EWEYNmVjVaIRuw1izwxxbWoj5uN5R8I
         eCIQ==
X-Gm-Message-State: ABy/qLY1q33geSRsjSEFiyJ+ju2nFNQkgko7IRAoZvjl+3WLiV1W89GY
        bx7QEL2gMdOyHQnZU0RPblAvpS3Zu7fQynywdYs=
X-Google-Smtp-Source: APBJJlGA6FB5rzPdcD74UYx5gxzH9yM5f7+DG4L5VYl2S7TJRitIUfehrcJVV9Dt2M+t4chhZDozaw==
X-Received: by 2002:a6b:b7c1:0:b0:783:6ec1:65f6 with SMTP id h184-20020a6bb7c1000000b007836ec165f6mr4498550iof.1.1689345829556;
        Fri, 14 Jul 2023 07:43:49 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 25-20020a05660220d900b00783581fd200sm2678915ioz.20.2023.07.14.07.43.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jul 2023 07:43:49 -0700 (PDT)
Message-ID: <4dc89f6c-ab93-d3e7-5b5a-4b2f34e2fcac@kernel.dk>
Date:   Fri, 14 Jul 2023 08:43:48 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v5] blk-mq: fix start_time_ns and alloc_time_ns for
 pre-allocated rq
Content-Language: en-US
To:     Chengming Zhou <chengming.zhou@linux.dev>,
        Tejun Heo <tj@kernel.org>
Cc:     hch@lst.de, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, ming.lei@redhat.com,
        zhouchengming@bytedance.com
References: <20230710105516.2053478-1-chengming.zhou@linux.dev>
 <aa813164-9a6a-53bd-405b-ba4cc1f1b656@kernel.dk>
 <63f93f1c-98da-4c09-b3d8-711f6953d8b7@linux.dev>
 <ZLA7QAfSojxu_FMW@slm.duckdns.org>
 <5be1cba6-b141-3a05-f801-3af7d2092674@linux.dev>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <5be1cba6-b141-3a05-f801-3af7d2092674@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/14/23 5:31?AM, Chengming Zhou wrote:
> On 2023/7/14 01:58, Tejun Heo wrote:
>> Hello,
>>
>> On Thu, Jul 13, 2023 at 08:25:50PM +0800, Chengming Zhou wrote:
>>> Ok, this version will only get time stamp once for one request, it's actually
>>> not worse than the current code, which will get start time stamp once for each
>>> request even in the batch allocation.
>>>
>>> But yes, maybe we can also set the start time stamp in the batch mode, and only
>>> update the time stamp in the block case, like you said, has better performance.
>>>
>>> The first version [1] I posted actually just did this, in which use a nr_flush counter
>>> in plug to indicate that we blocked & flushed plug. Tejun and I think it seems fragile.
>>> So go to this way that only set time stamp once when the request actually used.
>>>
>>> [1] https://lore.kernel.org/all/20230601053919.3639954-1-chengming.zhou@linux.dev/
>>>
>>> Another way I can think of is to make rq_qos_throttle() return a bool to indicate
>>> if it blocked. Tejun and Jens, how do you think about this way?
>>>
>>> Although it's better performance, in case of preemption, the time stamp maybe not accurate.
>>
>> Trying to manually optimized timestamp reads seems like a bit of fool's
>> errand to me. I don't think anyone cares about nanosec accuracy, so there
>> are ample opportunities for generically caching timestamp so that we don't
>> have to contort code to optimzie timestamp calls.
>>
>> It's a bit out of scope for this patchset but I think it might make sense to
>> build a timestamp caching infrastructure. The cached timestamp can be
>> invalidated on context switches (block layer already hooks into them) and
>> issue and other path boundaries (e.g. at the end of plug flush).
>>
> 
> Yes, this is a really great idea. It has better performance and is
> more generic.

Do you want to work on that approach? I pretty much outlined how I think
it'd work in the previous reply.

-- 
Jens Axboe

