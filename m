Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890041DE8B5
	for <linux-block@vger.kernel.org>; Tue,  8 Oct 2024 08:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728375220; cv=none; b=Y8dw6RX8z+Q2hginIBlXx+SNs14ULFX9OYxO9K3/DS3fKzYoQQr9TeA/bdLPvakpTYdhEURiwjPdEwwMAXUbjU/dj0dLjT8ypZ+GqabR/wzliDdQIa1eZ2dB+szOI7XNmi5GfBjTg1PrWTR5TMgSaa5F7ktXJGYUxubP17ywbDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728375220; c=relaxed/simple;
	bh=BNEQbvWlwjdYg1DJPC5sLb7tD6faaitpJwxiNk6nobM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FGv18dH1L+3zYFOCHJ3rEUnZ5CUKonllgGSrU6XxoARqg6kzR+cABz7mzxqficB4eggp7OBs4NsHaZmpUp/e8R0hhOdlUOOkobRrz9GM2jCcFCts0x723DYHetRehGZ81zYvBwbhhbZd4RnjBUK5G9s7oHtV13SV+yimWefXuHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=zBBe11U4; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="zBBe11U4"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=mAc8KEVP8bysQFliBAytg9tuEQ2dHMxmx+D1kgWuSc4=; b=zBBe11U4uqbkfR44yviU2aplS/
	ZzlK0XolCg4hn/zlW0bqmJNxQCSqgkm1JBsVrOd45lKW1odpn0acADyqyaRoXYktY06bR9A8t7mXu
	zob1bAGX89SYiUPQzYi1fDASmyd/dWK+jExE7VaGpMx4U6bxtb1EeWbfz6gKe0EFHFP0wO5BhpX64
	dllUp17HyIHLa99Z+p1UftOx7OTIyXQPfsFIIhPL4tKn7f3jTyaCxxQm6pas1BydE9FAUiHlPOAU7
	fHYD07X9l7kDmG4fYLFTt4K6JMq75lAKkohUYla7BtEXtZmxRAzDw4LNYAS+fJKhKpUz/XBloifxc
	veDx8wlg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sy5LZ-00000004xyr-02Y9;
	Tue, 08 Oct 2024 08:13:33 +0000
Date: Tue, 8 Oct 2024 01:13:32 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Christoph Hellwig <hch@infradead.org>, YangYang <yang.yang@vivo.com>,
	linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: block: del_gendisk() vs blk_queue_enter() race condition
Message-ID: <ZwTprM-QVvMQX3Eo@infradead.org>
References: <20241003085610.GK11458@google.com>
 <b3690d1b-3c4f-4ec0-9d74-e09addc322ff@vivo.com>
 <20241008051948.GB10794@google.com>
 <20241008052617.GC10794@google.com>
 <ZwTJj5__g-4K8Hjz@infradead.org>
 <20241008061053.GE10794@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241008061053.GE10794@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Oct 08, 2024 at 03:10:53PM +0900, Sergey Senozhatsky wrote:
> cd->lock still falls a victim of
> "blk_queue_enter() and blk_queue_start_drain() are both called under ->open_mutex"
> thingy, which seems like a primary problem here.  No matter why
> blk_queue_enter() sleeps, draining under ->open_mutex, given that what we
> want to drain can hold ->open_mutex, sometimes isn't going to drain.

Yes. So I think we'll need to move __blk_mark_disk_dead out
of ->open_mutex again, it also isn't protected when calling
blk_mark_disk_dead, but we'll also need to stop the SCSI LLDs from
submitting new commands from their ->relase routines.   Let me cook up
a little series..

