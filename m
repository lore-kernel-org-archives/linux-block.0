Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2920F33C53F;
	Mon, 25 May 2026 06:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779689241; cv=none; b=rNfVCBi9fmF7hJ4QCEhUabnIyQlo0iMnZNROzyiyrkwS9w3xz0kZOds1CJQAA8P0xh0kCP5JZJWvWlPsZMY6Y8yLm5lWq9wYzxQmGk1RzQsP2VjQJkTYsZWOH+8YJtfB/LvZojmLLzBxI0Euw9agZ8lWzmFiUD/tlq4etnu3058=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779689241; c=relaxed/simple;
	bh=Ya1OJ+yKLTt4EDXqoLFOyih7TJemskbPI6WpUF/PezI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WIROFJR+Frqd81LoILvQFjfTOnw6yXsaSsOYGDfSh8LMZvn/zk9KMbwb2qc86it/rcdXvCxIA7caYvQR5KoSPq+GGTaHhBdy7dR5SfAXYtFtTOQylFHixf5jRw921z3HcX5SRg22ARSEaUhgSMKrfyDreMYazLlBf/TAvonx9Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=s6ueCnRO; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="s6ueCnRO"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=7UFWfStPoSp/07uf7f90uucqtuvqX9e2FjqUHyUPDoE=; b=s6ueCnROOEFYLblo8HL/tmUoxb
	4aG6/j6BOnKn0glOAWF0tf2fQ1r19Y3uHpiWDp+DHmxIGbcYJ5HOsLloTlsM6FQRVURX6e2HHM0JU
	wog71NTwQplqfF7p2TVar6i4WMtoBHZgKR3lbYXUQRTowCfEGs/fmnH1xj19S7grwyl6/2NRZ7s1h
	1Jbk/hhCu1Iuv5rUPIwXzSwjvJpwDMepBG0skkHLJFNNO9Ck/xLAg4tp14IUu0gJ9us2uMIuNi8pi
	sU8nguaz6QMd3Vkwma5/arU6ASqgBoQR5tpbd0ZLK/NnwmHoKVrOVRcWLGLOT7iXoDbLRkjUGe81f
	SlLJLH2Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wROT8-0000000GNug-1zAi;
	Mon, 25 May 2026 06:07:18 +0000
Date: Sun, 24 May 2026 23:07:18 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Denis Arefev <arefev@swemel.ru>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] block: Avoid mounting the bdev pseudo-filesystem in
 userspace
Message-ID: <ahPnFlvUqq0JC2vy@infradead.org>
References: <20260521072857.5078-1-arefev@swemel.ru>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260521072857.5078-1-arefev@swemel.ru>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, May 21, 2026 at 10:28:56AM +0300, Denis Arefev wrote:
> The bdev pseudo-filesystem is an internal kernel filesystem with which
> userspace should not interfere. Unregister it so that userspace cannot
> even attempt to mount it.
> 
> This fixes a bug [1] that occurs when attempting to access files,
> because the system call move_mount() uses pointers declared in the
> inode_operations structure, which for the bdev pseudo-filesystem
> are always equal to 0. `inode->i_op = &empty_iops;`

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

