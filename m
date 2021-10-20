Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FAC7C433F5
	for <linux-block@archiver.kernel.org>; Wed, 20 Oct 2021 20:10:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78B45610E7
	for <linux-block@archiver.kernel.org>; Wed, 20 Oct 2021 20:10:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231695AbhJTUMZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Oct 2021 16:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231676AbhJTUMY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Oct 2021 16:12:24 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E2CAC06161C;
        Wed, 20 Oct 2021 13:10:10 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id t11so16912186plq.11;
        Wed, 20 Oct 2021 13:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=K05jLGVYT1OOWM9LHHmc8HLRdEchhFT9XiRJZyZVkUM=;
        b=Ra0L6ar+M6OhF0xiUFZ/Ji9TADTNtKaeoKk+nFnNbn7yLclr75DgYOY+QlmUKB0OJ6
         aSiPRvE7KiaCjCPZSQsb3joeq+UlPGd5LeIoHgu0ZgOiaqsu1YyAzOtvq9cOYEauuBJZ
         pQNk3wEpDfSDO2ko/Qs4cH7ls81KdWungwWK4o32tnUwz3ThInbudxi0JM1j2hBmgm0s
         AnuiEbGynXzew3/rnB50dtsKkzYls9P3caOaxJT3J70k+cjlWxMhOp+hc0a1lkDnMQCB
         0hskEPan9zAon0a2IE31Z00CCgIf30GtCcXjRguzUBqw39HlOP90OfHjbzI4qzW5y5t2
         RdxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=K05jLGVYT1OOWM9LHHmc8HLRdEchhFT9XiRJZyZVkUM=;
        b=XOo/TuUtyJAU/fIbUBMQolS2v6PMYEdQyA5YZRpeYUi1qzNRqahBCRgY14ZHEVFmnn
         pswtM0cV25p+f+7GbyhVpXGda4rOcSb4w7bhQFqbMsQMy9/IG+Dg7UltczdhP5+HjSvh
         YuRzSbCdZQYMQC0sIpENiobwlS461nxdjpXWMce/pbDuihjhUUFMrYoeXylW+S9MpDdi
         /Hc12r3O8P5UOZ+P94JASk1LUcO3AmNupEDTXeVGTbAiL9cDlO7/MMijmRaGbJtMtes7
         Hie+2Lt4kjIbMQhFEX5nEhzBjxLPAd9lT69tI1hzRa1bwJPHw/jI0Dv0fm4kE8KgVT6j
         KJ7w==
X-Gm-Message-State: AOAM531SaMSFs4lghpTLy0Cv/OFw5XwbCmWTj081kV1pPtc/DV2r3oHJ
        KIazxnlFGxiw7khx2MNkibk=
X-Google-Smtp-Source: ABdhPJzhssuFfJh1tqLMWgVA1PKfZZg9vQJ8ENfJfh2ZBtEh4x+sD/6rOJeuPMCybJNr97N6NqIHUQ==
X-Received: by 2002:a17:902:d50f:b0:13f:ac51:29b4 with SMTP id b15-20020a170902d50f00b0013fac5129b4mr1025549plg.51.1634760609567;
        Wed, 20 Oct 2021 13:10:09 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id q16sm4118338pfu.36.2021.10.20.13.10.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 13:10:09 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 20 Oct 2021 10:10:07 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Pavel Begunkov <asml.silence@gmail.com>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Christoph Lameter <cl@linux.com>,
        Dennis Zhou <dennis@kernel.org>
Subject: Re: [PATCH 1/2] percpu_ref: percpu_ref_tryget_live() version holding
 RCU
Message-ID: <YXB3n2pxiKYbd2Il@slm.duckdns.org>
References: <cover.1634759754.git.asml.silence@gmail.com>
 <d65d6d60faf773293e5189bd2b95c7bbc034976b.1634759754.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d65d6d60faf773293e5189bd2b95c7bbc034976b.1634759754.git.asml.silence@gmail.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Oct 20, 2021 at 09:03:18PM +0100, Pavel Begunkov wrote:
> +/**
> + * percpu_ref_tryget_live_rcu - same as percpu_ref_tryget_live() but the
> + * caller is responsible for taking RCU.
> + *
> + * This function is safe to call as long as @ref is between init and exit.
> + */
> +static inline bool percpu_ref_tryget_live_rcu(struct percpu_ref *ref)
> +{
> +	unsigned long __percpu *percpu_count;
> +	bool ret = false;
> +
> +	if (likely(__ref_is_percpu(ref, &percpu_count))) {
> +		this_cpu_inc(*percpu_count);
> +		ret = true;
> +	} else if (!(ref->percpu_count_ptr & __PERCPU_REF_DEAD)) {
> +		ret = atomic_long_inc_not_zero(&ref->data->count);
> +	}
> +	return ret;
> +}

Can we please add rcu_read_lock_held() assertion? Other than that, looks
fine to me.

Thanks.

-- 
tejun
