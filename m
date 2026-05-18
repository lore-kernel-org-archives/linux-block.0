Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13FE544D693;
	Mon, 18 May 2026 12:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779108674; cv=none; b=PdOHuoL3yhLcA2typb8PUNsHE73WV4ATwiLvYUE1cHT2BYmI3E2brZeB0ulB8EhfLNKhCo0yp5F7kBB9z8DZ6/sdi9hes6GTLFqoDEsGrElDJ9BchAzIX3/cTNyVYX3NaPHr3shdV5xXfKH3ID2atbE2829bmvTQFShz0YnxQy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779108674; c=relaxed/simple;
	bh=KHYdDA1sZFnnFjf0sMPyWJr+Xnebj/oK20Vp8ALhK3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N7tSA2dT1n5v9my36+hXkctPaBeuMGR9QVgusi8Pr1kDTSWW5cslmksFGApYkXrT8yKNKg7j99oNKm56dFIOcZDkRonYA1ZF0Q6cHXhvmkJnj2Cq3rbAgBqzMQQ52SliLD+pCJr2ABwD28gbwEQd7ahkjfSTQZxI6W9A3sEpGU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id BB2A368D05; Mon, 18 May 2026 14:51:09 +0200 (CEST)
Date: Mon, 18 May 2026 14:51:09 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jan Kara <jack@suse.cz>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 2/2] block: don't set BIO_QUIET for BLK_STS_AGAIN
Message-ID: <20260518125109.GA5286@lst.de>
References: <20260518063336.507369-1-hch@lst.de> <20260518063336.507369-3-hch@lst.de> <4j3y4zm2vsbyxlpmyktz4g3sbfwucw64h7p5t3hos3bvtinax4@j5dj3aeahnwa>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4j3y4zm2vsbyxlpmyktz4g3sbfwucw64h7p5t3hos3bvtinax4@j5dj3aeahnwa>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, May 18, 2026 at 02:34:49PM +0200, Jan Kara wrote:
> > Commit abb30460bda2 ("block: mark bio_wouldblock_error() bio with
> > BIO_QUIET") added this to suppress buffer_head warnings, but neither
> > when this commit was added nor now any buffer_head using code actually
> > ever sets REQ_NOWAIT which can lead to BLK_STS_AGAIN.
> > 
> > Remove the special handling for now.  If we ever plan to use REQ_NOWAIT
> > for buffer_head based I/O we're better off handling BLK_STS_AGAIN in
> > the completion handler as it actually needs to retry the I/O as well.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> So I agree about the bh argument but bio_wouldblock_error() is not specific
> to bh path in any way, is it? So do we expect all bi_end_io handlers to
> check for BLK_STS_AGAIN and avoid complaining to logs in case of that? Not
> that all of them would be currently checking for BIO_QUIET either so I'm
> mostly trying to figure out what's the expected handling.

File system would need special handling for BLK_STS_AGAIN were we to wire
it up again (in upstream we have the dead direct-io code removed in
patch 1, and an incorrect use in iomap polled I/O I sent a separate patch
for), because simply bubbling it up as -EAGAIN will generally do the
wrong thing.  We ran into file system corruption last time we did it due
to non-idempotency of writes and general locking issues with just
retrying at a higher level.

Thus the rough consensus was that If we want to support fs-issued
REQ_NOWAIT I/O we'd first need to add infrastructure to retry them from
a blocking context at the bio-level, preferably in the block layer
itself.
