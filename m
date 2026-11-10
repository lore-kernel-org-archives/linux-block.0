Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794330208;
	b=Sk47Nid2ZjPfLlr+IjB2E2969fUiBXNBiergjsgSpzQtpmBtPcRark/MB9JY8BWR+wti
	 t9lMrHOHffNi1scRxy0BYTo6vadlPGjIcqVNu+dnqOAgtef7FdxrRCas4JDrEpjWRvvXp
	 SUBhCyVrECdNHMEYSpfgqYkTOPtc4NPOetgrt6DYbLefFmZ6g6Nz+VObvBV8Cejjom6/V
	 SkCb3O1OmMxryPkEXh6onl2Xp2jmgh5XpjN8yRY5GTMCYPp/A/Zw8UOev5ZM1DUuWaAec
	 pmNlci9NfbI3ef07aKgOl+EKQpKC0XzrshF66oOc0z4iu32WR+/2jNMmQ3Lxm0Fvb7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794330208;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=OYBNS/wIwETszXOBgNpLsMvPx95qdQbX+4kEObkSrd4=;
	b=wVpXSAz9wqLBE/OVoUJOIjhVy9dELK6b8xXpXllMWu7jDUtpsQtfHF4mhrblutdU9xlM
	 hpd9tikSqWBVC4PmlrCRobqJxGMvOL0x8OZdJ2vA7twDCyhNB0bXrGlTyEB4Xr0I4VGK6
	 vOk06GmXp60z9ku0bCR5KFkrclJl+LaAbNYPh+Pmyri+aEduZLx4f7nXyX/3oT9A+O5Jh
	 OYMQgmWY3w5M7yT/6VBcXBj3RwUrNzpoSk6YbDMQqrx50lLUquPz1ACiKTNKfdRmS34WI
	 wJ7fsBJywzrbmUqVa9+6b+sKuA7NltrBFTqkAHtrT6x+0CT+ubeYau5D1VO3boDlMtg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h9xiN3w6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2A3606A31C;
	Tue, 10 Nov 2026 17:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h9xiN3w6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32CD81F008A3;
	Tue, 10 Nov 2026 17:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794330207;
	bh=OYBNS/wIwETszXOBgNpLsMvPx95qdQbX+4kEObkSrd4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=h9xiN3w6tQaZmnlGlFXHoQYdpAhIdrU1SCwWBhN4fRfNjkM+xDQIPj2Pba9imBt8x
	 SrGL0Hayefiwa7HkLpIrlkOPy4h09Ukw3bDyV8IpF+nGgbb9hZNWvmEkP1GbwkYUsl
	 wB5jx8genrtWxC5qMhpd3wEXiP7cpXpn/Cj7Zt3eSdLoqW3fSoHZyJlQ2fEPRvz1gI
	 PVDFENGYdlYYuvtD6FgjB5EscgrFiYvWXUrcpjr1ASmO9dE+/N31CsETmVpuRSraZP
	 8pO4w/TgE2wcEn82+N9jJoSQP9WPVgUBlZmOLJmDPZPHKRlsmuYX4fSfJL8a1NmcfC
	 2rJqxQ61582SA==
Date: Tue, 10 Nov 2026 17:03:25 +0000
From: Yosry Ahmed <yosry@kernel.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Nhat Pham <nphamcs@gmail.com>, Yosry Ahmed <yosry.ahmed@linux.dev>, 
	Johannes Weiner <hannes@cmpxchg.org>, Brian Geffon <bgeffon@google.com>, 
	Minchan Kim <minchan@kernel.org>, Richard Chang <richardycc@google.com>, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 11/11] zsmalloc: populate new zspage outside
 class->lock in zs_store()
Message-ID: <avNOUwojK5x8IkOm@google.com>
References: <20261110054836.1515030-1-senozhatsky@chromium.org>
 <20261110054836.1515030-12-senozhatsky@chromium.org>
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
In-Reply-To: <20261110054836.1515030-12-senozhatsky@chromium.org>

On Tue, Nov 10, 2026 at 02:48:16PM +0900, Sergey Senozhatsky wrote:
> A new zspage is not on class fullness lists and is not movable until
> zs_store() calls insert_zspage() and SetZsPageMovable(), so neither
> other zs_store() callers nor compaction and page migration can see it.
> Nobody else has the handle yet either.
> 
> So for a new zspage allocate the object and copy the data before we
> take class->lock, and don't take zspage read lock.  This makes
> class->lock critical section shorter and saves a zspage lock/unlock.
> 
> Suggested-by: Yosry Ahmed <yosry@kernel.org>
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>

LGTM:

Reviewed-by: Yosry Ahmed <yosry@kernel.org>
