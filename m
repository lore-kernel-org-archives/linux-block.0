Return-Path: <SRS0=mhrr=QI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63E23C282D8
	for <linux-block@archiver.kernel.org>; Fri,  1 Feb 2019 07:57:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B85420869
	for <linux-block@archiver.kernel.org>; Fri,  1 Feb 2019 07:57:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZfQfrY5k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbfBAH4I (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 1 Feb 2019 02:56:08 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:33990 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbfBAH4I (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 1 Feb 2019 02:56:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=nHfwlcHmoxRFtQ76i+nsMJQiGCw1RgNUHm664wxU9fs=; b=ZfQfrY5krmGNOE54OHAvq6t35L
        ZC3oYR/ACaxQlP0pWoVJPa80anCiQFlMELYytUHa9LCbO67jVyUXbTfgSG5Fl3ALBpIwP2+Sc8DW3
        Iwsf8J6GaOChmklBqIxtuhQ7afDno9d6QSNgy4wua6xBAAyBbDpiMXuYfV6aJDLhicrtvDNHmlrvI
        VJx0SawqTkgBxHkOtjOhlQyBtJasv0sdMf56oEsFXfgnYTqOj3UHAXUisP6Yh9t/05woD6DBu4Qh0
        sPulZyRsV0aUx+LFtYqGBm2YXbnwSUIKN1IvCwQVVkaKavBWcJB+bWXXVIM1bqdv5Fr3ZEZAe0JTA
        IUTiRHww==;
Received: from 089144212163.atnat0021.highway.a1.net ([89.144.212.163] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gpTgB-0005f9-Ie; Fri, 01 Feb 2019 07:56:04 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk, martin.petersen@oracle.com, ooo@electrozaur.com
Cc:     Johannes Thumshirn <jthumshirn@suse.de>,
        Benjamin Block <bblock@linux.vnet.ibm.com>,
        linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Benjamin Block <bblock@linux.ibm.com>,
        Avri Altman <avri.altman@wdc.com>
Subject: [PATCH 1/8] bsg: refactor bsg_ioctl
Date:   Fri,  1 Feb 2019 08:55:50 +0100
Message-Id: <20190201075557.9249-2-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190201075557.9249-1-hch@lst.de>
References: <20190201075557.9249-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Move all actual functionality into helpers, just leaving the dispatch
in this function.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Benjamin Block <bblock@linux.ibm.com>
Tested-by: Benjamin Block <bblock@linux.ibm.com>
Tested-by: Avri Altman <avri.altman@wdc.com>
---
 block/bsg.c | 158 ++++++++++++++++++++++++----------------------------
 1 file changed, 72 insertions(+), 86 deletions(-)

diff --git a/block/bsg.c b/block/bsg.c
index 50e5f8f666f2..a799b0ace55c 100644
--- a/block/bsg.c
+++ b/block/bsg.c
@@ -138,32 +138,35 @@ static const struct bsg_ops bsg_scsi_ops = {
 	.free_rq		= bsg_scsi_free_rq,
 };
 
-static struct request *
-bsg_map_hdr(struct request_queue *q, struct sg_io_v4 *hdr, fmode_t mode)
+static int bsg_sg_io(struct request_queue *q, fmode_t mode, void __user *uarg)
 {
 	struct request *rq, *next_rq = NULL;
+	struct bio *bio, *bidi_bio = NULL;
+	struct sg_io_v4 hdr;
 	int ret;
 
-	if (!q->bsg_dev.class_dev)
-		return ERR_PTR(-ENXIO);
+	if (copy_from_user(&hdr, uarg, sizeof(hdr)))
+		return -EFAULT;
 
-	if (hdr->guard != 'Q')
-		return ERR_PTR(-EINVAL);
+	if (!q->bsg_dev.class_dev)
+		return -ENXIO;
 
-	ret = q->bsg_dev.ops->check_proto(hdr);
+	if (hdr.guard != 'Q')
+		return -EINVAL;
+	ret = q->bsg_dev.ops->check_proto(&hdr);
 	if (ret)
-		return ERR_PTR(ret);
+		return ret;
 
-	rq = blk_get_request(q, hdr->dout_xfer_len ?
+	rq = blk_get_request(q, hdr.dout_xfer_len ?
 			REQ_OP_SCSI_OUT : REQ_OP_SCSI_IN, 0);
 	if (IS_ERR(rq))
-		return rq;
+		return PTR_ERR(rq);
 
-	ret = q->bsg_dev.ops->fill_hdr(rq, hdr, mode);
+	ret = q->bsg_dev.ops->fill_hdr(rq, &hdr, mode);
 	if (ret)
 		goto out;
 
-	rq->timeout = msecs_to_jiffies(hdr->timeout);
+	rq->timeout = msecs_to_jiffies(hdr.timeout);
 	if (!rq->timeout)
 		rq->timeout = q->sg_timeout;
 	if (!rq->timeout)
@@ -171,7 +174,7 @@ bsg_map_hdr(struct request_queue *q, struct sg_io_v4 *hdr, fmode_t mode)
 	if (rq->timeout < BLK_MIN_SG_TIMEOUT)
 		rq->timeout = BLK_MIN_SG_TIMEOUT;
 
-	if (hdr->dout_xfer_len && hdr->din_xfer_len) {
+	if (hdr.dout_xfer_len && hdr.din_xfer_len) {
 		if (!test_bit(QUEUE_FLAG_BIDI, &q->queue_flags)) {
 			ret = -EOPNOTSUPP;
 			goto out;
@@ -188,42 +191,29 @@ bsg_map_hdr(struct request_queue *q, struct sg_io_v4 *hdr, fmode_t mode)
 		}
 
 		rq->next_rq = next_rq;
-		ret = blk_rq_map_user(q, next_rq, NULL, uptr64(hdr->din_xferp),
-				       hdr->din_xfer_len, GFP_KERNEL);
+		ret = blk_rq_map_user(q, next_rq, NULL, uptr64(hdr.din_xferp),
+				       hdr.din_xfer_len, GFP_KERNEL);
 		if (ret)
 			goto out_free_nextrq;
 	}
 
-	if (hdr->dout_xfer_len) {
-		ret = blk_rq_map_user(q, rq, NULL, uptr64(hdr->dout_xferp),
-				hdr->dout_xfer_len, GFP_KERNEL);
-	} else if (hdr->din_xfer_len) {
-		ret = blk_rq_map_user(q, rq, NULL, uptr64(hdr->din_xferp),
-				hdr->din_xfer_len, GFP_KERNEL);
+	if (hdr.dout_xfer_len) {
+		ret = blk_rq_map_user(q, rq, NULL, uptr64(hdr.dout_xferp),
+				hdr.dout_xfer_len, GFP_KERNEL);
+	} else if (hdr.din_xfer_len) {
+		ret = blk_rq_map_user(q, rq, NULL, uptr64(hdr.din_xferp),
+				hdr.din_xfer_len, GFP_KERNEL);
 	}
 
 	if (ret)
 		goto out_unmap_nextrq;
-	return rq;
 
-out_unmap_nextrq:
+	bio = rq->bio;
 	if (rq->next_rq)
-		blk_rq_unmap_user(rq->next_rq->bio);
-out_free_nextrq:
-	if (rq->next_rq)
-		blk_put_request(rq->next_rq);
-out:
-	q->bsg_dev.ops->free_rq(rq);
-	blk_put_request(rq);
-	return ERR_PTR(ret);
-}
-
-static int blk_complete_sgv4_hdr_rq(struct request *rq, struct sg_io_v4 *hdr,
-				    struct bio *bio, struct bio *bidi_bio)
-{
-	int ret;
+		bidi_bio = rq->next_rq->bio;
 
-	ret = rq->q->bsg_dev.ops->complete_rq(rq, hdr);
+	blk_execute_rq(q, NULL, rq, !(hdr.flags & BSG_FLAG_Q_AT_TAIL));
+	ret = rq->q->bsg_dev.ops->complete_rq(rq, &hdr);
 
 	if (rq->next_rq) {
 		blk_rq_unmap_user(bidi_bio);
@@ -233,6 +223,20 @@ static int blk_complete_sgv4_hdr_rq(struct request *rq, struct sg_io_v4 *hdr,
 	blk_rq_unmap_user(bio);
 	rq->q->bsg_dev.ops->free_rq(rq);
 	blk_put_request(rq);
+
+	if (copy_to_user(uarg, &hdr, sizeof(hdr)))
+		return -EFAULT;
+	return ret;
+
+out_unmap_nextrq:
+	if (rq->next_rq)
+		blk_rq_unmap_user(rq->next_rq->bio);
+out_free_nextrq:
+	if (rq->next_rq)
+		blk_put_request(rq->next_rq);
+out:
+	q->bsg_dev.ops->free_rq(rq);
+	blk_put_request(rq);
 	return ret;
 }
 
@@ -367,31 +371,39 @@ static int bsg_release(struct inode *inode, struct file *file)
 	return bsg_put_device(bd);
 }
 
+static int bsg_get_command_q(struct bsg_device *bd, int __user *uarg)
+{
+	return put_user(bd->max_queue, uarg);
+}
+
+static int bsg_set_command_q(struct bsg_device *bd, int __user *uarg)
+{
+	int queue;
+
+	if (get_user(queue, uarg))
+		return -EFAULT;
+	if (queue < 1)
+		return -EINVAL;
+
+	spin_lock_irq(&bd->lock);
+	bd->max_queue = queue;
+	spin_unlock_irq(&bd->lock);
+	return 0;
+}
+
 static long bsg_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 {
 	struct bsg_device *bd = file->private_data;
-	int __user *uarg = (int __user *) arg;
-	int ret;
+	void __user *uarg = (void __user *) arg;
 
 	switch (cmd) {
-		/*
-		 * our own ioctls
-		 */
+	/*
+	 * Our own ioctls
+	 */
 	case SG_GET_COMMAND_Q:
-		return put_user(bd->max_queue, uarg);
-	case SG_SET_COMMAND_Q: {
-		int queue;
-
-		if (get_user(queue, uarg))
-			return -EFAULT;
-		if (queue < 1)
-			return -EINVAL;
-
-		spin_lock_irq(&bd->lock);
-		bd->max_queue = queue;
-		spin_unlock_irq(&bd->lock);
-		return 0;
-	}
+		return bsg_get_command_q(bd, uarg);
+	case SG_SET_COMMAND_Q:
+		return bsg_set_command_q(bd, uarg);
 
 	/*
 	 * SCSI/sg ioctls
@@ -404,36 +416,10 @@ static long bsg_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	case SG_GET_RESERVED_SIZE:
 	case SG_SET_RESERVED_SIZE:
 	case SG_EMULATED_HOST:
-	case SCSI_IOCTL_SEND_COMMAND: {
-		void __user *uarg = (void __user *) arg;
+	case SCSI_IOCTL_SEND_COMMAND:
 		return scsi_cmd_ioctl(bd->queue, NULL, file->f_mode, cmd, uarg);
-	}
-	case SG_IO: {
-		struct request *rq;
-		struct bio *bio, *bidi_bio = NULL;
-		struct sg_io_v4 hdr;
-		int at_head;
-
-		if (copy_from_user(&hdr, uarg, sizeof(hdr)))
-			return -EFAULT;
-
-		rq = bsg_map_hdr(bd->queue, &hdr, file->f_mode);
-		if (IS_ERR(rq))
-			return PTR_ERR(rq);
-
-		bio = rq->bio;
-		if (rq->next_rq)
-			bidi_bio = rq->next_rq->bio;
-
-		at_head = (0 == (hdr.flags & BSG_FLAG_Q_AT_TAIL));
-		blk_execute_rq(bd->queue, NULL, rq, at_head);
-		ret = blk_complete_sgv4_hdr_rq(rq, &hdr, bio, bidi_bio);
-
-		if (copy_to_user(uarg, &hdr, sizeof(hdr)))
-			return -EFAULT;
-
-		return ret;
-	}
+	case SG_IO:
+		return bsg_sg_io(bd->queue, file->f_mode, uarg);
 	default:
 		return -ENOTTY;
 	}
-- 
2.20.1

