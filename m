Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B1D19B3ED
	for <linux-block@vger.kernel.org>; Thu,  3 Oct 2024 13:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727962583; cv=none; b=jy5db8VwhdRhDM/bHfKERvKhDCHKKFBakqK3ZrqowqQteklTD3qePWN5Jw1FeF4+DvSVKfVYYmUIwy68V7dm7AddifN7wgfwHB4t2Aanw8/AFLNEWWn2L98v9lBpYXnXFD4ybuR1UlaAuKznqWEPxMHmzA/bU20sLTMSWo3z5aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727962583; c=relaxed/simple;
	bh=g5xg2YAZye4MtfdHpyk2pZG21dmsYSeSLOkKolcpwok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K3juWmiF2gcW/toYbR3KdgEN1lEiG5H/bNG2dWa9C0Iw4JSTLD5kCUwxVWYGOngQQd9ch5K9tUlXKiYlb4H0RJTeF0HB//OeaauqhGXPvZSxAJO+cWzXtX+kCZZyJO2qdpvQjYr9Q7fy/lYtoxvD+7RDR0menHqSo4u/36vdBok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=btIvhXLP; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="btIvhXLP"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=SLUux5438BVARFQ+isOzOOj5pWr+R8mv3JNdFEpBmb8=; b=btIvhXLPs4xQ7b/RTkj+cpKop2
	MLNZTc1OiaG7fgramITH65JrO6GJvUFOPO9jAe4XhLg+FaQUA3GyLI1F765ZmHyKvypfYN45+WKc6
	QnPkuUas4LPZOPtp0/fcBGpB5AK+99Sz+RbzkYFCtCJA9D3q6w9/aIaOtFYVonboM9mfM4GKjDULq
	pl7cGO2b4yJQbjvbLwtsduU/UqMhqFzI8FtiXfslBTyBuhiZ3MsYOPtM1NddD5pzL0wB2kdoxkTuW
	8FV7gXtijV3ywRKr9KaC2Q092g3pKQB4Hionehz5dp9ojGF/OG8kDTV24BdvQP3j48b9gOhVwa34o
	j/g3FAjw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1swM0C-00000009DhN-0nMU;
	Thu, 03 Oct 2024 13:36:20 +0000
Date: Thu, 3 Oct 2024 06:36:20 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: block: del_gendisk() vs blk_queue_enter() race condition
Message-ID: <Zv6d1Iy18wKvliLm@infradead.org>
References: <20241003085610.GK11458@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241003085610.GK11458@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Oct 03, 2024 at 05:56:10PM +0900, Sergey Senozhatsky wrote:
> blk_queue_enter() sleeps forever, under ->open_mutex, there is no
> way for it to be woken up and to detect blk_queue_dying().  del_gendisk()
> sleeps forever because it attempts to grab ->open_mutex before it calls
> __blk_mark_disk_dead(), which would mark the queue QUEUE_FLAG_DYING and
> wake up ->mq_freeze_wq (which is blk_queue_enter() in this case).
> 
> I wonder how to fix it.  My current "patch" is to set QUEUE_FLAG_DYING
> and "kick" ->mq_freeze_wq early on in del_gendisk(), before it attempts
> to grab ->open_mutex for the first time.

We split blk_queue_enter further to distinguish between file system
requests and passthrough ones.

The file system request should be using bio_queue_enter, which only
checks GD_DEAD, instead of QUEUE_FLAG_DYING.  Passthrough requests like
the cdrom door lock are using blk_queue_enter that checks QUEUE_FLAG_DYING
which only gets set in blk_mq_destroy_queue.

So AFAICS your trace should not happen with the current kernel, but
probably could happen with older stable version unless I'm missing
something.  What kernel version did you see this on?

