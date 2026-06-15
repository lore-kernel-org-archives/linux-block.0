Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D6730F55F
	for <linux-block@vger.kernel.org>; Mon, 15 Jun 2026 13:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781530553; cv=none; b=rcvIWnJSu9ryeW5Ra1JbdNvSIhWBem/DaxnYx9ZtyuYsGpJNHjJX8SwvII99+nfUVYWTy8QT8IIg8iH22Amk2XUmmOGWAjOysezq8jngtUheaL+g1FV9QdynEH+lWvFWNorljO7bHfSncoIh318ZjGzEa4KU6AOc2jjdXjDuhqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781530553; c=relaxed/simple;
	bh=exDgtL21SW+pXLoaCdU+8BfwjjJNAu/It+SXZHwnDoI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mVvLSLs/zqZC64S/3L5sjeBdeYQ1YobN+QVzJ4rMY5LjwTNE4uDfF3Drubi5TIadrLm9glk9cJfhsczipZNQn+zXmnZgbNepLn+huLRgCnvUSbQhg8HTq6dQPMB5iPqK+V9uFNCwC5azFmqoCjpRAi5ze3fVG9y7MZdeuhpqGpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3A8AE68AFE; Mon, 15 Jun 2026 15:35:49 +0200 (CEST)
Date: Mon, 15 Jun 2026 15:35:49 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, axboe@kernel.dk,
	Keith Busch <kbusch@kernel.org>, Carlos Maiolino <cem@kernel.org>
Subject: Re: [PATCH] block: check bio split for unaligned bvec
Message-ID: <20260615133549.GC26132@lst.de>
References: <20260612223205.465913-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260612223205.465913-1-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Jun 12, 2026 at 03:32:04PM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> Offsets and lengths need to be validated against the dma alignment. This
> check was skipped for sufficiently a small bio with a single bvec, which
> may allow an invalid request dispatched to the driver. Force the
> validation for an unaligned bvec by forcing the bio split path that
> handles this condition.

This fix itself looks good, but we'll also need something similar
for bio-based drivers that never call into the splitting helper.

