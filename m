Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC134C43460
	for <linux-block@archiver.kernel.org>; Tue, 11 May 2021 10:57:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 836296128C
	for <linux-block@archiver.kernel.org>; Tue, 11 May 2021 10:57:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231486AbhEKK6d (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 May 2021 06:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231393AbhEKK63 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 May 2021 06:58:29 -0400
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com [IPv6:2607:f8b0:4864:20::a34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFCB4C06138D
        for <linux-block@vger.kernel.org>; Tue, 11 May 2021 03:57:18 -0700 (PDT)
Received: by mail-vk1-xa34.google.com with SMTP id u205so3948361vke.10
        for <linux-block@vger.kernel.org>; Tue, 11 May 2021 03:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s01uOIcuSIPW14/XjmL0MpDTagmvSwwBs/Gv3lf9fjA=;
        b=rlYrysJdl1Mda+GvFMoWJ+uhaHtunkkcNcwp3qyEx1f8RvU7lBZGUYL/OBd6YKoMF9
         +brKcWimXGAv5F0Cxktj75n2FQQbgnuxJ23z7vGlfDj2dZf+7uJ1dpux6Y7WDgo7RJOV
         XWi+Kc7B+Q91D7tsLNInzeMRlo3Xv3Z2pkqgoTQh1Jeg2yheV2/1NWhRfp/YLyVtDrg7
         gApejY358tx771oxvH4gr2u/3XQQxIuTt3khlLuXPZtIehgORak0q5uS2RsBO5/AXGZu
         EeSoyYb93n/7H9VogQVrr8YQOaeLvxYtZZ4ziWRvV1Ya3CH5rdDpUTNxP0ji68gRdwgG
         7aug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s01uOIcuSIPW14/XjmL0MpDTagmvSwwBs/Gv3lf9fjA=;
        b=agH7Xffawr4qLgdrJWLq2vREZpC6G7acA4eNnwD5P9QBTfvKjoPtTuBpzOcP8cbcCD
         07mMm/+54gLEBAqZM2Uhm/JibpPvKNTsEXvb++AbpTucry7xvkw8dVM1TVtxzyZEek4p
         aY5BDqkLKn+CSmbC7adj9tsYj4MleHYUS8bJJzB0dKnLfAgOsakNJkvhZXAn/9IUrsN7
         fpXr8OzFKpQiu4fk9RN9hDkVC8f1FEMcj2jN3c3+90LYiPbqLCNNR1Ik9+KEw1CmnhzS
         +6bJ1CRHcLGpkRkBxaObwypy4fdXHbnECSgjZAbm2V2YTTCKs9fwD1EvKdqGugSHOUGX
         p/kA==
X-Gm-Message-State: AOAM531NQCEHpYnQ9qAfY00v+90XVJnlw2tfn1P7sTzIjARAh+gU5U7S
        by92ADAmnTEWi5I9Olx1kWq75LIjJdijGgWZi8WXlA==
X-Google-Smtp-Source: ABdhPJxcZ+ban6aleEJNN92j4tJgm89AUsY95SJ6/sPp/ktWdNTXalV0FrL6eyMT/qwmXBOjvVbf4PfARqT6Iyjlvbg=
X-Received: by 2002:a1f:aecf:: with SMTP id x198mr21864792vke.6.1620730637975;
 Tue, 11 May 2021 03:57:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210504161222.101536-1-ulf.hansson@linaro.org>
In-Reply-To: <20210504161222.101536-1-ulf.hansson@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 11 May 2021 12:56:41 +0200
Message-ID: <CAPDyKFqNS9MYJwF7VdGtbNuoULd-xwcR8obUwARVOVBtH7AnPQ@mail.gmail.com>
Subject: Re: [PATCH 00/11] Initital support for new power/perf features for SD cards
To:     linux-mmc <linux-mmc@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Avri Altman <avri.altman@wdc.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 4 May 2021 at 18:12, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> In the SD spec v4.x the SD function extension registers were introduced,
> together with a new set of commands (CMD48/49 and CMD58/59) to read and write
> to them.
>
> Moreover, in v4.x a new standard function for power management features were
> added, while in v6.x a new standard function for performance enhancements
> features were added.
>
> This series implement the basics to add support for these new features (and
> includes some additional preparations in patch 1->7), by adding support for
> reading and parsing these new SD registers. In the final patch we add support
> for the SD poweroff notification feature, which also add a function to write to
> these registers.
>
> Note that, there are no HW updates need for the host to support reading/parsing
> of the these new SD registers. This has been tested with a 64GB Sandisk Extreme
> PRO UHS-I A2 card.
>
> Tests and reviews are of course greatly appreciated!
>
> Kind regards
> Ulf Hansson
>
> Ulf Hansson (11):
>   mmc: core: Drop open coding when preparing commands with busy
>     signaling
>   mmc: core: Take into account MMC_CAP_NEED_RSP_BUSY for eMMC HPI
>     commands
>   mmc: core: Re-structure some code in __mmc_poll_for_busy()
>   mmc: core: Extend re-use of __mmc_poll_for_busy()
>   mmc: core: Enable eMMC sleep commands to use HW busy polling
>   mmc: core: Prepare mmc_send_cxd_data() to be re-used for additional
>     cmds
>   mmc: core: Drop open coding in mmc_sd_switch()
>   mmc: core: Parse the SD SCR register for support of CMD48/49 and
>     CMD58/59
>   mmc: core: Read the SD function extension registers for power
>     management
>   mmc: core: Read performance enhancements registers for SD cards
>   mmc: core: Add support for Power Off Notification for SD cards
>
>  drivers/mmc/core/core.c    |  22 +--
>  drivers/mmc/core/mmc.c     |  43 ++---
>  drivers/mmc/core/mmc_ops.c | 137 +++++++-------
>  drivers/mmc/core/mmc_ops.h |  10 +-
>  drivers/mmc/core/sd.c      | 371 ++++++++++++++++++++++++++++++++++++-
>  drivers/mmc/core/sd_ops.c  |  38 +---
>  include/linux/mmc/card.h   |  22 +++
>  include/linux/mmc/sd.h     |   4 +
>  8 files changed, 504 insertions(+), 143 deletions(-)

FYI, this series has been applied for next, with some minor
modifications according to review comments. Thanks!

Kind regards
Uffe
