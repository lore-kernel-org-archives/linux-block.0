Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3FB30BF79
	for <linux-block@vger.kernel.org>; Fri, 31 Oct 2025 09:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761901771; cv=none; b=R+TwZocJcagzYp360VqeuGNLGhfBc1NPYLXXajS0BF2mku3/KHOyVlxq64KfTGCpXOOtgneu8YxOaH5Q981Fg09s1FNrZFK934YJEm0jH+4ot2BOjri0UvRU0m1in0zhA8ps9mtSzbfRJNl+PTAlpaBVjIpiPrdaZ0ADD879f5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761901771; c=relaxed/simple;
	bh=2lRa67nMXvdcn7K9ScQUQ7phMnuh/39r0OzbWtgJwNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qVX1JYDXM8F8xURldmgGjEayXCD+QIiR/O423nGImX4BT08inCUXs/zI5iXuBq0yMbWBnhpAGKOdRYLsOUxCcbEwsj2d++C10Z+1fKVyWcHBDPSIhJiZcDpjxhAdac86CpFBpLmL+wsTbRoFPFeJEnorzW6L0S7sw7u8/7p7g9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5BFF2227A88; Fri, 31 Oct 2025 10:09:25 +0100 (CET)
Date: Fri, 31 Oct 2025 10:09:25 +0100
From: Christoph Hellwig <hch@lst.de>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Luis Chamberlain <mcgrof@kernel.org>, linux-block@vger.kernel.org,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	guanghuifeng@linux.alibaba.com, zongyong.wzy@alibaba-inc.com,
	zyfjeff@linux.alibaba.com
Subject: Re: question about bd_inode hashing against device_add() // Re:
 [PATCH 03/11] block: call bdev_add later in device_add_disk
Message-ID: <20251031090925.GA9379@lst.de>
References: <20210818144542.19305-1-hch@lst.de> <20210818144542.19305-4-hch@lst.de> <43375218-2a80-4a7a-b8bb-465f6419b595@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43375218-2a80-4a7a-b8bb-465f6419b595@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Oct 31, 2025 at 03:46:02PM +0800, Gao Xiang wrote:
> From my understanding, before this commit, bdev_add() will
> be called prior to device_add() so insert_inode_hash()
> in bdev_add() will be called before users can see blkdev
> in the devtmpfs.
>
> But after this change, blkdev can be seen before
> insert_inode_hash(), which opens a race (although I'm not
> sure if it's an expected behavior) blkdev_get_no_open() will
> find nothing (e.g. mounting) even blkdev in devtmpfs is
> there.

We're not supposed to see the uevent notification before the
block device is ready.  Do you see that earlier, or do you have
code busy polling for a node?

