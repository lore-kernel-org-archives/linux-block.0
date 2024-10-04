Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E231B4D8C6
	for <linux-block@vger.kernel.org>; Fri,  4 Oct 2024 06:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728024313; cv=none; b=qvWSeZIgrWx0JIdrXaXuo0m08zXSaqmKBXNp4xBInzETJqq0hhj1TK4LlzfmY6YeKdhBD5nQNDqWC6HKIMw7miATHz0E2k/NUT1tmGrNNv/pa8GwutHUhCDuce3o1b/u0VbzW3Whz1Kp4MYzepJ2qN/muywONil17mykF4+tT60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728024313; c=relaxed/simple;
	bh=7L0cCai+hv1kyvo6agqACPpUErw1LhTrp8ceTVeZtvw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kgMkXmWzUlH/gsv7JgQVS3HSufuraiVaB+KAX6xg0D8Ag7oKc+pul8Wzu1YXW5GF13URLgq6U9uDXa3BofOk3Nus7xLEsVGPz4VxtgSx2MsYRcU0V/NsRTYhGGL8NdnfyAzDDWosEKdz0a5Sq0WK/X8skp2QbuD5cgV/XaUNKJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=494DybeQ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="494DybeQ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=sBDcvM4H5vQGBFRyqF2CSKmgC4ot6V+X0gZBu1hycKE=; b=494DybeQwGQSfgXMf+BzLG1S7/
	745pnwkZQ+0t0w7/EDFw5x+W45fqITdp66kTYJiGTXqWN6iKGr+CfBJWpt+qTAg/pJlcM6GWYf+51
	GHWBIxywSAeLgwLdF9Oy0n30VcxZReC7jEEBCZwecjeG6Z2CX7EOuPqsz2Ef00yb3EmF8sQ7YIWy/
	FkH4Tt6C2uveawbv1laoDsfgIlCz5hq8V9Z0Ct04pk5dW42/U+/sJS4ng3G/V0jbVf2WgpzBKnH8R
	g6upeRr/YgkbFGcL8qLV/A4N22Hp64md550S95K75VE6FfHtPGcot2V6blxcLNMWUKgKhfc3TcSh3
	6m8Z6oVQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1swc3q-0000000B9tU-0FAz;
	Fri, 04 Oct 2024 06:45:10 +0000
Date: Thu, 3 Oct 2024 23:45:10 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, Yang Yang <yang.yang@vivo.com>
Subject: Re: block: del_gendisk() vs blk_queue_enter() race condition
Message-ID: <Zv-O9tldIzPfD8ju@infradead.org>
References: <20241003085610.GK11458@google.com>
 <Zv6d1Iy18wKvliLm@infradead.org>
 <Zv6fbloZRg2xQ1Jf@infradead.org>
 <20241003140051.GM11458@google.com>
 <20241003141709.GN11458@google.com>
 <20241004042127.GO11458@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241004042127.GO11458@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Oct 04, 2024 at 01:21:27PM +0900, Sergey Senozhatsky wrote:
> Dunno. Is something like this completely silly?

__blk_mark_disk_dead got moved into the lock by: 7e04da2dc701 
("block: fix deadlock between sd_remove & sd_release"), which has a trace
that looks very similar to the one your reported.

And that commit also points out something I missed - we do not set
QUEUE_FLAG_DYING here because the gendisk does not own the queue for
SCSI.  Because of that allocating the request in sd/sr will not fail, and
it will deadlock.

So I think the short term fix is to also fail passthrough request here -
either by clearing and resurrecting QUEUE_FLAG_DYING or by also checking
q->disk for GD_DEAD if it exists.  Both of these are a bit ugly because
they will fail passthrough through /dev/sg during the removal which is
unexpected (although probably not happening for usual workloads).

The proper fix would be to split the freezing mechanism for file system
vs passthrough I/O, but that's going to be a huge change.

