Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3632253FC
	for <linux-block@vger.kernel.org>; Tue,  3 Mar 2026 14:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772546898; cv=none; b=ol9aLFJuRx2ZtRAJx3FTd+3xfcA6PT9gnGf2NP/s8Xty6c6Idxq9WeNTKVHf6/BM5z4StBxKBbn/bjw79cjTPSJ+Ds4R2vxXqSo4Jc+Ic5rbxsWhOoxYTWHjyI0oFv8J07XdWW8VZof/9dO7ALZocLuDwayWQivwcJ7eJk5TAlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772546898; c=relaxed/simple;
	bh=KsEeR/1nxzj3je001SErtndg84IDnunGNBpGcdu89/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BbVsyYA1SyINt9x6wa7Jiz7u/kYnaGhCfPYipjwgtPUo2Com6ebtH7V3ijdao+zE2PWucCyLQLuupKkIMfxkTaMmyIwNQW4hsxxk+Gr/XB9hk+Jg8BwrFu/YmuZpqTLr/z8yA+K3z7B/XjfkHaawXoOrje7PCWtMUhIO5VlWR+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kdZSoPSd; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kdZSoPSd"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=AqDdNrJSR2I7Cjjt+y/8vXVu4FmccyulNifwIyrWjbI=; b=kdZSoPSdRtFqmyuf6s6ouCQ2Pj
	lTbGYJJEvVbk44j73F54ZU46x6Sgc8r9rInK24l4+mMrOHF1kp6hQGZ1E28j8pJYi73vWQW/idghn
	V/yioynJ/BAp07hdC5MwJhmmVW1amY0BQN0IsG9DR1E5vdm/+KhvhePlIthIXo0fldiANv/uCL8Jq
	5MFIz7b+usN6OVsirY8GfWQic7nRjgL987BvO1FvtYtx0S/Wl37HpenTWfiL5z7vos1HhE3a45kkZ
	EhrKD6vtbu3RiLn3R7U7tbWTv6ABo7xP+QZdWy+LwNf7jgfs6+aTt2s0sZbj0+wT5fia/duIe7RCZ
	U1LvyzTw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxQQ2-0000000FHxO-1sw1;
	Tue, 03 Mar 2026 14:08:14 +0000
Date: Tue, 3 Mar 2026 06:08:14 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Yang Xiuwei <yangxiuwei@kylinos.cn>
Cc: axboe@kernel.dk, tom.leiming@gmail.com, linux-block@vger.kernel.org
Subject: Re: [PATCH] block: fix page leak in bio_copy_kern when bio_add_page
 fails
Message-ID: <aabrTtw6WpPl3cvk@infradead.org>
References: <20260303072517.571437-1-yangxiuwei@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260303072517.571437-1-yangxiuwei@kylinos.cn>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Mar 03, 2026 at 03:25:17PM +0800, Yang Xiuwei wrote:
> When bio_add_page() fails in bio_copy_kern(), the allocated page
> is not freed before breaking the loop, leading to a memory leak.

bio_add_page can't fail here, as the bio is sized correctly using
blk_rq_map_bio_alloc.  So if you want to clean this up, please switch
to __bio_add_page instead of adding dead error handling code.

