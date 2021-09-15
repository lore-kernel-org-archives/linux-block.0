Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FA2CC433F5
	for <linux-block@archiver.kernel.org>; Wed, 15 Sep 2021 03:16:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E045561175
	for <linux-block@archiver.kernel.org>; Wed, 15 Sep 2021 03:16:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235413AbhIODRZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 Sep 2021 23:17:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:53769 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235015AbhIODRY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Sep 2021 23:17:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631675765;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zlyxS0b1FK2wfVn9hcZ7WHgk1exfB9oaJDccxJiZ+b8=;
        b=f23pcD7p5AtfUWR6jtsbOkuzhr6Z4ZVURV1TeY4SysEZKz+BkE49e9aHeONGYdAc64+3CO
        JquJTce+CbcLd7ml8rhYEswLXRMwFxIuBTB2VJ7NtimOMMKdl/bzBaXfaTi0kmMuzgiM2V
        9tjhH3M/0pU6DfRPrb2qSrGydMkr6+o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-516-m5JDQB5rOWiq4iijiQWLVA-1; Tue, 14 Sep 2021 23:16:04 -0400
X-MC-Unique: m5JDQB5rOWiq4iijiQWLVA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2FA7E100C661;
        Wed, 15 Sep 2021 03:16:03 +0000 (UTC)
Received: from T590 (ovpn-12-59.pek2.redhat.com [10.72.12.59])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4D76B1972E;
        Wed, 15 Sep 2021 03:15:55 +0000 (UTC)
Date:   Wed, 15 Sep 2021 11:16:06 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     "yukuai (C)" <yukuai3@huawei.com>
Cc:     axboe@kernel.dk, josef@toxicpanda.com, hch@infradead.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        nbd@other.debian.org, yi.zhang@huawei.com
Subject: Re: [PATCH v5 5/6] nbd: convert to use blk_mq_find_and_get_req()
Message-ID: <YUFldgfRYrJyxFtz@T590>
References: <20210909141256.2606682-1-yukuai3@huawei.com>
 <20210909141256.2606682-6-yukuai3@huawei.com>
 <YT/2z4PSeW5oJWMq@T590>
 <c6af73a2-f12d-eeef-616e-ae0cdb4f6f2d@huawei.com>
 <YUBE4BJ7+kN1c4l8@T590>
 <374c6b37-b4b2-fe01-66be-ca2dbbc283e9@huawei.com>
 <YUBTVBioqJ7qas2R@T590>
 <b8301834-5541-76ee-13a9-0fa565fce7e3@huawei.com>
 <YUCzr2ysb+vJ1x0W@T590>
 <8f1849a3-6bf2-6b14-7ef9-4969a9a5425b@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8f1849a3-6bf2-6b14-7ef9-4969a9a5425b@huawei.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Sep 15, 2021 at 09:54:09AM +0800, yukuai (C) wrote:
> On 2021/09/14 22:37, Ming Lei wrote:
> > On Tue, Sep 14, 2021 at 05:19:31PM +0800, yukuai (C) wrote:
> > > On 在 2021/09/14 15:46, Ming Lei wrote:
> > > 
> > > > If the above can happen, blk_mq_find_and_get_req() may not fix it too, just
> > > > wondering why not take the following simpler way for avoiding the UAF?
> > > > 
> > > > diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> > > > index 5170a630778d..dfa5cce71f66 100644
> > > > --- a/drivers/block/nbd.c
> > > > +++ b/drivers/block/nbd.c
> > > > @@ -795,9 +795,13 @@ static void recv_work(struct work_struct *work)
> > > >    						     work);
> > > >    	struct nbd_device *nbd = args->nbd;
> > > >    	struct nbd_config *config = nbd->config;
> > > > +	struct request_queue *q = nbd->disk->queue;
> > > >    	struct nbd_cmd *cmd;
> > > >    	struct request *rq;
> > > > +	if (!percpu_ref_tryget(&q->q_usage_counter))
> > > > +                return;
> > > > +
> > > >    	while (1) {
> > > >    		cmd = nbd_read_stat(nbd, args->index);
> > > >    		if (IS_ERR(cmd)) {
> > > > @@ -813,6 +817,7 @@ static void recv_work(struct work_struct *work)
> > > >    		if (likely(!blk_should_fake_timeout(rq->q)))
> > > >    			blk_mq_complete_request(rq);
> > > >    	}
> > > > +	blk_queue_exit(q);
> > > >    	nbd_config_put(nbd);
> > > >    	atomic_dec(&config->recv_threads);
> > > >    	wake_up(&config->recv_wq);
> > > > 
> > > 
> > > Hi, Ming
> > > 
> > > This apporch is wrong.
> > > 
> > > If blk_mq_freeze_queue() is called, and nbd is waiting for all
> > > request to complete. percpu_ref_tryget() will fail here, and deadlock
> > > will occur because request can't complete in recv_work().
> > 
> > No, percpu_ref_tryget() won't fail until ->q_usage_counter is zero, when
> > it is perfectly fine to do nothing in recv_work().
> > 
> 
> Hi Ming
> 
> This apporch is a good idea, however we should not get q_usage_counter
> in reccv_work(), because It will block freeze queue.
> 
> How about get q_usage_counter in nbd_read_stat(), and put in error path
> or after request completion?

OK, looks I missed that nbd_read_stat() needs to wait for incoming reply
first, so how about the following change by partitioning nbd_read_stat()
into nbd_read_reply() and nbd_handle_reply()?

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 5170a630778d..477fe057fc93 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -683,38 +683,47 @@ static int nbd_send_cmd(struct nbd_device *nbd, struct nbd_cmd *cmd, int index)
 	return 0;
 }
 
-/* NULL returned = something went wrong, inform userspace */
-static struct nbd_cmd *nbd_read_stat(struct nbd_device *nbd, int index)
+static int nbd_read_reply(struct nbd_device *nbd, int index,
+		struct nbd_reply *reply)
 {
-	struct nbd_config *config = nbd->config;
 	int result;
-	struct nbd_reply reply;
-	struct nbd_cmd *cmd;
-	struct request *req = NULL;
-	u64 handle;
-	u16 hwq;
-	u32 tag;
-	struct kvec iov = {.iov_base = &reply, .iov_len = sizeof(reply)};
+	struct kvec iov = {.iov_base = reply, .iov_len = sizeof(*reply)};
 	struct iov_iter to;
-	int ret = 0;
 
-	reply.magic = 0;
+	reply->magic = 0;
 	iov_iter_kvec(&to, READ, &iov, 1, sizeof(reply));
 	result = sock_xmit(nbd, index, 0, &to, MSG_WAITALL, NULL);
-	if (result <= 0) {
-		if (!nbd_disconnected(config))
+	if (result < 0) {
+		if (!nbd_disconnected(nbd->config))
 			dev_err(disk_to_dev(nbd->disk),
 				"Receive control failed (result %d)\n", result);
-		return ERR_PTR(result);
+		return result;
 	}
 
-	if (ntohl(reply.magic) != NBD_REPLY_MAGIC) {
+	if (ntohl(reply->magic) != NBD_REPLY_MAGIC) {
 		dev_err(disk_to_dev(nbd->disk), "Wrong magic (0x%lx)\n",
-				(unsigned long)ntohl(reply.magic));
-		return ERR_PTR(-EPROTO);
+				(unsigned long)ntohl(reply->magic));
+		return -EPROTO;
 	}
 
-	memcpy(&handle, reply.handle, sizeof(handle));
+	return 0;
+}
+
+/* NULL returned = something went wrong, inform userspace */
+static struct nbd_cmd *nbd_handle_reply(struct nbd_device *nbd, int index,
+		struct nbd_reply *reply)
+{
+	struct nbd_config *config = nbd->config;
+	int result;
+	struct nbd_cmd *cmd;
+	struct request *req = NULL;
+	u64 handle;
+	u16 hwq;
+	u32 tag;
+	struct iov_iter to;
+	int ret = 0;
+
+	memcpy(&handle, reply->handle, sizeof(handle));
 	tag = nbd_handle_to_tag(handle);
 	hwq = blk_mq_unique_tag_to_hwq(tag);
 	if (hwq < nbd->tag_set.nr_hw_queues)
@@ -747,9 +756,9 @@ static struct nbd_cmd *nbd_read_stat(struct nbd_device *nbd, int index)
 		ret = -ENOENT;
 		goto out;
 	}
-	if (ntohl(reply.error)) {
+	if (ntohl(reply->error)) {
 		dev_err(disk_to_dev(nbd->disk), "Other side returned error (%d)\n",
-			ntohl(reply.error));
+			ntohl(reply->error));
 		cmd->status = BLK_STS_IOERR;
 		goto out;
 	}
@@ -795,24 +804,36 @@ static void recv_work(struct work_struct *work)
 						     work);
 	struct nbd_device *nbd = args->nbd;
 	struct nbd_config *config = nbd->config;
+	struct request_queue *q = nbd->disk->queue;
+	struct nbd_sock *nsock;
 	struct nbd_cmd *cmd;
 	struct request *rq;
 
 	while (1) {
-		cmd = nbd_read_stat(nbd, args->index);
-		if (IS_ERR(cmd)) {
-			struct nbd_sock *nsock = config->socks[args->index];
+		struct nbd_reply reply;
 
-			mutex_lock(&nsock->tx_lock);
-			nbd_mark_nsock_dead(nbd, nsock, 1);
-			mutex_unlock(&nsock->tx_lock);
+		if (nbd_read_reply(nbd, args->index, &reply))
 			break;
-		}
 
+		if (!percpu_ref_tryget(&q->q_usage_counter))
+			break;
+
+		cmd = nbd_handle_reply(nbd, args->index, &reply);
+		if (IS_ERR(cmd)) {
+			blk_queue_exit(q);
+			break;
+		}
 		rq = blk_mq_rq_from_pdu(cmd);
 		if (likely(!blk_should_fake_timeout(rq->q)))
 			blk_mq_complete_request(rq);
+		blk_queue_exit(q);
 	}
+
+	nsock = config->socks[args->index];
+	mutex_lock(&nsock->tx_lock);
+	nbd_mark_nsock_dead(nbd, nsock, 1);
+	mutex_unlock(&nsock->tx_lock);
+
 	nbd_config_put(nbd);
 	atomic_dec(&config->recv_threads);
 	wake_up(&config->recv_wq);


Thanks,
Ming

