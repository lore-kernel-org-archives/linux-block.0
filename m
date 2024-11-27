Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A9913A24A
	for <linux-block@vger.kernel.org>; Wed, 27 Nov 2024 05:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732683895; cv=none; b=f58cGx8og2GTUO5I32ZTZJTeOJPBpiT2KKjNC0dRwwrg4Ti4py+o+phwka85F0mBjL4b+GS/bdXZK9LRwpj2hIalLP9WxFzChepGIaJHjwD+OUwKGK0Iowo1qzj4QTGUSpxf+f34J25MucliKBZQE9AB+OW3mwCkNOLa0KOZLqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732683895; c=relaxed/simple;
	bh=u/eH54xtDsWuxKbSNDv6Vxgz0D6zyql7xjPO0KWd/CA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NT0Hpo8VKUSPSsmsF13YZkhk4Elg5UkYCPwrr6C5G3hqu421KbALq1bQKVh+DrhW5KfIWR4hwTZLqwcoxaAK/N+y8Zn4Hc01B2mJh/q5/YeJChtq7ykiroSLg1bncFMVFK9kTiFprQ0krKZ8Uojvu/k5scmbxfcX00g+lzFjln0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=cagm0fEP; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cagm0fEP"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-71d47201b3fso1448668a34.2
        for <linux-block@vger.kernel.org>; Tue, 26 Nov 2024 21:04:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732683893; x=1733288693; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=F9c+Y5f2jAHQ4Swx7mfQpva9qVpb6j1FoF2WaSf7AxU=;
        b=cagm0fEPc/U8YbvM7ZRQ6Fd9GzAi1J7jDTNNdyHAO4jmMfAcS7j4DppClImnkUjffs
         xtShswRZaWZhP94iG6xQkd+1UQAkpBPSPsEBCtekm6zO9eITlQvYvx0EmkLuLffXupXn
         hqmCC4QcC1dncI4mMt5HOOtyV6UCzxZDvINAU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732683893; x=1733288693;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F9c+Y5f2jAHQ4Swx7mfQpva9qVpb6j1FoF2WaSf7AxU=;
        b=SMO4gs5qS4eZdZmhRA3BLLKdMQTEFJqbDoW2A1CmPK3tvd512VniAVGMav62Tl+XFG
         yqHPKf3xiolUBQo/aVY1sz3U/d9XnV45tPutiGj1eNF75m5I/5l9GynVc7mFh7yxQqkS
         ZzFTgDaFlyS8lIA9OKUMd7jDX30/vUb8weVpHwnwhJCDj5Mj3tjqAY0+9qhy0BsCF6Su
         4uA5EnHgY2ovLh6aFgsdLr4/IzN5wzaMVL3X5KmcCxw05rJ3WN0mBFPmGFNz2JBluMQh
         PBUADONDbFIORPDh5yuWvGfUSKjSvCLcGL+iLEjTa2P7n3rpVPyumcICDvTb8swmT6hU
         O6+w==
X-Forwarded-Encrypted: i=1; AJvYcCXfRu+AR+LEYLuvIzL9gyTP9OuQN2OzGh9b9xxSsQJWwpvsl4MoIGwteMGxFiA7IeraTr6JbdFqos/77Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxhYFBIswYA+s1T47D7JZ0QrqL9iDk4wzP4HkCm51x6Ys/H37Xd
	4Z25vlrvCSfXtxUvasrl3A3tJ/feuSDiJIlr0MoU4y4bUl2i5M9t1NKH/UERNw==
X-Gm-Gg: ASbGncs4FP6OI7/EuxkX0iY7trFDSh8RhPtD28Fdj7FCQcH9taDwziSefPBPo4dULKw
	/MNGzn6FTnofftyewDblWmphUnkjjwFf5RjjyC+qpYTdLd0skvxswkMwcQdcZLPX85tnBpGukKX
	by1HJU4aBhCDLZFpBVHHGmHY/GsFpZ7QqbOzMPT3BzBF3NzugV2mZ8JZKsjN8X3PJZsQ1sjhsYK
	gm8nXqrzwSUf2n65d0ruKck0DbgujnmzBODrn2q0mAywbVwlyHbXA==
X-Google-Smtp-Source: AGHT+IFUH/TU6QwHVNcWTTll/6bNgy/3+v7SQl5cBPmYmRbyQJXOKtcTtfuOPhu4Pvbmsxc8XceNuw==
X-Received: by 2002:a05:6830:2584:b0:71d:54fb:da4e with SMTP id 46e09a7af769-71d65c7e043mr1657222a34.3.1732683893233;
        Tue, 26 Nov 2024 21:04:53 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:cda8:c605:6e79:8b60])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fbcc422d0bsm8262535a12.84.2024.11.26.21.04.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 21:04:52 -0800 (PST)
Date: Wed, 27 Nov 2024 14:04:45 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Barry Song <21cnbao@gmail.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	akpm@linux-foundation.org, linux-mm@kvack.org, axboe@kernel.dk,
	bala.seshasayee@linux.intel.com, chrisl@kernel.org,
	david@redhat.com, hannes@cmpxchg.org, kanchana.p.sridhar@intel.com,
	kasong@tencent.com, linux-block@vger.kernel.org, minchan@kernel.org,
	nphamcs@gmail.com, ryan.roberts@arm.com, surenb@google.com,
	terrelln@fb.com, usamaarif642@gmail.com, v-songbaohua@oppo.com,
	wajdi.k.feghali@intel.com, willy@infradead.org,
	ying.huang@intel.com, yosryahmed@google.com, yuzhao@google.com,
	zhengtangquan@oppo.com, zhouchengming@bytedance.com
Subject: Re: [PATCH RFC v3 0/4] mTHP-friendly compression in zsmalloc and
 zram based on multi-pages
Message-ID: <20241127050445.GG440697@google.com>
References: <20241121222521.83458-1-21cnbao@gmail.com>
 <20241126050917.GC440697@google.com>
 <20241126105258.GE440697@google.com>
 <CAGsJ_4w5WSpVUr1yybwZsp0QKapzOLW0qU0+_F-8WJnXKK9_pA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGsJ_4w5WSpVUr1yybwZsp0QKapzOLW0qU0+_F-8WJnXKK9_pA@mail.gmail.com>

On (24/11/27 09:31), Barry Song wrote:
> On Tue, Nov 26, 2024 at 11:53 PM Sergey Senozhatsky
> <senozhatsky@chromium.org> wrote:
> >
> > On (24/11/26 14:09), Sergey Senozhatsky wrote:
> > > > swap-out time(ms)       68711              49908
> > > > swap-in time(ms)        30687              20685
> > > > compression ratio       20.49%             16.9%
> >
> > I'm also sort of curious if you'd use zstd with pre-trained user
> > dictionary [1] (e.g. based on a dump of your swap-file under most
> > common workloads) would it give you desired compression ratio
> > improvements (on current zram, that does single page compression).
> >
> > [1] https://github.com/facebook/zstd?tab=readme-ov-file#the-case-for-small-data-compression
>
> Not yet, but it might be worth trying. A key difference between servers and
> Android phones is that phones have millions of different applications
> downloaded from the Google Play Store or other sources.

Maybe yes maybe not, I don't know.  It could be that that 99% of users
use the same 1% apps out of those millions.

> In this case, would using a dictionary be a feasible approach? Apologies
> if my question seems too naive.

It's a good question, and there is probably only one way to answer
it - through experiments, it's data dependent, so it's case-by-case.

> On the other hand, the advantage of a pre-trained user dictionary
> doesn't outweigh the benefits of large block compression? Can’t both
> be used together?

Well, so far the approach has many unmeasured unknowns and corner
cases, I don't think I personally even understand all of them to begin
with.  Not sure if I have a way to measure and analyze, that mTHP
swapout seems like a relatively new thing and it also seems that you
are still fixing some of its issues/shortcomings.
