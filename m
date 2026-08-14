Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72303E00A5
	for <linux-block@vger.kernel.org>; Fri, 14 Aug 2026 08:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786695130; cv=none; b=bTkh+mBNlRlQQXhJHjyOScbNHH0vzSGQcXZ4Dfhhec9e2tyc96A8ApL/GUeNrdl4/thFbSTMJSplVtciMgthiF5G285wLEkExhuXjSohYXHbQR4nDivae9gyl6pTIi4wR579BSyaIkGVfBaBkoFxe/Rr+fsZkSW5RmoC+Q97Rug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786695130; c=relaxed/simple;
	bh=9JYfE6tnahry8X0k+IgN6EW/bHkh7IZx52Pa3bkGtgE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GUNw/L4Fz3DPfcPPizQSQtEs/G9f9UoYNzZT02iJJhSoA+yVo+goHHM8MxHARxM0ez/y04P2UK5qN8IxT/9+QGr2z6KFeJ+Xsc/2/5pXT8ZxlEXdD8Xu25EXvfzJBXr1qDGDSofrrEHd8gUkngjt7q7TpJfnfiNNc/daP2g9x8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 689C768B05; Fri, 14 Aug 2026 10:12:05 +0200 (CEST)
Date: Fri, 14 Aug 2026 10:12:05 +0200
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH v4 13/13] block: flag zoned disks with GENHD_FL_NO_PART
Message-ID: <20260814081205.GH12566@lst.de>
References: <20260814063201.1762743-1-dlemoal@kernel.org> <20260814063201.1762743-14-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260814063201.1762743-14-dlemoal@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Aug 14, 2026 at 03:32:01PM +0900, Damien Le Moal wrote:
> Zoned block devices do not support partitions. However, the partition
> table is nevertheless still inspected, and any partition found ignored
> with a warning in add_partition(). While this is generally not a problem,
> and in fact beneficial to the user as it indicates an invalid use of a
> zoned block device, scanning for a partition table on the device may
> result in issuing read operations to offline zones (e.g. after a disk head
> is depopulated for disks that support head management operations).
> 
> Since partitions are ignored anyway, completely disable partition scanning
> for zoned gendisks by setting the flag GENHD_FL_NO_PART in __add_disk().
> The existing check in add_partition() is left as-is to ensure that we
> still get a warning if for whatever reason, despite GENHD_FL_NO_PART, we
> still endup trying to add partitions.
> 
> Flagging zoned disks with GENHD_FL_NO_PART also has the benefit to expose
> through sysfs the ext_range attribute with the value of 1 instead of the
> default DISK_MAX_PARTS, thus correctly advertizing the fact that zoned
> disks do not support partitions.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> Reviewed-by: Hannes Reinecke <hare@kernel.org>

This really should get a Fixes for my original patch that skipped
partitions and go to -stable (and into 7.3 even if Jens won't take
the whole series) as it causes totally pointless I/O.  I also suspect
the partition scanning and blkid interaction might be related to some
of the weirdo xfstests failure I see where blkid doesn't detect
xfs file systems in synthetic devices.

Reviewed-by: Christoph Hellwig <hch@lst.de>
