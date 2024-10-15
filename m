Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3401E1C33
	for <linux-block@vger.kernel.org>; Tue, 15 Oct 2024 10:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728987712; cv=none; b=BtnOhui+wg04mjtdMdczr6h++nCYiaOnkKveFezzQcr1x6+720nIvrpunYApdpFEfDq+YOaAR1G7/QJS10bW4HLOWFHNhZw4hX7ZmTw+ft5pqjmnHm3Rlqqbt96RzICLWgUsPerJkDd6WxoHI8M7TOl7YNxSmkgJ2JEmszpbDJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728987712; c=relaxed/simple;
	bh=vipnB5wwhRrndBzLgvXpspVuZIUR/r6CALGw+eq6bqY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=VAblaid3c8Zxe1XgwaQC9Y66RvjT1DQWYe1NWTB1Jvbpyk81fAJI5y3QG8hAaHghpfA3pTbBoOqU2W2r5dMCvQEN7FhMjZFycxRbO5OpuONgm/KeIFnhvoLnG/fDgbWrcoFxc6BrXZYOSXeh0LyoL2IsRTb7EympjJAyTQ07x2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ToFeJ+sq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ToFeJ+sq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728987710;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=bh+Ir/j3gUT3OWFj/tNxfK3IIX6mfHtdP5FI1CZ59vE=;
	b=ToFeJ+sqjm/EUkpsiGz7u+BcZcnS8HLrwk5T4i+SaS94F8o2V/FXLHX3cxAl05MqyDOioJ
	MnklZWdCy9Cm2xSLyMdOSrBBTbiem3LEl8/FHbLylQZbViHNlcHVD4g72sHXdIkz4SGoyP
	F5E2w2hjQVc5GzyToGfj+9/c3rfyf+Y=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-126-mAb97BP8MGuxHYZ7yVKARQ-1; Tue,
 15 Oct 2024 06:21:47 -0400
X-MC-Unique: mAb97BP8MGuxHYZ7yVKARQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8FA1319560BE;
	Tue, 15 Oct 2024 10:21:45 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.132])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9800219560A2;
	Tue, 15 Oct 2024 10:21:43 +0000 (UTC)
Date: Tue, 15 Oct 2024 12:21:40 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: josef@toxicpanda.com
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, nbd@other.debian.org,
	eblake@redhat.com
Subject: Kernel NBD client waits on wrong cookie, aborts connection
Message-ID: <Zw5CNDIde6xkq_Sf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Hi all,

the other day I was running some benchmarks to compare different QEMU
block exports, and one of the scenarios I was interested in was
exporting NBD from qemu-storage-daemon over a unix socket and attaching
it as a block device using the kernel NBD client. I would then run a VM
on top of it and fio inside of it.

Unfortunately, I couldn't get any numbers because the connection always
aborted with messages like "Double reply on req ..." or "Unexpected
reply ..." in the host kernel log.

Yesterday I found some time to have a closer look why this is happening,
and I think I have a rough understanding of what's going on now. Look at
these trace events:

        qemu-img-51025   [005] ..... 19503.285423: nbd_header_sent: nbd transport event: request 000000002df03708, handle 0x0000150c0000005a
[...]
        qemu-img-51025   [008] ..... 19503.285500: nbd_payload_sent: nbd transport event: request 000000002df03708, handle 0x0000150c0000005d
[...]
   kworker/u49:1-47350   [004] ..... 19503.285514: nbd_header_received: nbd transport event: request 00000000b79e7443, handle 0x0000150c0000005a

This is the same request, but the handle has changed between
nbd_header_sent and nbd_payload_sent! I think this means that we hit one
of the cases where the request is requeued, and then the next time it
is executed with a different blk-mq tag, which is something the nbd
driver doesn't seem to expect.

Of course, since the cookie is transmitted in the header, the server
replies with the original handle that contains the tag from the first
call, while the kernel is only waiting for a handle with the new tag and
is confused by the server response.

I'm not sure yet which of the following options should be considered the
real problem here, so I'm only describing the situation without trying
to provide a patch:

1. Is it that blk-mq should always re-run the request with the same tag?
   I don't expect so, though in practice I was surprised to see that it
   happens quite often after nbd requeues a request that it actually
   does end up with the same cookie again.

2. Is it that nbd should use cookies that don't depend on the tag?
   Maybe, but then we lose an easy way to identify the request from the
   server response.

3. Is it that it should never requeue requests after already starting to
   send data for them? This sounds most likely to me, but also like the
   biggest change to make in nbd.

4. Or something else entirely?

I tested this with the 6.10.12 kernel from Fedora 40, but a quick git
diff on nbd.c doesn't suggest that anything related has changed since
then. This is how I reproduced it for debugging (without a VM):

$ qemu-storage-daemon --blockdev null-co,size=$((16*(1024**3))),node-name=data --nbd-server addr.type=unix,addr.path=/tmp/nbd.sock --export nbd,id=exp0,node-name=data,writable=on
# nbd-client -unix -N data /tmp/nbd.sock /dev/nbd0
# qemu-img bench -f host_device -w -s 4k -c 1000000 -t none -i io_uring /dev/nbd0

I couldn't trigger the problem with TCP or without the io_uring backend
(i.e. using Linux AIO or the thread pool) for 'qemu-img bench'.

Kevin

