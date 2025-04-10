Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9F91DF751
	for <linux-block@vger.kernel.org>; Thu, 10 Apr 2025 07:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744270486; cv=none; b=JbqMjyskHnyif76QtaBCKos85ZOM86nc/oqoO/xBk+U6rb+0/Fd8RoDAwOUVI/4gnGovsl69bovB9Z/ydkCtGaMl2aiLIkcoUgAmC2BWFOl9QExkoKQeIrMivj/atJDAHf98LWWPqbU1R5+eA7v19+HVEnyFTT9VmUFCPIgC+i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744270486; c=relaxed/simple;
	bh=YLJxgH6Q9126RQrki8MIAwZ3H5NPqCkqCGMqSaIbQOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SwTCdSYViWZrEhCfahI/2Hj5vj7E2gaabhlT0+YNzV37Aez6J8vBUr+C9ZS1i3YoWpCGSifvOhDJNMEi+xUqhUuETLPQwDF/JbM8pftdV8Sp/CJSRkXYp+YhCifyq5zySAoSqDQspPQbz+A8vFxw7Cueu66xZKlG21//dp39/OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 75CA868B05; Thu, 10 Apr 2025 09:34:39 +0200 (CEST)
Date: Thu, 10 Apr 2025 09:34:39 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk, djwong@kernel.org,
	linux-block@vger.kernel.org
Subject: Re: [PATCH] loop: stop using vfs_iter_{read,write} for buffered I/O
Message-ID: <20250410073439.GA461@lst.de>
References: <20250409130940.3685677-1-hch@lst.de> <Z_Z5ydIl7UGkFrz6@fedora>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_Z5ydIl7UGkFrz6@fedora>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Apr 09, 2025 at 09:44:41PM +0800, Ming Lei wrote:
> On Wed, Apr 09, 2025 at 03:09:40PM +0200, Christoph Hellwig wrote:
> > vfs_iter_{read,write} always perform direct I/O when the file has the
> > O_DIRECT flag set, which breaks disabling direct I/O using the
> > LOOP_SET_STATUS / LOOP_SET_STATUS64 ioctls.
> 
> So dio is disabled automatically because lo_offset is changed in
> LOOP_SET_STATUS, but backing file is still opened with O_DIRECT,
> then dio fails?
> 
> But Darrick reports it is caused by changing sector size, instead of
> LOOP_SET_STATUS.

LOOP_SET_STATUS changes the direct I/O flag.

This is the minimal reproducer, dev needs to be a 4k lba size device:

dev=/dev/nvme0n1

mkfs.xfs -f $dev
mount $dev /mnt

truncate -s 30g /mnt/a
losetup --direct-io=on -f --show /mnt/a
losetup --direct-io=off /dev/loop0
losetup --sector-size 2048 /dev/loop0
mkfs.xfs /dev/loop0

mkfs then fails with an I/O error.

(I plan to wire up something like this for blktests)

> > This was recenly reported as a regression, but as far as I can tell
> > was only uncovered by better checking for block sizes and has been
> > around since the direct I/O support was added.
> 
> What is the 1st real bad commit for this regression? I think it is useful
> for backporting. Or it is new test case?

Not entirely sure, maybe Darrick can fill in.

> 
> > 
> > Fix this by using the existing aio code that calls the raw read/write
> > iter methods instead.  Note that despite the comments there is no need
> > for block drivers to ever call flush_dcache_page themselves, and the
> > call is a left-over from prehistoric times.
> > 
> > Fixes: ab1cb278bc70 ("block: loop: introduce ioctl command of LOOP_SET_DIRECT_IO")
> 
> Why is the issue related with ioctl(LOOP_SET_DIRECT_IO)?
> 
> 
> Thanks, 
> Ming
---end quoted text---
