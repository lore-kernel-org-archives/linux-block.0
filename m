Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3D72E9730
	for <linux-block@vger.kernel.org>; Thu, 16 Jul 2026 11:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784202838; cv=none; b=AhSPvV3yCW+0VxEBpsA+D2/bMgEAkA/YvSBu5AMskn0dExuBj7WYLK5bIBWy7zahQ4FRhZZifTPcf4CXqZCIU11gKZnqNcgm8m7x7VgT3RNGDUk9DucWudkgYMAj3papp487c9tGVrmVxpGw79ViM2GbGFyHaf+PrtfQ7pAGFJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784202838; c=relaxed/simple;
	bh=sA0JGHy38xSnBYF4jz8RF27ZNqKo9oO58OEvqtrd2c8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ijUpUGjf1g4Be3y35tK1qOuHHqIpy83MExrIcQRLlPbCOPLdnqgwdX50gEuik2ziGK2VJ2emUoM46rFqSM9NmXJ/LiAJM6yCabxBUTPjCmotUdxOTNUnfY1JOFGXc99NVqSNBblyeoDBXQmaA+RNgBY//AF+RbI+9BQCgx3act8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rF3m7+Ad; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rF3m7+Ad"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-383cb94f742so6152381a91.3
        for <linux-block@vger.kernel.org>; Thu, 16 Jul 2026 04:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784202837; x=1784807637; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xuC1bTJn9dIqIbUB4ODFYcZuHR4GDYh4l9W/45UELX0=;
        b=rF3m7+Ad3l7lWd3q51i4hGpCWtRQxw2i22dWo7gmw60cggOOWELfRFf+aJ9qzdcdg+
         DcCr9XSInoWCRXTWJvwHSKXu13FPUYdET17qJetznnP5XUXM0wHrGT8sYmiABD/Sd8aS
         W0YwL8Wo9h90HVcOL61YwpacvGCzX8noY1xKm96IH71loaxjsgEA1XgK/DqVxh6fdrRU
         GNGfbiMkfdGs6Clt3euFbaGVlfQRzCmc3H4gU0PAGg5tRoiZ942TPMl+m0z2J0cmFcxK
         S8EOGjrHqy0u797SKjaiPk14OVeuZ31mbpLgsQ9mQof942iSWd1sK/IKQpfED0tT0bt0
         xHnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784202837; x=1784807637;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xuC1bTJn9dIqIbUB4ODFYcZuHR4GDYh4l9W/45UELX0=;
        b=Ixkyi5SVnW1X4scboM9E4fg6B3TVmQw5K10zkefv7hTpv+s5WHX+kHuaDBbzc4Mo2n
         lw5NJH/xMGXF3SIWiLU4+aH6Q4P55qLL5E0nP5z/gbNqgqxoVYw5r+KQRZpbNIx8XSje
         TvDuRNxQrlhJ+LkatufGJffWuRTpo6k5B7b1CNfHAh8vrQhe2yf8NWLTR1xDhrpLZGjI
         CZreeGNGiuQdHW/3LVWYUId6E8nN2eEl+U4mlA1J8hd/bJuSWD0IsfNP6h1xstsJlazJ
         D3Ri1J3Lr+4Fj1mZsYN0Pauh3LssPJO6CSAG7zS3CyEz4/oL05GzV+2tYVamz+FmW+uJ
         UNPA==
X-Forwarded-Encrypted: i=1; AHgh+RosY4wpYQl2+pxlArGw2PCKYIzXYPsi6C+6iSrmbXdPYFajDXxbmUfB6sBZdsegMCz/RQIMYhFnx/7S4g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwrqvkUZV65Tpq4PfWAXo3eCcrpnNLf/LQliakp0+2gUzJkl7l9
	ed1aCK4GNL6XZGZzazPWc9yBpP+h9inSM/i8b8764+93c76ZbX8ZGcSi
X-Gm-Gg: AfdE7cm21iExnLjry5XARAd4hkdyqZ24Cu+wk1RaJ1plmxq3ccarlzICZhbgORiIWYx
	ukWYzegl3JHOKCsIR5ybd3wmSJBdtlk40hGQ00Xyv9n2Uy9X8awPcYxOmRj+KZIVKdGXsF/QOGF
	HcN4qvPpmqgjya9Ly+/LVh86HSG+yUHKOYia15ZT5nqGi5oBXx2XUprgHp3g8gA3hz7Y01sc1Mo
	Mieg4NY7V1r6w0eYUkucl07o9L1uw+6bs3HSYebq3rq6JnqLtog76rZ+pcJNwes7gN9RPJyHUma
	2OnfAPvk6PKlMhNfCN9wVv7gyrIe6G0UB6yYcVP+gAO86qXM8tlmWO7HQwe7jmDz3fXdYlLLfdf
	OfAdDloJcXThwgOS1CRmEFscdbpfYeP44TRkbvDNprsSBihoVFIDYxm1bQBOC3KAvbBeTleGa84
	m9dzlPBtA1W859laZU79fAoufxy6krukp+xed5DwIIwrr0fGlCO9USOmkEX1RoATKn9JUB/wVih
	KJP
X-Received: by 2002:a17:90b:4a04:b0:387:e0bb:5802 with SMTP id 98e67ed59e1d1-38e2a12332amr6513482a91.41.1784202836681;
        Thu, 16 Jul 2026 04:53:56 -0700 (PDT)
Received: from ?IPV6:2400:79e0:1203:64b0:e174:fd48:2cf7:d01e? ([2400:79e0:1203:64b0:e174:fd48:2cf7:d01e])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e2a20a7b8sm1507273a91.1.2026.07.16.04.53.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jul 2026 04:53:56 -0700 (PDT)
Message-ID: <5d0fe256-c1c8-4cf5-a69c-a7e9afa08097@gmail.com>
Date: Thu, 16 Jul 2026 19:53:52 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block/cgroup: Drop stale -EBUSY retry from
 blkg_conf_prep()
To: Yang Xiuwei <yangxiuwei@kylinos.cn>, Tejun Heo <tj@kernel.org>,
 Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>
Cc: cgroups@vger.kernel.org, linux-block@vger.kernel.org
References: <20260622085623.520209-1-yangxiuwei@kylinos.cn>
Content-Language: en-US
From: Tang Yizhou <tangyeechou@gmail.com>
In-Reply-To: <20260622085623.520209-1-yangxiuwei@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 22/6/26 4:56 pm, Yang Xiuwei wrote:
> Since commit 8f4236d9008b ("block: remove QUEUE_FLAG_BYPASS and
> ->bypass") nothing in the blkcg blkg lookup/creation path
> returns -EBUSY anymore. blkg_conf_prep() nevertheless still
> retries at fail_exit with msleep(10) and restart_syscall()
> — logic added in 2012 when blk_queue_bypass() could

Hi Xiuwei,

Thanks for the cleanup.

Instead of the vague "logic added in 2012", please mention the commit
e56da7e28796 ("blkcg: don't allow or retain configuration of missing devices").

> cause blkg lookup/creation to fail with -EBUSY while the queue was
> temporarily bypassed during elevator changes.
> 
> Signed-off-by: Yang Xiuwei <yangxiuwei@kylinos.cn>
> ---
>  block/blk-cgroup.c | 10 ----------
>  1 file changed, 10 deletions(-)
> 
> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
> index 3093c1c03902..259f2240e7df 100644
> --- a/block/blk-cgroup.c
> +++ b/block/blk-cgroup.c
> @@ -919,16 +919,6 @@ int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
>  	spin_unlock_irq(&q->queue_lock);
>  fail_exit:
>  	mutex_unlock(&q->blkcg_mutex);
> -	/*
> -	 * If queue was bypassing, we should retry.  Do so after a
> -	 * short msleep().  It isn't strictly necessary but queue
> -	 * can be bypassing for some time and it's always nice to
> -	 * avoid busy looping.
> -	 */
> -	if (ret == -EBUSY) {
> -		msleep(10);

Since msleep() is gone, we can also remove #include <linux/delay.h>.

With the above addressed, feel free to add:
Reviewed-by: Tang Yizhou <yizhou.tang@shopee.com>

-- 
Best Regards,
Yi

> -		ret = restart_syscall();
> -	}
>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(blkg_conf_prep);



