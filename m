Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84FB720FA96
	for <linux-block@vger.kernel.org>; Fri,  9 May 2025 14:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746801183; cv=none; b=X+RZIzxkAeCwj5lafNfa85l9lN1iNOpi4BKHth6fwP56FQ2pkWQFNK5IYtLQsC82vwdhgVek/7T/wbdR4UwaHhrrXgsTVsT25OUVchpW53TxiTx4G3g89nnPLr2VD3oZuSlvDJd5THwotOhQd4T4hiOONL4lXSjXCIN3Vbo7w5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746801183; c=relaxed/simple;
	bh=tuvdgIcQewKEDTQoLF8MaVq24PYwXl4eqbqK8W084lk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M475xYwlTKNGg0DM3icZ5FMsDmMDBlXXDQw2rRMedJUb54BqSnYAfeQi8A/BeWCjgN0hjhobVtZJbMC3Mhm+g3RLcj383vRpkMUtdu/XZ6/nAHdkYMKkOE1fI6zf3ksLoyIw9Zja3bkOIi0615sK10AP7qHzSZJN5py7ci132f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Emf1Ho2W; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Emf1Ho2W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92E6DC4CEE4;
	Fri,  9 May 2025 14:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746801183;
	bh=tuvdgIcQewKEDTQoLF8MaVq24PYwXl4eqbqK8W084lk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Emf1Ho2WRcu63KGXGN2dhX0LV/ugRrkUCjQuvG7lNqC/BwH8YW5d22HRS/XvTPHgF
	 WN4yb/dQBmnZjvQ+RpkTFN6pColU15lukV+0fYz/pRTCa+NNP518eA0p7U/VqntTLz
	 x3xkMRqNEGLhWvvl9gJPJ3iXT7NuiYXFYMnboBtwfE5UPfypTN0iUvwhnV0raMsDaI
	 KQLO058LQ/MZyv7kbXWTZH9WcbZpcjLx6Zqum9jWt7JMTSKFtYuEw8ynwZAZYXiFh0
	 KBtFbN4mGJXZfgeBz7aTLOpZ9nGR3fklVLQwS0WMekqGi2DW3aEU0fwyDHv2jjF/jW
	 BqQpvsoIIsrwQ==
Date: Fri, 9 May 2025 08:33:00 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, axboe@kernel.dk,
	linux-block@vger.kernel.org, martin.petersen@oracle.com,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] block: always allocate integrity buffer when required
Message-ID: <aB4SHKuSiuewRltB@kbusch-mbp>
References: <20250508175814.1176459-1-kbusch@meta.com>
 <20250509041949.GA28563@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250509041949.GA28563@lst.de>

On Fri, May 09, 2025 at 06:19:49AM +0200, Christoph Hellwig wrote:
> On Thu, May 08, 2025 at 10:58:14AM -0700, Keith Busch wrote:
> > Add a new blk_integrity flag to indicate if the disk format requires an
> > integrity buffer. When this flag is set, provide an unchecked buffer if
> > the sysfs attributes disabled verify or generation. This fixes the
> > following nvme warning:
> 
> Do we even need the flag?  I think we could just deduce it from
> tag_size < tuple_size, which feels more robust.

It looks like tag_size just refers to the space for the "application
tag", which can vary depending on if ref_tag is used or not. But it's
always going to be smaller than the tuple size.

I think you mean 'if tuple_size == sizeof(struct {t10|crc64}_pi_tuple)',
depending on which csum type is used. I introduced a new flag because I
thought that gen/strip property was just an arbitrary decision that NVMe
made for PRACT, but if it's a universal thing, then we can totally use
that. 
