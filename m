Return-Path: <SRS0=euq6=B7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4FB3C433DF
	for <linux-block@archiver.kernel.org>; Fri, 21 Aug 2020 23:40:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EB8F2072D
	for <linux-block@archiver.kernel.org>; Fri, 21 Aug 2020 23:40:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="V0ycwNCU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbgHUXko (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 Aug 2020 19:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726746AbgHUXkn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Aug 2020 19:40:43 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 870D7C061573
        for <linux-block@vger.kernel.org>; Fri, 21 Aug 2020 16:40:43 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id h4so3370510ioe.5
        for <linux-block@vger.kernel.org>; Fri, 21 Aug 2020 16:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jZGHtjpWYce+ezqQE68OaR3BETimF95K9n9GicBk70o=;
        b=V0ycwNCUbDoI0XkJVOma+ry1DiXtOSZv5pzijskD9RjMk1k/FP5sqBdswteuMRyc6i
         t7/OD9JSdD9QXeJHGfdTEyc+xKtM6QP9zlzQbxKrj9J52o/ZHsRBeXfEUs4/6k6ZcCUT
         4IebD3aMD9W4dY+rJ/iNHv4PjmdTEAltr3Q4/X38hhRQBVe79JGjiRQemHsYBM3ZAfNO
         U1Z+PvSJRwO1MNruP07M3DSjQ2Or40WjTGp4PJ/jKx6obcecS86LOdp6ApMOaByPEoCq
         InKTPhI2feNf6MkLB9A8xDrUqXidfKY4Cju22yzXmQWp+XrVdaAOG8C3P1mBwXFMBtLG
         QRqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jZGHtjpWYce+ezqQE68OaR3BETimF95K9n9GicBk70o=;
        b=o9WPdewedCr155JOMSImr8KE+gTI7Xh5frHeFcRkXcFGaUuR7IykleOMgXr9d2it4V
         XqtFvuioeMfilUFRcUkBN9J/GMQBrWoriGUq8myKkcFRiKjAPY0w0Bc2B6wAA4VfGV4P
         teMt1w/xt56JgWHk5CajEjEKhPTVZMZPlcGcdCL4eKFbBY1zW7mg3JTYb80b0M5UGtpI
         LcR86Upra50p3hB1SzJUCUJXkgNJfkyBLuhzsCKNstBbMEqoJvrBVPloJwJ+SqyAvIij
         2u2YsCTicEzeRuLNwMY8LY8OUGyCuNjHGYJy0FefLeFNQbTGiYH3/P7DA2sPKTUmFP5l
         Mrww==
X-Gm-Message-State: AOAM533eBrMWT1WQHKXPsnNPGAq/IRQsXefYqNMmwHofkWKUt5XLLCU5
        UvSpDvaN1eBMMywkrJsB4Ve/yZzXOymcv5Qh
X-Google-Smtp-Source: ABdhPJyciv2SMBU+9IoUvHo1P7bN4w7G4BzbCjUj/JdjB5nnmW0n7KOHBF7P3VU9D1mVS1ytyJKCAg==
X-Received: by 2002:a05:6638:594:: with SMTP id a20mr4635918jar.127.1598053242277;
        Fri, 21 Aug 2020 16:40:42 -0700 (PDT)
Received: from [192.168.1.58] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id f6sm2042182ioo.32.2020.08.21.16.40.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Aug 2020 16:40:41 -0700 (PDT)
Subject: Re: [GIT PULL] Block fixes for 5.9-rc2
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <2e213354-a1f8-cdb6-0f3c-24473a2a2ef8@kernel.dk>
 <CAHk-=wiFwUUEpCQ2FDWxBFb3XSxu=+yODHGfLPncvTQa9BeP9w@mail.gmail.com>
 <22fc2c2f-1ab9-6c57-df94-4768a64644e9@kernel.dk>
 <CAHk-=wg=CkBbPHVOjoaFWoACzm+7jWhBBzwmsw7y0EYcmseh0Q@mail.gmail.com>
 <7a221d34-6651-ba92-f074-c785fab70460@kernel.dk>
 <CAHk-=wgw1GQ3FOcLUgj1ZDG2RaACZFuC0CB9MHSTaFSVEdEPdg@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <fab39809-e477-f64e-6454-a29b4d016ba1@kernel.dk>
Date:   Fri, 21 Aug 2020 17:40:41 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wgw1GQ3FOcLUgj1ZDG2RaACZFuC0CB9MHSTaFSVEdEPdg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/21/20 5:29 PM, Linus Torvalds wrote:
> On Fri, Aug 21, 2020 at 4:01 PM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> The tree is totally warning clean right now on build, but that's usually
>> not the case, and missing a single warning isn't that hard.
> 
> Actually, my tree is generally entirely warning-free and has been for
> years, because I absolutely hate warnings.
> 
> You're not the only person I haven't pulled from because I saw a
> single warning. This is the second one just this release window.  I'm
> not singling you out. A warning to me is simply a hard "No".
> 
> Because I know very well that if there is even a single warning,
> people will then ignore the other warnings.
> 
> So there is no such thing as a harmless warning - it doesn't matter
> _what_ it warns about, it's a bad thing, because even one bogus
> warning will then mean that people ignore warnings that _aren't_
> bogus, and it goes all downhill from there.

We're in violent agreement on this part. None of the projects I maintain
throw any warnings, exactly for the same reason. My test box is using
gcc-10 and it definitely hasn't been "clean for years". It is now, and
has been for probably a release or two. The warnings do condition you to
ignore new warnings, which is of course a sad outcome that shouldn't
happen. I don't think anyone sane would disagree on that.

> So the reason I notice is exactly because I keep my build tree 100%
> clean. I do allmodconfig builds that are entirely clean, and I check
> it after each and every pull I do, and each patch series I apply.
> Mistakes can happen, but I try _very_ hard to keep my tree clean.
> 
> Now, that said, I'll miss warnings too, because I don't do
> cross-builds for other architectures, and I really only do a couple of
> fairly basic configurations.
> 
> But perhaps more importantly - I don't build with a lot of different
> compilers. I do in fact test two different compilers (both gcc and
> clang), but I use two different configurations, so it's not really
> overlapping testing, it's more that these days I make sure the clang
> build is warning free at least for the core kernel too.
> 
> So "warning free" is always relative to some compiler base (and some
> config base). But the baseline should absolutely be "zero warnings".
> 
> Generally, new warnings in my tree is because of a compiler upgrade or
> similar congifuration issues.
> 
> And it's sadly the "different compilers" thing that then means that
> *my* clean tree might not then necessarily be clean for others. It's
> also why I can't just enable "-Werror" to make it harder to miss.
> 
> But I've been tempted. Many times. There's been a couple of times I've
> added that "-Werror" to the Makefile, only to never commit it.
> 
> But if you have warnings that you see due to different compilers or
> configurations, holler. We'll get them fixed.

I obviously don't disagree with any of this, it'd be hard to, and it
wasn't really what any of my replies were about. It was about how this
was dealt with. But I won't keep beating the dead horse.

As I said, I'll rebase the branch, and in fact I already did. I likely
won't be able to get it out before after -rc2, which is pretty sad since
there's an nvme regression in there that would have been nice to have.
There's an off chance that I'll send it out tomorrow, depends on timing.

-- 
Jens Axboe

