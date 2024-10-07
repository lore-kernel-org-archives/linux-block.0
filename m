Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6091442F3
	for <linux-block@vger.kernel.org>; Mon,  7 Oct 2024 06:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728281404; cv=none; b=FtPG+I/PDshJvYvvDa/UA7xlrf/3mKD57aGpMBCHPuaUyzXuRaABNw34l4pN6e3LPZws3T1Sjaia9PCoqPABa0553o6YI35tMI0qIj86okcHWYFIZP4EQY4zZ/WXl0gwaTZVkrK39Sf26OwhKn2pRot1AVT2VBINYULH/VlqjgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728281404; c=relaxed/simple;
	bh=3asrwxWL5qgkCGSWb4Nb+OCAcLe4Eb2okS4KiFHFclY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rkHUWIYHnvbRU7buySBap3Kndc+bbKXNurnS9Thlb9H87DMPbPjTJkwDipV6n/mktpWV20e/iVRnuyrnR/pe/RbuDUT8AVAKrhv7fU9eGkd21eWKB+AZOVhLz+TxqHk9q5kcFoR+8XL6tnPFgkyScwBOJXGgAscv1bHXV9ALuwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QATf1f43; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QATf1f43"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=OE2e/koAiN70ZSr/qpRMrFplUoQJfOoAGeA5DyeJzYc=; b=QATf1f438e7TYCSumpA7jJaz/w
	4L3B1R5fpLXZ7uPgXoFVmbw+j1LDCln1rk+gVIC/xWfpjh5rHSW/zadNSnv+8N0wSRGZCp1O51+h/
	518T9NvNVNXDBfoFE6M6UCFw42sQp5reXfm3HaSHfttBbzlWI8Snt49FpmEehlbhOqbBnpwcskNLF
	oCIvLtL9N5jhxwQAciaaREXzI1jfwRXufvoNNjfGKUiJmd4NPV29W3fdyHCeuUc4bep05Ill+ZAy8
	hiai/+eAVbdBRXWN73+xuXeez6qlIDWOYPL9oml1ryRzcBWXDrJeHR2ZSLDtHCggVOYwTGT/nhvao
	lxNNJ0mg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sxgwT-00000001NUp-17qd;
	Mon, 07 Oct 2024 06:10:01 +0000
Date: Sun, 6 Oct 2024 23:10:01 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, Yang Yang <yang.yang@vivo.com>
Subject: Re: block: del_gendisk() vs blk_queue_enter() race condition
Message-ID: <ZwN7OTXW3uDBbo--@infradead.org>
References: <20241003085610.GK11458@google.com>
 <Zv6d1Iy18wKvliLm@infradead.org>
 <Zv6fbloZRg2xQ1Jf@infradead.org>
 <20241003140051.GM11458@google.com>
 <20241003141709.GN11458@google.com>
 <20241004042127.GO11458@google.com>
 <Zv-O9tldIzPfD8ju@infradead.org>
 <20241004074818.GP11458@google.com>
 <Zv_ddkAZhjC9OQyo@infradead.org>
 <20241004143234.GR11458@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241004143234.GR11458@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Oct 04, 2024 at 11:32:34PM +0900, Sergey Senozhatsky wrote:
> Hmm, setting QUEUE_FLAG_DYING unconditionally in __blk_mark_disk_dead()
> implies moving it up, to the very top of del_gendisk(), before the first
> time we grab ->open_mutex, because that's the issue that we are having.
> Does this sound like re-introducing the previous deadlock scenario (the
> one you pointed at previously) because of that "don't acquire ->open_mutex
> after freezing the queue" thing?

So the trace of that one is literally the same as the one you reported,
and I'm still wondering how they are related (I hope Yang Yang can
chime in).  I suspect that if we mark both the disk and queue dead
early that will error out everything and should fix it.

That would also avoid the issue with your patch in the next reply that
would skip marking the disk dead when calling blk_mark_disk_dead.

(BTW, we really need to write a big fat comment explaining how we ended
up with whatever is the final fix here for the next person touching the
code)
