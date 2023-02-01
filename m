Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A1F7C636D3
	for <linux-block@archiver.kernel.org>; Wed,  1 Feb 2023 13:20:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbjBANUD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 Feb 2023 08:20:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjBANUA (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 Feb 2023 08:20:00 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAB034ED1;
        Wed,  1 Feb 2023 05:19:59 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id B645D5C0037;
        Wed,  1 Feb 2023 08:19:56 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Wed, 01 Feb 2023 08:19:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1675257596; x=1675343996; bh=YCqsp8Mqsp
        74IICT/TqGM2TSd3uwt3jYS5thBWjzm6M=; b=p7QhsgDCDIJRYv4WuD7S0BMa4S
        xs95xqEKcKF05Ucr0l1TsYlh3Hd5Fvrmkyds8RITuh+yt8oEDa4ITeSuHQPPI3Q3
        RLJo2KFHalBIDCLHGU7XTDM5kxca3xBAD2z6LvhtVuSAqu/4oaZj1Tfuf10G62ph
        z3HgwXctSMq/i0UoWVapJD3qIYcKuR2Y/d+RdpFCpFV6zAOpTduMhx8UbPOSsMpY
        Ayc/F2hQMbyQVVQigYdLZn3LqxBAWHQbHo274ylMHHCd92tWZMkWlhPw7RpIv456
        GwNCm8mk4Y/H2gZRMQAHDmV2PB8lQxuGJRy4XO+7PXfqJAjyMzHu7zFs4pJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1675257596; x=1675343996; bh=YCqsp8Mqsp74IICT/TqGM2TSd3uw
        t3jYS5thBWjzm6M=; b=KPoFHr1Cdv3p6bvLurdPMvjO7w34VlnOZtzcCqq65axB
        oe2lmr9cuwbRoFII7sMc35JIMYsGGJuE00LuhPf4rWghOSBdSreLoWqDDoQgrWo7
        WCeH8aiEzXEknVqzqP2l5FFhw9z/Rx2fJ/QPSwqPFPTmH0PfN6dK+l5SZ+CBDFHJ
        uDGwx5EPFFauxvZb9waM65Oa6F8mIstRFIp+TOCjgtGGX/wtWRPCiPovKciSAn8w
        /IlfQoerE6NkkU8djuf245iuoKkwH6vGELdk4HN6ZeohCYY6MpHWL+nUO3Qx5JgY
        BlA3ZZkzZLJHeRQceCtFUWygdckdd5flpXUfQDqeZg==
X-ME-Sender: <xms:_GbaY9i07ZzCil2YcNsGgAH5HK4W2_URAbTcde4dWrQ2bw2l5Ov66g>
    <xme:_GbaYyAsxrCGJdvRSzWSmPPNwe2a6O3GQC89DD-WBu5wVoaQxBb_h1XYplmY12ctn
    koTPZon7DxZ1LSi7Ho>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudefiedgheduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:_GbaY9Hh5bTFO3T1YpJHlcnB8tbKzuB15D5ob8K1EhJ0sODkLU-ZCw>
    <xmx:_GbaYyRYUj6kaO6-r3Y3A8X_JGWf2qL3Frt2Ch6pmDRfNMfFRBzW0Q>
    <xmx:_GbaY6yjszmYc9Ps06yRJz1AUnmseti0bFQTwY0m1a4vqzV_jyTzSQ>
    <xmx:_GbaY1_6djvri0xXVnGmFOLmntNUHOLC40PJZD7bnNoDOyx6N3aQjg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 7776EB6044F; Wed,  1 Feb 2023 08:19:56 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-107-g82c3c54364-fm-20230131.002-g82c3c543
Mime-Version: 1.0
Message-Id: <9f1992e7-6bd6-466c-9d57-0cbd24490e58@app.fastmail.com>
In-Reply-To: <20230131084742.1038135-1-linus.walleij@linaro.org>
References: <20230131084742.1038135-1-linus.walleij@linaro.org>
Date:   Wed, 01 Feb 2023 14:19:37 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Linus Walleij" <linus.walleij@linaro.org>,
        "linux-mmc @ vger . kernel . org" <linux-mmc@vger.kernel.org>,
        "Ulf Hansson" <ulf.hansson@linaro.org>
Cc:     linux-block@vger.kernel.org,
        "Paolo Valente" <paolo.valente@linaro.org>
Subject: Re: [PATCH] mmc: core: Imply IOSCHED_BFQ
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jan 31, 2023, at 09:47, Linus Walleij wrote:
> If we enable the MMC/SD block layer, use Kconfig to imply the BFQ
> I/O scheduler.
>
> As all MMC/SD devices are single-queue, this is the scheduler that
> users want so let's be helpful and make sure it gets
> default-selected into a manual kernel configuration. It will still
> need to be enabled at runtime (usually with udev scripts).
>
> Cc: linux-block@vger.kernel.org
> Cc: Paolo Valente <paolo.valente@linaro.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/mmc/core/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/core/Kconfig b/drivers/mmc/core/Kconfig
> index 6f25c34e4fec..52fe9d7c21cc 100644
> --- a/drivers/mmc/core/Kconfig
> +++ b/drivers/mmc/core/Kconfig
> @@ -37,6 +37,7 @@ config PWRSEQ_SIMPLE
>  config MMC_BLOCK
>  	tristate "MMC block device driver"
>  	depends on BLOCK
> +	imply IOSCHED_BFQ

As with most other uses of 'imply', this one does not do what you
think it does. Enabling MMC_BLOCK in 'make menuconfig' or similar
won't actually turn on IOSCHED_BFQ implicitly. The only difference
this makes is that it gets enabled in a 'make defconfig' run when
IOSCHED_BFQ is not already configured.

Just put it into the defconfig files instead.

     Arnd
