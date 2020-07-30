Return-Path: <SRS0=0pY0=BJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8B27C433DF
	for <linux-block@archiver.kernel.org>; Thu, 30 Jul 2020 14:14:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F3FC20842
	for <linux-block@archiver.kernel.org>; Thu, 30 Jul 2020 14:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596118448;
	bh=NbHLZf31GGPCGywTI9YMetN3AtIUrukVE0kwJ01c3qY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nqNYZGNa2QAhP8/AEqRa5TvsnJ4ExLYJs4KbKxFzAUp/AWH5bCgHbySUugDz+ocpx
	 jdqNZsQrpXV9rUWAXyQc3I7cR3pJVBI80q9At1pzKZ0hlDazseHnXQZPq0mrlOzAqE
	 cAEmvFJpOUlMuMfIgwq97238wcKuTbuzUSU9mDp8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729273AbgG3OOH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 Jul 2020 10:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729252AbgG3OOH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Jul 2020 10:14:07 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50D3EC061574;
        Thu, 30 Jul 2020 07:14:07 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id l13so6192880qvt.10;
        Thu, 30 Jul 2020 07:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1GfYkK7/x88dPSta57qjc35WTcVURqTk5ykRw4B7tRs=;
        b=aqLfRSJIgUYu9JS6xR32xAwjDb6+rBkvWTHYyoxS9ZpZ4SUlL+SYdcII49Ip9Yf7CA
         pllE5GHAS2zM91bOva74Ab+ZDJB8OfysW7TfskidPcAAxo5kccxxhhPyY9PV5UUxLNn1
         9NKNfg3tD3sKoIseu4rgSnxW+cjrrNGrW7QJUkU/zovJ2fgxO1ehXqFOYbzD3tlzurB1
         l6JbmmOC7IP8EyR/6wYIzcoD+w59RDR6kX2RhGfZSmf+uTA+FWBuCvBFVwX2NnUj8Rcm
         s8BWWezcZOwmTemeQeQZ8txA8rpg7Bz4VJE94DL08BC9Dl666N3K9F/SOTG+b16x4nP+
         IQTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=1GfYkK7/x88dPSta57qjc35WTcVURqTk5ykRw4B7tRs=;
        b=VdumjmViXBCSRo/lW5K9yKcSh0U6YgRI1veyR8YzFQlRaiVAnlxNqy5fyLfXW1vdw1
         unhryVYUFn6/Maxm1WFcOlMTCI88j8qgz5ydPnPguJsgZhoynx+1WAPfC2ReLTw2O6mn
         gs4ZWvmTbv/Oq46xcYch16T44HEefawWAaExweJn4s0BTzZDr/KAg8jLR+Se3Ir8YCjp
         ycTb83brToL0PyiOIYrbagJ1pi8VuA9ct3n2dAbEPvJVY86zQLlLqPPjJN2UpXP1f/Lm
         Gp4pFIyKKK0yWEV7+j9wZi67ORpRo3lOZ9EHqm52C4QPvsay2yskE9jAmploPRZSuM9I
         zrag==
X-Gm-Message-State: AOAM5324YuNMF65BcTG7e90mBBJPBSIIU/VhOfuXhQpT3/Yt9gBiO9H8
        0Y5mnUxn7mQc5MYWq6lG/xCF1t7Nw9I=
X-Google-Smtp-Source: ABdhPJza5cdd/JllkSeePgWZUtYrkYwWysIydxYTzkhTwHxYPW3DDxz4idf7kabQyApRfR97v++kBg==
X-Received: by 2002:a0c:fde4:: with SMTP id m4mr2979870qvu.97.1596118446244;
        Thu, 30 Jul 2020 07:14:06 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:115b])
        by smtp.gmail.com with ESMTPSA id h144sm4091990qke.83.2020.07.30.07.14.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2020 07:14:05 -0700 (PDT)
Date:   Thu, 30 Jul 2020 10:14:04 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iocost: Fix check condition of iocg abs_vdebt
Message-ID: <20200730141404.GA4601@mtj.duckdns.org>
References: <20200730090321.38781-1-zhouchengming@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200730090321.38781-1-zhouchengming@bytedance.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

On Thu, Jul 30, 2020 at 05:03:21PM +0800, Chengming Zhou wrote:
> We shouldn't skip iocg when its abs_vdebt is not zero.
> 
> Fixes: 0b80f9866e6b ("iocost: protect iocg->abs_vdebt with
> iocg->waitq.lock")
> 
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>

  Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
