Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7F3BC2D0E4
	for <linux-block@archiver.kernel.org>; Fri, 27 Nov 2020 12:49:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E41322248
	for <linux-block@archiver.kernel.org>; Fri, 27 Nov 2020 12:49:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="ShRJZTqQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729662AbgK0MtS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 27 Nov 2020 07:49:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729659AbgK0MtR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 Nov 2020 07:49:17 -0500
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF2F8C0613D4
        for <linux-block@vger.kernel.org>; Fri, 27 Nov 2020 04:49:15 -0800 (PST)
Received: by mail-ed1-x544.google.com with SMTP id y4so5589152edy.5
        for <linux-block@vger.kernel.org>; Fri, 27 Nov 2020 04:49:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MLxlW/gEhLdaoeknORQbB3xpeNHDsUxRze8Z8bH4egc=;
        b=ShRJZTqQ5FfdO4ONy4BOdejADoVoxPejEMT5ZCwrog94iqOpSC9bV+Hx7iCD5Yyzcf
         xwQ9ERuCouISSaGxHRDlPxZhKNTUIZyTTM9MuFlWerBDQrCKlUfvxCP+xJ5BD2AxYIFJ
         2UPER0z03O3hKBw64agptEeOoqrIatzbDy0FDHSnXlpdkslw/lhvvv3duBN8bzULxnGr
         34udYFCSayv/T4VJ7xuKF4qm89fIjASK1e9kQ76CYAKKcwewyFOt7xHGIPwcbmiqyTe2
         Vn4CR2dH5t4PZxFAJWxSuoGaEBNZsuI7CSLDKR8vX+vV/Gpu0pB60KvNp/3ZRE3BV0q8
         1RHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MLxlW/gEhLdaoeknORQbB3xpeNHDsUxRze8Z8bH4egc=;
        b=WtzZ14HlUmrQ5NECACf/fpSg65ywK02kczpNOfZfTpLuOhkArVdHRozgY11GHw5JUb
         f74QADhqD22Epq5/INng/PEDdZWCtpC7gY7iOLDQByje02+76P8qjS5Dfvj9lrz2YpwD
         eyyTjBxmGVD58rBx92IiCoMrVqSVmFsIf/UAN4Imtv1t/bKGNRdVNCUuc0JyS9PId7sx
         H6Jp87QHzKmoepq7t2aoBvP0K2qbW6PFoHKaH/52RCKqnLCE/mB4xgk6hrenni6gj/0W
         DM/xz7eRzaJbtlEnTMyDNN3VqizLrJ0V5ARflHJ4S+LfeLl3D5oqtqNMZL9j8vnphOxq
         b9pA==
X-Gm-Message-State: AOAM531SsoNhV8HjENKntOmbRfbDh7WWdCMfeaQEuukvxGie/S/rFxS2
        7QFCtjW+T6lr9yTN+yCbwGKQ8bucWEhI5Qv9+aoynQ==
X-Google-Smtp-Source: ABdhPJyiCIe+eQjcHroPmqnP59s6SYoo9yIxwORecYyCI3l02nP0cUJvNwqxcWOmRmuJ0dgWwUGjnpcRUy/iey1aITg=
X-Received: by 2002:a05:6402:3089:: with SMTP id de9mr7512723edb.100.1606481354525;
 Fri, 27 Nov 2020 04:49:14 -0800 (PST)
MIME-Version: 1.0
References: <1606479915-7259-1-git-send-email-ingleswapnil@gmail.com>
In-Reply-To: <1606479915-7259-1-git-send-email-ingleswapnil@gmail.com>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Fri, 27 Nov 2020 13:49:03 +0100
Message-ID: <CAMGffEm9KRH9GBP6FOTE9GUJGJzY+p3-_Xm9-BTapec3L3mu1g@mail.gmail.com>
Subject: Re: [PATCH] block/rnbd: Adding name to the Contributors List
To:     Swapnil Ingle <ingleswapnil@gmail.com>
Cc:     Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Jens Axboe <axboe@kernel.dk>,
        "open list:RNBD BLOCK DRIVERS" <linux-block@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Nov 27, 2020 at 1:31 PM Swapnil Ingle <ingleswapnil@gmail.com> wrote:
>
> Adding name to the Contributors List
>
> Signed-off-by: Swapnil Ingle <ingleswapnil@gmail.com>
Hi, Swapnil,

Thanks for your past contributions, sorry for missing your name on the list.
Acked-by: Jack Wang <jinpu.wang@cloud.ionos.com>
> ---
>  drivers/block/rnbd/README | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/block/rnbd/README b/drivers/block/rnbd/README
> index 1773c0a..080f58a 100644
> --- a/drivers/block/rnbd/README
> +++ b/drivers/block/rnbd/README
> @@ -90,3 +90,4 @@ Kleber Souza <kleber.souza@profitbricks.com>
>  Lutz Pogrell <lutz.pogrell@cloud.ionos.com>
>  Milind Dumbare <Milind.dumbare@gmail.com>
>  Roman Penyaev <roman.penyaev@profitbricks.com>
> +Swapnil Ingle <ingleswapnil@gmail.com>
> --
> 1.8.3.1
>
