Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6A62C433FE
	for <linux-block@archiver.kernel.org>; Mon, 28 Mar 2022 15:50:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239923AbiC1PwX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Mar 2022 11:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239920AbiC1PwW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Mar 2022 11:52:22 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 721C4100
        for <linux-block@vger.kernel.org>; Mon, 28 Mar 2022 08:50:40 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id mp11-20020a17090b190b00b001c79aa8fac4so155035pjb.0
        for <linux-block@vger.kernel.org>; Mon, 28 Mar 2022 08:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2FC5q0QTLMQlOMPNbeelt9gAcyzEt30HNRyg0i+B/zU=;
        b=Ks1TVnrC498THU2u6zU1C0hM0zLu/ESAF6cbGwZpuqis6BTRxuFn1G0JWSJ4OCBhLn
         Zy2qyxerW+/9giWiBjdKhu2DGsdYdJLRr4WpTnOqnSGGnfigyWWAQ1Mgu8XFPZtVodnr
         aVc+tTxcGDmUqdlMRxLGMSclOqzAH/lOLazHqqbvw4tSVS2D5AksUD5w0obeUYQCUqfW
         jWa2cYMCem0oQFLxVBhDMjh+A91/ogB8oaH+G3JunyIdxY+6eJhPI5mF5SVurcNtPw2i
         HmUxc6xtCMY03w2677tII3pKN9Chptk0dOgd5i2zSPTPSXqc4wt9CdgAbtAR8V1UmOY2
         bTsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2FC5q0QTLMQlOMPNbeelt9gAcyzEt30HNRyg0i+B/zU=;
        b=jUmpryzpMvMtyLVKTVkzb9YDBewahGsXmqrxbhqbSCDMA8Od1dGVfWQdXbBYcO7WyT
         /PayRN/bV1kjZjSi7X4DBeVK74s1dTFDbag9eTB6dNF62aZn5Tk1Yxfw4V5R7xzjIUNs
         JSwERt5eYjwpzFu/YKOVvAdVWcJzWPdVzOCLsrkLdCvydiRbLy+a0McAgvS29u0L6xB/
         2JD2L4/YtPQEW+l/6kkiVcR5LoYGRlN9ySzGn4DnuU+toCJ5CE+IGz8pY72c1ITZuJcn
         +MpxjpEGIZm8SNLcquaU+nlMxLtFFCcuHcaoRP7wB0bkaCUFRQOXeQqvgdY4eu5mDE/e
         CZvw==
X-Gm-Message-State: AOAM532HUbhRM2t3LPNkMV1Yn6Dc6PXC41ZQ4UU7UV7tvpLgVYiovHfd
        9zqf9x71xtp4q7ck9bFdAvY=
X-Google-Smtp-Source: ABdhPJzg68BZOKrPk2NDy5H11GYrO7hZK6u4vZgUgA205+1emFOzTscSeNCEo3Ght2MNkCKYpNaBNQ==
X-Received: by 2002:a17:902:c105:b0:154:81e0:529d with SMTP id 5-20020a170902c10500b0015481e0529dmr26588501pli.1.1648482639842;
        Mon, 28 Mar 2022 08:50:39 -0700 (PDT)
Received: from localhost.localdomain ([114.200.4.15])
        by smtp.gmail.com with ESMTPSA id m18-20020a639412000000b003820bd9f2f2sm13753710pge.53.2022.03.28.08.50.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 08:50:39 -0700 (PDT)
Date:   Tue, 29 Mar 2022 00:50:33 +0900
From:   Suwan Kim <suwan.kim027@gmail.com>
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     mst@redhat.com, jasowang@redhat.com, pbonzini@redhat.com,
        mgurtovoy@nvidia.com, virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH v3 2/2] virtio-blk: support mq_ops->queue_rqs()
Message-ID: <YkHZSV+USBSRPuTv@localhost.localdomain>
References: <20220324140450.33148-1-suwan.kim027@gmail.com>
 <20220324140450.33148-3-suwan.kim027@gmail.com>
 <YkG1HeQ8qu11KFnF@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YkG1HeQ8qu11KFnF@stefanha-x1.localdomain>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Mar 28, 2022 at 02:16:13PM +0100, Stefan Hajnoczi wrote:
> On Thu, Mar 24, 2022 at 11:04:50PM +0900, Suwan Kim wrote:
> > @@ -367,6 +381,66 @@ static blk_status_t virtio_queue_rq(struct blk_mq_hw_ctx *hctx,
> >  	return BLK_STS_OK;
> >  }
> >  
> > +static bool virtblk_prep_rq_batch(struct virtio_blk_vq *vq, struct request *req)
> > +{
> > +	struct virtio_blk *vblk = req->mq_hctx->queue->queuedata;
> > +	struct virtblk_req *vbr = blk_mq_rq_to_pdu(req);
> > +	unsigned long flags;
> > +	int num, err;
> > +
> > +	req->mq_hctx->tags->rqs[req->tag] = req;
> > +
> > +	if (virtblk_prep_rq(req->mq_hctx, vblk, req, vbr, &num) != BLK_STS_OK)
> > +		return false;
> > +
> > +	spin_lock_irqsave(&vq->lock, flags);
> > +	err = virtblk_add_req(vq->vq, vbr, vbr->sg_table.sgl, num);
> > +	if (err) {
> > +		spin_unlock_irqrestore(&vq->lock, flags);
> > +		virtblk_unmap_data(req, vbr);
> > +		virtblk_cleanup_cmd(req);
> > +		return false;
> > +	}
> > +	spin_unlock_irqrestore(&vq->lock, flags);
> 
> Simplification:
> 
>   spin_lock_irqsave(&vq->lock, flags);
>   err = virtblk_add_req(vq->vq, vbr, vbr->sg_table.sgl, num);
>   spin_unlock_irqrestore(&vq->lock, flags);
>   if (err) {
>       virtblk_unmap_data(req, vbr);
>       virtblk_cleanup_cmd(req);
>       return false;
>   }
> 

Thanks! I will fix it.

> > +
> > +	return true;
> > +}
> > +
> > +static void virtio_queue_rqs(struct request **rqlist)
> > +{
> > +	struct request *req, *next, *prev = NULL;
> > +	struct request *requeue_list = NULL;
> > +
> > +	rq_list_for_each_safe(rqlist, req, next) {
> > +		struct virtio_blk_vq *vq = req->mq_hctx->driver_data;
> > +		unsigned long flags;
> > +		bool kick;
> > +
> > +		if (!virtblk_prep_rq_batch(vq, req)) {
> > +			rq_list_move(rqlist, &requeue_list, req, prev);
> > +			req = prev;
> > +
> > +			if (!req)
> > +				continue;
> > +		}
> > +
> > +		if (!next || req->mq_hctx != next->mq_hctx) {
> > +			spin_lock_irqsave(&vq->lock, flags);
> 
> Did you try calling virtblk_add_req() here to avoid acquiring and
> releasing the lock multiple times? In other words, do virtblk_prep_rq()
> but wait until we get here to do virtblk_add_req().
> 
> I don't know if it has any measurable effect on performance or maybe the
> code would become too complex, but I noticed that we're not fully
> exploiting batching.

I tried as you said. I called virtlblk_add_req() and added requests
of rqlist to virtqueue in this if statement with holding the lock
only once.

I attach the code at the end of this mail.
Please refer the code.

But I didn't see improvement. It showed slightly worse performance
than the current patch.

> > +			kick = virtqueue_kick_prepare(vq->vq);
> > +			spin_unlock_irqrestore(&vq->lock, flags);
> > +			if (kick)
> > +				virtqueue_notify(vq->vq);
> > +
> > +			req->rq_next = NULL;

Did you ask this part?

> > +			*rqlist = next;
> > +			prev = NULL;
> > +		} else
> > +			prev = req;
> 
> What guarantees that req is still alive after we called
> virtblk_add_req()? The device may have seen it and completed it already
> by the time we get here.

Isn't request completed after the kick?

If you asked about "req->rq_next = NULL",
I think it should be placed before
"kick = virtqueue_kick_prepare(vq->vq);"

-----------
	req->rq_next = NULL;
	kick = virtqueue_kick_prepare(vq->vq);
	spin_unlock_irqrestore(&vq->lock, flags);
	if (kick)
		virtqueue_notify(vq->vq);
-----------

Regards,
Suwan Kim

---

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 2218cab39c72..d972d3042068 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -92,6 +92,7 @@ struct virtio_blk {
 struct virtblk_req {
 	struct virtio_blk_outhdr out_hdr;
 	u8 status;
+	int sg_num;
 	struct sg_table sg_table;
 	struct scatterlist sg[];
 };
@@ -311,18 +312,13 @@ static void virtio_commit_rqs(struct blk_mq_hw_ctx *hctx)
 		virtqueue_notify(vq->vq);
 }

-static blk_status_t virtio_queue_rq(struct blk_mq_hw_ctx *hctx,
-			   const struct blk_mq_queue_data *bd)
+static blk_status_t virtblk_prep_rq(struct blk_mq_hw_ctx *hctx,
+					struct virtio_blk *vblk,
+					struct request *req,
+					struct virtblk_req *vbr)
 {
-	struct virtio_blk *vblk = hctx->queue->queuedata;
-	struct request *req = bd->rq;
-	struct virtblk_req *vbr = blk_mq_rq_to_pdu(req);
-	unsigned long flags;
-	int num;
-	int qid = hctx->queue_num;
-	bool notify = false;
 	blk_status_t status;
-	int err;
+	int num;

 	status = virtblk_setup_cmd(vblk->vdev, req, vbr);
 	if (unlikely(status))
@@ -335,9 +331,30 @@ static blk_status_t virtio_queue_rq(struct blk_mq_hw_ctx *hctx,
 		virtblk_cleanup_cmd(req);
 		return BLK_STS_RESOURCE;
 	}
+	vbr->sg_num = num;
+
+	return BLK_STS_OK;
+}
+
+static blk_status_t virtio_queue_rq(struct blk_mq_hw_ctx *hctx,
+			   const struct blk_mq_queue_data *bd)
+{
+	struct virtio_blk *vblk = hctx->queue->queuedata;
+	struct request *req = bd->rq;
+	struct virtblk_req *vbr = blk_mq_rq_to_pdu(req);
+	unsigned long flags;
+	int qid = hctx->queue_num;
+	bool notify = false;
+	blk_status_t status;
+	int err;
+
+	status = virtblk_prep_rq(hctx, vblk, req, vbr);
+	if (unlikely(status))
+		return status;

 	spin_lock_irqsave(&vblk->vqs[qid].lock, flags);
-	err = virtblk_add_req(vblk->vqs[qid].vq, vbr, vbr->sg_table.sgl, num);
+	err = virtblk_add_req(vblk->vqs[qid].vq, vbr,
+				vbr->sg_table.sgl, vbr->sg_num);
 	if (err) {
 		virtqueue_kick(vblk->vqs[qid].vq);
 		/* Don't stop the queue if -ENOMEM: we may have failed to
@@ -367,6 +384,76 @@ static blk_status_t virtio_queue_rq(struct blk_mq_hw_ctx *hctx,
 	return BLK_STS_OK;
 }

+static bool virtblk_prep_rq_batch(struct virtio_blk_vq *vq, struct request *req)
+{
+	struct virtio_blk *vblk = req->mq_hctx->queue->queuedata;
+	struct virtblk_req *vbr = blk_mq_rq_to_pdu(req);
+
+	req->mq_hctx->tags->rqs[req->tag] = req;
+
+	return virtblk_prep_rq(req->mq_hctx, vblk, req, vbr) == BLK_STS_OK;
+}
+
+static bool virtblk_add_req_batch(struct virtio_blk_vq *vq,
+					struct request **rqlist,
+					struct request **requeue_list)
+{
+	unsigned long flags;
+	int err;
+	bool kick;
+
+	spin_lock_irqsave(&vq->lock, flags);
+	while (!rq_list_empty(*rqlist)) {
+		struct request *req = rq_list_pop(rqlist);
+		struct virtblk_req *vbr = blk_mq_rq_to_pdu(req);
+
+		err = virtblk_add_req(vq->vq, vbr,
+					vbr->sg_table.sgl, vbr->sg_num);
+		if (err) {
+			virtblk_unmap_data(req, vbr);
+			virtblk_cleanup_cmd(req);
+			rq_list_add(requeue_list, req);
+		}
+	}
+
+	kick = virtqueue_kick_prepare(vq->vq);
+	spin_unlock_irqrestore(&vq->lock, flags);
+
+	return kick;
+}
+
+static void virtio_queue_rqs(struct request **rqlist)
+{
+	struct request *req, *next, *prev = NULL;
+	struct request *requeue_list = NULL;
+
+	rq_list_for_each_safe(rqlist, req, next) {
+		struct virtio_blk_vq *vq = req->mq_hctx->driver_data;
+		bool kick;
+
+		if (!virtblk_prep_rq_batch(vq, req)) {
+			rq_list_move(rqlist, &requeue_list, req, prev);
+			req = prev;
+
+			if (!req)
+				continue;
+		}
+
+		if (!next || req->mq_hctx != next->mq_hctx) {
+			kick = virtblk_add_req_batch(vq, rqlist, &requeue_list);
+			if (kick)
+				virtqueue_notify(vq->vq);
+
+			req->rq_next = NULL;
+			*rqlist = next;
+			prev = NULL;
+		} else
+			prev = req;
+	}
+
+	*rqlist = requeue_list;
+}
+
 /* return id (s/n) string for *disk to *id_str
  */
 static int virtblk_get_id(struct gendisk *disk, char *id_str)
@@ -818,6 +905,7 @@ static int virtblk_init_hctx(struct blk_mq_hw_ctx *hctx, void *data,

 static const struct blk_mq_ops virtio_mq_ops = {
 	.queue_rq	= virtio_queue_rq,
+	.queue_rqs	= virtio_queue_rqs,
 	.commit_rqs	= virtio_commit_rqs,
 	.init_hctx	= virtblk_init_hctx,
 	.complete	= virtblk_request_done,

