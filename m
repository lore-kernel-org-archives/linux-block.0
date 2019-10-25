Return-Path: <SRS0=ZVtD=YS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7FE4CA9EBD
	for <linux-block@archiver.kernel.org>; Fri, 25 Oct 2019 16:27:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BED0E2084C
	for <linux-block@archiver.kernel.org>; Fri, 25 Oct 2019 16:27:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="ws9PLaNt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505730AbfJYQ1z (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 25 Oct 2019 12:27:55 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:46065 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502714AbfJYQ1z (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Oct 2019 12:27:55 -0400
Received: by mail-io1-f65.google.com with SMTP id c25so3056437iot.12
        for <linux-block@vger.kernel.org>; Fri, 25 Oct 2019 09:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=RaDvY6LWZ/yZX1Gor0UyKnQkPXm7WlGMpaKJhq/jVms=;
        b=ws9PLaNtS2Vs7N+gwq3wuxTl8ddkUm0eF3zqwKbupfigCYPVUJ7sr18qgftp+jHQ+K
         jqgvoYgNUAz5GX8mRS0pqloApfqLkovP9aOKBJ8EcuSiXrJkhBhexauQ3F9AQ4ZKkZ66
         BklMZXpMSe/W6VzpEo8cB7e5DL7NZihYMIouBZTtcsK8sw5iw/K19iYL7p2wHbXLiT9p
         c4HmcEJwGWawKaWQQn6wOpmaAw557J5FMFeC6u1SSTN6enmBRUbhq0QeirxDcLKdwfvM
         JCVZMzFILX+VtlmMIP5QpC2Qjrr89v9KM/hlwCEEg633WsTyF12Vbdu/I8itDWIY56Nf
         Texw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RaDvY6LWZ/yZX1Gor0UyKnQkPXm7WlGMpaKJhq/jVms=;
        b=ZC1ssTFcCRxltZKRJSbaIwVKXxZ8wyza/NTWlpSNldUl403j+2Cd2ywdPDCcC6Ap1f
         ZuoZLZ+MUO92jwGkRPDu0AVLqGFfPEmuLN4a+LyWIo8pecOPPOfCiJtNKwMGmy7LAWXM
         nMr6SxJLWhMV8PfSNce9z3ajBs5561s/NvMTxLW3hZpLyPZUvElk9FGRy3jXUNm9HRjj
         x97dtuvPkIJL5NN+vmdjXjyWEfWoQx6VNCoOnE1iov1uMMIwW4N9YjSj+ASWPvcKf2Wp
         U0OtZ+o0jhw6JgqwyiYBMKHOkLFshVdGdgYdku3ZiMKhfDlJ+MfDEWRvu6WrggBaNCCn
         1mGA==
X-Gm-Message-State: APjAAAW0G3MJs46ROYWiXMZ8UaD9MUNG5FusZuq2R03hyDkwo0LyvNpa
        jy2qDt4UHSKFFyYmRkRZSvjdPQ==
X-Google-Smtp-Source: APXvYqxXSmEHcQy85qGn/KxnpvoMemzTN/kWJyZmSFui3ekTNgy4YIHRWXy1SYpaWRsDxeahPYAK6A==
X-Received: by 2002:a6b:c98e:: with SMTP id z136mr4182029iof.15.1572020872810;
        Fri, 25 Oct 2019 09:27:52 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id p5sm364983ils.32.2019.10.25.09.27.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Oct 2019 09:27:51 -0700 (PDT)
Subject: Re: [BUG] io_uring: defer logic based on shared data
To:     Pavel Begunkov <asml.silence@gmail.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <5badf1c0-9a7d-0950-2943-ff8db33e0929@gmail.com>
 <bfb58429-6abe-06f0-3fd8-14a0040cecf0@kernel.dk>
 <b44b0488-ba66-0187-2d9b-6949ceb613fb@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <96446fe1-4f32-642b-7100-ebfa291d7127@kernel.dk>
Date:   Fri, 25 Oct 2019 10:27:50 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <b44b0488-ba66-0187-2d9b-6949ceb613fb@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/25/19 10:21 AM, Pavel Begunkov wrote:
> On 25/10/2019 19:03, Jens Axboe wrote:
>> On 10/25/19 3:55 AM, Pavel Begunkov wrote:
>>> I found 2 problems with __io_sequence_defer().
>>>
>>> 1. it uses @sq_dropped, but doesn't consider @cq_overflow
>>> 2. @sq_dropped and @cq_overflow are write-shared with userspace, so
>>> it can be maliciously changed.
>>>
>>> see sent liburing test (test/defer *_hung()), which left an unkillable
>>> process for me
>>
>> OK, how about the below. I'll split this in two, as it's really two
>> separate fixes.
> cached_sq_dropped is good, but I was concerned about cached_cq_overflow.
> io_cqring_fill_event() can be called in async, so shouldn't we do some
> synchronisation then?

We should probably make it an atomic just to be on the safe side, I'll
update the series.

-- 
Jens Axboe

