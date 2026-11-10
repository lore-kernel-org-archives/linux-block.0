Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794279089;
	b=lrWIAMuvSpTe3/aEc1eu//NH8VKH98Me5t3c1tWB95qE6HPQ6vNPZUgxNinEuXvUe2RW
	 5xRWmDH9U4+cLODUt2RkMHrrdLA3k1SG0H+pg/brhI3Fm4mdpjcOO7mgPitdpiX1HsJ3L
	 R/6o9o+EmD3YnhNVz0szw6r3YO0zw/tZlOfEMR3FPb31Qa3jjCXA+lehrFgDk1BeWOZ75
	 2RonLnFkAexNqlGxdArbNQZ+liQfsmCA5tkAkkWqKlvubBnCLbmAmC+246ta9EJ6noBkO
	 koWrCP+k95da1EOTgEfIDpXj3vudz1WGPi86y+g54o+gxkQaBTxOgI2UQhyzvaBwm1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794279089;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=rbLMU1pYfk4pMCO3YrPvND96KRltx8I0UXJznwRM32s=;
	b=RhK2CD61keWUF8bAHuoTPx0oNfNbrq1W4g6gFmiARJNtuWMzB3X8iLJLbFi5g7w6LmXQ
	 zYXUMlASTq0z3JmFy+bIR3qgZi+YTrrcQUb/Xb+7Rfj1XEILueV2TVRlzbYwjSNqjH61r
	 S00N6VIvWKa1GGYJh68MDq3WfsA1JUQAezjLNI+EijkILgy2R2moRDZEcv1KgX8pw6xWW
	 iWqtXJIGTSe4HBsNgeylzBryjjvGXgkwo2m+/v0IzTYCK/juzUZxqVNPDBwNA4KKGGURo
	 lRWo1Wh6LnIJGt3lW2uPA7D3CbmizwvyghJxw4Mp4lV59P+HP90OXLuXQxjUEdjgjMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b="Um6f0w/5";
	arc=none smtp.remote-ip=209.85.210.181
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D98C606A31C
	for <linux-block@vger.kernel.org>; Tue, 10 Nov 2026 02:51:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D98C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=Um6f0w/5
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8b66d1a08ccso1456970b3a.1
        for <linux-block@vger.kernel.org>; Mon, 09 Nov 2026 18:51:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1794279088; x=1794883888; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rbLMU1pYfk4pMCO3YrPvND96KRltx8I0UXJznwRM32s=;
        b=Um6f0w/5hrpraY4UHnRm7NaUyIZEMqFGBKFeCU0z9+K+iCAOJKPih79teU+6bqvobp
         pAeaKB0EiZ4TWOu11jB2PyY6JcUGKXCWSih/aIkR6yVb0Q3yaDm8NG7sxE1UZZ3qU/bf
         p/aMjEnZsM6IyzOU7mvKHCm5Jj2ikfcstijEI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794279088; x=1794883888;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rbLMU1pYfk4pMCO3YrPvND96KRltx8I0UXJznwRM32s=;
        b=huUYyQSLIy5X3uBZVKXLg4ae038pKzgz8/T1ynqRJx+OPuemcMXf0KNn1gdF48r0JY
         7ZeC1gAH/S/kzghu4cFNnMKabSLE/V2DC+HkWCJrzaHnacH1cECQGfTO66X1fQs4Fr4A
         K851UyXSFBvKX8LkFJ4AnaN2NNAusnADJEfwtwAySx99rN+KifNH3QcXjfanY+msBbFG
         B0IZSvf5Ll1MBD/57nLjvUZE8eLIu6XvgKBmTERewz/Yq8OcHA3iDA2fgmgP4EPczQnC
         BpFQqDW8aV2jBhC/54Yqu/IqLd97S+hrHceiKlaLQzN4M/8Sn8Sbmhu16iR8CyUeWkKd
         qbJQ==
X-Forwarded-Encrypted: i=1; AL+hErEhj1XuI8tjA62yIScrSTm82Lr3FdvHVjWFjRJpFucICZjtxstNStTV0iJ9jG4KfPsuXTEJpa5WRdEFqw==@vger.kernel.org
X-Gm-Message-State: APuU4Z/iq44wYvm2NS2jVJDxC2vsDiUU7VJuY8L2LEyqQiM8CjDsGxcK
	9jeoD9taEEX2SfMcXkaCojBG2HeCgkznofpHtQ98wXazyeucNWjVbrqXamGdARUfHEEfGm/sC6I
	dqWY=
X-Gm-Gg: AYBFou1971acmIuYVcpNBRQ7YGOK3PH5j9FvGeUIUCPDfYG17T3ScbKQt5w0I5BACjh
	HM2xZ1OI16h0WKxNZSdLzS/77SNHK1aS5sEgo6dhIH/3cX2LtxxMPYMQXpDESm1RqlJNhwhdbd8
	hP9x9+oVusNFVI52Ldt/sH0BaEG47K66Meqc2AKGXyhxJ3rXc62C3tGeRrSSUseXCQvFKxvm5Bn
	fVx5xNMejBZsczGqZMIqga5evHtJgJN1hoh9KhOWuOKvkdSAfeRd5YxgZHeQtiKCoJ2YvDCMhwP
	EozuJQeMjpbAL/SHibxrRcbzrPEyv5L34rqvhZDcQlyvINOXEn9FCERykLDmwQfBqCN24lismhS
	X+zhoJSCFjZBMDQQldOhSzxzpxhD59quWysTi4lMw21qjMTkTOdlvHFa2xw3Kxr/Ra9LXTzl0nt
	8WCTKHj8VeB3eXwWy3etpXyD/xLWPaGENoHnT1VRRxKnoAsVYRP5vu2M8EbBTSSldqmmfLqULcK
	e6z1+hDbLoIf8wRHRYQ/vmjrvCj/S4Idc29GUUvIBIggmmWiBCwrNQA0Jz9TfO4XIuRty918CFp
	WOTGyROBj6KwqyFmLQqi2Obn73RsF15g52+85hjlUIVyXFwya2VclGffM3qdEjvcORAgGIZ9qeR
	nmbEATnHU16nnx/c=
X-Received: by 2002:a05:6a00:1249:b0:89f:3053:9af2 with SMTP id d2e1a72fcca58-8ba860cdac1mr1637379b3a.12.1794279087731;
        Mon, 09 Nov 2026 18:51:27 -0800 (PST)
Received: from google.com ([2a00:79e0:2031:6:e137:9384:7cd8:6e40])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8baaa2a7fbesm298559b3a.11.2026.11.09.18.51.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 18:51:27 -0800 (PST)
Date: Tue, 10 Nov 2026 11:51:21 +0900
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
Message-ID: <avKFc82JS4R9yU-N@google.com>
References: <20261105044752.1997895-1-senozhatsky@chromium.org>
 <20261105044752.1997895-6-senozhatsky@chromium.org>
 <auy22TkX0ADxP9WR@google.com>
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
In-Reply-To: <auy22TkX0ADxP9WR@google.com>

On (26/11/05 17:19), Yosry Ahmed wrote:
[..]
> >  Additionally, zs_malloc() does not return a dereferenceable pointer.
> > -Instead, it returns an opaque handle (unsigned long) which encodes actual
> > -location of the allocated object. The reason for this indirection is that
> > +Instead, it stores the encoded location of the allocated object in the
> > +provided ``struct zs_handle``. The reason for this indirection is that
> 
> Should we explicitly call out that zsmalloc will keep a back pointer to
> the handle and update it asynchronously, so the owner shouldn't modify
> it, and should keep it allocated until zs_free() (or rebind)?
> 
> Probably somewhere in the code comments too?

Yeah, perhaps.

> >  zsmalloc does not keep zspages permanently mapped since that would cause
> >  issues on 32-bit systems where the VA region for kernel space mappings
> >  is very small. So, using the allocated memory should be done through the
> > diff --git a/include/linux/zsmalloc.h b/include/linux/zsmalloc.h
> > index 693c9484b638..6c76fd10344e 100644
> > --- a/include/linux/zsmalloc.h
> > +++ b/include/linux/zsmalloc.h
> > @@ -14,6 +14,7 @@
> >  #ifndef _ZS_MALLOC_H_
> >  #define _ZS_MALLOC_H_
> >  
> > +#include <linux/compiler.h>
> >  #include <linux/types.h>
> >  
> >  struct zs_pool_stats {
> > @@ -21,16 +22,39 @@ struct zs_pool_stats {
> >  	atomic_long_t pages_compacted;
> >  };
> >  
> > +/*
> > + * zsmalloc writes object location into the handle and updates it when
> > + * the object moves (compaction, page migration), so the handle must not
> > + * be on the stack and must not be copied.  Use zs_rebind_handle() to
> > + * move an object to another handle.
> > + */
> > +struct zs_handle {
> > +	unsigned long __private obj;
> > +} __aligned(sizeof(unsigned long));
> 
> Is alignment guaranteed even if this is embedded in a packed struct? I
> wonder if we should have an explicit alignment check in
> zs_malloc()/zs_store(), and probably rebind too?

I guess only run-time check will work.  I can add those.  I wonder
if we actually need to worry about this, neither zram nor zswap use
packed entries, but I think it's cheap enough to make sure in run-time.

> > +
> > +static inline void zs_handle_init(struct zs_handle *handle)
> > +{
> > +	ACCESS_PRIVATE(handle, obj) = 0;
> > +}
> > +
> > +static inline bool zs_handle_is_allocated(const struct zs_handle *handle)
> > +{
> > +	return READ_ONCE(ACCESS_PRIVATE(handle, obj)) != 0;
> > +}
> 
> Can this ever give a false negative?

That's a very good question.

> I believe that's only possible with pfn=0, I don't know if this can be the
> case on any architecture. Should we use something like OBJ_ALLOCATED_TAG?

Yeah, I don't know, I guess would be better to not rely on "pfn cannot be
0".  Let me look into this.


> > -struct zs_handle *zs_malloc(struct zs_pool *pool, size_t size, gfp_t flags,
> > -			    const int nid);
> > +int zs_malloc(struct zs_pool *pool, struct zs_handle *handle, size_t size,
> > +	      gfp_t flags, const int nid);
> >  void zs_free(struct zs_pool *pool, struct zs_handle *handle);
> > +#ifdef CONFIG_ZSMALLOC_REBIND_HANDLE
> 
> FWIW, I don't think this is buying as much. It's one function that is
> only called by zram anyway.

Ack.

> > +void zs_rebind_handle(struct zs_pool *pool, struct zs_handle *dst,
> > +		      struct zs_handle *src);
> 
> A few comments in zsmalloc.c mention zs_free() reading the handle
> locklessly, do these apply to rebinding as well?

Let me take a look.

> > +#endif
> >  
> >  size_t zs_huge_class_size(struct zs_pool *pool);
> 
> [..]
> > diff --git a/mm/zswap.c b/mm/zswap.c
> > index 397b06c9f33b..f28a46cae1e1 100644
> > --- a/mm/zswap.c
> > +++ b/mm/zswap.c
> > @@ -215,7 +215,7 @@ struct zswap_entry {
> >  	unsigned int length;
> >  	bool referenced;
> >  	u8 pool_idx;
> > -	struct zs_handle *handle;
> > +	struct zs_handle handle;
> >  	struct obj_cgroup *objcg;
> >  	struct list_head lru;
> >  };
> > @@ -769,6 +769,7 @@ static struct zswap_entry *zswap_entry_cache_alloc(gfp_t gfp, int nid)
> >  	entry = kmem_cache_alloc_node(zswap_entry_cache, gfp, nid);
> >  	if (!entry)
> >  		return NULL;
> > +	zs_handle_init(&entry->handle);
> >  	return entry;
> >  }
> >  
> > @@ -787,7 +788,7 @@ static void zswap_entry_free(struct zswap_entry *entry)
> >  
> >  	zswap_lru_del(entry);
> >  	if (!WARN_ON_ONCE(!pool)) {
> 
> This check is mostly defensive, and if the pool was ever NULL it
> prevented a NULL deref, and potentially leaked the underlying zsmalloc
> object, which is mostly fine as the pool being NULL points to a larger
> problem (e.g. corruption).
> 
> However, if that happens now, the handle pointer in zsmalloc would point
> at the zswap entry after it's freed by zswap_entry_cache_free() below,
> potentially causing a UAF. It's arguably fine as it's just a cascade of
> corruptions, but I wonder if we should just bail early and skip all
> cleanups below if the pool is NULL.
> 
> We'll leak the cgroup charge, stats, and the zswap entry itself -- but
> that's arguably the safer option if we already have a corruption
> problem.
> 
> We can also just delete the NULL check, but it's cheap to keep and I'd
> rather have it tbh.

Sounds good, let me reshuffle the code a bit.
