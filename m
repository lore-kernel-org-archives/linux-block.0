Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D5F4689
	for <linux-block@vger.kernel.org>; Wed, 27 Nov 2024 04:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732683154; cv=none; b=g+UHTMPddj2BZimShrGu14vfXu6m3BRI5E93D9pR8Nlc+a9tp1T0GhOQgupJCqNxUfdW2b3A9HAQ4Gw+JvMBfRaLgfMEdJZc+xzALx1212tKXOI/JK0as27K0tcaq2hhmZHhf2mAO62seokaAjcHwQLUtWf6CoUyGNTjvlSEJ3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732683154; c=relaxed/simple;
	bh=GELYA9wTAXhMSGcsmdKZCc+Dc9ucb7cWRhg2i6IHIMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SGMy5LKBqZP1/VlX4TUp9os1ih3blutakSZ9ULCMUQSWwifyjutdSxU5FeCH5pxdsFDtpIitFzCgw/Rn56ZmiFhBQA3k6a/b5qkVX8mN10y6jlbTMPJ+owg5B0WjfOfCJQAxAuu8d7ohWsix53X6zE25DmgR7DVS7hvihMuKbuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FQAIltwQ; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FQAIltwQ"
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3ea55e95d0fso1091514b6e.2
        for <linux-block@vger.kernel.org>; Tue, 26 Nov 2024 20:52:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732683152; x=1733287952; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=z69UMzqeol1IWD5ILb806Pk7wLeAX+Rnixn/3FIcMLk=;
        b=FQAIltwQZu+eHKdfOOZQ1RpKKGVbAJIFLEpY/1qmIEI9LClwhvjSTejFm5KGQusBN7
         HBpwchvBljNjsqMMuOztpEUWJE7QohJf3EJOknLuyUi+FHpZh1ZLVYXn2117UXg8Fbxx
         ByUqFALJico7uEFOpqhu2VynKeZMludhFDqBI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732683152; x=1733287952;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z69UMzqeol1IWD5ILb806Pk7wLeAX+Rnixn/3FIcMLk=;
        b=WYY72IUasvC1UsmeTvSz7SI1wTG35/TJPXkHRO2iDtNCVppEi3yGr3HB8cRZH/LQoa
         45OMA9r1KkM94AoE8aDM7AoxH4eqTQMe6fEwewpGLBqIprfwhowjy2YaKyZb3SvKR0Cj
         irnadaIHxo/t1OYLVCSp10YQB6HYNj7JV1P0hrhdTRkIIpjJrf2ndx3FOK6cficmnLPO
         d8cCHme8aJg26WN4Gq00xO1B69zzRUG2eA742iytgBOK1V/bb+X4kUOTyHYeoaxPL5Xp
         11v8a7HUTKOHKGhN51CcYnj/3SW7aiR8crJPdbrQhpU3nOvNFJmDr4czroN4RGMRtXBv
         MVpg==
X-Forwarded-Encrypted: i=1; AJvYcCVP0PHwRRh2fRzX6BHQDkg3VL9sUzTX5rYa+tc15UjVADdouoIHbXazBeGHn+bE4goZhk+mTEGm1/VzOA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzfyBj+2LIvrsYcReJqn9+WQgGhI6Z0w7jXfW31zlLLgOCWMQIP
	A6/8/zMiZ8nvFQvFP4aJADgiso99TsMXBQz4ESReHBDlIvIKuIwHoBWNZXlsYw==
X-Gm-Gg: ASbGncsoQaV8olypbGRd88taJI3UIwLm4PCpNCiq0O1fu//bD8k4UHfd9ZmK+ol3+p9
	qQlQXRjZV5ytlvfAQoBYVrjMyTbNu2sdVuvwMRLA8YwXszA6RjuRDCsjaFcO2T98cVThLp1dQ+M
	eKFsy9hgb5UeIwFtcpXY2iyw5W0AMSMEXqIY1nfNoAGuYrH4h4dKnqm39lAaHinRQ1x+SN12sig
	+okvpYHbm+CFgPJJLA6VBFTSp0G+wkdAg5KV3MW7OfAkZ86C77otA==
X-Google-Smtp-Source: AGHT+IEFX6h+L0daWFK8yJBkoXQpIAAzSGJOv1MG9EkZoRksU5/Y6YZrI63cmmZAPQ7BtBeS03+jhQ==
X-Received: by 2002:a05:6808:d51:b0:3ea:5be6:a697 with SMTP id 5614622812f47-3ea6dbdfe3fmr1606964b6e.13.1732683151825;
        Tue, 26 Nov 2024 20:52:31 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:cda8:c605:6e79:8b60])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fbcbfc0857sm9655057a12.10.2024.11.26.20.52.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 20:52:31 -0800 (PST)
Date: Wed, 27 Nov 2024 13:52:24 +0900
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
Message-ID: <20241127045224.GF440697@google.com>
References: <20241121222521.83458-1-21cnbao@gmail.com>
 <20241126050917.GC440697@google.com>
 <CAGsJ_4z8BM3SwSsjUd5LMA82y-Ju9Bgo_re18wW2k-nKpLWXyA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGsJ_4z8BM3SwSsjUd5LMA82y-Ju9Bgo_re18wW2k-nKpLWXyA@mail.gmail.com>

On (24/11/27 09:20), Barry Song wrote:
[..]
> >    390 12736
> >    395 13056
> >    404 13632
> >    410 14016
> >    415 14336
> >    418 14528
> >    447 16384
> >
> > E.g. 13632 and 13056 are more than 500 bytes apart.
> >
> > > swap-out time(ms)       68711              49908
> > > swap-in time(ms)        30687              20685
> > > compression ratio       20.49%             16.9%
> >
> > These are not the only numbers to focus on, really important metrics
> > are: zsmalloc pages-used and zsmalloc max-pages-used.  Then we can
> > calculate the pool memory usage ratio (the size of compressed data vs
> > the number of pages zsmalloc pool allocated to keep them).
>
> To address this, we plan to collect more data and get back to you
> afterwards. From my understanding, we still have an opportunity
> to refine the CHAIN SIZE?

Do you mean changing the value?  It's configurable.

> Essentially, each small object might cause some waste within the
> original PAGE_SIZE. Now, with 4 * PAGE_SIZE, there could be a
> single instance of waste. If we can manage the ratio, this could be
> optimized?

All size classes work the same and we merge size-classes with equal
characteristics.  So in the example above

		395 13056
		404 13632

size-classes #396-403 are merged with size-class #404.  And #404 size-class
splits zspage into 13632-byte chunks, any smaller objects (e.g. an object
from size-class #396 (which can be just one byte larger than #395
objects)) takes that entire chunk and the rest of the space in the chunk
is just padding.

CHAIN_SIZE is how we find the optimal balance.  The larger the zspage
the more likely we squeeze some space for extra objects, which otherwise
would have been just a waste.  With large CHAIN_SIZE we also change
characteristics of many size classes so we merge less classes and have
more clusters.  The price, on the other hand, is more physical 0-order
pages per zspage, which can be painful.  On all the tests I ran 8 or 10
worked best.

[..]
> > another option might be to just use a faster algorithm and then utilize
> > post-processing (re-compression with zstd or writeback) for memory
> > savings?
>
> The concern lies in power consumption

But the power consumption concern is also in "decompress just one middle
page from very large object" case, and size-classes de-fragmentation
which requires moving around lots of objects in order to form more full
zspage and release empty zspages.  There are concerns everywhere, how
many of them are measured and analyzed and either ruled out or confirmed
is another question.
