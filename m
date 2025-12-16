Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742E333AD8B
	for <linux-block@vger.kernel.org>; Tue, 16 Dec 2025 23:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765927458; cv=none; b=FGXrRlrB5GBN/WyfQGY0CZYjT/L6EhdT7BFfmZ/rkwGSaBWjQQCyPGvYaAgjHvCWhWiC6ymOisEp5NAeifqg/Qs20NguUW4XKeaxOhn/PPjnXIhtzoJshyIeRfOpXRlC3FGAyxObaobQZBLUfiDmcUtyGTs6Jo8Xu6RvTRDFvz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765927458; c=relaxed/simple;
	bh=QNPBmbxw0Q7A9XnDxdJbSyR4Ro/tq0C3opw5vu/wetY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oQLF0ytKi/HvCUnNK20hNCvixHss+az/LCZi5bUYFSmmP097DqO3WvKYquxt9XeB2ef5fSLdW9o7W4D+oHqtPX6cLmm1nERxXFP5OMj9DUlErVzzTRhwgCKn+5bgBVYqQA+O1gX5HU7V/1k+sOUzxmfd9rtlKr2pOPZV7C0Q9Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vdd4D/w2; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vdd4D/w2"
Date: Tue, 16 Dec 2025 15:23:53 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1765927438;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=G31AkpMZemEUvcQ+pR++1/nOv6ZIsNUGB/faxeF8AQE=;
	b=vdd4D/w2Y4vy2dn5sy4fDWEsqgbkF6bNKUoKAm3lH7x4SHyySSzN9PwQ5OKem0Y2duHIqf
	1+eBiaqTGhuvPQkJTbXX5oSKxgDkcm4Vi1YbmOhB7XEWYUz0seeBukaNr2z7O92dmc4yHZ
	w6DIyi1uvfAl5BIvZ92mjq3HvNUE3Dw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>, 
	Deepanshu Kartikey <kartikey406@gmail.com>, akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: retiring laptop_mode? was Re: [PATCH] mm: vmscan: always allow
 writeback during memcg reclaim
Message-ID: <gweo3wdh3agfavhiky5cloweu4m2hvgzk2j2euckbka5x7n47e@ezjmx7eq7ks5>
References: <20251213083639.364539-1-kartikey406@gmail.com>
 <20251215041200.GB905277@cmpxchg.org>
 <aT-xv1BNYabnZB_n@infradead.org>
 <20251215200838.GC905277@cmpxchg.org>
 <aUENEydFvVvxZK8r@infradead.org>
 <20251216185201.GH905277@cmpxchg.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251216185201.GH905277@cmpxchg.org>
X-Migadu-Flow: FLOW_OUT

On Tue, Dec 16, 2025 at 01:52:01PM -0500, Johannes Weiner wrote:
[...]
> 
> From 087f10b8046864f71ebc3a3f3316b097932cbded Mon Sep 17 00:00:00 2001
> From: Johannes Weiner <hannes@cmpxchg.org>
> Date: Mon, 15 Dec 2025 12:57:53 -0500
> Subject: [PATCH] mm/block/fs: remove laptop_mode
> 
> Laptop mode was introduced to save battery, by delaying and
> consolidating writes and thereby maximize the time rotating hard
> drives wouldn't have to spin.
> 
> Luckily, rotating hard drives, with their high spin-up times and power
> draw, are a thing of the past for battery-powered devices. Reclaim has
> also since changed to not write single filesystem pages anymore, and
> regular filesystem writeback is lumpy by design.
> 
> The juice doesn't appear worth the squeeze anymore. The footprint of
> the feature is small, but nevertheless it's a complicating factor in
> mm, block, filesystems. Developers don't think about it, and it likely
> hasn't been tested with new reclaim and writeback changes in years.
> 
> Let's sunset it. Keep the sysctl with a deprecation warning around for
> a few more cycles, but remove all functionality behind it.
> 
> Suggested-by: Christoph Hellwig <hch@infradead.org>
> Message-ID: <aT-xv1BNYabnZB_n@infradead.org>

Is there a need for above message ID? Why not put the whole lore link?

> Acked-by: Jens Axboe <axboe@kernel.dk>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

One nit below and other than that you can add:

Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>

> --- a/include/uapi/linux/sysctl.h
> +++ b/include/uapi/linux/sysctl.h
> @@ -183,7 +183,7 @@ enum
>  	VM_LOWMEM_RESERVE_RATIO=20,/* reservation ratio for lower memory zones */
>  	VM_MIN_FREE_KBYTES=21,	/* Minimum free kilobytes to maintain */
>  	VM_MAX_MAP_COUNT=22,	/* int: Maximum number of mmaps/address-space */
> -	VM_LAPTOP_MODE=23,	/* vm laptop mode */
> +

There are 8 earlier enums here with names like VM_UNUSED* along with
the information on what were they. Should we have something similar for
this one? Something like:

	VM_UNUSED10=23, /* was vm laptop mode */

