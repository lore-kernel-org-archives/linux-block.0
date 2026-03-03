Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A837934F46E
	for <linux-block@vger.kernel.org>; Tue,  3 Mar 2026 16:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772557154; cv=none; b=Hg7VbBoWo3lRLxswWhZzc7WPQFN6bKCyepR2snKMoUOq667XR7yOadVXlBV/kHfxvAhbMi7535BCuWkCHc846oGcU7HQmXeqqEgfikRxt9auSXsWvtOtKmV8b7E8JENi8GT8MWO6r8t0mRqki8HtpjQ9jPEPoWuMh74BCCnLbu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772557154; c=relaxed/simple;
	bh=Vv8oBh6u29fah7cqUz/BRbt9XhR+uNSS5yLEIDzcwhU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ohf+e7CV7M4ZRMDsqyXm4eAWZmUF5xL/mDx2UaGjDA2wi266MtE+fvrw/dckjXaCJ/cx0nMjIjWy/okP227qBf86uGgIaWul0B8lE0h+zKBDg8rW3qf7gYm3rQPbpE2LXXathYm54xSRS0v7Ezk9upMZk03V8x6nxV4iKEm7CLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=Y0rgovww; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="Y0rgovww"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8cb49f63238so321291085a.0
        for <linux-block@vger.kernel.org>; Tue, 03 Mar 2026 08:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1772557151; x=1773161951; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6FEv90vReHYT0L9srNroqmwLlfOuALvxi8SW9QHvPXM=;
        b=Y0rgovwwKIbT6GfHwNbuTWGqZYkSHyDjsJIit1KFsls01XWCgbxyor7/MKd/FVUKK0
         EnrGrkYkCLvD8Crcb92LhQq3s7A8N/wc6Pm/LvrkoX+2ZRmSHuAtNsLEAzeatqHp3+44
         3lOJRak1eRZ4AS/NOgYBNawTxpNI4dRAmsJDPKATbA2d1dgRScXBjexkocX0wtS6GK1/
         PKukcuX/N3Il29DODhhbZ4N+1dq+SKTdsopK97Ke9aCgln73eWwjz6qROw7p9luZqENM
         dq+da8FYuc0Sk3ph7a98IHtt+h02OK1simO7TRVi/vwi0glxNepDM1lfD7J+UeVagM6k
         5rNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772557151; x=1773161951;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6FEv90vReHYT0L9srNroqmwLlfOuALvxi8SW9QHvPXM=;
        b=YLnPGYyWJe0OzrHgs5GoWwFngUh0gLNFKUZ8ODCTpMVP4PK1nxGN39XbAsZlRC2c8R
         R8ClOdl15eP5tyocxdgV9YaMDP9iYS1ljxWNu2dsARGEFbaR0O1eRrDTxxUyjeL5IZGc
         vH66pi8T89oLMnSM4mSdCMeiRO5nbFk1cOiiPa0g+wElNHttwsco/cmSyeTXkk0uTNLb
         /sVYuymU3Whiab0ys0uNM62eiim2UyGAWA1bl78CzTFlijhm7P1sdtrUdTPqSXKb0ihe
         7l1syUr9mvnfq7nuDdfQhm2uVft1if9FvZYDpir3ESMzqQzhCr057fWOqKTkcoouJDuu
         3/bA==
X-Forwarded-Encrypted: i=1; AJvYcCXSUPeFv/px0fpDYKFTWOYzal2PlKxmGKOLD7nVtQHdKbM92StZiTeuRp+qOOglgFmVJR4Vn83lbwKtlg==@vger.kernel.org
X-Gm-Message-State: AOJu0YypGb6UQgmYRANrx/QonsHTm2mPiUsWklON/3LMRzYW9oZwRKHJ
	/eOJACrxSNGp1Jxe2zbCAKbWBhL5YyyD/1IdVshDX8Nxwbj0u0iGlvNjYGcxmmG2aiM=
X-Gm-Gg: ATEYQzzXSwyoEfcKGAsqp4MZ+cxUWPseWeaZojQpAeDgZANW5qXw9J/t6ocSeE5Q19F
	a2wHlRSRlGJZ5EYDi7p5fZ3RwVzRHqkmEClg+zcn1TK0a3eh8hb/CgHBNedt5g44kMBupRlDdKQ
	XRlnNa9IsBtds4Tqs72OLbeuSMxvJTmPs2yVe2vO6tZ1Ue8XVd+vXQMkYE2zLy/5wcfITVsJxhT
	SXuYVD1itWuyUDHgz36D1tp9Pz+iqbXoYfDwYW0gPK2Js1b/oGuaNxaJkrMq2IFSNPlQf/Xr7ta
	M19V5dateRNTXk5J0yxsifGjPmhqchuYXHKX3PTv+AFoK5FCPM9peqY6yrpTN77C+XEJWZR+D7Z
	e/hb3jW7g8yHoWHCoGSn4szTaSoTj7Bi+GRwSmijA26pPQiG9B10sfeODqFPhD1CCbnbhomUp/+
	dAVh4/88B18e22b96MpF1kmEVdZ03uLnnx
X-Received: by 2002:a05:620a:3707:b0:8b2:6606:edaf with SMTP id af79cd13be357-8cbc8f16224mr2082525085a.37.1772557151379;
        Tue, 03 Mar 2026 08:59:11 -0800 (PST)
Received: from localhost ([2603:7000:c00:3a00:365a:60ff:fe62:ff29])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cbbf7161fcsm1414410985a.33.2026.03.03.08.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 08:59:10 -0800 (PST)
Date: Tue, 3 Mar 2026 11:59:07 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Matt Fleming <matt@readmodwrite.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jens Axboe <axboe@kernel.dk>, Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>,
	Barry Song <baohua@kernel.org>, Vlastimil Babka <vbabka@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>, Zi Yan <ziy@nvidia.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, kernel-team@cloudflare.com,
	Matt Fleming <mfleming@cloudflare.com>
Subject: Re: [RFC PATCH 1/1] mm: Reduce direct reclaim stalls with RAM-backed
 swap
Message-ID: <aacTW_FEp6c1coDf@cmpxchg.org>
References: <20260303115358.1323188-1-matt@readmodwrite.com>
 <20260303115358.1323188-2-matt@readmodwrite.com>
 <aabrv_xrsKPx9jZf@infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aabrv_xrsKPx9jZf@infradead.org>

On Tue, Mar 03, 2026 at 06:10:07AM -0800, Christoph Hellwig wrote:
> No way.  Stop adding hacks to the block layer just because you're
> abusing a block driver for compressed swap.  Please everyone direct
> their enegery to pluggable zwap backends and backing store less zswap
> now instead of making the zram mess even worse.

+1

The virtual block device idea seems simple and attractive at first
because, hey it looks just like any other swap device, and the block
surface is so much smaller than the MM surface.

But compression is a *memory* consumer. A big one. And with swap it
sits in the reclaim path. So now you have to solve intricate MM
problems with the block layer in between.

The effectiveness of compression as a reclaim strategy is also highly
variable and dependent on page contents, so the static properties of
the block device abstraction are a poor fit for the problem space.

I'd propose the following:

What keeps users in the zram camp is disk-less setups.

What keeps users in the zswap camp is reclaim-writeback, cgroup
accounting & control, and the prospect of fully dynamic sizing.

There are ongoing efforts to solve zswap's disk requirement and with
it its dependency on static address spacing.

The gap on the zram side looks wider, and more awkward to solve given
the block layer intermediary. And it's already 2.6x the SLOC of zswap.

So I fully agree. We should try to make zswap the single compressed
swap implementation. It would simplify things dramatically for kernel
developers working on MM and the swap subsystem. It would make things
better for users too.
