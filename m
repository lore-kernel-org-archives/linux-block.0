Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8326719D08A
	for <linux-block@vger.kernel.org>; Thu, 31 Oct 2024 12:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730379490; cv=none; b=I/SqlcTTbw2QZjRBDFzXmypjQg+KzYe50azMq8cUAaVDSRFavuiqy4XoQ/Tr4r9/RqrG4k/UFGXNBdDD8Q30UzJ2gEv8UAAlE7l9QhCuEj8sM79/vs0nGE9rjM3hcvmwvzd02UZruR93QuMJHfpthhiIfkGtX55PuRCj3Qp0h2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730379490; c=relaxed/simple;
	bh=4bxiv1HbKVMcRgx1PcZc+iP6mPjtzdt+ckVwauwZb3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HTGr8cdWBKK2MFOIFnaW88ZHx6y0r1vNdpBeI9iC2YlNSuUfvEwKS4hThSJ0yMj8ubAVQVbXcxmhEvAjw6sq5f8s7VGtYSQNhMPZcoNtYw7/ilBurGACPgYLOTP9ukmtXjk0sf7u/t2w3WlMA6iMDymFFYKNr8DRpAZLnkZvqjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 02A0568BFE; Thu, 31 Oct 2024 13:58:01 +0100 (CET)
Date: Thu, 31 Oct 2024 13:58:01 +0100
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Klara Modin <klarasmodin@gmail.com>
Subject: Re: [PATCH] lib/iov_iter.c: initialize bi.bi_idx before iterating
 over bvec
Message-ID: <20241031125801.GB17520@lst.de>
References: <20241031110224.293343-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241031110224.293343-1-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Oct 31, 2024 at 07:02:24PM +0800, Ming Lei wrote:
> Initialize bi.bi_idx as 0 before iterating over bvec, otherwise
> garbage data can be used as ->bi_idx.
> 
> Cc: Christoph Hellwig <hch@lst.de>
> Reported-and-tested-by: Klara Modin <klarasmodin@gmail.com>
> Fixes: e4e535bff2bc ("iov_iter: don't require contiguous pages in iov_iter_extract_bvec_pages")
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  lib/iov_iter.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/lib/iov_iter.c b/lib/iov_iter.c
> index 9fc06f5fb748..c761f6db3cb4 100644
> --- a/lib/iov_iter.c
> +++ b/lib/iov_iter.c
> @@ -1699,6 +1699,7 @@ static ssize_t iov_iter_extract_bvec_pages(struct iov_iter *i,
>  		i->bvec++;
>  		skip = 0;
>  	}
> +	bi.bi_idx = 0;

Looks good, but the more future proof variant would be to
initialize bi to zero at declaration time:

	struct bvec_iter bi = { };

Either way:

Reviewed-by: Christoph Hellwig <hch@lst.de>

