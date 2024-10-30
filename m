Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E3F1F4277
	for <linux-block@vger.kernel.org>; Wed, 30 Oct 2024 14:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730299619; cv=none; b=JNzq/x7D1XJFYc3MyeFvQOFLTbyx8u4FBWvCEUvBWlX+jWLSkMBc9SCHaIcHIFXUz1GxFYwWpNpQ6sK+z3eJs/p7iRg3e9nzWXIx5HpiP5uTRePWFCaZNRhcL9b23dTE6nB34+xOfCcOYCAJv8gLwZdz8RnC5LwGSsZKL0P7Qbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730299619; c=relaxed/simple;
	bh=6M0qlmEZ3yl4gXbTD1ep6BwaVr2X3YzV3YvrKIGdQkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c5lDzA6dIcxO+OwJR+5V45cRRd/x2xUqM2pYN3wX0m1SQbxGPLE+gK7SIxsP9vgsXctsiBy/SotH7zytbKsTHtYN/vSRYVYks2yb3ge/IONsCReQKC1L5vHr8bSFi5jDUR+TyOWm3TlGiogkiXP7JGrTB73whWVt7CRa7+xqd/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 50F02227A8E; Wed, 30 Oct 2024 15:46:53 +0100 (CET)
Date: Wed, 30 Oct 2024 15:46:52 +0100
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Lai Yi <yi1.lai@linux.intel.com>
Subject: Re: [PATCH 5/5] block: don't verify IO lock for freeze/unfreeze in
 elevator_init_mq()
Message-ID: <20241030144652.GD32043@lst.de>
References: <20241030124240.230610-1-ming.lei@redhat.com> <20241030124240.230610-6-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241030124240.230610-6-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Oct 30, 2024 at 08:42:37PM +0800, Ming Lei wrote:
> --- a/block/elevator.c
> +++ b/block/elevator.c
> @@ -598,13 +598,17 @@ void elevator_init_mq(struct request_queue *q)
>  	 * drain any dispatch activities originated from passthrough
>  	 * requests, then no need to quiesce queue which may add long boot
>  	 * latency, especially when lots of disks are involved.
> +	 *
> +	 * Disk isn't added yet, so verifying queue lock only manually.
>  	 */
> -	blk_mq_freeze_queue(q);
> +	blk_mq_freeze_queue_non_owner(q);
> +	blk_freeze_acquire_lock(q, true, false);
>  	blk_mq_cancel_work_sync(q);
>  
>  	err = blk_mq_init_sched(q, e);
>  
> -	blk_mq_unfreeze_queue(q);
> +	blk_unfreeze_release_lock(q, true, false);
> +	blk_mq_unfreeze_queue_non_owner(q);

Why do we need to free at all from the add_disk case?  The passthrough
command should never hit the elevator, or am I missing something?

