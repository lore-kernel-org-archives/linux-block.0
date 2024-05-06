Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C7448CCD
	for <linux-block@vger.kernel.org>; Mon,  6 May 2024 06:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714975518; cv=none; b=XANHKmOej2hO5N9avommUn/TKv3YFQBiP4PZuHthjJEd9BvJth2F/5utuz8fZ5A0P+1cBRNayfXtpAe/AgtkTtxLof025ntpQgdg8EOTGjFr5NxdoU2ueid3171W4eZ5qKNVDyT8d/u0gW0wpw68wBXn16OLXR2gJcozr4KXfSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714975518; c=relaxed/simple;
	bh=N3pWe94OvSgIhXH06V+jpz1V7E2/EVJQGIHDLNjkRg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qFDS4boEAZ4M1c6KXK0kRrHQKN+C9El/gvni6WawXyf/RA40c/Cw++6xAU+q5C0y+T1hKKZ2dweOa8RbzD8CtrV9A4+gYYXquIyOO0fYIzCAoJJGNT3deycoxHPVRSFIikGHt98Nl5/k2U374ipcxLMPP6rFWX0SfFSbYThIMyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5D7C468AFE; Mon,  6 May 2024 08:05:10 +0200 (CEST)
Date: Mon, 6 May 2024 08:05:09 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: kbusch@kernel.org, hch@lst.de, axboe@kernel.dk,
	linux-block@vger.kernel.org, martin.petersen@oracle.com,
	anuj20.g@samsung.com
Subject: Re: [PATCH] block: streamline meta bounce buffer handling
Message-ID: <20240506060509.GA5362@lst.de>
References: <CGME20240506051751epcas5p1ed84e21495e12c7bf41e94827aa85e33@epcas5p1.samsung.com> <20240506051047.4291-1-joshi.k@samsung.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240506051047.4291-1-joshi.k@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Can we take a step back first?

Current the blk-map user buffer handling decided to either pin
the memory and use that directly or use the normal user copy helpers
through copy_page_to_iter/copy_page_from_iter.

Why do we even pin the memory here to then do an in-kernel copy instead
of doing the copy_from/to_user which is going to be a lot more efficient?

Sort of related to that is that this does driver the copy to user and
unpin from bio_integrity_free, which is a low-level routine.  It really
should be driven from the highlevel blk-map code that is the I/O
submitter, just like the data side.  Shoe-horning uaccess into the
low-level block layer plumbing is just going to get us into trouble.

