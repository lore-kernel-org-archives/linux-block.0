Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27599C7618B
	for <linux-block@archiver.kernel.org>; Fri, 17 Mar 2023 21:00:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbjCQVAb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 17 Mar 2023 17:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbjCQVA3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Mar 2023 17:00:29 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91B10B1A49
        for <linux-block@vger.kernel.org>; Fri, 17 Mar 2023 14:00:28 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id o12so25141343edb.9
        for <linux-block@vger.kernel.org>; Fri, 17 Mar 2023 14:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1679086827;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oZhGvYYe72+EpjoPoiXYwYh2DEQKfYqrF7Ny0kVjGfo=;
        b=bFc0Pc8sXPyYD8hJfB75Je/AWDEaqDQIZcaDrX71XHxJyGUFwcwpRgO9/bCgLPAhi/
         k2z+xzWbM6myBql6/edUy7WUteXBZ0FUU0NO48BMEiEe+BHuiFf3xe0CSmgNetoMFX7Q
         2rc34LiYQV7auDHqin9gPlDHU5jCjsDAE9l0s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679086827;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oZhGvYYe72+EpjoPoiXYwYh2DEQKfYqrF7Ny0kVjGfo=;
        b=gokz6WoYx4YJ2zW3VqCP5b+jr/L75lQ0a8eE4iHDqgfJgvSadesc1g0In4sbS83Kwd
         +JCtSgUwfROxUuxFVmi324qmfyTBWypik5ZGhj4WF7hTU+fbCeaDE+kJegRq28kNBWrH
         KR1i7dVQrGSqweDfZvQlcIhgTQZqcFLbbaXHR6EizRoqrfR991Ddko5YCG4R6nnS/ecj
         1i8AoVN65JSXKZvZd4U8+kQn+kR1WlP1+ap9Ff6f4ojdsw872gFdky/iElpGJU7oXbAE
         SfdXb5Aoy6q3mtLB5jYKeIEwjt1JogaCcEZrjN6kt5RHGnqKCof+lYmnx3U/0t3eZrWG
         Dx6A==
X-Gm-Message-State: AO0yUKW+XnI1hR3WRP2CfNQm17jrVU/xq+s/zCm2vcZmbnX1gNf8i5hF
        6HZ7e6gK+139Fe6wzueE0NU8reKTc+gdwKhdmhCOYQ==
X-Google-Smtp-Source: AK7set/A79Ud5GFqLrMVdeae25oSvmUgzza2Al7lBDXKraFqncWW6rex8vA+bCJIGYqotZTodOEbTQ==
X-Received: by 2002:aa7:cf18:0:b0:4fd:236f:7d4d with SMTP id a24-20020aa7cf18000000b004fd236f7d4dmr4549824edy.18.1679086826733;
        Fri, 17 Mar 2023 14:00:26 -0700 (PDT)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id x23-20020a50d617000000b004fa268da13esm1557155edi.56.2023.03.17.14.00.26
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Mar 2023 14:00:26 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id x13so25246348edd.1
        for <linux-block@vger.kernel.org>; Fri, 17 Mar 2023 14:00:26 -0700 (PDT)
X-Received: by 2002:a17:906:ef8f:b0:8de:c6a6:5134 with SMTP id
 ze15-20020a170906ef8f00b008dec6a65134mr298086ejb.15.1679086825747; Fri, 17
 Mar 2023 14:00:25 -0700 (PDT)
MIME-Version: 1.0
References: <9d0ef355-f430-e8e2-c844-b34cfcf60d88@kernel.dk>
 <CAHk-=wgcYvgJ5YWJPy6PA-B_yRtPfpw01fmCqtvqGN9jouc_8w@mail.gmail.com>
 <CAKwvOdmJkQUe6bhvQXHo0XOncdso0Kk26n8vdJZufm4Ku72tng@mail.gmail.com>
 <6414c470.a70a0220.6b62f.3f02@mx.google.com> <CAHk-=wi5yk0+NeqB34fRC-Zvt+8QZVPTiny9MvCxxjg+ZqDhKg@mail.gmail.com>
 <CANiq72m46OzQPtZbS_VaQGgGknFV-hKvhBw8sVZx9ef=AzupTQ@mail.gmail.com> <CAHk-=wgTSdKYbmB1JYM5vmHMcD9J9UZr0mn7BOYM_LudrP+Xvw@mail.gmail.com>
In-Reply-To: <CAHk-=wgTSdKYbmB1JYM5vmHMcD9J9UZr0mn7BOYM_LudrP+Xvw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 17 Mar 2023 14:00:09 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgLBjQZ1Xic9SDvtPOu3MNwRznZygZ35mqq4CpKmWdBtA@mail.gmail.com>
Message-ID: <CAHk-=wgLBjQZ1Xic9SDvtPOu3MNwRznZygZ35mqq4CpKmWdBtA@mail.gmail.com>
Subject: Re: [GIT PULL] Block fixes for 6.3-rc3
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jens Axboe <axboe@kernel.dk>,
        Nathan Chancellor <nathan@kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Mar 17, 2023 at 1:51=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> but I would *really* like clang to be fixed to not silently generate
> code that does insane things and would be basically impossible to
> debug if it ever triggers.

Side note: the key word here is "silently".

If clang notices that it generates crazy code, a warning at build-time
would be preferable to the "oh, we noticed the crazy code generation
because we do sanity checking that just happened to catch it".

If that "fall-through due to impossible third iteration" had happened
*inside* the function, rather than at the end, we'd have never
noticed.

So we were kind of lucky in just where things triggered this time.
Maybe that's always going to be true due to some random internal clang
logic ("dead code fallthrough is always at the end because of how we
sort basic blocks"), but I don't see why it would be in general.

                      Linus
