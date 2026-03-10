Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2626284881
	for <linux-block@vger.kernel.org>; Tue, 10 Mar 2026 05:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773121185; cv=none; b=tzBwRfCwojQFcWGF4xztfQiwvT7piQtnq1e4V3lWehhNWBj1oEjTYWpFEa+KRTXrJm6Fj66QS739bx9YhxAs0EpICDKK9ybK5eeth2eFIiSdrn5yVoIIdFOfbm6/4Za4GB/vR4JKVXIaRL0pqWba1x0MnxpWttkAcS9iglk3HNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773121185; c=relaxed/simple;
	bh=nB9xIMLjhF/iaWa4zTIp5oFpdXpCe7lSh9rcsGcI/uw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s80od2xgeSuzStjG7ThN1mPWx1fU1MoSKfhK4Sy6u+kmoVWEGLyaiqYL5ZaXfreECjD1T/i9PDedsz5NMmFTd3dbb6Bdl8j7pPfTquvlerGpWoQalGZ91vm4QgdBZGPa6UeJ+cL/xlIEO1MEArFUI8e2Vf1j41GtP7SCWhFFdek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Op3OaI6/; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Op3OaI6/"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c73aabd620bso1686684a12.1
        for <linux-block@vger.kernel.org>; Mon, 09 Mar 2026 22:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1773121183; x=1773725983; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HvRlyDyTSjBWwIiXQKIbLdkGLZLef1DOzpb4yqLasSE=;
        b=Op3OaI6/2R8eSi9EDq7nQmQUEkTL+oFWvS9zsm5TEdlMRfyo9S3p2K4TMygMRL2Oq7
         igDCgfdsOsVThny6nDHScjnxV7+RxwDVwPAup+Xc3uEoZ9UEAP331Cgg5kvXAn1ITx47
         Uu2UzP9lU24LpBj30EwEg0wNXdRPjwTDKF/u8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773121183; x=1773725983;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HvRlyDyTSjBWwIiXQKIbLdkGLZLef1DOzpb4yqLasSE=;
        b=xDTapCUE6JjryFv2RYd1hiRhlEBU576iqJiv+z9vyZ5ymjQKzZyk8HzItAC/3PWdVy
         bK0hPHKBu9+mpaien2IatgxpMem/S37x4W7m3aUAyX4jPD7xpVwHlovwRtmjRZ+SvZq3
         0UpyPsx36mZNOZCiX3Tqg/fQJFXX5v212rDa0LY145yQaZq/klQWhwy+fnJ2G4PgET3j
         /KWfqhLbLaEavSHBT09ZYGVsMBmBIy87THQRrJ6TuQMA/AkNbJrFjBs0bEQTsKytKvsL
         QtsXfimRpCcUk48nho9GQ3snVX26wXejprMJFLwlFHTQBhqALGU2fA6ERfZDPaKF+pMt
         3kTQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhkJCN36ILQacrUwnVbdZVmJgUWXRvfVb6Lxh5EA6bh7kcV4feQM6MzCGiIPLhAAu8gkL28L6sjE/g4w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxfV+5LM5+xgephmFb6H5YhoLbORxpvcQMVHpVTplR3aHNjdHgX
	I9cZtRO8xBOGYN8ODKrf9+9qnqAJc4KAkn7a4Blag5ovqcRABQgaL1nEMD+wOtOscg==
X-Gm-Gg: ATEYQzwe774E7oXGdgHjS7fEhivvLHaDvEmicfirI6w1WNQMjxG0o3uKr6QXqAloj+j
	JN+e71lpgDu4Cr3NDuznHZYafn6KMe25BcUuS6YA/1Hyf68yOMrjyx9YBVqfey8oJvesy3ev5iU
	ylMhnm5KnPyEYOPqNcMIImqhX9Rlilf5Xaduw8WUoXI6ivOgD/pkXkQCluH1aKFTnTm0QUjfpW/
	K0sDAHpIsc1rh66vbpIfnXWw1ARXIWgJ4LFrpMZXyQhTEKCxU9gw3HZpYQ67yIHS5ps0cL5YP0a
	e6oO0CLID2fxraQg1PDri7zyhQGkyZ3XXs8eJikM7idhX80A26OmUl5Ex9AZH5DTl0rfL1+ztZM
	m6noEqFQgLPcmtr8DwOTMTWmgPFKz3pHiVO8jy/+3b9K0D+wFvyRDBp9TxUKz7GFy7Q9JsPsRm8
	DBLn4TDbTcyJlt/S4tZOvZtzpUvux3Q66Wp0nJUxm5lZuXukB1/b1yt4ahBdM7gJA=
X-Received: by 2002:a05:6a21:6f16:b0:393:dc6b:a0eb with SMTP id adf61e73a8af0-398590d6298mr13032783637.64.1773121183093;
        Mon, 09 Mar 2026 22:39:43 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:5620:959c:240f:eb2a])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c739e170c87sm11446175a12.18.2026.03.09.22.39.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 22:39:42 -0700 (PDT)
Date: Tue, 10 Mar 2026 14:39:39 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: gao xu <gaoxu2@honor.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Minchan Kim <minchan@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, "surenb@google.com" <surenb@google.com>, 
	zhouxiaolong <zhouxiaolong9@honor.com>
Subject: Re: zram: Optimize LZ4 dictionary compression performance
Message-ID: <aa-ucbuYGj-sZylm@google.com>
References: <ae51966c3cb445e9983230243bb6a5b2@honor.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae51966c3cb445e9983230243bb6a5b2@honor.com>

On (26/03/10 02:54), gao xu wrote:
[..]
> @@ -78,10 +121,16 @@ static int lz4_compress(struct zcomp_params *params, struct zcomp_ctx *ctx,
>  					req->dst_len, params->level,
>  					zctx->mem);
>  	} else {
> +		/* rebuild base_cstream when the dictionary changes */

How often does it change and under what circumstances?

> +		if (!drv->base_c_valid || drv->dict_gen != params->dict_gen) {
> +			ret = lz4_build_base_cstream(params);
> +			if (ret)
> +				return ret;
> +		}
