Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6541CB9EB
	for <linux-block@vger.kernel.org>; Tue, 15 Oct 2024 16:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729008381; cv=none; b=uypHKR0PxqgKJem21tWyNZapJ5vbYrd1w3YpgIxrclv+4Av32nlc4Fw0rT0nTX8uxmVmZiFFr3BNvr1rfUOrY9tI5nGwMfUuww1VvYP4kncNND5UrGUAP98TuYvSBfY3M6k8XnrIRUUL7YXQaXO/xN7K/5YeKvu2iqI/1nAlqd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729008381; c=relaxed/simple;
	bh=lqDo6jLw6I/JG8rFWObB7gKwS6dsJlWu/vKAw8fc4po=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EGk5U3ScGHOCWUPWRPOQIVjoMcdBh1V2WuanJvFKTJx3r8xZLyVZdhs7qsC+E63l/iCHHEMqwkzJJ/L+Ky9hXKE9ZiId8r5BQIxUEjyib1VbFf1rBcje/m4H6cSQw0pJgXkQtSYjOWM8Q5kSYpiV9tqrUOCfxd/SfRriaV7rM/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ecJi0uBP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ecJi0uBP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729008377;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iojyARjeXN8Q5+UMphGbYbxc6rgrJQPAjTgYzn/WhPs=;
	b=ecJi0uBPVJcnndNd2IU0xvGuXWYGn7xXfUMRMf5BftWM/3b3brMWSxOzERVMOBmHpzH6gn
	qjcqbJz4z1t5K4ehUWAy5npK5o1nxo0gyQUHGWwrq2xI2ycuM6JfKvcP1F6WODfN4UWaEW
	OdkdbuGN7KEnMBRE8iFG0BkMHCkPFWg=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-390-TANJWY-JO6-vvKVYDGmSfQ-1; Tue,
 15 Oct 2024 12:06:16 -0400
X-MC-Unique: TANJWY-JO6-vvKVYDGmSfQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3849B19560AE;
	Tue, 15 Oct 2024 16:06:15 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.132])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1C0C11956086;
	Tue, 15 Oct 2024 16:06:11 +0000 (UTC)
Date: Tue, 15 Oct 2024 18:06:01 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: josef@toxicpanda.com, axboe@kernel.dk, linux-block@vger.kernel.org,
	nbd@other.debian.org, eblake@redhat.com
Subject: Re: Kernel NBD client waits on wrong cookie, aborts connection
Message-ID: <Zw6S6RoKWzUnNVpu@redhat.com>
References: <Zw5CNDIde6xkq_Sf@redhat.com>
 <CAFj5m9LXwcH7vc2Fk_i+VhfUA+tevzhciJzKc1am49y_5jgC2Q@mail.gmail.com>
 <Zw5b1mwk3aG01NTg@fedora>
 <CAFj5m9+x+tiAAKj3dX_WcFczkdSNaR6nguDHm9FXuYjQHd8YcA@mail.gmail.com>
 <Zw5nMQoPrSIq9axl@fedora>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zw5nMQoPrSIq9axl@fedora>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Am 15.10.2024 um 14:59 hat Ming Lei geschrieben:
> On Tue, Oct 15, 2024 at 08:15:17PM +0800, Ming Lei wrote:
> > On Tue, Oct 15, 2024 at 8:11 PM Ming Lei <ming.lei@redhat.com> wrote:
> > >
> > > On Tue, Oct 15, 2024 at 08:01:43PM +0800, Ming Lei wrote:
> > > > On Tue, Oct 15, 2024 at 6:22 PM Kevin Wolf <kwolf@redhat.com> wrote:
> > > > >
> > > > > Hi all,
> > > > >
> > > > > the other day I was running some benchmarks to compare different QEMU
> > > > > block exports, and one of the scenarios I was interested in was
> > > > > exporting NBD from qemu-storage-daemon over a unix socket and attaching
> > > > > it as a block device using the kernel NBD client. I would then run a VM
> > > > > on top of it and fio inside of it.
> > > > >
> > > > > Unfortunately, I couldn't get any numbers because the connection always
> > > > > aborted with messages like "Double reply on req ..." or "Unexpected
> > > > > reply ..." in the host kernel log.
> > > > >
> > > > > Yesterday I found some time to have a closer look why this is happening,
> > > > > and I think I have a rough understanding of what's going on now. Look at
> > > > > these trace events:
> > > > >
> > > > >         qemu-img-51025   [005] ..... 19503.285423: nbd_header_sent: nbd transport event: request 000000002df03708, handle 0x0000150c0000005a
> > > > > [...]
> > > > >         qemu-img-51025   [008] ..... 19503.285500: nbd_payload_sent: nbd transport event: request 000000002df03708, handle 0x0000150c0000005d
> > > > > [...]
> > > > >    kworker/u49:1-47350   [004] ..... 19503.285514: nbd_header_received: nbd transport event: request 00000000b79e7443, handle 0x0000150c0000005a
> > > > >
> > > > > This is the same request, but the handle has changed between
> > > > > nbd_header_sent and nbd_payload_sent! I think this means that we hit one
> > > > > of the cases where the request is requeued, and then the next time it
> > > > > is executed with a different blk-mq tag, which is something the nbd
> > > > > driver doesn't seem to expect.
> > > > >
> > > > > Of course, since the cookie is transmitted in the header, the server
> > > > > replies with the original handle that contains the tag from the first
> > > > > call, while the kernel is only waiting for a handle with the new tag and
> > > > > is confused by the server response.
> > > > >
> > > > > I'm not sure yet which of the following options should be considered the
> > > > > real problem here, so I'm only describing the situation without trying
> > > > > to provide a patch:
> > > > >
> > > > > 1. Is it that blk-mq should always re-run the request with the same tag?
> > > > >    I don't expect so, though in practice I was surprised to see that it
> > > > >    happens quite often after nbd requeues a request that it actually
> > > > >    does end up with the same cookie again.
> > > >
> > > > No.
> > > >
> > > > request->tag will change, but we may take ->internal_tag(sched) or
> > > > ->tag(none), which won't change.
> > > >
> > > > I guess was_interrupted() in nbd_send_cmd() is triggered, then the payload
> > > > is sent with a different tag.
> > > >
> > > > I will try to cook one patch soon.
> > >
> > > Please try the following patch:
> > 
> > Oops, please ignore the patch, it can't work since
> > nbd_handle_reply() doesn't know static tag.
> 
> Please try the v2:

It doesn't fully work, though it replaced the bug with a different one.
Now I get "Unexpected request" for the final flush request.

Anyway, before talking about specific patches, would this even be the
right solution or would it only paper over a bigger issue?

Is getting a different tag the only thing that can go wrong if you
handle a request partially and then requeue it?

Kevin

