Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A157B14EC40
	for <linux-block@vger.kernel.org>; Sun,  8 Sep 2024 10:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725790841; cv=none; b=P5o8hk2eYCXSFqQNvt3sH1NgWvTI8YdbFhYJLK5PzQmDfoZSUR/Jm+8zETDepx/wWdhCjxrOefLC7N4RgW8MtoCie1xKdyzGuONmNvrDJd+OMlXBPmDkHpLphiVvAuNEddgsxlxsg9ciVn8PUiidYRxeoaOa6SRfPSyOTVbTESE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725790841; c=relaxed/simple;
	bh=qqZBGvygySUIwebPHaOgukAGvIx/tYeM1appMNO+SoA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SytGdO5gH3gqYL4DZFllamHQiGKH078XCu8dzSmLgd3EOXZddtHiAZbYz4nPeA090ebBzctQIs8hS1vWmSb6ptrYtkE9Jv0kgtmKKMsDnXgrbDPEQrrvADkVAIRVovUWrIiLz3RwAK3beG+mB8h7UPo587zEcfuOObtLBqsTqg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NtCdGaAq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NtCdGaAq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725790838;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CsNr34yyilaT0nKMT7zaED+o4bAb68gHZzJKXlx6lBU=;
	b=NtCdGaAqvkTlRrNAe2PBbrGzoUMV6rSy+G3XJyguPvYjFLPUCk6E3Ci7k02gFcF3TtG7PG
	GU81vSQ/vQcEE5JDodje2qqQOO3nYJ4879ip9DEFse3EGG+GSUNbzy6m2eMYc1r/ODcI/2
	BwFBxbfmjQJ3DZi+Fd7xkkGD8Gnc5DI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-658-YG5_nSWgONOQYypgPY2j7A-1; Sun,
 08 Sep 2024 06:20:33 -0400
X-MC-Unique: YG5_nSWgONOQYypgPY2j7A-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CC28019560B4;
	Sun,  8 Sep 2024 10:20:31 +0000 (UTC)
Received: from localhost (unknown [10.42.28.10])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1BE083000239;
	Sun,  8 Sep 2024 10:20:29 +0000 (UTC)
Date: Sun, 8 Sep 2024 11:20:29 +0100
From: "Richard W.M. Jones" <rjones@redhat.com>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>, Jeff Moyer <jmoyer@redhat.com>,
	Jiri Jaburek <jjaburek@redhat.com>, Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>,
	Hannes Reinecke <hare@suse.de>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH] block: Prevent deadlocks when switching elevators
Message-ID: <20240908102029.GB1450@redhat.com>
References: <20240908000704.414538-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240908000704.414538-1-dlemoal@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Sun, Sep 08, 2024 at 09:07:04AM +0900, Damien Le Moal wrote:
> Commit af2814149883 ("block: freeze the queue in queue_attr_store")
> changed queue_attr_store() to always freeze a sysfs attribute queue
> before calling the attribute store() method, to ensure that no IOs are
> in-flight when an attribute value is being updated.
> 
> However, this change created a potential deadlock situation for the
> scheduler queue attribute as changing the queue elevator with
> elv_iosched_store() can result in a call to request_module() if the user
> requested module is not already registered. If the file of the requested
> module is stored on the block device of the frozen queue, a deadlock
> will happen as the read operations triggered by request_module() will
> wait for the queue freeze to end.
> 
> Solve this issue by introducing the load_module method in struct
> queue_sysfs_entry, and to calling this method function in
> queue_attr_store() before freezing the attribute queue.
> The macro definition QUEUE_RW_LOAD_MODULE_ENTRY() is added to define a
> queue sysfs attribute that needs loading a module.
> 
> The definition of the scheduler atrribute is changed to using
> QUEUE_RW_LOAD_MODULE_ENTRY(), with the function
> elv_iosched_load_module() defined as the load_module method.
> elv_iosched_store() can then be simplified to remove the call to
> request_module().
> 
> Reported-by: Richard W.M. Jones <rjones@redhat.com>
> Reported-by: Jiri Jaburek <jjaburek@redhat.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219166
> Fixes: af2814149883 ("block: freeze the queue in queue_attr_store")
> Cc: stable@vger.kernel.org
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>

I tested this (using my "unreliable" test!), and it passed 5,000
iterations, so:

Tested-by: Richard W.M. Jones <rjones@redhat.com>

Thanks,

Rich.

> ---
>  block/blk-sysfs.c | 22 +++++++++++++++++++++-
>  block/elevator.c  | 21 +++++++++++++++------
>  block/elevator.h  |  2 ++
>  3 files changed, 38 insertions(+), 7 deletions(-)
> 
> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
> index 60116d13cb80..e85941bec857 100644
> --- a/block/blk-sysfs.c
> +++ b/block/blk-sysfs.c
> @@ -23,6 +23,7 @@
>  struct queue_sysfs_entry {
>  	struct attribute attr;
>  	ssize_t (*show)(struct gendisk *disk, char *page);
> +	int (*load_module)(struct gendisk *disk, const char *page, size_t count);
>  	ssize_t (*store)(struct gendisk *disk, const char *page, size_t count);
>  };
>  
> @@ -413,6 +414,14 @@ static struct queue_sysfs_entry _prefix##_entry = {	\
>  	.store	= _prefix##_store,			\
>  };
>  
> +#define QUEUE_RW_LOAD_MODULE_ENTRY(_prefix, _name)		\
> +static struct queue_sysfs_entry _prefix##_entry = {		\
> +	.attr		= { .name = _name, .mode = 0644 },	\
> +	.show		= _prefix##_show,			\
> +	.load_module	= _prefix##_load_module,		\
> +	.store		= _prefix##_store,			\
> +}
> +
>  QUEUE_RW_ENTRY(queue_requests, "nr_requests");
>  QUEUE_RW_ENTRY(queue_ra, "read_ahead_kb");
>  QUEUE_RW_ENTRY(queue_max_sectors, "max_sectors_kb");
> @@ -420,7 +429,7 @@ QUEUE_RO_ENTRY(queue_max_hw_sectors, "max_hw_sectors_kb");
>  QUEUE_RO_ENTRY(queue_max_segments, "max_segments");
>  QUEUE_RO_ENTRY(queue_max_integrity_segments, "max_integrity_segments");
>  QUEUE_RO_ENTRY(queue_max_segment_size, "max_segment_size");
> -QUEUE_RW_ENTRY(elv_iosched, "scheduler");
> +QUEUE_RW_LOAD_MODULE_ENTRY(elv_iosched, "scheduler");
>  
>  QUEUE_RO_ENTRY(queue_logical_block_size, "logical_block_size");
>  QUEUE_RO_ENTRY(queue_physical_block_size, "physical_block_size");
> @@ -670,6 +679,17 @@ queue_attr_store(struct kobject *kobj, struct attribute *attr,
>  	if (!entry->store)
>  		return -EIO;
>  
> +	/*
> +	 * If the attribute needs to load a module, do it before freezing the
> +	 * queue to ensure that the module file can be read when the request
> +	 * queue is the one for the device storing the module file.
> +	 */
> +	if (entry->load_module) {
> +		res = entry->load_module(disk, page, length);
> +		if (res)
> +			return res;
> +	}
> +
>  	blk_mq_freeze_queue(q);
>  	mutex_lock(&q->sysfs_lock);
>  	res = entry->store(disk, page, length);
> diff --git a/block/elevator.c b/block/elevator.c
> index f13d552a32c8..c355b55d0107 100644
> --- a/block/elevator.c
> +++ b/block/elevator.c
> @@ -698,17 +698,26 @@ static int elevator_change(struct request_queue *q, const char *elevator_name)
>  		return 0;
>  
>  	e = elevator_find_get(q, elevator_name);
> -	if (!e) {
> -		request_module("%s-iosched", elevator_name);
> -		e = elevator_find_get(q, elevator_name);
> -		if (!e)
> -			return -EINVAL;
> -	}
> +	if (!e)
> +		return -EINVAL;
>  	ret = elevator_switch(q, e);
>  	elevator_put(e);
>  	return ret;
>  }
>  
> +int elv_iosched_load_module(struct gendisk *disk, const char *buf,
> +			    size_t count)
> +{
> +	char elevator_name[ELV_NAME_MAX];
> +
> +	if (!elv_support_iosched(disk->queue))
> +		return -EOPNOTSUPP;
> +
> +	strscpy(elevator_name, buf, sizeof(elevator_name));
> +
> +	return request_module("%s-iosched", strstrip(elevator_name));
> +}
> +
>  ssize_t elv_iosched_store(struct gendisk *disk, const char *buf,
>  			  size_t count)
>  {
> diff --git a/block/elevator.h b/block/elevator.h
> index 3fe18e1a8692..2a78544bf201 100644
> --- a/block/elevator.h
> +++ b/block/elevator.h
> @@ -148,6 +148,8 @@ extern void elv_unregister(struct elevator_type *);
>   * io scheduler sysfs switching
>   */
>  ssize_t elv_iosched_show(struct gendisk *disk, char *page);
> +int elv_iosched_load_module(struct gendisk *disk, const char *page,
> +			    size_t count);
>  ssize_t elv_iosched_store(struct gendisk *disk, const char *page, size_t count);
>  
>  extern bool elv_bio_merge_ok(struct request *, struct bio *);
> -- 
> 2.46.0

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
nbdkit - Flexible, fast NBD server with plugins
https://gitlab.com/nbdkit/nbdkit

