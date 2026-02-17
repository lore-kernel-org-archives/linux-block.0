Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52FBB1C4A20
	for <linux-block@vger.kernel.org>; Tue, 17 Feb 2026 06:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771308394; cv=none; b=FWdKLbB4QgFjPBm/gYPXJb7kcnXb6Lw/N3p8QWq2BrBJqd42+xePaz2pHgIPpzYe+gdcREZmmqJDYERmWLiLONzEpnsKWWSHdtRxUAczweqvfy6F8tVvK4IKTp3jqSijWb9+n8H6RDwEFs5bAKR9DiWeKBUEwAXYAnUgx6Xm6NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771308394; c=relaxed/simple;
	bh=x53vtEFraYDdGlZuAC/TRr2FZBRvzTQJAylzq8aveUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lS2eSN+zNiMDq6Hn9Tozm90hPD9dEVkSJfLuiQEB4G6nQo9otJ9a+3U+MWwM4q6TDgzuyyhQTqDNLRs8jmuDVwLwpon3kBLzdz1HEJFZviQRyzyFqEGSBaaeOjoJUwWysaWGlVJQfZFCUS1I+pGiZ/4dn/tQ98Jrs78J5kOg8rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5FC8468C7B; Tue, 17 Feb 2026 07:06:31 +0100 (CET)
Date: Tue, 17 Feb 2026 07:06:31 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] block: fix folio leak in bio_iov_iter_bounce_read()
Message-ID: <20260217060631.GB6232@lst.de>
References: <ed27f009-4607-47f4-9d72-ccfc1b1e5de3@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed27f009-4607-47f4-9d72-ccfc1b1e5de3@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Feb 12, 2026 at 04:10:09AM -0700, Jens Axboe wrote:
> If iov_iter_extract_bvecs() returns an error or zero bytes extracted,
> then the folio allocated is leaked on return. Ensure it's put before
> returning.
> 
> Fixes: 8dd5e7c75d7b ("block: add helpers to bounce buffer an iov_iter into bios")
> Signed-off-by: Jens Axboe <axboe@kernel.dk>


Looks good, thanks:

Reviewed-by: Christoph Hellwig <hch@lst.de>
