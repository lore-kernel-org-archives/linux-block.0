Return-Path: <SRS0=Yhvv=DH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2731AC4727C
	for <linux-block@archiver.kernel.org>; Wed, 30 Sep 2020 16:00:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8FFE20789
	for <linux-block@archiver.kernel.org>; Wed, 30 Sep 2020 16:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601481619;
	bh=ZqhtMIKTTegEwEa09unkOyug9cyUrZOQgyVAD9TWxNM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=EjSt+Ly+iF7pw6v+Fa40VeUBZbRLVLmc2nRfFAJfTafflw7h4FtuboSLJpzL9NQc9
	 tuVc8xt9qTuS3R7tarYxroyzx6q5+k1DzNrcSVVke20XPm3vc5k0emqntBvFek0dBW
	 tUbPRipdYhTHRUPbqFOtc7YJ9p44/mvPvhKwOcBg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725837AbgI3QAT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 30 Sep 2020 12:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbgI3QAS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Sep 2020 12:00:18 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A16EEC061755;
        Wed, 30 Sep 2020 09:00:18 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id 16so1909036qkf.4;
        Wed, 30 Sep 2020 09:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zQMyHMOAK54x4+Uu0bs0SlOT+nNZwBpL0SWANYBUJNg=;
        b=YytXHlNdF+nbBmCq922bGTx4NeGtuVVvY0yg/maoWqaaDDRj/imxKF2PG5hh9u2Xsw
         XF1bMUz5hBGqcNlt/j6mHy/mF3DU4lGpiJwe1E1ahrQaE2m8imRLe/8qmebaC2mXDxS9
         gjnbKivF6byMitg0ctKj66DFD6v1giHWLpBRNINxz2tw0EuNCpw7Gj/1HMnKtKsbtCMt
         0egzRG3ZhRJJSUo5G6enKYYg9zHgk6sDmYmpqu7Fz/5YbDi4z/zAV9p2njge7DLSF4hN
         EYej8UjrsmdwKgibi4Xli1mBx50G9kh/cofzCn8lWdC5+f6GLJ8Nw0vMV9cUNSseuuZm
         oKZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=zQMyHMOAK54x4+Uu0bs0SlOT+nNZwBpL0SWANYBUJNg=;
        b=GqeU4QgqHz6bHfLRZ2Byiv8de6I4iTkorNY1sHYoi1JHd8LgPrRpK5A02JY0vjVIIm
         sKccI3hs1lmq7mKBFxUQDKEXDE+qC9g6zmakI6nEB9gxAxvNDbK1iVSpL3TwQZi0wj3f
         D5D+XcN6v16QF9F0do1KqzChwhsHTgxlJY6bny7Tgn3U+bUhuwAlOPi2U4YKI9okY0dJ
         htDroUYaQbmi0p/9r1zOQXGM8GoGPQ8rXf64edfuXHc61DK5JaKMtWs6C2u2u37eBRc4
         oJxSV9RnwBeq7TDtlqSKisvXHZsKP/cS6WxEwdKb3aFjs+s6SInWEKkd7o+yLidwIUY+
         YW0Q==
X-Gm-Message-State: AOAM532TT7EEheXLeVVVggV3gKMidpj2oaoXpsGabrGOcJnZyRhZ+16M
        0I7SMLOmjN3YJoXGpg2JBquuqBDMok4CSQ==
X-Google-Smtp-Source: ABdhPJyPBbryGKffuKw3sEBOxrZ7x8f9e3t1HWMOBZDsQkD/TXFE7IUk1pWI8uHHEI+KDgoPH5hkWw==
X-Received: by 2002:a05:620a:11b1:: with SMTP id c17mr3220219qkk.94.1601481617659;
        Wed, 30 Sep 2020 09:00:17 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:e9fa])
        by smtp.gmail.com with ESMTPSA id g14sm2542009qkk.38.2020.09.30.09.00.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 09:00:16 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 30 Sep 2020 12:00:15 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Veronika Kabatova <vkabatov@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH V6 1/2] percpu_ref: reduce memory footprint of percpu_ref
 in fast path
Message-ID: <20200930160015.GC4441@mtj.duckdns.org>
References: <20200930082657.3305143-1-ming.lei@redhat.com>
 <20200930082657.3305143-2-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200930082657.3305143-2-ming.lei@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Sep 30, 2020 at 04:26:56PM +0800, Ming Lei wrote:
> diff --git a/include/linux/percpu-refcount.h b/include/linux/percpu-refcount.h
> index 87d8a38bdea1..1d6ed9ca23dd 100644
> --- a/include/linux/percpu-refcount.h
> +++ b/include/linux/percpu-refcount.h
> @@ -92,18 +92,23 @@ enum {
>  	PERCPU_REF_ALLOW_REINIT	= 1 << 2,
>  };
>  
> -struct percpu_ref {
> +struct percpu_ref_data {
>  	atomic_long_t		count;
> -	/*
> -	 * The low bit of the pointer indicates whether the ref is in percpu
> -	 * mode; if set, then get/put will manipulate the atomic_t.
> -	 */
> -	unsigned long		percpu_count_ptr;
>  	percpu_ref_func_t	*release;
>  	percpu_ref_func_t	*confirm_switch;
>  	bool			force_atomic:1;
>  	bool			allow_reinit:1;
>  	struct rcu_head		rcu;
> +	struct percpu_ref	*ref;
> +};
> +
> +struct percpu_ref {
> +	/*
> +	 * The low bit of the pointer indicates whether the ref is in percpu
> +	 * mode; if set, then get/put will manipulate the atomic_t.
> +	 */
> +	unsigned long		percpu_count_ptr;
> +	struct percpu_ref_data  *data;
>  };

Can you please add a comment explaining why the two structs are split?

Thanks.

-- 
tejun
