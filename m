Return-Path: <SRS0=VRi+=2C=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5241C2D0C6
	for <linux-block@archiver.kernel.org>; Thu, 12 Dec 2019 01:23:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A49DA208C3
	for <linux-block@archiver.kernel.org>; Thu, 12 Dec 2019 01:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576113790;
	bh=AA7gcgle7guw+VMZffnHdsDERUX6fFbYVUy8tJm2ApA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=eewNenRGvYuPiIvdMO8J2uA5PzaPLkDh2HShGoDQBiX3bHibsATMHEVoZyN8Ws/1x
	 AKfaJ7D0ds68/IrI2UiwMUNxW0C0LffCXJGkwqExulB5QU5g8kiEe3/lWxj6wNI9sT
	 PROz99TbhWm55dow5zIPOcOVsDmi2Za8RPNza2vM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727297AbfLLBXK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Dec 2019 20:23:10 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41716 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727224AbfLLBXJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Dec 2019 20:23:09 -0500
Received: by mail-lj1-f196.google.com with SMTP id h23so304050ljc.8
        for <linux-block@vger.kernel.org>; Wed, 11 Dec 2019 17:23:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZFejtvBe0docBJOjFHxtgIhfiR8IhEXMLIpQaHwz1hE=;
        b=Qc2vMRGn05C6BWhmeoZIaRoNsVj0SkjLXAbn9Gpo6T5N/+z6+RFmlpRLW5yvsYKNPg
         yDJ+wvL8TsHB0O6Oyi4tDJl0UJhonvrjzcws9HiezXHgSae108P3Sjj8l/gZO1nX23dW
         37s2bsGbyB3ZRoTk2x40dKoxY7GG6o7PWDKGs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZFejtvBe0docBJOjFHxtgIhfiR8IhEXMLIpQaHwz1hE=;
        b=MSH1xZ7NBUCwn3Q2OgBLUnO3bI76LiqnEm9oSZxkwym1lu9AdxyZRaw2+njg5zVMbm
         blNQRMKK9vmHjNbyLXw2BBMJhEmcFd57ZlwVL1fxrskH2os4VOydyBtijlr9FgS3Tply
         4gQt1lZxrE+C2xbENgZaG9AKP36EFlV74NbFlYvIuE0LIqYZUoXZLISKV9Bfs6iVlAID
         ocWn3/mzwEzOjb2ePioyOQTdNm4wfp2Fg6R9w/2Mip4YXwVZyNFX8DQKlMxjhymbFsx1
         N19RINw7dNLbrlnctq2R5tAtnKlHaPyA1jaMpgbfgyTrUuCcW8wPxYnX3ul/EWniMwwF
         FoIw==
X-Gm-Message-State: APjAAAXg/vN5NG8HwHsHhESK7hbdSi4SixmqgzD51aMKEtrF850Bq5cX
        WVnbyeUcVMQBNER3jiBVQCmxUOpA1mQ=
X-Google-Smtp-Source: APXvYqyXD1SGt20zC0hQcbM69hFT5swz8pXih5fE4Y43FS0mXj4/HtBuyi9z3vxx1c3a5wQolqIEqg==
X-Received: by 2002:a2e:6a03:: with SMTP id f3mr4194301ljc.232.1576113787390;
        Wed, 11 Dec 2019 17:23:07 -0800 (PST)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id u20sm1979843lju.34.2019.12.11.17.23.06
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2019 17:23:06 -0800 (PST)
Received: by mail-lf1-f46.google.com with SMTP id 203so320595lfa.12
        for <linux-block@vger.kernel.org>; Wed, 11 Dec 2019 17:23:06 -0800 (PST)
X-Received: by 2002:a05:6512:1dd:: with SMTP id f29mr4158153lfp.106.1576113785777;
 Wed, 11 Dec 2019 17:23:05 -0800 (PST)
MIME-Version: 1.0
References: <20191211152943.2933-1-axboe@kernel.dk> <CAHk-=wjz3LE1kznro1dozhk9i9Dr4pCnkj7Fuccn2xdWeGHawQ@mail.gmail.com>
 <d0adcde2-3106-4fea-c047-4d17111bab70@kernel.dk> <e43a2700-8625-e136-dc9d-d0d2da5d96ac@kernel.dk>
 <CAHk-=wje8i3DVcO=fMC4tzKTS5+eHv0anrVZa_JENQt08T=qCQ@mail.gmail.com>
 <0d4e3954-c467-30a7-5a8e-7c4180275533@kernel.dk> <CAHk-=whk4bcVPvtAv5OmHiW5z6AXgCLFhO4YrXD7o0XC+K-aHw@mail.gmail.com>
 <fef996ca-a4ed-9633-1f79-91292a984a20@kernel.dk> <CAHk-=wg=hHUFg3i0vDmKEg8HFbEKquAsoC8CJoZpP-8_A1jZDA@mail.gmail.com>
 <1c93194a-ed91-c3aa-deb5-a3394805defb@kernel.dk>
In-Reply-To: <1c93194a-ed91-c3aa-deb5-a3394805defb@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 11 Dec 2019 17:22:49 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj0pXsngjWKw5p3oTvwkNnT2DyoZWqPB+-wBY+BGTQ96w@mail.gmail.com>
Message-ID: <CAHk-=wj0pXsngjWKw5p3oTvwkNnT2DyoZWqPB+-wBY+BGTQ96w@mail.gmail.com>
Subject: Re: [PATCHSET v3 0/5] Support for RWF_UNCACHED
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>, Chris Mason <clm@fb.com>,
        Dave Chinner <david@fromorbit.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Dec 11, 2019 at 5:11 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> 15K is likely too slow to really show an issue, I'm afraid. The 970
> is no slouch, but your crypt setup will likely hamper it a lot. You
> don't have a non-encrypted partition on it?

No. I normally don't need all that much disk, so I've never upgraded
my ssd from the 512G size.

Which means that it's actually half full or so, and I never felt like
"I should keep an unencrypted partition for IO testing", since I don't
generally _do_ any IO testing.

I can get my load up with "numjobs=8" and get my iops up to the 100k
range, though.

But kswapd doesn't much seem to care, the CPU percentage actually does
_down_ to 0.39% when I try that. Probably simply because now my CPU's
are busy, so they are running at 4.7Ghz instead of the 800Mhz "mostly
idle" state ...

I guess I should be happy. It does mean that the situation you see
isn't exactly the normal case. I understand why you want to do the
non-cached case, but the case I think it the worrisome one is the
regular buffered one, so that's what I'm testing (not even trying the
noaccess patches).

So from your report I went "uhhuh, that sounds like a bug". And it
appears that it largely isn't - you're seeing it because of pushing
the IO subsystem by another order of magnitude (and then I agree that
"under those kinds of IO loads, caching just won't help")

                   Linus
