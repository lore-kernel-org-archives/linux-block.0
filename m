Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97789377018
	for <linux-block@vger.kernel.org>; Mon, 13 Jul 2026 09:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783934873; cv=none; b=JsEuMtojIe7BIjOXcnFLYVNZv/43kUY9K7Qnr3N4H1Ac32n9lgPhbmzI9fs1FOBwaWFmDzACLhqWDbpnKEQe3be+4DHYO3Yrrb3/7W76wEidy4+f4gZ0GHq9TWY2e3MYo/GXRH5B6eOMbpM/CZ+z0TkZT2RdLothiaFv14JFL5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783934873; c=relaxed/simple;
	bh=h2JAwaEBgIpJZQpeBku2YQgXQDj0kLykY1rAOjf74Zk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KW7LJw+tz5svVDFT65jCV2vPaZN+dQ0JWBDaVOOjyuAgnrJeodEtRaUZfpV45U/xrjbghvlsTP5PMS/8NpMmcipJ1WVTIyJubFsBbQtGRyKR+E3S4qRTy+qrDimoUXF7ch4QPQCn+4tCRIS0mfWx5S/dvHvMJLWTNKlqSqBTkEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1CA6968BFE; Mon, 13 Jul 2026 11:27:48 +0200 (CEST)
Date: Mon, 13 Jul 2026 11:27:47 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Sven-Hendrik Haase <svenstaro@archlinux.org>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	regressions@lists.linux.dev, linux-block@vger.kernel.org,
	Li Chen <me@linux.beauty>, Joseph Qi <joseph.qi@linux.alibaba.com>
Subject: Re: [REGRESSION] commit b520c4eef83d ("block: split
 bio_alloc_bioset more clearly into a fast and slowpath") causes
 fsync to fail with pmem
Message-ID: <20260713092747.GB8112@lst.de>
References: <8a2b1abf-3c8a-4242-82c5-fba9943cf8f4@archlinux.org> <alE3PqhMQ63lBcWe@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alE3PqhMQ63lBcWe@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Jul 10, 2026 at 12:17:34PM -0600, Keith Busch wrote:
> On Fri, Jul 10, 2026 at 08:07:32PM +0200, Sven-Hendrik Haase wrote:
> > I noticed that starting with Linux 7.1, my pmem volumes inside of QEMU
> > stopped working. My use case is this:
> > 
> > qemu-system-x86_64 ... tons of QEMU flags ...
> > -object memory-backend-file,id=pmem0,share=on,merge=on,discard-data=on,mem-path=/path/pmem0.pmem,size=100G
> > -device virtio-pmem-pci,memdev=pmem0,id=nv0
> > 
> > This used to work but inside the VM I'd get this when running mkfs.ext4
> > /dev/pmem0 with guest kernel 7.1.3:
> 
> This pending fix (which is the same as what you proposed here) should
> take care of it:
> 
> https://lore.kernel.org/linux-block/20260709020145.4011533-1-joseph.qi@linux.alibaba.com/

Note that it can stil fail with that alone.  The real fix is this:

https://lore.kernel.org/all/20260709124455.1547912-1-joseph.qi@linux.alibaba.com/
