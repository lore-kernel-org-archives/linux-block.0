Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC63CC6FA82
	for <linux-block@archiver.kernel.org>; Mon, 26 Sep 2022 21:18:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231388AbiIZVSo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 26 Sep 2022 17:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiIZVSn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Sep 2022 17:18:43 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E7F79259C
        for <linux-block@vger.kernel.org>; Mon, 26 Sep 2022 14:18:42 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id x15-20020a17090a294f00b00205d6bb3815so107402pjf.4
        for <linux-block@vger.kernel.org>; Mon, 26 Sep 2022 14:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date;
        bh=OxpwXUsO/lvx8mWt/A4Gkdmt9CMhw07y60CYDcr9qXE=;
        b=LdLXkfcXcBzjIdn3fXN2Dr78jXEMcd3FGX9wk9y+C0qjniyZE9XX9J1Ao/8CRqkdxF
         6inkL7TV85zggy4lH1iaxNbbjnQB58pDzNScW39pMJ1+9F/Hf0s8uFS7uHuoUMayTms1
         WaK2FasLipkwXV1qq6wRDekqI58zY7JLf2m2hm9Mx55QIZc1hOs0w0U/FUy+jtQWC9Dj
         R+Mm9aGXvmytndQiqXkWbaymqFY45B4AyTYkZ8k4q/AVy6/qGS2gnOS2/9650Mm8/rYm
         0T5/6iuIrfGMr2JKO9F/JiC/xPRuKMHzybTNoeLZo47KuYpVb/6omYs2LXn3A2DmCNB3
         jBug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date;
        bh=OxpwXUsO/lvx8mWt/A4Gkdmt9CMhw07y60CYDcr9qXE=;
        b=r5+fAvr5QG8gfRVCQHvR7ZZ13FWMN2Gulx4st14U/5rKicJ+FkZA4AnWFxta/q9DSw
         ZYcu2zW11ZiPSfzLW8RskKglrSW1MIm8b4HgO34I2TfExG1mbS8JY/oEAGEPUGD51fVp
         Rj1CNeF3kBsUJLScLcVXxzMFOooU03ceBhQy2gdxvqYJWcwX18LzFjrusMwAtjieKkUI
         KK12Ym4SH2N9+++Dm/a2OXwRnaQabu0NcpJ2WcwZ6rKfYXDhL3/F1Hz6C+aVFAGRGaDk
         4u9MP+oZcHohZM+Tfn1lOCC6aoUcNJX4w4EvEG4ATqOzuQlm9naXQyIwIDSz+3pnEgfK
         OaJQ==
X-Gm-Message-State: ACrzQf0sUIm9wRjcPJY7nku0lfWQJa3MToz6mIEMsjee+8hRczIILPRR
        EtCL7xWsmddOjErL6w4uslY=
X-Google-Smtp-Source: AMsMyM47e0p3ERuQxSKM3h1WuppRIz+Foi8dg8gqaFQDhs+DE2shAMW/YKHKSRQcnS4APgWaK+p6bg==
X-Received: by 2002:a17:90b:1d0f:b0:202:be3e:a14a with SMTP id on15-20020a17090b1d0f00b00202be3ea14amr772970pjb.102.1664227121537;
        Mon, 26 Sep 2022 14:18:41 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:a7e])
        by smtp.gmail.com with ESMTPSA id i3-20020aa796e3000000b00535da15a252sm12586657pfq.165.2022.09.26.14.18.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 14:18:40 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 26 Sep 2022 11:18:39 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 05/17] blk-cgroup: remove blkg_lookup_check
Message-ID: <YzIXL29l4+XI3ghZ@slm.duckdns.org>
References: <20220921180501.1539876-1-hch@lst.de>
 <20220921180501.1539876-6-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220921180501.1539876-6-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

On Wed, Sep 21, 2022 at 08:04:49PM +0200, Christoph Hellwig wrote:
> The combinations of an error check with an ERR_PTR return and a lookup
> with a NULL return leads to ugly handling of the return values in the
> callers.  Just open coding the check and the lookup is much simpler.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Tejun Heo <tj@kernel.org>

but please look below.

>  /**
>   * blkcg_conf_open_bdev - parse and open bdev for per-blkg config update
>   * @inputp: input string pointer
> @@ -697,14 +678,16 @@ int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
>  	rcu_read_lock();
>  	spin_lock_irq(&q->queue_lock);
>  
> -	blkg = blkg_lookup_check(blkcg, pol, q);
> -	if (IS_ERR(blkg)) {
> -		ret = PTR_ERR(blkg);
> +	if (!blkcg_policy_enabled(q, pol)) {
> +		ret = -EOPNOTSUPP;
>  		goto fail_unlock;
>  	}
>  
> -	if (blkg)
> +	blkg = blkg_lookup(blkcg, q);
> +	if (blkg) {
> +		blkg_update_hint(blkcg, blkg);
>  		goto success;
> +	}
>  
>  	/*
>  	 * Create blkgs walking down from blkcg_root to @blkcg, so that all
> @@ -740,14 +723,15 @@ int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
>  		rcu_read_lock();
>  		spin_lock_irq(&q->queue_lock);
>  
> -		blkg = blkg_lookup_check(pos, pol, q);
> -		if (IS_ERR(blkg)) {
> -			ret = PTR_ERR(blkg);
> +		if (!blkcg_policy_enabled(q, pol)) {
>  			blkg_free(new_blkg);
> +			ret = -EOPNOTSUPP;
>  			goto fail_preloaded;
>  		}
>  
> +		blkg = blkg_lookup(pos, q);
>  		if (blkg) {
> +			blkg_update_hint(pos, blkg);
>  			blkg_free(new_blkg);

I don't think conf_prep needs to update the hint in the first place, so we
can just do blkg_lookup()'s and drop the blkg_update_hint() calls.

Thanks.

-- 
tejun
