Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7255B3AC1C
	for <linux-block@vger.kernel.org>; Wed,  6 Aug 2025 14:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754492122; cv=none; b=XAw6/0AQu3zSg9SSkZx3lnOXPmaFO/FWSUIDto+zAl29yVKAlK8gcsfuxc6HR8ykel5JsAblR2lrmMrjCWRy86NjWbVibqn8jlBeO13f8KV6PemTnBPEgFA3immDc9NQn6W1HMjELZyCahkVp6DDrHmg+MhoUhERnpyYeWQsFHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754492122; c=relaxed/simple;
	bh=w8Hic1BQYnJYZh2MbUeyv3MRpwxuIV+91vCSGl3C/ms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K6/MOLHzFJJQDYZMUoOT3N1U8e8RySXkscLcktdlEdYmDKm3iquZ6O+SrLerN7JYwpKo7l13UD6j0Kh0cWlHtNaQHYJyv99jFaZw8XJE3JOnLp7dFt4Ya2Qw23Wv8qKhj/238szUU5a81lLy6uYsBn+uKCKwJ8FHOSrMhjVnMfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5F97D68B05; Wed,  6 Aug 2025 16:55:14 +0200 (CEST)
Date: Wed, 6 Aug 2025 16:55:14 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, hch@lst.de,
	axboe@kernel.dk, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 2/2] nvme: remove virtual boundary for sgl capable
 devices
Message-ID: <20250806145514.GB20102@lst.de>
References: <20250805195608.2379107-1-kbusch@meta.com> <20250805195608.2379107-2-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250805195608.2379107-2-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Aug 05, 2025 at 12:56:08PM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> The nvme virtual boundary is only for the PRP format. Devices that can
> use the SGL format don't need it for IO queues. Drop reporting it for
> such PCIe devices; fabrics target will continue to use the limit.

That's not quite true any more as of 6.17.  We now also rely it for
efficiently mapping multiple segments into a single IOMMU mapping.
So by not enforcing it for IOMMU mode.  In many cases we're better
off splitting I/O rather forcing a non-optimized IOMMU mapping.

