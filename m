Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E01FCC05027
	for <linux-block@archiver.kernel.org>; Thu,  2 Feb 2023 15:23:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232533AbjBBPXI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Feb 2023 10:23:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232808AbjBBPW6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Feb 2023 10:22:58 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AD8443452
        for <linux-block@vger.kernel.org>; Thu,  2 Feb 2023 07:22:56 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id g9so1414899pfk.13
        for <linux-block@vger.kernel.org>; Thu, 02 Feb 2023 07:22:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WGfX55LDKwIhxgBD6Pv/9qAlZ3kdQLWrx019H3iLqUE=;
        b=ONA1iCVjl6ZCooezOTJ98NRlsioy+aiVMj5YJWlPqGzjMDIi5qv7wZqy24ONbuk09z
         Iw+5Jj0L+rY2oGlYQV0kyJgG7gvGo84Dk2U7A02eGT9NEPH0xBjjExQqyO2EkyCU53DP
         GBOqWdZxe7/lCbaIoyd69etDe3Yg7/DGIFEpyKkouCxc+oJlZPwOrDFHWjrue3zwt0TU
         1Cz9mHeITH4l5XvYH+7gkPswY7/DrvBwP3DJylQcizgRTv8bsnCFwSVBUj93N+ixaAbd
         oM3g/AvNvLNUClbsuqpHb2hP4Mo3UMAq/idqYCBafXXzQQQoisPwYj9bPUGj2udz6OBP
         2kEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WGfX55LDKwIhxgBD6Pv/9qAlZ3kdQLWrx019H3iLqUE=;
        b=CUZmhn1VB01aJsI9chI8JCoGxQscvBtJoTmTOUXb5SIv6hkpEvbwh0rknKt3KmMdOx
         ZakWUK9kCT8aTBuifzAbrwcVIXGXXP6XJVlPMYcBNijqhOAOOOb/4Ci4sCtz9R13vNUi
         nP4n5B3sjIm7DNHUiYIUrtBzVFI8t9JuBimMoeLDUV9qNkKKcyPe2UOD+lIU2DJEk3Aw
         meRe46p6TVxe0t3CNg/jQa0YHOiiMAKFCrw+zmIcdG44hTrWrjrXWzz7Y81mSY6/hyS6
         Tu7SMEV9o9grD8OhXy8kgbNOUO5gyAedaWlH8cKcJoV0nE745X4k91kNJOl2DdR22Pr/
         0G4A==
X-Gm-Message-State: AO0yUKVraKiD/t7P+Sx717EIvxbPIfDtkiK4zIXAKoN5VrzgvLsu5Reu
        zZY1Nq80pwdZbhDYADWoqIIUoU5qW7gByo9agvGO7A==
X-Google-Smtp-Source: AK7set9VTZrVkIkP+oXz1cIB38TwGV2QakBKlVcyQMqSQScI/aUsUDrbvgbFafGagD4V5IxkNsy0q5FuD/dlWZBacRA=
X-Received: by 2002:aa7:96ab:0:b0:592:5ac8:156f with SMTP id
 g11-20020aa796ab000000b005925ac8156fmr1599752pfk.39.1675351375537; Thu, 02
 Feb 2023 07:22:55 -0800 (PST)
MIME-Version: 1.0
References: <20230131085220.1038241-1-linus.walleij@linaro.org>
In-Reply-To: <20230131085220.1038241-1-linus.walleij@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 2 Feb 2023 16:22:19 +0100
Message-ID: <CAPDyKFqCMZLOte6Fd6oJgTMXaMYMTiRsZKSJu-YJE+nWYTpQ6g@mail.gmail.com>
Subject: Re: [PATCH] memstick: core: Imply IOSCHED_BFQ
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-block@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 31 Jan 2023 at 09:52, Linus Walleij <linus.walleij@linaro.org> wrote:
>
> If we enable the memory stick block layer, use Kconfig to imply
> the BFQ I/O scheduler.
>
> As all memstick devices are single-queue, this is the scheduler that
> users want so let's be helpful and make sure it gets
> default-selected into a manual kernel configuration. It will still
> need to be enabled at runtime (usually with udev scripts).
>
> Cc: linux-block@vger.kernel.org
> Cc: Paolo Valente <paolo.valente@linaro.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

For the similar reasons to why I applied the MMC patch, applied for
next, thanks!

Kind regards
Uffe


> ---
>  drivers/memstick/core/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/memstick/core/Kconfig b/drivers/memstick/core/Kconfig
> index 08192fd70eb4..50fa0711da9d 100644
> --- a/drivers/memstick/core/Kconfig
> +++ b/drivers/memstick/core/Kconfig
> @@ -20,6 +20,7 @@ config MEMSTICK_UNSAFE_RESUME
>  config MSPRO_BLOCK
>         tristate "MemoryStick Pro block device driver"
>         depends on BLOCK
> +       imply IOSCHED_BFQ
>         help
>           Say Y here to enable the MemoryStick Pro block device driver
>           support. This provides a block device driver, which you can use
> @@ -29,6 +30,7 @@ config MSPRO_BLOCK
>  config MS_BLOCK
>         tristate "MemoryStick Standard device driver"
>         depends on BLOCK
> +       imply IOSCHED_BFQ
>         help
>           Say Y here to enable the MemoryStick Standard device driver
>           support. This provides a block device driver, which you can use
> --
> 2.34.1
>
