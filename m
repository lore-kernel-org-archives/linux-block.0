Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8925D1C68F
	for <linux-block@vger.kernel.org>; Fri,  4 Apr 2025 09:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743757844; cv=none; b=U91ahnkdaHVeyVCNZOC5VCt0TY/0x3tkSOsN9C/0onIM5jgPrbDPda4ORQZl1ZPQqvWpv+rb5vhFK8h8LWOcQhYOxWWVjxQB04v9IrQy6fL2jBl4EoOgsvJGNe0jqqzEM8tA9vA8ZWdEF2EbRifuYkmCgIKHT1Y4y5nAv63l6bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743757844; c=relaxed/simple;
	bh=O/Ck4fu6UFK/LmhCNRPC6+oEiAPwfAUOHVfBYaSTdIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uluqr/g2heX4NwmnID19f3MzIIHMKW67Gr2/3ibVgbhUKZzdhu8dryrivw9RrULVvczGA22dZQC7hpe5F4IlFyF68jsAiJ94p590NA9OVFA9xtD11gBeHnglgs82Tir/mzhukpvS2q41rx/Bs1VrdFsfEbl7u//vhYQ+FAiPQpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 259E268BEB; Fri,  4 Apr 2025 11:10:38 +0200 (CEST)
Date: Fri, 4 Apr 2025 11:10:37 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Nilay Shroff <nilay@linux.ibm.com>, Christoph Hellwig <hch@lst.de>,
	syzbot+4c7e0f9b94ad65811efb@syzkaller.appspotmail.com
Subject: Re: [PATCH] block: don't grab elevator lock during queue
 initialization
Message-ID: <20250404091037.GB12163@lst.de>
References: <20250403105402.1334206-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250403105402.1334206-1-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Apr 03, 2025 at 06:54:02PM +0800, Ming Lei wrote:
> Fixes the following lockdep warning:

Please spell the actual dependency out here, links are not permanent
and also not readable for any offline reading of the commit logs.

> +static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
> +				   struct request_queue *q, bool lock)
> +{
> +	if (lock) {

bool lock(ed) arguments are an anti-pattern, and regularly get Linus
screaming at you (in this case even for the right reason :))

> +		/* protect against switching io scheduler  */
> +		mutex_lock(&q->elevator_lock);
> +		__blk_mq_realloc_hw_ctxs(set, q);
> +		mutex_unlock(&q->elevator_lock);
> +	} else {
> +		__blk_mq_realloc_hw_ctxs(set, q);
> +	}

I think the problem here is again that because of all the other
dependencies elevator_lock really needs to be per-set instead of
per-queue which will allows us to have much saner locking hierarchies.

