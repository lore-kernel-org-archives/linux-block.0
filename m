Return-Path: <SRS0=0s1t=YC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFB19C4360C
	for <linux-block@archiver.kernel.org>; Wed,  9 Oct 2019 02:54:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFB9B20859
	for <linux-block@archiver.kernel.org>; Wed,  9 Oct 2019 02:54:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="QszbxjMP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729734AbfJICyo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Oct 2019 22:54:44 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33778 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726490AbfJICyn (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Oct 2019 22:54:43 -0400
Received: by mail-pf1-f193.google.com with SMTP id q10so638038pfl.0
        for <linux-block@vger.kernel.org>; Tue, 08 Oct 2019 19:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=aAug75V7sXllLnHgZ5CCYBYO9dt8RE+I/rj5oKotaPY=;
        b=QszbxjMPmr3p3n5L6OHNxCtKiobxczj4dLZiltQUwboe309N5tUp4lLvWywf8GN8tz
         Kb+jqJNMy3gGn2aTFQ0Nrb1T2fnqsqzlOhF1FLjBReHF0DXtacNc0/f7Bt7TNW9/+5fX
         Ggsj4zOjcX6igciC1dBqWloa6oNbUYW5PGtrlj2UA02bF6NKAM4aNFHfPn6t2sMYJkCO
         pHLZ8qNr42Io4oIG+cSXzs9st8jJf3Y6Bv/P8swTnMtAVC23nmNYRgTq59uRrihaQyvS
         364Zbbf6/9spSLPGZ8Ht/77XUsY3fmsdIkcsHI39RYRXPpoVz0/+OxqNCni+0oqhCHVG
         vQnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aAug75V7sXllLnHgZ5CCYBYO9dt8RE+I/rj5oKotaPY=;
        b=TKF9KeNS26L0fxh19oRyq2xI7rSMyi5DipnSUl/uY0taIJEk95tt2MPaAMF5fFgFIb
         uu6ScpWQsR6g9OLvld9BB6lKss/gjmfGk5vtKekivNSFFhhWDdp/cc4/JSukGROXdfej
         0bwrB2Ms8fgQ56gpoT7daNoJIwi1o/wyBTd8Scuz+gw1Ps0QTmu2hDV9lDyomL2bgiHV
         FQ/2Eh2vcQF32q2DNndnchvnG6+sAuBB1L7LFkHRzW6DnbYu6D54aIO2mrEQYLizhSa7
         XYe2jlEEbZu3srQHHgVLIWJ8Oun5efQev2Xix0dwC5b4PR65RM6wSU+cHB8TUEFrm85W
         ouuQ==
X-Gm-Message-State: APjAAAWsO8PqNe+xHFe/htwgWbUMbLhViYAs6zjO530qQtSkDx/pDyRO
        0xK0MFEPgJdAjytkCVBmZbgXew==
X-Google-Smtp-Source: APXvYqwHKEOgIQIln3eLIO81SIgsLyShBjX0nD7O0h2CW/+7Poo4XZw/acErNtYIAS0Bt4cI7Of3ww==
X-Received: by 2002:a17:90a:8c02:: with SMTP id a2mr1329170pjo.79.1570589682713;
        Tue, 08 Oct 2019 19:54:42 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id z13sm452971pfg.172.2019.10.08.19.54.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Oct 2019 19:54:41 -0700 (PDT)
Subject: Re: [PATCH] io_uring: remove wait loop spurious wakeups
To:     Pavel Begunkov <asml.silence@gmail.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <936cd758d6c694fe1b8b9de050e24cfecdc2e60d.1570489620.git.asml.silence@gmail.com>
 <e11a0716-eb18-4ce3-9902-3247beafe65a@kernel.dk>
 <d035bb1b-e6f0-77db-a434-1761b0a7a142@gmail.com>
 <62a8a6c7-9c5b-c9a4-9c73-c77db87c6637@kernel.dk>
 <99bfb7aa-6980-fc14-32f7-a479dea63eb4@gmail.com>
 <a1f8de23-fcad-7252-cbd4-8f5e617056cd@kernel.dk>
 <4004b5bc-edf0-cc8f-8efc-7f848c95f0ba@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <adc20cef-bc8e-2e67-399c-30c2f4af1a93@kernel.dk>
Date:   Tue, 8 Oct 2019 20:54:38 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <4004b5bc-edf0-cc8f-8efc-7f848c95f0ba@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/8/19 4:05 PM, Pavel Begunkov wrote:
> On 09/10/2019 00:22, Jens Axboe wrote:
>> On 10/8/19 2:58 PM, Pavel Begunkov wrote:
>>> On 08/10/2019 20:00, Jens Axboe wrote:
>>>> On 10/8/19 10:43 AM, Pavel Begunkov wrote:
>>>>> On 08/10/2019 06:16, Jens Axboe wrote:
>>>>>> On 10/7/19 5:18 PM, Pavel Begunkov (Silence) wrote:
>>>>>>> From: Pavel Begunkov <asml.silence@gmail.com>
>>>>>>>
>>>>>>> Any changes interesting to tasks waiting in io_cqring_wait() are
>>>>>>> commited with io_cqring_ev_posted(). However, io_ring_drop_ctx_refs()
>>>>>>> also tries to do that but with no reason, that means spurious wakeups
>>>>>>> every io_free_req() and io_uring_enter().
>>>>>>>
>>>>>>> Just use percpu_ref_put() instead.
>>>>>>
>>>>>> Looks good, this is a leftover from when the ctx teardown used
>>>>>> the waitqueue as well.
>>>>>>
>>>>> BTW, is there a reason for ref-counting in struct io_kiocb? I understand
>>>>> the idea behind submission reference, but don't see any actual part
>>>>> needing it.
>>>>
>>>> In short, it's to prevent the completion running before we're done with
>>>> the iocb on the submission side.
>>>
>>> Yep, that's what I expected. Perhaps I missed something, but what I've
>>> seen following code paths all the way down, it either
>>> 1. gets error / completes synchronously and then frees req locally
>>> 2. or passes it further (e.g. async list) and never accesses it after
>>
>> As soon as the IO is passed on, it can complete. In fact, it can complete
>> even _before_ that call returns. That's the issue. Obviously this isn't
>> true for purely polled IO, but it is true for IRQ based IO.
> 
> And the idea was to not use io_kiocb after submission. Except when we know,
> that it won't complete asynchronously (e.g. error), that could be checked
> with return code, I guess.

I think you're still missing the point. During the submission it can go
away, it can be deep in a call chain. So it's not enough to say "we
won't touch it after completion returns", we need to hold a reference to
ensure it doesn't go away WHILE being submitted.

Hope that helps!

-- 
Jens Axboe

