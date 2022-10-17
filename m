Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17A6CC433FE
	for <linux-block@archiver.kernel.org>; Mon, 17 Oct 2022 19:15:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbiJQTPn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Oct 2022 15:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbiJQTPm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Oct 2022 15:15:42 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3640C3DBC4;
        Mon, 17 Oct 2022 12:15:42 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id n7so11685315plp.1;
        Mon, 17 Oct 2022 12:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jYQqkn4Z7pKMP3VJb1HX2oe2GpNgJO0E7bDKNOoYtIE=;
        b=TPN7z+1mH6FaSYcRjIy1CQQSIt5z8vj1Tle8p8G6umvRw+WQOFyYd8mYhw/EcxgIsF
         vgisJtlzCmLBDI0+8V+/gRYV9fC0WzT7lsz6LYUvbvR+F72s4LGohEmCW4VAzviotxc8
         6VYSHMhzMRJNMi7NHCg36Dj5UtfiTDkpt95xuV18Ak7aIjDzMHSsCe+xJWA6Q2wqLp4o
         fxMHLwTBfcsY6fF9PE9SEmZrqoKFlxCL0GGQT/QIgM0Z8AZseEU/YrOO+jICs6b4qz9m
         TwfKBv9JC6cQPTkYOSMTRwZKSVL280JKetKKJqv/gWOuBouMXDAlxOejxGe9qwtx3m7H
         FDaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jYQqkn4Z7pKMP3VJb1HX2oe2GpNgJO0E7bDKNOoYtIE=;
        b=dZCJ4xob+KJ1YoSm/uxlI6DO7bBiAb5jap06CUey8N7h0ct3es8QFTUAYRV3zjACCj
         Ypxit6of0ucSh355Lzf9bFY8LfZbrm6YAmzq/RjS68LjeSUWxWPBmyf+6fF9WrtYi7zU
         AlkOu2mQhXnDoE/NwfJyG97qoWglitoCBcWw0qP3UW34jRDy2NCLh10uEWApOoN1yUjd
         GNzSLhcQ13fzMBtK8QKZLogbOi6mow2tlB2tL18H6HoqVEwTHgNL+L4Wr2n4EchyftvH
         mkXBundc50RZ4hVUc8qn5SLSQrltLoA8ZPcowWBCZYNOAt6piKOlnnhfqkWdHIe2zCzY
         W+6w==
X-Gm-Message-State: ACrzQf0VKyDN1WFOwGk1ZkF4pDrm71womdUKFwF/RMEkRO2FJb/YR8sv
        YgsqkRMJ7XfQGpA4C469nNODH5OvNlfCoQ==
X-Google-Smtp-Source: AMsMyM7zwjDrT1QdJLHBEh0N/xEdJto3b07NPFrCmaAcVvUQZNzbAmlidfRdShChWxs4WVtlbGhzkw==
X-Received: by 2002:a17:90a:6e09:b0:20d:86b2:4c54 with SMTP id b9-20020a17090a6e0900b0020d86b24c54mr15267460pjk.73.1666034141597;
        Mon, 17 Oct 2022 12:15:41 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id f15-20020a170902684f00b00176b0dec886sm6978459pln.58.2022.10.17.12.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 12:15:41 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 17 Oct 2022 09:15:39 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Kemeng Shi <shikemeng@huawei.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/8] blk-iocost: Avoid to call current_hweight_max if
 iocg->inuse == iocg->active
Message-ID: <Y02p23KdUZfkYyzI@slm.duckdns.org>
References: <20221017020011.25016-1-shikemeng@huawei.com>
 <20221017020011.25016-7-shikemeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221017020011.25016-7-shikemeng@huawei.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Oct 17, 2022 at 10:00:09AM +0800, Kemeng Shi wrote:
> The old_hwi is already max hweight_inuse if iocg->inuse == iocg->active.
> Remove unnecessary calculation.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huawei.com>
> ---
>  block/blk-iocost.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/block/blk-iocost.c b/block/blk-iocost.c
> index 96c1571a8a1d..fa90f471dfdc 100644
> --- a/block/blk-iocost.c
> +++ b/block/blk-iocost.c
> @@ -2299,7 +2299,10 @@ static void ioc_timer_fn(struct timer_list *timer)
>  			 * Determine the donation amount.
>  			 */
>  			current_hweight(iocg, &hwa, &old_hwi);
> -			hwm = current_hweight_max(iocg);
> +			if (iocg->inuse == iocg->active)
> +				hwm = old_hwi;
> +			else
> +				hwm = current_hweight_max(iocg);

I don't think this is correct. The intermediate nodes might be donating.
This also isn't a meaningful optimization given that it's in the cold
periodic timer path. I'd much rather keep the code simpler unless the
performance benfeit can be clearly demonstrated.

Thanks.

-- 
tejun
