Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E36EDC433ED
	for <linux-block@archiver.kernel.org>; Mon, 10 May 2021 09:44:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6A5B613CA
	for <linux-block@archiver.kernel.org>; Mon, 10 May 2021 09:44:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230449AbhEJJpx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 May 2021 05:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230426AbhEJJpw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 May 2021 05:45:52 -0400
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84AFAC061760
        for <linux-block@vger.kernel.org>; Mon, 10 May 2021 02:44:47 -0700 (PDT)
Received: by mail-ua1-x932.google.com with SMTP id h1so5031856uar.0
        for <linux-block@vger.kernel.org>; Mon, 10 May 2021 02:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1rEPEMkDJ95/FEpu1ZRMcuPYaf30wKnn+hqKQvejaMQ=;
        b=OoG66rN3+QleL/aze1/iCDcqvMqGnPJBDZp7xQOkIbZcg4L5UdE7mUhVcgOTDlBD+S
         uVmzQDx7r2pdJ9peqNu11kWstwPMQNm2fQ8Oreibu/hiPGzuaODR4KD4rQJwLNRK7hpJ
         PZ0Ze+BqRPMDdovYluCZW3hBnT41Vb3PImOGW2gyyS8Za6+VqDxeJoa9mZqdR24Phvru
         PpZm4KGq1dP4LZkBKK+PkGd4Erjs3kVbz+6MYCUC592sIL27yVnBBVNKKfJyv7WIfzLB
         2hOwrXXOOsuC0E5wqu/K5cGw7t/MkXqgl/2qMc/EfdoD+Wm7mnUZb4AQpErzlLXftWCR
         3FrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1rEPEMkDJ95/FEpu1ZRMcuPYaf30wKnn+hqKQvejaMQ=;
        b=XiPzgOfET/QnAsXM7n5m5i2WzHVSaqPK4Q9pGd9h+961MfIgwbkaybynvTADV1/lX2
         6ae/A4TzvhEutceEE1ydWpGX5d9+IM2P3IcM46QuoQ5+hP1N5GaAl3chJJPBxIv3mSS5
         E1FDNLa9oCV5xpJWIWPaLUrxd+OrLDWjq+ZoOB+s0g+ZsOgEBSyyRzmvdt1kemk2EHEL
         A1entw27dfHpi/nNhd1XbVJcCf7kZWl8pqz94bGteCC6XBxiaviYXRxLX/MP7jLygivA
         gk5NWvlWmbp/yxaCdQ5CWaHuDmpUAzY7oy1GQQjd1h1zKWaQHDFVOTbBx5mj753LPddX
         zqUA==
X-Gm-Message-State: AOAM5335ng9YgI8gioA0mhnhD9+yqvi0dkzak1cmPI4nGIWt/TquX6iO
        Q6wjnThUK7FHAlXxGB83mQf7HZ2yii2+hwBHVy5seg==
X-Google-Smtp-Source: ABdhPJwOKJnss0sPhuipimi5yGGczAkCy/WjIhtbRAGDnzNs/Aj5YwuVeGIT25TK+KLrXoXDm139iodfuhY5syawILA=
X-Received: by 2002:a9f:35b3:: with SMTP id t48mr499011uad.129.1620639886549;
 Mon, 10 May 2021 02:44:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210506145829.198823-1-ulf.hansson@linaro.org> <DM6PR04MB657511CDCE94264D080F006CFC549@DM6PR04MB6575.namprd04.prod.outlook.com>
In-Reply-To: <DM6PR04MB657511CDCE94264D080F006CFC549@DM6PR04MB6575.namprd04.prod.outlook.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 10 May 2021 11:44:10 +0200
Message-ID: <CAPDyKFqQe5aYqF6iNppY66EfkVNPce_sRF6NJgSn26Rs=_=jxw@mail.gmail.com>
Subject: Re: [PATCH 0/2] mmc: core: Implement support for cache ctrl for SD cards
To:     Avri Altman <Avri.Altman@wdc.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 10 May 2021 at 09:40, Avri Altman <Avri.Altman@wdc.com> wrote:
>
> > In the SD spec v6.x the SD function extension registers for performance
> > enhancements were introduced. As a part of this an optional internal cache
> > on
> > the SD card can be used to improve performance.
> Just to verify that you are aware of that:
> In addition to the extension Registers that were defined in the physical core spec,
> there was a separate document that was released that suggest a common OS API's to those registers.
> It is called "SD specification part A5, SD Extensions API specification".

Thanks for the pointer!

I did have a very brief look at this. The conclusion I made is that
this is way over designed to enable support for features like cache
and poweroff notification. However, there may be other use cases that
could benefit from a user space library, along the lines of the SD
Extensions API, but I can't really tell.

Do you have an interest around this that you can share?

Thanks for reviewing!

Kind regards
Uffe
