Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297071C5D59
	for <linux-block@vger.kernel.org>; Thu,  8 May 2025 10:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746698815; cv=none; b=sE4W3VBQUFt+oa8MHGz0diKSXVeWE9e/9N5E+f/ePe5v9BO2QIzmtYQ0PRqfsYVNowvmX0JwkZZef4GDHMnUa87WQqVG7LWEYDZZzvwlIwXbXBVvwN8y0GDUa5Pg7A4Vlz8ExgSNA9hc063XtfJROdcXFrW1k8Ber5LBMqxZrnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746698815; c=relaxed/simple;
	bh=v04Cy7kmwFAX8crSLae7MFvkfVkNHRbU9S+geJjtBL8=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pf2GkdNKujUcsZkTVfiJTfM34pANBfGKHB8BtSSDv0C6mhLeRbOpfQuDWNQVA2vX5E8wfAspznqCG1ZxyMm/0d4YaWaxXynu3vxvKxAv+l6f8sGOey/ppiBWXrkx1QnHf/sDNBIt/X4iKpj8dgWlLtDK/KOeyvjYmSHRkRH9gOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dN7KYuUO; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dN7KYuUO"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=pfHS1satfw4d5UlQRemOh7AwSCj6+f4ja/q+0KzVbcE=; b=dN7KYuUORZ+nhO+OImtjFutR+v
	//J4b2N1a9Yq/rOlkOXYl5LtENRH4GQaD5w6jru6ckFx46y3wDtSbfRd6kFhyX9kWkdMzmWEuWwNq
	qtp/Ax9s03FeFDSt66YC/pytIf0hmgX86su9i3jqYv9fmjl+G8TLQIADz1Kr60YEaGyuaJewjQUdS
	CEExDFLHgGromSAmsVvBPBEqsgQ7bgj3guD4dBdvgtzt5zfRLSNP+dtNSJq6KJwuWwwOJOpo0cEBe
	o6BRhPh+FUIXhOoX9tYyDQ+kUXyfplwFSdmQLwfhq0W4d5zDmlmvqus4xNFuff0RoTiLn7cEfn/h6
	NGU/GzrQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCy9V-00000000L5s-07EI;
	Thu, 08 May 2025 10:06:53 +0000
Date: Thu, 8 May 2025 03:06:53 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Christoph Hellwig <hch@infradead.org>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Christoph =?iso-8859-1?Q?B=F6hmwalder?= <christoph.boehmwalder@linbit.com>,
	drbd-dev@lists.linbit.com, linux-block@vger.kernel.org
Subject: Re: transferring bvecs over the network in drbd
Message-ID: <aByCPR7Ynl93qDiY@infradead.org>
References: <aBxTHl8UIwr9Ehuv@infradead.org>
 <aBxt3NsJcofxhV5P@grappa.linbit>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBxt3NsJcofxhV5P@grappa.linbit>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, May 08, 2025 at 10:39:56AM +0200, Lars Ellenberg wrote:
> For async replication, we want to actually copy data into send buffer,
> we cannot have the network stack hold a reference to a page for which
> we signalled io completion already.
> 
> For sync replication we want to avoid additional data copy if possible,
> so try to use "zero copy sendpage".

I didn't even complain about having both variants :)

> 
> That's why we have two variants of what looks to be the same thing.
> 
> Why we do it that way: probably when we wrote that part,
> a better infrastructure was not available, or we were not aware of it.

Yes.  While the iov_iter and the bvec version of have been around
for a long time, drbd probably still predates them.

> Thanks for the pointers, we'll look into it.
> Using more efficient ways to do stuff sounds good.

thanks.  Note that now that ->sendpage has been replaced with the
MSG_SPLICE_PAGES flag you can actually share most code for both
variants as well.
