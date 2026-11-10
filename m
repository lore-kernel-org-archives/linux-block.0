Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794278663;
	b=hT11JS0BzIbdwE9x3UrjRZsP9HW4cnEeEWs+G7nr7OU1VO14KyS4EEmpJbDeh2f5w2Br
	 b4j5sY35tT+FhBwXnXCn8797jDSCZLu/sloWMpM73Ys7Moy6Ktu+iWpanKcz4fPZ+Vnv1
	 /Dm8xp4xEijkgZ3s6xZPgyMv4GI+njGwDmpJrkrr6iRXFsi7QEN4Tdu5kdOJ6jVR90mTY
	 lDpglKpS9J1QOvBCR8+y1MXbfLRa5/2SxofMRXCr5WphZtkdZUsLSjvkX/XUBe9b52ZXo
	 12ly7MVFBfic1HAYO4jsNvN+IqC+f2aqoFeA9XwP6+vKCYjxTMYPaVtSp42vSXcdQgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794278663;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=tGrXQabJRkW1FbhmS9p0Mif8T7WdwJdeDHCgDEbxScA=;
	b=zaFL+QaTBaMwekWDeNE/ZLOuZ2Lulq7iEpckCPElH+3QzH7fZRNuaFYJjMby97zDuNfK
	 6g5t7CHHXoqbuxyb5PVFPEo4JemcPALPu057OjHO9d3aV4//2um03UVwlvQisCM60bLfw
	 usXopoh21n0f59ByQfnocafBkJnB3asJU+rL/GqUuoRlI+ebZ4w4dzcqiCOKi/RbsJ094
	 QzI7VKG3Df5cPQLnkg0dhDjSnpCbViqL2oaIraIhTkemk4rlZ7vxUvh+LXdefIeHee91k
	 8jgqQZnRog3obdUWV9H//orY6RyZOk7Dnf+pQSGoXxLvRi2sORmfSqjFH8ahg3ClrgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=f1Z1EUUW;
	arc=none smtp.remote-ip=209.85.210.171
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E24606A330
	for <linux-block@vger.kernel.org>; Tue, 10 Nov 2026 02:44:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70E24606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=f1Z1EUUW
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8b271e573adso586667b3a.2
        for <linux-block@vger.kernel.org>; Mon, 09 Nov 2026 18:44:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1794278663; x=1794883463; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tGrXQabJRkW1FbhmS9p0Mif8T7WdwJdeDHCgDEbxScA=;
        b=f1Z1EUUWUqIEi/1hrH681g2Lts7jDLTXirhZCgNvmRtMcVjLJOjDCTHdBYDQOdebt0
         o0ZuUHqtjeGFXwCg1dTkmXcT0uwk01YgZGwgKfMj6/FrmyYqunvhCCbaVo4spMtxZ8nd
         Xs4zJqS5psU695Q1y5o70nziSd6fD6I27srlA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794278663; x=1794883463;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tGrXQabJRkW1FbhmS9p0Mif8T7WdwJdeDHCgDEbxScA=;
        b=QZuAaadEdR8LKoOmtBOWVAO+0DFSIWgVoJyoDy6twAuqH/SjofcGHerDdWaMWjb0Jp
         DxxQgvcvo1Qawve1OBPr+W0wu8Cqd1CW2xzl/Dd4q5Fi9z85rCbPfk7P/SOIeymH/WS7
         0g497N68nUU0pn9YNYP4GJGZ6Sn+v/RPE2aj/HMVBAilIAggkaRZfwk7uK+AJTUmjMP6
         YJaGVi8hSZ5pML+6hoFCFSrqS/8EgHk60VW+/0JLmIaY6XNfWzv1tvmvoqHFAJn4Hxj3
         CUNv/hcIK/xRnBskWhN0mCAOlMMaS9XOWOU1zK26iM5eN20lrnNes6vN4thRr0LWUqL3
         D7Zw==
X-Forwarded-Encrypted: i=1; AL+hErGflvXjf41tMkQKtLsOfg6tNWtrRHEpVqvQEuhA9MNDVOJZdVxrrF4boP+V185eIyZb/v3LNJx9KBDsWQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z+OnbeT3m4Vzf+PjzSLeZpJguy24rAsZb0MTThiivfsDDJvKgBs
	YWpXazkswfY24at2aCpCg+9HiLF9CnsP26keK9hUquuAdqpB8Pl7zRjMGCgnxLPoLZ4nxsPFEw3
	FoNo=
X-Gm-Gg: AYBFou1FqC2+1LPo5kn3CAKziZWOd+ZqXY0WBqt9fAHJK+slMhlKvdNfHuFa0GiAZXk
	sr2U0zIAXCtS9OdE2dFMK+BgcGfvVLWJVtRw2u36RC79dVvxMz+KlVZB0AFtOVTHnUoPfJ4QI9F
	2AQNibbnjpo6CN/tIF4QE8v/wus8BEsraUiSSbPsncJK5tfaqi1qIN3twP6pAd6CYvjaYTMEY1V
	iTM5UAmx3xW7iZI89Pb4w5gkv7nx6l4WEgpSZuTbHGpOsuSh0oYu4uTKOAqVIFcXuCCWarqGdTF
	Pig9appC9B6YsdUOWPtGNbwD1hors6vhajue8lOHXt+T4yVArhQAfuUhM4jZ+7Ct3shS+QyDtKx
	WH1tM/NTEO/mnYHiiWuZ4+aD52sQFM7At2qmWsAyLDs3eA3xYkNf/r/vxmfPzD9MUHzi+OjaMB+
	GqZfWAfbPw8jZK4Equn95jIcKltqk10XFOUhxs2cYiDI8h9ZesYfozC+/V2+snA4kicWBmq99B5
	fs5P7LWz5rmx24OlTx5GuLdIRz2FtsrnAqd2Rn1T5FUETR9GNMA9UyN9+ULwrNiKNR9uQ+hB+GA
	X+gGFET3PytGe73+BJepGkcm35onmvuONzKSizxK1zqrzfNO3pIUpj+QTBwbflCEAzHX9g==
X-Received: by 2002:a05:6a21:7303:b0:3eb:a104:f30a with SMTP id adf61e73a8af0-3f18e1df821mr1008561637.12.1794278662747;
        Mon, 09 Nov 2026 18:44:22 -0800 (PST)
Received: from google.com ([2a00:79e0:2031:6:e137:9384:7cd8:6e40])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8baaa963bd1sm305882b3a.29.2026.11.09.18.44.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 18:44:22 -0800 (PST)
Date: Tue, 10 Nov 2026 11:44:18 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Nhat Pham <nphamcs@gmail.com>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, 
	Brian Geffon <bgeffon@google.com>, Minchan Kim <minchan@kernel.org>, 
	Richard Chang <richardycc@google.com>, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-mm@kvack.org
Subject: Re: [PATCH 5/7] zsmalloc: embed struct zs_handle into zram and zswap
 entries
Message-ID: <avKE9cp35cn5pAMD@google.com>
References: <20261105044752.1997895-1-senozhatsky@chromium.org>
 <20261105044752.1997895-6-senozhatsky@chromium.org>
 <auy8-5SW9sCfCCbc@google.com>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <auy8-5SW9sCfCCbc@google.com>

On (26/11/05 17:30), Yosry Ahmed wrote:
> > +#ifdef CONFIG_ZSMALLOC_REBIND_HANDLE
> > +/**
> > + * zs_rebind_handle() - Rebind an allocated object to a new handle.
> > + * @pool: pool the object belongs to
> > + * @dst: unallocated destination handle (must not be on the stack)
> > + * @src: source handle that currently owns the object
> > + *
> > + * Rebinds the object from @src to @dst, updating the object header so
> > + * compaction and page migration update @dst instead of @src, and resets
> > + * @src.
> > + */
> > +void zs_rebind_handle(struct zs_pool *pool, struct zs_handle *dst,
> > +		      struct zs_handle *src)
> > +{
> > +	struct size_class *class;
> > +	struct zspage *zspage;
> > +	unsigned long obj;
> > +
> > +	if (WARN_ON_ONCE(object_is_on_stack(dst) ||
> > +			 zs_handle_is_allocated(dst) ||
> > +			 !zs_handle_is_allocated(src)))
> > +		return;
> > +
> > +	obj_class_get_and_lock(pool, src, &obj, &zspage, &class);
> > +
> > +	if (likely(!ZsHugePage(zspage))) {
> > +		struct zpdesc *zpdesc;
> > +		struct link_free *link;
> > +		unsigned int obj_idx;
> > +		unsigned long off;
> > +		void *vaddr;
> 
> I think this would be easier to read if you move the declarations to the
> top of the function, so that the different logic in the branches is more
> obvious.

Ack.
