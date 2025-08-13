Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A067286D50
	for <linux-block@vger.kernel.org>; Wed, 13 Aug 2025 15:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755100508; cv=none; b=Ab0CJ6rsdVHLm0KDOZMhprHDuD3pZD5sGf4OxMw+ub4gq0XVMmUUBYwfYTQJldqyC3emxaH43BkiERiVbDuXry19to3zTjiL+L6VTyyRz/yWvrNjGkZRsSaiNVzJAgQFFymVcMfgAQww3TjJrqW0uKLlV7jRZH+9YoVoMMOPFCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755100508; c=relaxed/simple;
	bh=Q6HugQdWAMHeIrnmDl+pmUGJJsToydBpKBzsrH2ph+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GmmiYbc73aOhUsS3VH1PEL5EmdOlGc6T1v/SdUDDpekeyWLTh5Ec2hpd25HwDSSGZeSSQek+P53xVlNDGlmMEhTVm+8cBuuYR/A8Nz6d4IbhfVX/kiaxiMB3XqkQ9g1c+PGqsNiYMBzIJgz2JafzGdc5w6y3XwATaCkOuFcEc7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 996C0227AA8; Wed, 13 Aug 2025 17:55:00 +0200 (CEST)
Date: Wed, 13 Aug 2025 17:55:00 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, hch@lst.de,
	axboe@kernel.dk, joshi.k@samsung.com,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv7 6/9] blk-mq-dma: add scatter-less integrity data DMA
 mapping
Message-ID: <20250813155500.GD14188@lst.de>
References: <20250813153153.3260897-1-kbusch@meta.com> <20250813153153.3260897-7-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813153153.3260897-7-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

I got two copies of this which both look the same.

.. and good, so:

Reviewed-by: Christoph Hellwig <hch@lst.de>

