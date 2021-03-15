Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89496C433DB
	for <linux-block@archiver.kernel.org>; Mon, 15 Mar 2021 23:02:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6294064F51
	for <linux-block@archiver.kernel.org>; Mon, 15 Mar 2021 23:02:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232540AbhCOXC0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 15 Mar 2021 19:02:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:46310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232528AbhCOXCZ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 15 Mar 2021 19:02:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3246D64E07;
        Mon, 15 Mar 2021 23:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615849344;
        bh=MvgmTF9JP1Pl0WIL7tXvPjN/6QezXqYVNnpCd3cjBLk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LuFHU+DtNHYVNvoF998/ITpQCiVyqtetr3Zm8/GkiQuV9RHDMyekwDh/mR1gLMOdJ
         B/S6KrjQ8KOoSZokAIAJf1QaZY+L0btPXlb4ddDA5+kgL4Z/D7H3HBMPQzwHYJ7A2R
         0ZLWY3ENYrulrsOnudlc883i7sAwIxpJ11S6b5EehAF2VGx7XZ3hWiQLv0GRCzUf6w
         ZieSHwcqEgYkGfN0e/IhffK3AaJTCGFO/HWG0BuHuBZZEYU7KAsQRcl99Ru20DYVlM
         I5DOn6oseslpOiVqGNjNR9m0wtgh9OFBmh/G5w+DdUMDDa8IDVdkaTCmR8tS8dF2Gg
         HGWjP0E3KestQ==
Date:   Mon, 15 Mar 2021 16:02:22 -0700
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
Message-ID: <YE/nfu8vRETYN9dO@gmail.com>
References: <20210309015750.6283-1-peng.zhou@mediatek.com>
 <CACRpkdYTkW7b9SFEY6Ubq4NicgR_5ewQMjE2zHvGbgxYadhHQQ@mail.gmail.com>
 <YEpqkAq6wOZ+TpR9@gmail.com>
 <CACRpkdb7vmFgH0XTG3Z6OzFv0CfPsBguKqVAZt=PZ+ms2-0WjA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdb7vmFgH0XTG3Z6OzFv0CfPsBguKqVAZt=PZ+ms2-0WjA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Mar 15, 2021 at 02:41:58PM +0100, Linus Walleij wrote:
> Hi Eric,
> 
> thanks for stepping in and clarifying! I get it better now, I though
> this was some other encryption scheme "on the side".
> 
> There is one worrying thing in the patch still:
> 
> On Thu, Mar 11, 2021 at 8:08 PM Eric Biggers <ebiggers@kernel.org> wrote:
> > On Thu, Mar 11, 2021 at 02:48:23PM +0100, Linus Walleij wrote:
> > > On Tue, Mar 9, 2021 at 3:06 AM Peng Zhou <peng.zhou@mediatek.com> wrote:
> 
> > > > +       /*
> > > > +        * 1: MSDC_AES_CTL_INIT
> > > > +        * 4: cap_id, no-meaning now
> > > > +        * 1: cfg_id, we choose the second cfg group
> > > > +        */
> > > > +       if (mmc->caps2 & MMC_CAP2_CRYPTO)
> > > > +               arm_smccc_smc(MTK_SIP_MMC_CONTROL,
> > > > +                             1, 4, 1, 0, 0, 0, 0, &smccc_res);
> 
> So MSDC_AES_CTL_INIT. Assumes we are using AES and AES
> only I suppose?
> 
> > It happens in the same place, cqhci-crypto.c.  Mediatek's eMMC inline encryption
> > hardware follows the eMMC standard fairly closely, so Peng's patch series just
> > sets MMC_CAP2_CRYPTO to make it use the standard cqhci crypto code, and does a
> > couple extra things to actually enable the hardware's crypto support on Mediatek
> > platforms since it isn't enabled by default.  (*Why* it requires an SMC call to
> > enable instead of just working as expected, I don't know though.)
> 
> Now I don't know the limitations of cqhci crypto. Clearly it only supports
> AES today.
> 
> However would the cqhci crypto grow support for any other crypto
> like 2Fish or DES and the user request this, then I suppose there is
> no way for the MTK driver to announce "uh no I don't do that"?
> 
> Or will this cqhci hardware only ever support AES?

The standard specifies the encryption algorithms that may be supported, and it
specifies that host controllers have a set of crypto capability registers that
list the subset of those algorithms that the hardware actually supports.  See
cqhci_crypto_init() which reads these registers.

If new algorithms get added, the hardware won't declare support for them.
So what you describe won't be a problem.

If, nevertheless, there is broken hardware that declares support for algorithms
it doesn't support, we could work around it using a method in cqhci_host_ops.
That isn't necessary now though.

- Eric
