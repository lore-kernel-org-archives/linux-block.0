Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9669F8467
	for <linux-block@vger.kernel.org>; Wed, 23 Oct 2024 02:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729649027; cv=none; b=eMim8hh66jDvxE+EgTGkD9qUKRfFPuh+yzNKXWqD7BmdoBRhp60eGniNg0u2Bn0aOnrnV+jkl8EmzwipY5NDmqR3+KSRWzrC/2OiGne8oaardSNoyWt0cZDXrSpOW6FwX49LGQitaqKLVb1zgF7nhT24ps7BCJsMACs6yb2OPv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729649027; c=relaxed/simple;
	bh=A5Tto6PGZcfydVO8FV3N1EWc+8gYYlALiqsHmivbMa0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QwL/sLBTBqfEHeNGb3bBAN2uX8RK8NWLTYDq8IuVCV6GmAHcdoQ/QaP7SVgxtvXikYBBaIw3K3IIm1e4vJNpl4OreTNl1n2zfAnkpiBBtZb9uZBk7FEwhcN/n20xtu/SzhQ0SnbcvfkYMaGt5QAnCH3WtqZvgynnUn8NF4HPK2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NJewoD3P; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NJewoD3P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729649024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HIoRDZHRUmsXP2kKOMmZ32TrojNAFGflC0/1StrGcSE=;
	b=NJewoD3PZB62GZJT5ff6WTIywM6jlfO72N/MN6Z7jcxMrKvWKWX1qhmSpIg37qX4obM7Ik
	RerVYZYwMmdyiINBCVAqnSl6uIETyF35PpKLSoetp+e8QkAzoXD6gocXiMeDD0GLNEypkU
	IyppOfwnb+Gm/3YIv+/sbzOguiLNjcQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-611-ECR0eJmiOrGrXS-ijWd0VQ-1; Tue,
 22 Oct 2024 22:03:40 -0400
X-MC-Unique: ECR0eJmiOrGrXS-ijWd0VQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4FF7819560AA;
	Wed, 23 Oct 2024 02:03:39 +0000 (UTC)
Received: from fedora (unknown [10.72.116.47])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3E3481955EA3;
	Wed, 23 Oct 2024 02:03:32 +0000 (UTC)
Date: Wed, 23 Oct 2024 10:03:27 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	josef@toxicpanda.com, nbd@other.debian.org, eblake@redhat.com,
	vincent.chen@sifive.com, Leon Schuermann <leon@is.currently.online>,
	Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH V2] nbd: fix partial sending
Message-ID: <ZxhZb_HCeMYwBOkk@fedora>
References: <20241018140831.3064135-1-ming.lei@redhat.com>
 <Zxfy7-xIsoMVtUlz@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zxfy7-xIsoMVtUlz@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Tue, Oct 22, 2024 at 08:46:07PM +0200, Kevin Wolf wrote:
> Am 18.10.2024 um 16:08 hat Ming Lei geschrieben:
> > nbd driver sends request header and payload with multiple call of
> > sock_sendmsg, and partial sending can't be avoided. However, nbd driver
> > returns BLK_STS_RESOURCE to block core in this situation. This way causes
> > one issue: request->tag may change in the next run of nbd_queue_rq(), but
> > the original old tag has been sent as part of header cookie, this way
> > confuses nbd driver reply handling, since the real request can't be
> > retrieved any more with the obsolete old tag.
> > 
> > Fix it by retrying sending directly in per-socket work function,
> > meantime return BLK_STS_OK to block layer core.
> > 
> > Cc: vincent.chen@sifive.com
> > Cc: Leon Schuermann <leon@is.currently.online>
> > Cc: Bart Van Assche <bvanassche@acm.org>
> > Reported-by: Kevin Wolf <kwolf@redhat.com>
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> > V2:
> > 	- move pending retry to socket work function and return BLK_STS_OK, so that
> > 	userspace can get chance to handle the signal(Kevin)
> 
> So first of all: This seems to work.
> 
> But looking through the code I have a few comments:
> 
> >  drivers/block/nbd.c | 89 +++++++++++++++++++++++++++++++++++++++------
> >  1 file changed, 77 insertions(+), 12 deletions(-)
> > 
> > diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> > index b852050d8a96..855f4a79e37c 100644
> > --- a/drivers/block/nbd.c
> > +++ b/drivers/block/nbd.c
> > @@ -62,6 +62,7 @@ struct nbd_sock {
> >  	bool dead;
> >  	int fallback_index;
> >  	int cookie;
> > +	struct work_struct work;
> >  };
> >  
> >  struct recv_thread_args {
> > @@ -141,6 +142,9 @@ struct nbd_device {
> >   */
> >  #define NBD_CMD_INFLIGHT	2
> >  
> > +/* Just part of request header or data payload is sent successfully */
> > +#define NBD_CMD_PARTIAL_SEND	3
> > +
> >  struct nbd_cmd {
> >  	struct nbd_device *nbd;
> >  	struct mutex lock;
> > @@ -466,6 +470,12 @@ static enum blk_eh_timer_return nbd_xmit_timeout(struct request *req)
> >  	if (!mutex_trylock(&cmd->lock))
> >  		return BLK_EH_RESET_TIMER;
> >  
> > +	/* partial send is handled in nbd_sock's work function */
> > +	if (test_bit(NBD_CMD_PARTIAL_SEND, &cmd->flags)) {
> > +		mutex_unlock(&cmd->lock);
> > +		return BLK_EH_RESET_TIMER;
> > +	}
> > +
> >  	if (!test_bit(NBD_CMD_INFLIGHT, &cmd->flags)) {
> >  		mutex_unlock(&cmd->lock);
> >  		return BLK_EH_DONE;
> > @@ -614,6 +624,27 @@ static inline int was_interrupted(int result)
> >  	return result == -ERESTARTSYS || result == -EINTR;
> >  }
> >  
> > +/*
> > + * We've already sent header or part of data payload, have no choice but
> > + * to set pending and schedule it in work.
> > + *
> > + * And we have to return BLK_STS_OK to block core, otherwise this same
> > + * request may be re-dispatched with different tag, but our header has
> > + * been sent out with old tag, and this way does confuse reply handling.
> > + */
> > +static void nbd_run_pending_work(struct nbd_device *nbd,
> > +				 struct nbd_sock *nsock,
> > +				 struct nbd_cmd *cmd, int sent)
> 
> The name of this function is a bit confusing, we don't actually run
> anything here. Maybe nbd_schedule_pending_work()? Or something else with
> "schedule" and "send".

Fine, but blk-mq does has blk_mq_run_hw_queue().

> 
> > +{
> > +	struct request *req = blk_mq_rq_from_pdu(cmd);
> > +
> > +	nsock->pending = req;
> > +	nsock->sent = sent;
> > +	set_bit(NBD_CMD_PARTIAL_SEND, &cmd->flags);
> > +	refcount_inc(&nbd->config_refs);
> > +	schedule_work(&nsock->work);
> > +}
> 
> Important point about this function: It doesn't check if we already have
> scheduled the work. You seem to have some code in nbd_pending_cmd_work()
> that can cope with being scheduled multiple times, but allowing the
> situation makes the control flow hard to follow. It would probably be
> better to avoid this and call refcount_inc() and schedule_work() only if
> NBD_CMD_PARTIAL_SEND isn't already set.

The function can be called only once because BLK_STS_OK means the request
ownership is transferred to nbd now.

But we can add

	WARN_ON_ONCE(test_bit(NBD_CMD_PARTIAL_SEND, &cmd->flags));

here.

> 
> > +
> >  /*
> >   * Returns BLK_STS_RESOURCE if the caller should retry after a delay.
> >   * Returns BLK_STS_IOERR if sending failed.
> > @@ -699,11 +730,12 @@ static blk_status_t nbd_send_cmd(struct nbd_device *nbd, struct nbd_cmd *cmd,
> >  			 * completely done.
> >  			 */
> >  			if (sent) {
> > -				nsock->pending = req;
> > -				nsock->sent = sent;
> > +				nbd_run_pending_work(nbd, nsock, cmd, sent);
> > +				return BLK_STS_OK;
> 
> Now the question is if requeuing is already implicitly avoided, because

Yes, requeue is supposed to be exclusive with handling pending request,
but V2 still may allow requeue from pending work context, will fix it.

> returning EINTR to a worker doesn't seem to make a lot of sense to me,
> and so we might actually never hit this code path from a worker. But I'm
> not completely sure. Maybe better to detect the situation in
> nbd_run_pending_work() anyway.
> 
> > +			} else {
> > +				set_bit(NBD_CMD_REQUEUED, &cmd->flags);
> > +				return BLK_STS_RESOURCE;
> >  			}
> > -			set_bit(NBD_CMD_REQUEUED, &cmd->flags);
> > -			return BLK_STS_RESOURCE;
> 
> This is an unrelated style change.

Fine.

> 
> >  		}
> >  		dev_err_ratelimited(disk_to_dev(nbd->disk),
> >  			"Send control failed (result %d)\n", result);
> > @@ -737,14 +769,8 @@ static blk_status_t nbd_send_cmd(struct nbd_device *nbd, struct nbd_cmd *cmd,
> >  			result = sock_xmit(nbd, index, 1, &from, flags, &sent);
> >  			if (result < 0) {
> >  				if (was_interrupted(result)) {
> > -					/* We've already sent the header, we
> > -					 * have no choice but to set pending and
> > -					 * return BUSY.
> > -					 */
> > -					nsock->pending = req;
> > -					nsock->sent = sent;
> > -					set_bit(NBD_CMD_REQUEUED, &cmd->flags);
> > -					return BLK_STS_RESOURCE;
> > +					nbd_run_pending_work(nbd, nsock, cmd, sent);
> > +					return BLK_STS_OK;
> >  				}
> >  				dev_err(disk_to_dev(nbd->disk),
> >  					"Send data failed (result %d)\n",
> > @@ -778,6 +804,44 @@ static blk_status_t nbd_send_cmd(struct nbd_device *nbd, struct nbd_cmd *cmd,
> >  	return BLK_STS_OK;
> >  }
> >  
> > +/* handle partial sending */
> > +static void nbd_pending_cmd_work(struct work_struct *work)
> > +{
> > +	struct nbd_sock *nsock = container_of(work, struct nbd_sock, work);
> > +	struct request *req = nsock->pending;
> > +	struct nbd_cmd *cmd = blk_mq_rq_to_pdu(req);
> > +	struct nbd_device *nbd = cmd->nbd;
> > +	unsigned long deadline = READ_ONCE(req->deadline);
> > +	unsigned int wait_ms = 2;
> > +
> > +	mutex_lock(&cmd->lock);
> > +
> > +	WARN_ON_ONCE(test_bit(NBD_CMD_REQUEUED, &cmd->flags));
> > +	if (!test_bit(NBD_CMD_PARTIAL_SEND, &cmd->flags))
> > +		goto out;
> 
> I believe this check is only for detecting if the work was scheduled
> multiple times? If we avoid that above, we probably can make this a
> WARN_ON_ONCE(), too.

The check can be killed or changed to WARN_ON_ONCE().

> 
> > +
> > +	mutex_lock(&nsock->tx_lock);
> > +	while (true) {
> > +		nbd_send_cmd(nbd, cmd, cmd->index);
> > +		if (!nsock->pending)
> > +			break;
> 
> If it's true that we can never get EINTR or ERESTARTSYS in a worker,
> then this condition would always be true and the loop and sleeping logic
> is unnecessary.

kernel thread is capable of handling signal, but seems doesn't make
sense to get EINTR or ERESTARTSYS from kworker context.

But it doesn't matter here.

> 
> If it actually is necessary, I wonder if it wouldn't be better to just
> let nbd_send_cmd() reschedule the work without a loop and sleeping here.
> I'm not entirely sure what EINTR/ERESTARTSYS should even mean in this
> context, but like in the .queue_rq() path, the thing that clears these
> error conditions would probably be returning, not sleeping?

Yeah, it is necessary because nbd_pending_cmd_work() may not move
on, and the pending condition is still true, such as send socket buffer
is full, then we still need to wait and retry.

V2 doesn't handle this case, so requeue may be triggered, which is
wrong.


Thanks, 
Ming

