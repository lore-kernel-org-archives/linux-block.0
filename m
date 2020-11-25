Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51BCDC5519F
	for <linux-block@archiver.kernel.org>; Wed, 25 Nov 2020 14:36:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92F742076B
	for <linux-block@archiver.kernel.org>; Wed, 25 Nov 2020 14:36:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m2HXHzoK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726039AbgKYOfv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 25 Nov 2020 09:35:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbgKYOfv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Nov 2020 09:35:51 -0500
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DDEBC0613D4;
        Wed, 25 Nov 2020 06:35:38 -0800 (PST)
Received: by mail-qt1-x841.google.com with SMTP id f93so1683434qtb.10;
        Wed, 25 Nov 2020 06:35:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=reNTeNG/1q9E3XRZxYxhrxLrmN7VsxS9FILrCza+ipo=;
        b=m2HXHzoKvxYKDjgyq+5pUDAcpClLc3BfX/qIzN20if7745eTDFerDR0caKiOx7uRnR
         WGxffUltH9CY49r6SZrdAjg90EtOHy3SGE4/kb9uq/v4qWphaPsEWmqK8rduNemIzjco
         TfLHtP+rAnfeEsqreqPrLwWvYuaGQ2j7lCUt+CVclgQwbRHmlU76PSVtNdevgcVDt0WB
         FltJo8P0hRyjFmSXmvE1QM/EvfhYHizh8Dihh9wIUbuzw2Ukdm2Rj8lI6XKTc8h+i3gA
         tuTc0XBmAYyva8WHr8AEfcSLJ+PFepJgRjCrMUS8tEZxtdHTwP5UBvmyZ7LOctqh9Gkf
         b8Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=reNTeNG/1q9E3XRZxYxhrxLrmN7VsxS9FILrCza+ipo=;
        b=Ex3IbIpNLQmZldgCrvNJ2jNSJvz3f/nRsR6iOFZH4RagiVaOa/6n5v45aux+OSCr7Z
         9Eys7gMIcyyywWAVeKmvlrFnV5ywhdHHXVXmx7C7c/c/mex/XvWkqpV+cF6XNCk/Ks1D
         Hac6xhN/vWZSn6MEfu8ZI/dGgluvsfdb2TPSLrk9e72+k8mgqB9Jjf6U+UlfAeJFBUWl
         +dQFanwo8zncSESmqFxT+hDtYO4WAMtDXHrAMizkRTnIO4oFb01LVsAGhflP0MpbHoVS
         itpR7tS2HgOlsB5FnCINKIIrxZzx+H/GAiVw5X+0Hl0lfVCTAPEMmPS8WsB61alTJdKW
         vrpA==
X-Gm-Message-State: AOAM532TGiaZ4L5w7RAwzhxT7hc1otdOW96RZKe4DXnT0N3tBgvMBG2g
        +M+T8862ErmP+b5TwquuVWrLYdU+k00Lbw==
X-Google-Smtp-Source: ABdhPJwRSi3iL7p1SgTF60+41gwUaBE4RvW0ugiRW+T/cP47KMjbG7ULpZHQkYBpVEwDFQ40GbfuQg==
X-Received: by 2002:ac8:5786:: with SMTP id v6mr3393457qta.268.1606314937177;
        Wed, 25 Nov 2020 06:35:37 -0800 (PST)
Received: from localhost (dhcp-6c-ae-f6-dc-d8-61.cpe.echoes.net. [72.28.8.195])
        by smtp.gmail.com with ESMTPSA id z19sm2558758qtu.51.2020.11.25.06.35.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 06:35:36 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 25 Nov 2020 09:35:13 -0500
From:   Tejun Heo <tj@kernel.org>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     axboe@kernel.dk, baolin.wang7@gmail.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/7] blk-iocost: Add a flag to indicate if need update hwi
Message-ID: <X75roagtWe3e96Y2@mtj.duckdns.org>
References: <cover.1606186717.git.baolin.wang@linux.alibaba.com>
 <beb9ab5875427431b58e1001e481b7a43e9188eb.1606186717.git.baolin.wang@linux.alibaba.com>
 <X75KuGR1MTovojZp@mtj.duckdns.org>
 <d0488a26-bff3-bd92-b5c7-74131161d55e@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d0488a26-bff3-bd92-b5c7-74131161d55e@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Nov 25, 2020 at 10:15:38PM +0800, Baolin Wang wrote:
> 
> > Hello,
> > 
> > On Tue, Nov 24, 2020 at 11:33:33AM +0800, Baolin Wang wrote:
> > > @@ -1445,7 +1447,8 @@ static void iocg_kick_waitq(struct ioc_gq *iocg, bool pay_debt,
> > >   	 * after the above debt payment.
> > >   	 */
> > >   	ctx.vbudget = vbudget;
> > > -	current_hweight(iocg, NULL, &ctx.hw_inuse);
> > > +	if (need_update_hwi)
> > > +		current_hweight(iocg, NULL, &ctx.hw_inuse);
> > 
> > So, if you look at the implementation of current_hweight(), it's
> > 
> > 1. If nothing has changed, read out the cached values.
> > 2. If something has changed, recalculate.
> 
> Yes, correct.
> 
> > 
> > and the "something changed" test is single memory read (most likely L1 hot
> > at this point) and testing for equality. IOW, the change you're suggesting
> > isn't much of an optimization. Maybe the compiler can do a somewhat better
> > job of arranging the code and it's a register load than memory load but
> > given that it's already a relatively cold wait path, this is unlikely to
> > make any actual difference. And that's how current_hweight() is meant to be
> > used.
> 
> What I want to avoid is the 'atomic_read(&ioc->hweight_gen)' in
> current_hweight(), cause this is not a register load and is always a memory
> load. But introducing a flag can be cached and more light than a memory
> load.
> 
> But after thinking more, I think we can just move the "current_hweight(iocg,
> NULL, &ctx.hw_inuse);" to the correct place without introducing new flag to
> optimize the code. How do you think the below code?

I don't find this discussion very meaningful. We're talking about
theoretical one memory load optimization in a path which likely isn't hot
enough for such difference to make any difference. If you can show that this
matters, please do. Otherwise, what are we doing?

Thanks.

-- 
tejun
