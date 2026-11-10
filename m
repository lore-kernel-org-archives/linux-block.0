Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794278755;
	b=Qo2TF4srYqk+v6s8R8IzPksZK8U6OWXPUHoj2PCl/uGmBWVjwrpPgTYIEWx9GARWsl36
	 EP6cUDFUcw+tRni11DT4NjT03EGQQAs9E/lvuCH7/lnosIvkgJvYR3NVsuFwwiTb+5n+6
	 l3EbcYBQFXDlBc88PCr85QYv11PpxTZIdPgeI8nnUHlWCrIPw7NJCKdmYF6LpYG+1PiiK
	 1GNFz1A4+8gEed43LU3Rn+awsg7ljCeSeHWlHGXEKRKSovvZ6cvOnXk5q8+1Glac5Qjp4
	 /veGobj2ZqCKgoPZVWA3//y1yaAIRDz2VjDW1HnZ1OZdKTuks6QrxNyZtTohnP7qjgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794278755;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=+1IT6L02h4Z0rswWeGeMVfIe5Og40SseihhMQYse9qI=;
	b=gMwoAwddk2wRqHXrLnYX3pnU8NOxA+lLpo6N/D2lsFJ333teW+fptL87MKFvzJaslcGx
	 4sMnj3oO3rhgvGBVtR5uoCmklbM3ewnaI0fqLOhZhqq1bsl6iQCzgAZT9meQVMrdcDMfT
	 tRhYBNjMqMa4U2/4tk7K2jHRwwmVqNy6lF9wYPdwOlAxXt1+oYN/0i5cu42rEIuAWXikt
	 gpVJnzvD7j0kQztNbMU+BPp9gG4hU2fofozj5ytovxJ8dUfjEHSoo0P5TdftwMJQ8JXd6
	 YXJtuf0iFcpJ+ZYwt4glpjbsN0zAXuPwQ9ERbABt10cUWhkdPEJAtT2rti7ub6vWVlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=hqBoijwW;
	arc=none smtp.remote-ip=209.85.214.174
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D886606A321
	for <linux-block@vger.kernel.org>; Tue, 10 Nov 2026 02:45:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D886606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=hqBoijwW
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2ed2bfe3252so5623465ad.3
        for <linux-block@vger.kernel.org>; Mon, 09 Nov 2026 18:45:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1794278754; x=1794883554; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+1IT6L02h4Z0rswWeGeMVfIe5Og40SseihhMQYse9qI=;
        b=hqBoijwWRhG9a6Nw7Vb4sOk28SgYHZThM5/xqtyQKu+zBz4WSVBqa93imIaIvTBu+w
         94VIKdj14FYUX8jOTCs813DbthJDgPF246X/NXVE58H/W0rAU6G51euWo0nU6gjq8f0h
         gqrsQlimEC1ZyWHxCO7LkqB2zrnqJCrJoQ5aA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794278754; x=1794883554;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+1IT6L02h4Z0rswWeGeMVfIe5Og40SseihhMQYse9qI=;
        b=kzMl8pFNOsUms7Z7Uxh96AW2AV5zeldVlpMtIxu18ypF7RL8F84Y4vcHgiR3i5e9oF
         JyPaVCXfTGpqDhSKdwEiu898IDWhWW+puZ8lBKpeKp5lXFzJt0DqFdv1/k4WCbgHoppX
         2xbQOkR6WiQMAnyTno01O/uSGbwM+GSfJqAiAEM+IAp/wnBKA70aJVq/BtZ/rP1ydMSF
         c19HUUZDDbX6nROrxJklRo/Up6jneDWSCS22kGJ+KRMH7nI6H4CSSGFpjaTOVnrOMwAD
         lo0OfUADLsCIYTNFuSTJuBWLB1tVIykrypaUHoWIn9Y00xdVkxS/D7irqog6tJOlGgDU
         31Eg==
X-Forwarded-Encrypted: i=1; AL+hErF3Gwt4JCcucz0l0Nx0rEiNJn3kjZXoda0EazkIqsWrgnToFqKBY/HRFIcfRhdO4oVG2TgstY4efG02Ng==@vger.kernel.org
X-Gm-Message-State: APuU4Z9q9+43F4/hgrHIp2VU2qS39aMoxAFcOepAVfqZQo1cDb4o8ywf
	f7oktZSFxYg2nsS+edMy8Kdl6X2OWtExIwtVHavXeSPDaZGhVOvLcew4n92BYsoyoQ==
X-Gm-Gg: AYBFou1i5K8WHPlIeHsotL1/AVz90vQ0CaKgrNmh/FrcLDL3cIw5DWpo42xMbBW4T7a
	YB9muvNBw6DKSZuUdqUcoIGSPiuL+dnklF8FSm/Nxfz1kgqktYFzVbuEzRH+yuwSxPW0VMgmYMJ
	CktsLd9TcJlsWZMex48TWxAQ7iXiAsMPop/Mm7iOwU2OwiL/0WynmTRIRHFJ+XQ4s+EK29RDRjl
	xgce3IpTMM3dq4PWJwTTzAw4/Fuy9VSqxCZ3FE/KnLtLH0QC3QW5ej+x7pHjIshwuPishXisTyS
	UfhpCvrqUH2qBsqZV5FQKM2TT2g+t2GDCVbJQsKDrdOlEBwY8wPxCBQLrTBD2oqtx8FZvMS4rrG
	//tjYGghJT7m54bZ4bMDonFTAJqeMOC/ini0XOTV3SGMwv4GMdDLDOXk6vHHJNXiBXCwS2gQ7a4
	bzin/kk70LKYkoHXuuwVma5mbeCYp10gm85iCVyegbqq7tqauKzY5dlVt5Ek/J1euJaHyxqE9zR
	iq9rCLLelrbLcpAsqeMqDxiMWitHMssiquJahBIkTI485nXDjcJd3BmWPv/VeCVKSYRNM0T+V9T
	A8CoALK+d0LtO1IUoPwTNMklyudnYtYfa6h/cHyJdy7xSGqN5QTzqJdmLolrVCFxE/tNZg==
X-Received: by 2002:a17:902:daca:b0:2ed:4456:fb2a with SMTP id d9443c01a7336-2edb913e57fmr10948875ad.36.1794278754561;
        Mon, 09 Nov 2026 18:45:54 -0800 (PST)
Received: from google.com ([2a00:79e0:2031:6:e137:9384:7cd8:6e40])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2edb6e11e9asm3619075ad.74.2026.11.09.18.45.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 18:45:54 -0800 (PST)
Date: Tue, 10 Nov 2026 11:45:49 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Nhat Pham <nphamcs@gmail.com>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, 
	Brian Geffon <bgeffon@google.com>, Minchan Kim <minchan@kernel.org>, 
	Richard Chang <richardycc@google.com>, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-mm@kvack.org
Subject: Re: [PATCH 6/7] zsmalloc: fold zs_obj_write() into zs_store()
Message-ID: <avKFDz0PGwkbwNgz@google.com>
References: <20261105044752.1997895-1-senozhatsky@chromium.org>
 <20261105044752.1997895-7-senozhatsky@chromium.org>
 <auy6wQIz89NxpskT@google.com>
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
In-Reply-To: <auy6wQIz89NxpskT@google.com>

On (26/11/05 17:29), Yosry Ahmed wrote:
[..]
> >  Most of the memory allocation APIs use GFP flags to express how that
> >  memory should be allocated. The GFP acronym stands for "get free
> > diff --git a/Documentation/mm/zsmalloc.rst b/Documentation/mm/zsmalloc.rst
> > index dbb5c1a8dcc3..52eaba8f97e9 100644
> > --- a/Documentation/mm/zsmalloc.rst
> > +++ b/Documentation/mm/zsmalloc.rst
> > @@ -20,9 +20,9 @@ For simplicity, zsmalloc can only allocate objects of size up to PAGE_SIZE
> >  since this satisfies the requirements of all its current users (in the
> >  worst case, page is incompressible and is thus stored "as-is" i.e. in
> >  uncompressed form). For allocation requests larger than this size, failure
> > -is returned (see zs_malloc).
> > +is returned (see zs_store).
> >  
> > -Additionally, zs_malloc() does not return a dereferenceable pointer.
> > +Additionally, zs_store() does not return a dereferenceable pointer.
> 
> Well, it doesn't return a pointer at all now.

Ack.

[..]
> > -void zs_obj_write(struct zs_pool *pool, struct zs_handle *handle,
> > -		  void *handle_mem, size_t mem_len)
> > +static void obj_write(struct size_class *class, struct zspage *zspage,
> > +		      unsigned long obj, const void *handle_mem,
> > +		      size_t mem_len)
> 
> Should handle_mem and mem_len be renamed now?

Ack.

> Also, there's a comment in zs_page_migrate() referring to zs_obj_read/write().

Ack.

[..]
> > @@ -1318,12 +1306,16 @@ int zs_malloc(struct zs_pool *pool, struct zs_handle *handle, size_t size,
> >  	spin_lock(&class->lock);
> >  	zspage = find_get_zspage(class);
> >  	if (likely(zspage)) {
> > -		obj_malloc(pool, zspage, handle);
> > +		obj = obj_malloc(pool, zspage, handle);
> >  		/* Now move the zspage to another fullness group, if required */
> >  		fix_fullness_group(class, zspage);
> >  		class_stat_add(class, ZS_OBJS_INUSE, 1);
> > +		zspage_read_lock(zspage);
> 
> The zspage lock is now acquired under the class lock instead of the pool
> lock, this is probably fine but worth calling out explicitly in the
> changelog.

Let me take a close look.  Lockdep didn't complain, but let me look more
into it.

> > +		spin_unlock(&class->lock);
> >  
> > -		goto out;
> > +		obj_write(class, zspage, obj, src, size);
> > +		zspage_read_unlock(zspage);
> > +		return 0;
> >  	}
> >  
> >  	spin_unlock(&class->lock);
> > @@ -1332,8 +1324,14 @@ int zs_malloc(struct zs_pool *pool, struct zs_handle *handle, size_t size,
> >  	if (!zspage)
> >  		return -ENOMEM;
> >  
> > +	/*
> > +	 * New zspage is not in class->fullness_list or movable yet, so we
> > +	 * can allocate the object and copy data before taking class->lock.
> > +	 */
> > +	obj = obj_malloc(pool, zspage, handle);
> > +	obj_write(class, zspage, obj, src, size);
> > +
> >  	spin_lock(&class->lock);
> > -	obj_malloc(pool, zspage, handle);
> 
> Should moving obj_malloc() and obj_write() outside class->lock (and
> skipping zspage_read_lock()) for new zspages be split into a separate
> patch on top? AFAICT, it's a separate change from merging the
> interfaces.

Let me take a look.
