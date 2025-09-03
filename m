Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D08302CB3
	for <linux-block@vger.kernel.org>; Wed,  3 Sep 2025 14:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756908581; cv=none; b=Yw472rb4cHDh9txAZGCp0CD3MgjMSdzGm0wuFRaNZKgWy0Q0dwJpa1nlM/TvsnUgD57nuArVeS0y0SaydpFcJY4AA7fOlePmE3lc5QIFF1L1DUScdjc6kw539T9mO3VWczNKjmicvMCSk65uJVp7Ux3w2N3ttlO+/pYx3vYnXvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756908581; c=relaxed/simple;
	bh=NAAsiGhebLYdg4FBLRmrHJpwhXvSoS4qXNZJe+yKFEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mi4g2Iou+l7IyWqbLBkJdSqynuB26SatSEnCeMAfoQZ1Kc7srbdTAk+z+KaU+uG/FGHRNd/mj+z2e8Gz9ehHdHCAWvGgZNo2zL8j57q12oicRnaHJfHtSNFxR/eH0TQQ0B/j9jFDCxgehBOuVv+ocpgiHJJ3aXJfuMCBlIxOZfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=b+jXQ/BW; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="b+jXQ/BW"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=dTdOfwnUX1/7f9KR5MCmCBljhDZ69OSp5gjo3Ndyj1w=; b=b+jXQ/BWnnf8OMElLtldyPBz8Y
	iwVank1MRhxYxRIaRQ0rxk3kWYhJpCSRXuIA2BEQHwaqvfBvux5xHkzQ1sUuUTGjLzY2rUXdA/o8W
	KR25/Cg6CkZgpXnEoy/240IVzcC0sFsZcAHXj+gh975YDCrj7snUaZddqarxQwJIpNbHlV/Hp/KUc
	rGCid/0bMayUToAivYfCbVKsBJHDzKZQyfaeGNqSNs2lq6XEj7cB8spLnHo7RJs46XqnjHnoJQmt7
	NiOWRaFu9F4N6UwjmZ/2fplcvwDeSpfjpBNZlwEFkxCt7RZcfkoGN/bG0IE9y+2CRwiSUmSONtFsj
	hDYWGVKg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utoB6-00000000YXd-109B;
	Wed, 03 Sep 2025 14:09:36 +0000
Date: Wed, 3 Sep 2025 15:09:36 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
Subject: Re: [RFC][PATCHES] convert ->getgeo() from block_device of partition
 to gendisk
Message-ID: <20250903140936.GK39973@ZenIV>
References: <20250718192642.GE2580412@ZenIV>
 <c821c881-76c4-4dde-a208-bb9e8f3ea63f@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c821c881-76c4-4dde-a208-bb9e8f3ea63f@kernel.dk>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Jul 18, 2025 at 03:20:02PM -0600, Jens Axboe wrote:
> On 7/18/25 1:26 PM, Al Viro wrote:
> > 	Instances of ->getgeo() get a block_device of partition and
> > fill the (mostly fake) geometry information of the disk into caller's
> > struct hd_geometry.  It *does* contain one member related to specific
> > partition (the starting sector), but... that member is actually filled
> > by the callers of ->getgeo() (blkdev_getgeo() and compat_hdio_getgeo()),
> > leaving the instances partition-agnostic.
> > 
> > 	All actual work is done using bdev->bd_disk, be it the disk
> > capacity, IO, or cached geometry information.  AFAICS, it would make
> > more sense to pass it gendisk to start with.
> > 
> > 	The series is pretty straightforward - conversion of scsi_bios_ptable()
> > and scsi_partsize() to gendisk, then the same for ->bios_param(), then
> > ->getgeo() itself.   It sits in viro/vfs.git#rebase.getgeo, individual patches
> > in followups.
> > 
> > 	Comments, objections?
> 
> None from me, looks fine:
> 
> Acked-by: Jens Axboe <axboe@kernel.dk>

Which tree would you prefer it to go through?  Currently it's in viro/vfs.git
#work.getgeo (rebased to 6.17-rc1, no changes since the last posting);
I can merge it into vfs/viro #for-next and push it to Linus in the next
window, unless you prefer it to go through the block tree...
