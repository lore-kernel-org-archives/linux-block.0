Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E19D29CEB
	for <linux-block@vger.kernel.org>; Thu, 13 Nov 2025 07:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763018196; cv=none; b=phDiP4v1nNoslCp147LxWxN2sI4rd6x3A9f2vIK//ooKs+fJGV2KJE4aRe7+eufok1TYfUZh9Tm0njyRM9Y3/MKlJnxO5wNxZ0hFmCu0QrBz2W8EZ2u1qyrCCif4YJknpBr1m/kMlJiDj2LhAd/heTzfqO6qTYbTE/jmKMHJ80E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763018196; c=relaxed/simple;
	bh=c4zHcCtmZMeGsh/6boUVLJrPUNnv93qIJfOwOLJ0aqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QECaQe+aE+ihTS5thivaCueCnp0p1Ji2O1CGnNctxQmeX3ZUeFz7xtF1NXcVQHza6mTi+DpaFXeAiy4l0uUi2CG1IDoKzCqhS8sA1zaX8EGSyYd1Z1NrdIOZIU0Ab1xJ9+BHmYdOf1aovCDSDUF59yATFTWmU/Wv1WVPxd8WuYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=S5imVyNG; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="S5imVyNG"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b996c8db896so450456a12.3
        for <linux-block@vger.kernel.org>; Wed, 12 Nov 2025 23:16:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1763018194; x=1763622994; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7wrlB1q7/ZOkA42YS9v1roGaOvVL8ukdy93xk+fDJ2o=;
        b=S5imVyNGzSOJa/HyEgNrXmiA878QdPuoTIvAOXe8KFRNFcTOqn4tT5MN41u6O6u+1T
         EUC1phlWUxa+6Nu9IXjdjDBMMAwbdkjQk20zfxVHVecXerk7HrPWDTgRd/3YMWmCsYk2
         qydfMjRO0w92QRFI1yzLywffLBQN17v9GVwe0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763018194; x=1763622994;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7wrlB1q7/ZOkA42YS9v1roGaOvVL8ukdy93xk+fDJ2o=;
        b=tNlt0rDOqnRCZFt673S7zq/RnDK+tpjckFnE701SG0utLJNtpT7G4wXTemY6XMxN2P
         K11ssCiYmM+LvevJQe3exkzLNPD54qWfywfHpdxp3X3tuh5Sw5hIPTIc6nCURUZbxAp8
         pgBAVA2ci05IUV2Z0Q/zrz/59sHDNUxE7Y1cr3OUDNCA/Joho3Z5BoGvDjb4Oc81Peck
         QqXzCqg3T+kOzsEZH3ZOnwwh8fmYbQwrFRA9S3j/GqNU6qAeg+G1SG4qfD8lNDVGV2sz
         NWHdE6p5X/CdRMP3fWEpGchBmDsUSuso8oC2G5mu7J61Z3CYgYl4Cmwm64uEg6SxcZ8Y
         H5pA==
X-Forwarded-Encrypted: i=1; AJvYcCXJFkJbsrS4GSrlNbm3wiBO9m3Z+9o8vj3luo1sFctoj5bIYo8OvMj5ahl7tLwUWZH5XspLVYMbX0M/xg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo9S/7OHFqwTh1U1N0CmEnOqzjxOhuA3FbX12HSsTTx6WfPA0q
	IohBnh1fUlwAUV7u3xmUrVEO3AjZhg95vuROfJwFUdffXNI3nVg0tsEgRX0VaCY4qQ==
X-Gm-Gg: ASbGnctBsn0gY70ibnGIFG+FWV6Ii1y3xJH33QpHvQVN3E8XXzk+Hj3/PM5X5vq9isF
	pm6VyOaGFkOP2Gxh3RDK78OWsuRpF4w+OJGTdR73AhJnV8xCKv49nWmE1iXOh36ZRYslZm42Rke
	X01Xl1bBU9AhLUBLbl5FxZDjjLoxWGyC6lYFRzz4zbDhRD8GqMW3+TzmgFKv9v328KvN84ymvQM
	aMU+7zPmyS8vrOEmIvFq8OqKdo+IKrDBvA4/6ME3c0/s163pPPemjYgA4X88WooefQ7XkoEJhdR
	rHMVqoOOPV8b2BGEWqcsoLPNnQIMdNs0YS+fbfDln4ElHpoUJT8fSVlJpGJ/G5j0LFcU1ypw9wd
	7f70nsiKokd1ZBax7dC3+xpV6rpbm1W2MelFPEIsWpitLWdg9fdS0plmL8NOIVyUvwzOerpfAD1
	gCHV/R
X-Google-Smtp-Source: AGHT+IECRPkJaf4oGfrwi1MX+s8z5xbRJJ9Jk4VfQe26C35pT5SliM8hefU6QaId+JYNDJAkFupzCA==
X-Received: by 2002:a17:902:f707:b0:295:50f5:c0e1 with SMTP id d9443c01a7336-2984ed48facmr73094665ad.15.1763018194389;
        Wed, 12 Nov 2025 23:16:34 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:6d96:d8c6:55e6:2377])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2bed39sm14278045ad.77.2025.11.12.23.16.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 23:16:33 -0800 (PST)
Date: Thu, 13 Nov 2025 16:16:28 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Minchan Kim <minchan@kernel.org>, Yuwen Chen <ywen.chen@foxmail.com>, 
	Richard Chang <richardycc@google.com>, Brian Geffon <bgeffon@google.com>, 
	Fengyu Lian <licayy@outlook.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-block@vger.kernel.org
Subject: Re: [PATCH 1/2] zram: introduce bio batching support for faster
 writeback
Message-ID: <txgn6y47vwxb2d537374lklpbwwxy4r46okqgbvqxwxppjfwhj@wttkbv2pjjpx>
References: <45b418277c6ae613783b9ecc714c96313ceb841d.1763013260.git.senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45b418277c6ae613783b9ecc714c96313ceb841d.1763013260.git.senozhatsky@chromium.org>

On (25/11/13 14:59), Sergey Senozhatsky wrote:
[..]
> @@ -775,67 +980,41 @@ static int zram_writeback_slots(struct zram *zram, struct zram_pp_ctl *ctl)
>  		 */
>  		if (!zram_test_flag(zram, index, ZRAM_PP_SLOT))
>  			goto next;
> -		if (zram_read_from_zspool(zram, page, index))
> +		if (zram_read_from_zspool(zram, req->page, index))
>  			goto next;
>  		zram_slot_unlock(zram, index);
>  
> -		bio_init(&bio, zram->bdev, &bio_vec, 1,
> +		req->blk_idx = blk_idx;
> +		req->pps = pps;

This should move ownership of pps from pps_ctl to req.  Will fix in the next
iteration (apparently compile-testing is not the same as testing).
