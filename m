Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08462C433FE
	for <linux-block@archiver.kernel.org>; Tue, 18 Oct 2022 18:55:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbiJRSzQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Oct 2022 14:55:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbiJRSzN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Oct 2022 14:55:13 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 517FF816AB
        for <linux-block@vger.kernel.org>; Tue, 18 Oct 2022 11:55:11 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id x13so9266687qkg.11
        for <linux-block@vger.kernel.org>; Tue, 18 Oct 2022 11:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SJv2e3NDb4hb7fpvgryRdyTK/aBL4JeyRFOO7JpAa3g=;
        b=I6tAUY4Kc28ucOyXKjvzZw5w6u4QK/U7MjX7wJAQE/VbJgTz1FhiqwqivkZVpOIBer
         IN9YTqwuUKp5mhC2W5z0wbdU4SylIQ2AT3lL9TEER38pSJf0dubZRoNizQVCK73XSKRQ
         6ddgb5ITkpiQUxD7EIlMSlMZu7x3dYk67LDpQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SJv2e3NDb4hb7fpvgryRdyTK/aBL4JeyRFOO7JpAa3g=;
        b=glIlXIuWQhfTndslWptF6hP3rB0byX/Qk1vJEDlN0NQOXDq0E2x0zcXv3Nqnsn+Dfo
         /GL//nJnbiPmrq3wlgiJJQzqUksZUeWltjWAND23VgLb90R9OCa5rXt9UCkd9H09sR5n
         X4Eg7LYXqlLlKo28ffmi76Z9D04YVxbyLTD0cIo2xZdSNGd8W5ftZyqizQWtVU084ud1
         sN0J0Gwr2+zB5KwTxm+FlNLKfCUy8bWxY8XMGD5p8YhhvlwU/yKqZNAKsYGlglGS+/9v
         zZKRfC//h8VM7OieZ3CH8zdQQQnMJR2vxPSaA7Fw2hFib7zVNz6FO4zhoCSFHlt3zcep
         VfCQ==
X-Gm-Message-State: ACrzQf241bezVpv+5ik0QdWZgLdFcPXzyMWJ+2+Bs22RlxWlo9x6otGw
        OZ/Ify+4BFR/GbokgLBRMOOrygTN9FiLLw==
X-Google-Smtp-Source: AMsMyM4uI8parPJsqpErV3xE5x+BlnpNNkvcrRv1iCuXOYbybjlIKbftTZUg2pBQp09vyT+cwXYnNw==
X-Received: by 2002:ae9:e013:0:b0:6ec:9961:4ead with SMTP id m19-20020ae9e013000000b006ec99614eadmr2940444qkk.582.1666119310176;
        Tue, 18 Oct 2022 11:55:10 -0700 (PDT)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id m11-20020a05620a290b00b006b929a56a2bsm3046000qkp.3.2022.10.18.11.55.06
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Oct 2022 11:55:06 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id i127so7335413ybc.11
        for <linux-block@vger.kernel.org>; Tue, 18 Oct 2022 11:55:05 -0700 (PDT)
X-Received: by 2002:a05:6902:124f:b0:66e:e3da:487e with SMTP id
 t15-20020a056902124f00b0066ee3da487emr3964959ybu.310.1666119305668; Tue, 18
 Oct 2022 11:55:05 -0700 (PDT)
MIME-Version: 1.0
References: <Y07SYs98z5VNxdZq@redhat.com> <Y07twbDIVgEnPsFn@infradead.org>
In-Reply-To: <Y07twbDIVgEnPsFn@infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 18 Oct 2022 11:54:49 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg3cpPyoO8u+8Fu1uk86bgTUYanfKhmxMsZzvY_mV=Cxw@mail.gmail.com>
Message-ID: <CAHk-=wg3cpPyoO8u+8Fu1uk86bgTUYanfKhmxMsZzvY_mV=Cxw@mail.gmail.com>
Subject: Re: [git pull] device mapper changes for 6.1
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        linux-block@vger.kernel.org, Alasdair G Kergon <agk@redhat.com>,
        Genjian Zhang <zhanggenjian@kylinos.cn>,
        Jiangshan Yi <yijiangshan@kylinos.cn>,
        Jilin Yuan <yuanjilin@cdjrlc.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Milan Broz <gmazyland@gmail.com>,
        Nathan Huckleberry <nhuck@google.com>,
        Nikos Tsironis <ntsironis@arrikto.com>,
        Shaomin Deng <dengshaomin@cdjrlc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Oct 18, 2022 at 11:17 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Tue, Oct 18, 2022 at 12:20:50PM -0400, Mike Snitzer wrote:
> >
> > - Enhance DM ioctl interface to allow returning an error string to
> >   userspace. Depends on exporting is_vmalloc_or_module_addr() to allow
> >   DM core to conditionally free memory allocated with kasprintf().
>
> That really does not sound like a good idea at all.  And it does not
> seem to have any MM or core maintainer signoffs.

I wouldn't worry about maintainer sign-offs just for exporting a
helper function, but I agree with the whole concept being a complete
disaster and not a good idea at all.

Use errno.

It really is that simple. Strings have been discussed before, and they
are simply not a good idea. If your interface is so complicated that
you think errors need some textual explanation, your interface is
probably garbage.

Strings also have allocation issues (as you found out), and have
serious localization issues.

Yes, we do a lot of strings in the kernel in the form of dmesg, and we
have the rule that we simply don't localize. But that's dmesg. It's
for special stuff, not some interface.

And equally importantly, some really small detail in the kernel really
has *NO* business making up new error models of its own. You may think
that the DM ioctl's are a big and important deal, but realistically,
it's just an odd corner of the world that very very few people care
about, and they can use the same error numbers that EVERYBODY ELSE HAS
BEEN USING FOR SIX DECADES!

Don't reinvent something that works - badly.

I think we have one major interface that is string-based (apart from
the obvious pathname ones and the strings passed to 'execve()').

It's 'mount()' (and now fsconfig() etc), and it's string-based mainly
because it has that nasty "arbitrary things that different filesystem
may need for configuration"). And it has some nasty logging model
associated with it too for output.

But no, we absolutely do *not* want to emulate that particular horror
anywhere else.

If you think some errors are really important and hard to understand,
maybe you can just log them with a ratelimited pr_info() or something.

           Linus
