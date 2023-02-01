Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14E08C05027
	for <linux-block@archiver.kernel.org>; Wed,  1 Feb 2023 14:45:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232723AbjBAOpI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 Feb 2023 09:45:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232828AbjBAOoy (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 Feb 2023 09:44:54 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 175B06A71E
        for <linux-block@vger.kernel.org>; Wed,  1 Feb 2023 06:44:24 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id g2so1525829ybk.8
        for <linux-block@vger.kernel.org>; Wed, 01 Feb 2023 06:44:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BEoa4CHtt6WCmulMgq8sprSSchcj6u+PztkCRbnj6ws=;
        b=bVzel9PwmR/hg/ow37jhcdX0V2RqeP+vL/+FyFgZcG1ijfeYEv1re771UfuUt7/Rsj
         XX9gTu1cUUo/SofEI9eBB4JUwI8qz5G5wRF0+kpQ/EA0DuReuwBxh25xsYAbTSd/kLgd
         KKqg4H3tgHUeCkv0swakhju9ssZM5gjikIu5oZqTJt0Sk9C+X+oI3qu6nElf+pRyxFRH
         J3Z97NVaReHllDVZNAAmb5hFM52TB4wzqUQnvDUKq1+jZbie3end4ZbT9E9DqHJzff4g
         ccrCz9XATVw9zHcsO+mympNbF/o2RK5gTtHv4icT42vbbmgy2NABCbur+ZznwSUwMj0F
         +jWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BEoa4CHtt6WCmulMgq8sprSSchcj6u+PztkCRbnj6ws=;
        b=IC7Qwhe9lcei42+ORxjok7neyMIXjvwrUJv9fCKM7kWmgvmAiXjl4DpzYv4q7Fcw0F
         vIFbF620r6mb0J2ro5KrY3L7wPLVzudANjCDfXeXWEP2y059RpINaJW1skBZeTfrri67
         H1QskhkTXDO670IXHibq8wAeRUI49HKYoChak91WJfLeRkd7+qLTXQFqcM9aIlglHZ5o
         VGyJ3lszfnFVGpfR0gUC/d2VL78eDjFtRs6BXwY+vlEkd1OoyoTTwK9jMs3F9TuOwmDP
         C4S+s5ki31VFIjZCbdm2G9hmqJz3riRi7lHCAiLjtVE1Qip1xFioCSf9L/ZGWdzDw6fG
         loMg==
X-Gm-Message-State: AO0yUKUDn18GaDa3RukI8VIqupZmsxFAZK+I2SNlQT4Kex9KvEr2VCQw
        loGGnOA5EIOZPRzXgjmZNijnX0JQcdAeh1+ME+WZYQ==
X-Google-Smtp-Source: AK7set+RNj73EiVXE5d4GLBO70RFMu2aPL4ummPPYkPOQhj5lnyRm3TLp0IBxvNeElCQPzE7dUIRbtZXRfgysquPVIo=
X-Received: by 2002:a25:910:0:b0:83e:bd63:6dd7 with SMTP id
 16-20020a250910000000b0083ebd636dd7mr312538ybj.24.1675262662887; Wed, 01 Feb
 2023 06:44:22 -0800 (PST)
MIME-Version: 1.0
References: <20230131084742.1038135-1-linus.walleij@linaro.org> <9f1992e7-6bd6-466c-9d57-0cbd24490e58@app.fastmail.com>
In-Reply-To: <9f1992e7-6bd6-466c-9d57-0cbd24490e58@app.fastmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 1 Feb 2023 15:44:11 +0100
Message-ID: <CACRpkdae1ZL2ktMgi+Pm5qzk6y1fO-np=+mz0-_62YT0hGKSgg@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: Imply IOSCHED_BFQ
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "linux-mmc @ vger . kernel . org" <linux-mmc@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-block@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Feb 1, 2023 at 2:19 PM Arnd Bergmann <arnd@arndb.de> wrote:

> > diff --git a/drivers/mmc/core/Kconfig b/drivers/mmc/core/Kconfig
> > index 6f25c34e4fec..52fe9d7c21cc 100644
> > --- a/drivers/mmc/core/Kconfig
> > +++ b/drivers/mmc/core/Kconfig
> > @@ -37,6 +37,7 @@ config PWRSEQ_SIMPLE
> >  config MMC_BLOCK
> >       tristate "MMC block device driver"
> >       depends on BLOCK
> > +     imply IOSCHED_BFQ
>
> As with most other uses of 'imply', this one does not do what you
> think it does. Enabling MMC_BLOCK in 'make menuconfig' or similar
> won't actually turn on IOSCHED_BFQ implicitly. The only difference
> this makes is that it gets enabled in a 'make defconfig' run when
> IOSCHED_BFQ is not already configured.

Incidentally that is all I do in my life, so it works as expected for me...
but OK.

> Just put it into the defconfig files instead.

Given that ARMv7 and ARM64/aarch64 often has MMC/SD-cards
I suppose I will start sending patches for these.

I see that m68k, MIPS Loongson, sh, um and s390 (!!) has already
enabled it in their defconfigs.

Yours,
Linus Walleij
