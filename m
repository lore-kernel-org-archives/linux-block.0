Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7BA26059D;
	Tue, 16 Dec 2025 07:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765870877; cv=none; b=KjVGHuWncch0qz28LNlSsPP6qlTexoccZt8ZskTcq4zytwKm08tPswfEGyyoxy5Kvuex9ImRyF27J4zYsWS+9KonFP8+jZ7emuHSslXKeAZg62oFPNWSfZSKzRJ45r4hiYZ3bCUbQrkYlPxARlHVSrZJVedloQdTRtYgkSAOhCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765870877; c=relaxed/simple;
	bh=38XhwejL3a59cUoAN8EnCl+oZQBKXOfpFIF3AUqDER8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O3LFH7vxQqQbLlkKVcjzDBqPR9ryFYMpPJrYeck7/gDOlCbE0+VNdnT2rAionhPlP0Xyo6LN0dhPbN1VlOvaglnqdL3eM23Y56CtLVmJ7E2bIzL8jDL9W0/YA+7EIeXdS3JuG9AWNpgmp7mP+p7rAsnqPCAbrFXo3R8iC61qx/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=A2mK+WJB; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="A2mK+WJB"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Ef+/dRUWrEoAF52eKGXOIPSj0Dz2pVFYZysJHDl8loo=; b=A2mK+WJB1oecfFaavv+XJXaRX0
	AZPTOoctOvi4Gvp/7+MBhe0545EF01s9ezgAvVJrVMwMKr0r6J5CJT+KxXCjdaBygRs26XIY9DG+i
	sZUqDwdFhh/XN0UkLIFWzBOzx6/IAul46/gKDVeCcUNqTwAUlDIGr/0j/Pnasj/6gCX98Fi4vtYSu
	KLCIk7hoWkKkfeOvPzaPS5RVBORjxGxrbTygdh+4VGcttF6PocJPx2Hzw6jLQPOjDo68hAyzq7Z3l
	WewsU6+iL0MP3mfZ3/Fs3c7YTip1pxfYjpOv/yBE+vKz8kiIjaNzbRFSaJnND2YZw/y82MLVrrwkm
	inJHBApA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vVPgB-00000004s5V-0YDj;
	Tue, 16 Dec 2025 07:41:07 +0000
Date: Mon, 15 Dec 2025 23:41:07 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: retiring laptop_mode? was Re: [PATCH] mm: vmscan: always allow
 writeback during memcg reclaim
Message-ID: <aUENEydFvVvxZK8r@infradead.org>
References: <20251213083639.364539-1-kartikey406@gmail.com>
 <20251215041200.GB905277@cmpxchg.org>
 <aT-xv1BNYabnZB_n@infradead.org>
 <20251215200838.GC905277@cmpxchg.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251215200838.GC905277@cmpxchg.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Dec 15, 2025 at 03:08:38PM -0500, Johannes Weiner wrote:
> Debated whether to add some sort of deprecation sysctl handler, but at
> least systemd-sysctl just prints a warning and still applies other
> settings from the same config file.

In general dropping sysctl will break things.  So I think we'll need
a stub, at which point it might as well warn for a while.

> Laptop mode was introduced to save battery, by delaying and
> consolidating writes and maximize the time rotating hard drives
> wouldn't have to spin. Needless to say, this is a scenario of the
> (in)glorious past.

Maybe expand on this a bit by mentioning that reclaim now never does
file system writeback, and fs writeback is already very lumpy by
design.  And of cours that hard disk with their high spinup latency
and extra power draw are a thing of the past in laptops or other mobile
devices.

Otherwise this looks good to me.
