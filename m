Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF02EEB1
	for <linux-block@vger.kernel.org>; Thu, 10 Apr 2025 22:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744322833; cv=none; b=KTknh9CqkmXEskPp2fV13efpBTVqyy+VVNNX8NEgUaej5iEUYaTUuK7n6HCFQsqZ6K/doxasXZ9F4hNpzLuSFh0zWFjh7df525J6IX/oDIKIWhn8KvIrP1/yX2W/lXf5sn/Fokp4iXWdmn/ucEMm/akD95JMGs2BENe7dhNO3/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744322833; c=relaxed/simple;
	bh=mdeLHLv6tsiCpWBb/BGcPai3epCksuh8DTjDTiCisoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HWjOgEAzoE8Gnm0CP4UF8T3nA+F6nWCtaK1OdLCH/4zK4X1pSHKgLk6MjbZ0mKF5gUoMr6T7DHIN7Z0k0xMYb8yveMtXhrFr4pkw8ZTmPaW2Clf7sSbObl329yJgH88w9oL8ROzNONPRkgatpqxUA2kASmm2jQy72eg7ia1GF74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YJXuAY/g; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YJXuAY/g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC664C4CEE9;
	Thu, 10 Apr 2025 22:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744322832;
	bh=mdeLHLv6tsiCpWBb/BGcPai3epCksuh8DTjDTiCisoc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YJXuAY/gqVNTN9lbpDnJfN1gnXT46St+EGb98p67bziYqAIu97qFmZd0D5d32XJyy
	 MBNm3i0me79wrU0KZpaZDuNlQC5v2l8KNFM3kbaquXXGBhRRuu8BsujCXcwfqgOA+v
	 zHvGCmdWUYzZC3/9KdLlZ8wA/m1I7MQpPHgxb+0Si+4M03hHsHh5xRsm6Lab+iBsCF
	 0NOmT0WVxdYjRBFms+byUe0fJrlfJePJ9+1XxEZZ/Ox8BdcJhobvbKzYjCCpzYBqdj
	 W8Z5h6VXLfZmxs45PzHPUOVVRydD4vrLY6Dr27auzgmUvdRfbUtdw/EhWqMruhsa+u
	 GJRoUBRyhjl1Q==
Date: Thu, 10 Apr 2025 15:07:11 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>, axboe@kernel.dk,
	linux-block@vger.kernel.org
Subject: Re: [PATCH] loop: stop using vfs_iter_{read,write} for buffered I/O
Message-ID: <20250410220711.GU6307@frogsfrogsfrogs>
References: <20250409130940.3685677-1-hch@lst.de>
 <Z_Z5ydIl7UGkFrz6@fedora>
 <20250410073439.GA461@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250410073439.GA461@lst.de>

On Thu, Apr 10, 2025 at 09:34:39AM +0200, Christoph Hellwig wrote:
> On Wed, Apr 09, 2025 at 09:44:41PM +0800, Ming Lei wrote:
> > On Wed, Apr 09, 2025 at 03:09:40PM +0200, Christoph Hellwig wrote:
> > > vfs_iter_{read,write} always perform direct I/O when the file has the
> > > O_DIRECT flag set, which breaks disabling direct I/O using the
> > > LOOP_SET_STATUS / LOOP_SET_STATUS64 ioctls.
> > 
> > So dio is disabled automatically because lo_offset is changed in
> > LOOP_SET_STATUS, but backing file is still opened with O_DIRECT,
> > then dio fails?
> > 
> > But Darrick reports it is caused by changing sector size, instead of
> > LOOP_SET_STATUS.
> 
> LOOP_SET_STATUS changes the direct I/O flag.
> 
> This is the minimal reproducer, dev needs to be a 4k lba size device:
> 
> dev=/dev/nvme0n1
> 
> mkfs.xfs -f $dev
> mount $dev /mnt
> 
> truncate -s 30g /mnt/a
> losetup --direct-io=on -f --show /mnt/a
> losetup --direct-io=off /dev/loop0
> losetup --sector-size 2048 /dev/loop0
> mkfs.xfs /dev/loop0
> 
> mkfs then fails with an I/O error.
> 
> (I plan to wire up something like this for blktests)

Please cc me so I can pick through the test. :)

> > > This was recenly reported as a regression, but as far as I can tell
> > > was only uncovered by better checking for block sizes and has been
> > > around since the direct I/O support was added.
> > 
> > What is the 1st real bad commit for this regression? I think it is useful
> > for backporting. Or it is new test case?
> 
> Not entirely sure, maybe Darrick can fill in.

It was a surprisingly hard struggle to get losetup on RHEL8 and 9 to
cooperate.  It doesn't look like 5.4 or 5.15 are affected.  Regrettably
it's going to be harder to test 6.1 and 6.6 because I don't have kernels
at the ready, and grubby is a PITA to deal with.

--D

> > 
> > > 
> > > Fix this by using the existing aio code that calls the raw read/write
> > > iter methods instead.  Note that despite the comments there is no need
> > > for block drivers to ever call flush_dcache_page themselves, and the
> > > call is a left-over from prehistoric times.
> > > 
> > > Fixes: ab1cb278bc70 ("block: loop: introduce ioctl command of LOOP_SET_DIRECT_IO")
> > 
> > Why is the issue related with ioctl(LOOP_SET_DIRECT_IO)?
> > 
> > 
> > Thanks, 
> > Ming
> ---end quoted text---
