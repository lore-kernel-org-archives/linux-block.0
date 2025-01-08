Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676231940B0
	for <linux-block@vger.kernel.org>; Wed,  8 Jan 2025 18:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736359481; cv=none; b=paSW3+ka2qduc79g7mOPyDCbxIi3YtDSyuVCw2jQ9MGnSOV9MspMu9QyVd9NTK64jkctohoBpk9sTS0+/I8z57nI14f0KYuRq6WjDE9ZAyBbbOqzrqI8DYwGTHXcLtw9JEspSDEW69AtVZ4R38Rj1HbUtXU5ysaKjd0P0MjJ2JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736359481; c=relaxed/simple;
	bh=atbA/Mpna868rf9o/sBKO1DYOaWnUJTTxHJkKis/yc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WdWOjiVDVQ6zqA5VKS783l9geIJU5hxds90w+j3CUS92Ty+kYYKuT1R5taktpBg9WBra+0HHedyQJd6NShigxb3HmPxF6TTp9jYaAkdA2KhkF071ykE/SnAm8HmuVXKfIIJkBA/JXufHUj9HAU6khiyjRhcB4psYuQIrr6jY4Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fcpKUJvA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fcpKUJvA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736359478;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pfcBsLMpgBBjs+6gd7rLtqgcpV31/V32k2ExVRnnv8I=;
	b=fcpKUJvAYIR/8U96xdiuQGw4lW3DFNoOBVkMinj2A5GGiBsiwiRiYICM1Yur2Kl3on2kzF
	vLCHu4q7ZSXU9Hzikh3f0nSfwEpDI+Uqe9C1Wx2ff5RLgP+s6DLytpbAJLEO5Izb4hBt3M
	gsN1YdBdvDMrdLCUGIoTo/KdFcgN9Ug=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-617-T4LAYx6rOoy4Ib0IKqH2cA-1; Wed,
 08 Jan 2025 13:04:34 -0500
X-MC-Unique: T4LAYx6rOoy4Ib0IKqH2cA-1
X-Mimecast-MFC-AGG-ID: T4LAYx6rOoy4Ib0IKqH2cA
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E741E1979053;
	Wed,  8 Jan 2025 18:04:32 +0000 (UTC)
Received: from redhat.com (unknown [10.39.192.62])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B59D119560AD;
	Wed,  8 Jan 2025 18:04:29 +0000 (UTC)
Date: Wed, 8 Jan 2025 19:04:27 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	josef@toxicpanda.com, nbd@other.debian.org, eblake@redhat.com,
	vincent.chen@sifive.com, Leon Schuermann <leon@is.currently.online>,
	Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH V3] nbd: fix partial sending
Message-ID: <Z36-GdPCdgdjwvHX@redhat.com>
References: <20241029011941.153037-1-ming.lei@redhat.com>
 <ZyolmjfJvYWmhcbS@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZyolmjfJvYWmhcbS@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Am 05.11.2024 um 15:03 hat Kevin Wolf geschrieben:
> Am 29.10.2024 um 02:19 hat Ming Lei geschrieben:
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
> 
> > @@ -770,6 +798,14 @@ static blk_status_t nbd_send_cmd(struct nbd_device *nbd, struct nbd_cmd *cmd,
> >  	return BLK_STS_OK;
> >  
> >  requeue:
> > +	/*
> > +	 * Can't requeue in case we are dealing with partial send
> > +	 *
> > +	 * We must run from pending work function.
> > +	 * */
> > +	if (test_bit(NBD_CMD_PARTIAL_SEND, &cmd->flags))
> > +		return BLK_STS_OK;
> > +
> >  	/* retry on a different socket */
> >  	dev_err_ratelimited(disk_to_dev(nbd->disk),
> >  			    "Request send failed, requeueing\n");
> 
> This hunk doesn't feel ideal: The assumption in the normal code path
> here is that the socket is dead, i.e. the error isn't recoverable. With
> this way to handle it, nbd_pending_cmd_work() will keep retrying until
> the request finally times out. We could probably return an error right
> away.
> 
> In fact, I think even requeuing (and ideally still completing the
> request successfully in the end) would be fine in this case because
> we'll shut down the socket and never send any additional data on it, so
> the server will never see a complete command. We would just have to make
> sure that nbd_pending_cmd_work() doesn't try to complete sending the
> command any more.
> 
> But even though this error path isn't optimal, I feel it might be
> acceptable. Let's see if someone else has an opinion on it.
> 
> Tested-by: Kevin Wolf <kwolf@redhat.com>
> Reviewed-by: Kevin Wolf <kwolf@redhat.com>

What is the status with this fix? I don't see any further comments on it,
but it also doesn't seem to be merged yet. Am I missing a follow-up
thread?

Kevin

