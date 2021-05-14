Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62A8CC433ED
	for <linux-block@archiver.kernel.org>; Fri, 14 May 2021 20:20:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4419B6121E
	for <linux-block@archiver.kernel.org>; Fri, 14 May 2021 20:20:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232478AbhENUVf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 14 May 2021 16:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbhENUVe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 May 2021 16:21:34 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 738A1C061574
        for <linux-block@vger.kernel.org>; Fri, 14 May 2021 13:20:22 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id i13so6072502edb.9
        for <linux-block@vger.kernel.org>; Fri, 14 May 2021 13:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zj/dlxgrTFi/afXdqvpoKnC0fO1FIFdLyxVrDXldBSs=;
        b=YFKY9Xahh+37BAr6aWqyWYu1Mb7APXH6ODm/OL23XmTx5cHPfE5nvsgH3V9cI44nS0
         EW6HUNU9PMYQx+djBq7ws8ietkyGay3lY9V3u/1Wuw/v3Pr2ScmDgx0fOcF6ZkLkBuPr
         cN3FjgtrPRUQDfA1h2PJ+U+sspjArlX7AElF0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zj/dlxgrTFi/afXdqvpoKnC0fO1FIFdLyxVrDXldBSs=;
        b=eoarXaFb3Zfu05y2JndAR1RI5obLDVFGgzFJZ0g5Ha/c0XwnplFWXZ1ARaL/0JYyhp
         ZKuGC+edsyuCJElb4aGm6G7ko67n5WbjCBxXiENxpGqEAWfdsxTaTSIg3Sr8pRIG0wN/
         rV5emhU2kwP0z0viF3U5BO/MaE+ToIuNxKffonfg2xsuIQldFAoDjpS9QXzpnNHzRSR+
         elsDjSwzMRxe4cQtm5eXJczycunoIiAvRbz5uMJ/G9dEzD2YLYr90lFZKE38oXIQgEDV
         iJ77l/fzAir0s+GIkj0DUsr4OsL7HMsw8s9/rWuUp7lHlrqCbnBs8Gdp+5AGRHcDg3Ge
         v/ZQ==
X-Gm-Message-State: AOAM530laWFTwPt0IerH3lbsMS9px3/5n3dPEdUKHNTgQ5ddRopoTByB
        2KsyTjJUwadpUVxEnd1rBGFXA5pFKD8veOa0OUQ=
X-Google-Smtp-Source: ABdhPJx14qAH984lldTb/FQN/xzcuL12aVCxQ1RL9F0t5eB5S0OYcPpIue/n+843HXA4pFPcyHQxqw==
X-Received: by 2002:a05:6402:2712:: with SMTP id y18mr60604783edd.41.1621023621048;
        Fri, 14 May 2021 13:20:21 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id t2sm2427753edd.58.2021.05.14.13.20.19
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 May 2021 13:20:20 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id v5so24925580edc.8
        for <linux-block@vger.kernel.org>; Fri, 14 May 2021 13:20:19 -0700 (PDT)
X-Received: by 2002:a05:6512:374b:: with SMTP id a11mr32730248lfs.377.1621023609037;
 Fri, 14 May 2021 13:20:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210514100106.3404011-1-arnd@kernel.org> <CAHk-=whGObOKruA_bU3aPGZfoDqZM1_9wBkwREp0H0FgR-90uQ@mail.gmail.com>
 <2408c893-4ae7-4f53-f58c-497c91f5b034@synopsys.com> <CAHk-=wih8UHDwJ8x6m-p0PQ7o4S4gOBwGNs=w=q10GNY7A-70w@mail.gmail.com>
 <14016937-b9c3-c131-db18-f97081806c7f@synopsys.com>
In-Reply-To: <14016937-b9c3-c131-db18-f97081806c7f@synopsys.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 14 May 2021 13:19:53 -0700
X-Gmail-Original-Message-ID: <CAHk-=whdR4OLJjwaU_nJhmS4n6ruGK4XFuLxA7zEOoCV7U=QLA@mail.gmail.com>
Message-ID: <CAHk-=whdR4OLJjwaU_nJhmS4n6ruGK4XFuLxA7zEOoCV7U=QLA@mail.gmail.com>
Subject: Re: [PATCH v2 00/13] Unify asm/unaligned.h around struct helper
To:     Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Borislav Petkov <bp@alien8.de>,
        Eric Dumazet <edumazet@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ganapathi Bhat <ganapathi017@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        James Morris <jmorris@namei.org>, Jens Axboe <axboe@kernel.dk>,
        John Johansen <john.johansen@canonical.com>,
        Jonas Bonn <jonas@southpole.se>,
        Kalle Valo <kvalo@codeaurora.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Rich Felker <dalias@libc.org>,
        "Richard Russon (FlatCap)" <ldm@flatcap.org>,
        Russell King <linux@armlinux.org.uk>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Sharvari Harisangam <sharvari.harisangam@nxp.com>,
        Stafford Horne <shorne@gmail.com>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Xinming Hu <huxinming820@gmail.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        "openrisc@lists.librecores.org" <openrisc@lists.librecores.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        linux-sparc <sparclinux@vger.kernel.org>,
        "linux-ntfs-dev@lists.sourceforge.net" 
        <linux-ntfs-dev@lists.sourceforge.net>,
        linux-block <linux-block@vger.kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, May 14, 2021 at 12:45 PM Vineet Gupta
<Vineet.Gupta1@synopsys.com> wrote:
>
> Well, not really, the issue manifested in ARC O3 testing, but I showed
> the problem existed for arm64 gcc too.

.. but not with a supported kernel configuration.

> > So in fact it's not even queued up for 5.14 due to this all, I just dropped it.
>
> But Why.

I just didn't have time to deal with it during the merge window. If
you keep it alive, that's all fine and good.

                Linus
