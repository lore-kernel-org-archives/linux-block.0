Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB8D1EEA5D
	for <linux-block@vger.kernel.org>; Wed, 15 Jan 2025 09:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736934024; cv=none; b=ipdUPPReU6gEGZo4znPLklZpYsSWRtK2Zm8xaWZjT1b1hI+8HUKwt2nEJWOfUxeQNPZpfDQIMzVLn8ei6lVco9lcQfKakZ8NStO671HhxaHYxtPBzpsi9zJakyexQdtfErniZye9gl2+Aezj6wrUjNmygFbvbCqb9Dvl44fr40c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736934024; c=relaxed/simple;
	bh=6lPjAmeDCXAeOtmiHlwtrV53k9jOFvmtkglvGTXtXKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kfH5zSiMCPOPU1bWYCnOVQM1O5g8/f4T3rSTJZTrwSHPQeOWfZV2rPmWCn4usNZtt8yJpWNG4KhKD+eBXgm+umI7wv6cEAqiTqxgdubnUUE3cdd2imlupFfRos11O+Eo00Uo7jAIs4o1l18h+tBXWwusffrmdp/dyJBurskrnik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=oGGyOUKd; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oGGyOUKd"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=by7rn55csOxL0JGDQjJxb2FE9GA9xzEYYkNHIPobIqw=; b=oGGyOUKdlu0Tj/Osd8ky/E3Ntg
	JqBVcTC+r1mRrutmBorzUgOQ46bIwHLxU+oETmF9HW6oQkVjrYflk/OpuMdCPSdF6OYHyZWQnUyk+
	LGaVe/OqJf0zp/S2WmRiI6JdUaB0U4g66I3TYUNI+0knH0eKHvpogk4KTlvh95Uxk4r7UHO0ekI57
	RC2+xtKN+dcjEQTFUQDdIyW7+Im/ZNcktlZHcB5tYExTpXDOl+uInEKEnk/eeQSEP3raxmahp0p8t
	n2P+SSWK8bi8BHRnU5GqBnCZgu/Qb4Xeg6oi9oZGVQuN86nfWNjMvmghLkTF39yv88sbHKI6TQWM/
	CfbjnFvQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tXzsr-0000000BNMj-1vhG;
	Wed, 15 Jan 2025 09:40:21 +0000
Date: Wed, 15 Jan 2025 01:40:21 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, Kun Hu <huk23@m.fudan.edu.cn>,
	Jiaji Qin <jjtan24@m.fudan.edu.cn>
Subject: Re: [PATCH] loop: don't call vfs_flush() with queue frozen
Message-ID: <Z4eChfyt15sCL8rV@infradead.org>
References: <20250113022426.703537-1-ming.lei@redhat.com>
 <Z4Spc75EiBXowzMu@infradead.org>
 <Z4TNW2PYyPUqwLaD@fedora>
 <Z4TaSGZDu_B2GS1c@infradead.org>
 <Z4Tb3pmnXMk_z2Fm@fedora>
 <Z4UZ947fLqHusJzv@infradead.org>
 <Z4UsPor30ss0ML9s@fedora>
 <Z4cfVBrd9OJiYYG-@fedora>
 <Z4deHFfJ2qC8VHjT@infradead.org>
 <Z4dwFFIb6gjAa4wd@fedora>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4dwFFIb6gjAa4wd@fedora>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Jan 15, 2025 at 04:21:40PM +0800, Ming Lei wrote:
> On Tue, Jan 14, 2025 at 11:05:00PM -0800, Christoph Hellwig wrote:
> > On Wed, Jan 15, 2025 at 10:37:08AM +0800, Ming Lei wrote:
> > > Actually some FSs may call kmalloc(GFP_KERNEL) with i_rwsem grabbed,
> > > which could call into real deadlock if IO on the loop disk is caused by
> > > the kmalloc(GFP_KERNEL).
> > 
> > Well, loop can always deadlock when the lower fs is doing allocations,
> > even without the freeze.  I'm actually kinda surprised loop doesn't
> > force a context noio as we'd really need that.
> 
> Loop does call mapping_set_gfp_mask(~(__GFP_IO|__GFP_FS)).

But that only helps with page cache allocations, not other allocations
don't in the I/O path, of which there are plenty in modern file systems.

> > And all of these are caused by not breaking the dependency loop..
> 
> Can you share how to break the dependency? Such as fs_reclaim &
> mm->mmap_lock.

fs_reclaim should not be broken.  It's a fake lockdep key annotation
the reclaim path.  Everything under it needs to be NOFS, or in case
of loop NOIO (see above).  I think mmap_lock is just an indirect chain
here, but I need to take a closer look.  A little busty this week and
only sporadically online, sorry.

