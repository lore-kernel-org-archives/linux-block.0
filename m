Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17CE2C5519F
	for <linux-block@archiver.kernel.org>; Wed, 25 Nov 2020 12:30:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AECD1206E5
	for <linux-block@archiver.kernel.org>; Wed, 25 Nov 2020 12:30:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ki2Wh4wk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727671AbgKYMaa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 25 Nov 2020 07:30:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbgKYMaa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Nov 2020 07:30:30 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DD54C0613D4;
        Wed, 25 Nov 2020 04:30:30 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id l2so4099391qkf.0;
        Wed, 25 Nov 2020 04:30:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=G4gfJ5n87gApo02hy9/dwTUFwwrHS+6s4TFWwUegUNE=;
        b=Ki2Wh4wkvNKr+dzZ7dU0Ab1o0uU5HtqOOlBzNujsRpqKfoPxjkj05njJj+CB1CWTv/
         +1wpo3GvivU18UhC2hjPQHupB95g1hx43YKT2THp5C2UXI4OpWInr0vrfcYAE9Tj0NDs
         UcRq6Kkj6xGIukbzkMq09mcy6fAX62+Fasxdtem6+mjCtLkXRbiueIF0uJpOFzQUJCKj
         G5AokJmkmafbpbQsRpxYY78nXQkMwsxG1pZPrxKHoFcAmvOkAQIKWbtL7YRVX3PZ/4AH
         WybpA2CLJd8Y1UK4jjIWiV9B2RVwyyqBf1rbDqMlvjmWvep6n39U6Tmyj1HBPqiLu9ZR
         4Urw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=G4gfJ5n87gApo02hy9/dwTUFwwrHS+6s4TFWwUegUNE=;
        b=YHGhmMe+bvtOg/qdy9hzShBdOELLMpUaoAWzWp5XL7skUVBgGAemcKhT5W0mexccxf
         hkVIfpC9cgVZlmqobwdF1OLz20oprjjBKP9QK4gRIZYOZGLS9v7COHqT00+VyJ4Rdnnl
         K3mJVMHokpwkB7NT3p9x6FviaWnO9r+p3g9OLrK3+uGgBfkJggGLMeWie9jJCHU3Cxaz
         tk7rRJMNJhVnWgnoKS4HYAN3yHn1sDHWuE0v9YyDhNpa0PBiR62HNaLLd1E3ujwQ41av
         ZCovKwaXR3bhPqyTLD7Yi3Il4FKnIFyxLinypXtDdZsQcwXIhGILpn9CSdwQs/4Z3aCW
         Flbw==
X-Gm-Message-State: AOAM530Ej4WiHWKkRNrG9EA/Zr2k7iFlhjMeoKt5PsrA1NkmtXJLvGNF
        xvo3zwi8WLrTEK1MzI4bBxc=
X-Google-Smtp-Source: ABdhPJyRbjDwdok/+MeSx4qHVbvTsEmbd7uXYSQcq0X9BEEiScO16eN8deeZ3gXwrhWQTseAWJXoBg==
X-Received: by 2002:a37:ba82:: with SMTP id k124mr2944940qkf.25.1606307429612;
        Wed, 25 Nov 2020 04:30:29 -0800 (PST)
Received: from localhost (dhcp-6c-ae-f6-dc-d8-61.cpe.echoes.net. [72.28.8.195])
        by smtp.gmail.com with ESMTPSA id 61sm2167065qta.37.2020.11.25.04.30.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 04:30:28 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 25 Nov 2020 07:30:06 -0500
From:   Tejun Heo <tj@kernel.org>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     axboe@kernel.dk, baolin.wang7@gmail.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/7] blk-iocost: Factor out the base vrate change into a
 separate function
Message-ID: <X75OTmArk6X1pnV6@mtj.duckdns.org>
References: <cover.1606186717.git.baolin.wang@linux.alibaba.com>
 <f58ff36d7e24716994f2de22be461602fb49b6d5.1606186717.git.baolin.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f58ff36d7e24716994f2de22be461602fb49b6d5.1606186717.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

On Tue, Nov 24, 2020 at 11:33:36AM +0800, Baolin Wang wrote:
> @@ -2320,45 +2358,11 @@ static void ioc_timer_fn(struct timer_list *timer)
>  	ioc->busy_level = clamp(ioc->busy_level, -1000, 1000);
>  
>  	if (ioc->busy_level > 0 || (ioc->busy_level < 0 && !nr_lagging)) {
> -		u64 vrate = ioc->vtime_base_rate;
> -		u64 vrate_min = ioc->vrate_min, vrate_max = ioc->vrate_max;
...
> +		trace_iocost_ioc_vrate_adj(ioc, ioc->vtime_base_rate,
> +					   missed_ppm, rq_wait_pct,
>  					   nr_lagging, nr_shortages);
> -
> -		ioc->vtime_base_rate = vrate;
> -		ioc_refresh_margins(ioc);
>  	} else if (ioc->busy_level != prev_busy_level || nr_lagging) {
>  		trace_iocost_ioc_vrate_adj(ioc, atomic64_read(&ioc->vtime_rate),
>  					   missed_ppm, rq_wait_pct, nr_lagging,

I think it'd be better to factor out the surrounding if/else block together
(as early exit if blocks). Also, how about ioc_adjust_base_vrate()?

Thanks.

-- 
tejun
