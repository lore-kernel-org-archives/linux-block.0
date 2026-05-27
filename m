Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285BD39A061
	for <linux-block@vger.kernel.org>; Wed, 27 May 2026 06:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779863960; cv=none; b=RMo7fITkgl8fQ4SeOsGgy6h2DusnehGEUBDNgdmWwDrlblCBOj6tEFeZn180iF4ROXneW8dRD9WeZhgZO4GmAbD3q2zEVE+1Rg9dThR3Zfw3kUfdg86tmQDbCPxT+k/65oDRiOKosMcXSYbvo47hKU2kWj5ghi2j8lZyPAERiKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779863960; c=relaxed/simple;
	bh=pOPCft3nL9uWeg8fYQW0UiMoj2WtAxbf5BvQmmXwTis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k5dPrueIwoHA5u13kCET0k1X/XdIoQ+kBmnDkfNMqB5vcvXE5mWENUngD3Y5wURTCyF0OqoUG+jHZMKkXVPiPto+1t/blaes4Nqjk+x1RonuXT67Nmfd2STa4lKzdH5IJCt0uwSA08KXSNM3hLbpD89dqIXx26NMqZI43eRjDB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id E1DB568BEB; Wed, 27 May 2026 08:39:11 +0200 (CEST)
Date: Wed, 27 May 2026 08:39:11 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk,
	linux-block@vger.kernel.org
Subject: Re: [PATCH] bvec: make the bvec_iter helpers inline functions
Message-ID: <20260527063911.GB17042@lst.de>
References: <20260526070042.1817997-1-hch@lst.de> <ahX50HKkPtN7rNEq@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ahX50HKkPtN7rNEq@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, May 26, 2026 at 01:51:44PM -0600, Keith Busch wrote:
> On Tue, May 26, 2026 at 09:00:27AM +0200, Christoph Hellwig wrote:
> > -#define __bvec_iter_bvec(bvec, iter)	(&(bvec)[(iter).bi_idx])
> > +static __always_inline const struct bio_vec *
> > +__bvec_iter_bvec(const struct bio_vec *bvecs, const struct bvec_iter iter)
> > +{
> > +	return bvecs + iter.bi_idx;
> > +}
> 
> There's a couple drivers, nvme-tcp and loop, that call this without the
> const qualifier, so this will produce new warnings. The nvme-tcp one is
> simpler to fix by just adding the 'const', where loop looks like it
> needs a little more consideration to get there, but still doable.

Yeah.  I actually had this fixes but sent out just HEAD^..HEAD instead
of including the cleanups from them, which basically copy the nicer
code pattern from the zloop driver.
