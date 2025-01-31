Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944A614D6EB
	for <linux-block@vger.kernel.org>; Fri, 31 Jan 2025 07:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738308502; cv=none; b=uc0tjo289JkGIdM2p/te2vFvkUaMXFxuR1rGeDSjqdAVIJLr3N8Guzq+K1HdR/lb2wl+I7T2WoPtCAJV5VA5+QIBmlyWOHeQL5xhuZ3rqrEbVkCIAeIJE8qBNXcmQs03vhaeu9L4+hFiVSYUaXYhDrzR0pzWO9xN6K+wPL+FhvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738308502; c=relaxed/simple;
	bh=IK6uF6janJhKQXnsSXHOEGW1ZyoLKhADAVAzYLgA+Ck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nkfRdSc3BE1JfrFQC2UKiuVyFBh59c4GdaLGVtpVMpYaWQqW28FU8ADYepQjvgZG2kEHYdtbnsgi1dFIYA1cqlDtyzo7u+8oMUsssqYGWYssFLPHx9JDGx3DRJtxyr3b3quPHiOzPkNxHN0o4XmWMbiSYlAYpD3OsHcCVWQDnQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 125F568C4E; Fri, 31 Jan 2025 08:28:15 +0100 (CET)
Date: Fri, 31 Jan 2025 08:28:14 +0100
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk,
	linux-block@vger.kernel.org
Subject: Re: [PATCH] loop: take the file system minimum dio alignment into
 account
Message-ID: <20250131072814.GA16012@lst.de>
References: <20250127152236.612108-1-hch@lst.de> <c6603890-4b2d-4ad3-9fd0-19a6274a25d8@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c6603890-4b2d-4ad3-9fd0-19a6274a25d8@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Jan 30, 2025 at 02:49:38PM +0900, Damien Le Moal wrote:
> > +static void loop_query_min_dio_size(struct loop_device *lo)
> > +{
> > +	struct file *file = lo->lo_backing_file;
> > +	struct block_device *sb_bdev = file->f_mapping->host->i_sb->s_bdev;
> > +	struct kstat st;
> > +
> > +	if (!vfs_getattr(&file->f_path, &st, STATX_DIOALIGN, 0) &&
> > +	    (st.result_mask & STATX_DIOALIGN))
> > +		lo->lo_min_dio_size = st.dio_offset_align;
> 
> Nit: Maybe return here to avoid the else below and the comment block in the
> middle of a if-else-if ?

That looks kinda weird.  But maybe I can just return the value instead
and let the caller assign it, which would allow an early return without
multi-line blocks.

> > -static unsigned int loop_default_blocksize(struct loop_device *lo,
> > -		struct block_device *backing_bdev)
> > +static unsigned int loop_default_blocksize(struct loop_device *lo)
> >  {
> > -	/* In case of direct I/O, match underlying block size */
> > -	if ((lo->lo_backing_file->f_flags & O_DIRECT) && backing_bdev)
> > -		return bdev_logical_block_size(backing_bdev);
> > +	/* In case of direct I/O, match underlying minimum I/O size */
> > +	if (lo->lo_backing_file->f_flags & O_DIRECT)
> > +		return lo->lo_min_dio_size;
> 
> I wonder if conditionally returning lo_min_dio_size only for O_DIRECT is
> correct. What if the loop dev is first started without direct IO and gets a
> block size of 512B, and then later restarted with direct IO and now gets a block
> size of say 4K ? That could break a file system that is already on the device
> and formatted using the initial smaller block size. So shouldn't we simply
> always return lo_min_dio_size here, regardless of if O_DIRECT is used or not ?


Yes, that's not handled correctly here or in the existing code.  I'll
add a patch before this one to fix that up.

