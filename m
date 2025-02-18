Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C82E1B983E
	for <linux-block@vger.kernel.org>; Tue, 18 Feb 2025 09:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739869522; cv=none; b=cJRSoQoPfZnzNvXtWtYlomvRLkZ/SZ8VCJJ8oweH4/iJSGeUlbKpsFtqdvqQgcVvsAcsv48XgpVd7WvXEUnghR/b8SQsQtSReRpuvgyPF5IhYzD0N41iEGsaa6c3YJbbFA5dlOvQPGhS/XjICS+6dZMcTidDMkvx9zS4Rz4qbLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739869522; c=relaxed/simple;
	bh=ILfYnbjeydQvsXVwQfBbabQYLhlzjXWQX/BougcBHu8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A+ZwUm9Zf/Ze3Hm8Dq9KhluqPxAc+j0v1usfFZMbkdrGD94DUnWl8CM0mE8wntqJy75r4Nk9UHOBP7nkrK1RF+FxovoFeBv3ow5qd2tV9umrdcYOFlmaJtJUWlp14K/QYy8WMp8Ppu68yJ6VBE/t5LExxWWJ692deygDdAIvR0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 73DB368C7B; Tue, 18 Feb 2025 10:05:16 +0100 (CET)
Date: Tue, 18 Feb 2025 10:05:16 +0100
From: Christoph Hellwig <hch@lst.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-block@vger.kernel.org, ming.lei@redhat.com, dlemoal@kernel.org,
	axboe@kernel.dk, gjoyce@ibm.com
Subject: Re: [PATCHv2 3/6] block: Introduce a dedicated lock for protecting
 queue elevator updates
Message-ID: <20250218090516.GA12269@lst.de>
References: <20250218082908.265283-1-nilay@linux.ibm.com> <20250218082908.265283-4-nilay@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218082908.265283-4-nilay@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Feb 18, 2025 at 01:58:56PM +0530, Nilay Shroff wrote:
> As the scope of q->sysfs_lock is not well-defined, its misuse has
> resulted in numerous lockdep warnings. To resolve this, replace q->
> sysfs_lock with a new dedicated q->elevator_lock, which will be
> exclusively used to protect elevator switching and updates.

Well, it's not replacing q->sysfs_lock as that is still around.
It changes some data to now be protected by elevator_lock instead,
and you should spell out which, preferably in a comment next to the
elevator_lock definition (I should have done the same for limits_lock
despite the trivial applicability to the limits field).

>  	/* q->elevator needs protection from ->sysfs_lock */
> -	mutex_lock(&q->sysfs_lock);
> +	mutex_lock(&q->elevator_lock);

Well, the above comment is no trivially wrong.

>  
>  	/* the check has to be done with holding sysfs_lock */

Same for this one.

They could probably go away with the proper comments near elevator_lock
itself.

>  static ssize_t queue_requests_show(struct gendisk *disk, char *page)
>  {
> -	return queue_var_show(disk->queue->nr_requests, page);
> +	int ret;
> +
> +	mutex_lock(&disk->queue->sysfs_lock);
> +	ret = queue_var_show(disk->queue->nr_requests, page);
> +	mutex_unlock(&disk->queue->sysfs_lock);

This also shifts taking sysfs_lock into the the ->show and ->store
methods.  Which feels like a good thing, but isn't mentioned in the
commit log or directly releate to elevator_lock.  Can you please move
taking the locking into the methods into a preparation patch with a
proper commit log?  Also it's pretty strange the ->store_nolock is
now called with the queue frozen but ->store is not and both are
called without any locks.  So I think part of that prep patch should
also be moving the queue freezing into ->store and do away with
the separate ->store_nolock, and just keep the special ->store_limit.
There's also no more need for ->lock_module when the elevator store
method is called unfrozen and without a lock.

->show and ->show_nolock also are identical now and can be done
away with.

So maybe shifting the freezing and locking into the methods should go
very first, before dropping the lock for the attributes that don't it?

