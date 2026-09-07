Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D79A35C6BF;
	Mon,  7 Sep 2026 06:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788761763; cv=none; b=Ve1N8QvEdCtUWGMneDHZ2IExHq9zlYqWYh98Srt/PQ7JhwcaokiLmTGf9pp+/ohdhhD0LQNOZORY+0LtwQHfCFS05MPSkvV+vGNwvbXrhTrO99xOBeeVwbKS1W0CwTm7d/iKmJODnwfWFf13MsRkaDDroQGLpBS5Jfg1nBqWuv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788761763; c=relaxed/simple;
	bh=yu88Tds1MaooZqgeVAPVnYqAiKKKAQJ5o7zffmb+lKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hQbyh2VI6J59cLMkuCXVghe+4mRB/3p/c8RXFqGhvpi3+wiechZeedTH/rFdmMykTF9Zp9uCQviv5oWqGcVNqCibtnfjAXqXgn8iX2zlS5EJtQuh5co95IhE0O44IR2m8PrtWMnhURsPUabz98OkSmwelEwGvHRm4JLoFf3Mkeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id D3F5F68D05; Mon,  7 Sep 2026 08:15:57 +0200 (CEST)
Date: Mon, 7 Sep 2026 08:15:57 +0200
From: Christoph Hellwig <hch@lst.de>
To: David Howells <dhowells@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>, Hannes Reinecke <hare@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Paulo Alcantara <pc@manguebit.org>, netfs@lists.linux.dev,
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] block: Fix start and length check added to
 iov_iter_extract_bvecs()
Message-ID: <20260907061557.GA32231@lst.de>
References: <20260902112743.GA11999@lst.de> <1819786.1787768317@warthog.procyon.org.uk> <1895550.1787777192@warthog.procyon.org.uk> <350212.1788514937@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <350212.1788514937@warthog.procyon.org.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Sep 04, 2026 at 10:42:17AM +0100, David Howells wrote:
> Christoph Hellwig <hch@lst.de> wrote:
> 
> > Should this grow a comment explaining why for non-iov/kvec/ubuf
> > we check the alignment of every sector instead of just the
> > start alignment?
> 
> There should possibly be a comment explaining the need for an address
> alignment at all.

Sure.

