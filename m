Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794372356;
	b=m7zb4midQVei9Ls1tefQhIIrntbQc+aYFEogBJ115rt8jP+pTx1GTBTCOpwGfPNPLaL6
	 RpurkvgZ3a4nXbc6ukkg2dv28pV7NN1JXyhhUBLfcB8x6wxtUjjvEZzIFPocBHvx3S4QV
	 /FjIoMeMfctEqv9Q+cvTmkwRa1febsF7/8JzSyJ5qqMfMatv5RP111RCNQeO5BCuiTds6
	 s8B5O3QMmTX/i86s/4UUZ6tJ55z9GGn0u/OfC7dv3spR92f46wFD8xonIh706AGcwZl/R
	 nAZldmrSItzu/tUT7Uri9DkcVyTEdScpAc2RX8coewYQIN/doziWs8XhmfbBGAIfy+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794372356;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=OxBc7udt7i3/+ft4HX8pY2dwrc5+goW7dVLwPsErWuM=;
	b=ooGLsI6dzWJWXh2fK6+p+libVUZv30hrVeUxwmv+dopHoCGwyRYyh3jRq+LYqS82EdsM
	 gRQJjN1wrrK8DHFhYHVbs5jj4xPAKiTrJAiCKJFeMF0HJqJ75gCirwI65fkKJkawbtklI
	 9edazp0L7Ck+dujW/H2KwGj2K8anS4MQ8EoxKCXjAvPpwIXVxzYdpYGQO3Ui9Ma3yGq68
	 x7pkzCSlaJvXWWIMUUFTy2cyHYeGdt1xA+ors6R5yVRdqaDQRd8JuJOivgtFzLrcNKJ/o
	 ZcVqvFziK31ZpDyU8Fa8ddLkbtv2xLU/X2dXrrHIRv7JVq5JB8emjyF/Xg2W5G0caiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=JE7IFn+K;
	arc=none smtp.remote-ip=209.85.216.54
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3C2606A337
	for <linux-block@vger.kernel.org>; Wed, 11 Nov 2026 04:45:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC3C2606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=JE7IFn+K
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3b179528d56so462348a91.3
        for <linux-block@vger.kernel.org>; Tue, 10 Nov 2026 20:45:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1794372355; x=1794977155; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OxBc7udt7i3/+ft4HX8pY2dwrc5+goW7dVLwPsErWuM=;
        b=JE7IFn+KaEWtBeLR1zH0AgVCQY/XnnnYAg3RElMOTH6p/ySOhguUDZY5n1s0h5ZRZk
         dqpJeaLH5weeDncpT2Y7WyOWWMoHVC7IhOHZ5tBMfa9K7rRCUffva66BeUmqnJ+2zVOy
         FJAAp5sbmAaKz3rdHWUpiQ04QDeJdm3BXDyCk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794372355; x=1794977155;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OxBc7udt7i3/+ft4HX8pY2dwrc5+goW7dVLwPsErWuM=;
        b=kmQ3ouxOC1jQbc9ZxgkJXwXMBaMTbLakJSeo5t8Mvs3X9pifQqEhaEQnxxOMa7zhTn
         OGv5rV8fShO9MDCwXykeSjpIz+tkn/O2KX54Y/HuN6aoSkGUZ9z2aeBrITVXCIwSjROd
         9L7jc5ZfBssrjQEdZQBjL9hiyJso65BjsnNbuNStDzjH0y7WPQyuW/RzrirRCWJje8Zw
         RqxNNE2CbFHMfleNSDgwtrj69VvtTRKIPmJm/y04PQftEQ22PNu3QBIYYPyJIwHfDTMa
         9KnJttAsOXFwX9Nv7gkpldzFJXOgkIBVsqlNyHR06k5sJBGLTY4UaTLGX9x8WiBORI7/
         PV4Q==
X-Forwarded-Encrypted: i=1; AL+hErHmgoCVwTBor99xUPsJ+63+n2T43sPldrgFbZ4Ag8ezz8srHaAM7g2Mxd/HUmt+ACtEBVcUQcCdr1/oiA==@vger.kernel.org
X-Gm-Message-State: APuU4Z/Sjx4kCRgtW9OUPX3MJBBCDuZmU7JMvYa/1K2Pq/P75R4o/lhO
	1LgqV8Ux8G7UkbomJGLPFmAKYW9ofNKf7XzDMDjVH7QuNREe8dezu9YGOAGqrst4rQ==
X-Gm-Gg: AYBFou0tIgRpc9oL5z2nj4Lw/TagvCegkdmh/V5Wn8UkT7OXoF8TxfpfSnX2Nj7m4e8
	2ChMGsjHC3ZhnOBYNUsGktG1SeQqAY3MQ01Ra0oGmnxmBLjSeNCBkJVaemlBbG1YAVcaej/h1H/
	SUqQCVXE0a16fEHlPZpeSZERb7Urt5oeZaDVL0VZY2qJR4DBM9UWm/qXCH1Xr4cbomBmAffZVns
	SwnFQfj34lIhI2pyJzDLm/xYFHCrjDt177mTXa5LTcyJbud0e31xzqvMco4HX+D46UDgmT5SeVT
	IiuaiHu9Y+ZEo04e2Tu9nyhnuI0S9kqZ+S7YufeXXBGo247dLfzo4KsyuQe9K5nCKEpUkfFslNp
	Oymrb7SSfJ970VmFT2kTnWB+gqyemQ0zk6TPJU/BmRQfe39DvGgREIaYl6jnI+vM1ry6muz6gPe
	dpGxb1NO9AA0Bq2xQbZNga0Y0fjGsaOJadeCY+9FWbFr0L/1AXX/wBtzsbcNqr/xD+jzFNlwAzT
	nhLRMr26236IJAqMyhFS0fmFjf7PhUqfuJT1n2QbmC99gNlaAY7vmWkd31mFyChjdggjTXRWBiQ
	uGRCmDik+GDlRiz7bwVSigztcitUUT8LojFSAHrqlffUcRy8yxwzVSnBoxhBIKnZaQ0PqKGgEty
	afQ9t+lsc6sQoO44=
X-Received: by 2002:a17:90b:534e:b0:3ac:8dfe:8ec9 with SMTP id 98e67ed59e1d1-3b182f63112mr1181106a91.47.1794372355253;
        Tue, 10 Nov 2026 20:45:55 -0800 (PST)
Received: from google.com ([2a00:79e0:2031:6:ad6a:b446:df00:78dc])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b17db85a9bsm2707226a91.14.2026.11.10.20.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 20:45:54 -0800 (PST)
Date: Wed, 11 Nov 2026 13:45:51 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Nhat Pham <nphamcs@gmail.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Yosry Ahmed <yosry.ahmed@linux.dev>, 
	Johannes Weiner <hannes@cmpxchg.org>, Brian Geffon <bgeffon@google.com>, 
	Minchan Kim <minchan@kernel.org>, Richard Chang <richardycc@google.com>, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 08/11] zsmalloc: encode 1-based obj_idx so valid obj
 is never 0
Message-ID: <avPy0QUkvtzNy8aA@google.com>
References: <20261110054836.1515030-1-senozhatsky@chromium.org>
 <20261110054836.1515030-9-senozhatsky@chromium.org>
 <CAKEwX=OhvH80f-6emK0fBhbm2d4Er0rQ8oXX=FmfG0vrTdvZdA@mail.gmail.com>
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
In-Reply-To: <CAKEwX=OhvH80f-6emK0fBhbm2d4Er0rQ8oXX=FmfG0vrTdvZdA@mail.gmail.com>

On (26/11/10 10:57), Nhat Pham wrote:
> > The next patch embeds struct zs_handle into zram and zswap entries,
> > and a handle is considered allocated when its obj is not 0.  But obj
> > can be 0: object 0 of a zspage whose first page is PFN 0 encodes to
> > 0, and some platforms do give PFN 0 to the page allocator.
> >
> > Store obj_idx + 1 in obj, so that a valid obj is never 0, and adjust
> > ZS_MIN_ALLOC_SIZE so that the largest index still fits.  Unlike a
> > separate tag bit, this doesn't take any bits from obj.  zsmalloc did
> > the same before handles moved to handle_cachep, see
> > commit 67296874eb1c ("staging: zsmalloc: Ensure handle is never 0 on
> > success").
> >
> > Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> 
> Bit convoluted, I assume the this is so that we can use obj's 0 value
> to mark unallocated state?

Correct, 0 is for zs_handle_is_allocated().
