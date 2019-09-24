Return-Path: <SRS0=56XS=XT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03417C432C1
	for <linux-block@archiver.kernel.org>; Tue, 24 Sep 2019 11:16:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCC9620872
	for <linux-block@archiver.kernel.org>; Tue, 24 Sep 2019 11:16:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="DM/bGaSF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409595AbfIXLQC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 24 Sep 2019 07:16:02 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45073 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409582AbfIXLQC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Sep 2019 07:16:02 -0400
Received: by mail-pl1-f196.google.com with SMTP id u12so845957pls.12
        for <linux-block@vger.kernel.org>; Tue, 24 Sep 2019 04:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2Gdf6rrJ78JFoK3177iA9xPZfiz710O7xq5kze1mYLg=;
        b=DM/bGaSF9mTkDWPUrP+tKjpzReekozk0vkcwm/qn5A4/7oLsirebrYcD+OTSGmkuSv
         z2d9hoyqAZAfu/YYM9y+K5hvJTXv9gJjL1pRBixF2avzT5VnY1jIXwBbvSK2reOHj59m
         nlmHWqveukUqFqTXlo3lv7CpU5fN40GjlF4IO9jDoez0QDcBxlm+E9UJJx2jMVaqSAj8
         hLwTdGi8YYVcyOnXC61izqAfBVs5PGmi5NzDsNT32fP3UlQpieXAhWh2C4OV9j6r62hg
         ev22L1hfSXGb/4xi+7uKPUXX3TyIpnLlVnZxstl+QzepJeWBP/2MotvhO9sCUSKc4J5X
         lTfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2Gdf6rrJ78JFoK3177iA9xPZfiz710O7xq5kze1mYLg=;
        b=gUdTmjWUzE2E48FB3vRfMqeQD1MSUIzQ2IHxAXlEyxUqfo5P5Hq/OK4S+C+fIFlsng
         6RZemBrLEKZtxVszwl7q4F7UkKj7uqe/V12nyT4PJ/SwNjPGDROTYAtowqZtP6YRRMiz
         r2mIWpQlqHMGpx8/9URcbuEYZR82Zxj3Yo1lVW3JxOwRUGN2TQ1PEm3wpWA1/J4sycG9
         Sli/hO6oK1IikcGlCLjeOyzbHRX8k92bub8vZKFmMWE9aJhuO54nZldDFRGsGUbXzvNS
         UesMcbuxUYAh85y72UKCL6TSDZfAUZd+SsVOAr44qbnnCBeLx5AIvB8t7T1UevvxZsy0
         wQ1w==
X-Gm-Message-State: APjAAAV/BQ20P14ocC4QBXhYHd/9Lrt0LJucb8IaIyvD36lYCfC/fkmM
        ebGn70NIigNxAwDZ2Xm+/Ngy/A==
X-Google-Smtp-Source: APXvYqxwQZmXXwg08lPwE0Q+7ai01Po6hJAh0bDY6pnXE34tW+a5hjtWjo8g12BFudEkOz4yVBz/NA==
X-Received: by 2002:a17:902:8207:: with SMTP id x7mr2410456pln.147.1569323759815;
        Tue, 24 Sep 2019 04:15:59 -0700 (PDT)
Received: from ?IPv6:2600:380:8419:743e:a9a6:f93b:f300:79e6? ([2600:380:8419:743e:a9a6:f93b:f300:79e6])
        by smtp.gmail.com with ESMTPSA id v3sm2123221pfn.18.2019.09.24.04.15.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Sep 2019 04:15:58 -0700 (PDT)
Subject: Re: [PATCH v2 0/2] Optimise io_uring completion waiting
To:     Pavel Begunkov <asml.silence@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <a4996ae7-ac0a-447b-49b2-7e96275aad29@kernel.dk>
 <20190923083549.GA42487@gmail.com>
 <c15b2d54-c722-8fb4-266f-b589c1a21aa5@gmail.com>
 <df612e90-8999-0085-d2d6-4418e044e429@gmail.com>
 <731b2087-7786-5374-68ff-8cba42f0cd68@kernel.dk>
 <759b9b48-1de3-1d43-3e39-9c530bfffaa0@kernel.dk>
 <43244626-9cfd-0c0b-e7a1-878363712ef3@gmail.com>
 <f2608e3d-bb4e-9984-79e8-a2ab4f855c7f@kernel.dk>
 <b999490f-6138-b685-5472-5cd1843b747d@kernel.dk>
 <ed37058b-ee96-7d44-1dc7-d2c48e2ac23f@kernel.dk>
 <20190924094942.GN2349@hirez.programming.kicks-ass.net>
 <6f935fb9-6ebd-1df1-0cd0-69e34a16fa7e@kernel.dk>
 <29e6e06e-351f-c19d-ed7c-51f30c9ca887@kernel.dk>
 <08193e07-6f05-a496-492d-06ed8ce3aea1@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <da86ec56-5f14-536d-2d43-2cc9e118d2a7@kernel.dk>
Date:   Tue, 24 Sep 2019 13:15:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <08193e07-6f05-a496-492d-06ed8ce3aea1@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/24/19 5:11 AM, Pavel Begunkov wrote:
> On 24/09/2019 13:34, Jens Axboe wrote:
>> On 9/24/19 4:13 AM, Jens Axboe wrote:
>>> On 9/24/19 3:49 AM, Peter Zijlstra wrote:
>>>> On Tue, Sep 24, 2019 at 10:36:28AM +0200, Jens Axboe wrote:
>>>>
>>>>> +struct io_wait_queue {
>>>>> +	struct wait_queue_entry wq;
>>>>> +	struct io_ring_ctx *ctx;
>>>>> +	struct task_struct *task;
>>>>
>>>> wq.private is where the normal waitqueue stores the task pointer.
>>>>
>>>> (I'm going to rename that)
>>>
>>> If you do that, then we can just base the io_uring parts on that.
>>
>> Just took a quick look at it, and ran into block/kyber-iosched.c that
>> actually uses the private pointer for something that isn't a task
>> struct...
>>
> 
> Let reuse autoremove_wake_function anyway. Changed a bit your patch:

Yep that should do it, and saves 8 bytes of stack as well.

BTW, did you test my patch, this one or the previous? Just curious if it
worked for you.

-- 
Jens Axboe

