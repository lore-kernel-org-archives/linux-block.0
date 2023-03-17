Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7213AC74A5B
	for <linux-block@archiver.kernel.org>; Fri, 17 Mar 2023 18:35:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbjCQSf5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 17 Mar 2023 14:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjCQSf4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Mar 2023 14:35:56 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA84A35EEF
        for <linux-block@vger.kernel.org>; Fri, 17 Mar 2023 11:35:54 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id er8so12172362edb.0
        for <linux-block@vger.kernel.org>; Fri, 17 Mar 2023 11:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1679078153;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6q47tfVyvSpC5G96FSLgqo6Kvz0mEzwMLPLkpQTW/zI=;
        b=Gq7wQn4k1d9IYWf4h6pJBPJ/wadBELaCvLxYpjImMhxhR/TAGCe4/1D8YfIGuJ778V
         AbFyKqj8JJ/KdSOSbgHgLNZ/NNCLf5poyHRPHSzyF0qv6vL2ZZKgS8NeW42S6sHir+Y0
         UKSz97KN/tBKi/STwtWX2r8qi1j1/XCTDlr0I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679078153;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6q47tfVyvSpC5G96FSLgqo6Kvz0mEzwMLPLkpQTW/zI=;
        b=qtjHFTztsd2hq/JKLAZGWRra7nD4RzJSjGh+spWmDr7cqRtnlRF65J3SxqoUqVr7AS
         CDOnU3+wqpJ6km17oJ83KjEnKTMCxfftxRVdR3UjkQJcVIAfX+LyYt+HbTHL4LWBblTS
         M4EgCemv+tTxyBE0klgdjDx4hobMte0lhYRw4Ch8+7PXxwqkNWXDgrfn18mWZJKLU2Ts
         nRXyqCIBl4yV/Vd+Mk4a/CPSy4pmxg4bocCAtTL4Ac+KbTuTn33GN65HNpGd6GYfi0xB
         6wwHKQNjULIZUF/40mfEB5kSmvPbgdhdg7lrbAVuB+A4R/9hvYDk6PA59L+ZC50O6PL0
         9jYw==
X-Gm-Message-State: AO0yUKWntOaIIqgJTtw/6v+GS9MKte82lzjCoLDuGc3Fw7Ud4A5kxMyd
        HUl9mtlOfswe2rNb7Dq7LH9Q+7PdgR0su2DSAvADew==
X-Google-Smtp-Source: AK7set9IoHbY5utmYdtFsgEmOeXjnFJxejkqLs4JvVJtiP92rYFX2DeByz3NKwIMaYUBTIqyBOlCPA==
X-Received: by 2002:aa7:cf18:0:b0:4fd:236f:7d4d with SMTP id a24-20020aa7cf18000000b004fd236f7d4dmr4202816edy.18.1679078153230;
        Fri, 17 Mar 2023 11:35:53 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id p25-20020a50cd99000000b004bf76fdfdb3sm1421332edi.26.2023.03.17.11.35.51
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Mar 2023 11:35:52 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id y4so23966116edo.2
        for <linux-block@vger.kernel.org>; Fri, 17 Mar 2023 11:35:51 -0700 (PDT)
X-Received: by 2002:a17:906:6805:b0:8b1:28f6:8ab3 with SMTP id
 k5-20020a170906680500b008b128f68ab3mr137958ejr.15.1679078151333; Fri, 17 Mar
 2023 11:35:51 -0700 (PDT)
MIME-Version: 1.0
References: <9d0ef355-f430-e8e2-c844-b34cfcf60d88@kernel.dk>
In-Reply-To: <9d0ef355-f430-e8e2-c844-b34cfcf60d88@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 17 Mar 2023 11:35:34 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgcYvgJ5YWJPy6PA-B_yRtPfpw01fmCqtvqGN9jouc_8w@mail.gmail.com>
Message-ID: <CAHk-=wgcYvgJ5YWJPy6PA-B_yRtPfpw01fmCqtvqGN9jouc_8w@mail.gmail.com>
Subject: Re: [GIT PULL] Block fixes for 6.3-rc3
To:     Jens Axboe <axboe@kernel.dk>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Mar 17, 2023 at 10:16=E2=80=AFAM Jens Axboe <axboe@kernel.dk> wrote=
:
>
> - blk-mq SRCU fix for BLK_MQ_F_BLOCKING devices (Christ)

Christ indeed.

But I think you meant "Chris".

> Side note - when doing the usual allmodconfig builds with gcc-12 and
> clang before sending them out, for the latter I see this warning being
> spewed with clang-15:
>
> drivers/media/i2c/m5mols/m5mols.o: warning: objtool: m5mols_set_fmt() fal=
ls through to next function m5mols_get_frame_desc()
>
> Obviously not related to my changes, but mentioning it in case it has
> been missed as I know you love squeaky clean builds :-). Doesn't happen
> with clang-14.

Hmm. I have clang-15 too, but I do the allmodconfig builds with gcc,
and only my own "normal config" builds with clang.

So I don't see this particular issue and my builds are still squeaky clean.

That said, when I explicitly try that allmodconfig thing with clang, I
can see it too. And the reason seems to be something we've seen
before: UBSAN functions being considered non-return by clang, so clang
generates code like this:

   ....
.LBB24_3:
        callq   __sanitizer_cov_trace_pc@PLT
        movl    $2, %esi
        movq    $.L__unnamed_3, %rdi
        callq   __ubsan_handle_out_of_bounds
.Lfunc_end24:
        .size   m5mols_set_fmt, .Lfunc_end24-m5mols_set_fmt

ie the last thing in that m5mols_set_fmt() function is a call to
__ubsan_handle_out_of_bounds, and then it "falls through" to the next
function.

And yes, I absolutely *detest* how clang does that. Not only does it
cause objtool sanity checking issues, it fundamentally means that we
can never treat UBSAN warnings as warnings. They are always fatal.

This is a *huge* clang mis-feature, and I forget what we decided last
that we saw it.

But I suspect we need to disable UBSAN for clang, because clang gets
this so *horribly* wrong.

Fatal errors that cannot be recovered from are not something that the
compiler is supposed to decide on. It's exactly the same issue as
BUG() calls: it just results in a dead machine, and in the process the
actual problem easily gets lost (because maybe this only happens while
running X, and no serial console, and no way to actually see what the
UBSAN warning was as a result).

I really really detest this thing, and I think this is a fatal flaw,
and means that as-is, UBSAN really *has* to be disabled for clang
kernel builds. Maybe that will make somebody wake up and smell the
roses, and stop this idiotic "undefined behavior is fatal" garbage.

Nick? Do you remember what the fix was last time?

               Linus
