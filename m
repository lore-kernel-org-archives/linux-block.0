Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38732C433E1
	for <linux-block@archiver.kernel.org>; Mon, 22 Mar 2021 13:46:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F031F619A6
	for <linux-block@archiver.kernel.org>; Mon, 22 Mar 2021 13:46:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbhCVNqG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Mar 2021 09:46:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbhCVNp4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Mar 2021 09:45:56 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C36AC061756
        for <linux-block@vger.kernel.org>; Mon, 22 Mar 2021 06:45:55 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 184so21086177ljf.9
        for <linux-block@vger.kernel.org>; Mon, 22 Mar 2021 06:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MAsqu+nrUaGfuKdfO5JWOn1zVTZWLnet3/TkGIueees=;
        b=YEq3ulraf8GyTw13ab79KrtHWPmPGpFytr5S3JQPwnlGTBNgFP4IphrGJl3pfigMYX
         07ShF9QZQPZ+EuWBFqf/BnA46aC6P8SFY8vRF4pxBHwK+oMdBJxlEGT4adTFA4kagdqo
         mRZuaUJ/7q3y12Yq9saPcDbTOn62cish5pHqgYNx1DU7PD1dQw6OvAxyzKhqDdJlvUql
         Viqd96oS54A2qZfyDgs/hCc9eIDNvzrJfNn1SQEuCGWDdmy2jeZsJZLZAT+71zoYO2oH
         8/YoAjJSM3XfjvqOvU3yrTdcuvjYviPSXBHtOqGwjQ8wWuyHbbPuc27+jX9ELpC2Vb4E
         1DSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MAsqu+nrUaGfuKdfO5JWOn1zVTZWLnet3/TkGIueees=;
        b=aiZsA/gt02E4QtivJJO9OOXAykhqUmBNgBpjyTAsYmKQTppZYMWbkDDd4cbve1npqu
         E/Uvi8jMmK/RLjrf/7txUjE5p6pnYnSt7wu7ElBJx3QC/Zx2apcBT11oroBXSqHAP17y
         57h0man+BgIzfkoOFEI4kXMyVm7azvf/bYCvGMBSZ5TWI7FVB3g/vgiR+l4pijazOeuT
         EZdyZDE323Cpnoig8rqnwpKihCa2kU5A8g6PqNqp/JR4CEwJ53r427FzOA5qlTIK7klt
         6xDfXxDxqWxDzPU6JBVKcjFwoUi5rXFWpTBCyB+/RcuGcRAVDesgkLXvyxJwp5CO/nuo
         TQRw==
X-Gm-Message-State: AOAM530q9frp+x7Ht6R0z04RN6q0M9+qaYSY2pa95a5cm3jm96CXOXpR
        SVdZ3Or1v8BdSWUNz0HEDe1PVz3NH3iBoxBNBl055A==
X-Google-Smtp-Source: ABdhPJyezaVrNAfZsA0jCpOMJbhcpIkdGG6bxanetzRDs2x1TbHiBHrJuJI+v6mGNmCwWZbdqs2mPiUp/qAEeG5uMcI=
X-Received: by 2002:a05:651c:103a:: with SMTP id w26mr9692444ljm.273.1616420753913;
 Mon, 22 Mar 2021 06:45:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210309015750.6283-1-peng.zhou@mediatek.com> <CACRpkdYTkW7b9SFEY6Ubq4NicgR_5ewQMjE2zHvGbgxYadhHQQ@mail.gmail.com>
 <YEpqkAq6wOZ+TpR9@gmail.com> <CAPDyKFoWg7HYHAbxYJRbOad5kqm+rzVLVQ0O3g76ROO5Z+MF3Q@mail.gmail.com>
 <1615884533.21508.118.camel@mbjsdccf07> <CAPDyKFqtjYVAAe_wUKQC3n3ok5bUpGtpu=TUiOgFmbb6+Qkg=A@mail.gmail.com>
 <1615893329.21508.128.camel@mbjsdccf07> <CAPDyKFqaFbviwxQ8U_X8U64F7OwNaxXde6XdUcGPeGg8k9MWWg@mail.gmail.com>
In-Reply-To: <CAPDyKFqaFbviwxQ8U_X8U64F7OwNaxXde6XdUcGPeGg8k9MWWg@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 22 Mar 2021 14:45:42 +0100
Message-ID: <CACRpkdapAOq7NtZDOgnugvTmO0+Yh+EoCVod-s_akPfs2=Sj9Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] mmc: Mediatek: enable crypto hardware engine
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Peng.Zhou" <peng.zhou@mediatek.com>,
        Eric Biggers <ebiggers@kernel.org>,
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

On Tue, Mar 16, 2021 at 2:56 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:

> It looks like we have a couple of options to support this. I suggest
> we consider the two below, but perhaps others (Arnd/Linus?) have
> better ideas?

Admittedly it's a bit hard to shoehorn this in as it is not a standard
resource (clk, regulator, genpd, reset, gpio...)

There is drivers/soc and then you end up with the same custom
abstraction that qcom is using. The upside to using that
is that we can #ifdef it to static stubs in the .h file if this SoC
is not used, so I would go for that.

See for example qcom_scm_ice_invalidate_key() used from
drivers/firmware/qcom_scm.c, header is at
include/linux/qcom_scm.h and here you find:
#if IS_ENABLED(CONFIG_QCOM_SCM)
and if not, there are some stubs.

Yours,
Linus Walleij
