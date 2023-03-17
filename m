Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 587CDC74A5B
	for <linux-block@archiver.kernel.org>; Fri, 17 Mar 2023 21:01:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbjCQVBk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 17 Mar 2023 17:01:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbjCQVBi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Mar 2023 17:01:38 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 995212449F;
        Fri, 17 Mar 2023 14:01:26 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-5416698e889so116360527b3.2;
        Fri, 17 Mar 2023 14:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679086884;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rmSpKjFcHmHL8rGeUuPQJeJhrcZ9F18ZFNOkXCf33SI=;
        b=faBORuccEujB2ofXUkT+3G0AUkN5T3/nXa+d6WK+lKlQ++0REBnoldAEGF0h6yr4zn
         tpwoZ68kqKg24gYObJxxhcTePyv2/Cydn/QNbXUP9gJrDJvkmAFRGtqwOhUx+YSeEq2e
         6fFRsXbeRRoNWf5PvKQUJ1qw3a48f5cgMWYuCLaNswL2XVDQ1xbe8y77aOcn4Q2Oz2mp
         QwRs9ct2DBtMwBtnJ8Xe8J4UpbgF8Mks//f3gGKBXTDu+sSaBaoLMyuhqU4Yq+BdSApl
         VuNtvb635HWvb27YYSAfRliBUoYMww25vPjUcjej/HaoZTbqbG8nAKxtMxP4nunKzM1Q
         wFbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679086884;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rmSpKjFcHmHL8rGeUuPQJeJhrcZ9F18ZFNOkXCf33SI=;
        b=0DX5Ztwvr9suxD8odiJmxq3osvC1ouuyq9jKmuxWUxHP5ivlKmVykJryxS2edz7YAc
         m8caIIXDx3PTCZpFORgHnCEidm5p+l9NpdJ6BVvr1wCUijBk6ODhMmMoVs0VIu8dBZZD
         qbO245rlow9qBTgB1zAPBARYoxChRzJfJHNC4xLQ/Oq7ERMFNGPX4L6kbcsDvMAfjeY7
         IZwp5iqxVuIKh+7XIOVuNvtXIaI8CNIyv92DVXVfvcTDybW8a8dx4eeBYvzMimtGkAzA
         in4kf8pgmY9DuQTq/iv/z/Q9Ey8+ACeir++Qt43DaEcNK9wQIXIPPutVVK8nwU7fHn/h
         wrPg==
X-Gm-Message-State: AO0yUKWGn44x0knEAyppjNpquSdZ5aXiPpSLAXy8+XtAlxWuW4fr0Rpy
        tyN2pZ3NGY/tI/7ouKTicw/KALVoSbI//HBMIEE=
X-Google-Smtp-Source: AK7set+r1O/bxArezUGcdbwFLlX57QJXdgB3yEG3wjKU4O6PF/YfPvoHzhrTncGLX4waxiwXxbF1temZW9vLbcog2Yk=
X-Received: by 2002:a81:ca10:0:b0:544:6828:3c09 with SMTP id
 p16-20020a81ca10000000b0054468283c09mr5393575ywi.0.1679086884296; Fri, 17 Mar
 2023 14:01:24 -0700 (PDT)
MIME-Version: 1.0
References: <9d0ef355-f430-e8e2-c844-b34cfcf60d88@kernel.dk>
 <CAHk-=wgcYvgJ5YWJPy6PA-B_yRtPfpw01fmCqtvqGN9jouc_8w@mail.gmail.com>
 <CAKwvOdmJkQUe6bhvQXHo0XOncdso0Kk26n8vdJZufm4Ku72tng@mail.gmail.com>
 <6414c470.a70a0220.6b62f.3f02@mx.google.com> <CAHk-=wi5yk0+NeqB34fRC-Zvt+8QZVPTiny9MvCxxjg+ZqDhKg@mail.gmail.com>
 <CANiq72m46OzQPtZbS_VaQGgGknFV-hKvhBw8sVZx9ef=AzupTQ@mail.gmail.com> <CAHk-=wgTSdKYbmB1JYM5vmHMcD9J9UZr0mn7BOYM_LudrP+Xvw@mail.gmail.com>
In-Reply-To: <CAHk-=wgTSdKYbmB1JYM5vmHMcD9J9UZr0mn7BOYM_LudrP+Xvw@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 17 Mar 2023 22:01:12 +0100
Message-ID: <CANiq72kASorz1Oy-rsNzCNG99qrRPkQB=Xt4XfbPaxX5_poHuQ@mail.gmail.com>
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

On Fri, Mar 17, 2023 at 9:51=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Yeah, I see what it's doing.

Yeah, sorry, I saw your later email after sending that one.

> Yeah, but clang really should have generated a proper third iteration,
> which calls that "out of bounds" case, and then returns, instead fo
> falling off the end.
>
> I do think that on the kernel side, the fix is to just change
>
>         } while (type++ !=3D SIZE_DEFAULT_FFMT);
>
> to
>
>         } while (++type !=3D SIZE_DEFAULT_FFMT);
>
> but I would *really* like clang to be fixed to not silently generate
> code that does insane things and would be basically impossible to
> debug if it ever triggers.

Not sure how easy is for them to realize that they should do a 3rd
iteration. But perhaps it would be possible that Clang/LLVM does a
similar check to objtool and at least emit a warning about similar
situations that would help developers diagnose this (since it should
have way more information about what happened than objtool).

Cheers,
Miguel
