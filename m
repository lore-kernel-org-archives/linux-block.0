Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09941C43381
	for <linux-block@archiver.kernel.org>; Fri, 12 Mar 2021 10:48:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9F186502B
	for <linux-block@archiver.kernel.org>; Fri, 12 Mar 2021 10:48:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233502AbhCLKrr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 12 Mar 2021 05:47:47 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:49781 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233555AbhCLKrY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 12 Mar 2021 05:47:24 -0500
Received: from mail-ot1-f52.google.com ([209.85.210.52]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MKbTo-1l1u1G0aui-00KwvW; Fri, 12 Mar 2021 11:47:22 +0100
Received: by mail-ot1-f52.google.com with SMTP id o19-20020a9d22130000b02901bfa5b79e18so1159376ota.0;
        Fri, 12 Mar 2021 02:47:21 -0800 (PST)
X-Gm-Message-State: AOAM531kDOMqe2OxjYvkLN2T/PHI8L6zZaBQuqHLTcnpXj8Wdb1q3N5c
        kua2Dl1LVrEei7N451a4eYnJtTky3K6NsYCDgZo=
X-Google-Smtp-Source: ABdhPJz7zdlDpmXmM7BtqEG5Qr+1v5ljUta4AloLV5NxxcVPVwQnNpopJT0aoWIPmmaxOc8wySYDowkTwwg0qlmDJT8=
X-Received: by 2002:a05:6830:148c:: with SMTP id s12mr2953752otq.251.1615546040667;
 Fri, 12 Mar 2021 02:47:20 -0800 (PST)
MIME-Version: 1.0
References: <20210309015750.6283-1-peng.zhou@mediatek.com> <CACRpkdYTkW7b9SFEY6Ubq4NicgR_5ewQMjE2zHvGbgxYadhHQQ@mail.gmail.com>
 <YEpqkAq6wOZ+TpR9@gmail.com> <CAPDyKFoWg7HYHAbxYJRbOad5kqm+rzVLVQ0O3g76ROO5Z+MF3Q@mail.gmail.com>
In-Reply-To: <CAPDyKFoWg7HYHAbxYJRbOad5kqm+rzVLVQ0O3g76ROO5Z+MF3Q@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 12 Mar 2021 11:47:04 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0qEGS0AxyyDkzv2BD=vC=4GBSt5qXbM9t=jkWi4LXmBw@mail.gmail.com>
Message-ID: <CAK8P3a0qEGS0AxyyDkzv2BD=vC=4GBSt5qXbM9t=jkWi4LXmBw@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] mmc: Mediatek: enable crypto hardware engine
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Peng Zhou <peng.zhou@mediatek.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-block <linux-block@vger.kernel.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Satya Tangirala <satyat@google.com>,
        Wulin Li <wulin.li@mediatek.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:oYK1jENEdu4qKWbDYYZKq+7LCHSfxKlnsb37fZHFvF71/mUIs7o
 F7O8Wmc8nS02vPJOHcEfKloMirN4p5GB0yLAyTmjPCaWsdDAg1yEzQwHjymyjT+b8fkQ2I5
 Jg1g4pQE3L9mSwrJZJUmZwf+Xp/RiA09vTaq4cGQgBklB3fKb5n6j+3Ls8+zWM0C5N/P7P6
 9T2TsQMCJSUQEnj7fUXKw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PDalZpyHKKA=:QeYizN1udW2n8cyQEMpMTq
 Sp8oEA3kOze6SK6aoRtB43Y8+pJrl++qD2JuF/Slz4qfnr5MMG0MH48Xbpjg2mCWesfBIaH++
 tfF0TWs7kJnetGdxq9q7LjF6eYvYw3uFj9mHy8TIzZWIphbVhLHCIWKo40yfQkbu7LOnW/6tD
 3f3TSGDdrptoL66HQ0Xqa8iCwmCTB8hv5ef0vd1XUvLtOEtSAcG79nV5mlivsp55ZyBQcsAfM
 fJuyDmWCyxcba4PXYdurbKjoaaTggye0GsrIGF2CGsgf81es/Zzwye1ZF7+8vVNp1ZhTMWitd
 CzPlsdq3+5TI6RyhrFEY9e/Tz+BKXZh3zN7aNQmrH3c5iCnRdvvJppfx8SLQDthHiHEG8WY+z
 CTD4gR5NGI1A8L8NHIUxM7okUGg4RexRsd+LpGv4swEvV78I49vmHfFdeXP9KxxjACh7uDJRz
 YMPzB+MKgnPywrPjAHeH1k1nFdReVIYsnJ2RkZyt3rHPwIoxnTnIEt/IGNKStjXkv5Ir47zBx
 QPBK+I1hxANePobajn02RTy0K4r+opoxqvICcVMC4Kdys0e6PGvkVQJ4rf26Mi6Qg==
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Mar 12, 2021 at 10:05 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On Thu, 11 Mar 2021 at 20:08, Eric Biggers <ebiggers@kernel.org> wrote:
> > On Thu, Mar 11, 2021 at 02:48:23PM +0100, Linus Walleij wrote:
> >
> > It happens in the same place, cqhci-crypto.c.  Mediatek's eMMC inline encryption
> > hardware follows the eMMC standard fairly closely, so Peng's patch series just
> > sets MMC_CAP2_CRYPTO to make it use the standard cqhci crypto code, and does a
> > couple extra things to actually enable the hardware's crypto support on Mediatek
> > platforms since it isn't enabled by default.  (*Why* it requires an SMC call to
> > enable instead of just working as expected, I don't know though.)
>
> As I have probably indicated earlier, I am starting to become more and
> more annoyed with these arm_smccc_smc() calls in generic drivers.
>
> As a matter of fact, I think the situation is about to explode. Just
> do a "git grep arm_smccc_smc" and you will find that it's not only SoC
> specific drivers that call them. In general we want to keep drivers
> portable and this is clearly moving in the wrong direction. Or maybe
> it's just me being grumpy and having a bad day. :-)

I agree, this really does feel underspecified, as there is no way to
actually know which smc interfaces are available, or which ones belong
to a particular driver. Simply calling them is not that different from
using an ioremap() on a hardwired physical address just because you
know where a device is on a given SoC. Or another way of looking at
it is that these are function calls that are arbitrarily moved out from
the kernel into a piece of (usually) closed source software running on
the same chip.

A first step toward managing this better might be to enforce namespaces
of the smc calls, if we can find a way to limit arm_smccc_smc() calls
those that have the first argument defined in a central header file.

        Arnd
