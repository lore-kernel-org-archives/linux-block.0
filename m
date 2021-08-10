Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11A61C4320E
	for <linux-block@archiver.kernel.org>; Tue, 10 Aug 2021 14:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E05F560F41
	for <linux-block@archiver.kernel.org>; Tue, 10 Aug 2021 14:51:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242229AbhHJOvL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 10 Aug 2021 10:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241716AbhHJOtS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Aug 2021 10:49:18 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9D3AC0613D3
        for <linux-block@vger.kernel.org>; Tue, 10 Aug 2021 07:48:40 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id a5so5646517plh.5
        for <linux-block@vger.kernel.org>; Tue, 10 Aug 2021 07:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=D7b0H/WI2oJ3v/Z3U82xDpo/pUUk6BOu/D4wZSYWfJI=;
        b=ruhUrdhbeRv1BCcwEegnma6exIMv5ambqQIbor9NofU/pQxrqV4Lp4Fz/ZHRbHJrB+
         Wr3LTU8nS9Q3foE80dHnSOv6ofHSloKvFBE01ptbqxHF1GCIQLpVo7ceVp5ueYSegQD8
         gCqXbj9iYGxhDuiLBgrBwqsnbnO29z5LL/q9VkdxfAp/DJGSxPANU/PdVrQ+BA+gAHfG
         RFq51lPPdoZ4G/uo6gs9R/UzutpzUCtQ10IdgjZ7GFA8x2T/CR1/XMu/mheuaQ4llXkR
         4JmPrbb9b3AOAvNTEpP8VCAEcUByM4cCJas/5J2da9tZM4AUCxXBiEMjmQDEFpQMjtD8
         cKBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=D7b0H/WI2oJ3v/Z3U82xDpo/pUUk6BOu/D4wZSYWfJI=;
        b=Bfa6QI5ghsjHElg7TBAjtpESo5WnMZVePtIBuWmpySwxuJ+v9YJexd26BbygtMn+Nr
         LmhMLKujY+T10lbxCRZ5y2Nr755K2ESmNdal+J0R5lpPOBA0+EgO3eKicDSuxQH5TOBl
         C9RHPzWOO5KX4hq1Nx45xQIOpdTFcTj3UHdOgObO3NRfkha2jBX7IJh9hv2YpFy/cjxz
         syXiHv5u97kcyxp6DD90chrot2y+KZY3aMcRXCKTgPc7LWaSRHrpIUQIKJn55eCXLG2L
         7OUCbPFnJYqG8hfHOXMOQBSQ5+LmYpx1OpgSyR++obd61u5sc+Zg5gY1JNAu6VPJn4Wj
         d0fQ==
X-Gm-Message-State: AOAM533AzEuLI1uWJnSPoWC4HqOY3ezvE+VwaSKFG6VVpwf5CZo6ljzo
        jFLT6nwW04ZuSnKWRZOt9YZXcX4KzGnmxqs7
X-Google-Smtp-Source: ABdhPJwksFrQV1HSSbVL7IsIXtXscoa/fFeQJAFYGPMmNWU4tlHgsY3YYCDr7XhZlpJ+hh4Hr8xypQ==
X-Received: by 2002:a17:90a:65cc:: with SMTP id i12mr32099059pjs.36.1628606920039;
        Tue, 10 Aug 2021 07:48:40 -0700 (PDT)
Received: from [192.168.1.116] ([198.8.77.61])
        by smtp.gmail.com with ESMTPSA id u18sm15839648pfg.25.2021.08.10.07.48.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Aug 2021 07:48:39 -0700 (PDT)
Subject: Re: [PATCH 1/4] bio: add allocation cache abstraction
From:   Jens Axboe <axboe@kernel.dk>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     io-uring@vger.kernel.org, linux-block@vger.kernel.org
References: <20210809212401.19807-1-axboe@kernel.dk>
 <20210809212401.19807-2-axboe@kernel.dk> <YRJ74uUkGfXjR52l@T590>
 <79511eac-d5f2-2be3-f12c-7e296d9f1a76@kernel.dk>
 <6c06ac42-bda4-cef6-6b8e-7c96eeeeec47@kernel.dk>
Message-ID: <6f57bfcd-a080-8f3e-63c7-ab40296390a6@kernel.dk>
Date:   Tue, 10 Aug 2021 08:48:38 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <6c06ac42-bda4-cef6-6b8e-7c96eeeeec47@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/10/21 8:24 AM, Jens Axboe wrote:
> On 8/10/21 7:53 AM, Jens Axboe wrote:
>> On 8/10/21 7:15 AM, Ming Lei wrote:
>>> Hi Jens,
>>>
>>> On Mon, Aug 09, 2021 at 03:23:58PM -0600, Jens Axboe wrote:
>>>> Add a set of helpers that can encapsulate bio allocations, reusing them
>>>> as needed. Caller must provide the necessary locking, if any is needed.
>>>> The primary intended use case is polled IO from io_uring, which will not
>>>> need any external locking.
>>>>
>>>> Very simple - keeps a count of bio's in the cache, and maintains a max
>>>> of 512 with a slack of 64. If we get above max + slack, we drop slack
>>>> number of bio's.
>>>>
>>>> The cache is intended to be per-task, and the user will need to supply
>>>> the storage for it. As io_uring will be the only user right now, provide
>>>> a hook that returns the cache there. Stub it out as NULL initially.
>>>
>>> Is it possible for user space to submit & poll IO from different io_uring
>>> tasks?
>>>
>>> Then one bio may be allocated from bio cache of the submission task, and
>>> freed to cache of the poll task?
>>
>> Yes that is possible, and yes that would not benefit from this cache
>> at all. The previous version would work just fine with that, as the
>> cache is just under the ring lock and hence you can share it between
>> tasks.
>>
>> I wonder if the niftier solution here is to retain the cache in the
>> ring still, yet have the pointer be per-task. So basically the setup
>> that this version does, except we store the cache itself in the ring.
>> I'll give that a whirl, should be a minor change, and it'll work per
>> ring instead then like before.
> 
> That won't work, as we'd have to do a ctx lookup (which would defeat the
> purpose), and we don't even have anything to key off of at that point...
> 
> The current approach seems like the only viable one, or adding a member
> to kiocb so we can pass in the cache in question. The latter did work
> just fine, but I really dislike the fact that it's growing the kiocb to
> more than a cacheline.

One potential way around this is to store the bio cache pointer in the
iov_iter. Each consumer will setup a new struct to hold the bio etc, so
we can continue storing it in there and have it for completion as well.

Upside of that is that we retain the per-ring cache, instead of
per-task, and iov_iter has room to hold the pointer without getting near
the cacheline size yet.

The downside is that it's kind of odd to store it in the iov_iter, and
I'm sure that Al would hate it. Does seem like the best option though,
in terms of getting the storage for the cache "for free".

-- 
Jens Axboe

