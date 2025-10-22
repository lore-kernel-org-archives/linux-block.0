Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0893D1AC88A
	for <linux-block@vger.kernel.org>; Wed, 22 Oct 2025 04:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761108394; cv=none; b=izkHyX3trY7cVZwYlAcTvKd9jEDJvUxtMSQkB+lmwE8Qqxkvo4zMvaPoSkIZh1XfeodUQayAh4PRT2MKyo6pACRa07pehB+jNYLyCjRdEIKQAJQSFqjt+jW+rMAip+72cbsP7pNbvhTwHQCuYVGmgxspKY+L4GqTjDQWd2eaWlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761108394; c=relaxed/simple;
	bh=QQdiwRiIwDMGy3DHVtQk3eKRB9KC1XO7PYGiIllHLKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PjM814Szfsa0WCY6OowKfrfXoNQUBs3Axn7KOo26QvZpNo7Q3dSr+0o5KSfTecv13AF8TD7lgQlkvYaxoUKietZ59x9vxEbyq+xQbcXTxPBZtlvEwQWswQqNufVVhRlKfcuyyibfoYzDqZ05KBLppFtIMGuihmfc0235B5ydjLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=tSbpcj1c; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tSbpcj1c"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=IHUeLNroghw3/fxK2QjdS8bHXtrT/TpYzcUC3yBxoy4=; b=tSbpcj1cjpsJkEf/SIDET9RVOh
	tqhAm054rIbBiygb2QR/iLPojeZ4f0o3biNZt43E5P0Y8RlnZYgm/UJcDLYq4bofmyXszskQsUcQ9
	cDWVeT04L0GOryJi4fQqP0FvAznCntevcIuvBXUmNXvE5btB5nZVkLYUAVFqBUK7Le7d7nRIXE2k3
	lhgL44wJaSD2pOzf6gbmOdEk+qDPGbtsYScQNYwxQLA6hp5xpkQN9R3iaoHoKK+fW6LJRuoXWABFM
	Ask+79/7GLxWuOgDBhCBaW/JAodN0BcjNA5eZNBV9GFIH/cZTQrteDyTmR0C72UsZM/Ja4S2H0PPW
	GqiVzlIA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBQk2-00000001T6Z-0qhG;
	Wed, 22 Oct 2025 04:46:30 +0000
Date: Tue, 21 Oct 2025 21:46:30 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, Keith Busch <kbusch@meta.com>,
	linux-block@vger.kernel.org, shinichiro.kawasaki@wdc.com
Subject: Re: [PATCH blktests] create a test for direct io offsets
Message-ID: <aPhhpohu8mc95oLp@infradead.org>
References: <20251014205420.941424-1-kbusch@meta.com>
 <aPIk3Ng8JXs-3Pye@infradead.org>
 <aPZhWIokZf0K-Ma9@kbusch-mbp>
 <aPcZ6ZnAGVwgK1DO@infradead.org>
 <aPf5gAOlnJtVUV6E@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPf5gAOlnJtVUV6E@kbusch-mbp>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Oct 21, 2025 at 03:22:08PM -0600, Keith Busch wrote:
> On Mon, Oct 20, 2025 at 10:28:09PM -0700, Christoph Hellwig wrote:
> > seems like a huge win.  Any chance you could try to get this done ASAP
> > so that we could make the interface fully discoverable before 6.18 is
> > released?
> 
> I just want to make sure I am aligned to what you have in mind. Is this
> something like this what you're looking for? This reports the kernel's
> ability to handle a dio with memory that is discontiguous for a single
> device "sector", and reports the virtual gap requirements.

So, I think Christian really did not want more random stuff in statx,
which would lead to using fsxattr instead.

Question:  Should we event advertize virt_boundary based unaligned
segment support?  It is almost impossible to use correctly unless I'm
missing something, so the better idea might be to just not offer the
value when using PRPs?

> +	if (request_mask & STATX_DIO_VIRT_SPLIT) {
> +		stat->dio_virt_boundary_mask = queue_virt_boundary(
> +								bdev->bd_queue);

Consumer code like file systems, or the bdev fake file system should
never see the queue (and yes, I realize the atomic code just below got
this wrong as well).  Please either add a bdev_virt_boundary wrapper,
or use bdev_limit and just access the limits directly.

> +	if (bdev_max_segments(bdev) > 1)
> +		stat->attributes |= STATX_ATTR_DIO_VEC_SPLIT;
> +	stat->attributes_mask |= STATX_ATTR_DIO_VEC_SPLIT;

> +	if (request_mask & STATX_DIO_VIRT_SPLIT) {
> +		struct block_device *bdev = inode->i_sb->s_bdev;
> +
> +		stat->dio_virt_boundary_mask = queue_virt_boundary(bdev->bd_queue);
> +		stat->result_mask |= STATX_DIO_VIRT_SPLIT;
> +	}

> +static void
> +xfs_report_dio_split(
> +	struct xfs_inode	*ip,
> +	struct kstat		*stat)
> +{
> +	struct xfs_buftarg	*target = xfs_inode_buftarg(ip);
> +	struct block_device	*bdev = target->bt_bdev;
> +
> +	stat->dio_virt_boundary_mask = queue_virt_boundary(bdev->bd_queue);
> +	stat->result_mask |= STATX_DIO_VIRT_SPLIT;
> +}
> +

Why does the bdev set different flags from the file system?  Shouldn't
the capabilities be the same?  And we'll probably want a little helper
to set these based on the bdev instead of opencoding the logic in
multiple places.

