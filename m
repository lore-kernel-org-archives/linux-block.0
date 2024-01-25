Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22CC523764
	for <linux-block@vger.kernel.org>; Thu, 25 Jan 2024 14:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706193161; cv=none; b=VM4s7xCx3d+UyE30b8+8bNAcgmfaLPHNE8GxCFYQrU5sOpCJAGbmBHfB6UZmlm19gZPLrVULhizDKznvCVbpqK/WvvPrdkt4ceEFk5rtJY5EpM509B6ZnpVhweu4FphNk1plQneWgD0xjT6kiDWiL1z98Lp5WvykpjTuft54lKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706193161; c=relaxed/simple;
	bh=XsA3QWjR+a3HmG89wU3rHxzcaF1XjG2J+ZahBzTKRO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Euipfqo24PejG5eqJ0KlU13BM/ZP6akZOZZksVJ0xsUbvs+AANBnGmcT8CmF34R5pfZo5UmDz7jryYEx+8xjtKhvxHMNL3LMJRwf/V2/3zQ2I0uBvvbm92k8JV/QIMLUzrVr54fWotCz2zWk4mtLP1kjLS81X+EHAQBLfBJxCTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id B10BD67373; Thu, 25 Jan 2024 15:32:34 +0100 (CET)
Date: Thu, 25 Jan 2024 15:32:34 +0100
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	virtualization@lists.linux.dev
Subject: Re: [PATCH 08/15] block: pass a queue_limits argument to
 blk_alloc_queue
Message-ID: <20240125143234.GA17817@lst.de>
References: <20240122173645.1686078-1-hch@lst.de> <20240122173645.1686078-9-hch@lst.de> <43b6b9ce-bbc8-4c36-abcb-85ed8c1eb40f@oracle.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43b6b9ce-bbc8-4c36-abcb-85ed8c1eb40f@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Jan 25, 2024 at 09:45:20AM +0000, John Garry wrote:
>> +struct request_queue *blk_alloc_queue(struct queue_limits *lim, int node_id)
>>   {
>>   	struct request_queue *q;
>> +	int error;
>>     	q = kmem_cache_alloc_node(blk_requestq_cachep, GFP_KERNEL | 
>> __GFP_ZERO,
>>   				  node_id);
>> @@ -404,13 +405,26 @@ struct request_queue *blk_alloc_queue(int node_id)
>
> Is there actually an issue in that blk_alloc_queue() can return NULL, and 
> we should be checking IS_ERR_OR_NULL() in the callers?
>
> I don't think that IS_ERR() picks up on NULL pointers, right?
>
> Or make this change:

Yes, that's the right thing to do, I'll add it.

> nit: This is only ever going to return -EINVAL or 0 by its very nature, 
> right? I suppose that it could return a bool and we do the conversion to 
> EINVAL here. It's a personal taste thing, I suppose.

I actually had that during most of the development, but then the callers
had to convert it.  Either way works, but this seemed a bit cleaner.

>> +		if (error)
>> +			goto fail_q;
>> +		q->limits = *lim;
>
> nit: It might be neater to do this in blk_validate_limits()

The limits assigment?  I'd really like to keep blk_validate_limits limited
to only look at the passed in queue_limits and never look at a live
object.
