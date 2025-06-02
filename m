Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44DBA2C327C
	for <linux-block@vger.kernel.org>; Mon,  2 Jun 2025 04:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748840337; cv=none; b=sZwZBGlbp9mP82H70fPtEf7/vk7MZq2FtR8FD1wae1ru9FLn63BtiP1lbzj92zvNy7FakelR/Awpay3Xe0nmhwGi5VP/2kmAoA8XzNiOI2M0R2QGZq4+kSDAHC2GVp/kpzfUoEic5gXLcGLpgIJdICW9nrH/0msakoa8kBESs+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748840337; c=relaxed/simple;
	bh=rMNBtxehxSTBZeA7meAYqElvRTffO6QUVbP3gIIZC3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H40NIq+Hz1zFivOO9JZcdOSXbuQb/u/UTvL7x9L0TG3TNsPNPSJ7axQoPsUTwfuixbx3Nqdb/TbCtqLq4NR6BlPjE3asMW4T+Al5Rv4N9AHr/qtN4EFd2Tx8zhPiet3ww/lD/a7esZEi3q1yiVv+3hziHYkQ1g6jkGqymrsU/a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DEDgFb0E; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DEDgFb0E"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=kxEvP93Wfl+81a5qScLy9c/kMrzau8pAQI/zcSNv4lE=; b=DEDgFb0EY0ewKUii8VVaI0SDeV
	WkVrExlWYED7ap6LJzQJGzqNv/6drn6fj5edHTLmPuFJUOKYQI0SQ004zf07dlb+S/+eXcXd7YF4z
	DNvSdqaaRFre+ytaiOiZroWEh1ras80XmPPhTumroEf4QWJc0VQqXHBegbd5+VLiVw4DaydCzM1lr
	yhj1CVQtPppeTZ00F9tRUs6Ba9nH+Uumi7MDbmgg9rr66c2mQ9TKw6nhCtUHWamH3OZdJVHQaY6Pl
	jMId7vJrPqfdQys4xLOyM54LbBHo7oZem6slLH6zgS7L0lwd1kDBdsd4HY/OCvip2vQfY5490NFAY
	Yx90tO1g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uLxGB-00000006iYQ-07d1;
	Mon, 02 Jun 2025 04:58:55 +0000
Date: Sun, 1 Jun 2025 21:58:55 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, Keith Busch <kbusch@meta.com>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	Mark Harmstone <maharmstone@fb.com>
Subject: Re: [PATCH 1/5] block: new sector copy api
Message-ID: <aD0vj0O-4P92Rkqx@infradead.org>
References: <20250521223107.709131-1-kbusch@meta.com>
 <20250521223107.709131-2-kbusch@meta.com>
 <aDBt1qXj90JO1y2v@infradead.org>
 <aDCqGLY4irp-6N5M@kbusch-mbp>
 <aDP5o1qb02iwgw-V@infradead.org>
 <aDX6NjOuGvxhbw7C@kbusch-mbp>
 <aDa_O4HGWjy_35I7@infradead.org>
 <aDeRNvT5x_qRj3kX@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aDeRNvT5x_qRj3kX@kbusch-mbp>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, May 28, 2025 at 04:41:58PM -0600, Keith Busch wrote:
> On Wed, May 28, 2025 at 12:46:03AM -0700, Christoph Hellwig wrote:
> > On Tue, May 27, 2025 at 11:45:26AM -0600, Keith Busch wrote:
> > > Just fyi, the initial user I was planning to target with the block
> > > layer's copy fallback isn't in kernel yet. Just an RFC at this moment on
> > > btrfs:
> > > 
> > >   https://lore.kernel.org/linux-btrfs/20250515163641.3449017-10-maharmstone@fb.com/
> > > 
> > > The blk-lib function could easily replace that patch's "do_copy()"
> > > without to much refactoring on the btrfs side.
> > 
> > Well, that code would be much better off using a long living buffer,
> > because the frequent allocations are worse.  
> 
> No argument against that. I'm just adding context for where this blk lib
> patch was targeted. I'm happy to help on both sides to make it more
> usable, though refactoring other block copy implementations (splice,
> kcopyd, xfs gc) to a common api looks like a much longer term project.

FYI, I'm happy to take care of XFS GC, but I don't think we need any
library code for that.  And I doubt any other async implementation would
share much code besides the low-level helpers.

So the question is if there are many potential users of sync helpers.
Maybe the answer is no and we should just not bother with that code for
now and only add it when/if it actually starts sharing code?

