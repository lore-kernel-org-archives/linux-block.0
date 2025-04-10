Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00532853ED
	for <linux-block@vger.kernel.org>; Thu, 10 Apr 2025 14:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744295790; cv=none; b=lur/eaU7n2qZp78qfwNkZZ8PU+/FshSeB08javyHOWHWPtfHTNve8+x0OoHODv8Bhsm0XSNEDhP8Vi9R2AoaQMrc7LvNQhphuex23QZWmyrNsngZmXFdfBczSJaDqRBmniW6r4sJvDKoz9tKBUyLt5yQwTxstPcBrg0GY+VLDqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744295790; c=relaxed/simple;
	bh=cbpSxTfH12be586Ez/izElK2NE5FelKwcQ7Q3c3nYm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t0MIile/fCp1OZb7MFJsCsc8s1M6T446Otlf+04WLXTEY2ZvLxQThHqCAMEvfOJ2M07+1vVp37qWOUyKIl0KwUplaspVclQrysKnJbcquJYtq/y787Ioiuef5g4Mkx+as/SECDGptxfQHKyWqSlX3aO1c2d5Y5pM8IbOpEJYSSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9A92D68B05; Thu, 10 Apr 2025 16:36:22 +0200 (CEST)
Date: Thu, 10 Apr 2025 16:36:22 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 04/15] block: prevent elevator switch during updating
 nr_hw_queues
Message-ID: <20250410143622.GC10701@lst.de>
References: <20250410133029.2487054-1-ming.lei@redhat.com> <20250410133029.2487054-5-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250410133029.2487054-5-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Apr 10, 2025 at 09:30:16PM +0800, Ming Lei wrote:
> updating nr_hw_queues is usually used for error handling code, when it

Capitalize the first word of each sentence, please.

> doesn't make sense to allow blk-mq elevator switching, since nr_hw_queues
> may change, and elevator tags depends on nr_hw_queues.

I don't think it's really updated from error handling

 - nbd does it when starting a device
 - nullb can do it through debugfs
 - xen-blkfront does it when resuming from a suspend
 - nvme does it when resetting a controller.  While error handling
   can escalate to it¸ it's basically probing and re-probing code

> Prevent elevator switch during updating nr_hw_queues by setting flag of
> BLK_MQ_F_UPDATE_HW_QUEUES, and use srcu to fail elevator switch during
> the period. Here elevator switch code is srcu reader of nr_hw_queues,
> and blk_mq_update_nr_hw_queues() is the writer.

That being said as we generally are in a setup path I think the general
idea is fine.  No devices should be life yet at this point and thus
no udev rules changing the scheduler should run yet.

> This way avoids lot of trouble.

Can you spell that out a bit?

> Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Closes: https://lore.kernel.org/linux-block/mz4t4tlwiqjijw3zvqnjb7ovvvaegkqganegmmlc567tt5xj67@xal5ro544cnc/

Are we using Closes for bug reports now?  I haven't really seen that
anywhere.

>  out_cleanup_srcu:
>  	if (set->flags & BLK_MQ_F_BLOCKING)
>  		cleanup_srcu_struct(set->srcu);
> @@ -5081,7 +5087,18 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
>  void blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set, int nr_hw_queues)
>  {
>  	mutex_lock(&set->tag_list_lock);
> +	/*
> +	 * Mark us in updating nr_hw_queues for preventing switching
> +	 * elevator
>
> +	 *
> +	 * Elevator switch code can _not_ acquire ->tag_list_lock

Please add a . at the end of a sentences.  Also this should probably
be something like "Mark us as in.." but I'll leave more nitpicking
to the native speakers.

>  	struct request_queue *q = disk->queue;
> +	struct blk_mq_tag_set *set = q->tag_set;
>  
>  	/*
>  	 * If the attribute needs to load a module, do it before freezing the
> @@ -732,6 +733,13 @@ ssize_t elv_iosched_store(struct gendisk *disk, const char *buf,
>  
>  	elv_iosched_load_module(name);
>  
> +	idx = srcu_read_lock(&set->update_nr_hwq_srcu);
> +
> +	if (set->flags & BLK_MQ_F_UPDATE_HW_QUEUES) {

What provides atomicity for field modifications vs reading of set->flags?
i.e. does this need to switch using test/set_bit?

> +	struct srcu_struct	update_nr_hwq_srcu;
>  };
>  
>  /**
> @@ -681,7 +682,14 @@ enum {
>  	 */
>  	BLK_MQ_F_NO_SCHED_BY_DEFAULT	= 1 << 6,
>  
> -	BLK_MQ_F_MAX = 1 << 7,
> +	/*
> +	 * True when updating nr_hw_queues is in-progress
> +	 *
> +	 * tag_set only flag, not usable for hctx
> +	 */
> +	BLK_MQ_F_UPDATE_HW_QUEUES	= 1 << 7,
> +
> +	BLK_MQ_F_MAX = 1 << 8,

Also mixing internal state with driver provided flags is always
a bad idea.  So this should probably be a new state field in the
tag_set and not reuse flags.

