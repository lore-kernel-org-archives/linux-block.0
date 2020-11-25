Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 524F7C56202
	for <linux-block@archiver.kernel.org>; Wed, 25 Nov 2020 12:15:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAD96206F7
	for <linux-block@archiver.kernel.org>; Wed, 25 Nov 2020 12:15:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LtVLo7FB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725836AbgKYMPM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 25 Nov 2020 07:15:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbgKYMPM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Nov 2020 07:15:12 -0500
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7C31C0613D4;
        Wed, 25 Nov 2020 04:15:11 -0800 (PST)
Received: by mail-qt1-x841.google.com with SMTP id z3so1376731qtw.9;
        Wed, 25 Nov 2020 04:15:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EZlDSKDcRH0cr+Xh/ErSPkHWLWrA/7jrLt62BycBYUQ=;
        b=LtVLo7FBjG+J3X0AeEFpAhyarHI6eblzmlW2FGdIHHRb0ihqMxJTIln9M6PXPr7KKx
         WyCWd5qsgTE5Y06MIvEScL6JxKf8s5AO1iK3JTkO9xpcFkwN3CP1HpC0SDH/bpaidJdt
         vJw2kVI03fV90IqH6LYgRG5hQjyiPcYhNevBsff8XXucTCJRiTBI+G43zVGLs7u3P1e8
         4c0k73oI6FQN1KXInQ6LjucGewYvQg8OrD0v+VtDFJ31sUJruxSPVYk52bnyXQX7AwIa
         V2bzJ5OrerGhYSKVRBe7RNaTg7kImfn/zTMSrG2ROjJQKlBgwp5zZ+cV9noXtaDCNyvd
         6oKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=EZlDSKDcRH0cr+Xh/ErSPkHWLWrA/7jrLt62BycBYUQ=;
        b=oIzw2quuqiq3p6Z3RBSI5ySnlsFH938noX4lo3EmTODvyrvfKu1mlA1Bikoj4B/AAM
         i87lzE5OrwKo5Ge0FeEHgI09074yVprg3fZ/0ZPtrlFpwCQ8IddhIORJkITanb4FHDON
         k4tFbi2ENg01WUlBfkf7ULI3TmyMGU3mhqweYRi/s60GJWB1Rv7PNLWL3OjFpLPjKS2H
         HWdr5+IcIuvKWeXl51NG1s87cEKMvcyi6KN+JK4bEDfxfcMx+HOD/y9JJa0Bzdc7pLjG
         q5oLH2LwsyM11IIWANburjhqcILh3L5rVkQ1MQUFsuSruBRq8WluVNzu74DiUuq05CoT
         qvUQ==
X-Gm-Message-State: AOAM532GlMmnPONRBeiqo0plqBxcB8/qTRDAdPYFOJKPCAlOEwUiGN1W
        dAwo8vk9OVFDgBA9TpQ+UN7MMjPgzUMPXg==
X-Google-Smtp-Source: ABdhPJw8HlIPvu6vlcBauGigcp/D57iV//gvUhOI7qWLrAn4V9ZGvkH9R95YHlr8tWIOxM5FTs8VyQ==
X-Received: by 2002:ac8:4708:: with SMTP id f8mr2687816qtp.376.1606306510932;
        Wed, 25 Nov 2020 04:15:10 -0800 (PST)
Received: from localhost (dhcp-6c-ae-f6-dc-d8-61.cpe.echoes.net. [72.28.8.195])
        by smtp.gmail.com with ESMTPSA id i7sm2093658qkl.94.2020.11.25.04.15.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 04:15:10 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 25 Nov 2020 07:14:48 -0500
From:   Tejun Heo <tj@kernel.org>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     axboe@kernel.dk, baolin.wang7@gmail.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/7] blk-iocost: Add a flag to indicate if need update hwi
Message-ID: <X75KuGR1MTovojZp@mtj.duckdns.org>
References: <cover.1606186717.git.baolin.wang@linux.alibaba.com>
 <beb9ab5875427431b58e1001e481b7a43e9188eb.1606186717.git.baolin.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <beb9ab5875427431b58e1001e481b7a43e9188eb.1606186717.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

On Tue, Nov 24, 2020 at 11:33:33AM +0800, Baolin Wang wrote:
> @@ -1445,7 +1447,8 @@ static void iocg_kick_waitq(struct ioc_gq *iocg, bool pay_debt,
>  	 * after the above debt payment.
>  	 */
>  	ctx.vbudget = vbudget;
> -	current_hweight(iocg, NULL, &ctx.hw_inuse);
> +	if (need_update_hwi)
> +		current_hweight(iocg, NULL, &ctx.hw_inuse);

So, if you look at the implementation of current_hweight(), it's

1. If nothing has changed, read out the cached values.
2. If something has changed, recalculate.

and the "something changed" test is single memory read (most likely L1 hot
at this point) and testing for equality. IOW, the change you're suggesting
isn't much of an optimization. Maybe the compiler can do a somewhat better
job of arranging the code and it's a register load than memory load but
given that it's already a relatively cold wait path, this is unlikely to
make any actual difference. And that's how current_hweight() is meant to be
used.

So, I'm not sure this is an improvement. It increases complication without
actually gaining anything.

Thanks.

-- 
tejun
