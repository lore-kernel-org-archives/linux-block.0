Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FA00C77B7F
	for <linux-block@archiver.kernel.org>; Fri,  5 May 2023 18:41:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233073AbjEESlF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 5 May 2023 14:41:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233016AbjEESlE (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 5 May 2023 14:41:04 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C7711A4AD
        for <linux-block@vger.kernel.org>; Fri,  5 May 2023 11:41:02 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-50bd2d7ba74so29768810a12.1
        for <linux-block@vger.kernel.org>; Fri, 05 May 2023 11:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1683312060; x=1685904060;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yhm3Rctnlx5UPRybogDdMN4gKvloPHqLZXPlqb0HbTI=;
        b=VXp66tQBwYbM0EWUCbQ0q9HdCzgIXFRCsNBqKAPIsWsz5JhB5gb/3Ns5z9qJK4/TmM
         AQZ3wqUSSVQA3S7yUGlYQeQUvudTcI9eYWwEd+f+A0hv+6tlS2N9DAPyaO8iIhn3BQZm
         eXuzRa1UphcBVWcsfHoxNy0t1TnRMPF0o7vPU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683312060; x=1685904060;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yhm3Rctnlx5UPRybogDdMN4gKvloPHqLZXPlqb0HbTI=;
        b=PvNAbU1+XmXrxhkN8hMfzikpDMfs9x20DksYS6EUTtwK4fE46yUkz7NS1Uct276M6s
         Ayfh+LmkPmLoE6uheAjk4n5hJkO2FNjWCvF9TJqJnY8R1fJRU4SwyRykDYqgITmnuRmD
         /XcZz0Kbe98tz9g09ibSfCCH36xbCvQYaoeZWMWvN7X2vsbjqzJu9+C3oLMKjkvk8/UB
         lzKR7Piz5SpcbMsk+6u+uWtpHW48EiMBSvXyjYhjxJSH+yQrb49zIukVsg+Oi8bEnYtI
         N/LRt8KbzTb1/pMwOjOTWYyKZmoqYoIGBRohNWdyrMC7E53Yd+gEcOV6V40x+lzu9IXE
         y3aw==
X-Gm-Message-State: AC+VfDwFSRuYjcf4YGIkUKREXG8J2trDoZxD0C8fg7Tb4ze8GJW7qFVd
        if2dRcUVGyktngKyMZBy0qFLYMorAVVrUB4whWC4nQ==
X-Google-Smtp-Source: ACHHUZ450fxGPJ2ddm1AaDYbb5Hb2ciKnOF67CiGPDQdpJyTfHW1uVbxNyboY44ciZ5Aa1PnpvRzXg==
X-Received: by 2002:a17:907:da4:b0:94e:6eb3:abc4 with SMTP id go36-20020a1709070da400b0094e6eb3abc4mr3154003ejc.4.1683312060377;
        Fri, 05 May 2023 11:41:00 -0700 (PDT)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id g26-20020a17090613da00b00959c07bdbc8sm1242631ejc.100.2023.05.05.11.40.59
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 May 2023 11:40:59 -0700 (PDT)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-50bd2d7ba74so29768639a12.1
        for <linux-block@vger.kernel.org>; Fri, 05 May 2023 11:40:59 -0700 (PDT)
X-Received: by 2002:a17:907:1690:b0:94f:6316:ce8d with SMTP id
 hc16-20020a170907169000b0094f6316ce8dmr2825064ejc.34.1683312059288; Fri, 05
 May 2023 11:40:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230504200527.1935944-1-mathieu.desnoyers@efficios.com>
 <20230504200527.1935944-13-mathieu.desnoyers@efficios.com> <3b017a9f-220d-4da8-2cf6-7f0d6175b30c@efficios.com>
In-Reply-To: <3b017a9f-220d-4da8-2cf6-7f0d6175b30c@efficios.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 5 May 2023 11:40:42 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjzpHjqhybyEhkTzGgTdBP3LZ1FmOw8=1MMXr=-j5OPxQ@mail.gmail.com>
Message-ID: <CAHk-=wjzpHjqhybyEhkTzGgTdBP3LZ1FmOw8=1MMXr=-j5OPxQ@mail.gmail.com>
Subject: Re: [RFC PATCH 12/13] blk-mq.h: Fix parentheses around macro
 parameter use
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, May 5, 2023 at 6:56=E2=80=AFAM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> Which way do we want to go with respect to the rvalue of the assignment
> operator "=3D" in a macro ? (with or without parentheses)
>
> In short:
>
> #define m(x) do { z =3D (x); } while (0)
>
> or
>
> #define m(x) do { z =3D x; } while (0)

I suspect that the first one is preferred, just as a "don't even have
to think about it" thing.

In general, despite my suggestion of maybe using upper-case to show
odd syntax (and I may have suggested it, but I really don't like how
it looks, so I'm not at all convinced it's a good idea), to a
first-order approximation the rule should be:

 - always use parentheses around macros

 - EXCEPT:
     - when used purely as arguments to functions or other macros
     - when there is some syntax reason why it's not ok to add parens

The "arguments to functions/macros" is because the comma separator
between arguments isn't even a operator (ie it is *not* a
comma-expression, it's multiple expressions separated by commas).
There is no "operator precedence" subtlety.

So we have a lot of macros that are just wrappers around functions (or
other macros), and in that situation you do *not* then add more
parentheses, and doing something like

    #define update_screen(x) redraw_screen(x, 0)

is fine, and might even be preferred syntax because putting
parentheses around 'x' not only doesn't buy you anything, but just
makes things uglier.

And the "syntax reasons" can be due to the usual things: we not only
have that 'pass member name around' issue, but we have things like
string expansion etc, where adding parentheses anywhere to things like

    #define __stringify_1(x...)     #x
    #define __stringify(x...)       __stringify_1(x)

would obviously simply not work (or look at our "SYSCALL_DEFINEx()"
games for more complex examples with many layers of token pasting
etc).

But in general I would suggest against "this is the lowest priority
operator" kind of games. Nobody remembers the exact operator
precedence so well that they don't have to think about it.

So for example, we have

    #define scr_writew(val, addr) (*(addr) =3D (val))

to pick another VT example, and I think that's right both for 'addr'
(that requires the parentheses) and for 'val' (that might not require
it, but let's not make people think about it).

                  Linus
