Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DEAA236445
	for <linux-block@vger.kernel.org>; Fri,  2 May 2025 12:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746190236; cv=none; b=pdFnvHXXlGmOMyXIbn0g4hkRVVlBMGbz/so86WdIsYB+TS4yERTxq00uJYTFLAit69Nnj3lKVmUMhJaAZTYOupT/n1BD/JZkiFfHIt6AoSJJysm48jgHkurdx4/1I4B0qLESHHxM6C+AaDJayyaypW580nCFuXcViZX7h55YJsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746190236; c=relaxed/simple;
	bh=/IlS9FFNMOwMunQ30pHuuq+zUXYIDXwxV1+qcyLY7dE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tIYk3h/u1GWtpgqr13l854BALPx3VwxE2m0nHROYbdmhlg5qDYXN8qFGq44ZddKRPIFj5y07KcuvP+dVAmiIUoY6XT5PDOCbFD7rXNqVL3LMeblmjzE7puZzNx33wvOwSJGAWMPkzX14fPcfDg9Ak/KShG2aVjru+AORUjQP1nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BW0zhNl6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BW0zhNl6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746190233;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EmYS/L67Y8dm/2dprGtg9Zqve4beur8uQddesZmpnuA=;
	b=BW0zhNl6RgILBQimfTtkaWasBn5CMjVynj8Ihg1ugEm7JWjEx0OJihqv4lMKuZEdIzhoZq
	0juc+2YnOTv+l94dt5UWXiItvFUfCVvfkWcB5GjW+qTtRWrn6IdYHFXgdkVwZ5QxXLO/yi
	BiWpM2x9Xcali8j4CTl54hkXCcPpg+o=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-653-NfbQGpu3O3-unOOJZKWikg-1; Fri,
 02 May 2025 08:50:30 -0400
X-MC-Unique: NfbQGpu3O3-unOOJZKWikg-1
X-Mimecast-MFC-AGG-ID: NfbQGpu3O3-unOOJZKWikg_1746190229
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 432CB1800368;
	Fri,  2 May 2025 12:50:28 +0000 (UTC)
Received: from fedora (unknown [10.72.116.6])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F14AB1956094;
	Fri,  2 May 2025 12:50:22 +0000 (UTC)
Date: Fri, 2 May 2025 20:50:16 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH V4 20/24] block: move elv_register[unregister]_queue out
 of elevator_lock
Message-ID: <aBS_iEczViFkx9Jb@fedora>
References: <20250430043529.1950194-1-ming.lei@redhat.com>
 <20250430043529.1950194-21-ming.lei@redhat.com>
 <089e64c6-ea36-409b-8771-a029e88b4972@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <089e64c6-ea36-409b-8771-a029e88b4972@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On Thu, May 01, 2025 at 03:56:03PM +0530, Nilay Shroff wrote:
> 
> 
...

> > diff --git a/block/genhd.c b/block/genhd.c
> > index 0e64e7400fb4..59d9febd8c14 100644
> > --- a/block/genhd.c
> > +++ b/block/genhd.c
> > @@ -751,11 +751,17 @@ static void __del_gendisk(struct gendisk *disk)
> >  
> >  static void disable_elv_switch(struct request_queue *q)
> >  {
> > +	struct blk_mq_tag_set *set = q->tag_set;
> > +
> >  	WARN_ON_ONCE(!queue_is_mq(q));
> >  
> >  	mutex_lock(&q->elevator_lock);
> >  	blk_queue_flag_set(QUEUE_FLAG_NO_ELV_SWITCH, q);
> >  	mutex_unlock(&q->elevator_lock);
> > +
> > +	/* wait until in-progress elevator switch is done */
> > +	down_write(&set->update_nr_hwq_lock);
> > +	up_write(&set->update_nr_hwq_lock);
> >  }
> >  
> >  /**
> 
> The disable_elv_switch which is now called just before __del_gendisk 
> disables elevator switch using QUEUE_FLAG_NO_ELV_SWITCH. And I also see
> write-lock (set->update_nr_hwq_lock) in disable_elv_switch which intends
> to wait until in-progress elevator switch is finished but that may not help
> because there's a small window in elv_iosched_store where it evaluates 
> "elevator-switching-disabled" and then when it actually acquires the 
> read-lock (set->update_nr_hwq_lock).
> 
> During the above window, if disable_elv_switch runs then we may enter into 
> the race, where we'd see elv_iosched_store and __del_gendisk running 
> concurrently.

You are right.

> 
> So we may want to update disable_elv_switch such that setting QUEUE_FLAG_
> NO_ELV_SWITCH is protected with write-lock (set->update_nr_hwq_lock) and
> if we do that then we may also not need q->elevator_lock in disable_elv_switch.
> Or another way to fix it might be to move read-lock (set->update_nr_hwq_lock) 
> at the top in elv_iosched_store.  

Looks the approach is good.


Thanks,
Ming

