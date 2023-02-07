Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69BDBC636D6
	for <linux-block@archiver.kernel.org>; Tue,  7 Feb 2023 16:15:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232132AbjBGQPj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Feb 2023 11:15:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231952AbjBGQP2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Feb 2023 11:15:28 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CE486193
        for <linux-block@vger.kernel.org>; Tue,  7 Feb 2023 08:15:24 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id u21so16336540edv.3
        for <linux-block@vger.kernel.org>; Tue, 07 Feb 2023 08:15:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4RM6pXDqOiFHeAx0WMmnhom/Qz888Ih/TPZU+Y9eyTk=;
        b=NsNlyZdX9FntXMmjVZZquGBbjRgyatHH8Ma3nbcSD5cdovFSmwk5DDBQ2fWraFPrwc
         yEbD3pAldW0OWp9nFmXL3+41yWEaP4WAJsgLpL/66YPcHbCxz4tea6LTrE8ieMPZUjLt
         m4B76mBx3QUIutr78aW0ASxIjNPwfvFPpHMSE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4RM6pXDqOiFHeAx0WMmnhom/Qz888Ih/TPZU+Y9eyTk=;
        b=5b/TBh1U5LjOIq9odzRYKg/DEXjYbM4uMem/3XcrGMXPVt0to9bP5LAhe17WAixfw+
         eqATt284Yfdbm131Sn4bWb3jeL662GG6sSGNsOHgvqOGEVRHCv7n5U7XmR1UBCWCOMOX
         kb9Toqveo+rhZDNpXtSPjYCeYB6m85r0V8fW+5DFbgZ04UU/nb0l/ysPokip83zqwWBI
         FneVg/BpKxqhJrVinTt6WhMAqvJjvxI3XaNrAM9RRhAvgrQ36rOQCsrsj1w31/jgudit
         dwzC3OCFzUKzN5B2kFaiCHKooH4PN89YNx0Jkl/1OjxyK9Pa2eLR/XmeoZtR5P2kXqJ1
         3bsQ==
X-Gm-Message-State: AO0yUKUDTb1JqcU5TlFwlEwf3VhSRAZwZ9I9vSxX+IdaVhiSD3ERVEPb
        gRvAdY2UkH+XZFLaE8Rhkw/mBXXx4tZ4wnlbJinV8Q==
X-Google-Smtp-Source: AK7set8pSlAWUfsc3KPZx1iv1mK7O7DImniMR6fJvIhtFYB1EdIdK20+sxqudyF4ueEbihg4dxpcFQ==
X-Received: by 2002:a17:906:8d06:b0:8a9:d68f:da2 with SMTP id rv6-20020a1709068d0600b008a9d68f0da2mr2455866ejc.28.1675786522572;
        Tue, 07 Feb 2023 08:15:22 -0800 (PST)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id qx18-20020a170906fcd200b0087b3d555d2esm7027249ejb.33.2023.02.07.08.15.21
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Feb 2023 08:15:21 -0800 (PST)
Received: by mail-ed1-f50.google.com with SMTP id x9so8288869eds.12
        for <linux-block@vger.kernel.org>; Tue, 07 Feb 2023 08:15:21 -0800 (PST)
X-Received: by 2002:a17:906:4e46:b0:87a:7098:ca09 with SMTP id
 g6-20020a1709064e4600b0087a7098ca09mr874420ejw.78.1675786520751; Tue, 07 Feb
 2023 08:15:20 -0800 (PST)
MIME-Version: 1.0
References: <20230129060452.7380-1-zhanghongchen@loongson.cn>
 <CAHk-=wjw-rrT59k6VdeLu4qUarQOzicsZPFGAO5J8TKM=oukUw@mail.gmail.com>
 <Y+EjmnRqpLuBFPX1@bombadil.infradead.org> <4ffbb0c8-c5d0-73b3-7a4e-2da9a7b03669@inria.fr>
 <Y+Ja5SRs886CEz7a@kadam>
In-Reply-To: <Y+Ja5SRs886CEz7a@kadam>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 7 Feb 2023 08:15:04 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg6ohuyrmLJYTfEpDbp2Jwnef54gkcpZ3-BYgy4C6UxRQ@mail.gmail.com>
Message-ID: <CAHk-=wg6ohuyrmLJYTfEpDbp2Jwnef54gkcpZ3-BYgy4C6UxRQ@mail.gmail.com>
Subject: Re: block: sleeping in atomic warnings
To:     Dan Carpenter <error27@gmail.com>,
        Eric Biggers <ebiggers@kernel.org>
Cc:     linux-block@vger.kernel.org, Julia Lawall <julia.lawall@inria.fr>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Hongchen Zhang <zhanghongchen@loongson.cn>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Christian Brauner (Microsoft)" <brauner@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        maobibo <maobibo@loongson.cn>,
        Matthew Wilcox <willy@infradead.org>,
        Sedat Dilek <sedat.dilek@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Feb 7, 2023 at 6:06 AM Dan Carpenter <error27@gmail.com> wrote:
>
> block/blk-crypto-profile.c:382 __blk_crypto_evict_key() warn: sleeping in atomic context
> block/blk-crypto-profile.c:390 __blk_crypto_evict_key() warn: sleeping in atomic context

Yeah, that looks very real, but doesn't really seem to be a block bug.

__put_super() has a big comment that it's called under the sb_lock
spinlock, so it's all in atomic context, but then:

> -> __put_super()
>    -> fscrypt_destroy_keyring()
>       -> fscrypt_put_master_key_activeref()
>          -> fscrypt_destroy_prepared_key()
>             -> fscrypt_destroy_inline_crypt_key()
>                -> blk_crypto_evict_key()

and we have a comment in __blk_crypto_evict_key() that it must be
called in "process context".

However, the *normal* unmount sequence does all the cleanup *before*
it gets sb_lock, and calls fscrypt_destroy_keyring() in process
context, which is probably why it never triggers in practice, because
the "last put" is normally there, not in __put_super.

Eric? Al?

It smells like __put_super() may need to do some parts delayed, not
under sb_lock.

              Linus
