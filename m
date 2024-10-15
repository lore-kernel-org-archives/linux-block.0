Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42DDA1C07C4
	for <linux-block@vger.kernel.org>; Tue, 15 Oct 2024 12:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728997187; cv=none; b=ZaiN8hZN45c96zqXvc/amJhLAxEDpon5ExtPzRiBKje1WgG7pz5RFfKLlv1S/mCSP5JYgvq634NYT7kyMRMpZtIQ5JaL5bzhFX7ATKX3eswK5G6xDySmmQkxm/+7Ksp4BMLpLo+yEkiRif0wqKqCld0VtBhjUG0odi/n/0wyU3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728997187; c=relaxed/simple;
	bh=Lvm3dIY5OtFwDQMeLn9ibYwXgaBqtwz8wQ+l2cen24M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NlzRa0Z6MfYn61XwQpWX+UlEniloAf/YWgEanTQwJb7rbIAKSGY69zM6NrvSQlsWy6QJGxp/b4U+kcf6CCSWo56qPBzlyVxIcUcInmZwNRW12NPEwqwm0b9xeEhj1ZhvPhLcQfMxqHB7nk3tP72LzaD314HxOCfq4rK2czxlqWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D8N5j2XN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D8N5j2XN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728997184;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5qx4N+RxCao7/0JsdwXmzRv+2O0YaqieLm0UF0uIAC8=;
	b=D8N5j2XNyl7kHhirAhBa2QpELxAe65gEV40ROplEvpm+9X3GuWwdZa8RVn4L+Q8rWQuHAX
	Sn3VaY6g3EtoWEMd7sth42e9aERovBR7w69bFyUQjDbyNugN6k6acAcOMoD19u3WS95i/B
	AbfzStyL0bapTizrHzGoYXJvemdQXKY=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-611-4LMbKdwsOceenDVkba1H9g-1; Tue,
 15 Oct 2024 08:59:41 -0400
X-MC-Unique: 4LMbKdwsOceenDVkba1H9g-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1C61B1955D45;
	Tue, 15 Oct 2024 12:59:40 +0000 (UTC)
Received: from fedora (unknown [10.72.116.121])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6301B1956089;
	Tue, 15 Oct 2024 12:59:34 +0000 (UTC)
Date: Tue, 15 Oct 2024 20:59:29 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: josef@toxicpanda.com, axboe@kernel.dk, linux-block@vger.kernel.org,
	nbd@other.debian.org, eblake@redhat.com
Subject: Re: Kernel NBD client waits on wrong cookie, aborts connection
Message-ID: <Zw5nMQoPrSIq9axl@fedora>
References: <Zw5CNDIde6xkq_Sf@redhat.com>
 <CAFj5m9LXwcH7vc2Fk_i+VhfUA+tevzhciJzKc1am49y_5jgC2Q@mail.gmail.com>
 <Zw5b1mwk3aG01NTg@fedora>
 <CAFj5m9+x+tiAAKj3dX_WcFczkdSNaR6nguDHm9FXuYjQHd8YcA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFj5m9+x+tiAAKj3dX_WcFczkdSNaR6nguDHm9FXuYjQHd8YcA@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On Tue, Oct 15, 2024 at 08:15:17PM +0800, Ming Lei wrote:
> On Tue, Oct 15, 2024 at 8:11 PM Ming Lei <ming.lei@redhat.com> wrote:
> >
> > On Tue, Oct 15, 2024 at 08:01:43PM +0800, Ming Lei wrote:
> > > On Tue, Oct 15, 2024 at 6:22 PM Kevin Wolf <kwolf@redhat.com> wrote:
> > > >
> > > > Hi all,
> > > >
> > > > the other day I was running some benchmarks to compare different QEMU
> > > > block exports, and one of the scenarios I was interested in was
> > > > exporting NBD from qemu-storage-daemon over a unix socket and attaching
> > > > it as a block device using the kernel NBD client. I would then run a VM
> > > > on top of it and fio inside of it.
> > > >
> > > > Unfortunately, I couldn't get any numbers because the connection always
> > > > aborted with messages like "Double reply on req ..." or "Unexpected
> > > > reply ..." in the host kernel log.
> > > >
> > > > Yesterday I found some time to have a closer look why this is happening,
> > > > and I think I have a rough understanding of what's going on now. Look at
> > > > these trace events:
> > > >
> > > >         qemu-img-51025   [005] ..... 19503.285423: nbd_header_sent: nbd transport event: request 000000002df03708, handle 0x0000150c0000005a
> > > > [...]
> > > >         qemu-img-51025   [008] ..... 19503.285500: nbd_payload_sent: nbd transport event: request 000000002df03708, handle 0x0000150c0000005d
> > > > [...]
> > > >    kworker/u49:1-47350   [004] ..... 19503.285514: nbd_header_received: nbd transport event: request 00000000b79e7443, handle 0x0000150c0000005a
> > > >
> > > > This is the same request, but the handle has changed between
> > > > nbd_header_sent and nbd_payload_sent! I think this means that we hit one
> > > > of the cases where the request is requeued, and then the next time it
> > > > is executed with a different blk-mq tag, which is something the nbd
> > > > driver doesn't seem to expect.
> > > >
> > > > Of course, since the cookie is transmitted in the header, the server
> > > > replies with the original handle that contains the tag from the first
> > > > call, while the kernel is only waiting for a handle with the new tag and
> > > > is confused by the server response.
> > > >
> > > > I'm not sure yet which of the following options should be considered the
> > > > real problem here, so I'm only describing the situation without trying
> > > > to provide a patch:
> > > >
> > > > 1. Is it that blk-mq should always re-run the request with the same tag?
> > > >    I don't expect so, though in practice I was surprised to see that it
> > > >    happens quite often after nbd requeues a request that it actually
> > > >    does end up with the same cookie again.
> > >
> > > No.
> > >
> > > request->tag will change, but we may take ->internal_tag(sched) or
> > > ->tag(none), which won't change.
> > >
> > > I guess was_interrupted() in nbd_send_cmd() is triggered, then the payload
> > > is sent with a different tag.
> > >
> > > I will try to cook one patch soon.
> >
> > Please try the following patch:
> 
> Oops, please ignore the patch, it can't work since
> nbd_handle_reply() doesn't know static tag.

Please try the v2:


diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 2cafcf11ee8b..8bad4030b2e4 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -682,3 +682,31 @@ u32 blk_mq_unique_tag(struct request *rq)
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
+
+struct request *blk_mq_static_tag_to_req(struct request_queue *q, u32 uniq_tag)
+{
+	unsigned long hwq = blk_mq_unique_tag_to_hwq(uniq_tag);
+	u32 tag = blk_mq_unique_tag_to_tag(uniq_tag);
+	const struct blk_mq_hw_ctx *hctx= xa_load(&q->hctx_table, hwq);
+
+	if (!hctx)
+		return NULL;
+
+	if (q->elevator)
+		return hctx->sched_tags->static_rqs[tag];
+	return hctx->tags->static_rqs[tag];
+}
+EXPORT_SYMBOL(blk_mq_static_tag_to_req);
diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index b852050d8a96..5be324233c9f 100644
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
@@ -818,10 +818,7 @@ static struct nbd_cmd *nbd_handle_reply(struct nbd_device *nbd, int index,
 
 	handle = be64_to_cpu(reply->cookie);
 	tag = nbd_handle_to_tag(handle);
-	hwq = blk_mq_unique_tag_to_hwq(tag);
-	if (hwq < nbd->tag_set.nr_hw_queues)
-		req = blk_mq_tag_to_rq(nbd->tag_set.tags[hwq],
-				       blk_mq_unique_tag_to_tag(tag));
+	req = blk_mq_static_tag_to_req(nbd->disk->queue, tag);
 	if (!req || !blk_mq_request_started(req)) {
 		dev_err(disk_to_dev(nbd->disk), "Unexpected reply (%d) %p\n",
 			tag, req);
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 4fecf46ef681..9c4ef3f16a77 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -793,6 +793,8 @@ enum {
 };
 
 u32 blk_mq_unique_tag(struct request *rq);
+u32 blk_mq_unique_static_tag(struct request *rq);
+struct request *blk_mq_static_tag_to_req(struct request_queue *q, u32 tag);
 
 static inline u16 blk_mq_unique_tag_to_hwq(u32 unique_tag)
 {

-- 
Ming

