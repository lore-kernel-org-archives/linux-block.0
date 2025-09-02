Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33EBA2DAFB8
	for <linux-block@vger.kernel.org>; Tue,  2 Sep 2025 14:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756825065; cv=none; b=eU07G2IaFKbnte+nZ8PUbPIlJXld0/Jnu30ZCkqsS4YjF79W7VyT8ahenZyJV5bCdPkZ7iBYjFTySPdUYdbRmzOKvttd9/65e/qcNZy5Hf97gAIQNs0JGbkW8SJXrTmeJlXugYi73WBKy9BEuy58a1u83lT47Qkpsm9h6P6qEPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756825065; c=relaxed/simple;
	bh=ffW3f6G8GTh9+GY4dZadiSebboE7pBfqZFq/9rOMOMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dEOBbDEihnb+9GIsyCyj5ujVshoHAnaIOp8wJrmQ0tV131xwFmK2s5T/Xf00ZQLQaBurtDIQLFXjpnaky6wApYznWFaol4hhygDV83QyxJ90o7AzdNgj+9LK9RB3n8FHngpjAQOqSMW6sJHp3ba5O/4PlmOupo5TTmuf7PxObFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PYg399Zh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PYg399Zh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49D35C4CEED;
	Tue,  2 Sep 2025 14:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756825064;
	bh=ffW3f6G8GTh9+GY4dZadiSebboE7pBfqZFq/9rOMOMo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PYg399Zhxgi3s4CNzOtESV3U4to38XhkK0QmKm+uTDp/cTg0pZIvtYflE/3fM/0sX
	 TUciH2e4vgBVJe0b1YJPJ9+UdtP8+0J+5lhpYVjE1nUIVtAyyN055krDsB2B+gJgqF
	 7S/wjaH0diJbxy2AcZ6zzhQ6it2yWgEMUw0E4aUH5uzqdPOY6pie7cJpKhilmjSxlS
	 koioY5JoYYfpyOUo3SHHZuXzxj67SMSGLQwf5KrRQbtfSv5z6/+bZIofP9QV2Ht7Ps
	 OJ1GJ8sVEQIu0tobCwYaWvvNW0tEAMhygnM+eyFBEz2vmix/gGbxZZNV59LCUgTMwY
	 GsrBkQsA8o/ig==
Date: Tue, 2 Sep 2025 17:57:40 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, axboe@kernel.dk,
	martin.petersen@oracle.com, jgg@nvidia.com
Subject: Re: [PATCH 2/2] blk-mq-dma: bring back p2p request flags
Message-ID: <20250902145740.GJ10073@unreal>
References: <20250829142307.3769873-1-kbusch@meta.com>
 <20250829142307.3769873-3-kbusch@meta.com>
 <20250902053358.GB11204@lst.de>
 <aLcBA-Z8yZ44t4ZK@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLcBA-Z8yZ44t4ZK@kbusch-mbp>

On Tue, Sep 02, 2025 at 08:36:51AM -0600, Keith Busch wrote:
> On Tue, Sep 02, 2025 at 07:33:58AM +0200, Christoph Hellwig wrote:
> > On Fri, Aug 29, 2025 at 07:23:07AM -0700, Keith Busch wrote:
> > > From: Keith Busch <kbusch@kernel.org>
> > > 
> > > We only need to consider data and metadata dma mapping types separately.
> > > The request and bio integrity payload have enough flag bits to
> > > internally track the mapping type for each. Add flags for these so the
> > > caller doesn't need to track them, and provide separete request and
> > > integrity helpers to the common code for unmpaping. This will make it
> > > easier to scale as new mappings are added without burdening the caller
> > > to track such things.
> > 
> > We are actually about to run out of REQ_* bits with the current
> > encoding.  We could shrink the space for REQ_OP_ a bit to create
> > more, or try to move some flags out into BIO_ flags (like
> > REQ_ALLOC_CACHE) or kill them by looking at pointers instead
> > (REQ_INTEGRITY), or by overlaying flags that can't be used with
> > the same of (REQ_FUA vs REQ_RAHEAD vs REQ_UNMAP for example).
> > And maybe we can come up with a more coherent scheme for
> > REQ_PRIO / REQ_BACKGROUND / REQ_SWAP and maybe REQ_IDLE that create
> > another priority scheme in addition to the I/O priorities.
>  
> Sure, but can we do that effort separately from this? I'm mainly trying
> to align with Leon's DMA series that adds REQ_MMIO so that we won't have
> flag conflicts.

Christoph,

In addition, let's make sure that functionality is correct and working right.

REQ_* cleanup can be perfect followup series for someone who understands
semantics around these bits.

Thanks
