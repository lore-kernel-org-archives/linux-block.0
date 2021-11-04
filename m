Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 751B5C433EF
	for <linux-block@archiver.kernel.org>; Thu,  4 Nov 2021 18:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E0226112E
	for <linux-block@archiver.kernel.org>; Thu,  4 Nov 2021 18:40:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234086AbhKDSm6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Nov 2021 14:42:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234064AbhKDSm5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 Nov 2021 14:42:57 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C76CC061714
        for <linux-block@vger.kernel.org>; Thu,  4 Nov 2021 11:40:19 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id p11-20020a9d4e0b000000b0055a5741bff7so9561566otf.2
        for <linux-block@vger.kernel.org>; Thu, 04 Nov 2021 11:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pbtT70uML7oLq7GpPqusK4gTNHw0KJdcIfjJKMo7UM4=;
        b=5brD3TIh+Or3lfu/4xK2g09xw8VDzf+TLWPsjbrgIbIzv46ve75xYxAUTLjqQkKa9M
         wdKp7QomGuJJbYh9qK0qEIyWYQxdRRHiA9o12FUPV2u1FarSS1DE1G/ALw+i/1pMXczT
         2mEz/Z1CxSyPTUKclhh7VImyk+SFffQuidPiVUn/5Sa1T2ZRoiNl+DB4cWHdJC3qdFTs
         9kci9ieHm775qHP8RAfvZhl6jsJZksY+VBUZ/D2sg7zmHT7xx2urm8jh5LsKKtkh2heR
         WgB2nH4lcrzawfyElLT0NWkfoiJGI74p05Ko7+QfJ0tcYxTMl4VMRy8G42QaHbHn+u76
         Ep2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pbtT70uML7oLq7GpPqusK4gTNHw0KJdcIfjJKMo7UM4=;
        b=gpcKWRGeQuCbDvBhUhkOZ6yonS2GF/TID9HRmxphnl9gjLe2gr0QDI0dDkejwcdaaw
         k8WEuh4KIGizZGNp6N61t9U7PmLXEMLsXL6TGXdpkbrCVYK31UxvKlLKddOypWuUNhUx
         q9FvVqKSeafGucGCKqvfdTqsez5UAImjapJhkQ2/82TpooAm688bHvQex4+jDmyDx4wD
         dJC6xGRzq12bTgn2TpCDVggKL6fMjaMtzPPyCWrpB+FjC4IwYR7viTzaTJ2aBv3yqSTF
         IAnMzIsgXhuhbPPkqEDgqGUE5IEh7G/YX2uhMltX1qAN8KjHmg6X2fVdINtm9gBrWkRM
         YPUA==
X-Gm-Message-State: AOAM532xbpic5FMhYj1bTFAPJTx8eGSuW1VdGynCDsOFHIVOD7YsWY3d
        4FngUs4XpQ/rimJ5FWyKHl1r3HhgsSKVmg==
X-Google-Smtp-Source: ABdhPJxl2B2RWp3Jy97bZxaM4atRRKkiQYMpkWy7HYxkgvl2Z/C/vQB48Mod6U9ijHRaN/aUPcJI+w==
X-Received: by 2002:a9d:70c9:: with SMTP id w9mr38550046otj.243.1636051218135;
        Thu, 04 Nov 2021 11:40:18 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id f25sm370200oog.44.2021.11.04.11.40.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Nov 2021 11:40:17 -0700 (PDT)
Subject: Re: [PATCH 4/5] block: move queue enter logic into
 blk_mq_submit_bio()
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org
References: <20211104182201.83906-1-axboe@kernel.dk>
 <20211104182201.83906-5-axboe@kernel.dk> <YYQoLzMn7+s9hxpX@infradead.org>
 <2865c289-7014-2250-0f5b-a9ed8770d0ec@kernel.dk>
 <YYQo4ougXZvgv11X@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <8c6163f4-0c0f-5254-5f79-9074f5a73cfe@kernel.dk>
Date:   Thu, 4 Nov 2021 12:40:17 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YYQo4ougXZvgv11X@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/4/21 12:39 PM, Christoph Hellwig wrote:
> On Thu, Nov 04, 2021 at 12:37:25PM -0600, Jens Axboe wrote:
>> On 11/4/21 12:36 PM, Christoph Hellwig wrote:
>>>> +static inline bool blk_mq_queue_enter(struct request_queue *q, struct bio *bio)
>>>> +{
>>>> +	if (!blk_try_enter_queue(q, false) && bio_queue_enter(bio))
>>>> +		return false;
>>>> +	return true;
>>>> +}
>>>
>>> Didn't we just agree on splitting bio_queue_enter into an inline helper
>>> and an out of line slowpath instead?
>>
>> See cover letter, and I also added to the commit message of this one. I do
>> think this approach is better, as bio_queue_enter() itself is just slow
>> path and there's no point polluting the code with 90% of what's in there.
>>
>> Hence I kept it as-is.
> 
> Well, let me reword this then:  why do you think the above is
> blk-mq secific and should not be used by every other caller of
> bio_queue_enter as well?  In other words, why not rename
> bio_queue_enter __bio_queue_enter and make the above the public
> bio_queue_enter interface then?

OK, that I can agree too. I'll respin it as such. Gets the job done as
well.

-- 
Jens Axboe

