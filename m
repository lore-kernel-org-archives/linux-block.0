Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECD75C433F5
	for <linux-block@archiver.kernel.org>; Wed, 24 Nov 2021 14:25:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352322AbhKXO3D (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Nov 2021 09:29:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354529AbhKXO2k (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Nov 2021 09:28:40 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6AE7C09349C
        for <linux-block@vger.kernel.org>; Wed, 24 Nov 2021 04:52:39 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id np3so2460618pjb.4
        for <linux-block@vger.kernel.org>; Wed, 24 Nov 2021 04:52:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HhjBXu1spqUIZjkRdjpzeyORochpjVOEaVaDPxXcrPQ=;
        b=cozjCge9C5AJHrR7oEYfC4H5dkIzE4za65ooehhEDODirMwBkx44ZasUqVRuZQWujJ
         gLcIRvV2ytmSyoMtPwV80a2ov7/8xQ8F1jN5Ka31YHmLtjCcpMevKvVosXcWfN2c+1Jb
         sV9VuliLm+ijvS95fU15IHh1dAfRS0JY5T/eRapNdd5VKoQS12ad14Q8IKrfsM5Ls79s
         +wJWEcutl90kr4ajU07j2aDzMdR6bggL30DiCD9kEh79V0+Jm+jKS6+PK4IDwqf9H1hW
         TfT+0Wg8VC52+FegNo/hpFCCOH+j+qgxOPShKmr7dzLp+Z5U7IRnM1TjEZA9SiceaVOa
         X8oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HhjBXu1spqUIZjkRdjpzeyORochpjVOEaVaDPxXcrPQ=;
        b=RH5NEAucN6SkB+uUBoijw55COWSs/ihcVvLBoenchPRsKvO5oKX4pHE2SX1q5JP8tI
         7hcTc+uH0mCK+2opYHXeeNUaXKt1yPJOH4arOXBDARjHN1dkjvVQVwCXBDJnohqpFc38
         cXgC4b5xoz9Ea1rN7QXVpVW1uOGMtcwZokbrZNGGSi+dCahgyW6XcCo6/ds/z8VDG/Rs
         IPbKRY8TPLGr2oxqOi5PYFjNKFL0Oq/kO6TZDpBJqs0XTaSRRpFQsTpfFMOEXVcn0/uz
         4dP0Od46KQf551SyTbKS4jeIxsjoOj9YfGbjZ8+Y9dLcaa9AjP/EiZGTpdQ4P0GqU1kJ
         f+Kg==
X-Gm-Message-State: AOAM532VKHRsfttYAq0ot8kZd9mHeg+Q7Tkq/+B/G3ZpYtxGWO1dTomm
        b0/ZtcJ/ZLHl5A4JNx3NXmUwiaqgdsP27w==
X-Google-Smtp-Source: ABdhPJzZFmFUqoKwaz3+cRX0U2oYcE7QkVtC4kMstCgBFC/exmSsTzJol9/zOHRltI3kymN3X2Yefw==
X-Received: by 2002:a17:903:22c6:b0:141:fac1:b722 with SMTP id y6-20020a17090322c600b00141fac1b722mr18412923plg.23.1637758359382;
        Wed, 24 Nov 2021 04:52:39 -0800 (PST)
Received: from localhost ([182.65.219.35])
        by smtp.gmail.com with ESMTPSA id u38sm18378941pfg.0.2021.11.24.04.52.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Nov 2021 04:52:38 -0800 (PST)
Date:   Wed, 24 Nov 2021 18:22:36 +0530
From:   Pankaj Raghav <pankydev8@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, p.raghav@samsung.com
Subject: Re: [PATCH 1/2] block: only allocate poll_stats if there's a user of
 them
Message-ID: <20211124125236.s7h7e2tunjxt3r3j@quentin>
References: <20211123191518.413917-1-axboe@kernel.dk>
 <20211123191518.413917-2-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211123191518.413917-2-axboe@kernel.dk>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

On Tue, Nov 23, 2021 at 12:15:18PM -0700, Jens Axboe wrote:
> +bool blk_stats_alloc_enable(struct request_queue *q)
> +{
> +	struct blk_rq_stat *poll_stat;
> +
> +	poll_stat = kcalloc(BLK_MQ_POLL_STATS_BKTS, sizeof(*poll_stat),
> +				GFP_ATOMIC);
> +	if (!poll_stat)
> +		return false;
> +
> +	if (cmpxchg(&q->poll_stat, poll_stat, NULL) != poll_stat) {
Isn't the logic inverted here? As we already check for non-NULL
q->poll_stat at the caller side, shouldn't it be:

if (cmpxchg(&q->poll_stat, NULL, poll_stat) != NULL) {

> +		kfree(poll_stat);
> +		return true;
> +	}
> +
> -- 
> 2.34.0
> 
Regards,
Pankaj
