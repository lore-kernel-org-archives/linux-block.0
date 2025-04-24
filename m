Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C7C210F5A
	for <linux-block@vger.kernel.org>; Thu, 24 Apr 2025 09:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745485395; cv=none; b=VzWlKeD6HzTQnIp2Go8nDuo5zNN5GJ+9Co3gtoHUxA4bn/P1FOs/ueg5rxst7DBOjoa8UmVjDeTklKU5kMl3VsV3EhcFQ3SAS+i/VzxYp6EAr6JLmUqWPPocnIXR/YWs0ZjydfOnXDGD/OpbW0gEOs4l7Oc2EzDlRDtFzC4J0Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745485395; c=relaxed/simple;
	bh=LxxZ3PnM3GnSmQVc4b35vmUhaH1YtHOD2luSa1Hv2FA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k9YdX0ZFXhPnGjnscPs0yDnDgGpeE0KfkrdDPurOaFQYVNxAVd8NsK55Jb3U7+vcGUwGPBt48NE/CQq75AILMWxnrrSSJZQlkAAn6hk4F4UkdDfiVxIT3wyyfn3tn+CwH2RoE43kroTufktBVVH/a1FysOXBsItVdJdUYwrRDqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WTIoglLA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WTIoglLA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745485391;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yQlNEGSJgij/t3GaaKCbDm9GBD8YV1Z5HMPR6Qwn3Uc=;
	b=WTIoglLAwCsjONgPVN/lCHkTDkABPk/XrsEOGGR07s/NT11rDNUd2CvoQiwwguO3Pm8+Jm
	xFfJFxEDbMK7rgiSIaD9TFMr4fEUilz3M8x9E8+In1RTFI1PjtFAblpE0v1fw+aaVb4CZs
	J2KUro2Vzf/5Gm9xjBWkBlXOaQbmPIA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-146-fEpUFpxbOZGKJ5sRVGC3Mw-1; Thu,
 24 Apr 2025 05:03:07 -0400
X-MC-Unique: fEpUFpxbOZGKJ5sRVGC3Mw-1
X-Mimecast-MFC-AGG-ID: fEpUFpxbOZGKJ5sRVGC3Mw_1745485386
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E95ED180036E;
	Thu, 24 Apr 2025 09:03:05 +0000 (UTC)
Received: from fedora (unknown [10.72.116.127])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4303D1800374;
	Thu, 24 Apr 2025 09:03:00 +0000 (UTC)
Date: Thu, 24 Apr 2025 17:02:56 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V2 13/20] block: unifying elevator change
Message-ID: <aAn-QPbsIadxZQhe@fedora>
References: <20250418163708.442085-1-ming.lei@redhat.com>
 <20250418163708.442085-14-ming.lei@redhat.com>
 <28d4f3b8-1e42-451e-9754-ebf639b05aa2@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28d4f3b8-1e42-451e-9754-ebf639b05aa2@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Sat, Apr 19, 2025 at 06:56:14PM +0530, Nilay Shroff wrote:
> 
> 
> On 4/18/25 10:06 PM, Ming Lei wrote:
> > elevator change is one well-define behavior:
> > 
> > - tear down current elevator if it exists
> > 
> > - setup new elevator
> > 
> > It is supposed to cover any case for changing elevator by single
> > internal API, typically the following cases:
> > 
> > - setup default elevator in add_disk()
> > 
> > - switch to none in del_disk()
> > 
> > - reset elevator in blk_mq_update_nr_hw_queues()
> > 
> > - switch elevator in sysfs `store` elevator attribute
> > 
> > This patch uses elevator_change() to cover all above cases:
> > 
> > - every elevator switch is serialized with each other: add_disk/del_disk/
> > store elevator is serialized already, blk_mq_update_nr_hw_queues() uses
> > srcu for syncing with the other three cases
> > 
> > - for both add_disk()/del_disk(), queue freeze works at atomic mode
> > or has been froze, so the freeze in elevator_change() won't add extra
> > delay
> > 
> > - `struct elev_change_ctx` instance holds any info for changing elevator
> > 
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >  block/blk-sysfs.c | 18 ++++-------
> >  block/blk.h       |  5 ++-
> >  block/elevator.c  | 81 ++++++++++++++++++++++++++---------------------
> >  block/elevator.h  |  1 +
> >  block/genhd.c     | 19 +----------
> >  5 files changed, 55 insertions(+), 69 deletions(-)
> > 
> > diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
> > index a2882751f0d2..58c50709bc14 100644
> > --- a/block/blk-sysfs.c
> > +++ b/block/blk-sysfs.c
> > @@ -869,14 +869,8 @@ int blk_register_queue(struct gendisk *disk)
> >  	if (ret)
> >  		goto out_unregister_ia_ranges;
> >  
> > +	elevator_set_default(q);
> >  	mutex_lock(&q->elevator_lock);
> > -	if (q->elevator) {
> > -		ret = elv_register_queue(q, false);
> > -		if (ret) {
> > -			mutex_unlock(&q->elevator_lock);
> > -			goto out_crypto_sysfs_unregister;
> > -		}
> > -	}
> >  	wbt_enable_default(disk);
> >  	mutex_unlock(&q->elevator_lock);
> >  
> [...]
> [...]
> >  /*
> > diff --git a/block/genhd.c b/block/genhd.c
> > index 86c3db5b9305..de227aa923ed 100644
> > --- a/block/genhd.c
> > +++ b/block/genhd.c
> > @@ -438,12 +438,6 @@ static int __add_disk_fwnode(struct gendisk_data *data)
> >  		 */
> >  		if (disk->fops->submit_bio || disk->fops->poll_bio)
> >  			return -EINVAL;
> > -
> > -		/*
> > -		 * Initialize the I/O scheduler code and pick a default one if
> > -		 * needed.
> > -		 */
> > -		elevator_init_mq(disk->queue);
> >  	} else {
> >  		if (!disk->fops->submit_bio)
> >  			return -EINVAL;
> > @@ -587,11 +581,7 @@ static int __add_disk_fwnode(struct gendisk_data *data)
> >  	if (disk->major == BLOCK_EXT_MAJOR)
> >  		blk_free_ext_minor(disk->first_minor);
> >  out_exit_elevator:
> > -	if (disk->queue->elevator) {
> > -		mutex_lock(&disk->queue->elevator_lock);
> > -		elevator_exit(disk->queue);
> > -		mutex_unlock(&disk->queue->elevator_lock);
> > -	}
> > +	elevator_set_none(disk->queue);
> >  	return ret;
> >  }
> As we moved elevator init function (elevator_set_default) inside blk_register_queue, 
> we probably now don't need label out_exit_elevator in __add_disk_fwnode. In fact,
> no code in __add_disk_fwnode shall jump to this label.
> I think, elevator_set_none may be called anytime after we see failure post 
> blk_register_queue returns.

Good catch, 'out_exit_elevator' can rename as 'out', and the last
elevator_set_none() can be dropped.

Thanks,
Ming

