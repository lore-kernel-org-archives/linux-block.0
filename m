Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7162BE7AD
	for <linux-block@vger.kernel.org>; Thu, 18 Dec 2025 07:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766042488; cv=none; b=gEJozvsz0/mv0S7ssyE5+0tqfyUOIaAzx3yL0Z0Alyu4Q6x/+L+9KMbj6aiPv/g4GbesKCIO44CyQpunoKWn/HWQUm94ELM+aoDgXJg79MURjcG5CRUj/m9xBqlmEg4aI8xNUc4pHTPCVxokYAXdOpFMUX1zi0VVnCH8g1KaALc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766042488; c=relaxed/simple;
	bh=UEHyABRpxQTi4Ga0+FuCEzL5ixPmc4cdUjskcHJfvsg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fBvenAIpIlw7h7u9tPlIxKBgq3mQzLGWvTnX0MKc2KtgDs1pRlw0oG76kdEinFYcjMEzVE6XcRDcMSdNYL3Xlbnc6JOcv32u5daSTVXSQCt1qUN/w3FW/3jNsq/omTFII4rwdfYMWvQuXPipKfyemmxplu0JKKVfQEdIwVIbB/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NYEjKcXO; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NYEjKcXO"
Date: Wed, 17 Dec 2025 23:21:04 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766042469;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QdZo6L5c2+gsxT6SqfejRQC9h/QKy9Y5BdqFa3CYsb4=;
	b=NYEjKcXO6pX2fx2bGc9uptFb6pO6C7AvivV0STkov7inU2M0mWHwcirHJByV6wiDvx7Q/9
	geB+YHVMeOYQHkAzN/u+sdw+gGRFHY+EtZktne3zFLOebRl/GVvuJY5T3FvETtId+qsf7S
	sBpWzybG3rneiH3E2lrowpR3ysywg9o=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>, 
	Deepanshu Kartikey <kartikey406@gmail.com>, akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: retiring laptop_mode? was Re: [PATCH] mm: vmscan: always allow
 writeback during memcg reclaim
Message-ID: <vs6nessf2rp4qvh7lpfybntrqzjnvthfykpf4h6rzxwlm77eyr@w74i6i4ojsgz>
References: <20251213083639.364539-1-kartikey406@gmail.com>
 <20251215041200.GB905277@cmpxchg.org>
 <aT-xv1BNYabnZB_n@infradead.org>
 <20251215200838.GC905277@cmpxchg.org>
 <aUENEydFvVvxZK8r@infradead.org>
 <20251216185201.GH905277@cmpxchg.org>
 <gweo3wdh3agfavhiky5cloweu4m2hvgzk2j2euckbka5x7n47e@ezjmx7eq7ks5>
 <aUMLmJ0En24pQBX_@cmpxchg.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aUMLmJ0En24pQBX_@cmpxchg.org>
X-Migadu-Flow: FLOW_OUT

On Wed, Dec 17, 2025 at 02:59:20PM -0500, Johannes Weiner wrote:
> On Tue, Dec 16, 2025 at 03:23:53PM -0800, Shakeel Butt wrote:
> > On Tue, Dec 16, 2025 at 01:52:01PM -0500, Johannes Weiner wrote:
> 
> > Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>
> 
> Thanks!
> 
> > > --- a/include/uapi/linux/sysctl.h
> > > +++ b/include/uapi/linux/sysctl.h
> > > @@ -183,7 +183,7 @@ enum
> > >  	VM_LOWMEM_RESERVE_RATIO=20,/* reservation ratio for lower memory zones */
> > >  	VM_MIN_FREE_KBYTES=21,	/* Minimum free kilobytes to maintain */
> > >  	VM_MAX_MAP_COUNT=22,	/* int: Maximum number of mmaps/address-space */
> > > -	VM_LAPTOP_MODE=23,	/* vm laptop mode */
> > > +
> > 
> > There are 8 earlier enums here with names like VM_UNUSED* along with
> > the information on what were they. Should we have something similar for
> > this one? Something like:
> > 
> > 	VM_UNUSED10=23, /* was vm laptop mode */
> 
> The other enums in that file leave holes, the VM ones have a mix of
> VM_UNUSED and holes. I don't think it matters either way since the
> sysctl syscall has been removed and nothing new should be compiled
> against the definitions in this file, right?

Yes, you are right.
