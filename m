Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E270C433ED
	for <linux-block@archiver.kernel.org>; Thu,  6 May 2021 13:00:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 304C2613C1
	for <linux-block@archiver.kernel.org>; Thu,  6 May 2021 13:00:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232418AbhEFNBi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 May 2021 09:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231265AbhEFNBh (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 May 2021 09:01:37 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74DADC061763
        for <linux-block@vger.kernel.org>; Thu,  6 May 2021 06:00:39 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id x19so7677019lfa.2
        for <linux-block@vger.kernel.org>; Thu, 06 May 2021 06:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=co6Tu6p7gwdreS8j+kzhyH/BpJmEW7gcEZ8FRox2VLM=;
        b=imjkp9zgX91dHPVMnXtZjX6RL8An3N4T5kLaqqZ6UKOJo9faTrNHFaPZELcNYuaypq
         uQ0/erVuIlCfOsrMExtH/3x/rE9AIDaoYdRD7IrMtbmzzNF+jCZ91F3hF4DXulvJ6zP/
         MuHOWqMS5MWRUIAAm/gj0Ow6coQgPBzRVIiF0tbBbonfjtA0fkRH7Ofu2gJc4sFh4VdW
         sMUdEY07akP+Z82iHfIBKrK5uAdOQyVWleVZtjHg9DWsguCqgfIU/qgMkTmCwb6F0X6c
         dykfROgNLyZEnLXx3Ol6DzFYXh8Gi3IuCvomWSHe7l1JjMTLqe1pyPpxL6b2H45b1H1J
         TQag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=co6Tu6p7gwdreS8j+kzhyH/BpJmEW7gcEZ8FRox2VLM=;
        b=e3ciEmnsQOFfVt6FBDQUEWjrAFbqzxqJFF+p61ELgDQ4l133iWbNDFt9wZ6r2/LSl8
         tCpYgizghsgmDHQFNkwI+7BPEnkfHTN2N6LQaMQz3knp8YnzK7pCVqHSNnu0x+4Wk+Hb
         Olc0BXE6m73xmcbCLVFoCz3TxQGkxivRsM/PnUWhcx95TogxDND+EPRfIUtxLLIYiQgu
         fgk/o32pfgvbrRg8KiqyAf2cicYUunjc3hyNTf7vFU52o34M5OpqJH9omElMXIpGEj9/
         AONtO8dS691GPZ9hO859hIuCPdL3FKH7iYzipY9JT2IxxHVPUxUcBnF6SlbB30qTdWtA
         IxHw==
X-Gm-Message-State: AOAM533Pqlk212OtnkUKYkRthFx7RAcerLIDhJDm2NQ9tp6rJMFq7sst
        vG8oV/aRyaIFzKUxSyWyVGh0vXEo4+DeWaOIk+VUEQ==
X-Google-Smtp-Source: ABdhPJwechm8k/LJgQ4yWdTtDYG9Go8iYVJJpJ+sWs2TdhwxF8w4kKFdR4XnUVrgxVAIpiJ8CaDV03AcGU3DFLg9ZH0=
X-Received: by 2002:a19:a418:: with SMTP id q24mr2688212lfc.649.1620306037628;
 Thu, 06 May 2021 06:00:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210504161222.101536-1-ulf.hansson@linaro.org> <20210504161222.101536-7-ulf.hansson@linaro.org>
In-Reply-To: <20210504161222.101536-7-ulf.hansson@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 6 May 2021 15:00:26 +0200
Message-ID: <CACRpkdZUWP5hOCLpVvOSfR3YNXF6HC4GaO5ptYify2_EPa=wOQ@mail.gmail.com>
Subject: Re: [PATCH 06/11] mmc: core: Prepare mmc_send_cxd_data() to be
 re-used for additional cmds
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Avri Altman <avri.altman@wdc.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, May 4, 2021 at 6:12 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:

>   * NOTE: void *buf, caller for the buf is required to use DMA-capable
>   * buffer or on-stack buffer (with some overhead in callee).
>   */
> -static int
> -mmc_send_cxd_data(struct mmc_card *card, struct mmc_host *host,
> -               u32 opcode, void *buf, unsigned len)
> +int mmc_send_adtc_data(struct mmc_card *card, struct mmc_host *host, u32 opcode,
> +                      u32 args, void *buf, unsigned len)

Just a note here (the change is good)

When applying please add some kerneldoc above mmc_send_adtc_data()
and expand the ADTC acronym and add some info explaining what it
is maybe a small protocol ref or so, so readers of the code get an
intuitive feeling for what this function does and what ADTC is.

Yours,
Linus Walleijq
