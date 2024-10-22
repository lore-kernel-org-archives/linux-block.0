Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1EF12B93
	for <linux-block@vger.kernel.org>; Tue, 22 Oct 2024 18:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729622782; cv=none; b=G5ZqJYGT5rnlsdz5STwekDlQ8jI39rnsDDMSpR1BAUo2z0TS3jYT6DfepElrz8doBqzVU1hLuIL4aPZmHTB0PxqBUUJlicI7g6bgLQzI8WIoVm4Xim0YsOMFoKEXwRGZ4T9Sg4ctojdXjQ7dNgD1w9qpB44Lr5tTfkYh0KgX82c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729622782; c=relaxed/simple;
	bh=ddHUAQe7V7I2QyhJMLvFrl/Irg7EX1sasLa7r7Rkp1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iAFzHOXA5ccn365VR7udmF9aMj3jAcSz3tYv6zYvLm/6QMq4kPpjkZi0VJgV2ORmuokPz+kLBE4Tc6rK/GUUhbhjr1V0wEKqoeRBFEg5OVtT7hgjj8O2FLAGGrCfsDM/OkFYrJjR8PoCjfLLY+JZUTcOmNIKynBsDaPYY1S3KCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iaqsguiI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iaqsguiI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729622779;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k8tLD3CI7E5sRuXkeFnUjHcUQQplTqarTlnIPHod/vw=;
	b=iaqsguiI5quDDiA5owWcvDRcdVh9kA4426+Gli3J36MqZZDr7RDUrJ4sRkE/TI+AycyEqW
	Xfp1z6/9NyRZzBY7uhQFtiLHjF8u6+wOw7bK8RhvRRNO0O6gVFpqXIjTUued1f07MbyT9d
	+OBA1EXIUUmP6bbCNBq259GIpQ3vEIo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-626-UG1dWRuSP_OVXFMt1KCV5g-1; Tue,
 22 Oct 2024 14:46:17 -0400
X-MC-Unique: UG1dWRuSP_OVXFMt1KCV5g-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D140D195608B;
	Tue, 22 Oct 2024 18:46:15 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.70])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2E1FF1956088;
	Tue, 22 Oct 2024 18:46:11 +0000 (UTC)
Date: Tue, 22 Oct 2024 20:46:07 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	josef@toxicpanda.com, nbd@other.debian.org, eblake@redhat.com,
	vincent.chen@sifive.com, Leon Schuermann <leon@is.currently.online>,
	Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH V2] nbd: fix partial sending
Message-ID: <Zxfy7-xIsoMVtUlz@redhat.com>
References: <20241018140831.3064135-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241018140831.3064135-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Am 18.10.2024 um 16:08 hat Ming Lei geschrieben:
> nbd driver sends request header and payload with multiple call of
> sock_sendmsg, and partial sending can't be avoided. However, nbd driver
> returns BLK_STS_RESOURCE to block core in this situation. This way causes
> one issue: request->tag may change in the next run of nbd_queue_rq(), but
> the original old tag has been sent as part of header cookie, this way
> confuses nbd driver reply handling, since the real request can't be
> retrieved any more with the obsolete old tag.
> 
> Fix it by retrying sending directly in per-socket work function,
> meantime return BLK_STS_OK to block layer core.
> 
> Cc: vincent.chen@sifive.com
> Cc: Leon Schuermann <leon@is.currently.online>
> Cc: Bart Van Assche <bvanassche@acm.org>
> Reported-by: Kevin Wolf <kwolf@redhat.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
> V2:
> 	- move pending retry to socket work function and return BLK_STS_OK, so that
> 	userspace can get chance to handle the signal(Kevin)

So first of all: This seems to work.

But looking through the code I have a few comments:

>  drivers/block/nbd.c | 89 +++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 77 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> index b852050d8a96..855f4a79e37c 100644
> --- a/drivers/block/nbd.c
> +++ b/drivers/block/nbd.c
> @@ -62,6 +62,7 @@ struct nbd_sock {
>  	bool dead;
>  	int fallback_index;
>  	int cookie;
> +	struct work_struct work;
>  };
>  
>  struct recv_thread_args {
> @@ -141,6 +142,9 @@ struct nbd_device {
>   */
>  #define NBD_CMD_INFLIGHT	2
>  
> +/* Just part of request header or data payload is sent successfully */
> +#define NBD_CMD_PARTIAL_SEND	3
> +
>  struct nbd_cmd {
>  	struct nbd_device *nbd;
>  	struct mutex lock;
> @@ -466,6 +470,12 @@ static enum blk_eh_timer_return nbd_xmit_timeout(struct request *req)
>  	if (!mutex_trylock(&cmd->lock))
>  		return BLK_EH_RESET_TIMER;
>  
> +	/* partial send is handled in nbd_sock's work function */
> +	if (test_bit(NBD_CMD_PARTIAL_SEND, &cmd->flags)) {
> +		mutex_unlock(&cmd->lock);
> +		return BLK_EH_RESET_TIMER;
> +	}
> +
>  	if (!test_bit(NBD_CMD_INFLIGHT, &cmd->flags)) {
>  		mutex_unlock(&cmd->lock);
>  		return BLK_EH_DONE;
> @@ -614,6 +624,27 @@ static inline int was_interrupted(int result)
>  	return result == -ERESTARTSYS || result == -EINTR;
>  }
>  
> +/*
> + * We've already sent header or part of data payload, have no choice but
> + * to set pending and schedule it in work.
> + *
> + * And we have to return BLK_STS_OK to block core, otherwise this same
> + * request may be re-dispatched with different tag, but our header has
> + * been sent out with old tag, and this way does confuse reply handling.
> + */
> +static void nbd_run_pending_work(struct nbd_device *nbd,
> +				 struct nbd_sock *nsock,
> +				 struct nbd_cmd *cmd, int sent)

The name of this function is a bit confusing, we don't actually run
anything here. Maybe nbd_schedule_pending_work()? Or something else with
"schedule" and "send".

> +{
> +	struct request *req = blk_mq_rq_from_pdu(cmd);
> +
> +	nsock->pending = req;
> +	nsock->sent = sent;
> +	set_bit(NBD_CMD_PARTIAL_SEND, &cmd->flags);
> +	refcount_inc(&nbd->config_refs);
> +	schedule_work(&nsock->work);
> +}

Important point about this function: It doesn't check if we already have
scheduled the work. You seem to have some code in nbd_pending_cmd_work()
that can cope with being scheduled multiple times, but allowing the
situation makes the control flow hard to follow. It would probably be
better to avoid this and call refcount_inc() and schedule_work() only if
NBD_CMD_PARTIAL_SEND isn't already set.

> +
>  /*
>   * Returns BLK_STS_RESOURCE if the caller should retry after a delay.
>   * Returns BLK_STS_IOERR if sending failed.
> @@ -699,11 +730,12 @@ static blk_status_t nbd_send_cmd(struct nbd_device *nbd, struct nbd_cmd *cmd,
>  			 * completely done.
>  			 */
>  			if (sent) {
> -				nsock->pending = req;
> -				nsock->sent = sent;
> +				nbd_run_pending_work(nbd, nsock, cmd, sent);
> +				return BLK_STS_OK;

Now the question is if requeuing is already implicitly avoided, because
returning EINTR to a worker doesn't seem to make a lot of sense to me,
and so we might actually never hit this code path from a worker. But I'm
not completely sure. Maybe better to detect the situation in
nbd_run_pending_work() anyway.

> +			} else {
> +				set_bit(NBD_CMD_REQUEUED, &cmd->flags);
> +				return BLK_STS_RESOURCE;
>  			}
> -			set_bit(NBD_CMD_REQUEUED, &cmd->flags);
> -			return BLK_STS_RESOURCE;

This is an unrelated style change.

>  		}
>  		dev_err_ratelimited(disk_to_dev(nbd->disk),
>  			"Send control failed (result %d)\n", result);
> @@ -737,14 +769,8 @@ static blk_status_t nbd_send_cmd(struct nbd_device *nbd, struct nbd_cmd *cmd,
>  			result = sock_xmit(nbd, index, 1, &from, flags, &sent);
>  			if (result < 0) {
>  				if (was_interrupted(result)) {
> -					/* We've already sent the header, we
> -					 * have no choice but to set pending and
> -					 * return BUSY.
> -					 */
> -					nsock->pending = req;
> -					nsock->sent = sent;
> -					set_bit(NBD_CMD_REQUEUED, &cmd->flags);
> -					return BLK_STS_RESOURCE;
> +					nbd_run_pending_work(nbd, nsock, cmd, sent);
> +					return BLK_STS_OK;
>  				}
>  				dev_err(disk_to_dev(nbd->disk),
>  					"Send data failed (result %d)\n",
> @@ -778,6 +804,44 @@ static blk_status_t nbd_send_cmd(struct nbd_device *nbd, struct nbd_cmd *cmd,
>  	return BLK_STS_OK;
>  }
>  
> +/* handle partial sending */
> +static void nbd_pending_cmd_work(struct work_struct *work)
> +{
> +	struct nbd_sock *nsock = container_of(work, struct nbd_sock, work);
> +	struct request *req = nsock->pending;
> +	struct nbd_cmd *cmd = blk_mq_rq_to_pdu(req);
> +	struct nbd_device *nbd = cmd->nbd;
> +	unsigned long deadline = READ_ONCE(req->deadline);
> +	unsigned int wait_ms = 2;
> +
> +	mutex_lock(&cmd->lock);
> +
> +	WARN_ON_ONCE(test_bit(NBD_CMD_REQUEUED, &cmd->flags));
> +	if (!test_bit(NBD_CMD_PARTIAL_SEND, &cmd->flags))
> +		goto out;

I believe this check is only for detecting if the work was scheduled
multiple times? If we avoid that above, we probably can make this a
WARN_ON_ONCE(), too.

> +
> +	mutex_lock(&nsock->tx_lock);
> +	while (true) {
> +		nbd_send_cmd(nbd, cmd, cmd->index);
> +		if (!nsock->pending)
> +			break;

If it's true that we can never get EINTR or ERESTARTSYS in a worker,
then this condition would always be true and the loop and sleeping logic
is unnecessary.

If it actually is necessary, I wonder if it wouldn't be better to just
let nbd_send_cmd() reschedule the work without a loop and sleeping here.
I'm not entirely sure what EINTR/ERESTARTSYS should even mean in this
context, but like in the .queue_rq() path, the thing that clears these
error conditions would probably be returning, not sleeping?

> +
> +		/* don't bother timeout handler for partial sending */
> +		if (READ_ONCE(jiffies) + msecs_to_jiffies(wait_ms) >= deadline) {
> +			cmd->status = BLK_STS_IOERR;
> +			blk_mq_complete_request(req);
> +			break;
> +		}
> +		msleep(wait_ms);
> +		wait_ms *= 2;
> +	}
> +	mutex_unlock(&nsock->tx_lock);
> +	clear_bit(NBD_CMD_PARTIAL_SEND, &cmd->flags);
> +out:
> +	mutex_unlock(&cmd->lock);
> +	nbd_config_put(nbd);
> +}

Kevin

