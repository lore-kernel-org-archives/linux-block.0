Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED181DDC33;
	Mon, 15 Dec 2025 06:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765781957; cv=none; b=jYP+uNe1thCE7utZYiYeIhT74kzmWeOfWcmJTOB2zq13RciqjfQCnRufs0uIT8N6L/rmakOVCR70pZRmYmNMYajlgdfIPHzDkxQjTrDRvLRtu5Rhx+txGPQOA/eppectvjwkn2R3g4++5PUObi+n9hDz82NY0gvcrHkYHlbcf44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765781957; c=relaxed/simple;
	bh=pftUfUULzPZ9GsBY/fjgHAq8AvUe5Ys25wSUqJUcki0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fc7AGeG1Tw69RlWihh8ybhYWYQAycRr6Q6LoJv/4krOzgd/VTPQjv3FdEtxqj0EW39r1rhuEo84rhLbjbSuhUCt3j2IvUGlAwVscGLxXADd4OJbpgQMhWEdStDRgVrqNJrZPuLDLF8a7mkNzYtzzlYv0PwfAoO5gC6eB61EYALE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=4BSHxxje; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="4BSHxxje"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=vwJMnZv4O2KS7JbGg+hlCsT0qlO0aGhYisR4zAG21iE=; b=4BSHxxjevVg68YdWTxLIftGPsI
	+MtOLp/rV2x4zbcffQzZlIR1ecP/uUvPeieNIix7+kkuPW5UdfBdrxJtK3YGVYgMF9hZ+k8w05CEg
	AtGtdAbOxSBhxd2XhlauoGfES+Itb7wcQ36hZ6QC8NH4iKfuCn/qksV99tx6DSiRwCJBd1Jt+nEn9
	603+ZF3ed2zGOr8udl5BIACij1QDa+MCX8THUpSHI6m0oYKu4zAe99nuRQcNykW9zpyagojcmt1Rh
	P33ssYJ88Q3BNwt0zcQX7oFA4lmOjaXdhMDcOrQdmyNogdVZOlgFGjsonwSeqGWS9QQxzXpsiOhor
	R6VCv9jw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vV2Y3-00000003Az8-2YW5;
	Mon, 15 Dec 2025 06:59:11 +0000
Date: Sun, 14 Dec 2025 22:59:11 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Johannes Weiner <hannes@cmpxchg.org>, Jens Axboe <axboe@kernel.dk>
Cc: Deepanshu Kartikey <kartikey406@gmail.com>, akpm@linux-foundation.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: retiring laptop_mode? was Re: [PATCH] mm: vmscan: always allow
 writeback during memcg reclaim
Message-ID: <aT-xv1BNYabnZB_n@infradead.org>
References: <20251213083639.364539-1-kartikey406@gmail.com>
 <20251215041200.GB905277@cmpxchg.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251215041200.GB905277@cmpxchg.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Sun, Dec 14, 2025 at 11:12:00PM -0500, Johannes Weiner wrote:
> That reasoning doesn't make sense to me. Reclaim is always in response
> to an allocation need. The laptop_mode idea applies to cgroup reclaim
> as much as any other reclaim.
> 
> Now obviously all of this is pretty dated. Reclaim doesn't do
> filesystem writes anymore, and I'm not sure there are a whole lot of
> laptops with rotational drives left, either. Also I doubt anybody is
> still using zone_reclaim_mode (which is where the may_unmap is from).

Yeah.  I wonder if we should retire laptop_mode.  It was a cute hack
back then, but it has it's ugly fingers in way to many places and
should be mostly obsolete by how writeback works these days.

