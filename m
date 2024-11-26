Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411877E76D
	for <linux-block@vger.kernel.org>; Tue, 26 Nov 2024 05:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732599430; cv=none; b=BDvK0xuYHVa+uJAbpobi34OiLjf74qaAW5Cy3Lw8pJrInJpu7Gp7YY7DQBj5NOn+n6tHZfMdiC4iKEd8ldz8rzFaxuLGMnLs7sUircJdtRTUrS22Of2eOn32Zt85ZDLmcoK0gj+HNZJNtendWi1b530g+TImsl10GZ1T/bRCJE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732599430; c=relaxed/simple;
	bh=qtzn69ej/h1iG/E/kvO20JYgyNNptrXvpH4T/ZW/EqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OKbqTQYWCixMYW/y4eiYReyJRNRrYZcV/VB74bynCUMml5m062QUQdvzq/MHyvjiXYEl4gAQ4wOQPhBunq3xWs+nFvXP/H1XBplw0a1xWVBfYMBulHer3NtuzqgABmKNExcCcPpNvNvIZylQp3/HUT1FKFV6m0RdFUV7RhpFWqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=haf3wj05; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="haf3wj05"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-724ffe64923so2469530b3a.2
        for <linux-block@vger.kernel.org>; Mon, 25 Nov 2024 21:37:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732599428; x=1733204228; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OZIs9h93WPrwz+VBwfPbM+vLbBlKmlPavgqCo2DVCiA=;
        b=haf3wj05DDL3p0QT1gYBD2T2PSUP6MKd6VoPf9sC+Eh7Wcfr/eQobKHjphgeKSCL18
         tBsyIUXb2dFGLx4ldE8gLuXJ0f8OpJFxAghqXoCVWyn/PsK2oqvfG//NTgmoW6a0YcgO
         3iOcVV8YjatXv+K86qkFDozBZT0PjqmiskAkk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732599428; x=1733204228;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OZIs9h93WPrwz+VBwfPbM+vLbBlKmlPavgqCo2DVCiA=;
        b=gkPnNdRyZh85mICdWeQQVJq4G9RntM/7/RHy/jBXvjVHv5g/TDzR3FdqiMFjxnTnz3
         wZ+U1MwaKG2h9ed/teV3keMnw5h/khX/ozOvUwCJSvpgp6kiVJTwF1F15RNTgiEEVm4B
         g2C83c/ZffjP27y3bVVdJJWdEsWBJTSp98lqZS7W3YMOZPjatIJgyrPzm0LLShFUPOyd
         s9/EPn9v5u+GM+Tj9U95/5jikVe7eHLslvZQ/cZY+7g5AvdYyqAnw2TC/MLMfahjJnXz
         el4khd82G9BB9qqpOWXQWGCp6N28kH+5d0S8XnAfjUq7yleYJvld4iOMJvH3K5aEuy3m
         OzCA==
X-Forwarded-Encrypted: i=1; AJvYcCXv8cRyCjDAXf6QtsW3Q8BSceH60jhg1N12vtmW/WA9qd1kOPh9sWBiNt2KEnwjEze882G8VprjV2JH4g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyNq3yb+BYJ639ieH2ELp3oydePwMt0QlqeA6YZpZps8ZMSFVDe
	iARf81OOMnUJf2HQrzD+P4FJpxBLEY0stHAyxoTVqi8Bs6U95HI8BDyGiIzUGw==
X-Gm-Gg: ASbGnctsaj1BBSGDfxq06sQ/zsUODo+B5uH9G16jTUefb7fqByN+P/fWpZJ32A42Ll2
	8NxCsgmW8zUH7F2MDUawkhF5fWj6YfjuEryEpfACaAoPRrX0oMq+V5GeoAns62JQ2jgDKreWAy2
	7XPahB4rMQwDuHMdA/6gpvDvtvS1Hlzyird8bSVeEwg/a9Fx1GFV/8oAq5ORepJDj9fKOgGNkyN
	H/BIlv0uzEYSmTZr+fumR+xOPvytq2tk+0t7QqU0wsEXxvfPBwO
X-Google-Smtp-Source: AGHT+IFcmwAYkfd43AO17AjLRO77+cjhEf0Q+v+bMz9ooJo6Oy9pdgPf2JtLOA/9sKzwZCKdSetmJQ==
X-Received: by 2002:a05:6a00:b45:b0:71e:6c65:e7c4 with SMTP id d2e1a72fcca58-724df6a799bmr23337783b3a.26.1732599428408;
        Mon, 25 Nov 2024 21:37:08 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:7631:203f:1b91:cbb])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724de45725dsm7435473b3a.16.2024.11.25.21.37.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 21:37:07 -0800 (PST)
Date: Tue, 26 Nov 2024 14:37:01 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, axboe@kernel.dk,
	bala.seshasayee@linux.intel.com, chrisl@kernel.org,
	david@redhat.com, hannes@cmpxchg.org, kanchana.p.sridhar@intel.com,
	kasong@tencent.com, linux-block@vger.kernel.org, minchan@kernel.org,
	nphamcs@gmail.com, ryan.roberts@arm.com, senozhatsky@chromium.org,
	surenb@google.com, terrelln@fb.com, usamaarif642@gmail.com,
	v-songbaohua@oppo.com, wajdi.k.feghali@intel.com,
	willy@infradead.org, ying.huang@intel.com, yosryahmed@google.com,
	yuzhao@google.com, zhengtangquan@oppo.com,
	zhouchengming@bytedance.com
Subject: Re: [PATCH RFC v3 1/4] mm: zsmalloc: support objects compressed
 based on multiple pages
Message-ID: <20241126053701.GD440697@google.com>
References: <20241121222521.83458-1-21cnbao@gmail.com>
 <20241121222521.83458-2-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241121222521.83458-2-21cnbao@gmail.com>

On (24/11/22 11:25), Barry Song wrote:
>  static void reset_page(struct page *page)
>  {
> -	__ClearPageMovable(page);
> +	if (PageMovable(page))
> +		__ClearPageMovable(page);

A side note:
ERROR: modpost: "PageMovable" [mm/zsmalloc.ko] undefined!
