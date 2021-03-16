Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69DE7C433DB
	for <linux-block@archiver.kernel.org>; Tue, 16 Mar 2021 13:57:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C06865067
	for <linux-block@archiver.kernel.org>; Tue, 16 Mar 2021 13:57:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235193AbhCPN4y (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 Mar 2021 09:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235635AbhCPN43 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Mar 2021 09:56:29 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53901C06175F
        for <linux-block@vger.kernel.org>; Tue, 16 Mar 2021 06:56:24 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id a15so18243290vsi.7
        for <linux-block@vger.kernel.org>; Tue, 16 Mar 2021 06:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0vFQFGLSSv2U1mK0qvvL4LwGLqVceQgVdP6wn35XKeY=;
        b=xoAgoDD1cdTmq6TLmF6RruGkLb5WMpfnyAm6P6aAuCUONdWy8AbNhst39rn6HGuP+r
         ZMvwnrWEZLlzN3Vx9ViMahXAZiZQ2+781y33Egkf2RCd78XnatWEkvzZnf1wlAWi3I2A
         bm58del1VSse/HqX9larxzmPXJWguX0GtatOoGXgqqkRiiTlf2P445oXiGL8Q4nM1AW4
         GPWSLMjVWkJ8ltFsluYB/MLoxLQvoOMGApinKl5WB8fTX0+kYYVjDHcBp0p0Tp1xGKeu
         O4n6dVnU+cNA0p6dBsFbbI6KEtHkUXvunfVGenZ3pw6atiZxbLRFW+dF/ziIxx/rhWPS
         8+7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0vFQFGLSSv2U1mK0qvvL4LwGLqVceQgVdP6wn35XKeY=;
        b=rQCCDyn/yn5byfdmrlMT5jlwODWQKftpzPvHb5ooZke6Eco6IAWIcC6Ey10TuiHM+I
         T4nWkSGcmBnUb63h4RxdMb8ugRJeaXLh4JkZS1TnSo7CsyRnkL1NNfTvjgOHZuSnZKyG
         mE/29BMXDgpBIhS0XOywhxLSRhlW1tztwnot8hHmaTQZXo2VU2vVFnnqaLMa3ayG6mkl
         z5SvVcWQEhca2zmbICvZw1abnknJTsxxgqQvvWpvWznyYFNFbdXLinS7Qq5bdXBoBq61
         sL6iZK8+4Kf9aEDEKap7RTt7cgGhhVHpdUCp0uBbuRwsHRq1DSHzZckGKLoE8YqfHBDz
         YhUw==
X-Gm-Message-State: AOAM530InRrjTGiC+sngHbNtFaC1qaNKZNFNvYvTgTa4Nlbr5SAMbWLF
        2m8iR57zgyBt3he9o9gh5TwRBADc7YM0Kh9EX7243g==
X-Google-Smtp-Source: ABdhPJynQHxnw3W3Y2x9UcxU8AP4VSE+hIcOBueGj+Oknjhjx9EbtnzZe9qkmrxRsq2741T+btkAncvMqvXiiHhSsic=
X-Received: by 2002:a67:8c89:: with SMTP id o131mr5786746vsd.42.1615902983266;
 Tue, 16 Mar 2021 06:56:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210309015750.6283-1-peng.zhou@mediatek.com> <CACRpkdYTkW7b9SFEY6Ubq4NicgR_5ewQMjE2zHvGbgxYadhHQQ@mail.gmail.com>
 <YEpqkAq6wOZ+TpR9@gmail.com> <CAPDyKFoWg7HYHAbxYJRbOad5kqm+rzVLVQ0O3g76ROO5Z+MF3Q@mail.gmail.com>
 <1615884533.21508.118.camel@mbjsdccf07> <CAPDyKFqtjYVAAe_wUKQC3n3ok5bUpGtpu=TUiOgFmbb6+Qkg=A@mail.gmail.com>
 <1615893329.21508.128.camel@mbjsdccf07>
In-Reply-To: <1615893329.21508.128.camel@mbjsdccf07>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 16 Mar 2021 14:55:46 +0100
Message-ID: <CAPDyKFqaFbviwxQ8U_X8U64F7OwNaxXde6XdUcGPeGg8k9MWWg@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] mmc: Mediatek: enable crypto hardware engine
To:     "Peng.Zhou" <peng.zhou@mediatek.com>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-block <linux-block@vger.kernel.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Satya Tangirala <satyat@google.com>,
        Wulin Li <wulin.li@mediatek.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Sudeep Holla <sudeep.holla@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 16 Mar 2021 at 12:22, Peng.Zhou <peng.zhou@mediatek.com> wrote:
>
> On Tue, 2021-03-16 at 11:09 +0100, Ulf Hansson wrote:
> > On Tue, 16 Mar 2021 at 09:55, Peng.Zhou <peng.zhou@mediatek.com> wrote:
> > >
> > > On Fri, 2021-03-12 at 10:05 +0100, Ulf Hansson wrote:
> > > > + Arnd, Sudeep
> > > >
> > > > On Thu, 11 Mar 2021 at 20:08, Eric Biggers <ebiggers@kernel.org> wrote:
> > > > >
> > > > > On Thu, Mar 11, 2021 at 02:48:23PM +0100, Linus Walleij wrote:
> > > > > > Hi Peng,
> > > > > >
> > > > > > thanks for your patch!
> > > > > >
> > > > > > On Tue, Mar 9, 2021 at 3:06 AM Peng Zhou <peng.zhou@mediatek.com> wrote:
> > > > > >
> > > > > > > Use SMC call enable hardware crypto engine
> > > > > > > due to it only be changed in ATF(EL3).
> > > > > > >
> > > > > > > Signed-off-by: Peng Zhou <peng.zhou@mediatek.com>
> > > > > >
> > > > > > Unfortunately this commit message is way to short to
> > > > > > understand what is going on, and has a lot of assumed
> > > > > > previous knowledge.
> > > > > >
> > > > > > Can you expand the commit message so that anyone
> > > > > > who just know MMC and some SoC basics can understand
> > > > > > what an SMC call and and what ATF(EL3) means?
> > > > > >
> > > > > > I assume this some kind of inline encryption?
> > > > > >
> > > > > > I think maybe linux-block mailing list need to be involved
> > > > > > because there is certain a Linux standard way of setting
> > > > > > up inline encryption for the block layer.
> > > > > >
> > > > > > For example: how is the key to be used derived?
> > > > > > How is the device unlocked in the first place?
> > > > > >
> > > > > > If I insert a LUKS encrypted harddrive in a Linux machine
> > > > > > the whole system is pretty much aware of how this should
> > > > > > be handled and everything "just works", I enter a pass
> > > > > > phrase and off it goes. I can use symmetric keys as well.
> > > > > > How is this stuff done for this hardware?
> > > > > >
> > > > > > > +       /*
> > > > > > > +        * 1: MSDC_AES_CTL_INIT
> > > > > > > +        * 4: cap_id, no-meaning now
> > > > > > > +        * 1: cfg_id, we choose the second cfg group
> > > > > > > +        */
> > > > > > > +       if (mmc->caps2 & MMC_CAP2_CRYPTO)
> > > > > > > +               arm_smccc_smc(MTK_SIP_MMC_CONTROL,
> > > > > > > +                             1, 4, 1, 0, 0, 0, 0, &smccc_res);
> > > > > >
> > > > > > The same as above: these comments assume that everyone
> > > > > > already knows what is going on.
> > > > > >
> > > > > > AES encryption requires a key and I don't see the driver
> > > > > > setting up any key. How is the code in this file:
> > > > > > drivers/mmc/core/crypto.c
> > > > > > interacting with your driver?
> > > > > > drivers/mmc/host/cqhci-crypto.c
> > > > > > is used by SDHCI and is quite readable and I see what is going on.
> > > > > > For example it contains functions like:
> > > > > > cqhci_crypto_program_key()
> > > > > > cqhci_crypto_keyslot_program()
> > > > > > cqhci_crypto_clear_keyslot()
> > > > > > cqhci_crypto_keyslot_evict()
> > > > > > cqhci_find_blk_crypto_mode()
> > > > > >
> > > > > > MMC_CAP2_CRYPTO is used as a sign that the driver
> > > > > > can do inline encryption, then devm_blk_ksm_init() is called
> > > > > > to initialize a block encryption abstraction with the block layer.
> > > > > > Ops are registered using
> > > > > > struct blk_ksm_ll_ops cqhci_ksm_ops.
> > > > > >
> > > > > > This is very straight forward.
> > > > > >
> > > > > > But where does all the above happen for this driver?
> > > > > >
> > > > >
> > > > > It happens in the same place, cqhci-crypto.c.  Mediatek's eMMC inline encryption
> > > > > hardware follows the eMMC standard fairly closely, so Peng's patch series just
> > > > > sets MMC_CAP2_CRYPTO to make it use the standard cqhci crypto code, and does a
> > > > > couple extra things to actually enable the hardware's crypto support on Mediatek
> > > > > platforms since it isn't enabled by default.  (*Why* it requires an SMC call to
> > > > > enable instead of just working as expected, I don't know though.)
> > > >
> > > > As I have probably indicated earlier, I am starting to become more and
> > > > more annoyed with these arm_smccc_smc() calls in generic drivers.
> > > >
> > > > As a matter of fact, I think the situation is about to explode. Just
> > > > do a "git grep arm_smccc_smc" and you will find that it's not only SoC
> > > > specific drivers that call them. In general we want to keep drivers
> > > > portable and this is clearly moving in the wrong direction. Or maybe
> > > > it's just me being grumpy and having a bad day. :-)
> > > >
> > > > In the Qcom mmc case (drivers/mmc/host/sdhci-msm.c) for eMMC inline
> > > > encryption, the arm_smccc_smc() call is slightly better handled as
> > > > it's abstracted behind a Qcom specific firmware API. So, sdhci-msm.c
> > > > calls qcom_scm_ice_set_key() (implemented in
> > > > drivers/firmware/qcom_scm.c) to program a key. I guess we don't have
> > > > an abstraction layer that would fit for this case, right?
> > > >
> > > > My point is, when there is no proper abstraction layer to use for the
> > > > relevant arm_smccc_smc() call, the Qcom way is fine to me.
> > > >
> > > > In this Mediatek case, it looks slightly different. To me it looks
> > > > more like a resource that needs to be turned on/off to enable/disable
> > > > the "inline encryption engine". Could it be modeled as phy,
> > > > power-rail, clock, pinctrl or perhaps behind a PM domain (where SoC
> > > > specific calls makes perfect sense).
> > > >
> > > > Peng can you please elaborate on what goes on behind the
> > > > arm_smccc_smc() call, as that would help us to understand what
> > > > abstraction layer to pick?
> > > >
> > > > [...]
> > > >
> > > > Kind regards
> > > > Uffe
> > >
> > > Hi All,
> > >
> > > First of all, I appreciated that you are interested in my patch series
> > > and give me so much significant suggestions! Then, please let me summary
> > > the detail information about MediaTek eMMC hardware crypto IP.
> > >
> > > Before that, as you know, due to I work for MediaTek.inc that means I'm
> > > as an employee in this mail thread, so I don't give any comment about
> > > other SoC manufacturers.I will only focus on ours.
> > >
> > >
> > > [Background] Why I upstream this patch series?
> > > Obiviously, we want to support hardware level file base encryption, file
> > > encryption had been a mandatory feature in mobile device such as Android
> > > environment.
> > >
> > > A few years ago, we only support software level file encryption, it
> > > based on the reality of that time:
> > >  - There is no official encryption specification announced by JEDEC or
> > > any device manufacturers
> > >  - File based encryption is not a mandatory feature for mobile devices
> > >  - Security is not the highest priority thing for our most of Customers
> > >
> > > Time can fly and Market requirement is also, hardware level encryption
> > > functions had been add in our SoCs in soon, because that:
> > >  - An encryption specification which is widely recognized by device
> > > manufacturers and SoC manufacturers had been announced. Although it
> > > doesn't been accepted by JEDEC until now, most of eMMC device
> > > manufacturers had support it.
> > >  - Performance, special in low end mobile device, to some extent,
> > > hardware encryption could reduce some CPU loading,
> > >  - Almost overnight, Security has became the super star, everyone want
> > > it, consider the performance (comparing with full disk encryption) and
> > > flexibility, file based encryption is indispensable.
> > >
> > > One more thing, there is no common framework in kernel when our SoCs had
> > > crypto IP in that time, so we design a special framework in kernel to
> > > support it. In fact, we had support hardware encryption for several
> > > years in a special and non-public way.
> > >
> > > You'll know the rest, Eric design a common framework that lets SoC
> > > manufacturers support hardware encryption easier now. That' why we give
> > > up our own special private way and try to support it.
> > >
> > > In fact, at this point in time, we have used this framework(include my
> > > patch series) in our mobile products with newest Android version for
> > > almost one year.
> > >
> > >
> > > [Your question] Why we need use SMC call in our driver? or Why our
> > > crypto hardware IP is not default on?
> > >
> > > Yes, MediaTek eMMC crypto hardware IP is default off in current design
> > > and most important is we only turn it on in ARM exception level 3
> > > (EL3,the highest security level), that means we can only control it
> > > under ARM trust firmware (ATF) environment, but kernel space (it's EL2
> > > in our platform).
> > >
> > > I can get your bewilderment: why it's default off and why put it in high
> > > security level control?
> >
> > Actually, I don't have an issue with this, at all. Instead, my worries
> > are about keeping generic drivers portable, which means resources need
> > to be modelled through proper abstraction layers. SoC specific drivers
> > are different, they don't necessarily need to cope with this
> > requirement.
> >
> > Additionally, to me, it makes perfect sense to allow the crypto IP
> > block to be powered off, as you would likely waste energy to have it
> > always powered on, especially when it's not being in use.
> >
> > So, this boils down to understand what "turn on" crypto hardware IP
> > actually means? Is it a clock, a phy, a power-rail or perhaps a
> > combination of things that is turned on for the IP to work? What
> > happens behind the SMC call?
> >
> > The answer to this question will help us understand what abstraction
> > layer we should pick.
>
> Hi,
>
> "turn on" crypto hardware IP has no related about clock or power, it
> means:
>
> On: eMMC host encrypt/dencrpt data works normally.
> Off: eMMC host encrypt/dencrpt data works error, although clock and
> power had been enabled. Error is command timeout or bus hang in our
> platforms.
>
> SMC call means write a register of our SoC specific, a bit of a special
> register actually, such as 0 means disable and 1 means enable.

Okay, thanks for clarifying.

It looks like we have a couple of options to support this. I suggest
we consider the two below, but perhaps others (Arnd/Linus?) have
better ideas?

1)
Model the power on/off of the silicon around the crypto HW through a
phy provider driver. The phy provider should then manage the "ice"
clock and the SMC call, through the ->power_on|off() callbacks, while
the mmc driver would act as the consumer of the phy. This would be
rather straightforward to implement, but I guess it can be debated if
this fits as a phy or not.

2)
Another slightly more complicated solution, would be to manage the SMC
call and the "ice" clock through a PM domain (aka genpd provider). As
a matter of fact, we already have a couple of references that use the
genpd infracture like this, as it allows devices to be turned on/off
from SoC specific code, through runtime PM. I wouldn't mind giving you
more pointers to examples for inspirations, if this is the option we
decide to go for.

Kind regards
Uffe
