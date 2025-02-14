Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C97265604
	for <linux-block@vger.kernel.org>; Fri, 14 Feb 2025 14:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739542222; cv=none; b=Yl+7RL1jX04Mq+tRGPX3wvXW9eCF+9ImhJCtDCFpnI2gx3t+GcE6kh6vBkW8oGjvSj5CoR1pY6cH50GKuFzPN9XAIfCIbT/8cs4x8ykjbmca70nW5W/szLzBQLO+/MVGLecUFikbONkEPp0STzuR7UviYgwUqr/vN+ihoE610Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739542222; c=relaxed/simple;
	bh=c/lpCaxHba3a7ARHz2uaV4O7rU/2BAhBzrJDESbUhnk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UHJGiA+CeRXAP9Gqpg3UjDngz3MkS7gywWgSvHQUZ0tkHOkh1aMj7LIot/JHCFpIIBtXERSwjoCdT4PuJwOpyCf03+hWLajxe/UBKPyn3tLOIffB4c46abwBm9aqUUoJtk8KQF0y0Iu+euYDrK+azr1LGr7DIsffHQjB2SzH0t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3BDDF68D12; Fri, 14 Feb 2025 15:10:11 +0100 (CET)
Date: Fri, 14 Feb 2025 15:10:10 +0100
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Cheyenne Wills <cheyenne.wills@gmail.com>
Subject: Re: [PATCH] block: fix NULL pointer dereferenced within
 __blk_rq_map_sg
Message-ID: <20250214141010.GA24011@lst.de>
References: <20250214084638.58437-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214084638.58437-1-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Feb 14, 2025 at 04:46:38PM +0800, Ming Lei wrote:
> Discard request may use special payload only and doesn't have bio
> attached, so the request iterator has to be initialized from valid
> req->bio, otherwise NULL pointer dereferenced is triggered.

So while the code changes here look good to me, the commit message is
wrong.  discard requests always have at least one bio attached, so we're
not going to hit this condition.  Discard requests also aren't even
handled by the function in Cheyenne's report.  I'm pretty sure this is
a flush request, as these are the only non-passthrough requests without
a bio.

> +	/* discard request may not have bio attached */
> +	if (iter.bio)
> +		iter.iter = iter.bio->bi_iter;

Same for the comment.

