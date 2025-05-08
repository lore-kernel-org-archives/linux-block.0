Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F258922422D
	for <linux-block@vger.kernel.org>; Thu,  8 May 2025 16:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746721171; cv=none; b=DHF4oYMuYmMuwkTgXh7h4KxR1K5qJfBPoVWRljio0CaC4L5/Xm6JThz06Wr3emvez35AeAV7FyAesUsT+RjeE68FUHOqRnwRM8Kaq1/IOiSl/AqUDCdXb8BOGJ1m0woyPKsu9ODQ/WZv0b6aOWWr4uNjW7sRbQWu7SxMi3RYQLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746721171; c=relaxed/simple;
	bh=WHuoV/KurTZth5DOXophPA05QqgYCrDynTIvhHpWV5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gvH3/Q4/fw0bF+huZp3WK0U9wbyl3RFW2fgntKXV5WBC/ng8wIxAJObG94qAQR1KlY83jZBhZa9pIJBotr8XkAfL78cnPcjHu1LHnh9fl4sr81wAwstSubl/09lJCIr57xtxdBx+9f9lhSx/ES12r4KPi9ODI9LqbUOPLyB5BiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8066067373; Thu,  8 May 2025 18:19:23 +0200 (CEST)
Date: Thu, 8 May 2025 18:19:23 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@meta.com>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCHv2] block: always allocate integrity buffer
Message-ID: <20250508161923.GA10610@lst.de>
References: <20250507191424.2436350-1-kbusch@meta.com> <20250508051233.GA27118@lst.de> <aBzYVf3qZkzgFAgy@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBzYVf3qZkzgFAgy@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, May 08, 2025 at 10:14:13AM -0600, Keith Busch wrote:
> But since you mention it, maybe someone does want to force PRACT on the
> generic read/write path? I considered it a fallback when the kernel
> doesn't have CONFIG_BLK_DEV_INTEGRITY, but we could control it at
> runtime through these attributes too. It would just need a new flag in
> the blk_integrity profile to say if format supports controller-side
> strip/generation and use that to decide if we need to attach an
> unchecked integrity payload or not.

The generate/verify attributes always were my way to force insert/strip
behavior on both SCSI and NVMe for testing.

But yeah, I never tested the PI + other metadata features where this
might or might not work, and we really do need to fix the attribute
for those.
