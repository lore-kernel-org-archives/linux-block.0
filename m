Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C39DEC61DA4
	for <linux-block@archiver.kernel.org>; Thu,  2 Feb 2023 15:23:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232611AbjBBPXC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Feb 2023 10:23:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232736AbjBBPWz (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Feb 2023 10:22:55 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 825AD1ABC1
        for <linux-block@vger.kernel.org>; Thu,  2 Feb 2023 07:22:52 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id jh15so2131866plb.8
        for <linux-block@vger.kernel.org>; Thu, 02 Feb 2023 07:22:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RDprxbolKOWdwwbIHMkRMigRdw+EGw2x6+hQir7JvSA=;
        b=doQlECiin+IZHhqzYYBAGmG7ruHwjSzhZrT63tI0qaxrLqoCRt1F6MC0t09QD/nDRT
         qSuJ5JdN672y3v5s81n3vaM1ZsRwnMcZ77rgWkAEuzW/FFQ//L6IRTdP8L1DkTKQYw64
         o/NgLjAIM5f21e1RK6cv79FOSjj0PDlhytOWysU/jnj5OkZFhWEwAEeGRDvHWDpw3Fhc
         2FOlPRmv8n7Asfb0qMnTDsgUmCmzjU4gQMdCas6sPEjWyfJvzEmlZ6pn/WENmrL8Snmz
         OCR4N94EGcLG/ieyVTtMfy2YLdWlh/2sDOk0PkviZWyQjk2Bmigt+1bFBjANliUXJC5n
         0fRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RDprxbolKOWdwwbIHMkRMigRdw+EGw2x6+hQir7JvSA=;
        b=QHn7uI/nRamfhfZSkj7PAUf5WCgXDSay7eXHN4u+ZSjybOKox3ZDY2sB9gnNpkhYFm
         C2qEUEumRb1CNwHGVSpwUz9lcJ0MZJSD+9wHmUsMIFvFIARVNQglhqlnhofGf1obSWVE
         6UllcDmJb4r4Vjh3fZTZPtR+QDDnG3IBCkAGxbM6Xwu4EgiAanA6/7PsmZcAi+z4ohXL
         cJXBDs2t5MM29pl4irZqKqusP7NEmWVGkTiyzZcIm0sIhloWDMQK6lVC5kCGTlcA1HuL
         nDGKkEqb0+bKLHqMvWQHtj/4kk+VUXSLH9LUTSxgEm8hjlUtm2TtClukFsdnzytTBbT9
         dTrA==
X-Gm-Message-State: AO0yUKWPgJL58hztmOotLX4NgUSudQIAO3AdQDn2zoAwcLdQVbPd6IOM
        WnMvYZ1Fdb/YBWzZm/6eZ7MYJufWVYbDCtLXcQC5XA==
X-Google-Smtp-Source: AK7set98New9iXm3ve35FJg7oNZjOErzLseWUSRPRNXVwcE7LzG/FJWndHiXjjUOs11lfhzwYHgb+c0FtlQ/B3QsQgc=
X-Received: by 2002:a17:903:11c7:b0:196:1462:3279 with SMTP id
 q7-20020a17090311c700b0019614623279mr1676619plh.17.1675351372019; Thu, 02 Feb
 2023 07:22:52 -0800 (PST)
MIME-Version: 1.0
References: <20230131084742.1038135-1-linus.walleij@linaro.org>
In-Reply-To: <20230131084742.1038135-1-linus.walleij@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 2 Feb 2023 16:22:15 +0100
Message-ID: <CAPDyKFrLetcCcFueJzZeWa-SVbsJcspwZ+nXWUDCGRXawxNhdg@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: Imply IOSCHED_BFQ
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-block@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 31 Jan 2023 at 09:47, Linus Walleij <linus.walleij@linaro.org> wrote:
>
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

I have taken the various arguments (for and against), but I think
$subject patch makes sense to me. In the end, this is about moving
towards a more sensible default kernel configuration and the "imply"
approach works fine for me.

More importantly, $subject patch doesn't really hurt anything, as it's
still perfectly fine to build MMC without I/O schedulers and BFQ, for
those configurations that need this.

That said, applied for next, thanks!

Kind regards
Uffe


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
>         tristate "MMC block device driver"
>         depends on BLOCK
> +       imply IOSCHED_BFQ
>         default y
>         help
>           Say Y here to enable the MMC block device driver support.
> --
> 2.34.1
>
