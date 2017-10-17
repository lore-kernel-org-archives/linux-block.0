Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-it0-f44.google.com ([209.85.214.44]:43842 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753209AbdJQQpj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Oct 2017 12:45:39 -0400
Received: by mail-it0-f44.google.com with SMTP id k70so6091475itk.0
        for <linux-block@vger.kernel.org>; Tue, 17 Oct 2017 09:45:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <AE364BB2-E347-4A5E-BFF7-AAAA32C512F5@linaro.org>
References: <07DF24AB-9B62-4EE5-8B45-3E04C1CEA84C@linaro.org> <AE364BB2-E347-4A5E-BFF7-AAAA32C512F5@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 17 Oct 2017 18:45:37 +0200
Message-ID: <CACRpkdZYMTqgPur_S1sFfpZfT3euzDLs=pxgs-fG=+3AtMSbig@mail.gmail.com>
Subject: Re: high overhead of functions blkg_*stats_* in bfq
To: Paolo Valente <paolo.valente@linaro.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        David Howells <dhowells@redhat.com>
Cc: Tejun Heo <tj@kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Luca Miccio <lucmiccio@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Oct 17, 2017 at 2:45 PM, Paolo Valente <paolo.valente@linaro.org> wrote:

> one of the most time-consuming operations needed by some blkg_*stats_*
> functions is, e.g., find_next_bit, for which we don't see any trivial
> replacement.

So this is one of the things that often falls down to a per-arch
assembly optimization, c.f. arch/arm/include/asm/bitops.h

On x86 I can't see any assembly optimization of this, so the
generic routines in lib/find_bit.c are used AFAICT.

This might be a silly question, but If you are testing this on x86,
do you think it would help if someone stepped in and slapped in
some optimized assembly for those functions?

(I guess that is like saying, "instead of a trivial replacement,
what about a really complicated one"?)

A simple git log arch/x86/include/asm/bitops.h doesn't show
any traces of anyone trying to optimize those for x86.

I paged in the x86 assembly people, they definately knows whether
that is a good idea or if it sucks. (And if it was done in the past.)

Yours,
Linus Walleij
