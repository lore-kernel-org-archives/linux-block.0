Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11ED116DC28
	for <linux-block@vger.kernel.org>; Thu, 10 Apr 2025 15:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744299266; cv=none; b=QhnKf3qbPDDQMdmwDdGCdPFU5CQzjSqvy1+FZA+CKFgoFlp9lN8U3N9BfOXEwtM2tH0HTJfuh37ZWKOAMmfhmZKODmWrGGT8hCfUu2YS5S/Jtv0XY58O8g5J7ZmLCpUnj7wyzE6fwolgvApxo/0CYXZEUAPOcI+lM4+0bByQirI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744299266; c=relaxed/simple;
	bh=AryUlh1rUXVYeFxY6MxFpjUu4a/FsZserJHF7btTRtI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XfG46oXQTAimq9z9NE9quxtI/LijacZ5VmYrcvUzSU1sEKPzG9yKH5L94ilaWWEaPi9Okwv6kBhNJOxWLsFwprQz6labUEHMW/Zy+WShn64uRNRuKREcz5jLt2Tvqn3ktrvpBcqCkY4HcdkUp5lcg+VWU4hQxoqO5X0fJJn/59A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9E61168B05; Thu, 10 Apr 2025 17:34:18 +0200 (CEST)
Date: Thu, 10 Apr 2025 17:34:18 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 05/15] block: simplify elevator reset for updating
 nr_hw_queues
Message-ID: <20250410153417.GA12430@lst.de>
References: <20250410133029.2487054-1-ming.lei@redhat.com> <20250410133029.2487054-6-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250410133029.2487054-6-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Apr 10, 2025 at 09:30:17PM +0800, Ming Lei wrote:
> @@ -5071,9 +4984,15 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
>  		blk_mq_debugfs_register_hctxs(q);
>  	}
>  
> -switch_back:
> -	list_for_each_entry(q, &set->tag_list, tag_set_list)
> -		blk_mq_elv_switch_back(&head, q);
> +	list_for_each_entry(q, &set->tag_list, tag_set_list) {
> +		const char *name = "none";
> +
> +		mutex_lock(&q->elevator_lock);
> +		if (q->elevator && !blk_queue_dying(q))
> +			name = q->elevator->type->elevator_name;
> +		__elevator_change(q, name, true);
> +		mutex_unlock(&q->elevator_lock);
> +	}

Coming back to this after looking through the next patches.

Why do we even need the __elevator_change call here?  We've not
actually disabled the elevator, and we prevent other callers
from changing it.

As you pass in the force argument this now always calls
elevator_switch and thus blk_mq_init_sched.  But why?

