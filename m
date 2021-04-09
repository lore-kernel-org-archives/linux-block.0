Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0B28C43470
	for <linux-block@archiver.kernel.org>; Fri,  9 Apr 2021 06:52:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8E32610C8
	for <linux-block@archiver.kernel.org>; Fri,  9 Apr 2021 06:52:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231540AbhDIGwU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 9 Apr 2021 02:52:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233436AbhDIGwS (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 9 Apr 2021 02:52:18 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 969ADC061762
        for <linux-block@vger.kernel.org>; Thu,  8 Apr 2021 23:51:39 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id ba6so5267550edb.1
        for <linux-block@vger.kernel.org>; Thu, 08 Apr 2021 23:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iVXwoDR1W9QvRjhucoUC7c/vC9MQIOWHo7DvYHCPOJo=;
        b=jp3edxb/QxA1ggevZiqUpfEhTNzwuTu/Fzj3YxQUTh4uqo999d9sPlwYAnEzGlbngh
         q0RaAWEavXjMLa0TBLUPgkW2QQUZn4tsAq0OF9xGh0RLGxDPSQ/OSPf759uM/8KlW0eW
         jwKxoGPSxdVoitKMl7IdqIO0OJ95VMnHaRQClJsHbSHBJ45LGgHPVpQJWfjmvejA0ady
         7wO8SRe9WKfr+QW/QLb/Ck/B08DqaAy3wEm6bU18zNWPrSl8J4hC7PIAPglYE6eUinbd
         Y/1xWROZxgpxGonT8d9oQdbt+WasxYr+B8Ehe4U3vwECdbUAJ2yPuiRG7mCixEdIeMpC
         z4Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iVXwoDR1W9QvRjhucoUC7c/vC9MQIOWHo7DvYHCPOJo=;
        b=F8YCoGao/yu4AaEUFj7YTSiJ+x7oCw05l/fu9V6MAKV0Rcfd4kc/RZF5goAPd94eja
         WukNjYB3yfl49ziu4tI0HJdJIc512Axk9n6Pb469yoLqlEIWjfOQeKuc6bBDlcSrJZ8Y
         Jwy1GE3s7C40/np2DGZMhZjwLXX+zN3jGVwl5XJjAt0NqAWWyF5FmmyvsPN2zbj/lg7X
         h5om4Wde8le6P7xx8gTFK+PGXZsLUiwOApYfpuYi2tmwv8/rd8Ck2glveLMA1gWIEDe+
         2G7X/pkgfe+ztyAVa/TSGONxvWcde+EHD2mISTQtkdC3PsIL/AbCZ0W8m/1wNibwNBEZ
         m/Kg==
X-Gm-Message-State: AOAM533gXv/nNH/6BArRyU3NYXSfmEufb61RUv6HYZjnqKMNFz2q+5CH
        zRgqKIHCrrOErkB8RTncomY/Q9FgMBgAGQFE3z3C2A==
X-Google-Smtp-Source: ABdhPJyJvtMdjK2KX7gsxXdwAKOJSMBjGpt1UhnyQgrzyqzOqiWv/VvaFEcu7shOuE5aXr1d1z9IsTvLv40e3h/k3UA=
X-Received: by 2002:aa7:d843:: with SMTP id f3mr10419259eds.52.1617951098105;
 Thu, 08 Apr 2021 23:51:38 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYtNAEwCk1WkA_25FVUrR0QJ2vt2Dh_w+m-QOSjb8f5TBQ@mail.gmail.com>
 <BYAPR04MB4965A95A5131664085CDD8B786739@BYAPR04MB4965.namprd04.prod.outlook.com>
 <CA+G9fYt30EZOv2mUOf+xGh3R3A0SMJhvVtHFwZuKyBgB75UTTw@mail.gmail.com> <BYAPR04MB49657BEEB8988BBEF3C4429486739@BYAPR04MB4965.namprd04.prod.outlook.com>
In-Reply-To: <BYAPR04MB49657BEEB8988BBEF3C4429486739@BYAPR04MB4965.namprd04.prod.outlook.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 9 Apr 2021 12:21:27 +0530
Message-ID: <CA+G9fYuZE3ciSrkJdT1byLyKwUV1c6yrk4zT97_-FxDDLK6GvQ@mail.gmail.com>
Subject: Re: [next] drivers/cdrom/gdrom.c:586:61: error: 'rq' undeclared
 (first use in this function)
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "lkft-triage@lists.linaro.org" <lkft-triage@lists.linaro.org>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, 9 Apr 2021 at 12:02, Chaitanya Kulkarni
<Chaitanya.Kulkarni@wdc.com> wrote:
>
> On 4/8/21 23:24, Naresh Kamboju wrote:
> >> bio_offset(req->bio),
> >>                         GDROM_DMA_STARTADDR_REG);
> >>         __raw_writel(block_cnt * GDROM_HARD_SECTOR, GDROM_DMA_LENGTH_REG);
> >>         __raw_writel(1, GDROM_DMA_DIRECTION_REG);
> > Thanks for your patch.
> > After applying this typo fix, the build pass now.
> >
> > - Naresh
> >
>
> are you okay if I add your tested by tag to the official patch ?
>
> Or you want to send it as a reply to that patch ?

Please create a patch and add my Reported-by / Tested-by tags.

- Naresh
