Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFE8AC433E0
	for <linux-block@archiver.kernel.org>; Thu, 18 Mar 2021 19:19:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B02B064F10
	for <linux-block@archiver.kernel.org>; Thu, 18 Mar 2021 19:19:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232653AbhCRTTN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 18 Mar 2021 15:19:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232764AbhCRTSw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Mar 2021 15:18:52 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 163AAC06174A;
        Thu, 18 Mar 2021 12:18:52 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id 61so6703911wrm.12;
        Thu, 18 Mar 2021 12:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=/j676tkAgUS/O5dhTPZRodCa+qnUzcgFpT3mbEwnEO8=;
        b=OK38Ka2J2ptk8WcFkgt1LrbAif1N99+zipc9tGVIg30IwmbnDeYWlzUod0QedwoO9E
         8uJgkzrJ6ay/82ilO4iQq7kL7RkVI1ULbD2sk5iTVYCSO0DyacQKk4RR2af6QXatwQQG
         AoPxYNSu3xutbWtwXHC3BGbjeWtxjPI5tynzIQsUwzMOpTKb5PZVTD6IRR93TukyGKcE
         yn8nopmVhiB5am74Gm9v6m2GH+sae4aDtAtaaIzaWJJI4f6Jg5rI1+oIlVD8/hK5k6oH
         Gf02pR1dg/nPXiobhIgwD/+uAIAx2Jz8oB03vumeLnupRCK2bxnnjZ8x3hOQCq2jzDeR
         5MAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=/j676tkAgUS/O5dhTPZRodCa+qnUzcgFpT3mbEwnEO8=;
        b=DjecK14S0b5WfkqFWeN+6Pi36eNSEj06u6OA+R8uVLtT3txoXDhRA8Na1L+sfdH6sk
         q44fQgqfW9sWOI1qC7uK+UO3jBSFBmfpOdtnub9xMrUiUXPj42+L880O4pU0QNSl5teE
         nj6XCFhDNMJpBrEqLE00TEL0pRHHB5Ann0+pyP8OzEHIzpqo5tUMZA1UWK9+E6rpAzcJ
         SmxH55WOsiYnJKVTWYgJjEeXtw+T+sJ1RAhJXV1r6zyPDXWchjjvkBlMga56Ln+WFXe3
         P4zvpKrdVYS5Hte/Btq/i8eDig1G99u2GngpDVAx6JZm39FTpDvWrSLEYqutZAQstHXX
         N/eg==
X-Gm-Message-State: AOAM532Dgmx5zHkpz/JYmSk1WK2di7FQG8yf1OCAGtd4x7rjiYW9llMd
        MO1DUwxWro6W7qtbu2VcpBw=
X-Google-Smtp-Source: ABdhPJyjMqFvq1mhgVW6jYL8JDgcCGNjgp2h7ACbK2MoWMoDBFZSVlZTe92JwYay2y0GZuUhhUTHww==
X-Received: by 2002:adf:eb8e:: with SMTP id t14mr831861wrn.20.1616095130864;
        Thu, 18 Mar 2021 12:18:50 -0700 (PDT)
Received: from LEGION ([111.119.187.17])
        by smtp.gmail.com with ESMTPSA id c2sm3256411wme.15.2021.03.18.12.18.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 12:18:50 -0700 (PDT)
Message-ID: <2f7b725b755350136b0ba8cedd3e342f8234834c.camel@gmail.com>
Subject: Re: [PATCH][next] loop: Fix missing max_active argument in
 alloc_workqueue call
From:   Muhammad Usama Anjum <musamaanjum@gmail.com>
To:     Colin King <colin.king@canonical.com>,
        Jens Axboe <axboe@kernel.dk>,
        Dan Schatzberg <schatzberg.dan@gmail.com>,
        linux-block@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 19 Mar 2021 00:18:25 +0500
In-Reply-To: <20210318151626.17442-1-colin.king@canonical.com>
References: <20210318151626.17442-1-colin.king@canonical.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 2021-03-18 at 15:16 +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The 3rd argument to alloc_workqueue should be the max_active count,
> however currently it is the lo->lo_number that is intended for the
> loop%d number. Fix this by adding in the missing max_active count.
> 
> Addresses-Coverity: ("Missing argument to printf")
> Fixes: 08ad7f822739 ("loop: Use worker per cgroup instead of kworker")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/block/loop.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index f2f9e4127847..ee2a6c1bc093 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -1192,7 +1192,7 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
>  	lo->workqueue = alloc_workqueue("loop%d",
>  					WQ_UNBOUND | WQ_FREEZABLE |
>  					WQ_MEM_RECLAIM,
> -					lo->lo_number);
> +					1, lo->lo_number);
>  	if (!lo->workqueue) {
>  		error = -ENOMEM;
>  		goto out_unlock;

Nice catch.

Reviewed-by: Muhammad Usama Anjum <musamaanjum@gmail.com>



