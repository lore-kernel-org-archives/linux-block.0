Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C569C77B73
	for <linux-block@archiver.kernel.org>; Mon, 22 May 2023 02:05:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbjEVCFo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 21 May 2023 22:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjEVCFn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 21 May 2023 22:05:43 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D1FD2
        for <linux-block@vger.kernel.org>; Sun, 21 May 2023 19:05:40 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-64d2f3dd990so354590b3a.0
        for <linux-block@vger.kernel.org>; Sun, 21 May 2023 19:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1684721140; x=1687313140;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fk8kemxw14hojvcQacglyElAaqE/35OTatI/tXaiYKI=;
        b=FigHr6FRMss0u3zrHctIDVClRhk1Lk7vKgBGQXLy5RCghnw691HoDr4q5q8YwFmB00
         GKOFJFX6KZEqnNBxEk7jZixbZtZtKRTmwQx+i8ouNmSyyyPQnsfycxd6YSskNcEusI0S
         ozveiF0NUj/u2859ufAtg9Tb9WDgrnXDe7S8Jv+Rx4dMzJuMtb6+COqMkJ0Cjy+Vscyd
         R6v7CpYC/95n6P5W2wkY35MsUnNN9WjSF34ttmESXNc0QdZ312xW6oijsmOuhZUpGP3M
         F2k6fmSIb3Q/Cor7m+VYeNjKbFBG3WNkxHUxejkaU7HMhPQLWP021dDdQP+jLH5HLj6t
         j0qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684721140; x=1687313140;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fk8kemxw14hojvcQacglyElAaqE/35OTatI/tXaiYKI=;
        b=WpBoFjGfGi6kA19MVCYnUhMkxr6csnRGjaJEI2B/eduTKPSV+9pT9/oMV0giahqsri
         QY1IZcgubkXjB91wjFISxYaq7TsEDNakxxrQTc7BQ/pVwAA/m6MbKFtF1pTVSYx6sbhQ
         FUb++49xySDPpL3xjNlbmie2lPvp9YUAYR+qq3Tq91yPu1rMuvfT71NZpUabLS6ebCfo
         iWGIe9MWAKGDaBwsANZ74eof+2CIHiJrT/f6QA5NcVnLFzwYTRVdmD9vKoLYtf0u6PgE
         1KsEkawHZSzbcNLikCKNPpftQX+VhFN75HBUJbLSIsT1F3yvYc+Q4zaVDDWB8DAYaOwo
         bhnQ==
X-Gm-Message-State: AC+VfDw/t7abKVQenGTZoedT87z3UznS7+IOGdS2+QomiaxYg5OdsyLD
        cyzelmqWkPvYXheymtjYlrn7NA==
X-Google-Smtp-Source: ACHHUZ4qiHx4xllLkCiKRl29RaP4+ypCVcrn8UAbmnRidq7PM2iK7w/KE6CAl9frogvPbrkjyj/c+Q==
X-Received: by 2002:a05:6a20:1610:b0:f6:9492:93a6 with SMTP id l16-20020a056a20161000b000f6949293a6mr9726087pzj.4.1684721140168;
        Sun, 21 May 2023 19:05:40 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id j25-20020aa78dd9000000b0063f18ae1d84sm3052816pfr.202.2023.05.21.19.05.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 May 2023 19:05:39 -0700 (PDT)
Message-ID: <85a6ba06-d1ac-9d67-52f4-005c8ff6fbd7@kernel.dk>
Date:   Sun, 21 May 2023 20:05:38 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/1] blk-mq: fix race condition in active queue accounting
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>, Damien Le Moal <dlemoal@kernel.org>
Cc:     Tian Lan <tilan7663@gmail.com>, linux-block@vger.kernel.org,
        Tian Lan <tian.lan@twosigma.com>
References: <20230522004328.760024-1-tilan7663@gmail.com>
 <694813ca-690d-4852-0066-cee6833ad8c4@kernel.org>
 <ZGrEJRrZcjYtlMpV@ovpn-8-16.pek2.redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZGrEJRrZcjYtlMpV@ovpn-8-16.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/21/23 7:23?PM, Ming Lei wrote:
> On Mon, May 22, 2023 at 10:15:22AM +0900, Damien Le Moal wrote:
>> On 5/22/23 09:43, Tian Lan wrote:
>>> From: Tian Lan <tian.lan@twosigma.com>
>>>
>>> If multiple CPUs are sharing the same hardware queue, it can
>>> cause leak in the active queue counter tracking when __blk_mq_tag_busy()
>>> is executed simultaneously.
>>>
>>> Fixes: ee78ec1077d3 ("blk-mq: blk_mq_tag_busy is no need to return a value")
>>> Signed-off-by: Tian Lan <tian.lan@twosigma.com>
>>> ---
>>>  block/blk-mq-tag.c | 10 ++++++----
>>>  1 file changed, 6 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
>>> index d6af9d431dc6..07372032238a 100644
>>> --- a/block/blk-mq-tag.c
>>> +++ b/block/blk-mq-tag.c
>>> @@ -42,13 +42,15 @@ void __blk_mq_tag_busy(struct blk_mq_hw_ctx *hctx)
>>>  	if (blk_mq_is_shared_tags(hctx->flags)) {
>>>  		struct request_queue *q = hctx->queue;
>>>  
>>> -		if (test_bit(QUEUE_FLAG_HCTX_ACTIVE, &q->queue_flags))
>>> +		if (test_bit(QUEUE_FLAG_HCTX_ACTIVE, &q->queue_flags) ||
>>> +		    test_and_set_bit(QUEUE_FLAG_HCTX_ACTIVE, &q->queue_flags)) {
>>
>> This is weird. test_and_set_bit() returns the bit old value, so shouldn't this be:
>>
>> 		if (test_and_set_bit(QUEUE_FLAG_HCTX_ACTIVE, &q->queue_flags))
>> 			return;
>>
>> ?
> 
> It is one micro optimization since test_and_set_bit is much heavier
> than test_bit, so test_and_set_bit() is just needed in the 1st time.

It's an optimization, but it's certainly not a micro one. If the common
case is always hitting that, then test_and_set_bit() will repeatedly
dirty that cacheline. And obviously it's useless to do that if the bit
is already set. This makes it a pretty nice optimization and definitely
outside the realm of "micro optimization" as it can have quite a large
impact. I used that in various spots in blk-mq, which I suspect is where
the inspiration for this one came too.

-- 
Jens Axboe

