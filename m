Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B936DC74A5B
	for <linux-block@archiver.kernel.org>; Fri, 17 Mar 2023 18:50:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbjCQSuf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 17 Mar 2023 14:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjCQSu3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Mar 2023 14:50:29 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEAF1C5AF0
        for <linux-block@vger.kernel.org>; Fri, 17 Mar 2023 11:50:27 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id h8so24004236ede.8
        for <linux-block@vger.kernel.org>; Fri, 17 Mar 2023 11:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1679079026;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qfTCL+CieKquWU9YnAy2pm4YqQSoRTG8bbhGpXRahXY=;
        b=NqjY/0mf9Vkd/q4nW7r70lfeWL6NKlZ3L0ttql3SOGCsBKpSNIYgt7EK0U+8KFdQBe
         bCoQa9pmPOBa/0o1rflhXfAAQus5zxjYPAQ+US9SZgKVXLi9sb5f/iZ+Stb4+7nnhfNh
         kW1vpxJWF986M3p8kk/DEyRqLAcBtwXEZepXo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679079026;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qfTCL+CieKquWU9YnAy2pm4YqQSoRTG8bbhGpXRahXY=;
        b=HBDCxXMqs4RxwqtBezGw9ubNDinUVFgWIoDMMtbpYgfBPQOWQuCr47IJjXfI1ZGj5k
         m2wdcAZ6Vm74V7kLGmEODbk5gOzhEB+TMgW/y7YcQLvQK60iMtGDrUY7o3sGsM8fzldT
         x7XxzaNIV85Dbqhy/gZ4GEsgzANqudKdW1ub/8f9QNoUBh+lzwzrpkXYGYraqVXRXnnM
         7da82AM/leuIT3YwDflCuTwVzraX+rb8OQLF6CU3e7f61NcKmpImGMq4ZiesQqj52RL9
         AuvcrF5ULclg+SR+/MXiyorMkm2pYyRx7dcxs+c9bkreGQW8uklDcwhnRcLEZDuvxC4C
         5B2g==
X-Gm-Message-State: AO0yUKUU1rGi083NPrG9DMArB8S6ZYw7+AqKkVFk0tFB/hbtYeW0a6Ql
        90Zj4/Rbj0R5jZ+Qi8nb7bk2cWHyXRimoMwrBAHPjg==
X-Google-Smtp-Source: AK7set/ULpyfmm9l+G1TFRloCQ2cXzUUKjRqwZs3ubEEhsYTyuV6A95V3K4NDgJZObfpfSmjXrRAVA==
X-Received: by 2002:a17:907:75e9:b0:931:7350:a4f3 with SMTP id jz9-20020a17090775e900b009317350a4f3mr414361ejc.10.1679079025925;
        Fri, 17 Mar 2023 11:50:25 -0700 (PDT)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id f22-20020a170906825600b00925ce7c7705sm1249760ejx.162.2023.03.17.11.50.24
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Mar 2023 11:50:24 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id eg48so23915892edb.13
        for <linux-block@vger.kernel.org>; Fri, 17 Mar 2023 11:50:24 -0700 (PDT)
X-Received: by 2002:a17:906:2695:b0:931:99b5:67a4 with SMTP id
 t21-20020a170906269500b0093199b567a4mr144258ejc.15.1679079024315; Fri, 17 Mar
 2023 11:50:24 -0700 (PDT)
MIME-Version: 1.0
References: <9d0ef355-f430-e8e2-c844-b34cfcf60d88@kernel.dk> <CAHk-=wgcYvgJ5YWJPy6PA-B_yRtPfpw01fmCqtvqGN9jouc_8w@mail.gmail.com>
In-Reply-To: <CAHk-=wgcYvgJ5YWJPy6PA-B_yRtPfpw01fmCqtvqGN9jouc_8w@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 17 Mar 2023 11:50:07 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj1wYh_2d8Y1Vm6YjPTh4yMqWc++aWVY2LpX7n_atc2hA@mail.gmail.com>
Message-ID: <CAHk-=wj1wYh_2d8Y1Vm6YjPTh4yMqWc++aWVY2LpX7n_atc2hA@mail.gmail.com>
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

On Fri, Mar 17, 2023 at 11:35=E2=80=AFAM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I really really detest this thing, and I think this is a fatal flaw,
> and means that as-is, UBSAN really *has* to be disabled for clang
> kernel builds. Maybe that will make somebody wake up and smell the
> roses, and stop this idiotic "undefined behavior is fatal" garbage.

Btw, this is not at all kernel-centric, even if the kernel may be
special in not necessarily being able to log things on fatal issues.

Imagine you are a database vendor, and you cannot replicate something
that a user sees, and the user is not willing to give you their
database, and you worry that it might be some undefined thing.

Are you going to ship the user a test-build that might die in the
middle, and thus be unable to actually show the behavior in any
half-way production setting? Would any sane user run that pile of
garbage on their machines, knowing that any error would be fatal and
result in their production database being broken?

So any compiler person that says "undefined behavior can do anything
at all according to the standard, so we're compliant with that" is an
incompetent person, and shouldn't be let near a real compiler.

Debug support *MUST* have an option to just continue. Sure, make "this
is fatal" be an option *too*, because if you are a developer, maybe
you really want the "fail hard, fail quickly" behavior.

But that fatal option cannot be the *only* choice, or we cannot use
said debug code in the kernel.

             Linus
