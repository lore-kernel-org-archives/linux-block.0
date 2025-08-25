Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050C32DFA27
	for <linux-block@vger.kernel.org>; Mon, 25 Aug 2025 13:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756129765; cv=none; b=XsDndYMAL7lq2VPaAyWP7r3u2UpWTq7WzfnWiAY5N/UO7wPLDtzZRlj/rFbGWW9twyD9C97LI1b21oM06gn+hV3lP+V+GFCxz3E6p0TYjpHzzw8ly3Y2xM+KZzFTDzczLSjSe6/HTPbNsPq79dxTfHTWGaQF0ucjhpdvCLZMfPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756129765; c=relaxed/simple;
	bh=xvihwrp/pRyz3ZXXFiXJBH9fwLmQSvpHmuqrOxh7tic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bxVSQNsdNkq1cHab9gp6Albjo56LrR0hiexEDz+U2AEOaCjiwmzTWtINzBgs7INPg4e/0g/EA8GasdP6IcSnslM843tvq/3Q9I0FXJc3X88xartmnfx1DfF/BJOhZdiKAPZd8Hl7FYU3u9P+mvYdPw/bjTrAOMIrfbdPnQEB3Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=I8Zxl3Ac; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="I8Zxl3Ac"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Qxpdd7vSHWAWUcYcWrm3MJxf6eR+loQRCQUNdueFNek=; b=I8Zxl3AcU5+mQkAyzwqT6jM/1z
	aPY6bEjgGFo6cnczecSZVjpbH4kLbnWjEMa76c5nZIVuvr46dJXAgheDD0KXucXylIPflBhGaD6ht
	QdqHRbhLBRfW83dSUeVXEOQ2/+5EFuD6jmLkJw1r2mKILkYViYP1XI7b5fNGnN5tWhIM3bhpnrbEE
	r62LeNqGwySHqp+YXozEEe0NKSmx36Hd0KkFQXwB0wTEpLhZ33QPNnMDuZkMLFtNn7vxg3Xup7oj8
	Naw/ea0tZmwDaiDKWdeP5qWsnkLfHMHYkTyMsGx3loJ87hQn+j6cGa46GJOLvylGqYtJQ7uKr3Tpt
	zpi7sgkw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqXZb-000000088zb-2BlD;
	Mon, 25 Aug 2025 13:49:23 +0000
Date: Mon, 25 Aug 2025 06:49:23 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, hch@lst.de,
	axboe@kernel.dk, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv3 2/2] nvme: remove virtual boundary for sgl capable
 devices
Message-ID: <aKxp49SdTknkO1fb@infradead.org>
References: <20250821204420.2267923-1-kbusch@meta.com>
 <20250821204420.2267923-3-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250821204420.2267923-3-kbusch@meta.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Aug 21, 2025 at 01:44:20PM -0700, Keith Busch wrote:
> +	/*
> +	 * The virtual boundary mask is not necessary for PCI controllers that
> +	 * support SGL for DMA. It's only necessary when using PRP. Admin
> +	 * queues only support PRP, and fabrics drivers currently don't report
> +	 * what boundaries they require, so set the virtual boundary for
> +	 * either.
> +	 */
> +	if (!nvme_ctrl_sgl_supported(ctrl) || admin ||
> +	    ctrl->ops->flags & NVME_F_FABRICS)
> +		lim->virt_boundary_mask = NVME_CTRL_PAGE_SIZE - 1;

Fabrics itself never needs the virt boundary.  And for TCP which is a
software only transport I think we can just do away with it.  For
FC I suspect we can do away with it as well, as all the FC HBA support
proper SGLs.  For RDMA the standard MR methods do require the virtual
boundary, but somewhat recent Mellanox / Nvidia hardware does not.

No need for you to update all these, but I think having the transport
advertise the capability is probably better than a bunch of random
conditions in the core code.

