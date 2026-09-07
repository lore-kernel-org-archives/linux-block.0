Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0025371D01;
	Mon,  7 Sep 2026 06:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788761896; cv=none; b=q9zqQn27y2kqclPjeV6J9dRzRUGPto2m4Gl8NzuxeHwHaKCMeVNNtBPag7IMXf9597R1a1AX0VTB/N78XUAYPizX5bzWrO0TPsdnUf1bKKizXr9iYJbrm7vrFwFlV394XSIOV5RNFRel/X08RRxrgHPo5ZIlm/JqXAX2ukfPoRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788761896; c=relaxed/simple;
	bh=0so6kgAvo9UK3Y3fCoiQSEZVNReplFAqRkuYwFuaECI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QEhIb3QaCyQ+Mzm+glqenvu1yHGBo89Uuoctezz7rBXS7JPDAfbRrC23XSsz/PbM8owU1POfhM/U18BaM1gr3d1YoD8dy16uHKbBzQWun9d1T/23IDnVXGgXErMdfiFPJaZyki+Vgc/VVt9qc0Ro3oTsWlbe6qMkbjF0N+guD6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4C80868D05; Mon,  7 Sep 2026 08:18:10 +0200 (CEST)
Date: Mon, 7 Sep 2026 08:18:10 +0200
From: Christoph Hellwig <hch@lst.de>
To: David Howells <dhowells@redhat.com>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Paulo Alcantara <pc@manguebit.org>, netfs@lists.linux.dev,
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] block: Fix start and length check added to
 iov_iter_extract_bvecs()
Message-ID: <20260907061810.GB32231@lst.de>
References: <apsP3Hvlw-fpd6uF@kbusch-mbp> <20260902112743.GA11999@lst.de> <1819786.1787768317@warthog.procyon.org.uk> <1895550.1787777192@warthog.procyon.org.uk> <350212.1788514937@warthog.procyon.org.uk> <1183138.1788625600@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1183138.1788625600@warthog.procyon.org.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Sat, Sep 05, 2026 at 05:26:40PM +0100, David Howells wrote:
> Keith Busch <kbusch@kernel.org> wrote:
> 
> > If a block device behind an RDMA NIC really wants to DMA a single byte
> > at a time, we can't describe that capability today. That would require a
> > 0 mask, which is currently treated as "unset" and overridden with a
> > default 512b mask.
> 
> The thing is, Christoph said:
> 
>     Massage __bio_iov_iter_get_pages so that it doesn't need the bio, and
>     move it to lib/iov_iter.c so that it can be used by block code for
>     other things than filling a bio and by other subsystems like netfs.
> 
> but unless it can have a 1-byte alignment, it's not actually much use for
> netfslib (I have to be able to support "unbuffered writes", which are almost
> exactly like DIO writes but without alignment restrictions).
> 
> Do block devices really need an aligned "start memory address" or just an
> aligned "start file position" (whatever that means for a blockdev).

The file position is totally irrelevant, the memory address, or in case
of IOMMUs the IOVA (which keeps the lower bits of the offset aligned)
matter.  Most hardware, bother storage and networking (and lots of
others) require at least 4-byte aka DWORD alignment.  But if we
want to support event less, we'll need to adjust the interface, which
shouldn't be too horrible.

> 
> David
---end quoted text---
