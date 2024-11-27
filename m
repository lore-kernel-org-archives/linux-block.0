Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C6F1428E3
	for <linux-block@vger.kernel.org>; Wed, 27 Nov 2024 08:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732697900; cv=none; b=iCk96bL86YUNOxy5tuS7iVXj8noBUhkNUc5ZaIZZ/aqYBISeiiK0n56sVYvasfgRXJ03MRjWmG5DxvLm5N7Ds1cFpKlLZbBXTEignhwPE4CY5ElHVIrA0Yzwe4B9wxnkztQGS0G7waJ4jnm18lj/vI1+7oZ/EbQOaTqvGdNwAaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732697900; c=relaxed/simple;
	bh=O8+qBlE7KhCrg42uRd1cUkGrcI0N8ceJmqPIdmfACBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dTj/pc49Dla9Kq2r3AMBF8EyTiIY/gOAAC/rv+SbMQ8AxU8ugKyjCBvMP5REF3UyMd7VVDpvErFaWRS6+Lbm247VGCR7txJmrzDwsgVcDN8pGtW60BIaMskYmIGkm0XP6l24BaZ1sT5EtJDz+DphbR74wRPuixbDqt8z8b4iRWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=4gIOaUVw; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="4gIOaUVw"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=jDO/34NVahss5JTO+7lRc01FhxQ+rUDD12wE+haUVTU=; b=4gIOaUVwDlzO4ffZRWJ/2z6kGO
	kiETci+sZHzi+wCEoXmDLMp4b85enpmAXIhbupdSQZSK5mfQ8dtqXgwl37cbuHt0JxrD/bjLFmEGi
	4IRYOGrsp5Bx7tfLvcYkowR0s2lMnSz0n9twuWxltkgscSBcN+VvBMF8MhxZaUQjtJrqNcTEy9w27
	H+pvwTYStoKYM5ZSWucfoZBHFQNVK6OkZSLHE4jO8EhUrQUpEkpo1kXqw+5uZksbcFx0rQpl4GswO
	fRYy1pvQNRsw7Je5ZMwXvyH39o+trYTpwjjj1w3Z/Wva3KdOS+dW1hMfhaNvGRPEp7JN2D5ss33BX
	Gvrs++tg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tGDsG-0000000Cdl6-2r0y;
	Wed, 27 Nov 2024 08:58:16 +0000
Date: Wed, 27 Nov 2024 00:58:16 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	linux-block@vger.kernel.org
Subject: Re: [blktests] zbd/012: Test requeuing of zoned writes and queue
 freezing
Message-ID: <Z0bfKNMKhLkEHusz@infradead.org>
References: <12c5ee53-dcc6-4c78-b027-8c861e147540@kernel.org>
 <Z0a5Mjqhrvw6DxyM@infradead.org>
 <Z0a6ehUQ0tqPPsfn@infradead.org>
 <73fb6bae-a265-43c3-a362-3cece4b42bbe@kernel.org>
 <Z0a9SGalQ5Sypfpf@infradead.org>
 <9d224032-254f-4b4a-a667-d1538cdbf0dc@kernel.org>
 <Z0bAHKD-j49ILtgv@infradead.org>
 <52570aad-c191-4717-b91d-a555d9dfda96@kernel.org>
 <Z0bIDopTmAaE_nxQ@infradead.org>
 <0e2dc18f-d84e-4dcf-a5c2-134d579c480c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e2dc18f-d84e-4dcf-a5c2-134d579c480c@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Nov 27, 2024 at 05:17:08PM +0900, Damien Le Moal wrote:
> After all these fixes, the last remaining problem is the zone write
> plug error recovery issuing a report zone which can block if a queue 
> freeze was initiated.
>
> That can prevent forward progress and hang the freeze caller. I do not
> see any way to avoid that report zones. I think this could be fixed with
> a magic BLK_MQ_REQ_INTERNAL flag passed to blk_mq_alloc_request() and
> propagated to blk_queue_enter() to forcefully take a queue usage counter
> reference even if a queue freeze was started. That would ensure forward
> progress (i.e. scsi_execute_cmd() or the NVMe equivalent would not block
> forever). Need to think more about that.

You are talking about disk_zone_wplug_handle_error here, right?

We should not issue a report zones to a frozen queue, as that would
bypass the freezing protection.  I suspect the right thing is to
simply defer the error recovery action until after the queue is
unfrozen.

I wonder if the separate error work handler should go away, instead
blk_zone_wplug_bio_work should always check for an error first
and in that case do the report zones.  And blk_zone_wplug_handle_write
would always defer to the work queue if there was an error.

