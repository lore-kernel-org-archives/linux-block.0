Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794278530;
	b=tpW2M+nACVrDErWZ2RPt6laVyZgs4oDpMgGw4RxQjX8ZUXEXeXNlNotA7zdJYZ1RHVxm
	 F6l15nzivFRCzmcqzn7kfXAhfPCgUnzYz+AFqHXG3lw5fZJGdRsmnPG3/MYtsLFNEWdZ1
	 3O0ggIcNAS7GoyqXlSR7lXACBB2egAuxrsQxYE5jQr+m9vGoWb7LYCrT0d4vz28QXoetr
	 53fQGxXR71YXgnivWv+8lt5O+b9UYxPledyFUTgIVoJihB59/ZBBdE2wvXRjsi7XCl8+C
	 m47x6BmpfO3G4QS3LFTSfU2LT3qafwXXPZUIeDHM4H91ncuS1uCa1rFsB4NezxEPzrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794278530;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=9eYU/miYIaBNjo7DaB+0PRJT3BKcPjkG2A+IW4gcpts=;
	b=iPSzpvPW+HjZ0+gPwC9bTRR9Sf+xBZfP2a/HQd0jC9ysiw+NhKqA4dU7KIkLnSKofbJC
	 bLOXA8TZba4h+vmsxY3dLQTob3dBxPuzMztkDyd1EXoBvvY7OAla7eXpwf1/0qK0TKi/S
	 VucNHPuip27LFuIAYDEzMy1xOEXtxYM3bmUt7ZTTA0GE3IRPxySftALXLuKj9GX+N0FBt
	 O7HV/+ZD9+ppcvZQZ9hCLJOTfxqmIpOAevO3zlBHuvdq329hOJactVLpq4OOu5gJz2H4+
	 yoeuszci+WCA6AJXol2r+125DSK1+TpkyMw/YHUAuKBrtiPkmI+6CaHRWcRKXcgUePQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=nXJhPw5v;
	arc=none smtp.remote-ip=209.85.216.50
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8079460A260E
	for <linux-block@vger.kernel.org>; Tue, 10 Nov 2026 02:42:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8079460A260E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=nXJhPw5v
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3ae1b34e0d2so857290a91.1
        for <linux-block@vger.kernel.org>; Mon, 09 Nov 2026 18:42:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1794278529; x=1794883329; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9eYU/miYIaBNjo7DaB+0PRJT3BKcPjkG2A+IW4gcpts=;
        b=nXJhPw5vFrR9y2ePe1Z8+p6bw6mKBf+vmWebUzrfYf5b5xi7vUnxgc8Y+pOetVkuXh
         yvwe11s3VjwtRuIgXfqhpp9fgFjvsI+PCP23kCfHlyWXh6I17unK40D4ULUsZf4XkRSR
         5v32odlZieWi6bzXlQjaR+085OfHz2rW9eYhQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794278529; x=1794883329;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9eYU/miYIaBNjo7DaB+0PRJT3BKcPjkG2A+IW4gcpts=;
        b=yMgoua/1Nv25pHCKeZE7RLUmA1D2TLxbfjS7S32zLhMu+3laEZFv90zCn1I2RUpwTS
         O5UZ/sDRLizt9VX6+pdbzoQadcZg4qLbm16dVOKWG0mXL/x/SgMYbUlb08V+AOtws/8o
         QD6cSJINu+9tGW8L/USMK6QjYh5lAv1C+8uDPMwSlZ3lFEj3ozIA7JHZA8/bayw4q9V/
         yGC8xmbwjeWDObe7plGcltlOc0r0yZHlpXGe3jwO1pwrJCb7aCNLs0s1Wa5Yggf9qidt
         qzri8woYF+npDLzBU6h9ulFA2VwtgHpVQHhMKMJSIWDW4rz/T2YnfWu5cKmuxf0ZxR5W
         qqyQ==
X-Forwarded-Encrypted: i=1; AL+hErFxuMEt9uSeoZ4Z5pxWhq8onl2z1qteOJqpp9kJIwFCbckHIShbPSWGzmei0TFJG2j6lcdbX9rmPiguew==@vger.kernel.org
X-Gm-Message-State: APuU4Z+XeQ4TPrboFv/nHFnAOlMMHdwNQBKbvqpDa9nhTSpNYo6mH3Il
	9NGG+cJrosRWyojzZ69Mbzg69Mo0jTqwFDD9DwM2XrSPGASkPxEH/iy+O+WLEevw5Q==
X-Gm-Gg: AYBFou0nVy7+gYC2wpsn5RCo++hvnEeAdXjgSpZDyg7f15+sx42/D3kc5f7KHpLzpK/
	Gn/MImm9x7ya4o/Tf/T+VhaRSSeHfdmieSCrzeetu/xJpMvn0D3WVN1xwW+YXGyINcm+0yT299e
	ugjA2sY73TaVOrrkJ7b9k1Q7y+XjZJglbTZziB6Hs6y0qKQnzd/+t4Rth3yZJRR4Y6trcS88lyj
	DIzPgRJA/VpPKVQZjwfoPgBzUiKAeHVZ4vBFGB/5ZTLZq/27qbrQF0Vj6F0zywa2Q0x5HFGFp4B
	izCbHvT5rTC2VhBBP1nihIEbjlAhMy05Ytn5Vxi0Q5/jKsbkFyCX8hiwYLEwix/GpvBejCV9ZQ3
	47Px/XQJ4ea/dIePbZxfIGxAsC1ZPuDwCmEMI5ZHAlYPbSr+269DuVWXtvj4B6Wzqfzrr9AW9DG
	MTpjbOTCJ2Uc0wHjzpwYa7y6Ypr2OklLHc39IhJcxc70bEGl2Zr5EzZ8+jOdprXvM9K8ZqFZled
	3mug35ERCk6m6/AuS7lcXnyzlHqLA/IZpQuvvCCGOWdtBBnhRqQynT/iX1BP7KL1vDHqkMRrgxM
	ehGgY6EHOx1QjPWaE57CJlooNCBkoF0uZH9Ws2zotp4dzItxnCwgcxidSJwPKbu75vEVcA==
X-Received: by 2002:a17:90b:2ec7:b0:3a6:d850:bf16 with SMTP id 98e67ed59e1d1-3b1679a3218mr887901a91.23.1794278528711;
        Mon, 09 Nov 2026 18:42:08 -0800 (PST)
Received: from google.com ([2a00:79e0:2031:6:e137:9384:7cd8:6e40])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b16792aabfsm1836319a91.12.2026.11.09.18.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 18:42:08 -0800 (PST)
Date: Tue, 10 Nov 2026 11:42:04 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Nhat Pham <nphamcs@gmail.com>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, 
	Brian Geffon <bgeffon@google.com>, Minchan Kim <minchan@kernel.org>, 
	Richard Chang <richardycc@google.com>, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-mm@kvack.org
Subject: Re: [PATCH 3/7] zsmalloc: switch handle type to struct zs_handle
Message-ID: <avKEXEl5-yYKFvD1@google.com>
References: <20261105044752.1997895-1-senozhatsky@chromium.org>
 <20261105044752.1997895-4-senozhatsky@chromium.org>
 <auy19VvYgb25vnFc@google.com>
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
In-Reply-To: <auy19VvYgb25vnFc@google.com>

On (26/11/05 17:03), Yosry Ahmed wrote:
[..]
> > -void zs_obj_read_sg_begin(struct zs_pool *pool, unsigned long handle,
> > +void zs_obj_read_sg_begin(struct zs_pool *pool, struct zs_handle *handle,
> >  			  struct scatterlist *sg, size_t mem_len);
> > -void zs_obj_read_sg_end(struct zs_pool *pool, unsigned long handle);
> > -void zs_obj_write(struct zs_pool *pool, unsigned long handle,
> > +void zs_obj_read_sg_end(struct zs_pool *pool, struct zs_handle *handle);
> > +void zs_obj_write(struct zs_pool *pool, struct zs_handle *handle,
> >  		  void *handle_mem, size_t mem_len);
> 
> I would squash patch 7's constification here.

Ack.

[..]
> >  static inline bool obj_allocated(struct zpdesc *zpdesc, void *obj,
> > -				 unsigned long *phandle)
> > +				 struct zs_handle **phandle)
> >  {
> >  	unsigned long handle;
> >  	struct zspage *zspage = get_zspage(zpdesc);
> > @@ -839,7 +843,7 @@ static inline bool obj_allocated(struct zpdesc *zpdesc, void *obj,
> >  		return false;
> >  
> >  	/* Clear all tags before returning the handle */
> > -	*phandle = handle & ~OBJ_TAG_MASK;
> > +	*phandle = (struct zs_handle *)(handle & ~OBJ_TAG_MASK);
> >  	return true;
> >  }
> 
> Would it be cleaerer if obj_allocated() just returned the handle here? I
> believe this can be done separately in a prep patch.

Ack.
