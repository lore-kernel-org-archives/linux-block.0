Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695EC2C028F
	for <linux-block@vger.kernel.org>; Thu, 16 Apr 2026 07:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776325288; cv=none; b=hO5+nbZksFIgAMWQ7LOZbtmmbaRENF4g1bJkO00QjP1FAvsmvfP+KilG1gzfcUZBlj/mtlwckPlfTlOHBOgFGUe9bMn/Fz765FC/TrqWg4r/3BXVmXiaL4nqeATHIO8IWMu4MYrtXnSexn2o9zBMVhrZqHVsdNSAaZgon+n8ysE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776325288; c=relaxed/simple;
	bh=2CEvo/qEM40xsTUb/K89q0yiG5wQQVyLLKC9UKSR1Fo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sQafb3Q/yd/t7lxkPVTwoIzaTN5r9oJY7tQwprxSI/Qk8bVXrWoM9AlifTPFn28txFe0sGQg3iNYtf73osoewfKSHwAvBTDmXGatmOegEAJNm45t1aMDkV7SzCHrVDF0AQIYi0RKuAi/tZMaGI6J1fa90G/N4H9LPD7GerEsOWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=YmaYbBbG; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YmaYbBbG"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-35e576110adso236389a91.0
        for <linux-block@vger.kernel.org>; Thu, 16 Apr 2026 00:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1776325287; x=1776930087; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MaYOU7eGew8S40dm8UCkeWyZ2/sdhMJxx0U3+qUHRQ4=;
        b=YmaYbBbGh8cT+gwhhTk5rboCm8rq8EUJ/GqcEAKGEpTWYgK4w+WTrwEeRrWNs+rct5
         hP1g6zC4K0aJvqr44QGrlrX8InMhq85PAK7xr3SDTD408/elT1dYWSLqfxteEAoJbNCA
         tEU4FnVXSVUkXXqAcIdmh32dT2Tmjjzz/zL9Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776325287; x=1776930087;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MaYOU7eGew8S40dm8UCkeWyZ2/sdhMJxx0U3+qUHRQ4=;
        b=qxoQ+qzlhROKSjpLHan0IusWtYgxITXeFo4A72wumDXs0qDNLxIpepESMXuAGIy7QA
         5F/Y/Pa6zOuAyx9nWEd7Bq57B5dW8cO0EhsRuNOpfACPnubCM03z9qwPOGBumhOMSPXr
         GFhCTmoOxcSSe18Crf5a4I7yrQmUSRIJE3vBgDAqsrvwJFkwln6ndls6/LAMZCNFC2cy
         CHzut07Y4O4XTG4t79ilQO9KrqyqcKpBkQJ7N0e7lU1R0D53tNjtOHR7M1TR10r3dT3z
         Ecbn2Lvkx2HJ1XdzF/A0Hpyy2khps7Hm3WXw/GkMBIKLbWjaJtUSHZ/tZnPqg4mlbZuA
         3QGw==
X-Forwarded-Encrypted: i=1; AFNElJ+2wNa2SVqJ9s+2QVKG0JLkAJsk0s6pVTZS/LnbucNZTBbHNZrdokmE2IoSLNcl+lnO6aYDdO2Q/+pikA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwNBb75PIuliAzT2W2Jvmt78m3w6LwTwQk5fUL2xlWdJO4zStKK
	lQCLU/6+pkQWARfTvIsacN38LWZPxNkcSHNEc2VtRQA3ULR5KurOkctpMSZDKdhy3Q==
X-Gm-Gg: AeBDietgXGZ80WXTOrdLhZ45fj92UFSkOaxeZSvjWqebk0YdFv8csBB6pBP25lS5RcV
	EBS15BjgmhWSdZU4PlhQnnjS/bzk/WZi2+l/1AW1kzGteaXbCp1/eo0cffQ86aTCZVuw2hyTgi8
	5Mlg+w7s0lWwgaX1VKfXIxoATt3pTISUI2w6YTfTebBWdADR8ltSjsvPHfp0TT7gerd1PJuKJQk
	E7mqG0ckxojm7KaX1SjwM56QhLuILupcY5m0p7pevl2MWT3gb2MSx8hLUCxMZxv58Z5F4H5AAGf
	UDo12OIWFF3FvgGALEsQ/01J80iVozGZHP4ZzCEDvGHOmJmICoh3afx+I2UAv16NoIJFiCWudHU
	mm3g/d/6wZFO8WjYSAryShyZMJloCgohVnHjRCdpR7QbffRSEWf8A9Nr4ko83SySkTpwq8PouKF
	bC9VlsBuzF4l/z0/g8l+OkgWMrvU1nYK+W4TVxB5t9cKtlbh7sL0FstIR8fB1vrYhBegNP2U+4B
	g==
X-Received: by 2002:a17:90b:1e01:b0:35d:a31e:6b04 with SMTP id 98e67ed59e1d1-3612f26db5fmr2823276a91.3.1776325286746;
        Thu, 16 Apr 2026 00:41:26 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:63b6:f9e5:485d:ef04])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36132cfc6cdsm1654717a91.13.2026.04.16.00.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 00:41:26 -0700 (PDT)
Date: Thu, 16 Apr 2026 16:41:22 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Xueyuan Chen <xueyuan.chen21@gmail.com>
Cc: ryncsn@gmail.com, baohua@kernel.org, minchan@kernel.org, 
	senozhatsky@chromium.org, akpm@linux-foundation.org, linux-mm@kvack.org, axboe@kernel.dk, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, kasong@tencent.com, 
	chrisl@kernel.org, justinjiang@vivo.com, liulei.rjpt@vivo.com
Subject: Re: [RFC PATCH] zram: support asynchronous GC for lazy slot freeing
Message-ID: <aeCRnAhfg3fNi6Ey@google.com>
References: <adt3Q_SRToF6fb3W@KASONG-MC4>
 <20260414054930.225853-1-xueyuan.chen21@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260414054930.225853-1-xueyuan.chen21@gmail.com>

On (26/04/14 13:49), Xueyuan Chen wrote:
> On Sun, Apr 12, 2026 at 07:48:48PM +0800, Kairui Song wrote:
> [...]
> >What is making this slot_free so costly? zs_free?
> 
> Yes, I've captured some perf data on RK3588 cpu2: 
> 
>   -    3.79%     0.42%  zram  [zram]  [k] slot_free
>      - 89.04% slot_free
>         - 65.40% zs_free
>            + 77.29% free_zspage
>            + 21.75% kmem_cache_free
>              0.68% __kern_my_cpu_offset
>         + 13.19% _raw_spin_unlock
>         + 4.86% _raw_read_unlock
>           4.75% obj_free
>         + 4.72% _raw_read_lock
>           3.64% fix_fullness_group
>         + 2.02% _raw_spin_lock
>         + 1.31% kmem_cache_free
> 
> It's clear that zs_free is the primary hotspot, accounting for ~65.40%
> of the total slot_free cycles. Beyond that, have some read and spin lock
> in slot_free.

Just a random thought, if zs_free() is costly then it likely also affects
zswap, which makes me wonder if doing something on the zsmalloc side is a
"batter" way forward.
