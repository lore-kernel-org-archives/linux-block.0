Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96BC0C133;
	Sat, 30 Aug 2025 01:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756518463; cv=none; b=Kv5Yx4cTjfVtyFarhz1Kwb/LTRnGuKLUtiG9OP1ce8vxgrKwC9xkbvTlAL76b9HLE894Y3NvW0VaaUndy0Zov6OMsJBgU5p6ehAnaP8da6gXsS+nklrHyoMlsh4P3987eVIa3z9z+yRyByMEkqDl0QdbJEZnnGu23tTILvYXUwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756518463; c=relaxed/simple;
	bh=zDvl+0mYl7B1IhYYLGnaqnKHVG/ZkuRi7oUHiicRwf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ApkcG9Orroyc1xDugUjZ5Z98+sTmJWoZouZf4gEY2je9EcSWAJwg2CJ7UBvxnFskKmacrXzCd5QlQwO8O7Z2Y7KH3AkSI+XI2kMK7xSnlStkCHS1ciZt+PtB82babAGUcBN24v4f+EbXAU8Olam7ReK45omn+xXvftZQR1vw4/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nqsj8dN+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nqsj8dN+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6222C4CEF0;
	Sat, 30 Aug 2025 01:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756518463;
	bh=zDvl+0mYl7B1IhYYLGnaqnKHVG/ZkuRi7oUHiicRwf8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nqsj8dN+DUEsg1mJ2QeNwyZCNjjtY5olN8/7yi6jMQs7E7ITe97a/OXNae7SguaO/
	 19om4q+mKKxoah75XzkrDdOXZFVAZeLHUrjozV+8HTkBvG97J6D20AcXld6ZPz+sCB
	 zezMEVYQqc1kJJboQlvTTMreLozgtSwiXjv6c0gE35LM3Y0eSHZJa3zllemdD5ocL5
	 If5ey2NVeII7UYUyDJHelS7yw4uik/YTVmT+CXBCr6P93WVze2HUbyMkgKDVSSYDp0
	 Lh3BWmbjmIEIrZKrV88flYV7VY++9zwL3yvFjC/JJYWIlsYf0SEgEZDR2m1MUMiCPS
	 5PVbvITmfZkkg==
Date: Fri, 29 Aug 2025 19:47:40 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Christoph Hellwig <hch@infradead.org>, Keith Busch <kbusch@meta.com>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	axboe@kernel.dk, iommu@lists.linux.dev
Subject: Re: [PATCHv3 1/2] block: accumulate segment page gaps per bio
Message-ID: <aLJYPGKE4Y_6QzY2@kbusch-mbp>
References: <20250821204420.2267923-1-kbusch@meta.com>
 <20250821204420.2267923-2-kbusch@meta.com>
 <aKxpSorluMXgOFEI@infradead.org>
 <aKxu83upEBhf5gT7@kbusch-mbp>
 <20250826130344.GA32739@lst.de>
 <aK27AhpcQOWADLO8@kbusch-mbp>
 <20250826135734.GA4532@lst.de>
 <aK42K_-gHrOQsNyv@kbusch-mbp>
 <20250827073709.GA25032@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827073709.GA25032@lst.de>

On Wed, Aug 27, 2025 at 09:37:09AM +0200, Christoph Hellwig wrote:
> On Tue, Aug 26, 2025 at 04:33:15PM -0600, Keith Busch wrote:
> > virt boundary check. It's looking like replace bvec's "page + offset"
> > with phys addrs, yeah?!
> 
> Basically everything should be using physical address.  The page + offset
> is just a weird and inefficient way to represent that and we really
> need to get rid of it.

I was plowing ahead with converting to phys addrs only to discover
skb_frag_t overlays a bvec with tightly coupled expectations on its
layout. I'm not comfortable right now messing with that type. I think it
may need to be decoupled to proceed on this path. :(
