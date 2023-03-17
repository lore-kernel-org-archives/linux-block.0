Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D338C6FD1D
	for <linux-block@archiver.kernel.org>; Fri, 17 Mar 2023 18:59:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbjCQS7v (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 17 Mar 2023 14:59:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbjCQS7s (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Mar 2023 14:59:48 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AA70CA00
        for <linux-block@vger.kernel.org>; Fri, 17 Mar 2023 11:59:23 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id v21so6296448ple.9
        for <linux-block@vger.kernel.org>; Fri, 17 Mar 2023 11:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679079563;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YdbsllINb0v9Gak3RMgfN2RxSUwAAmVJ3OhZyFi4WHw=;
        b=k+uChbs64bL79yGua7FKZhzd3fgGnzeDpk04MTG70urVc55rIYPAvmWfyFPyTFp6BO
         roslFhr/Dj2EA3LoT04TL4ZCDM7+0oh5d2UTGvgzmsLpAtDryoLWCblwuewX1sGZgdaz
         KKKchvzKVrG8EfI4a2u9y+1lgjCAXbSPYFKACreL2rydu28Z6SEeBV9EgYIY6sdxlyBQ
         ClE0HVchSu1FCVnnDO2zII0+I1rI7Z7SnEtULjQbonPCsi+3CKTgUSqoUfFOwgcLEryj
         oq9oA6YxgrbXNyDiqISHvbx2PcFjZHGMHRDzXBaby/p6dgbBjEVdbI9EWPbOxgQrZGG9
         wQWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679079563;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YdbsllINb0v9Gak3RMgfN2RxSUwAAmVJ3OhZyFi4WHw=;
        b=tgO2F7urPEtnhW7etnpngSSESUcTbIs/gNxFOcC/KQYin56RrHU88apGAlcr5iOkwA
         +l5eDTSnrXJlyn9ou1wzlWLebUn/S/91b+GhMVDMGP8Mou//42iQZkJDpPeqHQdVjyJX
         UOHJilli/IPE16CxQ3NbPa8DMUOhvzMIWSnKiCG+GkxuOcmrg3OdTJsBy7ngE7aERtdN
         WpdZLJybbW67Cqe/5STHDfoYyYFUGgmuihCAb3dzxqCmvNS8lWW3EHzRwqUPt7x9Gmoi
         Z38HUAJmTnSrUNCMFe0QeXfXPWIiPHiQ0rjCZ5OyQ5CPlZJzQx8hyoo1mDqLiGbbC8IV
         kp8Q==
X-Gm-Message-State: AO0yUKUSsHks3YWz8VLp5JL2prKpvXu6rQqR/PZSHnOS8DqPEI44s5Sa
        VxR5bQNYc+i+hS08KBp4kyufObhOYV1ga9CwRwqH+g==
X-Google-Smtp-Source: AK7set/37emJIMDdhZRjXztwTWML/IAIOOUvhiwFLM67CD2ghxFsMzI2CO91AJyou+kUyJ9zc9WNuBjCbGenmnAU0ek=
X-Received: by 2002:a17:903:452:b0:19e:f660:81ee with SMTP id
 iw18-20020a170903045200b0019ef66081eemr3630660plb.2.1679079562629; Fri, 17
 Mar 2023 11:59:22 -0700 (PDT)
MIME-Version: 1.0
References: <9d0ef355-f430-e8e2-c844-b34cfcf60d88@kernel.dk> <CAHk-=wgcYvgJ5YWJPy6PA-B_yRtPfpw01fmCqtvqGN9jouc_8w@mail.gmail.com>
In-Reply-To: <CAHk-=wgcYvgJ5YWJPy6PA-B_yRtPfpw01fmCqtvqGN9jouc_8w@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 17 Mar 2023 11:59:11 -0700
Message-ID: <CAKwvOdmJkQUe6bhvQXHo0XOncdso0Kk26n8vdJZufm4Ku72tng@mail.gmail.com>
Subject: Re: [GIT PULL] Block fixes for 6.3-rc3
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Nathan Chancellor <nathan@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

+Sanitizer folks (BCC'd)
(Top of lore thread:
https://lore.kernel.org/linux-block/9d0ef355-f430-e8e2-c844-b34cfcf60d88@ke=
rnel.dk/)

On Fri, Mar 17, 2023 at 11:35=E2=80=AFAM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Fri, Mar 17, 2023 at 10:16=E2=80=AFAM Jens Axboe <axboe@kernel.dk> wro=
te:
> >
> > - blk-mq SRCU fix for BLK_MQ_F_BLOCKING devices (Christ)
>
> Christ indeed.
>
> But I think you meant "Chris".
>
> > Side note - when doing the usual allmodconfig builds with gcc-12 and
> > clang before sending them out, for the latter I see this warning being
> > spewed with clang-15:
> >
> > drivers/media/i2c/m5mols/m5mols.o: warning: objtool: m5mols_set_fmt() f=
alls through to next function m5mols_get_frame_desc()
> >
> > Obviously not related to my changes, but mentioning it in case it has
> > been missed as I know you love squeaky clean builds :-). Doesn't happen
> > with clang-14.
>
> Hmm. I have clang-15 too, but I do the allmodconfig builds with gcc,
> and only my own "normal config" builds with clang.
>
> So I don't see this particular issue and my builds are still squeaky clea=
n.
>
> That said, when I explicitly try that allmodconfig thing with clang, I
> can see it too. And the reason seems to be something we've seen
> before: UBSAN functions being considered non-return by clang, so clang
> generates code like this:
>
>    ....
> .LBB24_3:
>         callq   __sanitizer_cov_trace_pc@PLT
>         movl    $2, %esi
>         movq    $.L__unnamed_3, %rdi
>         callq   __ubsan_handle_out_of_bounds
> .Lfunc_end24:
>         .size   m5mols_set_fmt, .Lfunc_end24-m5mols_set_fmt
>
> ie the last thing in that m5mols_set_fmt() function is a call to
> __ubsan_handle_out_of_bounds, and then it "falls through" to the next
> function.
>
> And yes, I absolutely *detest* how clang does that. Not only does it
> cause objtool sanity checking issues, it fundamentally means that we
> can never treat UBSAN warnings as warnings. They are always fatal.
>
> This is a *huge* clang mis-feature, and I forget what we decided last
> that we saw it.
>
> But I suspect we need to disable UBSAN for clang, because clang gets
> this so *horribly* wrong.
>
> Fatal errors that cannot be recovered from are not something that the
> compiler is supposed to decide on. It's exactly the same issue as
> BUG() calls: it just results in a dead machine, and in the process the
> actual problem easily gets lost (because maybe this only happens while
> running X, and no serial console, and no way to actually see what the
> UBSAN warning was as a result).
>
> I really really detest this thing, and I think this is a fatal flaw,
> and means that as-is, UBSAN really *has* to be disabled for clang
> kernel builds. Maybe that will make somebody wake up and smell the
> roses, and stop this idiotic "undefined behavior is fatal" garbage.
>
> Nick? Do you remember what the fix was last time?
>
>                Linus



--=20
Thanks,
~Nick Desaulniers
