Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1B01C433F5
	for <linux-block@archiver.kernel.org>; Wed, 20 Oct 2021 12:21:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC97A6137B
	for <linux-block@archiver.kernel.org>; Wed, 20 Oct 2021 12:21:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbhJTMXO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Oct 2021 08:23:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbhJTMXM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Oct 2021 08:23:12 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B579C06161C
        for <linux-block@vger.kernel.org>; Wed, 20 Oct 2021 05:20:58 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id u8-20020a05600c440800b0030d90076dabso4869637wmn.1
        for <linux-block@vger.kernel.org>; Wed, 20 Oct 2021 05:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=uJXdHRroZoGca13LwnSQqTmo7KsyuT4yiPKl3WRr248=;
        b=KPal+JItbDt/qZMWg4cYpRBEw5GmDy0fLPDw0+mZM8sU7UcpDZ0RUitHtaXX8BMZ7m
         jdeiCzU3sVElMU2PnLUmRGP5dxddcj45a1v+u35BBshy1WaskLSLM1+TKyIqz3Nh4hCC
         HOex39JvmDL7R6668RvccDE0y2yCLWSL542/2k1mxjSoS/ipn+X5WrENwbahHAOKAPeN
         E2BkU5kD+zjZZKAf9EnxXtlyv54mjORIOU+l2k4SHNjtTvF0N4R7R1CMau64RJl9Yszk
         /t0F3igBOFPw3IYWDqi/79LBYU1DHtbpZJMKNsZ+fm5yCar3R+HMDe2NSYbuzCbolqaF
         WJNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=uJXdHRroZoGca13LwnSQqTmo7KsyuT4yiPKl3WRr248=;
        b=O1OeQ/vVhc8Vrausih1XYmRrfGyy2GSHS78R4gnJXSr7EP01nhe8SkrLOEHmVCMkDg
         jjhfmE/utp9+YGtCVIqkPn1rM4m80e3s9CfZqKd1g3hS0KybAilwyomjBrAMLx7Mx3Sj
         W0+NKN8GWay5Kc23F89+UNqEDk5dZPhTBld2fmzK4Gj437mCirm+PI8pJySyzybakcwF
         51SJOywk1c1XRuBFPPLPwqwBFEegmO4xezvg+jELf+t93TIIJtjqZAQunIpAJq21fyct
         567GpQNgLZD1BKSn6SnuO+d4o/DpHepiySLcdNHoq0EmTxZarQ5qLEhgM+YXFTakl7e6
         CJDQ==
X-Gm-Message-State: AOAM531QzEX5wIyM/TRo4Q+9CVy0cf2cAtH2gwhdQ6lnAb1ZFHS3DeRN
        XGh9FjjNM8ynM062SHZmtJ9q4VfvBSQ=
X-Google-Smtp-Source: ABdhPJwOfW2XRW3q5NlMp3gso6UFSuYfHF4bB+UFrm64nTJ+nrCqID4myy1CP8DnF6VWBDWwSHvzUA==
X-Received: by 2002:a5d:4d0f:: with SMTP id z15mr52260503wrt.334.1634732456969;
        Wed, 20 Oct 2021 05:20:56 -0700 (PDT)
Received: from [192.168.43.77] (82-132-229-137.dab.02.net. [82.132.229.137])
        by smtp.gmail.com with ESMTPSA id u10sm1668014wrs.5.2021.10.20.05.20.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Oct 2021 05:20:56 -0700 (PDT)
Message-ID: <a00b2f44-e3e3-bf42-98a3-044423f17176@gmail.com>
Date:   Wed, 20 Oct 2021 13:20:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 06/16] block: clean up blk_mq_submit_bio() merging
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
References: <cover.1634676157.git.asml.silence@gmail.com>
 <4772d0d2111972ed5db4bc667e68e7416f809b57.1634676157.git.asml.silence@gmail.com>
 <YW+0Pf9jBG5JtjQY@infradead.org>
From:   Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <YW+0Pf9jBG5JtjQY@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/20/21 07:16, Christoph Hellwig wrote:
> On Tue, Oct 19, 2021 at 10:24:15PM +0100, Pavel Begunkov wrote:
>> Combine blk_mq_sched_bio_merge() and blk_attempt_plug_merge() under a
>> common if, so we don't check it twice. Also honor bio_mergeable() for
>> blk_mq_sched_bio_merge().
>>
>> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
>> ---
>>   block/blk-mq-sched.c |  2 +-
>>   block/blk-mq-sched.h | 12 +-----------
>>   block/blk-mq.c       | 13 +++++++------
>>   3 files changed, 9 insertions(+), 18 deletions(-)
>>
[...]
>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>> index bab1fccda6ca..218bfaa98591 100644
>> --- a/block/blk-mq.c
>> +++ b/block/blk-mq.c
>> @@ -2482,12 +2482,13 @@ void blk_mq_submit_bio(struct bio *bio)
>>   	if (!bio_integrity_prep(bio))
>>   		goto queue_exit;
>>   
>> -	if (!is_flush_fua && !blk_queue_nomerges(q) &&
>> -	    blk_attempt_plug_merge(q, bio, nr_segs, &same_queue_rq))
>> -		goto queue_exit;
>> -
>> -	if (blk_mq_sched_bio_merge(q, bio, nr_segs))
>> -		goto queue_exit;
>> +	if (!blk_queue_nomerges(q) && bio_mergeable(bio)) {
> 
> bio_mergeable just checks REQ_NOMERGE_FLAGS, which includes
> REQ_PREFLUSH and REQ_FUA...
> 
>> +		if (!is_flush_fua &&
> 
> ... so this is not needed.

Missed it, thanks. I also need to update the message then

-- 
Pavel Begunkov
