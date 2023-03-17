Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FCCCC6FD1D
	for <linux-block@archiver.kernel.org>; Fri, 17 Mar 2023 20:32:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbjCQUcK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 17 Mar 2023 16:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbjCQUcH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Mar 2023 16:32:07 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF0A01B31F
        for <linux-block@vger.kernel.org>; Fri, 17 Mar 2023 13:31:40 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id e194so7080022ybf.1
        for <linux-block@vger.kernel.org>; Fri, 17 Mar 2023 13:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679085095;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LAOavDnRCoSnVP+J06YC2/4u8vunh0Z+T3beJB56tGs=;
        b=k+EG32PX1ks8+ifXvbd81Om1X7/ouU/fclSmvOJQ6z8d4A6BhoFcR2hmyn0VZcZpvN
         4BcY253DsV872KX7/Kl0FOFevZo708obZXDpwJa9PTfrgTD9Sd6OhYi2T9HUPcQqpn5L
         gcStPAaLdZ3v4xIb1toioU5nnc/lrFSRDu7Gk0x6OJYBniOascUkYHSALyL88KBT6K0V
         gDQCqjTxDfVppLvIAQjw+x5qkPmA9cwvr62NCfwFDGb3m87FE9OoioXhs3DBARJbBeE4
         t6uMnQEILgooKqjurhy58mcUi/pFqOlG/OocDFsjtsVFodAq60elK4rbquPFR3C8TFr1
         8ryA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679085095;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LAOavDnRCoSnVP+J06YC2/4u8vunh0Z+T3beJB56tGs=;
        b=nyBVHcLI69U/DZlwmtFP8rMiCfjmvkWkzpcHKqN6x2ezUVRqaRy5xNhA60E6zZ1H9j
         FSlbt4VstI5LYRgPwiYFCffwON6ZnKuSH7rzkJGYoDByTSn26+83U1EH4wD16X0Xhbck
         M/Ivq9tEzBE7mVp3/xb+2O2Es1A8fY7HtfR+NrUW2KbfiBuoqsZMTuFNiRWYjA1gBXvx
         US3+W1ROMtvgz8t+lYXegJgF6J2dMUQtPyKaqHHnguz23mA04iakkOo42yzXJEW04o/J
         1KZqW/YC005CzH1+nyKv+16dE4FjNwGYg6wwrIj56e5NKiB51AUYvkCzi5i2c8QKD3D0
         q09A==
X-Gm-Message-State: AO0yUKWxx186o5vlPIGqjvExYOwd8VjXoUgaxa0b1yGanrBpVdrloW0z
        A/AaUe5xLNVr1APxlF1UWGOw9+QVsusM5A1PMqg=
X-Google-Smtp-Source: AK7set8lugLqGHowHkdXeIrEFyz+BTJvhQtaUcRiKKfFq6PTMzogHg2zvMvP7eBqclL95hiTyI6xGRcA0qPJTZRMXEg=
X-Received: by 2002:a25:e90b:0:b0:b21:5fb4:c6e6 with SMTP id
 n11-20020a25e90b000000b00b215fb4c6e6mr465188ybd.11.1679085095448; Fri, 17 Mar
 2023 13:31:35 -0700 (PDT)
MIME-Version: 1.0
References: <9d0ef355-f430-e8e2-c844-b34cfcf60d88@kernel.dk>
 <CAHk-=wgcYvgJ5YWJPy6PA-B_yRtPfpw01fmCqtvqGN9jouc_8w@mail.gmail.com> <CAHk-=wj1wYh_2d8Y1Vm6YjPTh4yMqWc++aWVY2LpX7n_atc2hA@mail.gmail.com>
In-Reply-To: <CAHk-=wj1wYh_2d8Y1Vm6YjPTh4yMqWc++aWVY2LpX7n_atc2hA@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 17 Mar 2023 21:31:24 +0100
Message-ID: <CANiq72kjd+NES2mSthLKZduFm_KrwLShngs6jLqhoQPSb+1d-g@mail.gmail.com>
Subject: Re: [GIT PULL] Block fixes for 6.3-rc3
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Mar 17, 2023 at 7:50=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Debug support *MUST* have an option to just continue. Sure, make "this
> is fatal" be an option *too*, because if you are a developer, maybe
> you really want the "fail hard, fail quickly" behavior.

At least for userspace it has different modes -- the default is to
report and continue:

    -fsanitize=3D...: print a verbose error report and continue
execution (default);
    -fno-sanitize-recover=3D...: print a verbose error report and exit
the program;
    -fsanitize-trap=3D...: execute a trap instruction (doesn=E2=80=99t requ=
ire
UBSan run-time support).
    -fno-sanitize=3D...: disable any check, e.g., -fno-sanitize=3Dalignment=
.

    (https://clang.llvm.org/docs/UndefinedBehaviorSanitizer.html#usage)

For the kernel I assume it is meant to work due to `UBSAN_TRAP`, but
the optimizer may be getting in the way.

From a quick look, it seems that `__find_restype` (which gets inlined
into `m5mols_set_fmt` via `__find_resolution`) has a small loop:

    do {
        if (code =3D=3D m5mols_default_ffmt[type].code)
            return type;
    } while (type++ !=3D SIZE_DEFAULT_FFMT);

that I guess gets simplified into something like:

    if (code =3D=3D first code)
        yield 0;
    if (code =3D=3D second code)
        yield 1;
    out of bounds;

When UBSAN is disabled, it may be assuming:

    if (code =3D=3D first code)
        yield 0;
    yield 1;

Thus no issue.

Though even with UBSAN disabled, if I add a dummy opaque call inside
the loop, it goes back to something like before, except the jump goes
nowhere and then `objtool` complains again:

    .LBB24_20:
        callq    dummydummydummy
    .Lfunc_end24:

So it is reproducible even without UBSAN getting involved:
https://godbolt.org/z/hTe91b3eG

Cheers,
Miguel
