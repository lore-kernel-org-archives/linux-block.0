Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 265A5C43461
	for <linux-block@archiver.kernel.org>; Thu,  6 May 2021 12:57:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1BBE613C1
	for <linux-block@archiver.kernel.org>; Thu,  6 May 2021 12:57:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232296AbhEFM6V (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 May 2021 08:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232982AbhEFM6U (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 May 2021 08:58:20 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44EC9C061574
        for <linux-block@vger.kernel.org>; Thu,  6 May 2021 05:57:21 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id y9so6915603ljn.6
        for <linux-block@vger.kernel.org>; Thu, 06 May 2021 05:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h9tWSVGqAxyrmuhU0qEueft/17Ve4hq5jQObsYsqKAo=;
        b=kDtQg2xdKGkWOf0VeyihTIH8uqxMlaYNjyGMUGrtha6n1HTfjcr8AzrA0yAwBaJk65
         tj2MF4ZHSAKqplZKiv1MnEkn49gLYQOwBvbwHIe3762SW3NODwUlqxgVS9mvXY2tzCSx
         Caex0Q17aEZWe65Wf69eLMsbY8pkM6FwNlRbuXZDqz4tJy39IXhQ8ucLS0hkbAEG7/lZ
         4X3+zxj3+Mgd58oIwRsoflsZGmZkfJ3LXXTmax8mke3qVjuqvpaOoBCjRzxVSvbuySs9
         kujqmiUUv9s3mPhxlPXQgaWFBX7A6pL/OXi0XPYZj+QWzuBlCNeNN9Mvh9L1D+0ZYqaj
         yBoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h9tWSVGqAxyrmuhU0qEueft/17Ve4hq5jQObsYsqKAo=;
        b=Mym81v+L0Sni5an20NXHg0YABAjfUdCDSzzO+f9wElPbug1aP1u8BFZJkT1uP8rQlu
         r9y5VqNv9vDkn0m9zlvniKEo2oik7OUVC11UFGjbHqpxMYkTnS/ywJmqK/UcEoDUDJNY
         Fefc7ZlrtakeKPLkX4AaRtS3NpP7I+t+6p1uFcRW9bl2TkxPWh1OYpLxMTjLzI9drkyY
         bJK16UsDN39APnW/PQ03wDsx3sGiJs0QFjHvt/n7q+XRZt6cK+mKQ8k3U/AoxUSCVXJg
         1LGpgD7lDXDUuWiVjhVw03E7otAZ6oLwsQEMznwbCQHW2Qt79UkdUi6A4CVb9Un1xFBW
         p8yg==
X-Gm-Message-State: AOAM530wFiSXKDvQ0D+y4yN9214AdHpeOCbl80kEh7j1YstrrcwCUUqK
        Uq2OldVby3RdbFgqRZqe8KseTQZZyoeMPXORLShrzw==
X-Google-Smtp-Source: ABdhPJzRLocly4lInuLR47A3QjZv308cEaSCErmH7JGkDvbfFfBa8Bfssy1vMvOkZRrd7PWcrDEoc5Xv1VfahSzp81E=
X-Received: by 2002:a2e:81d0:: with SMTP id s16mr3396554ljg.74.1620305839834;
 Thu, 06 May 2021 05:57:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210504161222.101536-1-ulf.hansson@linaro.org> <20210504161222.101536-8-ulf.hansson@linaro.org>
In-Reply-To: <20210504161222.101536-8-ulf.hansson@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 6 May 2021 14:57:08 +0200
Message-ID: <CACRpkdYVqA35th9a4j6CTcOE2A16jamrWiOOQitEbz0iXq=7HQ@mail.gmail.com>
Subject: Re: [PATCH 07/11] mmc: core: Drop open coding in mmc_sd_switch()
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

> The SD_SWITCH (CMD6) is an ADTC type of command with an R1 response, which
> can be sent by using the mmc_send_adtc_data(). Let's do that and drop the
> open coding in mmc_sd_switch().
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
