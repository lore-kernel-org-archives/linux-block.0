Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D816E2B1
	for <linux-block@vger.kernel.org>; Thu, 25 Jan 2024 14:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706193343; cv=none; b=eLixaTh0M4I6sQbysoGEHslJ+8bV+6+MpNliK7r7DVhDImYwlEWF5rPgSc+4WSXJPJKfCjbsR4Fs1G2/1/hRubKXNKXWzmX2fxAvbpoNHV4BvFjgi7uHj25WjjB/bJjgfOh8jCDK60RiAJa19wP3GzS+V8AS4wDv69D475VbScE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706193343; c=relaxed/simple;
	bh=oWYl14DMY/ftkJmmm8B149mXN/VgDvP1cxFi+DwKLDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cNz0V85/CtS71tSBKpr59Bz3Y392Mgoy51FS1GbLr5r73mDwE3mKtoLO6nIF3QOjeqWi7ZNpyw9joke1P86FYAD6AvpCq9NQT3H20rT8hrMU6kmtbZzKBEzT+SFT8a9gnK1eO2Of9m3IfcB4438hl3HhyX9VfQaJHXopzR9hFXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id AF6A867373; Thu, 25 Jan 2024 15:35:36 +0100 (CET)
Date: Thu, 25 Jan 2024 15:35:36 +0100
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
Subject: Re: [PATCH 03/15] block: add an API to atomically update queue
 limits
Message-ID: <20240125143536.GB17817@lst.de>
References: <20240122173645.1686078-1-hch@lst.de> <20240122173645.1686078-4-hch@lst.de> <79eb5c4c-d9c0-4a70-94ac-04892bbf8085@oracle.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79eb5c4c-d9c0-4a70-94ac-04892bbf8085@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Jan 25, 2024 at 10:28:49AM +0000, John Garry wrote:
>
>> +
>> +int blk_validate_limits(struct queue_limits *lim)
>> +{
>> +	unsigned int max_hw_sectors;
>> +
>> +	if (!lim->logical_block_size)
>> +		lim->logical_block_size = SECTOR_SIZE;
>
> nit: This function is doing a bit more than validating, as the function 
> name suggests

Well, it validates and fixes up.  But that sucks as a name.  If you
have a good naming suggestion I can pick it up, but I couldn't come
up with a better name.

>> +	if (!lim->physical_block_size)
>> +		lim->physical_block_size = SECTOR_SIZE;
>> +	if (lim->physical_block_size < lim->logical_block_size)
>> +		lim->physical_block_size = lim->physical_block_size;
>> +
>> +	if (!lim->io_min)
>> +		lim->io_min = SECTOR_SIZE;
>> +	if (lim->io_min < lim->physical_block_size)
>> +		lim->io_min = lim->physical_block_size;
>> +
>> +	if (!lim->max_hw_sectors)
>> +		lim->max_hw_sectors = BLK_SAFE_MAX_SECTORS;
>> +	if (WARN_ON_ONCE(lim->max_hw_sectors < PAGE_SIZE / SECTOR_SIZE))
>> +		return -EINVAL;
>
> The WARN_ON_ONCE usage is odd, as it will only ever WARN once for a 
> specific q, while other queues associated with other drivers may have the 
> same limit issue. But I suppose if one issue is fixed, then the other will 
> make itself known...

Yeah.  The idea is to give a loud warning for the API misuse as this
is not an error a normal user action could trigger.

>> +	int error = blk_validate_limits(lim);
>> +
>> +	if (!error) {
>> +		q->limits = *lim;
>
> this is duplicating what blk_alloc_queue() does

I originally had another helper to do the limits assignment
and the blk_apply_bdi_limits.  But as only one caller needs
the blk_apply_bdi_limits it felt a little silly.

>> +static inline struct queue_limits
>> +queue_limits_start_update(struct request_queue *q)
>> +	__acquires(q->limits_lock)
>> +{
>> +	mutex_lock(&q->limits_lock);
>> +	return q->limits;
>> +}
>> +int queue_limits_commit_update(struct request_queue *q,
>> +		struct queue_limits *lim);
>
> It ain't so nice that the code for queue_limits_start_update() and 
> queue_limits_commit_update() pair are in separate files.

We do that for a lot of APIs where part is inline.  And I really do
want queue_limits_start_update inline as passing large structs by
value generates horrible code, and for this API to work it needs
to be returned by value.  In fact it probably should be __always_inline
to avoid gcc doing stupid thing with -Os.

