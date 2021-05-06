Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38486C433ED
	for <linux-block@archiver.kernel.org>; Thu,  6 May 2021 13:01:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15AFF613DA
	for <linux-block@archiver.kernel.org>; Thu,  6 May 2021 13:01:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233051AbhEFNCN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 May 2021 09:02:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232992AbhEFNCN (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 May 2021 09:02:13 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DECA5C061761
        for <linux-block@vger.kernel.org>; Thu,  6 May 2021 06:01:14 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id w15so6912270ljo.10
        for <linux-block@vger.kernel.org>; Thu, 06 May 2021 06:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1o9YU1cRcYXzkHmKraCEMWOkwDyM4TPN0AO5wmmdGTY=;
        b=QGh/DMr3YWyJIdVxRuhgHcwYIwiGHeFKTvJnh/dtmauMQqI1wHd5Evea76xe9greed
         XtlHlw0rF6mL92DCBVZeB2+U7xlO0HJJZqamj5hTGEMkci98EHlifnwnNF0IiKcVuXgf
         cBmN3x8SvgbS7DWu+3Vun+cEPE6P/0YkUqjtLY6Se4NZ9vXx+dAfER56e+NsAzxJFHpl
         Wy/VupXQjfBonvEZeg3XnOwVi/P0sWXhuzY+txk2/wjJOva2ppjDV86zKuVu95wVUgBL
         lZL3AKRPWncJSitolznnmAbmQV7ZDE5fPfQfBgaxygmNRphn0k0jk7jGCdSoqvhkWfQy
         ZC+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1o9YU1cRcYXzkHmKraCEMWOkwDyM4TPN0AO5wmmdGTY=;
        b=adwqtOljHJDlY+wwyqsKhNTfavmKq/bMRmoJBFoLNk/jb2l5oHjOAzF6O4vThH/iYe
         vmkuf5CI5ve80aXvp0inSXppOt6lr/RksfS8MsRNgbVIfgKQzF8/+Wcy96cXPPU42se/
         EiMwGUmmMByCsKkPRg5lVW3DgJeFVCWrCggd56PZIGNPc2Ye6GngZp+Ftal/BqK3S1wX
         l2QFOo3YETYaeZrzi8arG6QxV4IG7tTT1jaSBBpF7tC3hl8xfaS7RC6aB88QucebVqD5
         MfLO+B+6teqFFxYJPDHvd06S9Esfi7N46HJM1NBGOCbLiDJnah0+2p42Iv5ljuuna3hI
         53rA==
X-Gm-Message-State: AOAM531mlvwdXqcetWeEmlT0uvkplZPkeUDm/961Ljit32fiNpMRET1Y
        9W9EGSJo3vKMgAZOFvqQ8fc1TsSoKuqdKrpu89titQ==
X-Google-Smtp-Source: ABdhPJxumvyre7G9VDri6pSA5PmkdD26UhUC2qL62jApVicOYFEU8vPDiZEavFOFM6F7HT1ITASFFaIz9QjawzPlJys=
X-Received: by 2002:a2e:889a:: with SMTP id k26mr3177134lji.438.1620306071975;
 Thu, 06 May 2021 06:01:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210504161222.101536-1-ulf.hansson@linaro.org> <20210504161222.101536-9-ulf.hansson@linaro.org>
In-Reply-To: <20210504161222.101536-9-ulf.hansson@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 6 May 2021 15:01:01 +0200
Message-ID: <CACRpkda9fWzeqLvSX4-fr1hcP7KqWrRQGSFvCM2STYNM_FkL9Q@mail.gmail.com>
Subject: Re: [PATCH 08/11] mmc: core: Parse the SD SCR register for support of
 CMD48/49 and CMD58/59
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

> In SD spec v4.x the support for CMD48/49 and CMD58/59 were introduced as
> optional features. To let the card announce whether it supports the
> commands, the SCR register has been extended with corresponding support
> bits. Let's parse and store this information for later use.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
