Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8ADE552
	for <linux-block@vger.kernel.org>; Tue, 15 Apr 2025 01:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744681754; cv=none; b=NecP1pSUsKZQ2nLeudrfDZyTcq7WJ7h9Xf+WKzaqFxAjTcgfzz++k2+M6wfx+yyN/NqzYiGFUE8zVMcjuL4HmYFRAAp5T3JYMX48W5b8UlQ1ujcTlOUz8wPuPuvUq8VDpysGlOi6qs5lGZcYz9V8OeUEuaX6imt8eDViP757wUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744681754; c=relaxed/simple;
	bh=cUrrbpNXLtUWNU7wLYWoCocXv3U4gzTvmzyFPSBC+mM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KF57NdTcei1+LwPtDHrQHFy0GwFcW18M4J8Oc1ASF20mHDoMCFpMTwLl24tOYvsUewZ2HlLm2PLfyiqC+isPEy+TMCDDs37IHNRzMhR/krWYYR1noJahu8AuLiNTMdCIhmVpZFKUkJexPga3CwYM3x/7rugE8Rjv1y9iJTOVXJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GmFfPpHv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GmFfPpHv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744681751;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h4oeOqVnJiYYytdpm0oz7MyIB81aw7HkHuyl62DjnDg=;
	b=GmFfPpHvoyLTktrfK117NYDQPiQv/HaeE0NJ2A08Xh/oNXPzMgMFpHCpr/3AWdQOyHJybq
	gAnkVgfaAuggiJxa8u4TBCSmqkH7L9c2BXQm5b9SBnNL8ZA98WBj4w6IjwiYSrTQP8P0g0
	vI/Y68idftzb7p9XNKcOISwEqj5SyGM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-686-Il9TYClTP3-hQjktHrm7-A-1; Mon,
 14 Apr 2025 21:49:06 -0400
X-MC-Unique: Il9TYClTP3-hQjktHrm7-A-1
X-Mimecast-MFC-AGG-ID: Il9TYClTP3-hQjktHrm7-A_1744681745
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5D6A3180025C;
	Tue, 15 Apr 2025 01:49:05 +0000 (UTC)
Received: from fedora (unknown [10.72.116.40])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C0AA91808869;
	Tue, 15 Apr 2025 01:49:01 +0000 (UTC)
Date: Tue, 15 Apr 2025 09:48:56 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Uday Shankar <ushankar@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: Re: [PATCH 4/9] ublk: rely on ->canceling for dealing with
 ublk_nosrv_dev_should_queue_io
Message-ID: <Z_27CByI8YfVy4yW@fedora>
References: <20250414112554.3025113-1-ming.lei@redhat.com>
 <20250414112554.3025113-5-ming.lei@redhat.com>
 <Z/1s63BGwt3rySq0@dev-ushankar.dev.purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z/1s63BGwt3rySq0@dev-ushankar.dev.purestorage.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Mon, Apr 14, 2025 at 02:15:39PM -0600, Uday Shankar wrote:
> On Mon, Apr 14, 2025 at 07:25:45PM +0800, Ming Lei wrote:
> > Now ublk deals with ublk_nosrv_dev_should_queue_io() by keeping request
> > queue as quiesced. This way is fragile because queue quiesce crosses syscalls
> > or process contexts.
> > 
> > Switch to rely on ubq->canceling for dealing with ublk_nosrv_dev_should_queue_io(),
> > because it has been used for this purpose during io_uring context exiting, and it
> > can be reused before recovering too.
> > 
> > Meantime we have to move reset of ubq->canceling from ublk_ctrl_end_recovery() to
> > ublk_ctrl_end_recovery(), when IO handling can be recovered completely.
> 
> First one here should be ublk_ctrl_start_recovery or ublk_queue_reinit

Yeah.

> 
> > 
> > Then blk_mq_quiesce_queue() and blk_mq_unquiesce_queue() are always used
> > in same context.
> > 
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >  drivers/block/ublk_drv.c | 31 +++++++++++++++++--------------
> >  1 file changed, 17 insertions(+), 14 deletions(-)
> > 
> > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > index 7e2c4084c243..e0213222e3cf 100644
> > --- a/drivers/block/ublk_drv.c
> > +++ b/drivers/block/ublk_drv.c
> > @@ -1734,13 +1734,19 @@ static void ublk_wait_tagset_rqs_idle(struct ublk_device *ub)
> >  
> >  static void __ublk_quiesce_dev(struct ublk_device *ub)
> >  {
> > +	int i;
> > +
> >  	pr_devel("%s: quiesce ub: dev_id %d state %s\n",
> >  			__func__, ub->dev_info.dev_id,
> >  			ub->dev_info.state == UBLK_S_DEV_LIVE ?
> >  			"LIVE" : "QUIESCED");
> >  	blk_mq_quiesce_queue(ub->ub_disk->queue);
> > +	/* mark every queue as canceling */
> > +	for (i = 0; i < ub->dev_info.nr_hw_queues; i++)
> > +		ublk_get_queue(ub, i)->canceling = true;
> >  	ublk_wait_tagset_rqs_idle(ub);
> >  	ub->dev_info.state = UBLK_S_DEV_QUIESCED;
> > +	blk_mq_unquiesce_queue(ub->ub_disk->queue);
> 
> So the queue is not actually quiesced when we are in UBLK_S_DEV_QUIESCED
> anymore, and we rely on __ublk_abort_rq to requeue I/O submitted in this
> QUIESCED state. This requeued I/O will immediately resubmit, right?
> Isn't this a waste of CPU?

__ublk_abort_rq() just adds request into requeue list, and doesn't requeue
actually, so there isn't waste of CPU.

Thanks,
Ming

