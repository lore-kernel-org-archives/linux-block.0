Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B60AC77B7C
	for <linux-block@archiver.kernel.org>; Fri, 12 May 2023 16:11:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242056AbjELQLH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 12 May 2023 12:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242034AbjELQLD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 12 May 2023 12:11:03 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6B4C8A4D
        for <linux-block@vger.kernel.org>; Fri, 12 May 2023 09:10:57 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id ca18e2360f4ac-76c6e795650so20187939f.1
        for <linux-block@vger.kernel.org>; Fri, 12 May 2023 09:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1683907857; x=1686499857;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lHFuowi1N9Fd4KtxilPHoK6/RmOYtNwjvd8U7ZX2rQQ=;
        b=FkZVnzOGX6I1/zKB8n420HAsc6zN4P9CVpbEh57+p3Wqr7AZYO/hFoP4wAPu1V0izS
         LDU5C/f0ImYedPB3kbmBsbFaFzLjRpXGloXoEW+u3svD+/Z0AFj/Q3JvBkGP9qpcF/sB
         HoNCkx6+aKfNYH+/+ahszZX8RQUnorFZsuHLM7uiwDpvO9oVYs2y+is2idH0v/QTHrnS
         jUFqTMvI9FiRhjfpmlJnsiDHjl/g+T39+SWDT7Zt+X4FGg+8mVqhRkY16SwE/3dBYBtv
         grGIj+2Xj7SvHb9RPe057V4CLk+2ASrlOa3e4QBRUMqKfErjRBXJpH1cqrtHGL2B/Lvn
         Q3pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683907857; x=1686499857;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lHFuowi1N9Fd4KtxilPHoK6/RmOYtNwjvd8U7ZX2rQQ=;
        b=K50Xql4i2O6esvo6Q0o5Nb2ygS7AZStD1Z0u3xqQEppC3YoB0cZbqgtKQCjA7c5dkH
         ibq6zJ9GrAo2rMUhSQRjQ2YU/HBVhh/MkuFVcv9orrnn8QvIlHi1gOO4EiJTv2mTZPgc
         8J+znE8o0K3/p/ekgGdaZLX1r+yNfw3zmJZRn/g4MuNl/fqrPsw/5NN0UOFbtN8VtePy
         ALZzPEg5DMAHFnAszeFXyWl8X/M2L02vOahzIb6fxuGxk8lF6eBRwhjPBYquDP3K3Dq8
         dvR1qXt53O0OiVmlnipVHMubET94as6eEpqeLH+I4020Hi0AksZfVpH0UteZIdT9Jchx
         xbiw==
X-Gm-Message-State: AC+VfDyzKnuRPy6SOx3G2ipQnxK33o3pgmaYPctghucdcfJCiIlVXpEF
        tb6xTZ2FeIddzcRVpyFcerxi5QM6uoY0TLUhBQA=
X-Google-Smtp-Source: ACHHUZ70LjCoq4qUD78vZvFy8XrdBlQdoWEbfSPZS/X2MbhQyBUd/vtj6mvUz3vhVoQl7+8DXphUsQ==
X-Received: by 2002:a05:6e02:e0f:b0:331:3e65:6ac0 with SMTP id a15-20020a056e020e0f00b003313e656ac0mr10648504ilk.1.1683907856983;
        Fri, 12 May 2023 09:10:56 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id x11-20020a92dc4b000000b00322fd960361sm4913215ilq.53.2023.05.12.09.10.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 May 2023 09:10:56 -0700 (PDT)
Message-ID: <f7618ff1-3122-aa64-50a9-2f48f7dd6359@kernel.dk>
Date:   Fri, 12 May 2023 10:10:55 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] blk-mq: don't queue passthrough request into scheduler
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, Guangwu Zhang <guazhang@redhat.com>,
        Yu Kuai <yukuai1@huaweicloud.com>
References: <20230512150328.192908-1-ming.lei@redhat.com>
 <70478f95-2852-9bf1-f8f7-630c74641c0f@kernel.dk>
 <ZF5ZB7QWPCF0ZKWN@ovpn-8-16.pek2.redhat.com>
 <b745f17b-088c-a72c-00f2-3c0a13cdead5@kernel.dk>
 <ZF5co5g2XLIw82DK@ovpn-8-16.pek2.redhat.com>
 <ca934bc6-651a-6c96-0598-105cd4a0b500@kernel.dk>
 <ZF5hbgvCyyVWRZPJ@ovpn-8-16.pek2.redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZF5hbgvCyyVWRZPJ@ovpn-8-16.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/12/23 9:55?AM, Ming Lei wrote:
> On Fri, May 12, 2023 at 09:43:32AM -0600, Jens Axboe wrote:
>> On 5/12/23 9:34?AM, Ming Lei wrote:
>>> On Fri, May 12, 2023 at 09:25:18AM -0600, Jens Axboe wrote:
>>>> On 5/12/23 9:19?AM, Ming Lei wrote:
>>>>> On Fri, May 12, 2023 at 09:08:54AM -0600, Jens Axboe wrote:
>>>>>> On 5/12/23 9:03?AM, Ming Lei wrote:
>>>>>>> Passthrough(pt) request shouldn't be queued to scheduler, especially some
>>>>>>> schedulers(such as bfq) supposes that req->bio is always available and
>>>>>>> blk-cgroup can be retrieved via bio.
>>>>>>>
>>>>>>> Sometimes pt request could be part of error handling, so it is better to always
>>>>>>> queue it into hctx->dispatch directly.
>>>>>>>
>>>>>>> Fix this issue by queuing pt request from plug list to hctx->dispatch
>>>>>>> directly.
>>>>>>
>>>>>> Why not just add the check to the BFQ insertion? That would be a lot
>>>>>> more trivial and would not be poluting the core with this stuff.
>>>>>
>>>>> pt request is supposed to be issued to device directly, and we never
>>>>> queue it to scheduler before 1c2d2fff6dc0 ("block: wire-up support for
>>>>> passthrough plugging").
>>>>>
>>>>> some pt request might be part of error handling, and adding it to
>>>>> scheduler could cause io hang.
>>>>
>>>> I'm not suggesting adding it to the scheduler, just having the bypass
>>>> "add to dispatch" in a different spot.
>>>
>>> Originally it is added to dispatch in blk_execute_rq_nowait() for each
>>> request, but now we support plug for pt request, that is why I add the
>>> bypass in blk_mq_dispatch_plug_list(), and just grab lock for each batch
>>> given now blk_execute_rq_nowait() is fast path for nvme uring pt io feature.
>>
>> We really have two types of passthrough - normal kind of IO, and
>> potential error recovery etc IO. The former can plug just fine, and I
>> don't think we should treat it differently. Might make more sense to
>> just bypass plugging for error handling type of IO, or pt that doesn't
>> transfer any data to avoid having a NULL bio inserted into the
>> scheduler.
> 
> So far, I guess we can't distinguish the two types.

Right, and that seems to be the real problem here. What is true for any
pt request is that normal sorting by sector doesn't work, but it really
would be nice to distinguish the two for other reasons. Eg "true" pt
error handling should definitely just go to the dispatch list, and we
don't need to apply any batching etc for them. For uring_cmd based
passthrough, we most certainly should.

> The simplest change could be the previous one[1] by not plugging request
> of !rq->bio, but pt request with user IO still can be added to
> scheduler, so the question is if pt request with user IO should be
> queued to scheduler?

I'm fine bypassing the scheduler insertion for that, my main objection
to your original patch is that it's a bit messy and I was hoping we
could do a cleaner separation earlier. But I _think_ that'd get us into
full logic bypass for pt, which again then would not be ideal for
performance oriented pt.

-- 
Jens Axboe

