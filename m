Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68AD62AD04
	for <linux-block@vger.kernel.org>; Mon, 21 Jul 2025 06:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753079229; cv=none; b=VlBUWVfdBAV70PKr3MaDMbhYyIiKtvPpQgjm19BdJoKJdBBJP0xgER4mlI0t7oBiqQH5Fh7MBWB801qn9iha0/l0/MQ1PBsB6VpAK1sFHAYTJlAEUZXMrLMAab/D/hmzigPytOY0vjlLK+kscI8CTDl8C6tqqMqdScSFiEg81x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753079229; c=relaxed/simple;
	bh=xnJIK+A9EUI7xpncRk5Qo9c3QrUoG4jaDMqWwOWTON4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cRLBhY3K44QCzJLSxufB7LGkAec/kTGYAbQlvmFC6W+cDWULF/VZbeDQeWiO973Oaq4uzaKrGh7Zjp7KZBy7tVeMgL3vmJP9tH+oQ4awDLF+FkslhaMe3UZCKh2fCxDJFRpyAHOhtHQPcQffbhLQ8UJwxeM18KQMtRIg3H/EQYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Hd+RBPuD; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Hd+RBPuD"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=xnJIK+A9EUI7xpncRk5Qo9c3QrUoG4jaDMqWwOWTON4=; b=Hd+RBPuDJT2FVA+jmjOPxpXd3/
	Iw3JKnOGyEHVro1X/fWUpEe0G7hIJmFV2vsMDbcrU7JTU0Ego3qAWQNBFVvmsB9CM3MFPvVygIOdI
	RjIgtIszEFWfpICFNK7/5wzoILnhfkRygYAFqfyBPFhh0Iwr0tU7fl10RdIux3+n0CY9XsLQnz7dG
	Uwn2x5169sTSOr6qva6VARAmcdRJN4QwuxTPqpTPoLyF5PM1t188lkCrnTCkRtZNMEGCI1n+91Od+
	6Wy/rqgOB0fsQnST4lFYdPMhTo52EL3+2pJCVtu8hQhfmVG5zGk2OYpx87M/kguMdLKEtiUP+El8J
	79S53K3g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1udjzO-0000000GMfv-1SOg;
	Mon, 21 Jul 2025 06:27:06 +0000
Date: Sun, 20 Jul 2025 23:27:06 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [RFC][PATCHES] convert ->getgeo() from block_device of partition
 to gendisk
Message-ID: <aH3dukc8bOhfvpvv@infradead.org>
References: <20250718192642.GE2580412@ZenIV>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250718192642.GE2580412@ZenIV>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

The whole series looks fine to me:

Reviewed-by: Christoph Hellwig <hch@lst.de>

