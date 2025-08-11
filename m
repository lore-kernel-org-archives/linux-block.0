Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81732E540A
	for <linux-block@vger.kernel.org>; Mon, 11 Aug 2025 15:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754926040; cv=none; b=G0Bjj3VBsbv3NEfZrohvXyMVP7w+WsO4kRPgAQ80xbsttp+M+qUw5NJi+FDVKOa97SLbUPkqhI2drd+Fpey8vDohvmxPK/Hwhn8Bh9/6G3j5BOCfaQ8jd2u53hA/84XGnXQNy3DTLM8WSy2VOx9gCaSzipYTjjDm5TQ2Xvaj7EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754926040; c=relaxed/simple;
	bh=VpLhh5UIBa5WLWeWZ91IRhfl7lk6wwEiIrfIGeNP384=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OPfnAeESTrSo5mJCVV8Jn0z3MJBoF19VzpvG8LhOEOKxFN7lv9AMoM23ZQWZpMXKHtddBUYjtZvcU/FZ89/CeA4BS6eUGJb3ASDUGcunN984ZA4ABaKHoMoyu2QIliYhYC7Kl7q9tMC9cZVrnDk++nKl1AswqN7huY5oeZ+X4k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ESZVrbwu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ESZVrbwu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A13DC4CEED;
	Mon, 11 Aug 2025 15:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754926040;
	bh=VpLhh5UIBa5WLWeWZ91IRhfl7lk6wwEiIrfIGeNP384=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ESZVrbwu8vQ0/ZLULCITShyrmsSE4YnhQuKlM6sXRQavbKIMFKpKFZjBBSw5EpjML
	 CwCCWG+Y3h5+iQAHdgZHEf2fw++Qg/hfXpbSpFVKK3EgpHmH1SPgLFFF3XgWO7SQQv
	 VYmLiJ9aQtNtK7bdwoERwKSvX/UGVUJoanUXixiPok2NlRg2G9pjE5qFS+Zuq7d6jl
	 xGNvc/2OOoZoyPyS5hrE9PaKhX19gvSqurB9VfeOTPtVGqElV0wCPg2IrD81wwZ6eB
	 GRqGPD0Md9rGe9enDks2OPMLMUew/1vAjbrxgnYQ8F2NdBSsLAgyuwdiDq6vfhisWA
	 Dz0jniuxG7asQ==
Date: Mon, 11 Aug 2025 09:27:18 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, axboe@kernel.dk
Subject: Re: [PATCH 1/2] block: accumulate segment page gaps per bio
Message-ID: <aJoL1rsvI5bXkod_@kbusch-mbp>
References: <20250805195608.2379107-1-kbusch@meta.com>
 <20250806145621.GC20102@lst.de>
 <aJN4b6GS30eJdQLd@kbusch-mbp>
 <20250810143112.GA4860@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250810143112.GA4860@lst.de>

On Sun, Aug 10, 2025 at 04:31:12PM +0200, Christoph Hellwig wrote:
> On Wed, Aug 06, 2025 at 09:44:47AM -0600, Keith Busch wrote:
> > 
> > Maybe, but I don't have anywhere else to put this. We split the bio to
> > its hardware limits at some point, which is where this field gets
> > initially set.
> 
> What we do for nr_segs is to just do it on stack while splitting,
> and then only record it in the request.  I think you could do the same
> here, i.e. replace the nr_segs output parameter to __bio_split_to_limits
> and it's helpers with a new struct bio_split_info that in the first
> version just contains nr_segs, but can be extended to other easily
> derived information like the page gaps.

I initially tried to copy the nsegs usage in the request, but there are
multiple places (iomap, xfs, and btrfs) that split to hardware limits
without a request, so I'm not sure where the result is supposed to go to
be referenced later. Or do those all call the same split function later
in the generic block layer, in which case it shouldn't matter if the
upper layers already called it?
