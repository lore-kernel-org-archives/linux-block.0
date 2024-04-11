Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E455D13BC01
	for <linux-block@vger.kernel.org>; Thu, 11 Apr 2024 04:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712808878; cv=none; b=YpdFu/RMX4sZ0Z/T6ArSQfx3Svatq5hTHM0h0q5Rlelklx40+uWTQWZDvhmB8lC1tOgRsiakpGggzi0f+bj/nD2C8oxSILy2VQriI607IcTUdI4+Lod+NqWKcBAoUsHPLtq7oMa/1bjhRYQREfWBjuumdqY9JrOlFTpN0j7Rs/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712808878; c=relaxed/simple;
	bh=CE0muciGI0euYifqkEnr9r2ip4cvQe/XVjrbK70K+ac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QePe14aOP7Cwvd1/6PrNzZN0dsvD4I05ovybFX1oz88y5f/t5E2Ov3V+UPJAzQOb/fhGnYKzwoFBUR0qpnx3yAOhI25ym4kF0gx2i/uSmWtwhcMhIq6FxDZ3YBzmOhX2VkeW1p6MTGkBglJPQ8maHquFhI/tMIfXV2rV3taic/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=eWTxqMJK; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eWTxqMJK"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1e2c725e234so3593925ad.1
        for <linux-block@vger.kernel.org>; Wed, 10 Apr 2024 21:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1712808876; x=1713413676; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QRpoNsjOK6j5XqQ61OspVBmQJ87V0XiHLogvxYX/tbU=;
        b=eWTxqMJK3Tpv8DeBp0Ze0zWa4e/e15bpFGcsk1wmb+WkYqFMBIpthB+g12wob9cM6Z
         CRMNT58Rrz46A2UgIVQeAoOFmARMlSgLZQjy7lkDzh24ytXBneamKl1zSNknYLH8oPZs
         dh5dy5wOZpZ8fQ1pyL1sOOhcqXKAyRpOLnGYI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712808876; x=1713413676;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QRpoNsjOK6j5XqQ61OspVBmQJ87V0XiHLogvxYX/tbU=;
        b=wQDOLMU5PsNn2jpK+L91NopWqLnzeM/D86rlaYwZLu4QTUHppdOk+eHCetGSWVWr+s
         IPMzgRrrQlH8wpyJpA/hU9/DeRCPP6W+0lwHpHzzx1544PFoIvJ3yfmcoxAuOHN+nRAq
         WyL8AHLLP6FBnwuXUBFxLwPfff4VMODlmX5c7G/Z1+4nbZXVyaUYA/46u103suPIXLdq
         5ppmifCSVyX5jbxE3yRoxFDvfiIFRP5EyjMeP7hqCzJi9MlocOkjMzLc8vZtte0sVv4k
         WNi+8tYK5/Ua/kcU0O+H4rX9AfSmoj/ItKHL4JgTVJrTjDQ6SNKC2SDnw9c1k3vSPkak
         A2Yg==
X-Forwarded-Encrypted: i=1; AJvYcCUx4xqybp7+/9b9SMDsjJmOxJgovkZLxJxPW3lreEIfeAgDEpu9tLYH3ligBVIQzVRH0LtdfPErYDRJumKX7a4I4afWB+f6/E5HhrM=
X-Gm-Message-State: AOJu0Yy8X3+DjPLTV/xg9vV3Wj0Dz91D1ijpECc98of/yx2STLts7sQU
	kmHDq6rrHo9k0NAk1XYB2mCECFtQXPkXj3NMkISZp9gJli7+ak+3xnltgfG2/A==
X-Google-Smtp-Source: AGHT+IGoydN9224pn35l5jD63mMzmg3BIpFzF/YZMufBNif8aUBovCp+Y1xf/odqVVg4Olh9jDdbLg==
X-Received: by 2002:a17:902:ea02:b0:1e3:f622:f21a with SMTP id s2-20020a170902ea0200b001e3f622f21amr2122851plg.24.1712808876099;
        Wed, 10 Apr 2024 21:14:36 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:f30d:f29e:acb:4140])
        by smtp.gmail.com with ESMTPSA id m7-20020a170902db0700b001e446490072sm350021plx.25.2024.04.10.21.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 21:14:35 -0700 (PDT)
Date: Thu, 11 Apr 2024 13:14:29 +0900
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
Message-ID: <20240411041429.GC8743@google.com>
References: <20240327214816.31191-1-21cnbao@gmail.com>
 <20240327214816.31191-3-21cnbao@gmail.com>
 <20240411014237.GB8743@google.com>
 <CAGsJ_4yKjfr1kgFKufM68yJoTysgT_gri4Dbg-aghj70F0Zf0Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGsJ_4yKjfr1kgFKufM68yJoTysgT_gri4Dbg-aghj70F0Zf0Q@mail.gmail.com>

On (24/04/11 14:03), Barry Song wrote:
> > [..]
> >
> > > +static int zram_bvec_write_multi_pages_partial(struct zram *zram, struct bio_vec *bvec,
> > > +                                u32 index, int offset, struct bio *bio)
> > > +{
> > > +     struct page *page = alloc_pages(GFP_NOIO | __GFP_COMP, ZCOMP_MULTI_PAGES_ORDER);
> > > +     int ret;
> > > +     void *src, *dst;
> > > +
> > > +     if (!page)
> > > +             return -ENOMEM;
> > > +
> > > +     ret = zram_read_multi_pages(zram, page, index, bio);
> > > +     if (!ret) {
> > > +             src = kmap_local_page(bvec->bv_page);
> > > +             dst = kmap_local_page(page);
> > > +             memcpy(dst + offset, src + bvec->bv_offset, bvec->bv_len);
> > > +             kunmap_local(dst);
> > > +             kunmap_local(src);
> > > +
> > > +             atomic64_inc(&zram->stats.zram_bio_write_multi_pages_partial_count);
> > > +             ret = zram_write_page(zram, page, index);
> > > +     }
> > > +     __free_pages(page, ZCOMP_MULTI_PAGES_ORDER);
> > > +     return ret;
> > > +}
> >
> > What type of testing you run on it? How often do you see partial
> > reads and writes? Because this looks concerning - zsmalloc memory
> > usage reduction is one metrics, but this also can be achieved via
> > recompression, writeback, or even a different compression algorithm,
> > but higher CPU/power usage/higher requirements for physically contig
> > pages cannot be offset easily. (Another corner case, assume we have
> > partial read requests on every CPU simultaneously.)
> 
> This question brings up an interesting observation. In our actual product,
> we've noticed a success rate of over 90% when allocating large folios in
> do_swap_page, but occasionally, we encounter failures. In such cases,
> instead of resorting to partial reads, we opt to allocate 16 small folios and
> request zram to fill them all. This strategy effectively minimizes partial reads
> to nearly zero. However, integrating this into the upstream codebase seems
> like a considerable task, and for now, it remains part of our
> out-of-tree code[1],
> which is also open-source.
> We're gradually sending patches for the swap-in process, systematically
> cleaning up the product's code.

I see, thanks for explanation.
Does this sound like this series is ahead of its time?

> To enhance the success rate of large folio allocation, we've reserved some
> page blocks for mTHP. This approach is currently absent from the mainline
> codebase as well (Yu Zhao is trying to provide TAO [2]). Consequently, we
> anticipate that partial reads may reach 50% or more until this method is
> incorporated upstream.

These partial reads/writes are difficult to justify - instead of doing
comp_op(PAGE_SIZE) we, in the worst case, now can do ZCOMP_MULTI_PAGES_NR
of comp_op(ZCOMP_MULTI_PAGES_ORDER) (assuming a access pattern that
touches each of multi-pages individually). That is a potentially huge
increase in CPU/power usage, which cannot be easily sacrificed. In fact,
I'd probably say that power usage is more important here than zspool
memory usage (that we have means to deal with).

Have you evaluated power usage?

I also wonder if it brings down the number of ZRAM_SAME pages. Suppose
when several pages out of ZCOMP_MULTI_PAGES_ORDER are filled with zeroes
(or some other recognizable pattern) which previously would have been
stored using just unsigned long. Makes me even wonder if ZRAM_SAME test
makes sense on multi-page at all, for that matter.
