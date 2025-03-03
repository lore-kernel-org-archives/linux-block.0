Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB45214A6E
	for <linux-block@vger.kernel.org>; Mon,  3 Mar 2025 15:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741016933; cv=none; b=XBmxoZYW0CwEjoCdigIcf6om9uK5mxpvlOM8VohOLtGdalH/pxY86nbDmnxDLtrKub2TPzY98M6kGeX9Wyjcf8e0z/uBQbJAhyRBYJYdEibCdjrPvEnLDm9lRTWGFhhRAE42tn6m3mR8ppfbUJ94Mcs3TLIIL4uS3CGsrynaGS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741016933; c=relaxed/simple;
	bh=1gfWbXOHXAYCblxNQ2JEhLx8RXJFIn3Fg535FJYmFfM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F+oSd2gWdXHcUgT5OKDOmydp4t0xDQUPvypSJQnIztDxZk+WUvjQ9B5gfTSacI3diXtZvkb6pQeIWYXl/WPDZ/dgVttL8RbIVS8ZLf9PxXNQkjxJI87dqbAvufr0KbBUkNIH7SFFGaTnDMLealhdKGIPma52xqILX7qJplYV0dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KF4dtobH; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KF4dtobH"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=oBr3Q35PYOX8KLcyP5TMvc9JdpscxzNbBR95ep2biiE=; b=KF4dtobHd1vxFyKHtfGmYLTnJu
	3geMPg49K4GbOBm2pLeLDxmdEyM8wxBYxMf0A6ZCUckskxQC8SObjg7eTENqRnD+xezhPXhoVYHt7
	BIa6qhmEz9fV+4iAUt8AtSB0mCb9bo/tn0/azePHbgZeoTb9n1epLw+QhwDJCzecaA/PCHoFKXcTX
	YzLAysAqb1fhfLjGJtAwfR99COhkmANTeVDCN0GV88kJod+UULBOqZjVdywdyIZq8Xtd7uUnlRtjW
	bHDeAxxeCqrp+xFeD2K166PKbV/B9nTwf9tEdMJHfR7IP0C7C7IqpVZ1OCAMaIrfuxbxcT6EvnVve
	YABkLQIw==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tp82C-0000000BqnG-2N01;
	Mon, 03 Mar 2025 15:48:48 +0000
Date: Mon, 3 Mar 2025 15:48:48 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Hannes Reinecke <hare@suse.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, Sagi Grimberg <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	linux-mm@kvack.org
Subject: Re: Kernel oops with 6.14 when enabling TLS
Message-ID: <Z8XPYNw4BSAWPAWT@casper.infradead.org>
References: <08c29e4b-2f71-4b6d-8046-27e407214d8c@suse.com>
 <509dd4d3-85e9-40b2-a967-8c937909a1bf@suse.com>
 <Z8W8OtJYFzr9OQac@casper.infradead.org>
 <Z8W_1l7lCFqMiwXV@casper.infradead.org>
 <15be2446-f096-45b9-aaf3-b371a694049d@suse.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15be2446-f096-45b9-aaf3-b371a694049d@suse.com>

On Mon, Mar 03, 2025 at 04:39:47PM +0100, Hannes Reinecke wrote:
> On 3/3/25 15:42, Matthew Wilcox wrote:
> > On Mon, Mar 03, 2025 at 02:27:06PM +0000, Matthew Wilcox wrote:
> > > We have a _lot_ of page types available.  We should mark large kmallocs
> > > as such.  I'll send a patch to do that.
> > 
> > Can you try this?  It should fix the crash, at least.  Not sure why the
> > frozen patch triggered it.
> 
> Still crashes:

It warns, but doesn't crash!  This is an improvement.

> [   63.658068] WARNING: CPU: 6 PID: 5216 at mm/slub.c:4720
> free_large_kmalloc+0x89/0xa0
> [   63.667728] RIP: 0010:free_large_kmalloc+0x89/0xa0
> [   63.842773] Call Trace:
> [   63.934398]  kfree+0x2a5/0x340
> [   63.987632]  nvmf_connect_admin_queue+0x105/0x1a0 [nvme_fabrics
> 18bfa9223bf0bd1ec571f5f45774adcc919a867e]
> [   63.987641]  nvme_tcp_start_queue+0x192/0x310 [nvme_tcp
> a0629454ac5200d03b72a09e4d2b1e27dfa113e9]
> [   63.987649]  nvme_tcp_setup_ctrl+0xf8/0x700 [nvme_tcp
> a0629454ac5200d03b72a09e4d2b1e27dfa113e9]
> [   64.043323]  nvme_tcp_create_ctrl+0x2e3/0x4d0 [nvme_tcp
> a0629454ac5200d03b72a09e4d2b1e27dfa113e9]
> [   64.043332]  nvmf_dev_write+0x323/0x3d0 [nvme_fabrics
> 18bfa9223bf0bd1ec571f5f45774adcc919a867e]
> [   64.043344]  vfs_write+0xd9/0x430
> [   64.108458] ---[ end trace 0000000000000000 ]---
> [   64.108461] page: refcount:0 mapcount:0 mapping:0000000000000000
> index:0x2 pfn:0x5e3a
> [   64.108465] flags: 0xfffffc0000000(node=0|zone=1|lastcpupid=0x1fffff)
> [   64.108469] raw: 000fffffc0000000 0000000000000000 fffb0b48c0178e90
> 0000000000000000
> [   64.108472] raw: 0000000000000002 0000000000000000 00000000ffffffff
> 0000000000000000
> [   64.108473] page dumped because: Not a kmalloc allocation

Right.  So you called kfree() on something that isn't currently
kmalloced memory.  Either it used to be kmalloced memory and we freed
the slab that it used to be in, or it's a wild pointer.  Whichever
it is, that's a bug in the caller, not in slab.

Why it bisected to that commit, I can't say.  Maybe it changed the
timing, or maybe it was just luck (whether the allocation which is now
being freed is the last allocation in the slab or not).

> [   66.084156] page: refcount:0 mapcount:0 mapping:0000000000000000
> index:0x0 pfn:0x5de5
> [   66.093770] flags: 0xfffffc0000000(node=0|zone=1|lastcpupid=0x1fffff)
> [   66.101810] raw: 000fffffc0000000 0000000000000000 dead000000000122
> 0000000000000000
> [   66.111311] raw: 0000000000000000 0000000000000000 00000000ffffffff
> 0000000000000000
> [   66.111314] page dumped because: Not a kmalloc allocation
> [   66.112001] page: refcount:0 mapcount:0 mapping:0000000000000000
> index:0xdc pfn:0x5de3
> [   66.137452] flags: 0xfffffc0000000(node=0|zone=1|lastcpupid=0x1fffff)
> [   66.137460] raw: 000fffffc0000000 ff45d9a24d93f420 ff45d9a24d93f420
> 0000000000000000
> [   66.137464] raw: 00000000000000dc 0000000000000000 00000000ffffffff
> 0000000000000000

It happened again ;-)

> [   66.137466] page dumped because: Not a kmalloc allocation
> [   66.138095] page: refcount:0 mapcount:0 mapping:0000000000000000
> index:0x0 pfn:0x5de5
> [   66.180944] flags: 0xfffffc0000000(node=0|zone=1|lastcpupid=0x1fffff)
> [   66.180950] raw: 000fffffc0000000 ff45d9a24da3f420 ff45d9a24da3f420
> 0000000000000000
> [   66.180953] raw: 0000000000000000 0000000000000000 00000000ffffffff
> 0000000000000000
> [   66.180954] page dumped because: Not a kmalloc allocation

And again ...

> [   66.181672] BUG: unable to handle page fault for address:
> ff40e4ea8fa50250

Oh, now it crashed.  But we have so much evidence of a bug in the caller
at this point that I don't think we can blame slab for falling over.
If you're double-freeing something that's _not_ in a freed slab, this
is the kind of thing we might expect?

You need to turn on the debugging options Vlastimil mentioned and try to
figure out what nvme is doing wrong.

