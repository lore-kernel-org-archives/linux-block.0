Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E17637C
	for <linux-block@vger.kernel.org>; Fri, 19 Apr 2024 03:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713498084; cv=none; b=tWwA1/kzlkyJOtqJ7PwHHETrg6dhuC3nhbU4Uo5yG2UtoCy/L+3SOnIBVzy+MbzXvjvHWN/4TjfWDP8Usf2a4q8qCi5UxqHVc2mdPNwqfFUvgyx7CAEeBbjIYw7ibItGGteVAV2RmmiopgqN4UeaxytHZlZPK6Xqo6V0M2l2zSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713498084; c=relaxed/simple;
	bh=MV5rMPY/OVZ3q/hSgZdY6he8BHBsALejO5Qx4Vyeep4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f0Hcst/dj1EqyKyqUcooiRXIZHy1qcfG4/nFU9FyLLVktPGAwhs8SshwLSupl45ojXcQWgTXlYJUZqETzlFLMD2UIwpftS0l7u71Tmd6Cor8WVIRRem6KpLv3P1cWuXVNNrAFfng5LCFzNMsqS0dR+0w7LgHZ7QbvkMDzQtAdIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=P4DDbXds; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="P4DDbXds"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6ecee1f325bso1496803b3a.2
        for <linux-block@vger.kernel.org>; Thu, 18 Apr 2024 20:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713498083; x=1714102883; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=COoLcotltF9EK9RVxJ+lFaTxE0a/sLD2/8TlJCAzA3Y=;
        b=P4DDbXdsyZgvqrP316oQ9NZm2UpvvOQsO9dCnzZKMhaoKJyuyf14lGjgsVFZKT01mI
         JeTQiHtADkvWFS4uxMms6zUtSnfQY6byjalMzD/+3iFyAIbjemMLUtEAS+qr9cisy+mp
         usF6dlW91vB51C7JrPKKHB+HDKw/RK5YH9vYM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713498083; x=1714102883;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=COoLcotltF9EK9RVxJ+lFaTxE0a/sLD2/8TlJCAzA3Y=;
        b=NzCXxv0anUYb38Y6pRoA/uyMYL1LVZGtDCTGZtSiQgRWMeNjJj8HraUuIUHnXR2byt
         DpoHYEqk24zFxkrof0f80dlJIv6hvk/q/svHHNt9AHPPH+0r+LTKj1vQG5GlNwytJdZj
         57m7i6TGvrO6R0FPuVdMJit6YTW+8sN4pKZi5RULGy08zQPCiKpWVQF9DAcmAcqZJ9fw
         qtD0/dkQrO6F7hdtNov2Ag2fzhjUW3cEYVdjRqD0xeky0iNDtt1PEytcW/z+FDzTlAal
         d6y+W91ni8NoYgSVtV8xMdi88AiED8MmbDQLjiI9ibbnbUOB2K8lgKGUYb9lwi109aWX
         Br5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUlHvdKd73OOO9+i/Aier7twYQGh3yV+J35/PLcVGL1s8mFcpzYrqw8mNfLqJS8S5HxoJQKVIvBP5TiNXj1sTljtknijdJiSKzi0L0=
X-Gm-Message-State: AOJu0YzDl6PSiK57D9vVhyuXrDRS6zuQnOBRvxH1qgs/c87A1Zc0hVIO
	cXJKV4vfBGZ/m/Kxeu9B96Kq5ZMqnFtR6ylETMOAg5JhtDN+S4990VgCefVfhA==
X-Google-Smtp-Source: AGHT+IGptQUDr0GtgR6YqlMV7RNEKqHhWmpEoHOI7r2leH1Us40P2W30NLbStJhoscYlCtlUKYOaKA==
X-Received: by 2002:a05:6a00:ac2:b0:6ed:cd4c:cc1a with SMTP id c2-20020a056a000ac200b006edcd4ccc1amr1366733pfl.8.1713498082846;
        Thu, 18 Apr 2024 20:41:22 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:8fac:640b:67dd:99fa])
        by smtp.gmail.com with ESMTPSA id z17-20020aa78891000000b006ecf217a5e1sm2248287pfe.189.2024.04.18.20.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 20:41:22 -0700 (PDT)
Date: Fri, 19 Apr 2024 12:41:15 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Barry Song <21cnbao@gmail.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	akpm@linux-foundation.org, minchan@kernel.org,
	linux-block@vger.kernel.org, axboe@kernel.dk, linux-mm@kvack.org,
	terrelln@fb.com, chrisl@kernel.org, david@redhat.com,
	kasong@tencent.com, yuzhao@google.com, yosryahmed@google.com,
	nphamcs@gmail.com, willy@infradead.org, hannes@cmpxchg.org,
	ying.huang@intel.com, surenb@google.com, wajdi.k.feghali@intel.com,
	kanchana.p.sridhar@intel.com, corbet@lwn.net,
	zhouchengming@bytedance.com,
	Tangquan Zheng <zhengtangquan@oppo.com>,
	Barry Song <v-songbaohua@oppo.com>
Subject: Re: [PATCH RFC 2/2] zram: support compression at the granularity of
 multi-pages
Message-ID: <20240419034115.GD14947@google.com>
References: <20240327214816.31191-1-21cnbao@gmail.com>
 <20240327214816.31191-3-21cnbao@gmail.com>
 <20240411014237.GB8743@google.com>
 <CAGsJ_4yKjfr1kgFKufM68yJoTysgT_gri4Dbg-aghj70F0Zf0Q@mail.gmail.com>
 <20240411041429.GC8743@google.com>
 <CAGsJ_4wdBtoBUbwmDs+FnPvinG-PtKKY7SzOinr_6DzrZ22_0A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGsJ_4wdBtoBUbwmDs+FnPvinG-PtKKY7SzOinr_6DzrZ22_0A@mail.gmail.com>

On (24/04/11 19:49), Barry Song wrote:
> > > This question brings up an interesting observation. In our actual product,
> > > we've noticed a success rate of over 90% when allocating large folios in
> > > do_swap_page, but occasionally, we encounter failures. In such cases,
> > > instead of resorting to partial reads, we opt to allocate 16 small folios and
> > > request zram to fill them all. This strategy effectively minimizes partial reads
> > > to nearly zero. However, integrating this into the upstream codebase seems
> > > like a considerable task, and for now, it remains part of our
> > > out-of-tree code[1],
> > > which is also open-source.
> > > We're gradually sending patches for the swap-in process, systematically
> > > cleaning up the product's code.
> >
> > I see, thanks for explanation.
> > Does this sound like this series is ahead of its time?
> 
> I feel it is necessary to present the whole picture together with large folios
> swp-in series[1]

Yeah, makes sense.

> > These partial reads/writes are difficult to justify - instead of doing
> > comp_op(PAGE_SIZE) we, in the worst case, now can do ZCOMP_MULTI_PAGES_NR
> > of comp_op(ZCOMP_MULTI_PAGES_ORDER) (assuming a access pattern that
> > touches each of multi-pages individually). That is a potentially huge
> > increase in CPU/power usage, which cannot be easily sacrificed. In fact,
> > I'd probably say that power usage is more important here than zspool
> > memory usage (that we have means to deal with).
> 
> Once Ryan's mTHP swapout without splitting [2] is integrated into the
> mainline, this
> patchset certainly gains an advantage for SWPOUT. However, for SWPIN,
> the situation
> is more nuanced. There's a risk of failing to allocate mTHP, which
> could result in the
> allocation of a small folio instead. In such cases, decompressing a
> large folio but
> copying only one subpage leads to inefficiency.
> 
> In real-world products, we've addressed this challenge in two ways:
> 1. We've enhanced reserved page blocks for mTHP to boost allocation
> success rates.
> 2. In instances where we fail to allocate a large folio, we fall back
> to allocating nr_pages
> small folios instead of just one. so we still only decompress once for
> multi-pages.
> 
> With these measures in place, we consistently achieve wins in both
> power consumption and
> memory savings. However, it's important to note that these
> optimizations are specific to our
> product, and there's still much work needed to upstream them all.

Do you track any other metrics? Memory savings is just one way of looking
at it. The other metrics is utilization ratio of zspool
	compressed size : zs_get_total_pages(zram->mem_pool)

Compaction and migration can also be interesting, given that
zsmalloc is changing.

> > Have you evaluated power usage?
> >
> > I also wonder if it brings down the number of ZRAM_SAME pages. Suppose
> > when several pages out of ZCOMP_MULTI_PAGES_ORDER are filled with zeroes
> > (or some other recognizable pattern) which previously would have been
> > stored using just unsigned long. Makes me even wonder if ZRAM_SAME test
> > makes sense on multi-page at all, for that matter.
> 
> I don't think we need to worry about ZRAM_SAME.

Oh, it's not that I worry about it, just another thing that is
changing. E.g. having memcpy() /* current ZRAM_SAME handing ling */
vs decomp(order 4) and then memcpy().

> mTHP offers a means to emulate a 16KiB/64KiB base page while
> maintaining software
> compatibility with a 4KiB base page. The primary concern here lies in
> partial read/write
> operations. In our product, we've successfully addressed these issues. However,
> convincing people in the mainline community may take considerable time
> and effort :-)

Do you have a rebased zram/zsmalloc series somewhere in public access
that I can test?
