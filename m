Return-Path: <SRS0=rnrW=QF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 331F6C4151A
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 16:20:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 062272175B
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 16:20:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="FMsLb4Nk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727786AbfA2QT6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Jan 2019 11:19:58 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:33391 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726417AbfA2QT6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Jan 2019 11:19:58 -0500
Received: by mail-it1-f193.google.com with SMTP id m8so14218698itk.0
        for <linux-block@vger.kernel.org>; Tue, 29 Jan 2019 08:19:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Hl535qqGu6s7C0sfstGLUC++F16KJhjkkZJjtWu5Y/Q=;
        b=FMsLb4NkgkfO6GwNbjTejXShDLcc7LbXJj0K7woLuUQEgdmTm59UjapwFY4zSdCZXv
         bCoN3dnolKAmAnElAqFAxC47JVRSFzBmlmIEhXYAK8AMVTfmGamSmbixkpPR2SwZoWp2
         OpUtexJ7IsO7wvLQMS9PQfiqkEM+HVmrOYpZkjwr4l+N2mDKXEfvBtpgBSyqOXQWg8ST
         q7LwBB6fpZWBjP7/joQKBl0hkH2Z2U9wsmnTMBotDUw+X/cw9p9i38p7HTCB465F3S3w
         HOBD0Lkhi1+PJfDKNiaJSGCzJ7OOVdl16cIL2Z0L/9OyRrhMxszSkbTQk+FUWpRV8is1
         ARNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Hl535qqGu6s7C0sfstGLUC++F16KJhjkkZJjtWu5Y/Q=;
        b=ge83eyxjV3+4aCae/YDZWoYw0tB9/mIj1+n8nkIpzCI2e18zaGEa1ulp40hNWDwGIK
         3DpmYVMvAsRIS2FcISvYoA7X0IZuMcFHufW/J4MxvYo8G9PizkKYb2dupUml0f9lgeSM
         1Tb/k7/0uEKAKPQFbTxSi5YtlTJp8Tfr/RFFy0u3XGQRRCs30816NRJQKnqdizdlwf0N
         m0phNUahjkz8ulmx4A7JqpQ3gjsFps4M/6JHgGdeXtLqIIqqvlezJfcI9pkpQhjwQpv4
         NTM4ejVSjYlttSJWuJTb2ff7//UnOJ5gRsp158B4PbEkFevjM6992WTp0cINRkWxt3XL
         mEew==
X-Gm-Message-State: AJcUukdtARjkxAbqbTGokOgi+wz2qefSM4xjXOCFnv6eWAfLu2gQOLyM
        h0uIb1+6yIUYSVKjgeegB2OdcA==
X-Google-Smtp-Source: ALg8bN6UeH+7CQoaX9Og6UyI1RGfSW/3v5e9PoQG9cigivUxo0Ac87Gvl6kK3HXt2/hJ/sqXmTjvXQ==
X-Received: by 2002:a24:e04a:: with SMTP id c71mr13479693ith.127.1548778797180;
        Tue, 29 Jan 2019 08:19:57 -0800 (PST)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id n16sm14480053iom.58.2019.01.29.08.19.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 08:19:56 -0800 (PST)
Subject: Re: [PATCH 05/18] Add io_uring IO interface
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        linux-aio <linux-aio@kvack.org>,
        linux-block <linux-block@vger.kernel.org>,
        Jeff Moyer <jmoyer@redhat.com>, Avi Kivity <avi@scylladb.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>
References: <20190123153536.7081-1-axboe@kernel.dk>
 <20190123153536.7081-6-axboe@kernel.dk> <20190128145700.GA9795@lst.de>
 <2729ab43-b2bf-44b0-d41d-dbb495ddffbf@kernel.dk>
 <20190129063043.GC2996@lst.de>
 <CAK8P3a1x4BsFfacxOmaDXKOKmmQ2j0ypX2+mCNCbjH3E7nC4DQ@mail.gmail.com>
 <4b12d149-99f7-0b2e-0c3f-9b477ce48520@kernel.dk>
 <CAK8P3a38-FLBH0sp0vaebv29M5oDyiUkwwmVY+9_S3vSER9n5Q@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <9a66c000-62f3-7567-7919-31e61e28defa@kernel.dk>
Date:   Tue, 29 Jan 2019 09:19:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a38-FLBH0sp0vaebv29M5oDyiUkwwmVY+9_S3vSER9n5Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/29/19 9:18 AM, Arnd Bergmann wrote:
> On Tue, Jan 29, 2019 at 4:20 PM Jens Axboe <axboe@kernel.dk> wrote:
>> On 1/29/19 4:58 AM, Arnd Bergmann wrote:
>>> On Tue, Jan 29, 2019 at 7:30 AM Christoph Hellwig <hch@lst.de> wrote:
>>>>> On Mon, Jan 28, 2019 at 11:25:12AM -0700, Jens Axboe wrote:
>>>>>> Especially with poll support now in the series, don't we need a ѕigmask
>>>>>> argument similar to pselect/ppoll/io_pgetevents now to deal with signal
>>>>>> blocking during waiting for events?
>>>>>
>>>>> Is there any way to avoid passing in the sigset_t size? If it's just a
>>>>> 32-bit/64-bit thing, surely the in_compat_syscall() could cover it? Or
>>>>> are there other cases that need to be catered to?
>>>>
>>>> As far as I can tell we never look at it, never looked at it and don't
>>>> have any plans to look at it anytime soon.  But when I tried to omit
>>>> it for io_pgetevents I got stong pushback and thus had to add the
>>>> crazy double indirection calling convention.
>>
>> That's good info. I am currently using set_user_sigmask() for it.
>> I'd really like to avoid having to pass in a sigset_t size for the
>> system call, however.
> 
> I really wouldn't do it, given that all other signal handling interfaces
> are prepared for longer signal masks. You /could/ probably extend
> it later with a flags bit to signify a longer mask instead of using
> the entire register to hold the bit length, it just seems really
> inconsistent with all other system calls.

Damnit! OK, I'll keep what I currently have then.

-- 
Jens Axboe

