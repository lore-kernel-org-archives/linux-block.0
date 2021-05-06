Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04EFDC433B4
	for <linux-block@archiver.kernel.org>; Thu,  6 May 2021 12:56:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1802610FC
	for <linux-block@archiver.kernel.org>; Thu,  6 May 2021 12:56:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232319AbhEFM5k (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 May 2021 08:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbhEFM5k (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 May 2021 08:57:40 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30A6FC061761
        for <linux-block@vger.kernel.org>; Thu,  6 May 2021 05:56:41 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id v5so6886410ljg.12
        for <linux-block@vger.kernel.org>; Thu, 06 May 2021 05:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4aClTJeWbL/qxhEs2nSQK0NRaAKt2JmCluDJCHpda6Y=;
        b=qpppjZbeVuYwOFuRDH3TurulhVeiNksaHsn0Kj11NYmMJgdCA/egI11Fpv8L0Pkc+W
         ImwL5c4YoILHr5gI+x5kseYDAK0Fd4F4of1zGd/rIOE7KynX4HjImcyies3aZPlkXwO6
         MjWXIBgfVa/6DbCi29C75Z8+AID9L68PSTguvGbZHGrny1QxCOt4TGHWuCUea9WCgS4L
         XtOkixgeTFs/bTt9Sx5T+PMMb1iFsb442i0qHKWSUKDNxRr6s/0S4awebmt0gqsaziyz
         mlF1tTU7iPjftZJ1yd5fB2bBvN+eJcmCI7dERHu7I4JdF23il9xWJB9XX9+qJ8YkzM52
         vYfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4aClTJeWbL/qxhEs2nSQK0NRaAKt2JmCluDJCHpda6Y=;
        b=ZRut1wqiqSaFlwVdBZdx9tkfEE2Dcnf6PR2HPXAwQm1SIHLveJEHi9R1dECvRz526M
         JeN0SnucgexqRudpJnNVUnEHV7GJsdbAnoJf2oDnGFXWZDVJ3oYITnedqmGSDQ/acwC1
         j3EtjXb+0/veD7yrz9ZfT0XgF6YFf4vn6bjjqX8FRAzZRjNvZ4Msnk4FngY3mM43UiM9
         QgcGkZf86croDnSMjWI2iJdH1q/PpfR0ZirjJpsbDXQgQwzLoFkITz7umEFyX2TptfWW
         71HZz2cvd52wcvX+QurgUfSQHzgo5TyLfq2Yx9ugTJGM7Xtr95tTVKn8dtXNQ7Hqnses
         ss2g==
X-Gm-Message-State: AOAM532agbVRYWK8ZeGTT9prQmVR/alpifaSOfcEY3d2vIb/2sZbxi7a
        BYHmTHnlBFT1ak72oCxJPf48tHgfZ3bwPOXj4YLC3Q==
X-Google-Smtp-Source: ABdhPJzALvXV18URUN/FUKmi8gb0S8rqfJCUb4ZzD6gaSpgfzDqWDwdzjXqVQUzitR+KZE9s9iaAZOiE1GT/PoEXvC4=
X-Received: by 2002:a2e:2e12:: with SMTP id u18mr3153318lju.200.1620305799721;
 Thu, 06 May 2021 05:56:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210504161222.101536-1-ulf.hansson@linaro.org> <20210504161222.101536-7-ulf.hansson@linaro.org>
In-Reply-To: <20210504161222.101536-7-ulf.hansson@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 6 May 2021 14:56:28 +0200
Message-ID: <CACRpkdZWHQ3WS_zKOji9YZv3BMJnLxbsFjZjsUtiF0DPiq+sCg@mail.gmail.com>
Subject: Re: [PATCH 06/11] mmc: core: Prepare mmc_send_cxd_data() to be
 re-used for additional cmds
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

> The function mmc_send_cxd_data() sends a data read command of ADTC type and
> prepares to receive an R1 response. To make it even more re-usable, let's
> extend it with another in-parameter for the command argument. While at it,
> let's also rename the function to mmc_send_adtc_data() as it better
> describes its purpose.
>
> Note that, this change doesn't add any new users of the function. Instead
> that is done from subsequent changes.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
