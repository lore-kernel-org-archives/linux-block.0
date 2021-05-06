Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B41EEC433B4
	for <linux-block@archiver.kernel.org>; Thu,  6 May 2021 12:50:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A2C4613C2
	for <linux-block@archiver.kernel.org>; Thu,  6 May 2021 12:50:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231830AbhEFMvc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 May 2021 08:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231461AbhEFMvc (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 May 2021 08:51:32 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D3FAC06138A
        for <linux-block@vger.kernel.org>; Thu,  6 May 2021 05:50:30 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id z13so7646631lft.1
        for <linux-block@vger.kernel.org>; Thu, 06 May 2021 05:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8Ih4+p3zLbJgKbtyGHTBqIMZl1xrskHK8H9INh+Uv4Q=;
        b=tOVCF1VosorbmnojI82fLeeHSIKUGSQH/nyYU/9ksMYfnCNNk2WPdG6ay/mpoSJmoM
         LshYTzx//dMlid0bY/5z0+7Z7hG/1nZGsU1JgTerosNm2lPILJiPmxtQyBHTAK5K+1AU
         A74pBMjCDOnEpS6zXJLq5N9YkF6B4uk790O6cby6esqWbZS2qIihy0rgkg/oL8j5lk9E
         SERTcIDzkqSXuDPFC1z5cLQLpQYjgreb5Q4En7GoRGdQ4UnUpdKrZ8nmYj5yD6QA+fRQ
         lfATfeTiCPEZnx7QJrwGjflZxs9eOb4FVSEGGuxPImV0SOsOayxsGZAL81ftjfobmfUy
         LRQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8Ih4+p3zLbJgKbtyGHTBqIMZl1xrskHK8H9INh+Uv4Q=;
        b=QyjG74edlX8KW8SkxKdhXTYzrcE2RysA2S51xnRoreFzHDX8vidnh+KMqhcEnHE7w4
         KIJw6mWB+IMG/Nfl2ETHIpsT++FwBH/wlA0KwqPR8syCdvzubcVCHxFOJPvYyGPMQ77P
         utXAArwR/mNOQQuMBeLEKdl9GK/eZuMf25WkJtgN0TauLTiMdRUlb3zkoZm5F2s8MDJQ
         zQf8PwTAp4eK/B9gie7SKtWXht36EN72yO2Q1FjnKN8IzOySh70fyv9uujqXNqq2jHC2
         PtbDy4zSlH6AKKUTkPQs8PUsFWPrZ87vaT/ZajkZFGtvfW/26h76v6JhET5HM9UBcBJQ
         jiBw==
X-Gm-Message-State: AOAM531NCWdyhZuFrMy29uz/Pr9mebDAqj4yBcXgHNHY9TEcrLTdQWyP
        QaD4gbKiF7/U8zdFJu/7vzxtU2EvVSt403MnlqjHFw==
X-Google-Smtp-Source: ABdhPJzE0Z+zj23Q02inSzPqU6dizoYqkz7PVA6JO3I+kCwKxDGAnYJLv5iu6gj3sJSx5oylXPN9Gz/3NPn+3xWHDF8=
X-Received: by 2002:a19:a418:: with SMTP id q24mr2665011lfc.649.1620305428769;
 Thu, 06 May 2021 05:50:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210504161222.101536-1-ulf.hansson@linaro.org> <20210504161222.101536-2-ulf.hansson@linaro.org>
In-Reply-To: <20210504161222.101536-2-ulf.hansson@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 6 May 2021 14:50:17 +0200
Message-ID: <CACRpkdYbsfVDrTpMa6P8uia0McQD2KhSKQVA-jh84ZPwBS3C6Q@mail.gmail.com>
Subject: Re: [PATCH 01/11] mmc: core: Drop open coding when preparing commands
 with busy signaling
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

> Similar code for validating the host->max_busy_timeout towards the current
> command's busy timeout, exists in mmc_do_erase(), mmc_sleep() and
> __mmc_switch(). Let's move the common code into a helper function.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

This is a really nice refactoring in its own right.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
