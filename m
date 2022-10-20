Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD95DC4332F
	for <linux-block@archiver.kernel.org>; Thu, 20 Oct 2022 01:30:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231299AbiJTBaQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Oct 2022 21:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231327AbiJTBaO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Oct 2022 21:30:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A69A0114B
        for <linux-block@vger.kernel.org>; Wed, 19 Oct 2022 18:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666229185;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cMgGZ6JgJsqaOFU1082FRyXxTCRVHVjB7j7NRF7R4zo=;
        b=Uy9S48VTrP1JjZ1pvLD4TRHcRRMaVzAopM030QO2t9awIE2VTFHOiqcx+Ym1E+jALG6qkZ
        qQVAcjb8rrGo3hJUWbvQjaVOcIQ1xtyJbh4kfrgFiYqFhISyTdfUF8eOLtVS6S2MmPTUhb
        cEnyo0ktX6yqZITPFYcJAKBH+egaDSo=
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-158-pJpCkidMP96PAhfVLT21Ww-1; Wed, 19 Oct 2022 21:26:24 -0400
X-MC-Unique: pJpCkidMP96PAhfVLT21Ww-1
Received: by mail-ua1-f71.google.com with SMTP id t21-20020ab04ad5000000b003d6a29c1824so7850151uae.13
        for <linux-block@vger.kernel.org>; Wed, 19 Oct 2022 18:26:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cMgGZ6JgJsqaOFU1082FRyXxTCRVHVjB7j7NRF7R4zo=;
        b=IFy2w7tIs6Vms7Jnt+gNcZMcWcGx/AHnGnmfmGK92pTyKDfT3oOaiuXuhUXcnxQFHK
         ZVrOhNotrjI1d5FywPLzhewDkuVCfyd11Y1sXMlQoxM7yUBGNvEuQnDUa2WYBuuxzfzr
         UKWBPUTLZOeCGqpPj74WwN0az+qFoXMXBQSkDf8pLMdtN6iHwIr9GedfVMfWsqbMhQiy
         XQvzC4bL+HZjwmPMNTtUQZ1bSS0RwyYGjjdFj0klsOq51qSzpnyP8/leMsTRq0VCBMTz
         l/6gWxseFfpmI4VKKxgUm8LPRLwjg0fhjItBGxtevOSqN1wwKGRL6WNNLT/EDsTZCreN
         +CKQ==
X-Gm-Message-State: ACrzQf3apofO8Og5DYKZ6xmsVcAM3qnFhKlwVTxi95Vzxldahp4JD9Xc
        /GO74LPJqLD+o3uQtMQ/bK+q1r15OfiYhRdHUyEe1qSA8n15HnYxuOIdORJG0tV229Si/JUImBJ
        9/f9sSBO7Da/TtRyQLLHDHMt1dawLVst5tMZu6A4=
X-Received: by 2002:a1f:43cc:0:b0:3ab:ad61:bf73 with SMTP id q195-20020a1f43cc000000b003abad61bf73mr5209826vka.33.1666229183968;
        Wed, 19 Oct 2022 18:26:23 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5VqJMndKWdo1ttTzuTTW0GETd8TPEBsQhdsNZ8Ipln45lWhXgKpdKmtP1bjflXLDqOWHirpSJF5Vml3H3EyJQ=
X-Received: by 2002:a1f:43cc:0:b0:3ab:ad61:bf73 with SMTP id
 q195-20020a1f43cc000000b003abad61bf73mr5209819vka.33.1666229183758; Wed, 19
 Oct 2022 18:26:23 -0700 (PDT)
MIME-Version: 1.0
References: <20221018100132.355393-1-zys.zljxml@gmail.com>
In-Reply-To: <20221018100132.355393-1-zys.zljxml@gmail.com>
From:   Ming Lei <ming.lei@redhat.com>
Date:   Thu, 20 Oct 2022 09:26:12 +0800
Message-ID: <CAFj5m9L-=DL-bB9iKRkAdVB+Jjdb5LaF12K1hfj5SCKmii1gXw@mail.gmail.com>
Subject: Re: [PATCH] ublk_drv: use flexible-array member instead of
 zero-length array
To:     zys.zljxml@gmail.com
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yushan Zhou <katrinzhou@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Oct 18, 2022 at 6:02 PM <zys.zljxml@gmail.com> wrote:
>
> From: Yushan Zhou <katrinzhou@tencent.com>
>
> Eliminate the following coccicheck warning:
> ./drivers/block/ublk_drv.c:127:16-19: WARNING use flexible-array member instead
>
> Signed-off-by: Yushan Zhou <katrinzhou@tencent.com>
> ---
>  drivers/block/ublk_drv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 2651bf41dde3..5afce6ffaadf 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -124,7 +124,7 @@ struct ublk_queue {
>         bool force_abort;
>         unsigned short nr_io_ready;     /* how many ios setup */
>         struct ublk_device *dev;
> -       struct ublk_io ios[0];
> +       struct ublk_io ios[];
>  };
>
>  #define UBLK_DAEMON_MONITOR_PERIOD     (5 * HZ)

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming

