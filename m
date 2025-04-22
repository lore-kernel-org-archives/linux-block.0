Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90107CA64
	for <linux-block@vger.kernel.org>; Tue, 22 Apr 2025 07:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745305235; cv=none; b=jle3DOtDQA4TuxhQKOUbAKrOXFierVqTg40mH4ozJUKSFiMdW+yIYRv6HSnAXZHNdWXDu8xNirigcRlx6MeCGU5IhbSiRLRW6kcz5l9qqo7q039Muz2JQMoKyHQ8E/fBm8WdvT2rBwIU/NZ3qFlYHXSSdMck2nHfUmdNy7xt1GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745305235; c=relaxed/simple;
	bh=S4qKLfBI0xEejHwfA7vrZn1HqJcKWuytp4KrDvJB64w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oZxp083GTcVf4C7+uiRc6ShcUvSb9N3jPPhDuVsO5X+WSplZGSHmvlbreCL/srKA5rLVD/P5CrvZnKfPohEuxJfXJtk8pIF7xcXLTvQGtp1HNi5WHg6HflqufMy5BzUo5w1Z2id19mY30elth/YvaePFAsb/nDXsYKCqD1RbA7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8AE3968AA6; Tue, 22 Apr 2025 09:00:28 +0200 (CEST)
Date: Tue, 22 Apr 2025 09:00:27 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
Subject: Re: [PATCH V2 03/20] block: don't call freeze queue in
 elevator_switch() and elevator_disable()
Message-ID: <20250422070027.GA30990@lst.de>
References: <20250418163708.442085-1-ming.lei@redhat.com> <20250418163708.442085-4-ming.lei@redhat.com> <20250421123456.GC24038@lst.de> <aAcUbMjt7QdBx3eS@fedora>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aAcUbMjt7QdBx3eS@fedora>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Apr 22, 2025 at 12:00:44PM +0800, Ming Lei wrote:
> On Mon, Apr 21, 2025 at 02:34:56PM +0200, Christoph Hellwig wrote:
> > On Sat, Apr 19, 2025 at 12:36:44AM +0800, Ming Lei wrote:
> > > Both elevator_switch() and elevator_disable() are called from sysfs
> > > store and updating nr_hw_queue code paths only.
> > 
> > I don't understand this sentence.  What does
> > "and updating nr_hw_queue code paths only" mean?
> 
> Both two are only called from the two code paths, in which queue is
> guaranteed to be frozen.

Yes, that's also verified by the asserts.  But the commit message doesn't
sound like that at all.

