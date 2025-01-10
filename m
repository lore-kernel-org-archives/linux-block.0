Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A59208978
	for <linux-block@vger.kernel.org>; Fri, 10 Jan 2025 08:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736499502; cv=none; b=QS28LpSfXHrhU7lV1mXEIFR4EwGgS9cOR8Y8KtWbIU31fzDCxdioxUwo+aC5etX19o5GBzyz/bSDUGOFVXuZXM9bgtY3F1eHPFUPukM198NcVDwf1w0uGSC3soo4y/ijXPziTgIwHiBO9vErD9v7GWGqK80sywoclj2mlxlQ1l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736499502; c=relaxed/simple;
	bh=Dlr94CqVBpDTfAfvcl3AQN+YxVkdDsYsT2Yat8bkrkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nAFTXJllj45Jnt5BVZT90+eTQzqUdJiX+TYALaBUrBNOWF9syvkb2zSWVCGCInAH4aHpi0l+zcz015LWklnFHrzrzsXKAD7O2X0AKmmXDiKB4Xq4FK5N/HKk4D/QEP7R8gAN4v8+nPYwogFN6Xv+qdCaastvHB3dIFIsRu62zz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=2CinhbZn; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="2CinhbZn"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=RDp/DbtGirYJYNAv3Ihs6BUOnf2dqZhzxU2jeAkSL2w=; b=2CinhbZnZejajO/6rqG5dD6Fqr
	53KF22JUBKIPl/KJc+60SU8jGPo22tL3QFGNGXZ4G2uzGr42zhv/9oMUXi42/fZBvcry8cl0cmeJk
	FMTU90kdj4ICM0aXt7rtpcivnsi0kJ41qbq0VLdhpplVP0pDA2/o9tto4/h5GX2uX7iy5lW6S8cxc
	ku35EaZX881ZDnW4VDADbXXo00B+7+4JlJsD1i6H2AE8JpZKdPim9IjSUwOtm4KLvfLshSgQfebNQ
	yRLuHw+tHQa/pp8lypTS8uTxkvttBHCJDnjzE2Tut7X+EbzVIxazwlcy2E1VPl13L6HjDQ7+K+XBM
	t5wfGuDA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tWAqR-0000000EcGq-23bb;
	Fri, 10 Jan 2025 08:58:19 +0000
Date: Fri, 10 Jan 2025 00:58:19 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Theodore Ts'o <tytso@mit.edu>
Cc: Travis Downs <travis.downs@gmail.com>, linux-block@vger.kernel.org
Subject: Re: Semantics of racy O_DIRECT writes
Message-ID: <Z4DhK_JrkL5jn5P1@infradead.org>
References: <CAOBGo4xx+88nZM=nqqgQU5RRiHP1QOqU4i2dDwXt7rF6K0gaUQ@mail.gmail.com>
 <20250109045743.GE1323402@mit.edu>
 <CAOBGo4w88v0tqDiTwAPP6OQLXHGdjx1oFKaB0oRY45dmC-D1_Q@mail.gmail.com>
 <20250109155119.GF1323402@mit.edu>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250109155119.GF1323402@mit.edu>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Jan 09, 2025 at 10:51:19AM -0500, Theodore Ts'o wrote:
> For Linux, if the block device is one that requires stable writes
> (e.g., for iSCSI writes which include a checksum, or SCSI devices with
> DIF/DIX enabled, or some software RAID 5 block device), where a racy
> write might lead to an I/O error on the write or in the case of RAID
> 5, in the subsequent read of the block, Linux will protect against
> this happening by marking the page read-only while the I/O is
> underway, either if it's happening via buffered writeback or O_DIRECT
> writes, and then marking the page read/write afterwards.

This only happens for buffered I/O, and not for direct I/O.

But that only matters when your operation is inside the sector (LBA)
boundary that the device interface operates on, e.g. if you using 512
byte sector size as long your stay outside of that you're still fine.

BUT: that assumes device checksums.  File systems can have checksums
as well and have the same problem.  Because of that for example running
Windows VM images which tend to somehow generate this pattern on qemu
using direct I/O on btrfs files has historically causes a lot of
problems.

