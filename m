Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA52130AF6;
	Wed, 23 Oct 2024 12:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729686081; cv=none; b=qVsou6qOpYFLPgIHPLTOMUUajAXAfUc/shL1IYahbXF8CrsjyFv2YvMQt43KBQZJH7jwCiFPw/zfQXori2i36knJ60joGsB0DoXsVgoYt8tqqW3YBtFaK0vmmJEo/imDSPY4+xN18vQnCsBG+SSbkdVDp3yBtsVGxLH/JQdYcdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729686081; c=relaxed/simple;
	bh=upf4EcJxdV3izx1EMdFgcDZBrnbGIKzYn/ysL33tdFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pwHWQSFDhSwWwwd1Vw1yo69zn8j5mUdvZDkZhLyv9NgiZuEPirmHCmAVL3bv9BS3vuUi9ZwG8M8XTEE4bGZJ4S0s6o2NKFFz2v214Tnwbzd/Z1fdNblkGphVVcGWOS18Rwqux81nU9MMMF4FRw5hz9zqs2Zwm2+f/gMhZ6fcCRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7A5C1227A88; Wed, 23 Oct 2024 14:21:15 +0200 (CEST)
Date: Wed, 23 Oct 2024 14:21:15 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH 2/3] nvme: core: switch to non_owner variant of
 start_freeze/unfreeze queue
Message-ID: <20241023122115.GB28777@lst.de>
References: <20241023095438.3451156-1-ming.lei@redhat.com> <20241023095438.3451156-3-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241023095438.3451156-3-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Oct 23, 2024 at 05:54:34PM +0800, Ming Lei wrote:
> @@ -4913,7 +4913,7 @@ void nvme_start_freeze(struct nvme_ctrl *ctrl)
>  	set_bit(NVME_CTRL_FROZEN, &ctrl->flags);
>  	srcu_idx = srcu_read_lock(&ctrl->srcu);
>  	list_for_each_entry_rcu(ns, &ctrl->namespaces, list)
> -		blk_freeze_queue_start(ns->queue);
> +		blk_freeze_queue_start_non_owner(ns->queue);

Maybe throw in a comment like:

/*
 * Will be unfrozen at I/O completion time when called by
 * nvme_passthru_start.
 */

so that it's clear why the non_owner version is used here.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
