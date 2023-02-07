Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DDDEC636D3
	for <linux-block@archiver.kernel.org>; Tue,  7 Feb 2023 18:25:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232257AbjBGSZx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Feb 2023 13:25:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232269AbjBGSZk (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Feb 2023 13:25:40 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCE2265A6
        for <linux-block@vger.kernel.org>; Tue,  7 Feb 2023 10:25:08 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id p26so44797068ejx.13
        for <linux-block@vger.kernel.org>; Tue, 07 Feb 2023 10:25:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pizbVdzIu8iuBwFy6mvT//fygI8uGhRT/vJXKJ1LaVY=;
        b=Cbdf46oletXuJOCJFIQa/rXoWMh2VweqM3WV0BdriyXCVvt01UIAIUTfYvqvj42FI2
         dGIfD10JkRckky68XPz+miwRmw315N2EVOwurVjhjAEG1ALANVLXtxKLg2HenyvlPIf3
         BQ+5TFXwBlTTO9jEL5tKFIsun1OjHvxjw507I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pizbVdzIu8iuBwFy6mvT//fygI8uGhRT/vJXKJ1LaVY=;
        b=sOJoPHhpYRR/mL39k4C18YNRDLdt2YU9jr8HhvDxh45U+LZJDPFCqxsm0JMDejIpj3
         g2rbU2/D1Rr5Y97ggL0dhvvNTAtVkW0VF2CSOZ6/r6GbaQIoGZ9OhWtQbt2CI74nPQHo
         IBBmxaQ67kPbxrsY4O40Je8PryPSeha4p+5tvCwewMXXbYcRQ8hi49d0DdO+kiVmYUyq
         SMWjRCtGAeIKrVKQMm4cqMhcWlAaoKxqWixvEda44WZM2OneP3i+iNnrUnX1Cf318qD0
         CY0OOyCKeJRHQ1LqPCQkOO2ln17NJJwUuwXmoKNt1iK3SXuWU5Zep9kNSHiLGy4jaJ0I
         n4Vw==
X-Gm-Message-State: AO0yUKW6Vi2OXmm4i/MzssE+tmDu6j9znbnByYJtc3DGN85XfGJO5Bi9
        zPfh+BTLBZlmVh7OvbNFXLOycEmkmoqvxQ9IFJeA6w==
X-Google-Smtp-Source: AK7set8Cy2XARWhbNPC1Qf9lCt7YnvJ7ThEl/BSWby5NcWNS9fvFgTeME69E+SEa5r/h1Vu9onU5fw==
X-Received: by 2002:a17:906:da1b:b0:86d:7c2d:f65b with SMTP id fi27-20020a170906da1b00b0086d7c2df65bmr4355732ejb.27.1675794304730;
        Tue, 07 Feb 2023 10:25:04 -0800 (PST)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id v21-20020a170906339500b008838b040454sm7217551eja.95.2023.02.07.10.25.02
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Feb 2023 10:25:02 -0800 (PST)
Received: by mail-ej1-f41.google.com with SMTP id ml19so45074405ejb.0
        for <linux-block@vger.kernel.org>; Tue, 07 Feb 2023 10:25:02 -0800 (PST)
X-Received: by 2002:a17:906:4e46:b0:87a:7098:ca09 with SMTP id
 g6-20020a1709064e4600b0087a7098ca09mr970336ejw.78.1675794302170; Tue, 07 Feb
 2023 10:25:02 -0800 (PST)
MIME-Version: 1.0
References: <20230129060452.7380-1-zhanghongchen@loongson.cn>
 <CAHk-=wjw-rrT59k6VdeLu4qUarQOzicsZPFGAO5J8TKM=oukUw@mail.gmail.com>
 <Y+EjmnRqpLuBFPX1@bombadil.infradead.org> <4ffbb0c8-c5d0-73b3-7a4e-2da9a7b03669@inria.fr>
 <Y+Ja5SRs886CEz7a@kadam> <CAHk-=wg6ohuyrmLJYTfEpDbp2Jwnef54gkcpZ3-BYgy4C6UxRQ@mail.gmail.com>
 <Y+KP/fAQjawSofL1@gmail.com>
In-Reply-To: <Y+KP/fAQjawSofL1@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 7 Feb 2023 10:24:45 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgmZDqCOynfiH4NFoL50f4+yUjxjp0sCaWS=xUmy731CQ@mail.gmail.com>
Message-ID: <CAHk-=wgmZDqCOynfiH4NFoL50f4+yUjxjp0sCaWS=xUmy731CQ@mail.gmail.com>
Subject: Re: block: sleeping in atomic warnings
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Dan Carpenter <error27@gmail.com>, linux-block@vger.kernel.org,
        Julia Lawall <julia.lawall@inria.fr>,
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

On Tue, Feb 7, 2023 at 9:53 AM Eric Biggers <ebiggers@kernel.org> wrote:
>
> It's a false positive.  See the comment above fscrypt_destroy_keyring()

Hmm. Ok. Unfortunate.

>  If the filesystem has not been mounted, then the call from __put_super()
> is needed, but blk_crypto_evict_key() can never be executed in that case.

It's not all that clear that some *other* error might not have
happened to keep the mount from actually succeeding, but after the
keys have been instantiated?

IOW, what's the thing that makes "blk_crypto_evict_key() can never be
executed in that case" be obvious?

I think _that_ is what might want a comment, about how we always call
generic_shutdown_super() before the last put_super() happens.

It does seem like Dan's automated checks could be useful, but if
there's no sane way to avoid the false positives, it's always going to
be a lot of noise ;(

           Linus
