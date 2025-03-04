Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602E5259C89;
	Tue,  4 Mar 2025 16:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741104924; cv=none; b=OyS9l8vkagoB4xgdIoBIzRVidBc+pH0Aba0DIwzZWijhWlb1969mvgQqgBTaDt7XSr6ewsPMYNQ2Md04YzV7Xy9Fukzz1X4cNWxT/Z3cpkPaz1wSVnFD97uf5eTYuWLr+g72pt5hI6yeAd58xRxwBkS0z2AKIV+MBDmV9/kah9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741104924; c=relaxed/simple;
	bh=lQ4+10D0t0Q8TuYC/AyuEbU8Fo9fE1QT4c/FV1EckiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i0kGjniu55SQYu5ilQrzQZLCsBaxfykJPoODR9V1VbnQ6mY/Ug3PQyhe0uEYetQ/5UUpFpfyPZAlJth2TaLro/h7c3V1P/8VMBCCaQUnggieLiWPHSOSdX3ejvJnrJ+fkMIQiZ4VDeh7OI6E57KS/6b+Px8fjSrCZAg7tb7QgfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ioDwsSDp; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ioDwsSDp"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=pL43Quyb0ICgUXShUhHF7YtI0r/6haqOAOyn/xgv5nc=; b=ioDwsSDpQ9ByKM98PVFr7qaGNi
	ST5mF0gVx3oPZQTPM8RRnZZYPYhFxl3wf4Hgbb74Siu4a4vSM6QrDDYg5hbNVVvD2YUhnjQHQSRjU
	+qBTBt6+RTbgRd2HTeeiOB526g0wagPsMbvr30E5ehADsnEgtxqK4aS0jx0QnL0fbQbHDPaiwe/cH
	5Q5mo2PH0cYQTIpj0ZUi1FjKqsiz4qD0TC9lxltij7tHfMbcPlXDV/5q1xyAoMaiSlB3KsT5qAHrW
	4TBYXuHmZxYTU57sjC3Cz2/z4B4u6ZQA5New8VCPd9h6mAWZsRGe7ihZ46UaHmXsuQXzo+DTAa2xp
	PvQJsBeQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tpUub-00000001h5s-2rJd;
	Tue, 04 Mar 2025 16:14:30 +0000
Date: Tue, 4 Mar 2025 16:14:29 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Hannes Reinecke <hare@suse.com>, Boris Pismenny <borisp@nvidia.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	linux-mm@kvack.org, Harry Yoo <harry.yoo@oracle.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: Kernel oops with 6.14 when enabling TLS
Message-ID: <Z8cm5bVJsbskj4kC@casper.infradead.org>
References: <Z8W8OtJYFzr9OQac@casper.infradead.org>
 <Z8W_1l7lCFqMiwXV@casper.infradead.org>
 <15be2446-f096-45b9-aaf3-b371a694049d@suse.com>
 <Z8XPYNw4BSAWPAWT@casper.infradead.org>
 <edf65d4e-90f0-4b12-b04f-35e97974a36f@suse.cz>
 <95b0b93b-3b27-4482-8965-01963cc8beb8@suse.cz>
 <fcfa11c6-2738-4a2e-baa8-09fa8f79cbf3@suse.de>
 <a466b577-6156-4501-9756-1e9960aa4891@suse.cz>
 <6877dfb1-9f44-4023-bb6d-e7530d03e33c@suse.com>
 <db1a4681-1882-4e0a-b96f-a793e8fffb56@suse.cz>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db1a4681-1882-4e0a-b96f-a793e8fffb56@suse.cz>

On Tue, Mar 04, 2025 at 11:26:07AM +0100, Vlastimil Babka wrote:
> +Cc NETWORKING [TLS] maintainers and netdev for input, thanks.
> 
> The full error is here:
> https://lore.kernel.org/all/fcfa11c6-2738-4a2e-baa8-09fa8f79cbf3@suse.de/
> 
> On 3/4/25 11:20, Hannes Reinecke wrote:
> > On 3/4/25 09:18, Vlastimil Babka wrote:
> >> On 3/4/25 08:58, Hannes Reinecke wrote:
> >>> On 3/3/25 23:02, Vlastimil Babka wrote:
> >>>> Also make sure you have CONFIG_DEBUG_VM please.
> >>>>
> >>> Here you go:
> >>>
> >>> [  134.506802] page: refcount:0 mapcount:0 mapping:0000000000000000
> >>> index:0x0 pfn:0x101ef8
> >>> [  134.509253] head: order:3 mapcount:0 entire_mapcount:0
> >>> nr_pages_mapped:0 pincount:0
> >>> [  134.511594] flags:
> >>> 0x17ffffc0000040(head|node=0|zone=2|lastcpupid=0x1fffff)
> >>> [  134.513556] page_type: f5(slab)
> >>> [  134.513563] raw: 0017ffffc0000040 ffff888100041b00 ffffea0004a90810
> >>> ffff8881000402f0
> >>> [  134.513568] raw: 0000000000000000 00000000000a000a 00000000f5000000
> >>> 0000000000000000
> >>> [  134.513572] head: 0017ffffc0000040 ffff888100041b00 ffffea0004a90810
> >>> ffff8881000402f0
> >>> [  134.513575] head: 0000000000000000 00000000000a000a 00000000f5000000
> >>> 0000000000000000
> >>> [  134.513579] head: 0017ffffc0000003 ffffea000407be01 ffffffffffffffff
> >>> 0000000000000000
> >>> [  134.513583] head: 0000000000000008 0000000000000000 00000000ffffffff
> >>> 0000000000000000
> >>> [  134.513585] page dumped because: VM_BUG_ON_FOLIO(((unsigned int)
> >>> folio_ref_count(folio) + 127u <= 127u))
> >>> [  134.513615] ------------[ cut here ]------------
> >>> [  134.529822] kernel BUG at ./include/linux/mm.h:1455!
> >> 
> >> Yeah, just as I suspected, folio_get() says the refcount is 0.

... and it has a page_type of f5 (slab)

> >>> [  134.554509] Call Trace:
> >>> [  134.580282]  iov_iter_get_pages2+0x19/0x30
> >> 
> >> Presumably that's __iov_iter_get_pages_alloc() doing get_page() either in
> >> the " if (iov_iter_is_bvec(i)) " branch or via iter_folioq_get_pages()?

It's the bvec path:

                iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, &bvec, 1, len);

> >> Which doesn't work for a sub-size kmalloc() from a slab folio, which after
> >> the frozen refcount conversion no longer supports get_page().
> >> 
> >> The question is if this is a mistake specific for this path that's easy to
> >> fix or there are more paths that do this. At the very least the pinning of
> >> page through a kmalloc() allocation from it is useless - the object itself
> >> has to be kfree()'d and that would never happen through a put_page()
> >> reaching zero.
> >> 
> > Looks like a specific mistake.
> > tls_sw is the only user of sk_msg_zerocopy_from_iter()
> > (which is calling into __iov_iter_get_pages_alloc()).
> > 
> > And, more to the point, tls_sw messes up iov pacing coming in from
> > the upper layers.
> > So even if the upper layers send individual iovs (where each iov might
> > contain different allocation types), tls_sw is packing them together 
> > into full records. So it might end up with iovs having _different_ 
> > allocations.
> > Which would explain why we only see it with TLS, but not with normal
> > connections.

I thought we'd done all the work needed to get rid of these pointless
refcount bumps.  Turns out that's only on the block side (eg commit
e4cc64657bec).  So what does networking need in order to understand
that some iovecs do not need to mess with the refcount?
