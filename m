Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B704E198822
	for <linux-block@vger.kernel.org>; Wed,  5 Feb 2025 16:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738771205; cv=none; b=T1S4xdwruFP+0QBDcg5heHsZd5nqrLOHFp9lUR8+4jgAc7vdDvbYko6mVcZ31XbkoMVbBIrvj/HRVfzDFEOQ2HHZ2jxXqpevD/EBdu8y7Hm8zDizQRkvYC6Do2okQ3tD7LNZKDdAGycagkjK2oohfHc//melA6CZY6L0Ne1C7xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738771205; c=relaxed/simple;
	bh=M2ZuD2DPk0Xy2iBDLNqmBRkqRMSC7rd8oO3MN8tpF+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pPXSizIh927278v4qXbzlXh1cdrvsIsym/DM/ubPrZhGB4YKF/5iSdP+t+NWx5nLZ194uTaFlfV3DNVSiQQqBvuw9ENOvTMBYgr0rd+y9DtUYkX8eqfgn03ds0Qqbl9BtDD9Ckj+qpizDsF8dCXR8IaMgsz20WqdcHXas0bCelY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id B9FB768D1F; Wed,  5 Feb 2025 16:59:55 +0100 (CET)
Date: Wed, 5 Feb 2025 16:59:52 +0100
From: Christoph Hellwig <hch@lst.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-block@vger.kernel.org, hch@lst.de, ming.lei@redhat.com,
	dlemoal@kernel.org, axboe@kernel.dk, gjoyce@ibm.com
Subject: Re: [PATCH 1/2] block: fix lock ordering between the queue
 ->sysfs_lock and freeze-lock
Message-ID: <20250205155952.GB14133@lst.de>
References: <20250205144506.663819-1-nilay@linux.ibm.com> <20250205144506.663819-2-nilay@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250205144506.663819-2-nilay@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Feb 05, 2025 at 08:14:47PM +0530, Nilay Shroff wrote:
>  
>  static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
> @@ -5006,8 +5008,10 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
>  		return;
>  
>  	memflags = memalloc_noio_save();
> -	list_for_each_entry(q, &set->tag_list, tag_set_list)
> +	list_for_each_entry(q, &set->tag_list, tag_set_list) {
> +		mutex_lock(&q->sysfs_lock);

This now means we hold up to number of request queues sysfs_lock
at the same time.  I doubt lockdep will be happy about this.
Did you test this patch with a multi-namespace nvme device or
a multi-LU per host SCSI setup?

I suspect the answer here is to (ab)use the tag_list_lock for
scheduler updates - while the scope is too broad for just
changing it on a single queue it is a rate operation and it
solves the mess in __blk_mq_update_nr_hw_queues.

