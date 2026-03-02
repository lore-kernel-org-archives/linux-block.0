Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD3E3FB044;
	Mon,  2 Mar 2026 13:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772459459; cv=none; b=Yngj8z98VLgATK+6fZj6HDPZLPQwKKnLwb5rVGPXlQbZCv3soppSdjwPir4qVtqC9HMI3FPZ9NRLBBLYUYGJZihLyhNI4hDFCIWaZIzChqJWpokEqUN+zGyHgDPB1+QKQv6plvtyv0wM+QJgV7IS4Gqk7/bTUfzhMT2uRARNQKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772459459; c=relaxed/simple;
	bh=VHSK6YEGNyCIoVPW5pjqYIC45ahxdFqh2C/pBfplUAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YB3oLnfEXF172zImZ8c5Eev83cN8wkD3PeBACDDFob09OZXFBBla6LcBckzmjU0qRMtECO2HM5G7ohbOs0vphT1dh8ahw6OVZxY8BD/kiB/CiQh9TRug5jO7UXaRgpMQ2ywuXR2KTmmu7FdkiuPnipr3adsjDzPkWZ+NNL6U06A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=t9FoqLVN; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="t9FoqLVN"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=0mxOV7omutuRZu2xaV3AtdtQohZwv5xm8F7gjTBJ59Q=; b=t9FoqLVNqtepR+hrSxb7DbRRW/
	ZEx/KAh3QPrXU9qH4AEFUMbbhSfoCIIS39yTzAfwZMdnXRn14QDzmT4c7ioUu7OdAJpPYhFIe/b7K
	4vy0fepxNw5kD67v7lgefavzXh0P0JjwKevMmcIkjXVfUWYlEZ55VH8qlUaF8/yZ+3YkbVx1Txz3m
	PFqH98KUC8WqrfNY7ItimnKHUm+G//woU6ICgtGA5R/mZIrwRK2F8ubn0L2uXBW+r6HR878wlftM6
	AmFx+g+vGqMyrWQjLlLHmK9kGab2HHHITzv6WnBN2ABtm4/SzBBGC4gJ3YqdTbW8/O4i/+CWuXYdR
	wjYc74hw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vx3fk-0000000DA78-1MN6;
	Mon, 02 Mar 2026 13:50:56 +0000
Date: Mon, 2 Mar 2026 05:50:56 -0800
From: Christoph Hellwig <hch@infradead.org>
To: jiucheng.xu@amlogic.com
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, jianxin.pan@amlogic.com,
	tuan.zhang@amlogic.com, Gao Xiang <xiang@kernel.org>,
	linux-erofs@lists.ozlabs.org
Subject: Re: [PATCH] block: avoild hang when bio_list is non-NULL in
 submit_bio_wait()
Message-ID: <aaWVwH_Xna22DTAq@infradead.org>
References: <20260302-for-next-v1-1-eb9339e8dc99@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260302-for-next-v1-1-eb9339e8dc99@amlogic.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Mar 02, 2026 at 10:51:03AM +0800, Jiucheng Xu via B4 Relay wrote:
> From: Jiucheng Xu <jiucheng.xu@amlogic.com>
> 
> When current->bio_list is non-NULL in submit_bio_wait(),
> submit_bio_noacct_nocheck appends bio to bio_list but skips IO
> submission, causing submit_bio_wait() to hang indefinitely.
> 
> Fix this by temporarily backup bio_list, setting bio_list to
> NULL before calling submit_bio(), then restoring bio_list
> after submit_bio() returns.

No.  Fix this by not doing something that is a bad idea.

> I've trimmed down the call stack, as follows:
> 
> f2fs_submit_read_io
>   submit_bio
>     mmc_blk_mq_recovery
>       z_erofs_endio
>         vm_map_ram

->bi_end_io code really should not be having random in_atomic()
checks that make it completely different, but even if they have
that need to use GFP_NOIO.

