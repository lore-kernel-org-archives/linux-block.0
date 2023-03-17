Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2147CC7618B
	for <linux-block@archiver.kernel.org>; Fri, 17 Mar 2023 20:31:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbjCQUbe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 17 Mar 2023 16:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbjCQUbb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Mar 2023 16:31:31 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47E861EFFC
        for <linux-block@vger.kernel.org>; Fri, 17 Mar 2023 13:31:11 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id er8so13230847edb.0
        for <linux-block@vger.kernel.org>; Fri, 17 Mar 2023 13:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1679085065;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tdwPzVsmob+Q/2o5AaDTACeQ8LqTFlcH3duKRoFq2iQ=;
        b=NRRDvzKrpe8pYBzozs6ge7vqHuUviWfY6zC02S2Qz2ecCTbPpe9T4e6uBCNFzMqCd8
         seWjFsr2PePAi1T70JZzGYiFm0pUqoCfKAHToYFYfQSlppds1cRifzvCzqnfy5Hh7nnz
         wA/Xac9eMopHZS+YhuCw941avlp3Q9/QDL2QY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679085065;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tdwPzVsmob+Q/2o5AaDTACeQ8LqTFlcH3duKRoFq2iQ=;
        b=aDUbuOBYB2oMuRjmFwbC7MOcqVnMHAeJrPV4+gO8vKS7PUSu2eJbWQCmxImKiUS3Ph
         43hDoo9idxGjGPElsqdkna2u6OuHN9GngE0cUPXfn4YX1pTwRB5YwJb6UdCpkMLs4Ndy
         UzRKTWdXEwUtm7t74c6PEjMzp8EatvBBUnezhwsG+v8xEY1nC/pi0QNVJNnknFB+rxDd
         rKvACCDI0A79mu6S/3RYRS9ctbc59Io6fwVxeYrDDPHxW9n2IJ4ixYri8J5HYfBsKCY0
         +z1iBR5GS811yjQxRvOcpra3hQ7heCqarNqrLB02O523Ose+LPCskSgsVrJRsa1c0KMu
         n0mQ==
X-Gm-Message-State: AO0yUKVIT41yIFVsNyin7PiFWynqWqLjWQWxN3flhoe4VrmnDl4XRz0A
        j4554ZbKqb57n3oqtYtVYUtjhU3K1AjpxoM/IIY98g==
X-Google-Smtp-Source: AK7set8h78LvymKbKbmP0A/4oW3LQ2glut7rUolcOdQRLgFmz11ue/+K85Ksa3eL4A5fnyS7Z5879g==
X-Received: by 2002:a17:906:8496:b0:909:4a93:d9d2 with SMTP id m22-20020a170906849600b009094a93d9d2mr593563ejx.2.1679085064717;
        Fri, 17 Mar 2023 13:31:04 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id b24-20020a170906491800b008e82cb55195sm1340777ejq.203.2023.03.17.13.31.03
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Mar 2023 13:31:04 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id x13so25003987edd.1
        for <linux-block@vger.kernel.org>; Fri, 17 Mar 2023 13:31:03 -0700 (PDT)
X-Received: by 2002:a50:ce54:0:b0:4fa:794a:c0cc with SMTP id
 k20-20020a50ce54000000b004fa794ac0ccmr2477649edj.2.1679085063365; Fri, 17 Mar
 2023 13:31:03 -0700 (PDT)
MIME-Version: 1.0
References: <9d0ef355-f430-e8e2-c844-b34cfcf60d88@kernel.dk>
 <CAHk-=wgcYvgJ5YWJPy6PA-B_yRtPfpw01fmCqtvqGN9jouc_8w@mail.gmail.com>
 <CAKwvOdmJkQUe6bhvQXHo0XOncdso0Kk26n8vdJZufm4Ku72tng@mail.gmail.com> <6414c470.a70a0220.6b62f.3f02@mx.google.com>
In-Reply-To: <6414c470.a70a0220.6b62f.3f02@mx.google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 17 Mar 2023 13:30:46 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi5yk0+NeqB34fRC-Zvt+8QZVPTiny9MvCxxjg+ZqDhKg@mail.gmail.com>
Message-ID: <CAHk-=wi5yk0+NeqB34fRC-Zvt+8QZVPTiny9MvCxxjg+ZqDhKg@mail.gmail.com>
Subject: Re: [GIT PULL] Block fixes for 6.3-rc3
To:     Kees Cook <keescook@chromium.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
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

On Fri, Mar 17, 2023 at 12:50=E2=80=AFPM Kees Cook <keescook@chromium.org> =
wrote:
>
> I've hit these cases a few times too. The __ubsan_handle_* stuff
> is designed to be recoverable. I think there are some cases where
> we're tripping over Clang bugs, though. Some of the past issues
> have been with Clang thinking some UBSAN feature was trap-only
> (e.g. -fsanitizer=3Dlocal-bounds), but here it actually generated the cal=
l,
> but decided it was no-return. *sigh*

Hmm. The problem here is that we only get an objdump warning by pure luck.

This isn't a "objdump will always catch it", it's more like "objdump
will only catch it if the code happens to be moved to the end of the
function".

So I'm very happy to hear that it's not by design, and that's very good.

But the whole "this is a compiler bug" doesn't exactly give me the
warm and fuzzies either.

The code generation looks *really* odd to me. This is, as far as I can
tell, the code sequence that this code has:

m5mols_set_fmt:
  ..
        movq    %rdx, %rbp
  ..
        movl    16(%rbp), %ebx
        movq    %rbx, %rdi
  ..
        cmpq    $16385, %rbx                    # imm =3D 0x4001
        jne     .LBB24_1
  ..
.LBB24_1:
        cmpl    $8199, %ebx                     # imm =3D 0x2007
        jne     .LBB24_3
  ..
.LBB24_3:
        callq   __sanitizer_cov_trace_pc@PLT
        movl    $2, %esi
        movq    $.L__unnamed_3, %rdi
        callq   __ubsan_handle_out_of_bounds

and as far as I can tell, that "movl 16(%rbp), %ebx" is

        enum m5mols_restype stype =3D __find_restype(mf->code);

in __find_resolution(). But I don't understand those odd constants
it's comparing against at all.

'enum m5mols_restype' should be in the range 0..2, but it seems to use
a 64-bit compare against '16385' (and then a 32-bit compare against
'8199') to decide it's out-of-bounds.

I must be *completely* mis-reading this, because none of that makes a
whit of sense to me.

It's possible that clang is just *so* terminally confused that it just
generates random code, but it's more likely that I'm mis-reading
things.

The above is my interpretation of what I see with the current F37
clang version for a "allmodconfig" build of that file.

My 'clang -v' says

    clang version 15.0.7 (Fedora 15.0.7-1.fc37)

in case some clang person wants to try to recreate this.

> I'm not opposed to disabling UBSAN for all*config builds if we need to,
> but I want to get these Clang bugs found and fixed so I'd be sad to lose
> the coverage.

I wonder how many people actually end up having UBSAN actually
enabled. I get the feeling that most of the coverage it gets is
exactly just the compile-only coverage by "allmodconfig" and friends.

Otherwise it would be really easy to just say

        depends on !COMPILE_TEST

for all these run-time debug things. But exactly *because* they have
caused endless amounts of build-time pain - *and* because I doubt how
much real run-time testing they get - limiting it to non-build tests
sounds a bit counter-productive.

              Linus
