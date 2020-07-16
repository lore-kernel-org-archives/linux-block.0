Return-Path: <SRS0=Ci6H=A3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5BB5C433E1
	for <linux-block@archiver.kernel.org>; Thu, 16 Jul 2020 15:02:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B605B207BC
	for <linux-block@archiver.kernel.org>; Thu, 16 Jul 2020 15:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594911733;
	bh=QbJqBAP7rcQYyDE1vaHmnGGov8C2i1dDSnBVzXmx0Zw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kyIRf3R1OD0UIxqcowfyseyva8RE30dGsQkoi1mLiHR2yu1B9xpq8ln4Ao3Bp2uMn
	 FFamijH9NPcXQeYcictlRDUXGSXACdoSH2z3pnRsnze+WuRMfpJq6aTJluTVPDhEfJ
	 oOqrPnGlXkXdQtwcWSsOaEhzd6/dtuoKtwszAAIE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728150AbgGPPCN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Jul 2020 11:02:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726963AbgGPPCM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Jul 2020 11:02:12 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92466C061755
        for <linux-block@vger.kernel.org>; Thu, 16 Jul 2020 08:02:12 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id b25so5122264qto.2
        for <linux-block@vger.kernel.org>; Thu, 16 Jul 2020 08:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=g0Gc3G/Vqo0KrUXaVlb/Ytdg/J+kCQlsBfosR9cHE80=;
        b=fyKz1YEoYaf/ZgqdEDlkDPGf3PfH/z1N0+OMcTbOKEB6Fg0hmy1Zdtw3XNFHZDEyO/
         lxLyL0H/OawHEhBvT6M2ztmxjgQdGjDnfXAIeTdPr2OmqCudaAPUgQwXl4Y49sk6e9Gp
         sok1M3FeuWiL+jS+mpboj5aG5W44DYxik6vm0qKpoNGGK5CfJJy+kFwm55ikD1ML1xIV
         g0NzDMr1+lwCiNg0xXErZUeimimhgpg/mC/u2BA7rKgPEwXulmrL6v3WdFfpoyMT8wG6
         X7hIyI7wjpoGbvi6/LSDHGdEucakDrL4pqTY9FvgZyDLNGI5KT6RCEm7DuBGUKUaGLqM
         QYKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=g0Gc3G/Vqo0KrUXaVlb/Ytdg/J+kCQlsBfosR9cHE80=;
        b=WscCfs3yxs48s1rwBf2ufF0aDTuDfR5EfHNuc70eaNKIlfR9B+CkrCVrCWGiiktWwI
         8RWSitqe3/hev9e9yKJzFJvjXJLMZeFED1cfS06ESL7eJJEWkZQEXRm5vd4BmRVybC0h
         bt/vJHy66o+VqzEztpQ405C/y+WwFJVvpVaRthVLQurnHBOo14ufoy0be6DF/BqwIRDT
         bltpTxo91nXA7P+HnkFy0AQo5oUbWRO34tcjtnOsirSjd0vCDrODUQdkPsqJICFI+1Ya
         CrOHfacpZAaXsltDeUhuDm4wJsrUnJYHDoUQ4RKOoKwH5I2h6swG1B1VUM3vjdN2vi8Q
         8mVw==
X-Gm-Message-State: AOAM5305U9tbN8bTpoivhVWnSiwAxg/jsG44ekqZO4Cqw75ZG4Qp3oS+
        qNjhfEeya/z8K8CT4L1n+bJqA6KVpIg=
X-Google-Smtp-Source: ABdhPJwK/M+QDasq9BGtISUGVQuMPapbpXh3p2UNQ5TmH4VAIYDmhcRpD5OT96AOXzCIsP1JONOt9w==
X-Received: by 2002:ac8:6f7a:: with SMTP id u26mr5616351qtv.33.1594911731611;
        Thu, 16 Jul 2020 08:02:11 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:3423])
        by smtp.gmail.com with ESMTPSA id o5sm8373297qtb.26.2020.07.16.08.02.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 08:02:10 -0700 (PDT)
Date:   Thu, 16 Jul 2020 11:02:09 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 4/4] block: integrate bd_start_claiming into __blkdev_get
Message-ID: <20200716150209.GC135797@mtj.thefacebook.com>
References: <20200716143310.473136-1-hch@lst.de>
 <20200716143310.473136-5-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200716143310.473136-5-hch@lst.de>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jul 16, 2020 at 04:33:10PM +0200, Christoph Hellwig wrote:
> bd_start_claiming duplicates a lot of the work done in __blkdev_get.
> Integrate the two functions to avoid the duplicate work, and to do the
> right thing for the md -ERESTARTSYS corner case.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

For 3 and 4,

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
