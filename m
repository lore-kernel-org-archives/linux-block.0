Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740B41A683E;
	Fri, 10 Jul 2026 18:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783707457; cv=none; b=sJlUQlfQbb9UeGbwHO1mHisRebeTKIDB+adkAL0k8lClf263sm/nMNTAA5Mg6N9Bla8exC5xqI2CMiy3UN0792QdN1nHjEatxaSYWS1AI3AOr3LOtxzvYRzN2QnskpG27Pc2xVAuFgKszs26N0TUBUXcIeiYTTtoh9vmV3gpdjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783707457; c=relaxed/simple;
	bh=sx7gFUKtfOD5Ttm812W6ZdPoqnH2oaF9HersW7hSei4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dvbp7ajwwiP+vVGJi0qtZjyF4dVdqBZQ+x9Va9QiU6Y3cVALv1R+WwUDYseHfWSUwKK7dlC5FRgmoYl39NDxGJsWcnEQu5phFRTvTAHTI6mXXBXxwVoJSvJWmQA4tGwQd0Rv42tn8Zq7Y5xN6ISJnOLmhJJmPv8hcmJGvmuv1/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PhkZTYtQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PhkZTYtQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1B251F000E9;
	Fri, 10 Jul 2026 18:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783707456;
	bh=GVnzlpUO+akBvRIWjCH5ZIROCSlVX/MmD2hDWlbQfd8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PhkZTYtQQODdwhmeZRn2ddRIxfbN2Kb4U0z46IwptC88+417/1Tu7g4oOPa87/snC
	 PinHXcgV2TO+GtcVk7Rg2sQftS1rVvcGyzcr7U6w6O2k7DoPhbFM3aX/Lmy9oynQbA
	 tue5D43jIsg9dOLPDEwy1IXBnvbbkDvWtAzIcYSSYHjvYSFsYyRN3dgC3MAI6NSveX
	 YQ0lhDIZhwesYJZw4mWpU5qWBxsapSn1+YUdmGB8xU4CzZEoP09NkidYixyAUp2bv8
	 SPZX3OcmiQZ/OB+scTWT1+0PENuAhB9v9W8jzdyXOXjzS12zagkeIKrQYVnq51349R
	 mWGPNgX4iruiA==
Date: Fri, 10 Jul 2026 12:17:34 -0600
From: Keith Busch <kbusch@kernel.org>
To: Sven-Hendrik Haase <svenstaro@archlinux.org>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	regressions@lists.linux.dev, linux-block@vger.kernel.org,
	Li Chen <me@linux.beauty>, Joseph Qi <joseph.qi@linux.alibaba.com>
Subject: Re: [REGRESSION] commit b520c4eef83d ("block: split bio_alloc_bioset
 more clearly into a fast and slowpath") causes fsync to fail with pmem
Message-ID: <alE3PqhMQ63lBcWe@kbusch-mbp>
References: <8a2b1abf-3c8a-4242-82c5-fba9943cf8f4@archlinux.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a2b1abf-3c8a-4242-82c5-fba9943cf8f4@archlinux.org>

On Fri, Jul 10, 2026 at 08:07:32PM +0200, Sven-Hendrik Haase wrote:
> I noticed that starting with Linux 7.1, my pmem volumes inside of QEMU
> stopped working. My use case is this:
> 
> qemu-system-x86_64 ... tons of QEMU flags ...
> -object memory-backend-file,id=pmem0,share=on,merge=on,discard-data=on,mem-path=/path/pmem0.pmem,size=100G
> -device virtio-pmem-pci,memdev=pmem0,id=nv0
> 
> This used to work but inside the VM I'd get this when running mkfs.ext4
> /dev/pmem0 with guest kernel 7.1.3:

This pending fix (which is the same as what you proposed here) should
take care of it:

https://lore.kernel.org/linux-block/20260709020145.4011533-1-joseph.qi@linux.alibaba.com/
