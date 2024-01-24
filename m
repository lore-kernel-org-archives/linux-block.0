Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92AF1B5A4
	for <linux-block@vger.kernel.org>; Wed, 24 Jan 2024 09:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706088115; cv=none; b=E9xYa/KvD3SqPDOkywB6EjqE9J+ftRhfhSfnQfSCYGmyoyrGuDyyK07rN0uTfZsUeKfyDIJPSHY8gItNuArjk/UZe/vkFj64Oe63OZW8JC293jT0K7kM+Gp/c57yyOcvRC3L/vEMQrdnpgJTA4Hcbhk44HWqnVo3jLXwuem9g+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706088115; c=relaxed/simple;
	bh=Q0kfJGwfJNRpe/Ml0n5ViX31n5MiHcRCZGahnNtHrwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=srhJulVKuaG7xnRUw52Vmsqhl1d7fokgXKsLLZcGvog8IZmzR1ZYq7hQZw92m1maZHOJ4R6DFbP9raXpfwXTYlcwaohKsgd1DMU8U/Psrgd6gHbCGMu8qj61fD98MRZc/Q4jK0yqK8+QBcoA2GaSWpuvYiEDJ1sdBR+uAiw09VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0EC1B68AFE; Wed, 24 Jan 2024 10:21:49 +0100 (CET)
Date: Wed, 24 Jan 2024 10:21:48 +0100
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
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
Subject: Re: [PATCH 03/15] block: add an API to atomically update queue
 limits
Message-ID: <20240124092148.GA28770@lst.de>
References: <20240122173645.1686078-1-hch@lst.de> <20240122173645.1686078-4-hch@lst.de> <de3cd926-c78c-4e68-bee0-2f571ccdaf8d@suse.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de3cd926-c78c-4e68-bee0-2f571ccdaf8d@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Jan 24, 2024 at 07:08:58AM +0100, Hannes Reinecke wrote:
>> + * that there is outstanding I/O by other means.
>> + */
>> +static inline struct queue_limits
>> +queue_limits_start_update(struct request_queue *q)
>> +	__acquires(q->limits_lock)
>> +{
>> +	mutex_lock(&q->limits_lock);
>> +	return q->limits;
>> +}
>
> I'm slightly confused about the lifetime of the returned structure.
> By my understanding, the returned 'struct queue_limit' is allocated
> on the stack of the caller, right?
> Shouldn't we note this somewhere such that people don't start passing
> the structure around, or, worse, calling 'kfree()' on it?

queue_limits_start_update returns the structure by value.  So the
lifetime is that of whatever variable you assign it to, which better
be on the stack.  Tryign to kfree a non-pointer type will get the
compiler complain, as does passing a reference to it outside the
function these days.
