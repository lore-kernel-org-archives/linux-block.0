Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4366168BD;
	Mon,  4 May 2026 04:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777869861; cv=none; b=HOPZdEhlTz7xAHs/T/HYeGqXlQVub1Zvt41pBNTdmQuPHsu2d7AMKeiPZssoI/KG/twXMLVg0/Auw4Fs98H3O7HXBB+xXcr+zNlUYIjZ+mEJtnjs2WqZYZMPcBTG9YCDkL0JddS5IBaFuFbrfRyX1dN5hFuxydmUsk1xWw0Kn5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777869861; c=relaxed/simple;
	bh=WgdMtm8snSXiXjZbw4RKtd8xmEOVgpkx/K7f4EFgSIo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gvt432EHOEabJ2Rg8/sTKBM6Y0Sikmh51y0hESBwbOfhrThkKgwPU15Ff79MbReEwWEL2WypO2AYDYPkOD63oq8QG6m6dOpmSaxGAzSR9msLzY0+ni8ojwODZWrcwtxMLUA2ALhY+QfKxL713WGTj3IeXtXghiYBbYxkAmaF4Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id DDCE168AFE; Mon,  4 May 2026 06:44:15 +0200 (CEST)
Date: Mon, 4 May 2026 06:44:15 +0200
From: Christoph Hellwig <hch@lst.de>
To: Carlos Llamas <cmllamas@google.com>
Cc: Bart Van Assche <bvanassche@acm.org>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Chaitanya Kulkarni <kch@nvidia.com>, kernel-team@android.com,
	linux-kernel@vger.kernel.org,
	"open list:BLOCK LAYER" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] block: restore mempool reserves for non-block
Message-ID: <20260504044415.GA9077@lst.de>
References: <20260503001734.858296-1-cmllamas@google.com> <d8a4d967-ca1b-421c-a452-d440df9535f2@acm.org> <afdjYQ1szt_ovq_k@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afdjYQ1szt_ovq_k@google.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Sun, May 03, 2026 at 03:01:53PM +0000, Carlos Llamas wrote:
> On Sun, May 03, 2026 at 06:26:48AM +0200, Bart Van Assche wrote:
> > On 5/3/26 2:17 AM, Carlos Llamas wrote:
> > > Fixes: b520c4eef83d ("block: split bio_alloc_bioset more clearly into a fast and slowpath")
> > 
> > Hi Carlos,
> > 
> > Please help with verifying whether this patch series is sufficient:
> > Christoph Hellwig, fix /dev/sg allocation failures register, April 15.
> > This patch series can be found by searching for "b520c4eef83d" on
> > lore.kernel.org.
> 
> Hey Bart,
> 
> I did look for fixes but I totally missed commit 7b03c93d2beb ("scsi:
> sg: Don't use GFP_ATOMIC in sg_start_req()") from mkp tree. Sorry, this
> patch definitely fixes the issue I'm facing. Thanks!

Also b5129bda5bbc ("block: only restrict bio allocation gfp mask asked
to block") in the block tree.  Both of these should fix the issue
you're seeing, and both are good on their own.

