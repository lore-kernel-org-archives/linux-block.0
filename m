Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA26A94A
	for <linux-block@vger.kernel.org>; Thu, 16 Jan 2025 00:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736988102; cv=none; b=Y67RBAwNXy6meqXOXImRodPQ0lwN/b16gyn8ylURgcHd1M2/4S57DhJfpimWwRTdMxNvLiI1eCU1/MYtYWi4qBcO7IYvGUXKVReP4KqFd0A0ER1mYfZNxoQRhrBs063kSzL2RiAwLf2VpS84Ej4tgwGJP0dRL+oni0TtQRkKll8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736988102; c=relaxed/simple;
	bh=DaxSHKul3vLu4Fzx0kqGnf8Es9IgOSP4iIPSFx+eSoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kkulw5mOOt/t5ChXBScX9SLUCTKNS1ji6LfL85OBOLjInqjNz28DJmtP9Lt1lhwTrAGJ6xDoiobMEuqnTzJdVAtk8DN/aE0FLnQuQ2MlH5yakrBblMZI+cef2jxzxr0fRvrbRbC06CfRy4GkkRV9VzeLd/AXsqyoHQLbwLHNzLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=c2ALvChm; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="c2ALvChm"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2efded08c79so608354a91.0
        for <linux-block@vger.kernel.org>; Wed, 15 Jan 2025 16:41:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1736988100; x=1737592900; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2/REPRuAQRQKcKfA3HHYPj6NAjhg6mrxoQvl+BUtmD8=;
        b=c2ALvChmeCU9lxCMaUydyShMO3hf3t+mTa/fajFf9EMel7Z/0RFinrTOZFAOg3QCUS
         NtVB2nTY5B4bddTyyx5F/XFj75hMgOA5ieHwcFPAQSo3UihC08xalzBjOLqnkGfnnj6Q
         Bg4vU7WWtvCXpMuNut1Si5LG9mu8NV2kWW4ds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736988100; x=1737592900;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2/REPRuAQRQKcKfA3HHYPj6NAjhg6mrxoQvl+BUtmD8=;
        b=T9QQS4cmRKEZYf+GZyN8kxZn8kV2mVVx+/CX0WLx6Nd6W/V/pLjmePByb7n9/f5sdh
         BizfSVcvDFlEJbVt7lIK3zKNjHYchE9DMgRCHQSy2E4U3iF2RgR7LnDbxuEq0cxXj0z7
         Hc47p5JEsHPVRNnnXGYgPosANNNTva0F5GnIsVxDPwYS11PoIrxs2e3Mlwfla3n/USpr
         xInwq3AQSPjGvFUVY2rfxl6fG9J3BBDMNKmr6EQ2z0monZlL68kMtNcSotAN7t906bsQ
         zlFrlc83lx8FGJs2FKfUDLQJ40d8y9fbrsIiqZxpxbG2S8O/+EOttAtqo1PUfvJLtJMA
         CVlQ==
X-Forwarded-Encrypted: i=1; AJvYcCWaS4B4gc65SqzIySPyMvKcz9KJ38v40LgxScHaok4nlFf58kY19sMdYj3J/yGY4MYehdtzVUmbS/zzRw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwlnPsiWQYVXRht3Ux1e4y9z/msbXMZtl/6TqcsL1vZv5ygJf6B
	LsCZDyZmXZ10D0M4SOeENcqbQul1zGOVcqIPrHNN83JAjecXyVrwbh+I63tpeQ==
X-Gm-Gg: ASbGnctjlV/YyA2c0lTiRFVwvGWG9lhbFDj0ikAeo+sbj4P5I1r0MwwW0bg8L582RsR
	DJgX9qTaBtrq0V1NoM1ZUo7ByQIYc328h+Qc0P8s5xuLfkBAFmS7SDqjtwSLipHEpcP6VAzubnX
	VAh515J1YyhDd9pAXTzXEalmNhwNp03DbAuYi/6t3n2rahGFYqN+v36Oi0fGeCGIpW7P+ehMZL4
	ebVTPWu4TOT8LxGqLc1Bw2sjHMMJYFysB7pB1QWhXtQClT5+Dbs4FXx9rrr
X-Google-Smtp-Source: AGHT+IGWIcw0FCPwqDY2LRyBn7ZtzZiH0QECZZB8FXEiQTRYjNuUZY0oIimYMkgGsQOkZA7uKpRBoA==
X-Received: by 2002:a17:90b:2642:b0:2ea:aa56:499 with SMTP id 98e67ed59e1d1-2f548e9aed3mr40818506a91.1.1736988100602;
        Wed, 15 Jan 2025 16:41:40 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:8be4:86b8:bd3d:aa3c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f72c18b076sm2003354a91.15.2025.01.15.16.41.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 16:41:40 -0800 (PST)
Date: Thu, 16 Jan 2025 09:41:34 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Wenchao Hao <haowenchao22@gmail.com>
Cc: Minchan Kim <minchan@kernel.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org
Subject: Re: [PATCH] zram: cleanup in zram_read_from_zspool()
Message-ID: <iiiqdmxebni4sfal7rguy4me24tgmzym2v4oz5hzjv624vavr6@kida3yjmoecs>
References: <20250115145545.51561-1-haowenchao22@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250115145545.51561-1-haowenchao22@gmail.com>

On (25/01/15 22:55), Wenchao Hao wrote:
> @@ -1561,11 +1561,6 @@ static int zram_read_from_zspool(struct zram *zram, struct page *page,
>  
>  	size = zram_get_obj_size(zram, index);
>  
> -	if (size != PAGE_SIZE) {
> -		prio = zram_get_priority(zram, index);
> -		zstrm = zcomp_stream_get(zram->comps[prio]);
> -	}
> -
>  	src = zs_map_object(zram->mem_pool, handle, ZS_MM_RO);
>  	if (size == PAGE_SIZE) {
>  		dst = kmap_local_page(page);
> @@ -1573,6 +1568,9 @@ static int zram_read_from_zspool(struct zram *zram, struct page *page,
>  		kunmap_local(dst);
>  		ret = 0;
>  	} else {
> +		prio = zram_get_priority(zram, index);
> +		zstrm = zcomp_stream_get(zram->comps[prio]);
> +
>  		dst = kmap_local_page(page);
>  		ret = zcomp_decompress(zram->comps[prio], zstrm,
>  				       src, size, dst);

I think you are looking at some old code base (or maybe vanilla kernel),
that function does not look like this in the current mm tree (or linux-next).
