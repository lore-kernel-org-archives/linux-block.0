Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26705C7618B
	for <linux-block@archiver.kernel.org>; Fri, 17 Mar 2023 20:36:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbjCQUgQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 17 Mar 2023 16:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjCQUgO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Mar 2023 16:36:14 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3458C4D286
        for <linux-block@vger.kernel.org>; Fri, 17 Mar 2023 13:36:09 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id q14so3839222pff.10
        for <linux-block@vger.kernel.org>; Fri, 17 Mar 2023 13:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679085368;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K04P+o6YM0YyjlP+vZnYzniJaURtnib4ezA1Ng9nb8A=;
        b=a0WG48czdirL+zHsrElBt8WlWDWVuOlLfEPL0p0659vNL0+IbE1aDHvsnv3VefsN9B
         wFPRQ2+y2/PwPU8p9Ob4NOpbkswtvylRG9uNs8DEGg5k5vxxDzejTGy0/PxnO08TLEXc
         tjdHzNBPt80s9eRVikjzxAkXwBfJbrdSOgj8RWo+dqVw8IzkBp1biw5Wt9xFw2AbR7J8
         pk/b6x/HE/KiC5Gh/7pxUGL/uY3wljVt6bkyaF1KI715Xoyutb+sw80kxzs1KV4huhCm
         RlIjYo5ZAbEMDpSp+iuZCcRjBv0y5I6mI/tiYYQR0JO0748JxGHewJDCa/gug9+vMP0p
         vqeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679085368;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K04P+o6YM0YyjlP+vZnYzniJaURtnib4ezA1Ng9nb8A=;
        b=qMgrTuxqm9Saae1uU1/r2JM/QARDopwCp1jLRnQen0M+NwtD88bxbRPIUdNh7lpsse
         minzvY9GOkTDZ7Ij91lTaSNAgzLl4D+VO698yaUIv+jdB1z2+DjyaneBHGpr0vc+3u8c
         Wu4xFbCcu8D3Hkw5Jkcp3jV9Q3/xZM26JWGJurUHr7ftPWxmMG+5ZXmXJU+Wj2+UfA3N
         HVQ/FWGd44lguQbhrFvUQC996w00CLmXrlzzQYQUOja5f2TOCPrTYAt1mlbQ4Mr3Pq0r
         trFF7mUsdjc9wmxm1QlAFxq8hgqOB2xDn0OxmzCoQVimKjgU3PUzCHbzX72m+8HUTfv3
         +wAQ==
X-Gm-Message-State: AO0yUKXdEYsrcxILb3rHR9vnyTILkTMVaIO5JGN9ZKKJ2IfzwVf9cG8U
        dM2HgLv5B/hRObCN1NGHAyA6/1L8xhx42/BFTD0VQw==
X-Google-Smtp-Source: AK7set9/WXKcZWIQ/Nif1/Dts9WfJCla2y4PU0i0LS9xPr6VYsj3+6cO5VX/SkS8ztnTu8TNLWkSRC+46XTItrjwiNE=
X-Received: by 2002:a05:6a00:14d5:b0:625:c832:6a10 with SMTP id
 w21-20020a056a0014d500b00625c8326a10mr3936666pfu.4.1679085368311; Fri, 17 Mar
 2023 13:36:08 -0700 (PDT)
MIME-Version: 1.0
References: <9d0ef355-f430-e8e2-c844-b34cfcf60d88@kernel.dk>
 <CAHk-=wgcYvgJ5YWJPy6PA-B_yRtPfpw01fmCqtvqGN9jouc_8w@mail.gmail.com>
 <CAKwvOdmJkQUe6bhvQXHo0XOncdso0Kk26n8vdJZufm4Ku72tng@mail.gmail.com> <6414c470.a70a0220.6b62f.3f02@mx.google.com>
In-Reply-To: <6414c470.a70a0220.6b62f.3f02@mx.google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 17 Mar 2023 13:35:56 -0700
Message-ID: <CAKwvOd=MQmDMSpoLb3c081+wGAvGr3hHE0uGgXYm=FrvEprDMw@mail.gmail.com>
Subject: Re: [GIT PULL] Block fixes for 6.3-rc3
To:     Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Nathan Chancellor <nathan@kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Mar 17, 2023 at 12:50=E2=80=AFPM Kees Cook <keescook@chromium.org> =
wrote:
>
> On Fri, Mar 17, 2023 at 11:59:11AM -0700, Nick Desaulniers wrote:
> > +Sanitizer folks (BCC'd)
> > (Top of lore thread:
> > https://lore.kernel.org/linux-block/9d0ef355-f430-e8e2-c844-b34cfcf60d8=
8@kernel.dk/)
> >
> > On Fri, Mar 17, 2023 at 11:35=E2=80=AFAM Linus Torvalds
> > <torvalds@linux-foundation.org> wrote:
> > >
> > > On Fri, Mar 17, 2023 at 10:16=E2=80=AFAM Jens Axboe <axboe@kernel.dk>=
 wrote:
> > > > Side note - when doing the usual allmodconfig builds with gcc-12 an=
d
> > > > clang before sending them out, for the latter I see this warning be=
ing
> > > > spewed with clang-15:
> > > >
> > > > drivers/media/i2c/m5mols/m5mols.o: warning: objtool: m5mols_set_fmt=
() falls through to next function m5mols_get_frame_desc()
> > > >
> > > > Obviously not related to my changes, but mentioning it in case it h=
as
> > > > been missed as I know you love squeaky clean builds :-). Doesn't ha=
ppen
> > > > with clang-14.
> > >
> > > Hmm. I have clang-15 too, but I do the allmodconfig builds with gcc,
> > > and only my own "normal config" builds with clang.
> > >
> > > So I don't see this particular issue and my builds are still squeaky =
clean.
> > >
> > > That said, when I explicitly try that allmodconfig thing with clang, =
I
> > > can see it too. And the reason seems to be something we've seen
> > > before: UBSAN functions being considered non-return by clang, so clan=
g
> > > generates code like this:
> > >
> > >    ....
> > > .LBB24_3:
> > >         callq   __sanitizer_cov_trace_pc@PLT
> > >         movl    $2, %esi
> > >         movq    $.L__unnamed_3, %rdi
> > >         callq   __ubsan_handle_out_of_bounds
> > > .Lfunc_end24:
> > >         .size   m5mols_set_fmt, .Lfunc_end24-m5mols_set_fmt
> > >
> > > ie the last thing in that m5mols_set_fmt() function is a call to
> > > __ubsan_handle_out_of_bounds, and then it "falls through" to the next
> > > function.
> > >
> > > And yes, I absolutely *detest* how clang does that. Not only does it
> > > cause objtool sanity checking issues, it fundamentally means that we
> > > can never treat UBSAN warnings as warnings. They are always fatal.
>
> I've hit these cases a few times too. The __ubsan_handle_* stuff
> is designed to be recoverable. I think there are some cases where
> we're tripping over Clang bugs, though. Some of the past issues
> have been with Clang thinking some UBSAN feature was trap-only
> (e.g. -fsanitizer=3Dlocal-bounds), but here it actually generated the cal=
l,
> but decided it was no-return. *sigh*

I think no-return is a red herring (or rather, I don't think noreturn
is at play here at all). Looking at the IR, I don't see anything that
indicated anything was deduced to be noreturn.

It looks like this is coming from the loop in __find_restype() being
fully unrolled.

On the initial iteration, `type` =3D=3D `M5MOLS_RESTYPE_MONITOR` =3D=3D 0.
`m5mols_default_ffmt` is a 2 element array.
If we don't match we loop again, `type` =3D=3D `M5MOLS_RESTYPE_CAPTURE` =3D=
=3D 1.
`SIZE_DEFAULT_FFMT` =3D=3D ARRAY_SIZE(m5mols_default_ffmt) =3D=3D 2, so we =
loop again.
`type` =3D=3D 2, accessing m5mols_default_ffmt out of bounds.

Perhaps this code meant to simply use a for loop rather than do-while?
(Or pre-increment rather than post increment for the do-while)?

```
diff --git a/drivers/media/i2c/m5mols/m5mols_core.c
b/drivers/media/i2c/m5mols/m5mols_core.c
index 2b01873ba0db..603b1036127e 100644
--- a/drivers/media/i2c/m5mols/m5mols_core.c
+++ b/drivers/media/i2c/m5mols/m5mols_core.c
@@ -485,10 +485,9 @@ static enum m5mols_restype __find_restype(u32 code)
 {
        enum m5mols_restype type =3D M5MOLS_RESTYPE_MONITOR;

-       do {
+       for (; type !=3D M5MOLS_RESTYPE_MAX; ++type)
                if (code =3D=3D m5mols_default_ffmt[type].code)
                        return type;
-       } while (type++ !=3D SIZE_DEFAULT_FFMT);

        return 0;
 }
```

>
> > > But I suspect we need to disable UBSAN for clang, because clang gets
> > > this so *horribly* wrong.

I think Linus is thinking about,
commit e5d523f1ae8f ("ubsan: disable UBSAN_DIV_ZERO for clang")

I can see the loop unroller inserting a branch on "poison" which is a
magic value in LLVM related to but distinct from "undef".  That gets
replaced with an "unreachable" instruction.
I wonder if we can change loop unroller to not insert branch on poison
when the sanitizers are enabled, or freeze poison.
https://llvm.org/devmtg/2020-09/slides/Lee-UndefPoison.pdf

Maybe Linus has thoughts he can share on this thread:
https://github.com/llvm/llvm-project/issues/56289?

Finally, there's always `-mllvm -trap-unreachable` though that's a
last resort kind of thing; `-mllvm` flags need to be passed to the
linker for LTO, and compiler for non-LTO and LTO.  I do think in this
case that the fallthough is bringing to our attention an issue in the
source.

>
> Which is to say, it normally gets it right, but there are some instances
> where things go weird. If it was horribly wrong, there would be a LOT
> more objtool warnings. :)
>
> I'm not opposed to disabling UBSAN for all*config builds if we need to,
> but I want to get these Clang bugs found and fixed so I'd be sad to lose
> the coverage.
>
> --
> Kees Cook



--
Thanks,
~Nick Desaulniers
