Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10A641C7F
	for <linux-block@vger.kernel.org>; Wed, 16 Oct 2024 02:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729045811; cv=none; b=iZveIMJaSHaBky4spIIi467kdYabLGYXhmZwiqa0X9YE7cV/OSsPYPxmHBw4tYtpC9chTHot+meZN+TDsyD+itVXkOGCnxCa9B1hot8iMVom0lWK16n+oqOIahlSU/1u3Qr63QpYRxp4X69tqMQxuhSlPQvKjG/u8mcIsRhOjZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729045811; c=relaxed/simple;
	bh=gvJDZvGwFsus00W5eIIKMr7ZtHXzl/XLMlP3u7dbwfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qbml2MeBgGtI5bqf+DBvk0bWVBWeafbynzbhQVHm6dt4r4m2bd93nio643hCWzDKtBVCeemWoX60dOfmzaI9Yo5CTRt+PwLcL3d/ydHYTLnT9V6Azri0bga/JmsnFlPeL5GSn2Y8FTyZfwrOuC9WN+zVd7m4iUwFmqWBsmus6Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cv8AduW3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cv8AduW3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729045808;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kfu4VH+C86hJDu4TrSpv23uZBKyRidbPNr76VKLeJl0=;
	b=cv8AduW388ppHZ+v10++8ZPVXUVHeEmGt+lRRxTiTlg7nQqxLFfrzDmZc0I+lytp7yF2vs
	12RuEZUIn3wfZsRhQTLwlwbnSj6BeHk1fHxaT7C87U/ip8mpZzA4xM0WEM0TCo8rqlQ16q
	JzcQG0n96J5+//vDZNA3wV8Lmm7L35w=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-156-KykTR7YYPmaH5vJT2AxehA-1; Tue,
 15 Oct 2024 22:30:06 -0400
X-MC-Unique: KykTR7YYPmaH5vJT2AxehA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9435D19560AF;
	Wed, 16 Oct 2024 02:30:05 +0000 (UTC)
Received: from fedora (unknown [10.72.116.125])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 35C32300018D;
	Wed, 16 Oct 2024 02:30:01 +0000 (UTC)
Date: Wed, 16 Oct 2024 10:29:56 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Uday Shankar <ushankar@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH] ublk: eliminate unnecessary io_cmds queue
Message-ID: <Zw8lJDo8Xh3epbjq@fedora>
References: <20241009193700.3438201-1-ushankar@purestorage.com>
 <ZwdNvyXdXbsCf9MF@fedora>
 <Zw7Vwsh3G25bbl93@dev-ushankar.dev.purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zw7Vwsh3G25bbl93@dev-ushankar.dev.purestorage.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Tue, Oct 15, 2024 at 02:51:14PM -0600, Uday Shankar wrote:
> On Thu, Oct 10, 2024 at 11:45:03AM +0800, Ming Lei wrote:
> > >  static void ublk_queue_cmd(struct ublk_queue *ubq, struct request *rq)
> > >  {
> > > -	struct ublk_rq_data *data = blk_mq_rq_to_pdu(rq);
> > > -
> > > -	if (llist_add(&data->node, &ubq->io_cmds)) {
> > > -		struct ublk_io *io = &ubq->ios[rq->tag];
> > > +	struct ublk_io *io = &ubq->ios[rq->tag];
> > >  
> > > -		io_uring_cmd_complete_in_task(io->cmd, ublk_rq_task_work_cb);
> > > -	}
> > > +	ublk_get_uring_cmd_pdu(io->cmd)->req = rq;
> > > +	io_uring_cmd_complete_in_task(io->cmd, __ublk_rq_task_work);
> > >  }
> > 
> > I'd suggest to comment that io_uring_cmd_complete_in_task() needs to
> > maintain io command order.
> 
> Sorry, can you explain why this is important? Generally speaking
> out-of-order completion of I/Os is considered okay, so what's the issue
> if the dispatch to the ublk server here is not in order?

It is just okay, but proper implementation requires to keep IO order.

Please see:

1) 7d4a93176e01 ("ublk_drv: don't forward io commands in reserve order")

2) [Report] requests are submitted to hardware in reverse order from nvme/virtio-blk queue_rqs()

https://lore.kernel.org/linux-block/ZbD7ups50ryrlJ%2FG@fedora/


I am also working on ublk-bpf which needs this extra list for submitting
IO in batch, please hold on this patch now.

I plan to send out bpf patches in this cycle or next, and we can restart
the cleanup if the bpf thing turns out not doable.


Thanks, 
Ming

