Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99333FA373D
	for <linux-block@archiver.kernel.org>; Fri, 28 Oct 2022 00:14:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234558AbiJ1AOV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Oct 2022 20:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233946AbiJ1AOU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Oct 2022 20:14:20 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A971283F02
        for <linux-block@vger.kernel.org>; Thu, 27 Oct 2022 17:14:19 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id a14so4877931wru.5
        for <linux-block@vger.kernel.org>; Thu, 27 Oct 2022 17:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LkE7PmsWczvMmIJynfDBE8Jc7uZP/t3eSZNH+Pk6MdM=;
        b=K7Rb4DbPzNfuH6MoPGa+AdguJfEEDLxBCU4khmsQmK+6CqEb5OvPV5kVR/iqM+vIPT
         HxYf0PGuOmaXN7FltjRqRDzknQrTKv7p0LpuSPYmINdofohj4DVBCUC529OHKOzd6EHJ
         eHPDuX/QQFcAd353Fr1xLeh1Z3djlAyzF+y7L3cHUa8jjkI0DC2PVJN38oRJqmMny/oV
         6l46sg7zrWR5pOXbC+A5vc7T7cBBVxcKTPkAL/rt6Gy8L3mt5OE3gYzOCAno2rvfNHqr
         5xpMvqARwhOGHiIRpQ+UvKI9eToIp0IImpIdrGDTh9kdUNgAymxC26FKFaoe3UpahBww
         swDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LkE7PmsWczvMmIJynfDBE8Jc7uZP/t3eSZNH+Pk6MdM=;
        b=wk8eiJxLoA4rn4FC2P6TDVo9FeCzrJMkeWD2t70h5Yx7hObD85BAU0fYQtWGwMNeJP
         D28A4mMDybRDaZuFuKqIy1stC38rMTxqZLQ3MolyQAUNCIMEBRWum6xZTJnMg+mtl7uC
         X52y1JMVwa00Dw+mQ1hmLGBML0INhEhriW7BI4R7akhWGn3C3b8N+T7Xt/Z+DxsRZX8Z
         Ut+I5ffjMRWJcSfcIlCsJ9a1GgyUoYxU9PD2WzBoKg4LeAyreQ5IG0pQXmiu3RjEXKez
         E4WDKH9HVkViq0N/9iCHeeijCxAPKhgucApAOygPE7ak/BDnNSQqIZCqpmZRP9DjWviU
         iFTw==
X-Gm-Message-State: ACrzQf0QZNOoQGasiHQ2Ky8Gz02LDCCk9Q6HJE8QKM5x4FpxhhS+arsW
        fWJryG+n6V7F53p5sS2w4W+44t5WgMQcCw==
X-Google-Smtp-Source: AMsMyM5aYCDcCujNawVkSXrr0ROHGSzMZtdBjw8Web+d+6rQ6o3FyWmNQNHH7KJTLNsD0lERE4d+Dw==
X-Received: by 2002:a5d:47c5:0:b0:22e:655e:f258 with SMTP id o5-20020a5d47c5000000b0022e655ef258mr31965256wrc.569.1666916058118;
        Thu, 27 Oct 2022 17:14:18 -0700 (PDT)
Received: from [10.10.42.20] (213-205-70-130.net.novis.pt. [213.205.70.130])
        by smtp.gmail.com with ESMTPSA id q22-20020a7bce96000000b003c6d21a19a0sm2912711wmj.29.2022.10.27.17.14.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Oct 2022 17:14:17 -0700 (PDT)
Message-ID: <6d882bc4-3c9d-ee4b-8a98-3ef61ed3201f@gmail.com>
Date:   Fri, 28 Oct 2022 01:13:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH for-6.1 0/2] iopoll bio pcpu cache fix
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
References: <cover.1666886282.git.asml.silence@gmail.com>
 <983a4fda-5e42-3a26-81f6-65e8cd343f8e@kernel.dk>
 <13b597a1-b955-ba52-aa1b-174d789a5d7b@kernel.dk>
Content-Language: en-US
From:   Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <13b597a1-b955-ba52-aa1b-174d789a5d7b@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/28/22 00:55, Jens Axboe wrote:
> On 10/27/22 5:27 PM, Jens Axboe wrote:
>> On 10/27/22 4:14 PM, Pavel Begunkov wrote:
>>> There are ways to deprive bioset mempool of requests using pcpu caches
>>> and never return them back, which breaks forward progress guarantees bioset
>>> tried to provide. Fix it.
>>>
>>> Pavel Begunkov (2):
>>>    mempool: introduce mempool_is_saturated
>>>    bio: don't rob bios from starving bioset
>>>
>>>   block/bio.c             | 2 ++
>>>   include/linux/mempool.h | 5 +++++
>>>   2 files changed, 7 insertions(+)
>>>
>>
>> This isn't really a concern for 6.1 and earlier, because the caching is
>> just for polled IO. Polled IO will not be grabbing any of the reserved
>> inflight units on the mempool side, which is what guarantees the forward
>> progress.

And after looking it up, apparently it can allocate from reserves.


>> It'll be a concern for the 6.2 irq based general caching, so it would
>> need to be handled there. So perhaps this can be a pre-series for a
>> reposting of that patchset.
> 
> Just a followup, since we had some out-of-band discussion. This is
> a potential concern on the bio side, though not on the request side.
> But this approach is racy, we'll figure something else out.

I agree that it _may_ be, but I can't think of an counter example
for arches w/ strong ordering and would need to think more if there
is an issue in the looser ephemeral world.

-- 
Pavel Begunkov
