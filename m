Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B468337BE88
	for <linux-block@vger.kernel.org>; Mon,  9 Feb 2026 14:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770649064; cv=none; b=VUi+TO+LrWJuXoX75dMHS3dj5/qh4zsaCb01qDx3QlQcap0ianYew8abU4furhlk82Yzqr6lidl/yfroq28D/Opq3k4Ca6y84T9S9rarChnAfr7i0o5VFI6XvRE3D3tIkHf2H6fLPtJ4+CLt1T356YMtZ0li8nzBd+nUGeUhZv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770649064; c=relaxed/simple;
	bh=ysoqak9V07z7wX36C6y07eqv4cEjrkhKq4kLwDrvnfE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ONsMghKz/Q2N/YOk5AVmwvEckcZ1LBhv+ZaWa5Apgptl8WJqR0+Fq6Ysl1Psmz29FgW8Or178NePWac2A+Uy3VRWLcDMlnMoaGMLVl9n3mpk4KdpAPZIiCesSuvqciWSpJ+i7dVBnvpIiprgMT3PJ3TnP/aJHGG23fhUVNnviqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 444A168CFE; Mon,  9 Feb 2026 15:57:42 +0100 (CET)
Date: Mon, 9 Feb 2026 15:57:41 +0100
From: Christoph Hellwig <hch@lst.de>
To: Yu Kuai <yukuai@fnnas.com>
Cc: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
	sven@kernel.org, j@jannau.net, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, tj@kernel.org, nilay@linux.ibm.com,
	ming.lei@redhat.com, neal@gompa.dev, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/4] nvme-tcp: move blk_mq_update_nr_hw_queues after
 nvme_unfreeze
Message-ID: <20260209145741.GB18315@lst.de>
References: <20260209082953.3053721-1-yukuai@fnnas.com> <20260209082953.3053721-3-yukuai@fnnas.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260209082953.3053721-3-yukuai@fnnas.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Feb 09, 2026 at 04:29:51PM +0800, Yu Kuai wrote:
> blk_mq_update_nr_hw_queues() freezes and unfreezes queues internally.
> When the queue is already frozen before this call, the freeze depth
> becomes 2. The internal unfreeze only decrements it to 1, leaving the
> queue still frozen when debugfs_create_files() is called.
> 
> This triggers WARN_ON_ONCE(q->mq_freeze_depth != 0) in
> debugfs_create_files() and risks deadlock.
> 
> Fix this by moving nvme_unfreeze() before blk_mq_update_nr_hw_queues()
> so the queue is unfrozen before the call, allowing the internal
> freeze/unfreeze to work correctly.

Same comment as for rdma, otherwise:

Reviewed-by: Christoph Hellwig <hch@lst.de>

