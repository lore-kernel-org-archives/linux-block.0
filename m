Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64F16C433B4
	for <linux-block@archiver.kernel.org>; Thu,  6 May 2021 13:04:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31705613C2
	for <linux-block@archiver.kernel.org>; Thu,  6 May 2021 13:04:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233163AbhEFNFZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 May 2021 09:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231265AbhEFNFY (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 May 2021 09:05:24 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7321FC061574
        for <linux-block@vger.kernel.org>; Thu,  6 May 2021 06:04:26 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id v6so6942925ljj.5
        for <linux-block@vger.kernel.org>; Thu, 06 May 2021 06:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hLhu4a2qeeKN1ThghHVgWBhHswj+unmP67cSTUVDirw=;
        b=JXcpFGSsXkuwB65R3OnXVCm0UFidSXxrn6blltm71bquZl9btHIMhI9GAQYYzSaLeI
         xgea5q7+rY4XwJmcP9mtlaCMnDA83ceyMo6JrHum1coXn3p37qE9U56lv5OIqSsaxbi9
         DU/ImjVgNR4X2YxaJiMt51dcjYeUDG4lVvJpsdksMADuvyLmNPbpWleWToY0IdzwE6tF
         MtfY64u//1KbZ12PZwct/ury/h9OOWaVaJh5L/AZhg+xeYJBhxqg/0QoovcSTRxEQtcn
         ZlK49trxBeYvOAUG2zFOe1Wx9qLNB8my0Haj49rwJqN/h3Vu7yrELBe6J5tmjUeRg8tg
         6rAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hLhu4a2qeeKN1ThghHVgWBhHswj+unmP67cSTUVDirw=;
        b=j1v3OxpDBkYO44hxSb1jMaByyiMIwJtq0rXzK2ENbjOcVYzbz4O2FgUzbLYGvryLK4
         S1YtppRZ24JVWdwJmAJGfRfZyYZkMhxQj4YVKjJl52VxPffU3qSLc0B3D5vCJymcc+5w
         sKFDVXFiQxRs7CUxAfsZu7p4eQ3aK26CP7habbUUvXH42NY5emw2ZK2Y+C00Lkjo/XwV
         yvVp8+bGtu3dwyoKXtrlzPe2d3VnAdi1k55iScXT0tzfXUd9CFqqIhMJX7EAk4Etb2r4
         3qkJrKxG9FjGni5nuDcZLOFGIQgbQcvatDtTfyzLVQ5BrvLaDWogyi2RDGjIHO2+ly92
         V2MQ==
X-Gm-Message-State: AOAM530rs4qf3z8Cf5w6r4K00bYm84VTEf13AayVtnK3eqmQ7E+cp9VV
        woaMQWMp34ebWsrVwNcXPGWcc7LnPnajB7H2/+PU1A==
X-Google-Smtp-Source: ABdhPJwyHJtAXrS4OXMtzTzkXb2QMw08W7FLMIWBQGmGPNPCLKn10DtCdbNkaX4ss2LpI4zkSHvC3xbWLsqrLSX844Y=
X-Received: by 2002:a2e:a369:: with SMTP id i9mr3212788ljn.273.1620306263997;
 Thu, 06 May 2021 06:04:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210504161222.101536-1-ulf.hansson@linaro.org> <20210504161222.101536-10-ulf.hansson@linaro.org>
In-Reply-To: <20210504161222.101536-10-ulf.hansson@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 6 May 2021 15:04:12 +0200
Message-ID: <CACRpkdb_qqJJ2aXb+bCxzm1yoeAy0qeUitCVByFNKinAa4zGhw@mail.gmail.com>
Subject: Re: [PATCH 09/11] mmc: core: Read the SD function extension registers
 for power management
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

> In SD spec v4.x the SD function extension registers were introduced. A
> specific function register were added to let the card announce support for
> optional features in regards to power management. The features that were
> added are "Power Off Notification", "Power Down Mode" and "Power
> Sustenance".
>
> As a first step, let's read and parse this register for power management
> during the SD card initialization and store the information about the
> supported features in the struct mmc_card. In this way, we prepare for
> subsequent changes to implement the complete support for the new features.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Looks to me like it will work just fine.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
