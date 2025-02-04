Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F195B3D81
	for <linux-block@vger.kernel.org>; Tue,  4 Feb 2025 05:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738646350; cv=none; b=f0q+cErGP+OKTeiYc9g+vU1G8fNPF3o/zNdbkGOXf1Oo2Unf8sU2T+9EicGp1LMNM6BLMZiNxhPEHrMnlDSMEZyoyiASI5fZzhKvvM2SSE2yDZ9ebCczI2ErzX45LdZ2d2T4oeRfWvEsboDbEHTWbeIglXNun+kRGXgoePWw4sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738646350; c=relaxed/simple;
	bh=EGLBDArbX+38NlrhsorBMyZvcARfxkrHSjhL954I8qk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IEm2aOJJxcb6ZORVWCi3XublVRgiWjdztMJgECeO/yzWBDvesGL6IwXJVxynQ5onQRELXJdMqVfnqPX6Q8kyI+IecAgqbUMS/7Z/kEy4yS7ifvUx59hAw4DufeDSGXrmmtIBicU5qeG/wKskgH3vawrwOl8JPsQV9yEXWB9r2TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LlIVw3hu; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LlIVw3hu"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
	:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=ZkPUHLuqz3/xYLfqs60LiRIZbDDeKbs4v86qemwevcg=; b=LlIVw3huGBpYiuDKvbAAC0KtaG
	4tg88hDrAWWtz4tJtOf9YejXzcoLY+qrLzzditGo26uiVraN/+WB85i4lkrWq+PK/lv+Jxhiku+7I
	Y1deU+KcaTBVeVsXZQcWnFg0dR4gp1MZ04CUo7XzzGZWWv0BW1NGe1LOfRX9Nj8OWORUM7ivZIhKU
	AwNE5MatzC2QPUe/4oKyzMIyGqtbyne6J6caXXI7/jJs/0CD37dN8LE+G2ycpJzfKN++zzblfWvtB
	Ouy84Ut0OlSddZ59s1GyeMtGYYb9S4VTpOzi586My81rIHLDm6XWlUfnkDQcWt+QNVwTzMHnpZlKW
	4I26HNvg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tfBL1-0000000HGkb-2Eh5;
	Tue, 04 Feb 2025 05:19:07 +0000
Date: Mon, 3 Feb 2025 21:19:07 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Travis Downs <travis.downs@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, Theodore Ts'o <tytso@mit.edu>,
	linux-block@vger.kernel.org
Subject: Re: Semantics of racy O_DIRECT writes
Message-ID: <Z6GjS9rOmm4el9Za@infradead.org>
References: <CAOBGo4xx+88nZM=nqqgQU5RRiHP1QOqU4i2dDwXt7rF6K0gaUQ@mail.gmail.com>
 <20250109045743.GE1323402@mit.edu>
 <CAOBGo4w88v0tqDiTwAPP6OQLXHGdjx1oFKaB0oRY45dmC-D1_Q@mail.gmail.com>
 <20250109155119.GF1323402@mit.edu>
 <Z4DhK_JrkL5jn5P1@infradead.org>
 <CAOBGo4y_zo08BX=hRYsAQrdSfaLfn2kMci+Jk1R+B1-kjzsX1g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOBGo4y_zo08BX=hRYsAQrdSfaLfn2kMci+Jk1R+B1-kjzsX1g@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Jan 31, 2025 at 05:06:50PM -0300, Travis Downs wrote:
> On Fri, Jan 10, 2025 at 5:58 AM Christoph Hellwig <hch@infradead.org> wrote:
> >
> > On Thu, Jan 09, 2025 at 10:51:19AM -0500, Theodore Ts'o wrote:
> > > For Linux, if the block device is one that requires stable writes
> > > (e.g., for iSCSI writes which include a checksum, or SCSI devices with
> > > DIF/DIX enabled, or some software RAID 5 block device), where a racy
> > > write might lead to an I/O error on the write or in the case of RAID
> > > 5, in the subsequent read of the block, Linux will protect against
> > > this happening by marking the page read-only while the I/O is
> > > underway, either if it's happening via buffered writeback or O_DIRECT
> > > writes, and then marking the page read/write afterwards.
> >
> > This only happens for buffered I/O, and not for direct I/O.
> 
> Thank you. To clarify, "this" means the RO protection, right? So in direct IO
> there is no such protection?

Yes.

> > But that only matters when your operation is inside the sector (LBA)
> > boundary that the device interface operates on, e.g. if you using 512
> > byte sector size as long your stay outside of that you're still fine.
> 
> Sorry it's not clear if you are talking about the buffered or direct
> I/O case here.

This is all about direct I/O.

> > BUT: that assumes device checksums.  File systems can have checksums
> > as well and have the same problem.  Because of that for example running
> > Windows VM images which tend to somehow generate this pattern on qemu
> > using direct I/O on btrfs files has historically causes a lot of
> > problems.
> 
> So is it fair to say that for direct IO these types of racy writes are not safe?

In general: yes.

> 
> Specifically, we are looking at behavior in a 3rd party, proprietary
> block device
> (implemented as a kernel module) and are wondering if these types of racy
> writes break the implied or explicit semantics of safe direct IO writes.

I have no interest in helping anyone into looking proprietary drivers.
But every single one I've looked at was somewhere between somewhat to
totally broken in many way.
