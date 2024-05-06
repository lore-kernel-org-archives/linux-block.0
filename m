Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C388F66
	for <linux-block@vger.kernel.org>; Mon,  6 May 2024 14:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715007377; cv=none; b=pUZOmU6KhbWryE4kY3SQu8FLTkZiv979DWifPggQBDrVNsM7wl0BIw9//pDCpCaSYa8ryBqxOijRj8gtV0DtIW6zAkvVT585d8xlgRqpRJm+ApKNaSGGMfcavhXQwoNcnULAAjOG4+WRc44u7GFCuwP8T4cZTj92CMT5zfrClic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715007377; c=relaxed/simple;
	bh=LzgyJWJQSdOasgg8VggsJqIvtptkqm8IIbxVM4gHj8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yfxl24Y7GsMCaiz0LTy6kAaSc7csNEvo9W0+dNZTulxBwaJ2DMYH39Nsr8yDoaXE2aRTcHzxe7ShP0ZCsacoTljDZDRqwOG6eOw2UAMN8nhNFnQRQizgzOTNFGlsShcKNnPTTxyE71ggrehoGyPTvbS8piH1v3qMq3atMxuKsPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id C2DEE227A87; Mon,  6 May 2024 16:56:09 +0200 (CEST)
Date: Mon, 6 May 2024 16:56:09 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: Christoph Hellwig <hch@lst.de>, kbusch@kernel.org, axboe@kernel.dk,
	linux-block@vger.kernel.org, martin.petersen@oracle.com,
	anuj20.g@samsung.com
Subject: Re: [PATCH] block: streamline meta bounce buffer handling
Message-ID: <20240506145609.GA11066@lst.de>
References: <CGME20240506051751epcas5p1ed84e21495e12c7bf41e94827aa85e33@epcas5p1.samsung.com> <20240506051047.4291-1-joshi.k@samsung.com> <20240506060509.GA5362@lst.de> <9ce1c36d-67e5-b287-5faf-667844f8c2a8@samsung.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ce1c36d-67e5-b287-5faf-667844f8c2a8@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, May 06, 2024 at 06:16:45PM +0530, Kanchan Joshi wrote:
> Nvme and io_uring (Patch 2, 3, 4) get nice wins because of keeping the 
> user memory pinned even for bounce-buffer case.

In that case the data path should be doing the same.

> > Sort of related to that is that this does driver the copy to user and
> > unpin from bio_integrity_free, which is a low-level routine.  It really
> > should be driven from the highlevel blk-map code that is the I/O
> > submitter, just like the data side.  Shoe-horning uaccess into the
> > low-level block layer plumbing is just going to get us into trouble.
> > 
> 
> Not sure I follow, but citing this nvme patch again:
> https://lore.kernel.org/linux-block/20231130215309.2923568-3-kbusch@meta.com/
> Driver does not need to know whether meta was handled by pinning or by 
> using bounce buffer. Everything is centrally handled in 
> block/bio-integrity.c.

But the low-level bio code does, and it absolutely should not.  And
while I should have caught this earlier we really need to stop undoing
all the sanity we got by clearly splitting the submitter side from
the consumer side of the bio, as that will lead us straight back
into the mess we had before.
