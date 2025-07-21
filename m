Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A70C1F4261
	for <linux-block@vger.kernel.org>; Mon, 21 Jul 2025 06:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753077703; cv=none; b=mDFq0vq9G0a1kUUfsJRSCwpEJSI4NG3C/Ezgpan6WI5qybhayn84Af28pVW0De2IMQ2KUrWTUPjQK9Sl8ZJl/nIs3qQMasyyE+JQmoSLdpMtuPmCuSpaotn/Mnf+ycZg939vuOumKm9LMGzNNNTJWt0hUvnOMNj1TyLSICLU4J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753077703; c=relaxed/simple;
	bh=wmtrc9c/KPUFsCgMq3Z+MVZR1zWZn9rYyI2J+E7QjCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IQNX47iAxsjngfqzIsWSBiyq8qdWgSKFtJ9VbfysnvODUIJt9WkTp1EUUvIe43tOzYnYR2WY0YshrvfD3245M2+V7oH1qNmEwgbOFKA0B/2g/xVF7bzpzdmJh2yFyWiTUW/HktkRGCON2YXINdCQve/OSRYT9ORMVtFGuk0UKs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 02AC868D0E; Mon, 21 Jul 2025 08:01:25 +0200 (CEST)
Date: Mon, 21 Jul 2025 08:01:24 +0200
From: Christoph Hellwig <hch@lst.de>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Bart Van Assche <bvanassche@acm.org>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH v3 0/7] Fix bio splitting by the crypto fallback code
Message-ID: <20250721060124.GA28434@lst.de>
References: <20250715201057.1176740-1-bvanassche@acm.org> <20250715214456.GA765749@google.com> <20250717044342.GA26995@lst.de> <3d6e8317-7697-4bb4-8462-c67b5e6683b4@acm.org> <20250718165024.GD1574@quark>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250718165024.GD1574@quark>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Jul 18, 2025 at 09:50:24AM -0700, Eric Biggers wrote:
> But, as suggested at
> https://lore.kernel.org/linux-block/20250717044342.GA26995@lst.de/ it
> should also be okay to reorganize things so that the regular
> submit_bio() does not support the fallback, and upper layers have to
> call a different function blk_crypto_fallback_submit_bio() if they want
> the fallback.  I don't think that would help with the splitting issue
> directly,

It actually does.  Splitting before submit_bio will automatically
get the ordering right.  It is something done by a lot of file systems
already and trivially done.

> but perhaps we could make the filesystems just not submit bios
> that would need splitting by blk-crypto-fallback, which would solve the
> issue.

I think that distinction is a bit fuzzy.  When stacking the blk-crypto
fallback helpers above submit_bio, the split is formally done by the
file systems, just using generic library helpers.  As modern file systems
usually build bios to the full possibly size and then split them based
on limits I suspect that scheme is also the best here, but there might
be exceptions where just looking at the limits and not building the
bio bigger might be suitable, but I suspect they'd be the unusual
case.

