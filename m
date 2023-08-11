Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36818EB64DD
	for <linux-block@archiver.kernel.org>; Fri, 11 Aug 2023 18:17:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237041AbjHKSRN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 11 Aug 2023 14:17:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235224AbjHKSRI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Aug 2023 14:17:08 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B95530DD
        for <linux-block@vger.kernel.org>; Fri, 11 Aug 2023 11:17:08 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4fe44955decso2619385e87.1
        for <linux-block@vger.kernel.org>; Fri, 11 Aug 2023 11:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1691777826; x=1692382626;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yc08NlpUYdnLIv24Lptdj+fSBDTOBa932kABNWFPLk4=;
        b=OolZc1iq1AMydZ+l/nEHGM07D/qHfBu4YVSSNmAHgQtaqdZlZcuxCKKwF+WvSSfsdr
         cdawV8OUtp80Q9oSE9z0O3u6CwLpik1bRObqeVUJ4DuiL5Z+a8x4HvdP7B187V0NxUuD
         KCxDtVLnuogg/KTXALJg4OT8Iyeqq722gE18Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691777826; x=1692382626;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yc08NlpUYdnLIv24Lptdj+fSBDTOBa932kABNWFPLk4=;
        b=fdSnU6nKJVlZOVS4hRNMvvDMSAaUjCkrEwTgdoUbaea+uNvoDR9AaiWQ4JcBIu3/L6
         8XJPkY5GKcdPdOdyg7w32jOCwmZBEwUrTyjuGNNQ+AtHnFdxk0UcEJ//mtMrN6X+XipU
         pDZ1Frxq8M6WuVRnbB9eRJ7ldTy3QhRP+44kfH71esVCbNVsjLsHg+ochWh0KudLIDw8
         gi+BiNg/AeboX1FN4Bbmw7phc+jfhpWPErSsqfQbEf1IReF4alENBNU/dMgCBJp150HR
         qB5R4xrALFodjSHOCBQ+0OYsukTMM7r3+YpQULF0o18j1ndcazuRzfq4gZDcqPbJyxOc
         4AGQ==
X-Gm-Message-State: AOJu0YxiNNFtuaiwc1RpudvsSdTChOAGbo9ecsbWDnieJY845V1k4iw8
        c7gPGQVNzKNBMLztiBoq4ci5Sz4QdG/W1ayJlgYoaG9G
X-Google-Smtp-Source: AGHT+IFpciVMHfMzB7QdVPsyCXpGGT/lg2OwffUxEA6xhzlJGe44A9TdzmWm5KWiVU3D6hfZPtBVkg==
X-Received: by 2002:a05:6402:2793:b0:51f:ef58:da87 with SMTP id b19-20020a056402279300b0051fef58da87mr6792025ede.2.1691777324957;
        Fri, 11 Aug 2023 11:08:44 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id s2-20020aa7c542000000b0052348d74865sm2295167edr.61.2023.08.11.11.08.44
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Aug 2023 11:08:44 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-51e28cac164so6917242a12.1
        for <linux-block@vger.kernel.org>; Fri, 11 Aug 2023 11:08:44 -0700 (PDT)
X-Received: by 2002:aa7:dad9:0:b0:521:ad49:8493 with SMTP id
 x25-20020aa7dad9000000b00521ad498493mr3461940eds.6.1691777323138; Fri, 11 Aug
 2023 11:08:43 -0700 (PDT)
MIME-Version: 1.0
References: <3710261.1691764329@warthog.procyon.org.uk> <CAHk-=wi1QZ+zdXkjnEY7u1GsVDaBv8yY+m4-9G3R34ihwg9pmQ@mail.gmail.com>
 <3888331.1691773627@warthog.procyon.org.uk>
In-Reply-To: <3888331.1691773627@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 11 Aug 2023 11:08:26 -0700
X-Gmail-Original-Message-ID: <CAHk-=whsKN50RfZAP4EL12djwvMiWYKTca_5AYxPnHNzF7ffvg@mail.gmail.com>
Message-ID: <CAHk-=whsKN50RfZAP4EL12djwvMiWYKTca_5AYxPnHNzF7ffvg@mail.gmail.com>
Subject: Re: [RFC PATCH] iov_iter: Convert iterate*() to inline funcs
To:     David Howells <dhowells@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Christian Brauner <christian@brauner.io>,
        Matthew Wilcox <willy@infradead.org>, jlayton@kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, 11 Aug 2023 at 10:07, David Howells <dhowells@redhat.com> wrote:
>
> Hmmm...  It seems that using if-if-if rather than switch() gets optimised
> better in terms of .text space.  The attached change makes things a bit
> smaller (by 69 bytes).

Ack, and that also makes your change look more like the original code
and more as just a plain "turn macros into inline functions".

As a result the code diff initially seems a bit smaller too, but then
at some point it looks like at least clang decides that it can combine
common code and turn those 'ustep' calls into indirect calls off a
conditional register, ie code like

        movq    $memcpy_from_iter, %rax
        movq    $memcpy_from_iter_mc, %r13
        cmoveq  %rax, %r13
        [...]
        movq    %r13, %r11
        callq   __x86_indirect_thunk_r11

Which is absolutely horrible. It might actually generate smaller code,
but with all the speculation overhead, indirect calls are a complete
no-no. They now cause a pipeline flush on a large majority of CPUs out
there.

That code generation is not ok, and the old macro thing didn't
generate it (because it didn't have any indirect calls).

And it turns out that __always_inline on those functions doesn't even
help, because the fact that it's called through an indirect function
pointer means that at least clang just keeps it as an indirect call.

So I think you need to remove the changes you did to
memcpy_from_iter(). The old code was an explicit conditional of direct
calls:

        if (iov_iter_is_copy_mc(i))
                return (void *)copy_mc_to_kernel(to, from, size);
        return memcpy(to, from, size);

and now you do that

                                   iov_iter_is_copy_mc(i) ?
                                   memcpy_from_iter_mc : memcpy_from_iter);

to pass in a function pointer.

Not ok. Not ok at all. It may look clever, but function pointers are
bad. Avoid them like the plague.

            Linus
