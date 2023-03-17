Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9863BC74A5B
	for <linux-block@archiver.kernel.org>; Fri, 17 Mar 2023 20:45:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbjCQUpa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 17 Mar 2023 16:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbjCQUp3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Mar 2023 16:45:29 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CEAC1A657
        for <linux-block@vger.kernel.org>; Fri, 17 Mar 2023 13:45:27 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id er8so13348189edb.0
        for <linux-block@vger.kernel.org>; Fri, 17 Mar 2023 13:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1679085925;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gss4H1ZQ+0ilRx2yopl9iBc9rNAe4OOqCmcGOGIMEWs=;
        b=Hr5oAwRMlaXswLvnugh2M3B3g/p43gsdtsOhUCr6hgmhINOc1j074sVKUrfWxhsV6A
         Ji9+MSUk3lUIXEDcaWubxFGCzudpHRcwv6FYrJn1ybq8R+zlcdYMEMnK7h1Y3lI3A4Da
         0lwzVNQ4Exx/4xTIgozQrAadSU4FDy++qhOKs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679085925;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gss4H1ZQ+0ilRx2yopl9iBc9rNAe4OOqCmcGOGIMEWs=;
        b=DQvH5ng3An9uwaRg5VAWFFU2IdoGqGTBfFmwwM+e8phv+/dFa6lH9kzJLY/x4PsAwg
         mrjMx+g05KVdhcIV9yOJ4fFj0sQiDsCnBYoATTUOJAM7mySJFwFuY92ImMg8We3GCZru
         rAazZN/B7ZqiB0/n8IgAlsgQTucmBI2RRwUIfBkrKzMmNaRbaYhLul19oq6MweLQI7xI
         uQ4tN2WszZp9WQn5PGEx6yJKEHUT90P6hMKDoo4sTC1nNCjMYg5inYwqUvFwYih/k0xy
         JPIw7c0JDQI5zUSnrwAMTEuci/+ybiUj4W0DBU0Nu7MEv6lGgHg906taQogTH1udiIM0
         CGNw==
X-Gm-Message-State: AO0yUKXNedQkitN8VrZOR+J2ecQ8VHLcgMo4D92jqiG5NQCM/Ch3gUQW
        z48ZlVFAUlSrMVfsf79uDfgTy/8DwKNVBYulnjjVwA==
X-Google-Smtp-Source: AK7set8IaUsOthDHy2I10ww5j9AsqLWaCG5hLpFrHZlTtcJ8h+JTjyx5wFGyxA8JEnWtURATSz4yiQ==
X-Received: by 2002:a17:907:774c:b0:932:3d1b:b67a with SMTP id kx12-20020a170907774c00b009323d1bb67amr767498ejc.41.1679085925683;
        Fri, 17 Mar 2023 13:45:25 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id 11-20020a170906300b00b0093137b1f23fsm1362473ejz.37.2023.03.17.13.45.24
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Mar 2023 13:45:24 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id er8so13347886edb.0
        for <linux-block@vger.kernel.org>; Fri, 17 Mar 2023 13:45:24 -0700 (PDT)
X-Received: by 2002:a50:d54a:0:b0:4fc:a484:c6ed with SMTP id
 f10-20020a50d54a000000b004fca484c6edmr2431609edj.2.1679085923690; Fri, 17 Mar
 2023 13:45:23 -0700 (PDT)
MIME-Version: 1.0
References: <9d0ef355-f430-e8e2-c844-b34cfcf60d88@kernel.dk>
 <CAHk-=wgcYvgJ5YWJPy6PA-B_yRtPfpw01fmCqtvqGN9jouc_8w@mail.gmail.com>
 <CAHk-=wj1wYh_2d8Y1Vm6YjPTh4yMqWc++aWVY2LpX7n_atc2hA@mail.gmail.com> <CANiq72kjd+NES2mSthLKZduFm_KrwLShngs6jLqhoQPSb+1d-g@mail.gmail.com>
In-Reply-To: <CANiq72kjd+NES2mSthLKZduFm_KrwLShngs6jLqhoQPSb+1d-g@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 17 Mar 2023 13:45:07 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj3c3Y9fWJjOwvQ0fN6hciWoh8xV69tcRqDm=tpQP14Ew@mail.gmail.com>
Message-ID: <CAHk-=wj3c3Y9fWJjOwvQ0fN6hciWoh8xV69tcRqDm=tpQP14Ew@mail.gmail.com>
Subject: Re: [GIT PULL] Block fixes for 6.3-rc3
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
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

On Fri, Mar 17, 2023 at 1:31=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> From a quick look, it seems that `__find_restype` (which gets inlined
> into `m5mols_set_fmt` via `__find_resolution`) has a small loop:
>
>     do {
>         if (code =3D=3D m5mols_default_ffmt[type].code)
>             return type;
>     } while (type++ !=3D SIZE_DEFAULT_FFMT);
>
> that I guess gets simplified into something like:
>
>     if (code =3D=3D first code)
>         yield 0;
>     if (code =3D=3D second code)
>         yield 1;
>     out of bounds;

Ahh. That explains the odd constants I saw. I did figure out it had
something to do with loading 'mf->code', but then it went off the
rails.

> Though even with UBSAN disabled, if I add a dummy opaque call inside
> the loop, it goes back to something like before, except the jump goes
> nowhere and then `objtool` complains again:
>
>     .LBB24_20:
>         callq    dummydummydummy
>     .Lfunc_end24:
>
> So it is reproducible even without UBSAN getting involved:
> https://godbolt.org/z/hTe91b3eG

That code generation is some crazy stuff.

Yeah, that's not acceptable, and the bug is clearly not UBSAN, but
some generic bogus clang thing.

Much nicer to try to debug this as a "objtool complains about the
generated code" rather than as some insane runtine problem with code
falling off the end of the function.

                Linus
