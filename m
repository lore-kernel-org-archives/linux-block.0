Return-Path: <SRS0=VRi+=2C=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02D7BC2D0C5
	for <linux-block@archiver.kernel.org>; Thu, 12 Dec 2019 02:03:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCECA2077B
	for <linux-block@archiver.kernel.org>; Thu, 12 Dec 2019 02:03:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="rn/OjmCU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727591AbfLLCDo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Dec 2019 21:03:44 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46767 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727610AbfLLCDo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Dec 2019 21:03:44 -0500
Received: by mail-pl1-f194.google.com with SMTP id k20so327275pll.13
        for <linux-block@vger.kernel.org>; Wed, 11 Dec 2019 18:03:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Vdyn0MCNO1ty3ajxFsVqI/gZvnG7thnA7MHE+lTchGE=;
        b=rn/OjmCU+RdA5yV8DS2583/RK9D5MsA1C4cfbTjWvm+p7nU6R2nJ/gjga1u6cPD5tL
         pa0ORF/m1DnV36lu3OkmUxRv8DtzBktbxVBz37Rvq57cfMO/km2+luWjfo/3DDlN3Dax
         0B8F+oGERkPsTUNLzrXbrmcs7JOFniPAxwAig4LIRPtMgwKOHo1un9j+jQqfm30fKlaa
         GmBgDeuSC5i0R0LBWOurEH2y2j9Xr5HWtznlPcLKFfY73YIbF7kmu2HA7x+clJ6TVpnP
         sMI0s03+YMxPCDYuCz273I6b0rlFi7dZ8yxcmbAMXjJ0KScBK2+Le3EKDe9z2+sEcJAt
         vgVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Vdyn0MCNO1ty3ajxFsVqI/gZvnG7thnA7MHE+lTchGE=;
        b=bOMMzhYx6w0KmrKvPNZHntPC/r3u05hwr9l6KhSdVcvl5AqBirXK+qkqOYBdx4eLQW
         xqFkP6u+NjA4QtS0a8oaQ0dpr9kGHVsBmTS47Bnc3aTrGbXkjU+WuX+KDwDqceBI/9V9
         rP/dwF3gKwpLxS0FwAwP9TlHD4SkFr9z2X90S08gBw7KS5Lb2NLSJJbLj5Mi96dECACY
         re8mbm8ntiXYQHHzxA80gZrgxxY10qFOfGiX0UZAqCp1OIpaWartTsc8SUyO2Zn3Gug0
         mpdLqZAXNOjTc32MBbx92r1cTskwJ7EnYVsxJB8Im+CoLFB1dCW/8Rr0Ookvz5aa5PkK
         ZmwA==
X-Gm-Message-State: APjAAAX6Kjqxgobca2oe7yw5ds8vHklCkxbEBPPsoGHbQhy6TreJPmdN
        /Eac1nor0Y8wzQtLLhmtak1NdQ==
X-Google-Smtp-Source: APXvYqy+15um7yUOphomWYpUE0f9+qebFM2NA+q5sq8Js5dZUc2bAdagsOUJg5bL4ge7PGz0g3zqnA==
X-Received: by 2002:a17:90a:35e6:: with SMTP id r93mr7180387pjb.44.1576116223607;
        Wed, 11 Dec 2019 18:03:43 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id o31sm3982008pgb.56.2019.12.11.18.03.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2019 18:03:42 -0800 (PST)
Subject: Re: [PATCHSET v3 0/5] Support for RWF_UNCACHED
From:   Jens Axboe <axboe@kernel.dk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>, Chris Mason <clm@fb.com>,
        Dave Chinner <david@fromorbit.com>,
        Johannes Weiner <hannes@cmpxchg.org>
References: <20191211152943.2933-1-axboe@kernel.dk>
 <CAHk-=wjz3LE1kznro1dozhk9i9Dr4pCnkj7Fuccn2xdWeGHawQ@mail.gmail.com>
 <d0adcde2-3106-4fea-c047-4d17111bab70@kernel.dk>
 <e43a2700-8625-e136-dc9d-d0d2da5d96ac@kernel.dk>
 <CAHk-=wje8i3DVcO=fMC4tzKTS5+eHv0anrVZa_JENQt08T=qCQ@mail.gmail.com>
 <0d4e3954-c467-30a7-5a8e-7c4180275533@kernel.dk>
 <CAHk-=whk4bcVPvtAv5OmHiW5z6AXgCLFhO4YrXD7o0XC+K-aHw@mail.gmail.com>
 <fef996ca-a4ed-9633-1f79-91292a984a20@kernel.dk>
 <e7fc6b37-8106-4fe2-479c-05c3f2b1c1f1@kernel.dk>
Message-ID: <00a5c8b7-215a-7615-156d-d8f3dbb1cd3a@kernel.dk>
Date:   Wed, 11 Dec 2019 19:03:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <e7fc6b37-8106-4fe2-479c-05c3f2b1c1f1@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/11/19 6:09 PM, Jens Axboe wrote:
> On 12/11/19 4:41 PM, Jens Axboe wrote:
>> On 12/11/19 1:18 PM, Linus Torvalds wrote:
>>> On Wed, Dec 11, 2019 at 12:08 PM Jens Axboe <axboe@kernel.dk> wrote:
>>>>
>>>> $ cat /proc/meminfo | grep -i active
>>>> Active:           134136 kB
>>>> Inactive:       28683916 kB
>>>> Active(anon):      97064 kB
>>>> Inactive(anon):        4 kB
>>>> Active(file):      37072 kB
>>>> Inactive(file): 28683912 kB
>>>
>>> Yeah, that should not put pressure on some swap activity. We have 28
>>> GB of basically free inactive file data, and the VM is doing something
>>> very very bad if it then doesn't just quickly free it with no real
>>> drama.
>>>
>>> In fact, I don't think it should even trigger kswapd at all, it should
>>> all be direct reclaim. Of course, some of the mm people hate that with
>>> a passion, but this does look like a prime example of why it should
>>> just be done.
>>
>> For giggles, I ran just a single thread on the file set. We're only
>> doing about 100K IOPS at that point, yet when the page cache fills,
>> kswapd still eats 10% cpu. That seems like a lot for something that
>> slow.
> 
> Warning, the below is from the really crazy department...
> 
> Anyway, I took a closer look at the profiles for the uncached case.
> We're spending a lot of time doing memsets (this is the xa_node init,
> from the radix tree constructor), and call_rcu for the node free later
> on. All wasted time, and something that meant we weren't as close to the
> performance of O_DIRECT as we could be.
> 
> So Chris and I started talking about this, and pondered "what would
> happen if we simply bypassed the page cache completely?". Case in point,
> see below incremental patch. We still do the page cache lookup, and use
> that page to copy from if it's there. If the page isn't there, allocate
> one and do IO to it, but DON'T add it to the page cache. With that,
> we're almost at O_DIRECT levels of performance for the 4k read case,
> without 1-2%. I think 512b would look awesome, but we're reading full
> pages, so that won't really help us much. Compared to the previous
> uncached method, this is 30% faster on this device. That's substantial.
> 
> Obviously this has issues with truncate that would need to be resolved,
> and it's definitely dirtier. But the performance is very enticing...

Tested and cleaned a bit, and added truncate protection through
inode_dio_begin()/inode_dio_end().

https://git.kernel.dk/cgit/linux-block/commit/?h=buffered-uncached&id=6dac80bc340dabdcbfb4230b9331e52510acca87

This is much faster than the previous page cache dance, and I _think_
we're ok as long as we block truncate and hole punching.

Comments?

-- 
Jens Axboe

