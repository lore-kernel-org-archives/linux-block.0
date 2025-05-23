Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D82D2920A3
	for <linux-block@vger.kernel.org>; Fri, 23 May 2025 13:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748006808; cv=none; b=S1clZZECPg/S+iv087wBt/kpLl7Q9ZrC2iIEA/ixQPPDZ5W/fXQsg7cMVI1HnLB4I/mlMCWlL51ZmGpTyKW3+qXhX0RS1vyLHxOS+Db/618f+38MzdJJgtnh1v1ahaJ5BMuTwfk89iDLZZJK0hHLSkLbBAumknnpBUUpWVaUin0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748006808; c=relaxed/simple;
	bh=sqRkjVZ3F3dEMt2KHGeZ7+4b/Gt0fBHflzBf81991rY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NPA/TWTPwYhTyBXWdrnyERkybBnnW5QDYwaI05lFzi/stzR9f/5o+J+Go4fEW4P91ls3DjikSObiw5pK93ulnxo7TIl35LqGoeoK+3YGX/FegALB1ra4JyUnAaQJNekFUEtd4NkI23QxmoQHUmP/g/UVAZw2tFl09nsM0QcOvDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KgZHhKUc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KgZHhKUc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBEFFC4CEE9;
	Fri, 23 May 2025 13:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748006808;
	bh=sqRkjVZ3F3dEMt2KHGeZ7+4b/Gt0fBHflzBf81991rY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KgZHhKUc+ge2ysksf5L206+wa9025iWCyWieHRK8uiHNPYyy6GRP2RJQjLHZTQzPF
	 tWABZQc8UxgKfiHXTQP4oHqJ17jE++1DnPMVEUqJujkDbSHMu7s4I1GdDOTn0cQyy4
	 6h6CHpQyWLsv6n7CiXy3RZC9jy2b2z/GfTiFVCo5k1vU3C224i3GRpp8YPOYQmhClc
	 Er4HDmiqpDeLOvFLvxKcn0OANzLzdejQf9ZrEymBf/ZFvHakf9GDCfeF17b02gVmNB
	 8ADbhb6vFYkurAx4oGWjxoO6c7hIfByjXRMxhkp1BIeIkHuMVWVUT0vI03xYwA4HkH
	 SvDN/Hbfe1iTg==
Date: Fri, 23 May 2025 07:26:45 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 2/5] block: add support for copy offload
Message-ID: <aDB3lSQRLxjDHTSE@kbusch-mbp>
References: <20250521223107.709131-1-kbusch@meta.com>
 <20250521223107.709131-3-kbusch@meta.com>
 <aDBuQbsBRVjOc5wU@infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aDBuQbsBRVjOc5wU@infradead.org>

On Fri, May 23, 2025 at 05:46:57AM -0700, Christoph Hellwig wrote:
> On Wed, May 21, 2025 at 03:31:04PM -0700, Keith Busch wrote:
> >  struct bio_vec {
> > -	struct page	*bv_page;
> > -	unsigned int	bv_len;
> > -	unsigned int	bv_offset;
> > +	union {
> > +		struct {
> > +			struct page	*bv_page;
> > +			unsigned int	bv_len;
> > +			unsigned int	bv_offset;
> > +		};
> > +		struct {
> > +			sector_t	bv_sector;
> > +			sector_t	bv_sectors;
> > +		};
> > +	};
> 
> Urrgg.  Please don't overload the bio_vec. We've been working hard to
> generalize it and share the data structures with more users in the
> block layer. 

Darn, this part of the proposal is really the core concept of this patch
set that everything builds around. It's what allows submitting
arbitrarily large sized copy requests and letting the block layer
efficiently split a bio to the queue limits later.

> If having a bio for each source range is too much overhead
> for your user case (but I'd like to numbers for that), we'll need to
> find a way to do that without overloading the actual bio_vec structure.

Getting good numbers might be a problem in the near term. The current
generation of devices I have access to that can do copy offload don't
have asic support for it, so it is instrumented entirely in firmware.
The performance is currently underwhelming, but I expect next generation
to be much better.
