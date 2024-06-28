Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE0B6F06D;
	Fri, 28 Jun 2024 06:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719554733; cv=none; b=uJ1etkcI46JUKDfPxp0sdZbsTxzyt+12vCaAA8+lHuLisxT7jN4mI+ineb/elgPrsGpi5f1nr//osFJlDX0xHSZ3/QF89u9cWIRTIq5bvd7b9OWv/E8q4aKFgufj0vjbpXvAHbRyywKqeL00YC29QkhuH2gPMY5fWxwdK8QBDhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719554733; c=relaxed/simple;
	bh=cYlytjrE/bKtc6RiMlg5OwDG5WbZdwx0IPiQq0LqYVA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AnfpIQm/yqGdzcYcvDsi2TtfOBQIB8zd4v8+6zeyNzlhMzAPzBVass81kGzrDhxo5J4or2aoPIma3sndNQt/16w5Cn5WBAL3I57bANXpXEzCDF6n4n38Df/CPQvlqeELk4CZm585KKxqrrVqX0l9RUah3diqIoBj7fMmnsZ4kF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=emtMEFI1; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="emtMEFI1"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=V+OYYj8uq+pqoK/5F3d/Osi7mEas3i3Dbm15mfp2I+A=; b=emtMEFI1Qr78cOOrca2+ypoGyg
	KVgWGdbkscOWXQAKvhuypw4hBW+gR/7BAG03/lJNaNP6l8IC6JGVy+gHnE4zWKUQMxgKbBo2M/kNY
	ZWKqAh9XiPIPsaaW8ixWGrODDM7awRkw6/GcUI4TyYSCXX/LLkQOLaFy+EVT+uCvGIW4ebDc51/2B
	pOanlmk0ZpQKvkofBk2jlkIkyFcEjK6wO9KhhTNnVUcTaQ7XpWcWhY7pOEle0JKcxOBkvEaKNVsnf
	3XBH2BIMyFK3LwjqheiidB02lu9H+GGf9kHe5/zl2g6o+drydQeJo0Rf4Im3G8t1e9NtMhg8lQYUM
	orRYf2BA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sN4ji-0000000Chag-3fH0;
	Fri, 28 Jun 2024 06:05:30 +0000
Date: Thu, 27 Jun 2024 23:05:30 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Yi Zhang <yi.zhang@redhat.com>,
	Christoph Hellwig <hch@infradead.org>, Ye Bin <yebin10@huawei.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH V2 1/1] block: check bio alignment in blk_mq_submit_bio
Message-ID: <Zn5SqkFikVt14I6J@infradead.org>
References: <20240620030631.3114026-1-ming.lei@redhat.com>
 <ZnOucQM5ic6I3iE0@infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnOucQM5ic6I3iE0@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

So make this a:

Reviewed-by: Christoph Hellwig <hch@lst.de>

so that we can get it included and the ball rolling.

On Wed, Jun 19, 2024 at 09:22:09PM -0700, Christoph Hellwig wrote:
> Module the q argument mess I'll just fix up when I get to it this
> looks fine.
> 
> 
---end quoted text---
