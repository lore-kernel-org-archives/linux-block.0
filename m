Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A083C1F
	for <linux-block@vger.kernel.org>; Fri, 23 May 2025 14:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748008966; cv=none; b=LWytPmqlbjzsDwRp4t+24dzBHJtf3tOHrYHrZi9l0UWJRxDj1dv0BIphAvm0QzJomwbyIREJyN+pw335kSuxaYIQv4YJ/dhYtkdz3zrqPImx25ywcDQDLxQBDM33JHteWfQcO6TzD/UbjsnvkYrqujvxDXO+DdOEKszcfDT/xeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748008966; c=relaxed/simple;
	bh=zYeNz87nV+qW3bHWoW9jgirD78uPTQosVGPtLMs8r6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DTeNJHpxZZ8NAoYXi3uDG9bJIpQv6jcJiO+dVuclWkgxuRU7xCvrJ1SeTo4x6utWHrjxZDkoVlU3nh86I/fdlakd1i5qGKFhVCaO3/KzaDNBRuhwMgtl160y4OqYLYN6MUSfnPm67TtcQlKHUGHjnqdwgVmRnl1lM/NZkgWB7bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=f9OC9/VO; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="f9OC9/VO"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Y1LgnuGdwEgioTvPhAVNNhp4orxAU/cHH/seSfn+ygQ=; b=f9OC9/VOatRWeG7Ub04kttgY+4
	nvRLU744xZWWYz9KVfW9cbj0TCJkrrOqn2pUrpLjXjNtGf0ZI69WhuWXBG0roNzVpk0n2fHcjQZNN
	psSIMgu3VomRKQ2VE7AT89iUrtQFeJNgd85XM1xJ2Fse2KwwP61/ceVhBP1DHalNX0OBghVIq8CC6
	iGdfQ11jyImQWuNvyvNOIgwHFRk48qNYuq6ynMoo5sfsJhSc9YppN+C6LUauLrqGRqrmaQ8o8tY1F
	vWHIjZiEdRCOPCMVzKen0Z2H6Od2IHqzMlPMmYi6AQH3yl/+P2BE0Dx3XHAxYwRHXYW52HLqJJzqM
	lNEYP/OQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uISyy-000000042O5-0qml;
	Fri, 23 May 2025 14:02:44 +0000
Date: Fri, 23 May 2025 07:02:44 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, Keith Busch <kbusch@meta.com>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 5/5] nvmet: implement copy support for bdev backed target
Message-ID: <aDCABK5Nzxvtrocz@infradead.org>
References: <20250521223107.709131-1-kbusch@meta.com>
 <20250521223107.709131-6-kbusch@meta.com>
 <aDB1p8XIhsauGFhc@infradead.org>
 <aDB_mIZ5YUG32sHx@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aDB_mIZ5YUG32sHx@kbusch-mbp>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, May 23, 2025 at 08:00:56AM -0600, Keith Busch wrote:
> On Fri, May 23, 2025 at 06:18:31AM -0700, Christoph Hellwig wrote:
> > I need this additional bit so that the host code actually see the
> > copy support:
> 
> Thanks! I think it just needs to be constrained to bdev backed targets
> since I don't have file support for copy offload here. And less
> important, but for spec compliance, I need to update the Command Effects
> Log too.

A file backend should be pretty trivial using vfs_copy_file_range.
On reflink-enabled file systems it might end up beeing to fast to
be useful, though :)
