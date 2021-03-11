Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47EE9C4332E
	for <linux-block@archiver.kernel.org>; Thu, 11 Mar 2021 13:49:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0F8664FF2
	for <linux-block@archiver.kernel.org>; Thu, 11 Mar 2021 13:49:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233725AbhCKNtF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 Mar 2021 08:49:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233306AbhCKNsg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Mar 2021 08:48:36 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21C26C061574
        for <linux-block@vger.kernel.org>; Thu, 11 Mar 2021 05:48:36 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id 184so2216741ljf.9
        for <linux-block@vger.kernel.org>; Thu, 11 Mar 2021 05:48:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rEk/4ipeOtDShwpMiaY0Jz75T1hvoWxqNerJf3TNtsY=;
        b=h7sRUR7UJvx8pzoyO9YqyyaJDVXtOKxCVBSGohK6BN9dMEg0jSslERxAiTdrJERkNb
         n9kWMjX3VnxLcZdhOSLPa4qa0q9cm4RZie85nThsVbLcqlobnRxYhi/heasGzDxz9klB
         duV5ql6q8G1CkgCIkgmvhtm5zcP7qrkoVSXDev8ksc8RPPuoPxvFC3u8Rg/4ORNRT9HS
         iAXmae/T0NxeM78M6HdrQvUXASeGmALHROR33V+gaKWbBBRgDKX6qIEdDAkVmr3eOH8l
         iVCIMkpWp33gwzKiWZ3eiTU3gN2BMXTfFNg/dMwXO13KISS9NEDkKy/61qW09X4UozkG
         QweQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rEk/4ipeOtDShwpMiaY0Jz75T1hvoWxqNerJf3TNtsY=;
        b=OuXv7ANdRYPhLnfS9XsLzQbtJ0VZQRHhJrS3ttfQyB69ekxAyfy9j17YUcbrSqwGrz
         C8nORiYTgW5+eNeTh64nwjXzrGneyBlqSGAcaswg9W7iGXUbA67lgDk2Y3t/WYCoghDn
         vlGO6pMC6TPf+sFo1hhtRK4qBXv5Au17F9UEtr6+kGmZ4b9g0CxwXA92AyKFIY4WILlx
         uKln9Vqbc8C6NW2UAKbdGzFzPH5BsyuqTVYdJ2B/Zxjqaz02L3unQk/Bg8/YFRz6eqMY
         wI+GmDC+UzXDQAfJLcFgW4rHNfVU173IsRhYsAfEII6GWGT3eWp86jAgWAgvkoK43Zvu
         H11w==
X-Gm-Message-State: AOAM533vlhZoW8G+/79VudOuTjcbhB6Pg4jUJDHGYlB2+9AyLoVzj3+U
        BWxAWiTUqFoToB8iReTtZdbmn25SY0CylmZein/pgQ==
X-Google-Smtp-Source: ABdhPJyjBoMobf99RmUaXcBwKmWGeJ8EGILuW2y02hvc6McYOP2Ijymqky6V0r5VlBrzBaNwTLixfX39I/7NSFBgssI=
X-Received: by 2002:a2e:9cb:: with SMTP id 194mr4881771ljj.438.1615470514567;
 Thu, 11 Mar 2021 05:48:34 -0800 (PST)
MIME-Version: 1.0
References: <20210309015750.6283-1-peng.zhou@mediatek.com>
In-Reply-To: <20210309015750.6283-1-peng.zhou@mediatek.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 11 Mar 2021 14:48:23 +0100
Message-ID: <CACRpkdYTkW7b9SFEY6Ubq4NicgR_5ewQMjE2zHvGbgxYadhHQQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] mmc: Mediatek: enable crypto hardware engine
To:     Peng Zhou <peng.zhou@mediatek.com>,
        linux-block <linux-block@vger.kernel.org>,
        Eric Biggers <ebiggers@kernel.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Satya Tangirala <satyat@google.com>,
        Wulin Li <wulin.li@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Peng,

thanks for your patch!

On Tue, Mar 9, 2021 at 3:06 AM Peng Zhou <peng.zhou@mediatek.com> wrote:

> Use SMC call enable hardware crypto engine
> due to it only be changed in ATF(EL3).
>
> Signed-off-by: Peng Zhou <peng.zhou@mediatek.com>

Unfortunately this commit message is way to short to
understand what is going on, and has a lot of assumed
previous knowledge.

Can you expand the commit message so that anyone
who just know MMC and some SoC basics can understand
what an SMC call and and what ATF(EL3) means?

I assume this some kind of inline encryption?

I think maybe linux-block mailing list need to be involved
because there is certain a Linux standard way of setting
up inline encryption for the block layer.

For example: how is the key to be used derived?
How is the device unlocked in the first place?

If I insert a LUKS encrypted harddrive in a Linux machine
the whole system is pretty much aware of how this should
be handled and everything "just works", I enter a pass
phrase and off it goes. I can use symmetric keys as well.
How is this stuff done for this hardware?

> +       /*
> +        * 1: MSDC_AES_CTL_INIT
> +        * 4: cap_id, no-meaning now
> +        * 1: cfg_id, we choose the second cfg group
> +        */
> +       if (mmc->caps2 & MMC_CAP2_CRYPTO)
> +               arm_smccc_smc(MTK_SIP_MMC_CONTROL,
> +                             1, 4, 1, 0, 0, 0, 0, &smccc_res);

The same as above: these comments assume that everyone
already knows what is going on.

AES encryption requires a key and I don't see the driver
setting up any key. How is the code in this file:
drivers/mmc/core/crypto.c
interacting with your driver?
drivers/mmc/host/cqhci-crypto.c
is used by SDHCI and is quite readable and I see what is going on.
For example it contains functions like:
cqhci_crypto_program_key()
cqhci_crypto_keyslot_program()
cqhci_crypto_clear_keyslot()
cqhci_crypto_keyslot_evict()
cqhci_find_blk_crypto_mode()

MMC_CAP2_CRYPTO is used as a sign that the driver
can do inline encryption, then devm_blk_ksm_init() is called
to initialize a block encryption abstraction with the block layer.
Ops are registered using
struct blk_ksm_ll_ops cqhci_ksm_ops.

This is very straight forward.

But where does all the above happen for this driver?

I get the feeling that some magic is happening in outoftree
patches or in the secure world, and that is not how we do
these things, you have to use the frameworks.

Yours,
Linus Walleij
