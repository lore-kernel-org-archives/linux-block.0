Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794330017;
	b=XoeRf+u/ppS/uFPdgsVaeRJqQMTdaq9Ldp0xqRyVXCOMwCBu5ePQJ8OkwppduXde3Bw+
	 gklotrxniUl4C1ZdjlQkQs4XSWUyGWgolt4VJ720BnLd9Q0pp1Xn5AJAd2oWvGMgql8GT
	 cSH+if7rSdEBsN8GZl0ws2L7jUdaU7iRlaT9DKo0qQQrw0XWeKJAuAWbISBXBwxM6bswJ
	 Tul4vIvrr0ZhBV0gfJQ4yt/8DN9YESJXPoyAr3wlASSVcR002LFggOI0ijmXJIFLuBqPw
	 gxnk+JSmgNpphPaUKyXyDtawUSradpSQtdNsf5a+e1HB3rrJTPwmZTabP+Q/HzaUk+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794330017;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=e9tGyPXz9xL70oEPM5OS0/SNYUGPcdfzb2vPyxxeOIc=;
	b=PZmUpvScM+Pbe2mEakBh4oTxrf4k9IPHVffRVzPkkqeH0gm3Jfu72hZAkjhjcZoB9+33
	 oprigc4N0erTmEc9LX8z2NgGJqmFYkBpuBIVh5bamfUKtUTQ55A352qpZbCp7M+IxS64i
	 K0d0XXDnc09kolzLQylluAtOCo5bEoY2yDoeKElI90noWc7i7VdiYptbzY+eQ3DPfxB0g
	 GjUM7Tvsa/60sJ8lwQq+oOcDGrPS7IjJxf0kYeUWtl4w71jIaNkWICf2qGx7TR7ixC7Zg
	 36xxPOwlpCMqv5do2j3WRSPDs/gbYIEPiDE834il6yxnLGvWoCxYCH6g2Ouq8KhJ08A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RJjGS4aJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C25606A81C;
	Tue, 10 Nov 2026 17:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RJjGS4aJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E6FE1F0089F;
	Tue, 10 Nov 2026 17:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794330016;
	bh=e9tGyPXz9xL70oEPM5OS0/SNYUGPcdfzb2vPyxxeOIc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RJjGS4aJgoI4lZen2laaGmqFvmOokyg5KlyFv3ITPJzQK7nQoN1EH0vupyDu4eYdt
	 mcgYPzP/L5UVUL1qt9J5GkXH7Q/3OFYCYebwiXqvEp5tT9oU9WeOwh5SEdlrt8oxfg
	 WlQdNAQN5uJrxTdnbQjrhppykQ47HZ9CXAjKVIDX+aXA1M3OwXAJ0lQ8ecu4d1k7sm
	 zws+3hX3Vq1FRf7CykYhr7msoJeGYx3JKUKxRrfP9USK4VqnBibHsXvxY/dRhoFKoo
	 fNtKn8v0cneOg0aHwztoMu7E2uOUndOA4Vc0YhDLJh/7IS19X5XfwNRbT0Vzsm6JIN
	 vzqxWiif6yw/g==
Date: Tue, 10 Nov 2026 17:00:15 +0000
From: Yosry Ahmed <yosry@kernel.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Nhat Pham <nphamcs@gmail.com>, Yosry Ahmed <yosry.ahmed@linux.dev>, 
	Johannes Weiner <hannes@cmpxchg.org>, Brian Geffon <bgeffon@google.com>, 
	Minchan Kim <minchan@kernel.org>, Richard Chang <richardycc@google.com>, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 10/11] zsmalloc: fold zs_obj_write() into zs_store()
Message-ID: <avNNjoQoBs7qIXd3@google.com>
References: <20261110054836.1515030-1-senozhatsky@chromium.org>
 <20261110054836.1515030-11-senozhatsky@chromium.org>
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
In-Reply-To: <20261110054836.1515030-11-senozhatsky@chromium.org>

On Tue, Nov 10, 2026 at 02:48:15PM +0900, Sergey Senozhatsky wrote:
> zram and zswap always call zs_obj_write() right after zs_malloc(), and
> zs_obj_write() has to take pool->lock and look up object location
> again, which zs_malloc() just did.
> 
> Replace zs_malloc() and zs_obj_write() with one single zs_store()
> call.
> 
> zs_store() takes zspage read lock under class->lock, before it drops
> class->lock to copy the data, while zs_obj_write() used to take it
> under pool->lock.  Compaction and page migration already take zspage
> lock under class->lock, so this follows the existing pool->lock ->
> class->lock -> zspage->lock order.  We don't need pool->lock there,
> zs_store() doesn't look up the object via the handle, it already has
> the zspage from the allocation.
> 
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> ---
>  Documentation/core-api/memory-allocation.rst |  2 +-
>  Documentation/mm/zsmalloc.rst                |  4 +-
>  drivers/block/zram/zram_drv.c                | 42 +++++---------
>  include/linux/zsmalloc.h                     |  6 +-
>  mm/zsmalloc.c                                | 58 +++++++++-----------
>  mm/zswap.c                                   |  5 +-
>  6 files changed, 47 insertions(+), 70 deletions(-)

zswap and zsmalloc bits LGTM:

Reviewed-by: Yosry Ahmed <yosry@kernel.org>
