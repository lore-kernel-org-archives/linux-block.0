Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BBC3C2BAF
	for <linux-block@vger.kernel.org>; Mon, 19 Oct 2026 05:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792389332; cv=none; b=YHL1kjhDPoKcnWKr9fnWxkknEdPVj0twkJOlIuZ2hTQSXr52cMzp01qz+nZuhReuSXyJFHa8J3DQU2xuC/SbUlA8GEjXKdpFtPm1d2IZcMonV+NFsz4/qXyjwpDt5PL27vmhK3Pe4Rke5cJKXaaKTS+TBgD0Cmy1DPjvK0hklOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792389332; c=relaxed/simple;
	bh=vbBdaLoopUUlhWVw+UGt5lKN4LEI/dUgN1+9SCpkx4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YuP+hGx1riM5l8PHLsPyloHHkvR7fMYaO4dC4411XF2HYGIptmXUj1MRjgEg4wh2jlQhnmByhW3IiU+Qo8vNQEhQrqpBOEhoyM4mimCAdYNAnUEzTtgnp71VoUxUvf6BcRW1bq2HkUseOap+FDbk7UZImdvUorJCeQm0B71dMjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=J5g9bP7o; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="J5g9bP7o"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3a7cfe8f761so1831586a91.1
        for <linux-block@vger.kernel.org>; Sun, 18 Oct 2026 22:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1792389331; x=1792994131; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qdtOUxXRF05TEuV+l00U15wQDymBAePZDceRfWQ/v5c=;
        b=J5g9bP7odmuRh9pcHB4bqUUShXo1EGdolJyt/AEb8v9T96z9d8iO3VcxkA28JU/y46
         Obs86UndaaJZ3ZqJFmkBOLHwsSNAHUuX0m1hyglQQoijr1QoOFqJcMjtPArtPm/FEJ0I
         JTHX69JbWvfHdjy9srk5kc8oPQD6cHMaFGU5w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792389331; x=1792994131;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qdtOUxXRF05TEuV+l00U15wQDymBAePZDceRfWQ/v5c=;
        b=WEquf8Wz0sesOKCNLGuPydAwyvCM7fYQ7mwBGreZyEWhe7PR3LtrmSTh5FTpQndphL
         7qb9fxtsD3ecu/o4zB+nERn8r3EKK5t+MTwwIkUajh3Ax52ZDIMawphQWP8YSUFWC9tR
         pRT6+IzVx836BiLS426u/gRumQrugbPVSXFkv+c1QO51DV3xtuvJs3GMGZuOXaUhr8A4
         Kw/oCpVXF7grrlQsBDYjOQ9126YisfTUwTvmty9Q78ph81wBadQBrK7mX+nev5BMQ/dU
         1/1KS/1kNSR51uubwLD+oHAn+1RyAYP0jglnfgeGsKX43lj00T/wRBVeWwfXrI5+q4IN
         44QQ==
X-Forwarded-Encrypted: i=1; AKwUvBw0o0+HpRS0rp9ATe+NG2VAoA/CzoM2O9iTr8tDIWrUxTBKJOW1wb61H86S+fX1B+f3Nl+FkpRu17g/3g==@vger.kernel.org
X-Gm-Message-State: AFq9FYKxzmRWUawFBqM21gYlbvpymD9jmtqk28BNcYdltED4Zd5JFl5B
	xH9gjZpGBk2nL0etkKQVSxwHpe8usUx6cOGEncaEf5DBVT/odG4gLMXoJrVc2MwjAg==
X-Gm-Gg: AYBFou2exnyRr/Z6j/zhooOeyJ+e2uXH3ahJBCPIK05FNU6VlBWkQ9Z2zf2RqzC/s2F
	9ZSGylg28OGCd2ZhfoWAu5Pkom9wCqUXG82kwLj/8cYBHwwed0/79iHm5YtiqDqbGfVXg8xoCZP
	wxSPbLXVlGNtfK3zvg3BXQcZ+AjJtK/S6CO7eSKc2c21OoDPBh8gjTg3BBWMcPVYm4J7A0jHzID
	JkVJj4D4w6s+hlaoht+rINpVA3QPjW31X5bvmw+CSm0Nx4XwrwHiiif5AYzBh+kErgg3YOji+bE
	8RYOM6nOpjiC2OVp1THtbn9OCj8IzJC68+UN1dwb9WnAIFmYFHCz/xY1mGpLZeAb8uvgvrUF+RH
	EhY/44s6GB9WT4fqJCyZGVFLclKYstXxorqNaq6YSELwrOCrtoc2eLTIQTWpkK61Vp1xwN6PvxB
	guvLukjFEejGGrf+gbacs+H+V/la4TYTePLzgvkGXjeYgPWY3OXBzHIM5xFXoM2gHabtqQUZNd5
	VKwrj9VFvS5tBBKhKHYqXBTwNJnORyFdK52R6ZSUOuB5Xvv3b41owjqwvqANSmGPt/w5Ouejbyr
	TYx7fBDpfddqJXvuIwg9YZnmPDmKReuy3BX6Iy/e
X-Received: by 2002:a17:90b:582f:b0:3a6:e9bf:f244 with SMTP id 98e67ed59e1d1-3acee275f7dmr4044584a91.1.1792389331013;
        Sun, 18 Oct 2026 22:55:31 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:7b3d:f4ff:823:5963])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac94627250sm19129769a91.8.2026.10.18.22.55.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 22:55:30 -0700 (PDT)
Date: Mon, 19 Oct 2026 14:55:27 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Bo Zhang <zhangbo0325@gmail.com>
Cc: senozhatsky@chromium.org, akpm@linux-foundation.org, baohua@kernel.org, 
	bgeffon@google.com, minchan@kernel.org, richardycc@google.com, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3 10/11] zram: use rw_semaphore for decompression streams
Message-ID: <atWwtdGez8Rjq5ht@google.com>
References: <atHftz13hWzGludk@google.com>
 <20261016134847.1620103-1-zhangbo0325@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261016134847.1620103-1-zhangbo0325@gmail.com>

On (26/10/16 21:48), Bo Zhang wrote:
> On Fri, 16 Oct 2026 17:54:25 +0900 Sergey Senozhatsky <senozhatsky@chromium.org> wrote:
> > A quick and dirty patch, as usual, just to play around with.  This
> > attempts to improve the reader side, because the reader is side
> > much more sensitive.  Tested only with zstd.
> 
> I applied the cross-CPU borrowing patch on-device and re-ran the same
> zstd Android A/B, so it can be compared against the preempt-disable
> numbers I posted earlier. Focusing on the read (exclusive decompression)
> side, which is what this patch targets:
> 
>                         9+10+kmalloc   preempt-disable   cross-CPU borrow
>   dexcl_contended       15,919         54                1,447
>   dexcl_wait_ns_total   109.6 s        0.68 s            3.66 s
>   dexcl_wait_ns_max     145 ms         34.6 ms           26.6 ms
>   dexcl_avg_wait        6.88 ms        12.6 ms           2.53 ms
>   dexcl_acquire         2.21M          2.75M             2.94M
> 
> Borrowing clearly works: dexcl contention drops 15,919 -> 1,447 (-91%),
> and the residual 1,447 are the genuinely all-CPUs-busy cases that fall
> through to wait_event(). More importantly for us, the worst case and the
> average are the best of the three - max 145ms -> 26.6ms (-82%), avg down
> to 2.53ms.

Thank you Bo!  I included your numbers into the commit message.
