Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA4E5C96
	for <linux-block@vger.kernel.org>; Wed, 28 May 2025 07:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748418371; cv=none; b=CQ/Y8YojCD9rGQrDtino2Vmrm1V1PKVS0BgzhOSAiXQk+wTToHVC80rzaro2jQTwySMAomZepSY/JtmZ6No0oQq3bg+IA8X6Dy6Jzjk81+LMW6sQ7P+G7n1PUCpTBGqKO81S8NXibJ8UB3T+Lb9WcXF2W+sTXX69Zn3fpu/zCSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748418371; c=relaxed/simple;
	bh=qOKrNuMta20CrWb3GcALVhjSVVlc2YmU1C5INDgHKW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dp5K/eUQfMjYLMDZfZfDf/cpIw6l8hA0HeYL4VTp7aQ4DBKrlyWVCY+PlapwErtAsIRm2lNAvANx5vEKP1mf7CbFAAWOSLg+Z5JWw/Cc6LWSZ627JfEOW2nnaqGc9RV8iSllLnpqHJIW57TgyzImIpHz038eK2MRJ+ehl94Tk48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=04QGgMve; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="04QGgMve"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=o/VdYcODh0fa0SIBn/lhS7SE19ATz1ug168wcXxFUPY=; b=04QGgMveDFp9IawpSYXmxu9Zq5
	TnHKRlg9VXoHb9iuEOKgVqlRJf5OqBqNwmKJ0UMQdgJ5DGuvGKpey1vdz/znMesAA0X6WBPf1SzP9
	ZIvlb2S8AL0HhLKT3bJ3ZDbb9lUnC4XAdSXAuUXhoOlBWLzgRthKp3ADvfLT0/iGZD1zn7yrlIvYC
	pU89LSDTjzWVjXYhtA/eLMN5aod+MqK4M/Bz8vtKasj2nmsQGvQ2VRnU8VKKkpWKb3ypDgjSRrAqD
	47LoyVA+DiL5PJF3eFKc8QAKILl5bRnYP0IVe+kz3EvwCyCmFkqTixo0ixUkk9/mz8JMo91JTkKli
	vahjug+g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKBUB-0000000CSzm-2e8O;
	Wed, 28 May 2025 07:46:03 +0000
Date: Wed, 28 May 2025 00:46:03 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, Keith Busch <kbusch@meta.com>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	Mark Harmstone <maharmstone@fb.com>
Subject: Re: [PATCH 1/5] block: new sector copy api
Message-ID: <aDa_O4HGWjy_35I7@infradead.org>
References: <20250521223107.709131-1-kbusch@meta.com>
 <20250521223107.709131-2-kbusch@meta.com>
 <aDBt1qXj90JO1y2v@infradead.org>
 <aDCqGLY4irp-6N5M@kbusch-mbp>
 <aDP5o1qb02iwgw-V@infradead.org>
 <aDX6NjOuGvxhbw7C@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aDX6NjOuGvxhbw7C@kbusch-mbp>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, May 27, 2025 at 11:45:26AM -0600, Keith Busch wrote:
> Just fyi, the initial user I was planning to target with the block
> layer's copy fallback isn't in kernel yet. Just an RFC at this moment on
> btrfs:
> 
>   https://lore.kernel.org/linux-btrfs/20250515163641.3449017-10-maharmstone@fb.com/
> 
> The blk-lib function could easily replace that patch's "do_copy()"
> without to much refactoring on the btrfs side.

Well, that code would be much better off using a long living buffer,
because the frequent allocations are worse.  Also from talking to a btrfs
guys sitting next to me at least the classic relocation can actually be
in the normal write path, so you probably also don't want it to fail
because a large memory allocation fails.

What we did for the GC code in XFS that exists to basically do the same
is to do a large allocation at mount time, and then just keep reusing
it.
