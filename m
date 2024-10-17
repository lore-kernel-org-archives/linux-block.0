Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3EBE1D47AC
	for <linux-block@vger.kernel.org>; Thu, 17 Oct 2024 15:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729180090; cv=none; b=VRfh1Kr68FhXRmBbXFn+BMEhyvDhFERmDTZLoX8AU1P1p0JRy1SfAoEUq2rTT6sTwho+ninXePYoN/Prk8EbajYjjNFSMAKwbtzqdJ4nUB7ewfFPUbHgNbaUG9kAMV6VoGC8ZAgOWcrk26IFDRRGS2iRPKZlFEfTrdzQ+TPvdto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729180090; c=relaxed/simple;
	bh=gnmyZZ49v9ju8GP0Lh8E7mHc2YtSuA0JGHxaFFzYXPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RMOV9fbwXtaYga6DnXs/YHJetc/u+Bb6ap7kbN7R7le0L0LJb+SdVObFHPPgnNDrHNTuzOPaLK0gEFWNbx6mfzt/MeepzMyWsMEy36Bqhm4TOeEOoqUFAybNut4Ii0I2TZzAaDvArMjXcCC8mql4cBydbYxRZAva1NyDwYeXOMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LCt4ddXU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LCt4ddXU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729180084;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CkJIgd3MOKUyNmAOO8gKZqK4l1/szFdaieOcQRfp1Cg=;
	b=LCt4ddXU1WDxKwaJFyL8ts8mcx/eSzS6SOAHkXM+GaVvCybhSAzEt5fTYoJ49S6mNAU7pq
	I7MFqFZDRgjLsGvm24BZePnDQjqiz/DLVykAVHiNTrQqi6JGSpQJzaC9PESDIyQA4DqSkg
	FJRpJmtI/ci7HfMk6G+X+0Wa4ByPaNs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-82-bbeqPzlpPtO9aunp2Sqk7g-1; Thu,
 17 Oct 2024 11:48:01 -0400
X-MC-Unique: bbeqPzlpPtO9aunp2Sqk7g-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B4B38195608F;
	Thu, 17 Oct 2024 15:47:59 +0000 (UTC)
Received: from redhat.com (unknown [10.39.192.100])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 33AF3300018D;
	Thu, 17 Oct 2024 15:47:55 +0000 (UTC)
Date: Thu, 17 Oct 2024 17:47:53 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	josef@toxicpanda.com, nbd@other.debian.org, eblake@redhat.com,
	vincent.chen@sifive.com, Leon Schuermann <leon@is.currently.online>,
	Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH] nbd: fix partial sending
Message-ID: <ZxExqStWA5HmZMzy@redhat.com>
References: <20241017113614.2964389-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017113614.2964389-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Am 17.10.2024 um 13:36 hat Ming Lei geschrieben:
> nbd driver sends request header and payload with multiple call of
> sock_sendmsg, and partial sending can't be avoided. However, nbd driver
> returns BLK_STS_RESOURCE to block core in this situation. This way causes
> one issue: request->tag may change in the next run of nbd_queue_rq(), but
> the original old tag has been sent as part of header cookie, this way
> confuses nbd driver reply handling, since the real request can't be
> retrieved any more with the obsolete old tag.
> 
> Fix it by retrying sending directly, this way is reasonable & safe since
> nothing can move on if the current hw queue(socket) has pending request,
> and unnecessary requeue can be avoided in this way.
> 
> Cc: vincent.chen@sifive.com
> Cc: Leon Schuermann <leon@is.currently.online>
> Cc: Bart Van Assche <bvanassche@acm.org>
> Reported-by: Kevin Wolf <kwolf@redhat.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
> Kevin,
> 	Please test this version, thanks!

The NBD errors seem to go away with this.

I'm not sure about side effects, though. Isn't the idea behind EINTR
that you return to userspace to let it handle a signal? Looping in the
kernel doesn't quite achieve this, so do we delay/prevent signal
delivery with this? On the other hand, if it were completely prevented,
then this should become an infinite loop, which it didn't in my test.

>  drivers/block/nbd.c | 35 +++++++++++++++++++++++++++++++++--
>  1 file changed, 33 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> index b852050d8a96..ef84071041e3 100644
> --- a/drivers/block/nbd.c
> +++ b/drivers/block/nbd.c
> @@ -701,8 +701,9 @@ static blk_status_t nbd_send_cmd(struct nbd_device *nbd, struct nbd_cmd *cmd,
>  			if (sent) {
>  				nsock->pending = req;
>  				nsock->sent = sent;
> +			} else {
> +				set_bit(NBD_CMD_REQUEUED, &cmd->flags);
>  			}
> -			set_bit(NBD_CMD_REQUEUED, &cmd->flags);
>  			return BLK_STS_RESOURCE;
>  		}
>  		dev_err_ratelimited(disk_to_dev(nbd->disk),
> @@ -743,7 +744,6 @@ static blk_status_t nbd_send_cmd(struct nbd_device *nbd, struct nbd_cmd *cmd,
>  					 */
>  					nsock->pending = req;
>  					nsock->sent = sent;
> -					set_bit(NBD_CMD_REQUEUED, &cmd->flags);
>  					return BLK_STS_RESOURCE;
>  				}
>  				dev_err(disk_to_dev(nbd->disk),
> @@ -778,6 +778,35 @@ static blk_status_t nbd_send_cmd(struct nbd_device *nbd, struct nbd_cmd *cmd,
>  	return BLK_STS_OK;
>  }
>  
> +/*
> + * Send pending nbd request and payload, part of them have been sent
> + * already, so we have to send them all with current request, and can't
> + * return BLK_STS_RESOURCE, otherwise request tag may be changed in next
> + * retry
> + */
> +static blk_status_t nbd_send_pending_cmd(struct nbd_device *nbd,
> +		struct nbd_cmd *cmd)
> +{
> +	struct request *req = blk_mq_rq_from_pdu(cmd);
> +	unsigned long deadline = READ_ONCE(req->deadline);
> +	unsigned int wait_ms = 2;
> +	blk_status_t res;
> +
> +	WARN_ON_ONCE(test_bit(NBD_CMD_REQUEUED, &cmd->flags));
> +
> +	while (true) {
> +		res = nbd_send_cmd(nbd, cmd, cmd->index);
> +		if (res != BLK_STS_RESOURCE)
> +			return res;
> +		if (READ_ONCE(jiffies) + msecs_to_jiffies(wait_ms) >= deadline)
> +			break;
> +		msleep(wait_ms);
> +		wait_ms *= 2;
> +	}
> +
> +	return BLK_STS_IOERR;
> +}
> +
>  static int nbd_read_reply(struct nbd_device *nbd, struct socket *sock,
>  			  struct nbd_reply *reply)
>  {
> @@ -1111,6 +1140,8 @@ static blk_status_t nbd_handle_cmd(struct nbd_cmd *cmd, int index)
>  		goto out;
>  	}
>  	ret = nbd_send_cmd(nbd, cmd, index);
> +	if (ret == BLK_STS_RESOURCE && nsock->pending == req)
> +		ret = nbd_send_pending_cmd(nbd, cmd);

Is there a reason to call nbd_send_cmd() outside of the new loop first
instead of going to the loop directly? It's always better to only have
a single code path.

>  out:
>  	mutex_unlock(&nsock->tx_lock);
>  	nbd_config_put(nbd);

Kevin

