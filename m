Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0AF1EBA10
	for <linux-block@vger.kernel.org>; Tue, 15 Oct 2024 12:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728994281; cv=none; b=rKdBbuHxe6OuBbiv5gwshWsRRiQh73YFyfz/OSNBxxDDHCEFi7DTmVVzB14h4I98NgL/MEW8etPwD6j3GGzjvrwgnYcM5hIpmPefFZrbZGoW9Mxt0WV/0FyfTVQdTPuWIEWLS3T0MXNqSvX0GyB5k1yyzYQDkRhLLPT5H4jUrLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728994281; c=relaxed/simple;
	bh=V+4C3/dscvAkJcP+wPFslM1V6UlX9KAE3mMI9JhJ9IU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=irQnwpwEh32QDyTk/3mUrVWcXxN5ojiMiJeCYi62BAIWEqn4S5vENNJkRpROhcAbjGCsmEXt2vrXjB5zfESqv7zrUFM62ErjvwLdDFbdb0YbKvTJAfSVZuapRzEfut8ddFjITYqExuOt1mi7rwLdJ/VaKyRiN9HLjPM7u5yj9zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DqyiHuce; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DqyiHuce"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728994277;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G3Pcz/dEOnqKX/cFViUwxujJai8oBAzKnB5CGzzdEx0=;
	b=DqyiHucewE8IJ9Swt67LtHlt8v7fZr2KzjVpF3XY8iUaG+Sw4kmRZFSauF8Pgq8QiAFz46
	oHGXmi+b1XCWRcNVtjvz6oZytbGb+e+chha09sX7QDifgYHAgRXPJF8uQZ/blTYyJApB8M
	TIpPwF4cv4kr4S2gdmZuDgOJ+F6tmxU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-205-hIfcxqtOOSO0A-W20qWf1g-1; Tue,
 15 Oct 2024 08:11:14 -0400
X-MC-Unique: hIfcxqtOOSO0A-W20qWf1g-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B8ED51956083;
	Tue, 15 Oct 2024 12:11:13 +0000 (UTC)
Received: from fedora (unknown [10.72.116.121])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9A2EA1956056;
	Tue, 15 Oct 2024 12:11:08 +0000 (UTC)
Date: Tue, 15 Oct 2024 20:11:02 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: josef@toxicpanda.com, axboe@kernel.dk, linux-block@vger.kernel.org,
	nbd@other.debian.org, eblake@redhat.com, ming.lei@redhat.com
Subject: Re: Kernel NBD client waits on wrong cookie, aborts connection
Message-ID: <Zw5b1mwk3aG01NTg@fedora>
References: <Zw5CNDIde6xkq_Sf@redhat.com>
 <CAFj5m9LXwcH7vc2Fk_i+VhfUA+tevzhciJzKc1am49y_5jgC2Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFj5m9LXwcH7vc2Fk_i+VhfUA+tevzhciJzKc1am49y_5jgC2Q@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Tue, Oct 15, 2024 at 08:01:43PM +0800, Ming Lei wrote:
> On Tue, Oct 15, 2024 at 6:22 PM Kevin Wolf <kwolf@redhat.com> wrote:
> >
> > Hi all,
> >
> > the other day I was running some benchmarks to compare different QEMU
> > block exports, and one of the scenarios I was interested in was
> > exporting NBD from qemu-storage-daemon over a unix socket and attaching
> > it as a block device using the kernel NBD client. I would then run a VM
> > on top of it and fio inside of it.
> >
> > Unfortunately, I couldn't get any numbers because the connection always
> > aborted with messages like "Double reply on req ..." or "Unexpected
> > reply ..." in the host kernel log.
> >
> > Yesterday I found some time to have a closer look why this is happening,
> > and I think I have a rough understanding of what's going on now. Look at
> > these trace events:
> >
> >         qemu-img-51025   [005] ..... 19503.285423: nbd_header_sent: nbd transport event: request 000000002df03708, handle 0x0000150c0000005a
> > [...]
> >         qemu-img-51025   [008] ..... 19503.285500: nbd_payload_sent: nbd transport event: request 000000002df03708, handle 0x0000150c0000005d
> > [...]
> >    kworker/u49:1-47350   [004] ..... 19503.285514: nbd_header_received: nbd transport event: request 00000000b79e7443, handle 0x0000150c0000005a
> >
> > This is the same request, but the handle has changed between
> > nbd_header_sent and nbd_payload_sent! I think this means that we hit one
> > of the cases where the request is requeued, and then the next time it
> > is executed with a different blk-mq tag, which is something the nbd
> > driver doesn't seem to expect.
> >
> > Of course, since the cookie is transmitted in the header, the server
> > replies with the original handle that contains the tag from the first
> > call, while the kernel is only waiting for a handle with the new tag and
> > is confused by the server response.
> >
> > I'm not sure yet which of the following options should be considered the
> > real problem here, so I'm only describing the situation without trying
> > to provide a patch:
> >
> > 1. Is it that blk-mq should always re-run the request with the same tag?
> >    I don't expect so, though in practice I was surprised to see that it
> >    happens quite often after nbd requeues a request that it actually
> >    does end up with the same cookie again.
> 
> No.
> 
> request->tag will change, but we may take ->internal_tag(sched) or
> ->tag(none), which won't change.
> 
> I guess was_interrupted() in nbd_send_cmd() is triggered, then the payload
> is sent with a different tag.
> 
> I will try to cook one patch soon.

Please try the following patch:


diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 2cafcf11ee8b..e3eb31c3ee75 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -682,3 +682,16 @@ u32 blk_mq_unique_tag(struct request *rq)
 		(rq->tag & BLK_MQ_UNIQUE_TAG_MASK);
 }
 EXPORT_SYMBOL(blk_mq_unique_tag);
+
+/*
+ * Same with blk_mq_unique_tag, but one persistent tag is included in
+ * the request lifetime.
+ */
+u32 blk_mq_unique_static_tag(struct request *rq)
+{
+	u32 tag = rq->q->elevator ? rq->internal_tag : rq->tag;
+
+	return (rq->mq_hctx->queue_num << BLK_MQ_UNIQUE_TAG_BITS) |
+		(tag & BLK_MQ_UNIQUE_TAG_MASK);
+}
+EXPORT_SYMBOL(blk_mq_unique_static_tag);
diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index b852050d8a96..cc522a2cb9fb 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -201,7 +201,7 @@ static void nbd_requeue_cmd(struct nbd_cmd *cmd)
 static u64 nbd_cmd_handle(struct nbd_cmd *cmd)
 {
 	struct request *req = blk_mq_rq_from_pdu(cmd);
-	u32 tag = blk_mq_unique_tag(req);
+	u32 tag = blk_mq_unique_static_tag(req);
 	u64 cookie = cmd->cmd_cookie;
 
 	return (cookie << NBD_COOKIE_BITS) | tag;
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 4fecf46ef681..d6266759d62d 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -793,6 +793,7 @@ enum {
 };
 
 u32 blk_mq_unique_tag(struct request *rq);
+u32 blk_mq_unique_static_tag(struct request *rq);
 
 static inline u16 blk_mq_unique_tag_to_hwq(u32 unique_tag)
 {

-- 
Ming

