Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92AE11198
	for <linux-block@vger.kernel.org>; Fri, 23 Feb 2024 04:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708663621; cv=none; b=gUUQPzlWR32ppG12gDqrNGOMuvmRWMv1qZeHLmuy4FXxup158oTf9zCgWZqp2OftY5RiPqwuZMXN8mK+7Tqgfh9rZS+N7vLBdQvSgfG9BCP+FsyowMYCy9Z2eC7S2rjWgb+GARLW+wR0wQzO8I5OU9hAthTPo3S0I+hpXKS+3dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708663621; c=relaxed/simple;
	bh=y0qj7+sRvk9BpgfUh0nmUJnFo1kppVtdSI5DXWmrGlM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AAQAlChojqhJSP6tYRZjmq5BN39WxIgtWgrvySVjqhk34vXZc5lX0FmCIsthewXqiQm5JUY96f7x9uZXw26u5IriZIp78tg+raa0uUuGGwI/vv2xjrwIKoUl+vVk+GRgGLt3Yp62Q2ZMs+uBupWrtGzmMTf7kvb6uYOoO3Cw25s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W8Fmzgwd; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W8Fmzgwd"
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-7d5c257452dso219582241.0
        for <linux-block@vger.kernel.org>; Thu, 22 Feb 2024 20:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708663617; x=1709268417; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=98SsXJdzO2/QYlzrGwJU+VOpHGdjqBT3Ywfctx81eYA=;
        b=W8Fmzgwdiu6aI8lJ4qmGUeOdIBibhUjZqsk8HiHm1sE9+uGxhzpBwbzJGHfFIWR1A8
         kKpcpmANi1eoplegBh6ygbTkUUz2cNtbt//6zqTSJ6HGszhPh6ybxqr5AvAZPEdnBB3Q
         f5dnK89rKr4/WiLKSHR/P+sOEfGZGRQ2PmL6qPQZ2XBhlwqfRItSbCSsQ1n5CwHoC74D
         m44AXJBXStE0bD1RaRdBbgQjMFacph1jd50Vbi4kZ+coaCMoQxcBW1JfIh22DFQa+OVc
         AAb+9AqduNlFlpbaEnytl2Bc375aDBCrnj6/QWv51W+VcxsyKYtWdlvYZC+zewOK9cEh
         ZKGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708663617; x=1709268417;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=98SsXJdzO2/QYlzrGwJU+VOpHGdjqBT3Ywfctx81eYA=;
        b=p3DNiMz92eq6VIiAHjX5o0DK4MsaX8CBc0lXVOL2tE8iJ8GMiS0oheJ1N8IvbcVNVz
         zfGKbtbaz3tcmtFqC8Q5y5I1hTxEaDLZ+wreFzZxxuaSkc75+fF/reDg4oRKn7BBPgDK
         4DnE83F/OB0V8Ho9eRLtRn+sIfN9diBkXe4CvFtgckJRyL6nBAZfyeIfEngzaFF6gixp
         OFS/e4ziNJVMks0vMZ7fLJUGWXvytwEtUvceGORnPy0NyNr69DE/Mbno4d0Q+rII73Ii
         mqibXg5tPA4sJXXrdhCd6cI5fndxHzljadZINBXGD2rWjzLn3veIQ6ap0M3vzhmrFc7D
         w+Pg==
X-Forwarded-Encrypted: i=1; AJvYcCXOv+W/+TALhgPDjlKy3zbcccW32vxYBpKxJ88cqfb/CmNlT4NCpwrXVbvB4ZTKjRsvLT6n/AjaVfOGeTtkNvVmZbeIpVvXAQnmvao=
X-Gm-Message-State: AOJu0YzKdr3J8wFueF+6s5VtwZlUNVsx2xf9c0UZfv+7PNk2iP7nv0NT
	yUSCoOZNGueUvEY4uNFvKHMML9lZS5QZasX/AYCe0I7xOpU781PNc0NFeZBMMtvc9yP+/jZPJT5
	Y1I6/wE1AdNaKraf7uiUC0iu8t4rAHIYw+G8a
X-Google-Smtp-Source: AGHT+IHLJauUiF0rqTT18jvHpgRY2X3ODeLmlM72AlgOShsf7F205kobxGmKmoCjvK4GHvyNgXSi4VcYiSKE0B5axFQ=
X-Received: by 2002:a05:6102:1621:b0:471:c019:c9e6 with SMTP id
 cu33-20020a056102162100b00471c019c9e6mr798026vsb.23.1708663617395; Thu, 22
 Feb 2024 20:46:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240223035548.2591882-1-wangkefeng.wang@huawei.com>
In-Reply-To: <20240223035548.2591882-1-wangkefeng.wang@huawei.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Thu, 22 Feb 2024 20:46:18 -0800
Message-ID: <CAJD7tkb0E9pJ=9xMTg4aNcXEscwJwOo--kDfau9YfkwCbcJL1g@mail.gmail.com>
Subject: Re: [PATCH 0/5] mm: unify default compressor algorithm for zram/zswap
To: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Huacai Chen <chenhuacai@kernel.org>, Minchan Kim <minchan@kernel.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, linux-mm@kvack.org, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2024 at 7:56=E2=80=AFPM Kefeng Wang <wangkefeng.wang@huawei=
.com> wrote:
>
> Both zram and zswap are used to reduce memory usage by compressing cold
> page, a default compressor algorithm is selected from kinds of compressor
> algorithm as the default one from very similar Kconfig, also both of
> them could change the algorithm by sysfs interfaces, so unify the
> default compressor algorithm to cleanup the default algorithm chosen.

Both zswap and zram *can* be used for compressed swap, but zram is a
generic block device that has other use cases, see
https://docs.kernel.org/admin-guide/blockdev/zram.html.

For starters, making zram depend on SWAP may break some of those use cases.

Otherwise, I don't immediately see the benefit of unifying the config
options for two independent subsystems just because they both use
"compression". The reduction of the config options is nice, but in
this case I am not sure it's doing more good than harm. Also, most
people use either zswap or zram in my experience, so they don't really
have to configure both anyway.

>
> Kefeng Wang (5):
>   zram: zcomp: remove zcomp_set_max_streams() declaration
>   zram: make zram depends on SWAP
>   zram: support deflate compressor
>   mm: zswap: default to lzo-rle instead of lzo
>   mm: unify default compressor algorithm for zswap and zram
>
>  Documentation/admin-guide/mm/zswap.rst     |   2 +-
>  arch/loongarch/configs/loongson3_defconfig |   2 +-
>  drivers/block/zram/Kconfig                 |  44 +------
>  drivers/block/zram/zcomp.c                 |   3 +
>  drivers/block/zram/zcomp.h                 |   1 -
>  drivers/block/zram/zram_drv.c              |   2 +-
>  mm/Kconfig                                 | 134 +++++++++++----------
>  mm/zswap.c                                 |   8 +-
>  8 files changed, 83 insertions(+), 113 deletions(-)
>
> --
> 2.27.0
>
