Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D0923243D
	for <linux-block@vger.kernel.org>; Wed, 15 Jan 2025 07:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736924702; cv=none; b=ANx90bSgA9qEtP9iRr0ZJ4YDgP+EWGilLyvPJU0xB2lErj2SZb36srVuKu5Ez+T779kbTGgbvsYR5PgAaLm/qrGkJyrpgVHeY/0ekotv9BNGs/ZZOMOSjRnexquNqNngYG+i0i68vteUNNP8Lg94A/7SFUgsWyUn2SBkNbJ4F3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736924702; c=relaxed/simple;
	bh=HqMqlOrRUNYoej678DKG3UJAMPs10aijH6pBsJ9+1+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EZOFYxfF4m5j/EJ9QjEK0nEGRDen9ZCnB4A1QxWO1hLodCtG1hI+x55nzGVukVBzYzmJ4uCWTcjqreDbvTKhet7D7e6vunPvOy7QoZdz6PgitKmTSZPYFqAyiJZqNYM0uerZBKMrJdlI/Kdm37mdU7LFMVhsZd+hPc3RXF+usLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DgKH0Soc; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DgKH0Soc"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=4sBGLdIlIZWqh34dVcQEWTcufWuO0Oh9hB7jhMyKnBY=; b=DgKH0SociXaPsXxmPo5ZSdxfrF
	xZYGRzGohxuakEDWZxjfkKDVUNpuJacvU6Vs7n+FxU45n3Kr3kFPR1C2ec9CfPsghs9vy1WA8NiCK
	/nv7R7CaQ+7SlptigXt1RF44YMA4yrmgSbOsrp0fE7gY2b7IlHpp524SJBsv08TRb9GjAEqr47kRM
	z7L3pW5W2Sr1CEWTHL6j1fv5jDhOQBr66KXV64G3zQWUTslg0/s/aRr5PsfI3iaaeUth7NwjD+16a
	VWIoYldTl3xHvOV8WOy+ax85KWi0dkX/Wp3vlSnPJYY4RmNhB8bVRSA4pex9OjXeOjwuLSN0rkirm
	RRD7gfbg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tXxSW-0000000AszI-286k;
	Wed, 15 Jan 2025 07:05:00 +0000
Date: Tue, 14 Jan 2025 23:05:00 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, Kun Hu <huk23@m.fudan.edu.cn>,
	Jiaji Qin <jjtan24@m.fudan.edu.cn>
Subject: Re: [PATCH] loop: don't call vfs_flush() with queue frozen
Message-ID: <Z4deHFfJ2qC8VHjT@infradead.org>
References: <20250113022426.703537-1-ming.lei@redhat.com>
 <Z4Spc75EiBXowzMu@infradead.org>
 <Z4TNW2PYyPUqwLaD@fedora>
 <Z4TaSGZDu_B2GS1c@infradead.org>
 <Z4Tb3pmnXMk_z2Fm@fedora>
 <Z4UZ947fLqHusJzv@infradead.org>
 <Z4UsPor30ss0ML9s@fedora>
 <Z4cfVBrd9OJiYYG-@fedora>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4cfVBrd9OJiYYG-@fedora>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Jan 15, 2025 at 10:37:08AM +0800, Ming Lei wrote:
> Actually some FSs may call kmalloc(GFP_KERNEL) with i_rwsem grabbed,
> which could call into real deadlock if IO on the loop disk is caused by
> the kmalloc(GFP_KERNEL).

Well, loop can always deadlock when the lower fs is doing allocations,
even without the freeze.  I'm actually kinda surprised loop doesn't
force a context noio as we'd really need that.

> > > because we're talking about different file systems instances.  The only
> > > exception would be file systems taking global locks in the I/O path,
> > > but I sincerely hope no one does that.
> >  
> > Didn't you see the report on fs_reclaim and sysfs root lock?
> > 
> > https://lore.kernel.org/linux-block/197b07435a736825ab40dab8d91db031c7fce37e.camel@linux.intel.com/
> 
> There are more, such as mm->mmap_lock[1], hfs SB 'cat_tree' lock[2]...
> 
> 
> [1] https://lore.kernel.org/linux-block/67863050.050a0220.216c54.006f.GAE@google.com/
> [2] https://lore.kernel.org/linux-block/67582202.050a0220.a30f1.01cb.GAE@google.com/

And all of these are caused by not breaking the dependency loop..

