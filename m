Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793899849;
	b=XWk4VmvPDBmuYRj3tF23d7om8t7FVhmcrXuhwNn7zqb/uuu8oL3Jj5lleG5igEdvQ+13
	 KFJ7umyduRvV7BhQjqSUM+l9j+8xw1NXL3Vs8H++X0HHHrUrGcJifW0xNoLoK1e0w6zrY
	 WOpuyP+FAcDasXWeaEpBdPfXSQm5zVnSzpi3u1NPeISKorMACfee7w2Qj+dzYcXb3FpHI
	 PtZ40ZTdK7yl0mpu6qaV285eDybwJGfZA8tOAwZmIgfu1AQgD/v/ZOKZB8HhcYbU4pd2i
	 YJ9qwGZp5kJvHK/GFFOSWqxgKfc/hsK+6P6Pjqdua6SxWJDNPpyldXCweDDFzsmOW8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793899849;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=19B4q+don2ykfC+afUQfWB2iSWW/p5Mb1AKCVEYwGHw=;
	b=srQKxNkDa2Vm7+kUlMSihFHIMRGl3dGLbQgELxfFMBVe0ydx7/vhLrmSaI5hyxWvxbNR
	 QLHHaVRmWsFNVcgcOPCc8CwAaTUKZukZJK9ue0BqljuVMxrxVtMNR6+I4oUC0ntQQkbAH
	 8+JvWygrKrePp5Gy6OSGwvAVnE3tz14A/t2N1WRLKy54m0qAOFkCk2hMdGTJUtGy+j+vx
	 iNrYZgLqHHqOFw6NnU6gwwAqO/cntfkY/eZqk5c9AOuedMHggeDFuQueNjN5wkSpmQqpd
	 Zcb/JnZk8/l9emSnQiX+rMLyqNwFERJFkXVDXkGP3OwnMzTPeWmFal/+CEI9XRTvaYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aPi52GD9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96043606A326;
	Thu,  5 Nov 2026 17:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aPi52GD9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7E741F000C1;
	Thu,  5 Nov 2026 17:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793899849;
	bh=19B4q+don2ykfC+afUQfWB2iSWW/p5Mb1AKCVEYwGHw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aPi52GD9ZFKz882VYQcy/TqjEMpcGt06GVsERn6G6I7O0rPdLHHtOtfKUqFtAZY00
	 lcN+pOETIDUtqN5/Cs0BzgrefpC9jKLOr/RV2kSUhX4DHGysUALCchrKAmgcUk/0V3
	 ZjUfV0GkhcFKvEBhAu1FRDF2T+PnICkz1ZP6fY3daamGHsW/ga2HcxM1H5f+H3vN5q
	 2G0xrvuXSEDRFE+CDwvHzhu9qFXIqUl/+2g4Uf2m9DxZnFYebY3DqsVNe0sPG8DXmR
	 4BPl4FedNxPwSZmiidquMGJiGeAH/VRAJfxY/x2Ig5WXJMrT5SDCNMHGYj1JmZzCna
	 DwxzYY6yxD9VA==
Date: Thu, 5 Nov 2026 17:30:47 +0000
From: Yosry Ahmed <yosry@kernel.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Nhat Pham <nphamcs@gmail.com>, Yosry Ahmed <yosry.ahmed@linux.dev>, 
	Johannes Weiner <hannes@cmpxchg.org>, Brian Geffon <bgeffon@google.com>, 
	Minchan Kim <minchan@kernel.org>, Richard Chang <richardycc@google.com>, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 5/7] zsmalloc: embed struct zs_handle into zram and zswap
 entries
Message-ID: <auy8-5SW9sCfCCbc@google.com>
References: <20261105044752.1997895-1-senozhatsky@chromium.org>
 <20261105044752.1997895-6-senozhatsky@chromium.org>
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
In-Reply-To: <20261105044752.1997895-6-senozhatsky@chromium.org>

> +#ifdef CONFIG_ZSMALLOC_REBIND_HANDLE
> +/**
> + * zs_rebind_handle() - Rebind an allocated object to a new handle.
> + * @pool: pool the object belongs to
> + * @dst: unallocated destination handle (must not be on the stack)
> + * @src: source handle that currently owns the object
> + *
> + * Rebinds the object from @src to @dst, updating the object header so
> + * compaction and page migration update @dst instead of @src, and resets
> + * @src.
> + */
> +void zs_rebind_handle(struct zs_pool *pool, struct zs_handle *dst,
> +		      struct zs_handle *src)
> +{
> +	struct size_class *class;
> +	struct zspage *zspage;
> +	unsigned long obj;
> +
> +	if (WARN_ON_ONCE(object_is_on_stack(dst) ||
> +			 zs_handle_is_allocated(dst) ||
> +			 !zs_handle_is_allocated(src)))
> +		return;
> +
> +	obj_class_get_and_lock(pool, src, &obj, &zspage, &class);
> +
> +	if (likely(!ZsHugePage(zspage))) {
> +		struct zpdesc *zpdesc;
> +		struct link_free *link;
> +		unsigned int obj_idx;
> +		unsigned long off;
> +		void *vaddr;

I think this would be easier to read if you move the declarations to the
top of the function, so that the different logic in the branches is more
obvious.

> +
> +		obj_to_location(obj, &zpdesc, &obj_idx);
> +		off = offset_in_page(class->size * obj_idx);
> +		vaddr = kmap_local_zpdesc(zpdesc);
> +		link = (struct link_free *)(vaddr + off);
> +		link->handle = (unsigned long)dst | OBJ_ALLOCATED_TAG;
> +		kunmap_local(vaddr);
> +	} else {
> +		zspage->first_zpdesc->handle =
> +			(unsigned long)dst | OBJ_ALLOCATED_TAG;
> +	}
> +
> +	record_obj(dst, obj);
> +	record_obj(src, 0);
> +	spin_unlock(&class->lock);
> +}
> +EXPORT_SYMBOL_GPL(zs_rebind_handle);
> +#endif
