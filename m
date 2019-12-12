Return-Path: <SRS0=VRi+=2C=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 868B5C2D0C5
	for <linux-block@archiver.kernel.org>; Thu, 12 Dec 2019 01:50:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D76A20652
	for <linux-block@archiver.kernel.org>; Thu, 12 Dec 2019 01:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576115419;
	bh=6ua+gFrFHp8Ic5JviapLkNfyb1mlSo4I1NxW0GbS5aE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=EzMUKZo5R1AiGk2pKenGiwdvr5CMNijBbddc6QVJuU4EqDYc2GdosNz3A2elrnBR+
	 hww/NrqQk/yfqvE7MlfiDW4PiTbgHOXmVs30eXpUqxSiFCMOMDXeUIc0agxXEaZalo
	 gajHrs+hOtpxIDCMRSQqqclazNsPeLtXtPCtA60Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727591AbfLLBuR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Dec 2019 20:50:17 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:38524 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727504AbfLLBuR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Dec 2019 20:50:17 -0500
Received: by mail-lf1-f66.google.com with SMTP id r14so383561lfm.5
        for <linux-block@vger.kernel.org>; Wed, 11 Dec 2019 17:50:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PC+SlnRf7svTDlkNpHBVMSNitoLO6r2vdwDHMDAkNI8=;
        b=fNkGcKXQB3xCtLQKXADqQ3G/djHPEEOB2trqYHHu5gTxMrHq7l42M/wCwdjLYpZmt5
         d7A+P6Xe/uSH2xY8H4UU5n/Z0u0+D6EAJztG7SF9hKLTZUlA4KZhCzbYrxxykxZ762O1
         5fT3K/zxq8wXmuG9+5Iondt19rtNqXTpw1zSg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PC+SlnRf7svTDlkNpHBVMSNitoLO6r2vdwDHMDAkNI8=;
        b=GevaNuYmWQkGLMW8X4VldR/QuMd2UKYkBVVJWvRRmUs67ojC4w0isshjbumx3XPgNW
         mrLafNxl5wVtjVpZHtFSQAXFd8fSuSt9h1PDvoDL8SMngnZqpUDCbEsZWEHZZt8aSLDo
         Or+djP6BjrwnKoQdVJHu1labasYd0KujtRIw56OeFpwc8zNVQFeUkMcaHY6JkZEQ6iB3
         +lvFloz9EAdnqET69880oO2K9dhFDcX2cu9KSm5zlKVF8QRhnGixhxV++VwnGMRAkpLU
         vSK878zrRmorFqCV6ZC+k9f84rTjnImSyQxB2PmLgRWPo86hDeocb1n2xkX8cKPPQArH
         OIww==
X-Gm-Message-State: APjAAAU4/tJK5QZ7sV00xgxIjdmowSJpSH2t/zbtvfKvanE51hUEKCdr
        UkuJYKe6dEJtTTNBt4/EzJrWZwLkwNI=
X-Google-Smtp-Source: APXvYqwdjvYV4gOp5W96v0Q51Yw2N+7hriwtwb+GrvIgKOhMfrzShZvlH8QX1CfdMoXfKP8no7Fcbg==
X-Received: by 2002:ac2:54b5:: with SMTP id w21mr4043276lfk.175.1576115414779;
        Wed, 11 Dec 2019 17:50:14 -0800 (PST)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id z9sm2007711ljm.40.2019.12.11.17.50.13
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2019 17:50:13 -0800 (PST)
Received: by mail-lj1-f175.google.com with SMTP id d20so333921ljc.12
        for <linux-block@vger.kernel.org>; Wed, 11 Dec 2019 17:50:13 -0800 (PST)
X-Received: by 2002:a2e:9ad8:: with SMTP id p24mr4244948ljj.148.1576115413333;
 Wed, 11 Dec 2019 17:50:13 -0800 (PST)
MIME-Version: 1.0
References: <20191211152943.2933-1-axboe@kernel.dk> <CAHk-=wjz3LE1kznro1dozhk9i9Dr4pCnkj7Fuccn2xdWeGHawQ@mail.gmail.com>
 <d0adcde2-3106-4fea-c047-4d17111bab70@kernel.dk> <e43a2700-8625-e136-dc9d-d0d2da5d96ac@kernel.dk>
 <CAHk-=wje8i3DVcO=fMC4tzKTS5+eHv0anrVZa_JENQt08T=qCQ@mail.gmail.com>
 <0d4e3954-c467-30a7-5a8e-7c4180275533@kernel.dk> <CAHk-=whk4bcVPvtAv5OmHiW5z6AXgCLFhO4YrXD7o0XC+K-aHw@mail.gmail.com>
 <fef996ca-a4ed-9633-1f79-91292a984a20@kernel.dk> <CAHk-=wg=hHUFg3i0vDmKEg8HFbEKquAsoC8CJoZpP-8_A1jZDA@mail.gmail.com>
 <1c93194a-ed91-c3aa-deb5-a3394805defb@kernel.dk> <CAHk-=wj0pXsngjWKw5p3oTvwkNnT2DyoZWqPB+-wBY+BGTQ96w@mail.gmail.com>
 <d8a8ea42-7f76-926c-ae9a-d49b11578153@kernel.dk> <6e2ca035-0e06-1def-5ea9-90a7466b2d49@kernel.dk>
In-Reply-To: <6e2ca035-0e06-1def-5ea9-90a7466b2d49@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 11 Dec 2019 17:49:57 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjkpRnqDfcR1h2NyCN7Ka9T0DcHgBL=e9pVvYG2u0APdQ@mail.gmail.com>
Message-ID: <CAHk-=wjkpRnqDfcR1h2NyCN7Ka9T0DcHgBL=e9pVvYG2u0APdQ@mail.gmail.com>
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

On Wed, Dec 11, 2019 at 5:41 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> So now I'm even more puzzled why your (desktop?) doesn't show it, it
> must be more potent than my x1 laptop. But for me, the laptop and 2
> socket test box show EXACTLY the same behavior, laptop is just too slow
> to make it really pathological.

I see the exact same thing.

And now, go do "perf record -a sleep 100" while this is going on, to
see the big picture.

Suddenly that number is a lot smaller. Because the kswapd cost is less
than 10% of one cpu, and the xas_create is 30% of that. IOW, it's not
all that dominant until you zoom in on it. Considering the amount of
IO going on, it's kind of understandable.

But as mentioned, it does look like something that should be fixed.
Maybe it's even something where it's a bad XArray case? Willy?

              Linus
