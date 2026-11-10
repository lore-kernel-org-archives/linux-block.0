Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794328131;
	b=z/80+ZwZoQN//hpm4x8jgJmIYbbEiSEIYul9hk+WgmqK3IT5mR5V1Rdu9uvF275dxJIx
	 mkGxNUqlhULMBGvVNjKUUUO5k+WFUMykFcXZrYYW0bvZJSj3rKJd4n3Gzihu4TTO3Dt+i
	 xMT8N56ciH6bq0eElBuVkK/HAA8mH531cmHIQjGhnLzkl2GiH6VA40pEe/7whaEQozBUS
	 1N5f6l4VafYPqLsxNN0yt7A3/t3OVqJ2I5ijuM62Rqxt7doW+gNEfzYWZxvzFuohqCf6k
	 P8W2GyhKpwEJVZcO337kxBtzfbRRk/1rCF4I/FmfR+gV3TvBzC/QHf564TMWM5MPIbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794328131;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=jqTdiGrgVttSAor12rHHo7dssn/lkPOpavFY9gHvLGY=;
	b=dVMVMcMSTuZ7Lk6Bt2uR2KqAZfDpzbvxF+WVKh6thVOpursV5fPciZPECjBqkUZHCyDp
	 BeOqa0oS+1ZMQjUp8i4J6qyASQeyOhfa5HEoRwpUDBNGN4rTUXx3h5/5RXPH/c8f5Cu+f
	 gjifhXZq0DtyNAkNxFxxrV1hxTYHAput0RtEUpzQfnHDK/gT34P0sb8pfFJhcmgGV3VTY
	 gG2tQtEEv5BtPsQjmvJGmtccuS3EM2MWy76dGkulbiP6erb8PLR0z8mrTyJB0y7/MVsjs
	 hHPnYG63X7Slvv09LeTamFGbJE7p0I/W1FoA8xKaRMCfUuEoiCqsq7V5qlLH3cWow6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XiGp388F;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEFA5606A320;
	Tue, 10 Nov 2026 16:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XiGp388F
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58DC51F0089F;
	Tue, 10 Nov 2026 16:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794328130;
	bh=jqTdiGrgVttSAor12rHHo7dssn/lkPOpavFY9gHvLGY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XiGp388F+LBQoDPScHe38P94OcaRfL1I/7LCZEV9XQyhQBfrObBCRp2tOJVWf17CM
	 ajvv9s+2VWt9TLWlm/rvE2/TldaCEcMwPw2EVG+4CtTmOQDB//wCthK4k8z0VRolEY
	 3ZgxVclLmiFLksiVRA1czkoxbd4OcHnA+nfewp0+XKrwaKPgg/ljMP0VTbJq1eVGbP
	 V8qkn1egKl314eFeaajKU/lFCMsqTzA2aOzLE+3ODPs6a6L8//epSU8jhWx8CL4uQu
	 kuZV3NrP6f9tU1UjqTCwQzPsJI2kPFvCDdJSDHopBOxDsE+HsGG+ob83L+TRnTjOL1
	 pQPa0nsEy4gBQ==
Date: Tue, 10 Nov 2026 16:28:49 +0000
From: Yosry Ahmed <yosry@kernel.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Nhat Pham <nphamcs@gmail.com>, Yosry Ahmed <yosry.ahmed@linux.dev>, 
	Johannes Weiner <hannes@cmpxchg.org>, Brian Geffon <bgeffon@google.com>, 
	Minchan Kim <minchan@kernel.org>, Richard Chang <richardycc@google.com>, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 03/11] zsmalloc: return handle from obj_allocated()
Message-ID: <avNGMNpCP5rNT-Rc@google.com>
References: <20261110054836.1515030-1-senozhatsky@chromium.org>
 <20261110054836.1515030-4-senozhatsky@chromium.org>
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
In-Reply-To: <20261110054836.1515030-4-senozhatsky@chromium.org>

On Tue, Nov 10, 2026 at 02:48:08PM +0900, Sergey Senozhatsky wrote:
> Allocated handles are valid kernel addresses and never 0, so let
> obj_allocated() return the handle directly (or 0 if unallocated)
> instead of returning a bool.
> 
> No functional change.
> 
> Suggested-by: Yosry Ahmed <yosry@kernel.org>
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>

Reviewed-by: Yosry Ahmed <yosry@kernel.org>
