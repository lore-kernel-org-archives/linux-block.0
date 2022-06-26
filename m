Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AFF2C433EF
	for <linux-block@archiver.kernel.org>; Sun, 26 Jun 2022 16:34:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbiFZQeU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 26 Jun 2022 12:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbiFZQeT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 26 Jun 2022 12:34:19 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DA1A657E
        for <linux-block@vger.kernel.org>; Sun, 26 Jun 2022 09:34:18 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id lw20so14383002ejb.4
        for <linux-block@vger.kernel.org>; Sun, 26 Jun 2022 09:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mScxwT9DzL3m/fse9Qa13RHznVT8wiBux8yUPiA/65w=;
        b=Fv68tSKqZvEHCHdmDpfHlKLYttzkO7ojxHn2al/Pb7IdSsasPmpYAK2+TpzX4qQDqt
         oFjxvUfBmPnTQHGF+agmqW3JDOYDlGeS0gNC05KfbkWpTkkuK0w3mcidoo0C4Q2p+jH+
         qnQ/2ntK72Zq3JYUI5Z4Y8+t5KpSct0oU8lBc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mScxwT9DzL3m/fse9Qa13RHznVT8wiBux8yUPiA/65w=;
        b=Odq03qT9QvPsgs5Fnv5MDjWARWW0AEpXICBTz8ZC4fjNA3gHJXYTZk3HirKTe6TCYo
         kMiy7ukj983IpFTjbWbZ9xPzD47h/uQ2mTO8xqfJXBrzTmS3nGQZQE11m1yzVDLRKGfP
         Y2v6RPKlUnLLrvv5ZPFwJbu3BGH/u1Ec5wtylz+3Mmhh2s1RnXIrtTqI3b42DBOt9hqX
         /4JUormMlMfqrjTeYGJv/nF5YjxAwkXj2LH3Z69dob+CgmES+dNXgG7hGZxBe54dpIgM
         R7Q5qoO5xYlG7OHO3XKgqg58jqM2+EWr4MLTnIoeksq7s1N7irIXCveFmSXysQnmfxHV
         Zxkg==
X-Gm-Message-State: AJIora9iWD3yFW+rR7w8XnFAcF1BwrU3J1iFWYsWRYXQMqNlpr1TmSde
        z3WkQPKm26HXUmyK7GPgAtPQP5wg1ePNTD4P
X-Google-Smtp-Source: AGRyM1s4dsNKldjeUNJXXdTki6bce+gNUgTjmxiUceHQWs4+kv/vvJ9YDVginIrNMK/BZUqQe0X7ww==
X-Received: by 2002:a17:906:2086:b0:715:7983:a277 with SMTP id 6-20020a170906208600b007157983a277mr8757520ejq.386.1656261256851;
        Sun, 26 Jun 2022 09:34:16 -0700 (PDT)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com. [209.85.221.54])
        by smtp.gmail.com with ESMTPSA id k10-20020a170906970a00b006fea59ef3a5sm3991108ejx.32.2022.06.26.09.34.14
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Jun 2022 09:34:15 -0700 (PDT)
Received: by mail-wr1-f54.google.com with SMTP id e28so4651170wra.0
        for <linux-block@vger.kernel.org>; Sun, 26 Jun 2022 09:34:14 -0700 (PDT)
X-Received: by 2002:a05:6000:1251:b0:21a:efae:6cbe with SMTP id
 j17-20020a056000125100b0021aefae6cbemr8209393wrx.281.1656261253928; Sun, 26
 Jun 2022 09:34:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220623180528.3595304-1-bvanassche@acm.org> <20220623180528.3595304-52-bvanassche@acm.org>
 <20220624045613.GA4505@lst.de> <aa044f61-46f0-5f21-9b17-a1bb1ff9c471@acm.org>
 <20220625092349.GA23530@lst.de> <3eed7994-8de2-324d-c373-b6f4289a2734@acm.org>
 <20220626095814.7wtma47w4sph7dha@mail>
In-Reply-To: <20220626095814.7wtma47w4sph7dha@mail>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 26 Jun 2022 09:33:57 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj8gM8q04v2jS5JGjEdoE2d+B4_nm74xrFjZ77f9YRsbA@mail.gmail.com>
Message-ID: <CAHk-=wj8gM8q04v2jS5JGjEdoE2d+B4_nm74xrFjZ77f9YRsbA@mail.gmail.com>
Subject: Re: [PATCH 51/51] fs/zonefs: Fix sparse warnings in tracing code
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sparse Mailing-list <linux-sparse@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Jun 26, 2022 at 2:58 AM Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> What about I would add to sparse something to strip away the bitwise/
> recover the underlying type? Something like __unbitwiseof() or
> __underlying_typeof() (some better name is needed)?

Please no, we don't want to make random macros have to have sparse
logic in them when it's not actually sparse-related.

I think it would be better if sparse just recognized some of these
kinds of situation. In particular:

 (a) for the casting part, I actually suspect we should drop the
warning about castign integers to restricted types.

Note that this is actually one of the main causes of "__force" use in
the kernel, with code like

        VM_FAULT_OOM            = (__force vm_fault_t)0x000001,
        VM_FAULT_SIGBUS         = (__force vm_fault_t)0x000002,
        VM_FAULT_MAJOR          = (__force vm_fault_t)0x000004,
        VM_FAULT_WRITE          = (__force vm_fault_t)0x000008,

and I think that we could/should just say that "explicit casts of
constants are ok".

That would remove two of the four warnings right there, and probably
make bitwise types more convenient in general.

We already treat "0" as special (because for bitwise things, zero is
kind of the universal constant), and we should continue to warn about
_implicit_ casts of restricted types, but I think the use of "__force"
in the kernel does show that the explicit casts are probably a bad
idea.

 (b) I think we could also recognize "comparison of constants" to be
something that doesn't necessarily require a warning.

And here in particular the "compare with zero" and "compare with all
bits set" - which is exactly that "-1" case.

In fact, there's a very good argument that "-1" is as special as zero
is ("all bits set" vs "all bits clear"), so for that (a) case, I think
at a _minimum_ we shouldn't warn about that particular constant.

So I think we could silence this sparse warning entirely, without
really introducing any new syntax, and actually improving on how
bitwise works.

                 Linus
