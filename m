Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F1B5C433DB
	for <linux-block@archiver.kernel.org>; Thu, 11 Mar 2021 19:09:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AF4664E60
	for <linux-block@archiver.kernel.org>; Thu, 11 Mar 2021 19:09:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbhCKTIc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 Mar 2021 14:08:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:39536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229721AbhCKTIE (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Mar 2021 14:08:04 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 77EF664FE0;
        Thu, 11 Mar 2021 19:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615489682;
        bh=+MqxPqLxS0fmcZSkxqaGS/7xnCYlQhr8+DK+/ePJsDE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V5MNT4BHOqod0O8XEiHiDDZBzJM7BDrJFZjL0FvTnGjdV85TOijRaR9AQvrOnhQVV
         ulfWeO2Q785ENXGd2iGmhcoNfHLkxx2Bqc08uWVvOnOubM6nPIb0RQsSvdDDieSMQp
         KppyVCtJpMEDvovtpatEtA4lyZkdu3Xj28dkoQmEbWotinPIbdSq69fhHZqd+5XoOc
         dWbaROFQm2qh/8YRFEwDfHNd49yvkAMK2B3kTwPRFD1mfJ93HRE0Noih6TRvCZ90hV
         AF+nW/B5JSeAfFgAf+u0Rld8GnK/9c9HWhHUrV1gMUzjZCMNEk+hNUpJ30iF/+g1CN
         3Fv1Efm/4Cegg==
Date:   Thu, 11 Mar 2021 11:08:00 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Peng Zhou <peng.zhou@mediatek.com>,
        linux-block <linux-block@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Satya Tangirala <satyat@google.com>,
        Wulin Li <wulin.li@mediatek.com>
Subject: Re: [PATCH v2 2/4] mmc: Mediatek: enable crypto hardware engine
Message-ID: <YEpqkAq6wOZ+TpR9@gmail.com>
References: <20210309015750.6283-1-peng.zhou@mediatek.com>
 <CACRpkdYTkW7b9SFEY6Ubq4NicgR_5ewQMjE2zHvGbgxYadhHQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdYTkW7b9SFEY6Ubq4NicgR_5ewQMjE2zHvGbgxYadhHQQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Mar 11, 2021 at 02:48:23PM +0100, Linus Walleij wrote:
> Hi Peng,
> 
> thanks for your patch!
> 
> On Tue, Mar 9, 2021 at 3:06 AM Peng Zhou <peng.zhou@mediatek.com> wrote:
> 
> > Use SMC call enable hardware crypto engine
> > due to it only be changed in ATF(EL3).
> >
> > Signed-off-by: Peng Zhou <peng.zhou@mediatek.com>
> 
> Unfortunately this commit message is way to short to
> understand what is going on, and has a lot of assumed
> previous knowledge.
> 
> Can you expand the commit message so that anyone
> who just know MMC and some SoC basics can understand
> what an SMC call and and what ATF(EL3) means?
> 
> I assume this some kind of inline encryption?
> 
> I think maybe linux-block mailing list need to be involved
> because there is certain a Linux standard way of setting
> up inline encryption for the block layer.
> 
> For example: how is the key to be used derived?
> How is the device unlocked in the first place?
> 
> If I insert a LUKS encrypted harddrive in a Linux machine
> the whole system is pretty much aware of how this should
> be handled and everything "just works", I enter a pass
> phrase and off it goes. I can use symmetric keys as well.
> How is this stuff done for this hardware?
> 
> > +       /*
> > +        * 1: MSDC_AES_CTL_INIT
> > +        * 4: cap_id, no-meaning now
> > +        * 1: cfg_id, we choose the second cfg group
> > +        */
> > +       if (mmc->caps2 & MMC_CAP2_CRYPTO)
> > +               arm_smccc_smc(MTK_SIP_MMC_CONTROL,
> > +                             1, 4, 1, 0, 0, 0, 0, &smccc_res);
> 
> The same as above: these comments assume that everyone
> already knows what is going on.
> 
> AES encryption requires a key and I don't see the driver
> setting up any key. How is the code in this file:
> drivers/mmc/core/crypto.c
> interacting with your driver?
> drivers/mmc/host/cqhci-crypto.c
> is used by SDHCI and is quite readable and I see what is going on.
> For example it contains functions like:
> cqhci_crypto_program_key()
> cqhci_crypto_keyslot_program()
> cqhci_crypto_clear_keyslot()
> cqhci_crypto_keyslot_evict()
> cqhci_find_blk_crypto_mode()
> 
> MMC_CAP2_CRYPTO is used as a sign that the driver
> can do inline encryption, then devm_blk_ksm_init() is called
> to initialize a block encryption abstraction with the block layer.
> Ops are registered using
> struct blk_ksm_ll_ops cqhci_ksm_ops.
> 
> This is very straight forward.
> 
> But where does all the above happen for this driver?
> 

It happens in the same place, cqhci-crypto.c.  Mediatek's eMMC inline encryption
hardware follows the eMMC standard fairly closely, so Peng's patch series just
sets MMC_CAP2_CRYPTO to make it use the standard cqhci crypto code, and does a
couple extra things to actually enable the hardware's crypto support on Mediatek
platforms since it isn't enabled by default.  (*Why* it requires an SMC call to
enable instead of just working as expected, I don't know though.)

The way all this gets used is via the blk-crypto framework
(Documentation/block/inline-encryption.rst), which is used by fscrypt
(ext4 and f2fs encryption).

Peng, if you could explain all this properly in the cover letter, commit
messages, and code comments (where it makes sense), that would be really helpful
for people.  Also please make sure your patch series is in a thread so that
people see it together.

- Eric
