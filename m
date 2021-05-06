Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCC29C433B4
	for <linux-block@archiver.kernel.org>; Thu,  6 May 2021 12:55:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92245610F7
	for <linux-block@archiver.kernel.org>; Thu,  6 May 2021 12:55:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233227AbhEFM4S (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 May 2021 08:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbhEFM4O (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 May 2021 08:56:14 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B67D7C061763
        for <linux-block@vger.kernel.org>; Thu,  6 May 2021 05:55:14 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id t11so7596655lfl.11
        for <linux-block@vger.kernel.org>; Thu, 06 May 2021 05:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wqkbdKsOdWjTK7WgnVxR1G7Gje4G1wMYFsQzSKPfbAo=;
        b=WZ7v02+KE4wO7unCZvbfDLWFG1BRsiNeeiqwWtqYzNOqQASTg2Nx2XeJHesK7+D3i8
         2JQfF4stnA2fdQBg2FnNMBkVC/kF+kk/n7Ux2nNLiHXhJI8qVoCcSAjc8GHrDgI8yghv
         xGJDjI1jaRfOPqkXEJft2jPTJukttHcTAS6A0PvGYzKYNMLvUCUpMOIEwjn5ZbM7hktj
         Hs8saBV8RonqMxpUkZMPrdRzH+Ly0qzK/W6sz5FanvYdM38165f8sGdp+TsJtCtIFRcT
         pQc3QrChiZoCSOug9HHoE0ZWPCh2msWrev/R2BMiqXMy9GjDFcKTN+aUSnWaTYQI8CtR
         oseg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wqkbdKsOdWjTK7WgnVxR1G7Gje4G1wMYFsQzSKPfbAo=;
        b=r5iaROGREkagudTa9toTiRbQGUQ/l1hGkzJ22acaT6gKmb12aeuEIVxzBliToGkE3E
         isE7r9/Kd9UEAUkRWzPhLmpcRdH1yF2FoJzIi8vhITVRRvAnjXp9Z/wUsPWQ/RC+p72w
         Y6HOQTvM5rSl8bRUlACWF4hdFbDGwjO//yP8fcor/n+IomPCz0P+1wEqtGMsrkOkQ3CZ
         3XuNCikP3nK7IYdXu0zSX7GeVhQoB4e086+K5u3hMGFej+B2uMUDsWOjcQmqZ2H+oAbt
         5wuiy1OfuP6iqcRCaaxAfejycsGgDhIUp4pSWRW+YS+ZZTRxeCTJKKLXjR05mn9Fbd7k
         hwKA==
X-Gm-Message-State: AOAM531cmda1RBLmY1JaLDsIGwOIPHFJ8hYFimG8aVJCklQ8hB+tdDQ/
        ayohO9hVFpYQVhBlQvHtK1mq2PnrIm88Z70mqY5zQQ==
X-Google-Smtp-Source: ABdhPJwkS8PxjjDr2n5hfY2szPG9nSo1a5AJ4gvyeQ22qeS/fiE1q1FlxvsZwPnrHxg063ycasrTZYc3jhQ0K8KX3ds=
X-Received: by 2002:a05:6512:149:: with SMTP id m9mr2640542lfo.157.1620305713264;
 Thu, 06 May 2021 05:55:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210504161222.101536-1-ulf.hansson@linaro.org> <20210504161222.101536-6-ulf.hansson@linaro.org>
In-Reply-To: <20210504161222.101536-6-ulf.hansson@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 6 May 2021 14:55:01 +0200
Message-ID: <CACRpkdY2fScL3jvKoyR1m3+Yxj2=Nj3PPGm1cAqyn3kBS78aow@mail.gmail.com>
Subject: Re: [PATCH 05/11] mmc: core: Enable eMMC sleep commands to use HW
 busy polling
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

> After the eMMC sleep command (CMD5) has been sent, the card start signals
> busy on the DAT0 line, which can be monitored to understand when it's
> allowed to proceed to power off the VCC regulator.
>
> When MMC_CAP_WAIT_WHILE_BUSY isn't supported by the host the DAT0 line
> isn't being monitored for busy completion, but instead we are waiting a
> fixed period of time. The time corresponds to the sleep timeout that is
> specified in the EXT_CSD register of the eMMC card. This is many cases
> suboptimal, as the timeout corresponds to the worst case scenario.
>
> To improve the situation add support for HW busy polling through the
> ->card_busy() host ops, when the host supports this.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
