Return-Path: <SRS0=uCqz=BO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7DFFC433DF
	for <linux-block@archiver.kernel.org>; Tue,  4 Aug 2020 14:24:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A887D22BED
	for <linux-block@archiver.kernel.org>; Tue,  4 Aug 2020 14:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596551057;
	bh=5Z8Kopbxi7aEpHCihK5wFEwoJps5FrOJMRK80kP90m0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WnFVsnQNPDIQYs3r1T3eCPWBQtrGjfCdHd31j6hcVdjYwOjeqPF23KHyy63u0Wni1
	 nngwRlSISIVGyoUOLMSulr95cqnPPzd6Qwq108KQ82iPie7/+aiHmbm21lGQklBgnL
	 Kimn7GHjy4CjijwSNQw9/R+Ji5RTPNt9aatezH2o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728962AbgHDOYQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Aug 2020 10:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728948AbgHDOYM (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Aug 2020 10:24:12 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 324ABC06174A;
        Tue,  4 Aug 2020 07:24:12 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id q128so6152343qkd.2;
        Tue, 04 Aug 2020 07:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dd6Yl/t8idEhFl//6BuOYRHIHDUL8327gbR9zAH7VII=;
        b=PbNtTay4aqskHx+9NdhxFZehseF/nhdVcF1l3LZK2X9Y8rjBIVIVTDfdX8+RRTLJeA
         BEn0NuZaG0ByYr4U3wvLnPB7jioK1XTMQ6VXC8FaMiqEl/YUDMz+n+HkmOx+vfb2ERLw
         Bsxz656teytYovIbCIZhVSQF7E27WRL1BclCtwCXKXV7OUnCwsJgfbtH0opD9dyDoQds
         vce0WCBMuT6d7fOOWazK3E9sDVc/K0ofrF2lx5G9fO6IrKNQzDrFaybad62VDPcb2zjT
         RhgOjhM/0TMCDzmyYDzb4id3XkOqE5xdYWcc82BnHGJTZwGPT5MiRm+LLr7Xlvhzjl6W
         F0wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=dd6Yl/t8idEhFl//6BuOYRHIHDUL8327gbR9zAH7VII=;
        b=jMbijD4ZNTudqGrRuyjSUvjfBhcocYkX+HG/OPkLDYaPr8HvPlRSXXsZA5GMTx0nX5
         ph9fIji7S/teC8B4AtgaQsYzPddvVbFFuFqM+s+n5b9QjUQSKTn0SrEBXNMCYOVEE3J2
         f/iKdYYfcTPEjqvTVSLe0uvjTKe0jHaqRO0p/LRuwNzTwa2CGMHIvuY9WTjGeDlsV2Iv
         Tj+Rxdjaw+fOhe0OEwUdHHnap38Q7KW9q3kebi4NUJeaojvRpTBmk2kye9lN/3A6HrrR
         l9CZAxLeAd1bQVqC7XweWCOHgvG7u2kkyTYQSxIgRe9hWSbgBMwnA0FU9x6HFd6bNyIC
         opHA==
X-Gm-Message-State: AOAM530k5Btlehzp8TbnWqprwPFrGbgwJPzvu/i3WHXXDUedJ9sSPamv
        0T9Cts1PhxOATGS3esqomuw=
X-Google-Smtp-Source: ABdhPJzQmpUK1CGTt/9F7/7OOwbjOHmbsjZjrMdamoMxD7JzhRhkXt/EzrnWxr2DlJs+sh5kwNLiNw==
X-Received: by 2002:a37:614:: with SMTP id 20mr20958000qkg.456.1596551051224;
        Tue, 04 Aug 2020 07:24:11 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:d024])
        by smtp.gmail.com with ESMTPSA id d8sm25642978qtr.12.2020.08.04.07.24.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2020 07:24:10 -0700 (PDT)
Date:   Tue, 4 Aug 2020 10:24:09 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iocost: Only inc nr_shortages when have io waited
Message-ID: <20200804142409.GB4819@mtj.thefacebook.com>
References: <20200801170021.76756-1-zhouchengming@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200801170021.76756-1-zhouchengming@bytedance.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Aug 02, 2020 at 01:00:21AM +0800, Chengming Zhou wrote:
> The last else branch of current code may have not io waited in iocg,
> in which case we should not inc nr_shortages, or the device vrate
> will speed up even this iocg is not shortage of vtime.
> 
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> ---
>  block/blk-iocost.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block/blk-iocost.c b/block/blk-iocost.c
> index 86ba6fd254e1..ce68b5749364 100644
> --- a/block/blk-iocost.c
> +++ b/block/blk-iocost.c
> @@ -1485,7 +1485,7 @@ static void ioc_timer_fn(struct timer_list *timer)
>  				__propagate_active_weight(iocg, iocg->weight,
>  							  new_inuse);
>  			}
> -		} else {
> +		} else if (waitqueue_active(&iocg->waitq)) {

This is intentional. Shortage doesn't necessarily mean that there are
waiters right now. If there are cgroups which don't have enough headroom to
donate and the device is hitting the latency targets, it makes sense to ramp
up vrate as those cgroups are likely to get throttled.

Thanks.

-- 
tejun
