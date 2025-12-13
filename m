Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87DE227C84B
	for <linux-block@vger.kernel.org>; Sat, 13 Dec 2025 02:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765592935; cv=none; b=dO1j2vAMc0t9CINR8ADMwgSZqC08PeI1zWlz7yKhxH1HeemRkbp87dTuUBS8ye1Od3wOztQ5thasfZKUA3ZJi4GE9ptZ8ogxbBBmIQBqx5O9p2nI3dYKj5KXJ0Z2UqEHeOv9xYkF9eSNXb2fjmS8gOsQlx4Eg1X7rDQsoFcYgeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765592935; c=relaxed/simple;
	bh=Y0m42bZs35aF+FdAKBGbPHfzCXOkZULNDrSfTHg+JeA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nkXu4yTQLYlEpE+BksPX4CT27pGDbyDpVA9yauV7CBQ6bRVZI44QkwhZqwsVE3fttI/+cCijr0XeiH5yUAr4ASwL793tX25oJOVNaVvyIFWvQBjPvzzpn7PEf9ld+cPlgkErJkCBFhASvHZdsJIPNmMg8QA4U3IcOct/OxOKiyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Yanyy+yL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yanyy+yL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765592929;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l6jqiWGeiVQFWMxcUhP5hD16LVKE0CgUNPDXF2wyIS8=;
	b=Yanyy+yL390XYTFUusGU977nTcHdhzLPX3lAAa6n6s/3JCOgfYkxTqbZ4HOYDCGLMUkYu8
	3BXmdKPC1nyORwvmXnnp1DVkA37QxZlos8L40iBm9rDQhJyKE01VRqBGpMMc15puN9zMvI
	xv+Yvsy+jMEDlG8IN8FxEusW5nKD09c=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-679-3KLS-PgAPoCTuPp28val0Q-1; Fri,
 12 Dec 2025 21:28:46 -0500
X-MC-Unique: 3KLS-PgAPoCTuPp28val0Q-1
X-Mimecast-MFC-AGG-ID: 3KLS-PgAPoCTuPp28val0Q_1765592924
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 60AAA1956088;
	Sat, 13 Dec 2025 02:28:44 +0000 (UTC)
Received: from fedora (unknown [10.72.116.30])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4BC4E180044F;
	Sat, 13 Dec 2025 02:28:40 +0000 (UTC)
Date: Sat, 13 Dec 2025 10:28:35 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>
Subject: Re: [PATCH V2] ublk: fix deadlock when reading partition table
Message-ID: <aTzPUzyZ21lVOk1L@fedora>
References: <20251212143415.485359-1-ming.lei@redhat.com>
 <8dd3c141-3e92-44f3-91e2-2bf4827b36a4@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8dd3c141-3e92-44f3-91e2-2bf4827b36a4@kernel.dk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Fri, Dec 12, 2025 at 12:49:49PM -0700, Jens Axboe wrote:
> On 12/12/25 7:34 AM, Ming Lei wrote:
> > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > index df9831783a13..38f138f248e6 100644
> > --- a/drivers/block/ublk_drv.c
> > +++ b/drivers/block/ublk_drv.c
> > @@ -1080,12 +1080,20 @@ static inline struct ublk_uring_cmd_pdu *ublk_get_uring_cmd_pdu(
> >  	return io_uring_cmd_to_pdu(ioucmd, struct ublk_uring_cmd_pdu);
> >  }
> >  
> > +static void ublk_end_request(struct request *req, blk_status_t error)
> > +{
> > +	local_bh_disable();
> > +	blk_mq_end_request(req, error);
> > +	local_bh_enable();
> > +}
> 
> This is really almost too ugly to live, as a work-around for what just
> happens to be in __fput_deferred()... Surely we can come up with
> something better here? Heck even a PF_ flag would be better than this,
> imho.

task flag will switch to release all files opened by current from wq context,
and there may be chance to cause regression, especially this fix needs to
backport to stable.

So I'd suggest to take it for safe stable purpose.


> 
> > @@ -1117,14 +1125,26 @@ static inline void __ublk_complete_rq(struct request *req, struct ublk_io *io,
> >  	if (unlikely(unmapped_bytes < io->res))
> >  		io->res = unmapped_bytes;
> >  
> > -	if (blk_update_request(req, BLK_STS_OK, io->res))
> > +	/*
> > +	 * Run bio->bi_end_io() from softirq context for preventing this
> > +	 * ublk's blkdev_release() from being called on current's task
> > +	 * work, see fput() implementation.
> 
> But that's not what it does, running it from softirq context. It simply
> disables local bottomhalf interrupts to trick __fput_deferred(), it's
> not scheduling ->bi_end_io() to run from softirq context itself.

Yes, I can twink the words if you don't object this approach, but it isn't
different from core code viewpoint, in_interrupt() returns true.

Thanks,
Ming

