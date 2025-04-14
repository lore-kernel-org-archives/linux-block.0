Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0D6191F95
	for <linux-block@vger.kernel.org>; Mon, 14 Apr 2025 06:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744611006; cv=none; b=Y4+i+8lGV/2ot6Dkf1ezamU9HM578/Mku7lJtYw9JR/5WOouyWsqihVt3sW5v9Dd6Pl8UiwQDtoa8aFB811L/4k7SW6QyHPr5/se0uGIHK8tQVL2jYANEYsUvTcnICEib3IcHbMDJxKzM8f7UYY2zaN6T7HaRZ54Z7bokL+v58w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744611006; c=relaxed/simple;
	bh=Tem0NpyeaKQrt7JbjeynWcfsCu0LJCC5dG6xq4ZnExc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sXk+/+jeGZjuDOF0kBTg9j+CBmjRylULClaCdPB62wyau4Ttiiv5GC+DrNVApss1KRNf3VISRflgex3SHRzGiG47ewW/uBOr7A3O2SROXZUQ5kX8MpfwEOGdNGXB0h/OS1D943si6OPvCl9cVgVCo+siMwvb7HYQNUSAoZ21WaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id F35CC67373; Mon, 14 Apr 2025 08:09:59 +0200 (CEST)
Date: Mon, 14 Apr 2025 08:09:59 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
Subject: Re: [PATCH 05/15] block: simplify elevator reset for updating
 nr_hw_queues
Message-ID: <20250414060959.GB6451@lst.de>
References: <20250410133029.2487054-1-ming.lei@redhat.com> <20250410133029.2487054-6-ming.lei@redhat.com> <20250410153417.GA12430@lst.de> <Z_xdtNiZb38ubXVe@fedora>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_xdtNiZb38ubXVe@fedora>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Apr 14, 2025 at 08:58:28AM +0800, Ming Lei wrote:
> > Coming back to this after looking through the next patches.
> > 
> > Why do we even need the __elevator_change call here?  We've not
> > actually disabled the elevator, and we prevent other callers
> > from changing it.
> > 
> > As you pass in the force argument this now always calls
> > elevator_switch and thus blk_mq_init_sched.  But why?
> 
> sched tags is built over hctx and depends on ->nr_hw_queues,
> when nr_hw_queues is changed, sched tags has to be rebuilt.

Can you add a comment explaining this?

