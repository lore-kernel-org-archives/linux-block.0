Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C84117753
	for <linux-block@vger.kernel.org>; Sat,  7 Sep 2024 07:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725694536; cv=none; b=CHyCpIzzKJpwAHcQTDVYUDucYjM/t5+zTCBYDojDh4TXDJg0idUOnqohRPRZttWnAx10WEfH8cN21dguXEgtSKiNEO0OID1ZxbEaJuDdgR1BQV31AL+1BwmIirCEK07zRjBOTCAtmadY1KEdMOalEkUSUqUJwprIrQ9nTNrV3Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725694536; c=relaxed/simple;
	bh=cg72zqI35BC7r45bmE/RLPfXtDYsoHaXk3DHKaZ/zLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GCeIe6DDomddHNdaU3Db2DIQ9mJckhvc4pC4rpwcZhlX83OMKd/YckC14dqyA3TzfSPl0xL5Ek3eHxmnFAQpRzpUYzEFlZLMrgusjr1xeNIW3OCCtahX5T9qq6703FhpDoTIUGPXyhv7QoB+kkKeFioIbqh5J5PDhSuRyEMlroc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ffdYs+ts; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ffdYs+ts"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725694532;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QQeJdXPRKcWux22aWkvbSe6lIcp5khqyGJA2lTp2R2g=;
	b=ffdYs+ts3BVLlq/6uOIdrcOFz4cleNJ2cGOk7Px5t9ZhEJ+gpOJwrzU+geWsH8TyyRxLD8
	j0fb0sorxjKYs55jbpF9JivgnCfZO5WFZTrTlU4pm+wbslaWKS6e9aVa6q1B2eVJhK1GJr
	3/5ksAI9U/VEBrEtghUyAiium/Ku4T8=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-414-Lpt0fRJaPMmTq4KhA9kPtA-1; Sat,
 07 Sep 2024 03:35:27 -0400
X-MC-Unique: Lpt0fRJaPMmTq4KhA9kPtA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C1CEE1955D5A;
	Sat,  7 Sep 2024 07:35:25 +0000 (UTC)
Received: from localhost (unknown [10.42.28.10])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 247D63000236;
	Sat,  7 Sep 2024 07:35:23 +0000 (UTC)
Date: Sat, 7 Sep 2024 08:35:22 +0100
From: "Richard W.M. Jones" <rjones@redhat.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Jeff Moyer <jmoyer@redhat.com>, Jiri Jaburek <jjaburek@redhat.com>,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>,
	Damien Le Moal <dlemoal@kernel.org>, Hannes Reinecke <hare@suse.de>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH] block: elevator: avoid to load iosched module from this
 disk
Message-ID: <20240907073522.GW1450@redhat.com>
References: <20240907014331.176152-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240907014331.176152-1-ming.lei@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Sat, Sep 07, 2024 at 09:43:31AM +0800, Ming Lei wrote:
> When switching io scheduler via sysfs, 'request_module' may be called
> if the specified scheduler doesn't exist.
> 
> This was has deadlock risk because the module may be stored on FS behind
> our disk since request queue is frozen before switching its elevator.
> 
> Fix it by returning -EDEADLK in case that the disk is claimed, which
> can be thought as one signal that the disk is mounted.
> 
> Some distributions(Fedora) simulates the original kernel command line of
> 'elevator=foo' via 'echo foo > /sys/block/$DISK/queue/scheduler', and boot
> hang is triggered.
> 
> Cc: Richard Jones <rjones@redhat.com>
> Cc: Jeff Moyer <jmoyer@redhat.com>
> Cc: Jiri Jaburek <jjaburek@redhat.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

I'd suggest also:

Bug: https://bugzilla.kernel.org/show_bug.cgi?id=219166
Reported-by: Richard W.M. Jones <rjones@redhat.com>
Reported-by: Jiri Jaburek <jjaburek@redhat.com>
Tested-by: Richard W.M. Jones <rjones@redhat.com>

So I have tested this patch and it does fix the issue, at the possible
cost that now setting the scheduler can fail:

  + for f in /sys/block/{h,s,ub,v}d*/queue/scheduler
  + echo noop
  /init: line 109: echo: write error: Resource deadlock avoided

(I know I'm setting it to an impossible value here, but this could
also happen when setting it to a valid one.)

Since almost no one checks the result of 'echo foo > /sys/...'  that
would probably mean that sometimes a desired setting is silently not
set.

Also I bisected this bug yesterday and found it was caused by (or,
more likely, exposed by):

  commit af2814149883e2c1851866ea2afcd8eadc040f79
  Author: Christoph Hellwig <hch@lst.de>
  Date:   Mon Jun 17 08:04:38 2024 +0200

    block: freeze the queue in queue_attr_store
    
    queue_attr_store updates attributes used to control generating I/O, and
    can cause malformed bios if changed with I/O in flight.  Freeze the queue
    in common code instead of adding it to almost every attribute.

Reverting this commit on top of git head also fixes the problem.

Why did this commit expose the problem?

Rich.

> ---
>  block/elevator.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/block/elevator.c b/block/elevator.c
> index f13d552a32c8..2b0432f4ac33 100644
> --- a/block/elevator.c
> +++ b/block/elevator.c
> @@ -676,6 +676,13 @@ void elevator_disable(struct request_queue *q)
>  	blk_mq_unfreeze_queue(q);
>  }
>  
> +static bool disk_is_claimed(struct gendisk *disk)
> +{
> +	if (disk->part0->bd_holder)
> +		return true;
> +	return false;
> +}
> +
>  /*
>   * Switch this queue to the given IO scheduler.
>   */
> @@ -699,6 +706,13 @@ static int elevator_change(struct request_queue *q, const char *elevator_name)
>  
>  	e = elevator_find_get(q, elevator_name);
>  	if (!e) {
> +		/*
> +		 * Try to avoid to load iosched module from FS behind our
> +		 * disk, otherwise deadlock may be triggered
> +		 */
> +		if (disk_is_claimed(q->disk))
> +			return -EDEADLK;
> +
>  		request_module("%s-iosched", elevator_name);
>  		e = elevator_find_get(q, elevator_name);
>  		if (!e)
> -- 
> 2.46.0

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-top is 'top' for virtual machines.  Tiny program with many
powerful monitoring features, net stats, disk stats, logging, etc.
http://people.redhat.com/~rjones/virt-top

