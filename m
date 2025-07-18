Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B182F18E20
	for <linux-block@vger.kernel.org>; Fri, 18 Jul 2025 19:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752866807; cv=none; b=IM2pqDO/vn1DrCVy0pm0EmCujDoXNjg0A7pVAxR1D+qLcNRBsBHmlmEAnp4B7nqsXl4neLj3aCF801cihe/CmZ+9mG1nMmZt3EJXRG0eF5uX9HXC8mq0o3k4bxv/vO7apZUO7tMkuoxDXS7IhCmCZBa3yBB6I5F3R7odDVPAmUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752866807; c=relaxed/simple;
	bh=6KYYStB3QFQCrG0fVM+QTmc1h376oDyEASYCOkJ14NM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=db+G5q4SIMp1icCJiXlq9LY54jcMzLWp0rbk5k4FhEyiijbSVQvyoKzfT3BTFh/Xph0FVZZAvYpmQ6463u1wdD7Oat84mTs55s4iZ1JEuGoNxmvqJtnvEYQ3+WZlzyo7Y2WOfhjbdEF/7mxiq/0kpdnoaTTiP1hS6q9kRnWUbfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=qfB1jegw; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="qfB1jegw"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=DqzSHe0UYi4BqOqKiJJMK+yJaDYfDWVLTAt/tuXZCJM=; b=qfB1jegwq6awp+3OOIPu2+q2Kx
	oA6AAKRLTw+tYt1jmaVz/LONWSzH+0N6unimFjIZqVIa48w0jTLOr8oA7dLYpg1lQfMnSteU8rvaU
	nkzzLQdeP/O6TvwVJPF3xDierPxWtu/vIlFPGFaOyFqa0OQgdTZhY2qRPfljBBPbsZCrAOvsX8oAZ
	K6SIti5bG4UbDFnfUkZhmq6pv17zjIngTlBcjgIcM7pend4KyPeV1/ainISXeJCX1/gz9cai0980g
	rltWnSl9VEZGWidi9AsLbIorI2Gp+HnLqM2WfKsOOvrvztNOKH/6JlTVvI+bh4amW8LJJKUhn+ybV
	CzWuLRCg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ucqjD-0000000DY7k-0Drr;
	Fri, 18 Jul 2025 19:26:43 +0000
Date: Fri, 18 Jul 2025 20:26:42 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-block@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>
Subject: [RFC][PATCHES] convert ->getgeo() from block_device of partition to
 gendisk
Message-ID: <20250718192642.GE2580412@ZenIV>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

	Instances of ->getgeo() get a block_device of partition and
fill the (mostly fake) geometry information of the disk into caller's
struct hd_geometry.  It *does* contain one member related to specific
partition (the starting sector), but... that member is actually filled
by the callers of ->getgeo() (blkdev_getgeo() and compat_hdio_getgeo()),
leaving the instances partition-agnostic.

	All actual work is done using bdev->bd_disk, be it the disk
capacity, IO, or cached geometry information.  AFAICS, it would make
more sense to pass it gendisk to start with.

	The series is pretty straightforward - conversion of scsi_bios_ptable()
and scsi_partsize() to gendisk, then the same for ->bios_param(), then
->getgeo() itself.   It sits in viro/vfs.git#rebase.getgeo, individual patches
in followups.

	Comments, objections?
