Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E7D2701A3
	for <linux-block@vger.kernel.org>; Fri, 25 Apr 2025 14:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745591613; cv=none; b=T1mDzNSTVDCGafZLuC71189vjjm0/N5RlYFbvLzcTxHb8/On8jskdIpjZwRwrYoWkGVL9R5C0aIQIblVfPWio3wj77FB7nqnc68oIbsYTtVx0YvuXDFwZfQ18kLx7dq+NkLvLXnDqP3Wd1rGAUYcBu7MBJT3rgm0Nx3Q0y+4A8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745591613; c=relaxed/simple;
	bh=6KdeKzgxmgl6AVin8SaWWxvQJO4XytratT0P8Y+9++E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fN2PgpgWOfjBInWMNvr0CUo4bRw+rHrGJaMlqKC+aKveWTyUOX6A87yNfltnYyKpoHtE2OEOFaBCjdvePJA13qntdDFf3Po/fz289DGEyVUvGXQE9izzYSLk+tcZHyIF9xmkwybzQRSfQvtTPNlI1/VnF5NW3CzLt0qfw1+G5sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id CC92E68B05; Fri, 25 Apr 2025 16:33:26 +0200 (CEST)
Date: Fri, 25 Apr 2025 16:33:26 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V3 07/20] block: prevent adding/deleting disk during
 updating nr_hw_queues
Message-ID: <20250425143326.GD11082@lst.de>
References: <20250424152148.1066220-1-ming.lei@redhat.com> <20250424152148.1066220-8-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250424152148.1066220-8-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Apr 24, 2025 at 11:21:30PM +0800, Ming Lei wrote:
> +	init_rwsem(&set->update_nr_hwq_sema);

Can you please call this update_nr_hwq_lock instead?  _sema is a very
unusual naming for a rw semaphore.

>   * This function registers the partitioning information in @disk
>   * with the kernel. Also attach a fwnode to the disk device.
>   */
> -int __must_check add_disk_fwnode(struct device *parent, struct gendisk *disk,
> -				 const struct attribute_group **groups,
> -				 struct fwnode_handle *fwnode)
> +static int __add_disk_fwnode(struct device *parent, struct gendisk *disk,
> +			     const struct attribute_group **groups,
> +			     struct fwnode_handle *fwnode)

once this becomes internal there is no need for the _fwnode postfix and
this can simply become __add_disk.

This probably wants a lockdep assert that te nr_hwq lock is held for the
blk-mq case.

Also when you use two-tab indentation for the arguments you don't need to
reformat for every little naming change.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
