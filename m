Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA4E5C433B4
	for <linux-block@archiver.kernel.org>; Sun,  9 May 2021 18:49:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8287D610A7
	for <linux-block@archiver.kernel.org>; Sun,  9 May 2021 18:49:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbhEISuN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 9 May 2021 14:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbhEISuN (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 9 May 2021 14:50:13 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D633C06175F
        for <linux-block@vger.kernel.org>; Sun,  9 May 2021 11:49:09 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id v6so18073545ljj.5
        for <linux-block@vger.kernel.org>; Sun, 09 May 2021 11:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lMJvx5UVUSxWfxal6KmjDPL7AuvEAZJvWWHWo4hAYoo=;
        b=bPH0qO6fe7UoMIwaSSiLTVdTGdPG8Qq8pmPecFEYO8u1EtSnnoARg6IFh6TVjnG/Vo
         UC5kiD2S1FB4SSVHancR/Tfbn/4BeP3rSWIISAwLDVfdLqRQA7GTPIqyR8jxsSXN2Mef
         oCHy7ib2z0Qp+RHR5IddW0zG4FmRCKD5z4EpHMzBxJxorsnBM0TlNUrS3ivW3v/NK7HI
         cMJjc9HJVbyRAERobvQGpHiMPceqBR9f7EnwPXCffob0sYc+71UsYcKHNjy0zuUJY87c
         J3Lq6ROvTJTrRs9E39ivSzG41oN5IkLRB2gGD0FvuU4kVcok43gCxNWOcCfoI41sfgZN
         5pqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lMJvx5UVUSxWfxal6KmjDPL7AuvEAZJvWWHWo4hAYoo=;
        b=M8u9Q0j2kxnkTflm4bREgyQuQedQ/7aauGt8v0Kat4YOYSAACQpss72GfHCNmL/zaW
         Nyykh3geDLAEzE4DM48I2ajknqBtOz6mEXXyHejYFjB+3FLrVlyZbEb2+J1SAp3l2WZM
         xZkzOIeEF+UKKuj4KW98jwxQXC7HJU7RdFhLk7BCt59uNKEYYxbs4jEC4hJzD0jKOBgh
         wxM6WSUI4GQEhcUQe9wJ0JvR6DYC1Gfgl+1qkl86l7pCj2iv19fqElPwslLaC0HDHv6M
         eSiJtEWKWAw7MgAotXhcO1qHpldgw+OkewnM6HZaxd/nfGVnNQFT+GiXLrsQMxgVJbze
         Xf0Q==
X-Gm-Message-State: AOAM530ObcyFjhS31YyybXnwA4NrGlS7iK0ooRpz4QIbNYrvkkk7NipY
        1oUQ4Qpgk1UqMWdtQ9xz592Xu748pjzAp1yAwpzUMg==
X-Google-Smtp-Source: ABdhPJxFikBt8NEEjavRogVdk7f3yUsdtfJw1Nh5UYxdACqLuIxR2l2Nd4M9r0XGfUMWcsApRPZBl27Zb1VaeLEWIbQ=
X-Received: by 2002:a2e:2e12:: with SMTP id u18mr17146118lju.200.1620586146550;
 Sun, 09 May 2021 11:49:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210506145829.198823-1-ulf.hansson@linaro.org> <20210506145829.198823-2-ulf.hansson@linaro.org>
In-Reply-To: <20210506145829.198823-2-ulf.hansson@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 9 May 2021 20:48:54 +0200
Message-ID: <CACRpkdYjwGA+kOdBAg3Yc2VdZ5rPEHNe5PdDSxwBDwd9Y02mWg@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmc: core: Move eMMC cache flushing to a new bus_ops callback
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

On Thu, May 6, 2021 at 4:58 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:

> To prepare to add internal cache management for SD cards, let's start by
> moving the eMMC specific code into a new ->flush_cache() bus_ops callback.
>
> In this way, it becomes straight forward to add the SD specific parts,
> as subsequent changes are about to show.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
