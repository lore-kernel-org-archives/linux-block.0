Return-Path: <SRS0=N4qE=SZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13142C10F03
	for <linux-block@archiver.kernel.org>; Tue, 23 Apr 2019 22:07:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFA4021738
	for <linux-block@archiver.kernel.org>; Tue, 23 Apr 2019 22:07:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="o7d6v/cb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbfDWWH5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Apr 2019 18:07:57 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46970 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727929AbfDWWH4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Apr 2019 18:07:56 -0400
Received: by mail-pg1-f193.google.com with SMTP id v2so5857907pge.13
        for <linux-block@vger.kernel.org>; Tue, 23 Apr 2019 15:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=E+6aRvz4Z09evBiibOHD3ZNcSjXr3mNiHU4Qco54pcU=;
        b=o7d6v/cbAsVH2XoEkHi83W5JcavIKrSXT27FOuf4sCRGAdC8833TaMgkOEFpVETBdM
         wqlfaRW/Ug5yy82uJo8kUsOLuz66CBvWtyQxaRuI43t6RrfdF2eqI+14aQCUua4aHmxo
         UkmKU/sLqA4RQ2VzShqHtX/XaGKZnt6/pP30sg5BCQK0c27P+5x2wrHPn0U7agR9ULwE
         nNwHOWTKdpehSYkm8ZPsxCfjJaH7muA4L82h+ZVVU6SMfG8m5N+HFEee07e8yW5LRRBv
         jxL0792W2g84xme+I0cQwXzEqZiig1wVCShGWYe6kxRaw6F2b8+stjbZUX4hyB2EV1Sg
         4x+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=E+6aRvz4Z09evBiibOHD3ZNcSjXr3mNiHU4Qco54pcU=;
        b=C7/WQN8kPhjaiOwO8MQgBT7GUdzZIN4K4px81SKqsjtg/xJC+gBjlPYfviyMDZa2IG
         3uppxCjJvUgH0inco8YpAiViFwyxj0otT3Z34LLDQaoDRPtjS+1uuYqH5eV19HMuiT3m
         nsiqx5fD7bMzPqH5zkIyZ4eRDZ4mIxaDvRLhutukWDshHBqYjGnIez7NIMjB5D93dcv4
         wcZqTD1d5Er3C22cLHlbi1Y8ORQzprLYRojD1WDTqE109E7gYCNa0c8w4Btc5dwOFXfx
         iQF0M6o53a0mSY18FAsi0wU0Q0qzcMKLuhH8cGydh9LrOAGD68Vy2wOhMrjqik+T6sEw
         6naA==
X-Gm-Message-State: APjAAAUccE4QeKx8CCtsl08VHIDipx0HEkpiOgPsINsxkdHUrcWKvDxt
        EegdXnlh721PW1f27wS5dxcocA==
X-Google-Smtp-Source: APXvYqxeXKnny36PVIadE59Z0qTZp4Gg3iXoneCNv8Q6KIXfwKmxFfHhz2YkfB/hoN5NWsrt13IOMw==
X-Received: by 2002:a63:161d:: with SMTP id w29mr3979135pgl.395.1556057276054;
        Tue, 23 Apr 2019 15:07:56 -0700 (PDT)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id a10sm22000583pfc.21.2019.04.23.15.07.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 15:07:55 -0700 (PDT)
Subject: Re: io_uring: not good enough for release
From:   Jens Axboe <axboe@kernel.dk>
To:     =?UTF-8?Q?Stefan_B=c3=bchler?= <source@stbuehler.de>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <366484f9-cc5b-e477-6cc5-6c65f21afdcb@stbuehler.de>
 <37071226-375a-07a6-d3d3-21323145de71@kernel.dk>
Message-ID: <bc077192-56cc-7497-ee43-6a0bcc369d16@kernel.dk>
Date:   Tue, 23 Apr 2019 16:07:53 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <37071226-375a-07a6-d3d3-21323145de71@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/23/19 2:31 PM, Jens Axboe wrote:
>> 1. An error for a submission should be returned as completion for that
>> submission.  Please don't break my main event loop with strange error
>> codes just because a single operation is broken/not supported/...
> 
> So that's the case I was referring to above. We can just make that change,
> there's absolutely no reason to have errors passed back through a different
> channel.

Thinking about this a bit more, and I think the current approach is the
best one. The issue is that only submission side events tied to an sqe
can return an cqe, the rest have to be returned through the system call
value. So I think it's cleaner to keep it as-is, honestly.

>> (Also RWF_NOWAIT doesn't work in io_uring right now: IOCB_NOWAIT is
>> always removed in the workqueue context, and I don't see an early EAGAIN
>> completion).
> 
> That's a case I didn't consider, that you'd want to see EAGAIN after
> it's been punted. Once punted, we're not going to return EAGAIN since
> we can now block. Not sure how you'd want to handle that any better...

I think I grok this one too now - what you're saying is that if the
caller has RWF_NOWAIT set, then the EAGAIN should be returned instead of
being punted to the workqueue? I totally agree with that, that's a bug.

-- 
Jens Axboe

