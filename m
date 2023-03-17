Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A587FC7618B
	for <linux-block@archiver.kernel.org>; Fri, 17 Mar 2023 20:42:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbjCQUmR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 17 Mar 2023 16:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbjCQUmP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Mar 2023 16:42:15 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D09755517;
        Fri, 17 Mar 2023 13:42:14 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id t6so1009536ybb.9;
        Fri, 17 Mar 2023 13:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679085733;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jKqoQMP0cjX6fBJ5Baqr7Cd+5/vuvlm7dezKEA7BumQ=;
        b=OCGa9zSyWLiqiTOYurkRhYHYwN1IW/7p8tGRKYwOYRzWrYTtQe+roJbaEFZMlTPmLF
         mD2N4cUANRFbs1zHFfn495ZSISEGqYDzdrq/syIB1G8Jmp63diqX2hSaPQLNDsuoRwH9
         NOw8U7+kyEnSkTVjJJscfl2Ar07uHG0Sd9hb2bEykj6da6XLFCJZP6j7AnvV0COWl71J
         DZILg3uBs/tuXz25kq8LTzw0WXKIVoUFNiwdmmoktFhJaHAeQVTLBYYlDovGv+wUSbhs
         tsJdWJ1L4qaM7sHIBcNKnHVcRptRu6gNapoZXaIGC39vAJJaZNrX3SLlz7HtEAHYPO1z
         YjGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679085733;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jKqoQMP0cjX6fBJ5Baqr7Cd+5/vuvlm7dezKEA7BumQ=;
        b=HVrIThvusjBOam1GAEkhNpzkgixg2vAfuQR9/vWt/fahBEVpUZzQvrHYUwne6HTzXr
         s7VW9HAUPgHcCpxzS3AYf290sZjXJCG8e1gjyNjkmwy+nmq7day3AuuVgm8CfOmu8sgF
         fsUCYTbD+jFSpmEAcWQzpltmh9sazJXUCgii2xgzydtvIyrm4B8GopRQT2sCovFOyJOt
         0OzyAFWU9lbJ9YQ1YRkRXex1S+AJ0ne/3QbhnT4QJpmDRPGJLnDzAj0Rz09cl1HtdZ0r
         uexkQ+XyzmE8ONu0v6Ekd02jmrDDVWagf+7iEU7wbMViBOG9Y6SAYPXzzEZZQdZcwqda
         T2TQ==
X-Gm-Message-State: AO0yUKUhTzxlP4au2eL9cTUk0W81b7vxcan7CJYxPejPlXWoXvaokYrq
        qIDaqBkl5sK5CApP4nZDruFOt6n7LHUxD9GD8bg=
X-Google-Smtp-Source: AK7set9NqnQJsWl7rP+FHX5er2KO10BEglkFdEEEJn0DvKX5dso/jIWWueYin0ZzNqMU9obvzXGF8nSJrWcmkJvL6Cg=
X-Received: by 2002:a25:ec0c:0:b0:b1d:d57:fbef with SMTP id
 j12-20020a25ec0c000000b00b1d0d57fbefmr584281ybh.11.1679085732986; Fri, 17 Mar
 2023 13:42:12 -0700 (PDT)
MIME-Version: 1.0
References: <9d0ef355-f430-e8e2-c844-b34cfcf60d88@kernel.dk>
 <CAHk-=wgcYvgJ5YWJPy6PA-B_yRtPfpw01fmCqtvqGN9jouc_8w@mail.gmail.com>
 <CAKwvOdmJkQUe6bhvQXHo0XOncdso0Kk26n8vdJZufm4Ku72tng@mail.gmail.com>
 <6414c470.a70a0220.6b62f.3f02@mx.google.com> <CAHk-=wi5yk0+NeqB34fRC-Zvt+8QZVPTiny9MvCxxjg+ZqDhKg@mail.gmail.com>
In-Reply-To: <CAHk-=wi5yk0+NeqB34fRC-Zvt+8QZVPTiny9MvCxxjg+ZqDhKg@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 17 Mar 2023 21:42:02 +0100
Message-ID: <CANiq72m46OzQPtZbS_VaQGgGknFV-hKvhBw8sVZx9ef=AzupTQ@mail.gmail.com>
Subject: Re: [GIT PULL] Block fixes for 6.3-rc3
To:     Linus Torvalds <torvalds@linux-foundation.org>
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

On Fri, Mar 17, 2023 at 9:31=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> 'enum m5mols_restype' should be in the range 0..2, but it seems to use
> a 64-bit compare against '16385' (and then a 32-bit compare against
> '8199') to decide it's out-of-bounds.

It is comparing against just the `.code` in the `m5mols_default_ffmt`
table, i.e. the `MEDIA_BUS_FMT_VYUY8_2X8` (8199 =3D 0x2007) and
`MEDIA_BUS_FMT_JPEG_1X8` (16385 =3D 0x4001), see
https://elixir.bootlin.com/linux/latest/source/drivers/media/i2c/m5mols/m5m=
ols_core.c#L52.

So it is basically:

    if (code =3D=3D m5mols_default_ffmt[0].code)
        return type;
    if (type =3D=3D 2)
        continue;
    ++type;

    if (code =3D=3D m5mols_default_ffmt[1].code)
        return type;
    if (type =3D=3D 2)
        continue;
    ++type;

    m5mols_default_ffmt[2].code -> out of bounds UB -> unreachable

If the condition had `++type` instead, it would not be a problem,
because the loop stops before we go into the out of bounds access thus
no UB.

Cheers,
Miguel
