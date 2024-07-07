Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF2FE546
	for <linux-block@vger.kernel.org>; Sun,  7 Jul 2024 06:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720334443; cv=none; b=TiFNfj1Ke5rgLUBP3+VCWiLGxPoDIhPzWmLjE8u+uWIy0vf7nyN/YBPuG3XtwZSBdp3/VTbB+rVBT2PJ0tTuaOTstHzU2xBeO7dvvkIxNT3ElALBhgi7W2STKh8HkXm+3GMUlN1VUlaLCoCMahFg2F1yeAHwSjSOKbifSbghuI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720334443; c=relaxed/simple;
	bh=8rqcjuavurAPTmObuXxHiEBeEan0G6zgTieq7hAEm3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IGixEW3zB9tUwsneillthz+iMncXXI1JXHshwsRpsU72Xwlfw0nO34MHbqMCqkbMjYZPqLVXgIxUO2J7lp+zwSxSjOZ9Tdp8A6Rukg0hjc1iItMmYIKd3alEFH98k1Utj6bj5Z0PEP8DIFp7AoIDkTMBJiQbqh65uNfakYT54qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id BA46268AFE; Sun,  7 Jul 2024 08:40:37 +0200 (CEST)
Date: Sun, 7 Jul 2024 08:40:37 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	"linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 2/2] block: pass a phys_addr_t to get_max_segment_size
Message-ID: <20240707064037.GA432@lst.de>
References: <20240706075228.2350978-1-hch@lst.de> <20240706075228.2350978-3-hch@lst.de> <6ae64d5e-bc86-4c4b-bc3a-3d72e86d0dbf@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ae64d5e-bc86-4c4b-bc3a-3d72e86d0dbf@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Sat, Jul 06, 2024 at 10:37:11AM +0000, Chaitanya Kulkarni wrote:
> > -	return min(mask - offset, (unsigned long)lim->max_segment_size - 1) + 1;
> > +	return min_t(unsigned long, len,
> > +		min(lim->seg_boundary_mask - (lim->seg_boundary_mask & paddr),
> > +		    (unsigned long)lim->max_segment_size - 1) + 1);
> >   }
> >   
> 
> Looks good, is it possible to re-write last
> return min_t(..., ..., min(..., ...)) statement something like totally
> untested in [1] ?

>          paddr_seg_boundry =
>                  lim->seg_boundary_mask - (lim->seg_boundary_mask & paddr);
>          /*
>           * Prevent an overflow if mask = ULONG_MAX and offset = 0 by 
> adding 1
>           * after having calculated the minimum.
>           */
>          paddr_max_seg_allowed_len = min(paddr_seg_boundry,
>                                   (unsigned long)lim->max_segment_size - 
> 1) + 1;
>          return min_t(unsigned long, paddr_len, paddr_max_seg_allowed_len);
> }

What would be the point of that?  It is way harder to read and longer.
But except for that we probably could.

> 
> 
---end quoted text---
