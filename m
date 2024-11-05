Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DBC11D5160
	for <linux-block@vger.kernel.org>; Tue,  5 Nov 2024 14:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730815405; cv=none; b=mOoyejXcWVPfsvv17T/bjJ8RoCK3ImCexe0BQ6F6tH/xcyaYs3IcHjHUaellVTJUkMuxHotAOluSKq8XPs6O/Rrci2hyiVP0lX6CuSwwWzTMMuUKrJ0atnUV9MoVbPsbfOvN0sP0sJoQcM701JMWt92lE2VnEejGn29aDR991X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730815405; c=relaxed/simple;
	bh=QPXikWOJYnKKdTHfQ2UVKCqW6j61xPnR09C89pKA6pE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GdgPxcLtmSgASEy26VYmZ9zjtfrp+FbdTgAJ3fKgvFsImyUut+dfoOyTVbM8EgX6Ux/gL8oD95C6yuomZkg3D6Jfabf+yAiCCbghg2gpDR5US6uznxStUaZlotC5GvCH3wNzdJn61jhMI+eHlYhqTf8Nbo3oEenqghWzXXofjGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N2V/eNOO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N2V/eNOO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730815402;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a1YWEvpIV/hv1nANf3AYEhUmp9gUGHsaAanTGJypJ+s=;
	b=N2V/eNOOaY2wCQURQ2H+wAEXLId+tJqWx9I5Cn59jFrQhgavtmOuzwJcHRlyZtExCtTjzq
	7ALqDEnz+7zXm0dB2qGkqA8CyVvDClZyQ3/gQCyoZrDN1Au1oj3WdHFNS6O3kO8O2TXzOc
	Qt6MsCmcWK99ZuSEtgF805hW8FvQqkc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-272-w_GfUYeSPoiWKWPj3daBmw-1; Tue,
 05 Nov 2024 09:03:17 -0500
X-MC-Unique: w_GfUYeSPoiWKWPj3daBmw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9FE4A1955F67;
	Tue,  5 Nov 2024 14:03:12 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.127])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 92849300018D;
	Tue,  5 Nov 2024 14:03:09 +0000 (UTC)
Date: Tue, 5 Nov 2024 15:03:06 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	josef@toxicpanda.com, nbd@other.debian.org, eblake@redhat.com,
	vincent.chen@sifive.com, Leon Schuermann <leon@is.currently.online>,
	Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH V3] nbd: fix partial sending
Message-ID: <ZyolmjfJvYWmhcbS@redhat.com>
References: <20241029011941.153037-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241029011941.153037-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Am 29.10.2024 um 02:19 hat Ming Lei geschrieben:
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

> @@ -770,6 +798,14 @@ static blk_status_t nbd_send_cmd(struct nbd_device *nbd, struct nbd_cmd *cmd,
>  	return BLK_STS_OK;
>  
>  requeue:
> +	/*
> +	 * Can't requeue in case we are dealing with partial send
> +	 *
> +	 * We must run from pending work function.
> +	 * */
> +	if (test_bit(NBD_CMD_PARTIAL_SEND, &cmd->flags))
> +		return BLK_STS_OK;
> +
>  	/* retry on a different socket */
>  	dev_err_ratelimited(disk_to_dev(nbd->disk),
>  			    "Request send failed, requeueing\n");

This hunk doesn't feel ideal: The assumption in the normal code path
here is that the socket is dead, i.e. the error isn't recoverable. With
this way to handle it, nbd_pending_cmd_work() will keep retrying until
the request finally times out. We could probably return an error right
away.

In fact, I think even requeuing (and ideally still completing the
request successfully in the end) would be fine in this case because
we'll shut down the socket and never send any additional data on it, so
the server will never see a complete command. We would just have to make
sure that nbd_pending_cmd_work() doesn't try to complete sending the
command any more.

But even though this error path isn't optimal, I feel it might be
acceptable. Let's see if someone else has an opinion on it.

Tested-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>

