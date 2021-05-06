Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08083C433B4
	for <linux-block@archiver.kernel.org>; Thu,  6 May 2021 12:54:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB498610E9
	for <linux-block@archiver.kernel.org>; Thu,  6 May 2021 12:54:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232525AbhEFMy6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 May 2021 08:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbhEFMy6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 May 2021 08:54:58 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A8C8C061574
        for <linux-block@vger.kernel.org>; Thu,  6 May 2021 05:54:00 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id u25so6898081ljg.7
        for <linux-block@vger.kernel.org>; Thu, 06 May 2021 05:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d+OPQctMT5v0HvXEs0KL3xl4z57JF9IlElnIypbIafY=;
        b=MdnUPYwzkZPQjM5OIgcsszZlz/F/h+pGFm2t9OL+0ov7BsfZ1hS1jLjDLMxDtn9O2f
         BlEDl91hDASPTzTf2BPF6Eoq4rdB1K2cwNiUfiFAEFO+DOjeqC96sM65xiAJXtSqj0YP
         oi6h+ipCV6YG+cxzHUVhZijDusqMUAyWOl539L/2vIyretdReLPTIttMM+PccVAjbscM
         sA4F1I46sBr+taK3W5lQDClb4IAV8cRsKskb0CFOZq5Du3tKF6zpay/zzczJpoETBnfj
         RIaTlWujAtqpvW2qQX+gIa8/WvdrZZwWQoSxtViSRP4Wu2oULsxoSRKHqfcFOY8sliJs
         nRHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d+OPQctMT5v0HvXEs0KL3xl4z57JF9IlElnIypbIafY=;
        b=iQAzjvULfhENZXeJvX71oWIqcE9jXinrBudTUJOt0+Kf6Ql8uso55QG9DDasglR8NR
         NJIEwaPzP5vbi9h8cl2ZZymay3Z/x/mB9esbLxs6T+DKy1SRMGo9Mcf4swYoU/Xa2b5f
         jl3Zl6E4BjGwCR78hhSdKpbqiRjniNKJQ/gXq56Qi3EhiZKIhQkk54eQzIvX9tvDaMcV
         c56JwPumvxpMREVX+4JcB9j4M0o4lfeNM7a6rGoWPG1K+5DJeLOYEDSEYtHoHsd7K7Fi
         8MfiIo1BUjcs501nvDeYBiIxj5um+JLB5KPszYpSTxEGupNptQ6JSlM46RTqOMUdd+NK
         J/KQ==
X-Gm-Message-State: AOAM532ISBlS+wNTqh7IJz6jHxttjjhKHMek3Z4Ccy4lrpI2puKgFM7/
        pitYu8IG/HRa3gjCBAZnrwOU1taJ4cNqGG52XRZ8jg==
X-Google-Smtp-Source: ABdhPJwdOYHWiEjJghr3gE+4URcaew1fSeNhWpBS3+NVycFSi/NI/vSXe6Kw3TPGd35JtJGnHS4z1TSO+6fxNN+mrB4=
X-Received: by 2002:a2e:a54c:: with SMTP id e12mr3257006ljn.326.1620305638900;
 Thu, 06 May 2021 05:53:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210504161222.101536-1-ulf.hansson@linaro.org> <20210504161222.101536-5-ulf.hansson@linaro.org>
In-Reply-To: <20210504161222.101536-5-ulf.hansson@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 6 May 2021 14:53:47 +0200
Message-ID: <CACRpkdZ_5v0fe9YzZvhRvRovYd1CWTBX3X3uSPc3GeN6ygZxaw@mail.gmail.com>
Subject: Re: [PATCH 04/11] mmc: core: Extend re-use of __mmc_poll_for_busy()
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

> Via __mmc_poll_for_busy() we end up polling with the ->card_busy() host ops
> or by sending the CMD13. To allow polling of different types, which is
> needed to support a few new SD card features, let's rework the code around
> __mmc_poll_for_busy() to make it more generic.
>
> More precisely, let __mmc_poll_for_busy() take a pointer to a callback
> function as in-parameter, which it calls to poll for busy state completion.
> Additionally, let's share __mmc_poll_for_busy() to allow it to be re-used
> outside of mmc_ops.c. Subsequent changes will make use of it.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
