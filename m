Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C718C433EF
	for <linux-block@archiver.kernel.org>; Fri, 12 Nov 2021 15:41:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7691E60F0F
	for <linux-block@archiver.kernel.org>; Fri, 12 Nov 2021 15:41:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235285AbhKLPoQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 12 Nov 2021 10:44:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235273AbhKLPoP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 12 Nov 2021 10:44:15 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89931C061766
        for <linux-block@vger.kernel.org>; Fri, 12 Nov 2021 07:41:24 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id k22so11529739iol.13
        for <linux-block@vger.kernel.org>; Fri, 12 Nov 2021 07:41:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TW+78UtJNDAtmu8mZD/nSGjjpb9HER1Z5VD7cuELSfs=;
        b=T5Ju8a5iXXk6q5S2SMOoWR8p4sWDzXrX7nJQ3aW5ZC8JRK/AIAT7lo5GCzchr8BG8H
         MArW24/43p2/r9rIBBW2b2MGmtPY82y71aXQKw3LeasCXqtwyuQwOYxudmZPd1vKk3aU
         EULQTv3XIg/HsKP01dhj6WogwT5nean7bOaTp7oTrJdUAcVh2YQFj6XjU6wdbpRVVQaZ
         k6c+ngCkSzDXI978/Xu6RWYjsjfdy2hVl1I6QDbnxasgsF1wIr9wJPNFz/d4p75KUiMx
         p7LwOFuLh9lRobTn3JUR/IKVeFdk9MsloFG9XeBjedoQTcu+znIVHVINvsFu5z35KifN
         vrIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TW+78UtJNDAtmu8mZD/nSGjjpb9HER1Z5VD7cuELSfs=;
        b=zAacf1PNFNIfLkYp+mgwEi9SLaFGGNTjNuK9k42oQAQ+f0LinMRJw/oKtaHnZoqaPU
         u0Ns3nHANf6sIzwbKudPOWtEUZFzMhVY47QMh4tz6RIcgd8mms1CtJOmTwco6gN/7tND
         2/I548ffQmnVWDae9RJc49I3kZp0Kyw5pQ6V8Y7eIu0g8dC1sKykyOGXVlDktnlRAkyz
         vq3Q1qCJeavKb+9suolH7e8ab+w8d8LCnmk2g+2UVE0TzLWTF9ucvLH5i9n1h5KFYttV
         2HtVojhabjjZl2zBz0jNQb1mBqdVtPDJ2/KyIx/ZNMuRa9cMDG29B+B/J6rXQ1PMfStH
         e60Q==
X-Gm-Message-State: AOAM531fQJYFCrDXaepRavY6Hs1tv1spuJFjJPopPQvhQe5mPYasmILT
        DKeZt/wLCoVEMkSzQXperQinRQ==
X-Google-Smtp-Source: ABdhPJyQy/uM6/WU2rBboEmwk2xsH9SjKGDvAsa5+AvHfc8BUz+sjog5XtHhaXX3vGN2/EIpX3K1uA==
X-Received: by 2002:a6b:2cc5:: with SMTP id s188mr11245012ios.218.1636731683878;
        Fri, 12 Nov 2021 07:41:23 -0800 (PST)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id c12sm3888910ils.31.2021.11.12.07.41.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Nov 2021 07:41:23 -0800 (PST)
Subject: Re: [PATCH] blk-mq: setup blk_mq_alloc_data.cmd_flags after
 submit_bio_checks() is done
To:     Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
References: <20211112081137.406930-1-ming.lei@redhat.com>
 <20211112082140.GA30681@lst.de> <YY4nv5eQUTOF5Wfv@T590>
 <20211112084441.GA32120@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <0eb6236f-d428-5869-a632-919fa07dc172@kernel.dk>
Date:   Fri, 12 Nov 2021 08:41:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20211112084441.GA32120@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/12/21 1:44 AM, Christoph Hellwig wrote:
> On Fri, Nov 12, 2021 at 04:37:19PM +0800, Ming Lei wrote:
>>> can only be used for reads, and no fua can be set if the preallocating
>>> I/O didn't use fua, etc.
>>>
>>> What are the pitfalls of just chanigng cmd_flags?
>>
>> Then we need to check cmd_flags carefully, such as hctx->type has to
>> be same, flush & passthrough flags has to be same, that said all
>> ->cmd_flags used for allocating rqs have to be same with the following
>> bio->bi_opf.
>>
>> In usual cases, I guess all IOs submitted from same plug batch should be
>> same type. If not, we can switch to change cmd_flags.
> 
> Jens: is this a limit fitting into your use cases?

It's not a big problem for my use case, as that ones all the same type
of IO. And in general I don't expect a lot of mixed uses here, I guess
the main issue might be a plug for writes and an initial meta data read
will "polute" the request cache with requests that we won't be using.
But probably not a big enough thing to worry about in terms of
efficiency.

> I guess as a quick fix this rejecting different flags is probably the
> best we can do for now, but I suspect we'll want to eventually relax
> them.

Agree on both.

-- 
Jens Axboe

