Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7DABC4338F
	for <linux-block@archiver.kernel.org>; Mon,  9 Aug 2021 22:41:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8DB160EBC
	for <linux-block@archiver.kernel.org>; Mon,  9 Aug 2021 22:41:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234302AbhHIWlU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Aug 2021 18:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbhHIWlT (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Aug 2021 18:41:19 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCC45C0613D3
        for <linux-block@vger.kernel.org>; Mon,  9 Aug 2021 15:40:58 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id w13-20020a17090aea0db029017897a5f7bcso2298370pjy.5
        for <linux-block@vger.kernel.org>; Mon, 09 Aug 2021 15:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=y9xrCk9u2jkY7NWY7immUEbVW22Hh5Be4yHQKyXQJVA=;
        b=iq5SO2GuJbiULj/09SCHOfA9j0JvNzLjOfxr3LQwrWvUNNxwrcjrJ5mrLSBh3giziZ
         IKiJTqRdd0mCF7p/BrxbhdV+7y+mBD/h/hEttysr7v/9tx68t3y5z0cYqz2ZJsorf1ra
         Z5h4f1XZhG+bj301DBmdrUkHhv2ku4NuCd+qvK4rSki6lPfHnS25NOZvseu/iSQYYo68
         a+r6xyFRNGho+XLCcwSdO6Rry+Ph4BGOj1n5TsvVpbKz9RdsNymrMedD5a5WxdgqEt69
         iyMUIV0S8gyWbT82kVZLeNEMauWz18lue3v22GEZqb+/lbpjdaVwQt2wa6nDgkDqGKKr
         LN/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=y9xrCk9u2jkY7NWY7immUEbVW22Hh5Be4yHQKyXQJVA=;
        b=djfG1Jj1NDXB72uiw1hPXIvFtClgb1N55tKxQZ5hgsvMVFWNEaMk3P09kC6F/iG2o2
         nVQMBS2LdD2Ek+rMXWF0afWiSzcH7mLKLRJcz5TexjPHEOq2ogng56pkhyHpTVd5iCKG
         YxAOgD1WJcno2iYZ2XNGbSQZJM+XQ+wAQ7+nFNPkTsN9wezc5b/qF4qpSelxcf4p7+Ju
         XMnVQW3dd4VrgTKQOySgpQKAbLvPEQo0SfiV5IPtJulvyd7ETw61lhNAkQ15evTEn9ke
         tqdo+HViaUW4uhSXDK7kMvtvOdGiJsnOYZYAIIrLqW6Bpa2rD2x4H17APmhPQfUVBp19
         /qzA==
X-Gm-Message-State: AOAM530TDcNYzBpgcDqGnM0XTjgv6VRr0kaElER1258puPSRca6ayW30
        0yXB5JKSLWu4op9VHYCMmmY=
X-Google-Smtp-Source: ABdhPJwppQhZQzMpvlshfBgh9N3NudbWnbeKkcXoy7FBpWuvCFhkeulJKX5MsMyBz8yHzvdd7kmMCg==
X-Received: by 2002:a17:90a:428e:: with SMTP id p14mr1455425pjg.92.1628548858425;
        Mon, 09 Aug 2021 15:40:58 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:df1c])
        by smtp.gmail.com with ESMTPSA id h7sm19633141pjs.38.2021.08.09.15.40.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Aug 2021 15:40:57 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 9 Aug 2021 12:40:53 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Bruno Goncalves <bgoncalv@redhat.com>
Subject: Re: [PATCH] blk-iocost: fix lockdep warning on blkcg->lock
Message-ID: <YRGu9YS0M/4zPfUz@mtj.duckdns.org>
References: <20210803070608.1766400-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210803070608.1766400-1-ming.lei@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Aug 03, 2021 at 03:06:08PM +0800, Ming Lei wrote:
> blkcg->lock depends on q->queue_lock which may depend on another driver
> lock required in irq context, one example is dm-thin:
> 
> 	Chain exists of:
> 	  &pool->lock#3 --> &q->queue_lock --> &blkcg->lock
> 
> 	 Possible interrupt unsafe locking scenario:
> 
> 	       CPU0                    CPU1
> 	       ----                    ----
> 	  lock(&blkcg->lock);
> 	                               local_irq_disable();
> 	                               lock(&pool->lock#3);
> 	                               lock(&q->queue_lock);
> 	  <Interrupt>
> 	    lock(&pool->lock#3);
> 
> Fix the issue by using spin_lock_irq(&blkcg->lock) in ioc_weight_write().
> 
> Cc: Tejun Heo <tj@kernel.org>
> Reported-by: Bruno Goncalves <bgoncalv@redhat.com>
> Link: https://lore.kernel.org/linux-block/CA+QYu4rzz6079ighEanS3Qq_Dmnczcf45ZoJoHKVLVATTo1e4Q@mail.gmail.com/T/#u
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
