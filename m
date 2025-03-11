Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29ABB360
	for <linux-block@vger.kernel.org>; Tue, 11 Mar 2025 07:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741679931; cv=none; b=ECQuJvly70lyWrbu3MkCCGAlyEL7mRDyl8hpoMx6HQ4fbo+Izq9bOataPLcW57NTbG2jinCos19jIIrMV0zViWNKuGKE6mhIRSXMu+jnBSRSfoQSKV0MyCATvB8MkYS3mAL3A2xNpaC8W7CkfjOAxGF3xLeKExuc3jPSV2hGWow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741679931; c=relaxed/simple;
	bh=AmEwo1VTXhVisGJHrSaQnJqkALwStYDfzWwIWQnt4Zk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OEoBWvBgr3ce9dRoq4PZVCQtG3Ysw0evg2U0lCjP0QwgTdsaIELnkU8YaRAW5lFIGkZCmOpeLojGu/OVi8y84grwe152q9XMXCeWfUn9B6A05Kwtm5knai6rEVqlmMjsN+mu70uO8MpcDpgsGERDIDqt1LonIe+OdAPCIKj3D8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dwl2x4iw; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dwl2x4iw"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=lejIdlyEw/yqGzPZasEzxOhboO5bRC0c6ddv/zfxaLw=; b=dwl2x4iwqwclWhYZno7g6FC82R
	RSbEndgF2lf9MviqIUJ31h65CVEBtuaKTzA/h43Lll2WQAAbu7Em1ItGGpAhdIbrfH1ksqz63vIpG
	Gib3Fez+JkewyggPEBVDdOapeJ+WRkdsuXu6v+ZvVO6gqty4oCKECEcpZ3tGjzUX/fe2H+YgU2s90
	ZUr+iaSh8vWehENMHzHkXpGX0E9bI7gY6v7U1Cfuoh3hOYc3mplvpmMhXnlYjIC6KEt6ygU+qG3RB
	8EVQLcYM9yumNvSUpZ+F2tKDkzpe5ugaFOnb/wTb0I6enCZ3CHM++YdWhMxmz+nXhYss0/o2HO8Us
	d8zTApXw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1truVi-00000004vSE-2WKF;
	Tue, 11 Mar 2025 07:58:46 +0000
Date: Tue, 11 Mar 2025 00:58:46 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Subject: Re: [RESEND PATCH 4/5] loop: try to handle loop aio command via
 NOWAIT IO first
Message-ID: <Z8_tNiQOYeKSDt24@infradead.org>
References: <20250308162312.1640828-1-ming.lei@redhat.com>
 <20250308162312.1640828-5-ming.lei@redhat.com>
 <Z87JpLwpw-Fc2bkJ@infradead.org>
 <Z8-SzXD3tq7SKiiq@fedora>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8-SzXD3tq7SKiiq@fedora>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Mar 11, 2025 at 09:33:01AM +0800, Ming Lei wrote:
> On Mon, Mar 10, 2025 at 12:14:44PM +0100, Christoph Hellwig wrote:
> > On Sun, Mar 09, 2025 at 12:23:08AM +0800, Ming Lei wrote:
> > > Try to handle loop aio command via NOWAIT IO first, then we can avoid to
> > > queue the aio command into workqueue.
> > > 
> > > Fallback to workqueue in case of -EAGAIN.
> > > 
> > > BLK_MQ_F_BLOCKING has to be set for calling into .read_iter() or
> > > .write_iter() which might sleep even though it is NOWAIT.
> > 
> > This needs performance numbers (or other reasons) justifying the
> > change, especially as BLK_MQ_F_BLOCKING is a bit of an overhead.
> 
> The difference is just rcu_read_lock() vs. srcu_read_lock(), and not

Not, it also includes offloading to kblockd in more cases.

>
>
> see any difference in typical fio workload on loop device, and the gain
> is pretty obvious, bandwidth is increased by > 4X in aio workloads:
> 
> https://lore.kernel.org/linux-block/f7c9d956-2b9b-8bb4-aa49-d57323fc8eb0@redhat.com/T/#md3a6154218cb6619d8af5432cf2dd3a4a7a3dcc6

Please document that in the commit log.

> > > +	if (cmd->ret == -EAGAIN) {
> > > +		struct loop_device *lo = rq->q->queuedata;
> > > +
> > > +		loop_queue_work(lo, cmd);
> > > +		return;
> > > +	}
> > 
> > This looks like the wrong place for the rety, as -EAGAIN can only come from
> > the submissions path.  i.e. we should never make it to the full completion
> > path for that case.
> 
> That is not true, at least for XFS:

Your trace sees lo_rw_aio_complete called from the block layer
splitting called from loop, I see nothing about XFS there.  But yes,
this shows the issue discussed last week in the iomap IOCB_NOWAIT
thread.

