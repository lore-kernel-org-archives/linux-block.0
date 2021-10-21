Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B12F4C433EF
	for <linux-block@archiver.kernel.org>; Thu, 21 Oct 2021 14:01:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BE836112D
	for <linux-block@archiver.kernel.org>; Thu, 21 Oct 2021 14:01:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbhJUODo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Oct 2021 10:03:44 -0400
Received: from mail-qv1-f48.google.com ([209.85.219.48]:39481 "EHLO
        mail-qv1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbhJUODn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Oct 2021 10:03:43 -0400
Received: by mail-qv1-f48.google.com with SMTP id k29so467518qve.6;
        Thu, 21 Oct 2021 07:01:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0U+RWvmwzZQnDHkZFAiKquq3sy5BuzvtMKBzB6NsKtY=;
        b=uvOs44I5jDuMW6MBc1YFhLUzrgiG8MKp6EXRzXiRbJaNhZzDPVzOq7yhTRmEPXR+6d
         L0lFcDgRX1M8vOT5iP51dRdJTp7rs1mNZGdTUU4N9aop9C07WlhBjBSYpxlMjDeg4O8V
         tCDAPRj86nxPHP4Ig2oBgXi1cC8L1vBf1VEjdY3yAAK5usv7loYaC2wkV0erpshhRAU/
         GE/RJcZBv3bmfpc8eLezTjzRIcuK12vd7RHvu+7l5XlBxXusz+kD9YiVgqRaNM9RLRTY
         awbBOTPXnSC4pt8XRCZBE7qDqNqzOQCeoy8+6UvaNppiAFJV8ARAgwD8wOyWsfT8gmhC
         1boQ==
X-Gm-Message-State: AOAM532/RGBBdTjT7oGWIjcaOVpCwKSUA1LlPFgQJ61lVS618Z2Xpk6h
        6w6VG3aPlBcBR3BYYKUD9uL1ZMlRxh8=
X-Google-Smtp-Source: ABdhPJw2uX2rarXlJXea4IjdYD5evpOPewmF56bfTV7aJEvMs0lg3dzF+7TzoFHZy8QqOXi5pg+JFw==
X-Received: by 2002:a05:6214:144c:: with SMTP id b12mr5514294qvy.56.1634824887011;
        Thu, 21 Oct 2021 07:01:27 -0700 (PDT)
Received: from fedora (pool-173-68-57-129.nycmny.fios.verizon.net. [173.68.57.129])
        by smtp.gmail.com with ESMTPSA id b2sm2446805qtg.88.2021.10.21.07.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 07:01:26 -0700 (PDT)
Date:   Thu, 21 Oct 2021 10:01:24 -0400
From:   Dennis Zhou <dennis@kernel.org>
To:     Pavel Begunkov <asml.silence@gmail.com>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Christoph Lameter <cl@linux.com>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2 1/2] percpu_ref: percpu_ref_tryget_live() version
 holding RCU
Message-ID: <YXFytAdeF5RPRERf@fedora>
References: <cover.1634822969.git.asml.silence@gmail.com>
 <3066500d7a6eb3e03f10adf98b87fdb3b1c49db8.1634822969.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3066500d7a6eb3e03f10adf98b87fdb3b1c49db8.1634822969.git.asml.silence@gmail.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

On Thu, Oct 21, 2021 at 02:30:51PM +0100, Pavel Begunkov wrote:
> Add percpu_ref_tryget_live_rcu(), which is a version of
> percpu_ref_tryget_live() but the user is responsible for enclosing it in
> a RCU read lock section.
> 
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> ---
>  include/linux/percpu-refcount.h | 33 +++++++++++++++++++++++----------
>  1 file changed, 23 insertions(+), 10 deletions(-)
> 
> diff --git a/include/linux/percpu-refcount.h b/include/linux/percpu-refcount.h
> index ae16a9856305..b31d3f3312ce 100644
> --- a/include/linux/percpu-refcount.h
> +++ b/include/linux/percpu-refcount.h
> @@ -266,6 +266,28 @@ static inline bool percpu_ref_tryget(struct percpu_ref *ref)
>  	return percpu_ref_tryget_many(ref, 1);
>  }
>  
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
> +	WARN_ON_ONCE(!rcu_read_lock_held());
> +
> +	if (likely(__ref_is_percpu(ref, &percpu_count))) {
> +		this_cpu_inc(*percpu_count);
> +		ret = true;
> +	} else if (!(ref->percpu_count_ptr & __PERCPU_REF_DEAD)) {
> +		ret = atomic_long_inc_not_zero(&ref->data->count);
> +	}
> +	return ret;
> +}
> +
>  /**
>   * percpu_ref_tryget_live - try to increment a live percpu refcount
>   * @ref: percpu_ref to try-get

Nit: it's dumb convention at this point, but do you mind copying this
guy up. I like consistency.

> @@ -283,20 +305,11 @@ static inline bool percpu_ref_tryget(struct percpu_ref *ref)
>   */
>  static inline bool percpu_ref_tryget_live(struct percpu_ref *ref)
>  {
> -	unsigned long __percpu *percpu_count;
>  	bool ret = false;
>  
>  	rcu_read_lock();
> -
> -	if (__ref_is_percpu(ref, &percpu_count)) {
> -		this_cpu_inc(*percpu_count);
> -		ret = true;
> -	} else if (!(ref->percpu_count_ptr & __PERCPU_REF_DEAD)) {
> -		ret = atomic_long_inc_not_zero(&ref->data->count);
> -	}
> -
> +	ret = percpu_ref_tryget_live_rcu(ref);
>  	rcu_read_unlock();
> -
>  	return ret;
>  }
>  
> -- 
> 2.33.1
> 

Currently I'm not carrying anything and I don't expect any percpu_ref
work to come in. Jens, feel free to pick this up.

Acked-by: Dennis Zhou <dennis@kernel.org>

Thanks,
Dennis

