Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D482FE56A
	for <linux-block@vger.kernel.org>; Tue, 18 Nov 2025 07:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763452206; cv=none; b=WT+SnJP7zLLQsuNDIY30FfkczZWzMV2OdqqDYDGkUWAAlh0B4yGJaM4oan82/GBPHX7+Kr6Af9R4Jg2PtpZeTn9vhUIh5feG4f5vhwxH54rHFLEvuv8ew/VbA+35mqveg1WwLl0txHdR/AlZSaR7olBg1nPfwqa+JH4SmlvxfoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763452206; c=relaxed/simple;
	bh=N/sa3Z6fTWkIk+0vO8JlPVs17a6YQGMhM0TaMPOKZEc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jtaRz6NkX39aihX7ux6UZ0sDPNVkvfbAleT8If/QcUgDDmmRmH45Mv9IippJ4+1pyy/2QwRcEPwWMiLlNeaWyXZ/WxYK3SLHZK5kyztEnTN+dbs7tcsODoYYDWps0KM3jbIgOhn+EaUnqyN+PJuuf48sn+MzABEBgM7nzm8y74s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=MM0GZyBH; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MM0GZyBH"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-343ff854297so5744305a91.1
        for <linux-block@vger.kernel.org>; Mon, 17 Nov 2025 23:50:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1763452204; x=1764057004; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=plNtX4FgCEClMcrKjGfKlLaCiD+LAXHKIrMj02EWGZg=;
        b=MM0GZyBHm/6UU351UDQkxne5G+j+cJv2BLA7ZzvNEZou82+lnYBzHngNYI+LYV4zMo
         7LTMuIBnoXdkkeVtfsU1Z/HA83oxzq1hxV06oVDbHlxKuTXwhLBb+MeogfZVTvj/eX5Z
         0ouhHokuKCxTO74k56T8d+U9IP+jYle6N2pdw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763452204; x=1764057004;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=plNtX4FgCEClMcrKjGfKlLaCiD+LAXHKIrMj02EWGZg=;
        b=pFMXhU4igKIVduGBaOz3yk1sU/FPhrcVL0BnLaoP+LY3Vu8Y31aGlhreeUrvFtd+Og
         nF74IevoBrvaRhJaUyMO5VdgCMSAk/LcMDr9a0tnVO/4NodjCEHHE01kWWX58UZvdszX
         Axg2Iv/v+xsPPfBADc12bSwCHDuAEas6sFu1RJ8/jiaQhyZZ4/bSHCfeHPtr4QUOaxAZ
         e0LNcuU+aupqC7xjkijiLffEJNfusdTDiBfJ5DsLwM547cutwEgKyULjqCEXJinevCiW
         zeXOYS1KfXXfLTPCd+8h9M60zqOTAOhzmXBvWMzfxcY63uwNAgP6dnGfWeSCIUB3JtBH
         AbdA==
X-Forwarded-Encrypted: i=1; AJvYcCVs20rsxC9RAbcygglXzPJPODvK9tz5P8eUnbbFOmIGrbD6xbAPDUoNcxLBIhOYv+DZvZFlKalIVxOQMw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5vJmynakh26lRMJ7dwrga3C3g26a5UHaltmt611V8q9VPVSUv
	i9B16f0rLg50Ri/fVIL3tMC5g2yu/jnzp0YdIBvFE6OPiZwuQ18Fcyc5YoPECvkWFw==
X-Gm-Gg: ASbGncs9TYlO6U6N5p9VOiYz0B9M8jSyhTLGhg7xSn6/5VUCm+nkzk3HQPg6CK6kx2h
	NO0RFotLm7yypIoFzMCo2jcrpKJ2U5DzxQlScczLbM3ml3ZrJYWG/5peZ0Afi2rgwvUxMF1WizE
	qqKZmod6GKe9h6iGRS7fpFZly0efQ6O+QoukSvKZ9Cawa2ICLl1pz85NVDtn1z9s+Zr5b/KlOzA
	JuolkCPJFwuWKuPCK09YtOSQ/5vBB90hqy135BxEcK0rI0Vhdg45P7cUQF69Arc4GCMxi3vmkYc
	C1gpBYoV4t4lTQOF16qPTrehd6rXSXhNllqhAV9USkoUo1lTD07RS07no2PW8NxggV1WkCvDBlL
	+nCQbZVLD96jBYJ/q+mDmm4ZQGDyG6ckkrbAkT/H4mirct/BHgJXi+VmbHtJfyQaNfrtrXb4JU7
	JAY/Kv37u9LNg0PUoV2oxtLU/6Xg==
X-Google-Smtp-Source: AGHT+IHZwl0OAHHI3jg5IDqTvWIOofVPyV3wFLo/icrQp+7MyguQnHwiS3UU2BMu9Gy23vmm1Zpkbg==
X-Received: by 2002:a17:90b:2f08:b0:335:2eef:4ca8 with SMTP id 98e67ed59e1d1-343fa769fa1mr17863076a91.33.1763452204610;
        Mon, 17 Nov 2025 23:50:04 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:beba:22fc:d89b:ce14])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b92714e298sm15568611b3a.34.2025.11.17.23.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 23:50:04 -0800 (PST)
Date: Tue, 18 Nov 2025 16:49:58 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Yuwen Chen <ywen.chen@foxmail.com>
Cc: senozhatsky@chromium.org, akpm@linux-foundation.org, 
	bgeffon@google.com, licayy@outlook.com, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, minchan@kernel.org, richardycc@google.com
Subject: Re: [PATCH] zram: Fix the issue that the write - back limits might
 overflow
Message-ID: <eebxwjzm5sdej3i5hb7pkj3w2xkacflxkeuetbyb7i4dpmltdl@lkysptw5owko>
References: <tencent_80150170978D13BAF69D63E57D7F5175F90A@qq.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_80150170978D13BAF69D63E57D7F5175F90A@qq.com>

On (25/11/18 15:39), Yuwen Chen wrote:
> Since the value of bd_wb_limit is an unsigned number, when the
> page size is larger than 4 KB, it may cause an out-of-bounds situation.
> 
> This patch fixes the issue by limiting bd_wb_limit to be an
> integer multiple of PAGE_SIZE / 4096.
> 
> Fixes: 1d69a3f8ae77e ("zram: idle writeback fixes and cleanup")
> Signed-off-by: Yuwen Chen <ywen.chen@foxmail.com>
> ---
>  drivers/block/zram/zram_drv.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> index 4f2824a..4ecf2e7 100644
> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c
> @@ -562,6 +562,7 @@ static ssize_t writeback_limit_store(struct device *dev,
>  	if (kstrtoull(buf, 10, &val))
>  		return ret;
>  
> +	val = val & (~((1UL << (PAGE_SHIFT - 12)) - 1));
>  	down_read(&zram->init_lock);
>  	spin_lock(&zram->wb_limit_lock);
>  	zram->bd_wb_limit = val;

This patch is against unfixed writeback_limit_store() function,
it will need to be resubmitted once [1] lands.

[1] https://lore.kernel.org/linux-mm/20251118073000.1928107-1-senozhatsky@chromium.org
