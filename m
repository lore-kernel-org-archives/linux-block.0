Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48502C56202
	for <linux-block@archiver.kernel.org>; Wed, 25 Nov 2020 12:20:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E37B9206F7
	for <linux-block@archiver.kernel.org>; Wed, 25 Nov 2020 12:20:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lIoMv/m3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728900AbgKYMUJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 25 Nov 2020 07:20:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbgKYMUI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Nov 2020 07:20:08 -0500
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB1B3C0613D4;
        Wed, 25 Nov 2020 04:20:08 -0800 (PST)
Received: by mail-qt1-x841.google.com with SMTP id f93so1379585qtb.10;
        Wed, 25 Nov 2020 04:20:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=an/jJ9Rku2m0NqJB2xb52Vc8jeFzL41elSo1CJ3zhfo=;
        b=lIoMv/m3nzPitwyRrwrREDEROejhitkPv3aFT2D2jpgZpc3trqRv2eAu3zKJvqLfdE
         NYA7TQrix2E1AEw/fRzdgM1FBUXV8Y5VHnBOXanTxWTqTr9u41Nu2wFrc9Zavk5n/ngF
         SwFEN8UR2dYHE0hFbrce93aHrRQvIQ+NLIt8ah00uF+R+fSBZeBGq4eZhDh0r6qpLfmW
         PDVdoowY9ejEhW916QSYsTGMIyQwp2yJPGSwsVY07r3C36tK03jPaIXer881mXo+Ysmb
         xpMHqy/ztwRuFHjxfDomFY3k1bybfCfxcHUNIajpYmbqm0usFbsOt12jWXFa0Ol5RV50
         XMdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=an/jJ9Rku2m0NqJB2xb52Vc8jeFzL41elSo1CJ3zhfo=;
        b=XBTOe9zwxiwJ3eL8T48hZkiKWTPkDKL4Mg5wP+JmV5ez5WXGUAYM5x3os4aNk8Bv0S
         jja3m1+IatX3SMjVLIl4M8lfMmwfC8eLhSMgRwKjZODsXvWG/i6qwFzXVidAwsBpMRvV
         4tDEOjbsDGE+GtdHV5wOsPD7TZk0mFbNxpJs9hgkarMfufPXjsXvkKJHqS/1/2pklDLy
         Chr1Fm7qbUC3MS482FLHayVFuT21/956x0FG2HoHxXYsd1k7FEAx05xKfXPjakJc7S5+
         fqIsGhM0pLXHFdCH7EgpiRCHjEvWgGhtc4OJi4cF+D7RV7eKURT0vjBngyFLiDJZuCFO
         aoIg==
X-Gm-Message-State: AOAM533x+TsjUiH4wPuNU3VrC2D/vlIZ0pMT9j1UIrOssHPFcg4piEd1
        m9yG2OnIDzt5qmxwdX9eITtGKyJ1SG3CZw==
X-Google-Smtp-Source: ABdhPJzL4u77kOEb9WpRYIKrAKJJF0Zlj1TZIbzykpt+aWgrqRnwWPZMOz8Fkk9+uRWCxKWbkS+ZYA==
X-Received: by 2002:aed:2664:: with SMTP id z91mr2736206qtc.290.1606306807869;
        Wed, 25 Nov 2020 04:20:07 -0800 (PST)
Received: from localhost (dhcp-6c-ae-f6-dc-d8-61.cpe.echoes.net. [72.28.8.195])
        by smtp.gmail.com with ESMTPSA id e126sm2350330qkb.90.2020.11.25.04.20.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 04:20:07 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 25 Nov 2020 07:19:43 -0500
From:   Tejun Heo <tj@kernel.org>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     axboe@kernel.dk, baolin.wang7@gmail.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/7] blk-iocost: Move the usage ratio calculation to the
 correct place
Message-ID: <X75L39ZY3GQ+eL0B@mtj.duckdns.org>
References: <cover.1606186717.git.baolin.wang@linux.alibaba.com>
 <89a6e1223944e96e0e5e001191d87dd8079345c8.1606186717.git.baolin.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89a6e1223944e96e0e5e001191d87dd8079345c8.1606186717.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,
> @@ -2225,6 +2207,25 @@ static void ioc_timer_fn(struct timer_list *timer)
>  		     time_before64(vtime, now.vnow - ioc->margins.low))) {
>  			u32 hwa, old_hwi, hwm, new_hwi;
>  
> +			if (vdone != vtime) {
> +				u64 inflight_us = DIV64_U64_ROUND_UP(
> +					cost_to_abs_cost(vtime - vdone, hw_inuse),
> +					ioc->vtime_base_rate);
> +
> +				usage_us = max(usage_us, inflight_us);
> +			}
> +
> +			/* convert to hweight based usage ratio */
> +			if (time_after64(iocg->activated_at, ioc->period_at))
> +				usage_dur = max_t(u64, now.now - iocg->activated_at, 1);
> +			else
> +				usage_dur = max_t(u64, now.now - ioc->period_at, 1);
> +
> +			usage = clamp_t(u32,
> +				DIV64_U64_ROUND_UP(usage_us * WEIGHT_ONE,
> +						   usage_dur),
> +				1, WEIGHT_ONE);

Can you please move the variable declarations inside the block together with
the code?

Thanks.

-- 
tejun
