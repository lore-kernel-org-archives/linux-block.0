Return-Path: <SRS0=Rcoh=SY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2DA4C10F11
	for <linux-block@archiver.kernel.org>; Mon, 22 Apr 2019 16:38:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2A31214AE
	for <linux-block@archiver.kernel.org>; Mon, 22 Apr 2019 16:38:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="MjaOFfbe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728303AbfDVQig (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Apr 2019 12:38:36 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:36833 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728299AbfDVQif (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Apr 2019 12:38:35 -0400
Received: by mail-it1-f193.google.com with SMTP id y10so19150510itc.1
        for <linux-block@vger.kernel.org>; Mon, 22 Apr 2019 09:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hMF4Llv/Z7HnWPfu2XvWsN+C90/8jjRyDuPzjCOXXM4=;
        b=MjaOFfbedO013k2srZ8PF1vBifNNhn9MfMSoSQofF/cG66ZP5WdX1h+G1WlfFZlCFH
         17EMInn5tLJ2wcevRz0uk5Eg2t8rcJo+6+Jxj9NFtZQEjruHrc+oYrE0hWB3PkgYkBH6
         8fQXdJ6a6XV5d2bX73/HVNKZT08BIHlYq9TjzEWwwXJA7XuqN0k2OKO4it2LtmtgMWZk
         iNc+hnGqSXIaBTDgRFODB4+JjCL/Fz4/mfS4guGDtmPAOK3D3WgSs+Q1/RAA7W8B7dsa
         idY2tFKMtBb+M8pWTZ+yiKcGitzempUL29mSy5XCUikjl87Sz89IxlyRNuQlpxqhdNc5
         7egA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hMF4Llv/Z7HnWPfu2XvWsN+C90/8jjRyDuPzjCOXXM4=;
        b=bhIKwP9IjB8cY5FKRNAVcx4vLVPxua9/iD/GiUd/NZDpOMFdKsl0qZuRwKhfVAX9Fz
         Gv66CRQeRrZHxBmpm7AlE4cyh49fp9SkNSy0fa1Jnyp8HiqIWlSdiFcRA94umrcx5HKG
         f+ObY58TJ+XJZb1G93OWpQ2MSr8ONlVTO0UWyjzn8xog6Fxatd9ET1yZ5S29Xg7z2IPo
         ISGO3LDfhKP48mYF5Xn2dpLf41tjUO4dqEtqVu7sAz/ZAp59j1udj0vgdpdLfgRwqDIb
         bm2GzLIOoXOPcvz5IgdNqe/6RV8/yztx2kRDehpac//Ouqkjjms4DVUdRs9e+5geYuRh
         4NGA==
X-Gm-Message-State: APjAAAWN8NMiMpHgKlS/ZNU13O7JYgteunM48MWF2zCGZFDv7NcCngyR
        Ezk5BxY7samNNsGIazsDeU2V/w==
X-Google-Smtp-Source: APXvYqwIPwbX09YkmHtHNc+KynmoG+sKurlpWyeXPvC/lvF/Jb29guOOM3fFDP9wUeu5UsV/lvzcBA==
X-Received: by 2002:a24:3246:: with SMTP id j67mr14307483ita.70.1555951115051;
        Mon, 22 Apr 2019 09:38:35 -0700 (PDT)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id b82sm6441693itd.12.2019.04.22.09.38.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Apr 2019 09:38:33 -0700 (PDT)
Subject: Re: WARNING in percpu_ref_kill_and_confirm
From:   Jens Axboe <axboe@kernel.dk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     syzbot <syzbot+10d25e23199614b7721f@syzkaller.appspotmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Anvin <hpa@zytor.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Ingo Molnar <mingo@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        the arch/x86 maintainers <x86@kernel.org>
References: <00000000000043fe9c058720a5d3@google.com>
 <ad884b18-0e03-d6be-02b0-4e5273f068ce@kernel.dk>
 <CAHk-=wgG=RqK8T5kWiZfH7da6rBuqp3kAesP=ETgceb6RzvZng@mail.gmail.com>
 <53a17444-9539-5810-82a0-ceeefa742508@kernel.dk>
Message-ID: <cfa6be6d-4125-6d1e-8993-e9ec9dbaa7bb@kernel.dk>
Date:   Mon, 22 Apr 2019 10:38:32 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <53a17444-9539-5810-82a0-ceeefa742508@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/22/19 10:32 AM, Jens Axboe wrote:
> On 4/22/19 10:27 AM, Linus Torvalds wrote:
>> [ Crossed emails ]
>>
>> On Mon, Apr 22, 2019 at 9:23 AM Jens Axboe <axboe@kernel.dk> wrote:
>>>
>>> I think the below should fix this. Very early versions of io_uring didn't
>>> have this issue, since we did the percpu ref tryget for io_uring_register().
>>
>> Ok, so I like your patch better than mine, but note how syzbot
>> bisected this to the initial merge of the io_uring code.
> 
> Yes, I did think about that too...
> 
>> I agree that code shouldn't have had this particular issue, but it
>> looks like it does.
>>
>> Is there some way to race with io_ring_ctx_wait_and_kill(), which
>> _also_ does that ref_kill() thing? I'm not seeing how that could
>> happen, but maybe if the file ref counts get screwed up you have
>> ->release() called early..
> 
> I just tried on the current code and it triggers easily, but that's
> with that mutex patch in there. I agree it should not trigger before
> that, unless something is wonky. I'll try and play around with it a bit
> and see what is going on (or if I can trigger it at all with the mutex
> change reverted).

With the mutex change in, I can trigger it in a second or so. Just ran
the reproducer with that change reverted, and I'm not seeing any badness.
So I do wonder if the bisect results are accurate?

I think the dying check should cover it, and then marked with fixing
that mutex commit.

-- 
Jens Axboe

