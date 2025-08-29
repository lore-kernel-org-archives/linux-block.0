Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BED7322A2B
	for <linux-block@vger.kernel.org>; Fri, 29 Aug 2025 15:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756480553; cv=none; b=A9rpMyBuGT3mUFCFeL1NuNaPRUeGdvud593mS8P2oytU9bJHtQYdon/+rJcFFyRBVCLZi81Flr7z6+V5rh7kmj7O0muShIGY5ZMidJe+sUpRvsEIpYMKKv/JOL7eCt/Z9sIT9S9atWeB2r14MCgh7m9B2RA0JYP5yFDm0Mc08qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756480553; c=relaxed/simple;
	bh=FiZTvYPqfy/ZXNRGXoa0o6dikFbQzgwUvUBZHilwNMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a70rt0f1R01C/dJpGwdHz2Mwar+qU/1LUmyLcG0kcUY60oWoI7Dg2o1aoXAHiCP9CT/kUmU3exT1PsRe46qCUqh9YB61b8xtVbnVQSTSHfNVAZ8mu2V7E01Ci+4QFN6j/33ugADvV6z3nLNwULzFTvV1IwAu1eFbItG7q5jcJg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=md9cTswi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="md9cTswi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A87DC4CEF5;
	Fri, 29 Aug 2025 15:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756480552;
	bh=FiZTvYPqfy/ZXNRGXoa0o6dikFbQzgwUvUBZHilwNMA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=md9cTswiy6PRypiND6T0l12sixzuUzFi0BG18QCP9JWx2nNv1ocjVcmh7rbMtrP2P
	 topm6lqplZxnY8HpwIJkyMTBsMuFD6vZQKNElXGsBUBR4Lybb6nHZ/Li4IWUDh+nLy
	 7pZ64X0kHpxU1CNTONkV1xVZB0FDaXV+3FTGOQVHgj8nV5wQAYxbdKfe1mDHm2/3uH
	 JDfo2p4d3yC0GLl9wjMEuJ6FLoXbAPZkwcgaWQkucHvSlEMbHsca318pyiDtkte0yL
	 1yQmgTXhjHx8kYzZdVK53BR8Xve1ApdBuDwbV9vehC0iCGS0GrhotXBN6So73ok54b
	 JyXlY7pSMm0eg==
Date: Fri, 29 Aug 2025 09:15:50 -0600
From: Keith Busch <kbusch@kernel.org>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, hch@lst.de,
	axboe@kernel.dk, martin.petersen@oracle.com, jgg@nvidia.com,
	leon@kernel.org
Subject: Re: [PATCH 2/2] blk-mq-dma: bring back p2p request flags
Message-ID: <aLHEJnKgVGYdnb08@kbusch-mbp>
References: <20250829142307.3769873-1-kbusch@meta.com>
 <20250829142307.3769873-3-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829142307.3769873-3-kbusch@meta.com>

On Fri, Aug 29, 2025 at 07:23:07AM -0700, Keith Busch wrote:
> @@ -252,7 +252,7 @@ static unsigned int bvec_from_pages(struct bio_vec *bvec, struct page **pages,
>  			bytes -= next;
>  		}
>  
> -		if (is_pci_p2pdma_page(page))
> +		if (is_pci_p2pdma_page(pages[i]))
>  			*is_p2p = true;

Oh no... >_<

This part should have been folded into patch 1.
