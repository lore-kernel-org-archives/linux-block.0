Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793205924;
	b=DG/QuyN9ED8n7XumD9WUIfh/D9p5b1t+3eGEoL6L7MUDTf67p8DWC4DTOJbbdOzXGx8W
	 3OWzwUmvenGVOZt9tYupEv0BoH8uNHvnK4orpgFIULUdGapXRoicumdSU18UH84BPNkYq
	 66KZZvsrW9yU+pLoeQL4/KHexu7Fw1BWJIlrvjMePLYI7mE8bLuRl2V9oHKkNFASbZmsx
	 ghG91UG/FAiFctZnzfeoybiybGLy8PiyM/GJh3vq9SJZYUPcEbq8LohgI6o0K6oN1QGPw
	 K3xm4mh2ERpI0qpOEhuxd95R71hwdi3nFF8He007bDBJrGFxuICG/Vd96hdFmcexGKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793205924;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=UeJG0UOUSLPCvfdOy7lwocxX0Ei1nki1DOccly1XwLY=;
	b=EaYiejdFZdn+woAVMSPf6hFbSiV5rvTS3l6Lw0b8cBvykIWpu4ba1XWn9mb/eND0ZZlU
	 8Q2ctbAuuVXiaU7tYIia0t9lRjM5Syrp67X2Gj2J6cy6J/iKNyVX6exgEig1wsSqwoAq+
	 rqfDP0W+cS6pVych8Rvc3a1zrILOJ82MBS7irgolo5Tt8yqCCWFuGVMDI5Dfjvg8cg12V
	 pUIKPgOXttetiBmW8o21MAicrxxA5ngSVCceYtNVYw8bfVQ+/JrsxBvl5ow0ZbWQwQQon
	 LETa3H8E601WQzOCVjMJZGyLpJJsn6kD9uaIDaNudk60CDydyKIY0YOH38U7BlWRlng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b="XD/3Z2hs";
	arc=none smtp.remote-ip=209.85.161.47
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9F3606A31E
	for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 16:45:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BE9F3606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=XD/3Z2hs
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-6df7f544919so790593eaf.1
        for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 09:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793205922; x=1793810722; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UeJG0UOUSLPCvfdOy7lwocxX0Ei1nki1DOccly1XwLY=;
        b=XD/3Z2hsY+2XTNjdASiT0DRikSX4fmioDdKU6r8pnTIuyRZ3Yu8tfqmrZ5B8zOs90w
         ZU8Z18QyypQO0MStoDOZ7YrvrX7NEQbbWmXCzTXKpRnpktawFwxOwK1f7L6GYW2i3dML
         7kFgt2Xr4QzILfxZk4lCAtZ9caMrqYvKftZpZG7VPm/Fksku+r76Vaf+zokCRNGFmHkY
         Kt50GDlcqmv817wxVv3f4Mj9irBAvpzO/8cxp+Yafwe/iLIDB7aqgiFx2+VcrvBajRy0
         2vOWfWEsfYo7UY+xeytNSgGjEb5QCSrwd4d5VxSn4IR5WD56zkngVKABeAR7c5G6K0S4
         puCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793205922; x=1793810722;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UeJG0UOUSLPCvfdOy7lwocxX0Ei1nki1DOccly1XwLY=;
        b=GBJ2ySbBwajF+6L5bhqJP3jQPs1iUBsf1C0z+QaPywhj/9g6JkmcsoDH1tjAhBgaaj
         nTWrhdLL2O6Ts44DAaqnxdNvXl3yfrFhQutwZpn4/0TYMYG0p6W5jASVWI4mM36i2DY6
         rRfPuFosk+21qNvLUWX/QPZBZggqAGflAGWD19gVp7Ho99Q94ZnEQbWHF1fCt3+m6C4G
         DhCX1xzJ5IVHy1qUbRiWfF9DknkfgedQa9suZPEr06wvQEf9Q/UakNichb4PbR6G6KH3
         DRs5cbYrTR/xAgvbmA9/vBOkjUNGGk/hYJH8QmTt9M/dqSNmSfpEP9ttYYzFMzZoYU9K
         KmiA==
X-Gm-Message-State: AFq9FYI/5BJrjhkRJSBI3Gd0iiliWrg1SklD2J/ziDbtYmAXrIdvBuXt
	lCpCsE7IXEa0hujnNY/f1NIAifvs4YIE/f4I78H1ZJ/gWYiwqHR6rYbO1lDrFkULqYccEd94YzO
	22Fjg47I=
X-Gm-Gg: AYBFou2chphl7wKn0EFdhf+jsu3ewKu63NRxk8gui+Ych9OeLqVdWoDkydRi05bfHF6
	M6UUsPrdxJAqEJA9JfHVMmS1k+dVskN4TFAsGnsR28gAy2ZOAkaQFRTmqq7LkpKmBE1Ht1REXMi
	MdG5Bn43H6+z+ltwFghfyYU2898hzU/DmnbKh/YYZcOAx+Dm5s7GS2gS1RDA/5sQEjmGaFLBbQf
	8uU5puCgH8qJKFdpUn4qCGsmJer4WR1y6cHe7GGQIj0MD4xiczVwzs1qhDEbAdNyPbXX3Em3ZdZ
	fxT+qsQQjy3ESOcu/4YV2ooHpPW22LHJf2IZPRnqkFL0NmZGyJKJGP6MPpb5ZKMwB07kPWuUwqO
	iGs5jzpWVmZ1EqON3N9IwWWduiIXIxcp3tP0VABXhsFLmB9lyMvrsuFjRUb5p9cLPPG3owHCltH
	LOAJalA9UThQyw4KNOMbXhceoepX5Wrtef90uXmf+BCNb/+R/nMKvq8yINfFEirIJCCOaxMEGyF
	dOFDR3Y1jIdhqZyDqV8A58NWUE2IHIQRsmH1oiD3J1/aKlw/RrKyZA1QdOtJ3FXSITsnB2Fg40p
	s314fDNIstMUwBuv/pDqTMSR0IMISh2+sLp3DpxwUUgzyRAMmV+WrZJ8zGFkKMbLycZxGG5raQ=
	=
X-Received: by 2002:a05:6820:1394:b0:703:a92:a6a6 with SMTP id 006d021491bc7-713f0baffb2mr1630115eaf.19.1793205922525;
        Wed, 28 Oct 2026 09:45:22 -0700 (PDT)
Received: from xps16 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85b20216828sm2416941a34.19.2026.10.28.09.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:45:21 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 52/98] nvme-tcp: keep the socket while the queue is polled
Date: Wed, 28 Oct 2026 10:41:55 -0600
Message-ID: <20261028164415.1262013-53-axboe@kernel.dk>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261028164415.1262013-1-axboe@kernel.dk>
References: <20261028164415.1262013-1-axboe@kernel.dk>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Josef Bacik <josef@toxicpanda.com>

Quiescing keeps ->queue_rq() out, not ->poll(): bio_poll() enters even
a frozen queue. So nvme_tcp_poll() can run while error recovery or a
reset stops and frees the queues, and keeps running afterwards for the
requeued requests whose bios still carry a cookie. The NVME_TCP_Q_LIVE
check doesn't help, queue->sock->sk is read before it and
nvme_tcp_free_queue() has set queue->sock to NULL:

  BUG: KASAN: null-ptr-deref in nvme_tcp_poll+0x42/0x1c0

The poller dies holding a queue reference and the controller never
reconnects.

nvme_tcp_stop_queue() clears the bit under queue_lock. Trylock it in
nvme_tcp_poll() too and check the bit and the socket under it; whoever
holds it is either polling or stopping this queue. That means the lock
can't live with the queue, so initialize it with the controller.

Fixes: 1a9460cef571 ("nvme-tcp: support simple polling")
Cc: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/nvme/host/tcp.c | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index d735994ee517..98c55fba53c6 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1530,7 +1530,6 @@ static void nvme_tcp_free_queue(struct nvme_ctrl *nctrl, int qid)
 
 	kfree(queue->pdu);
 	mutex_destroy(&queue->send_mutex);
-	mutex_destroy(&queue->queue_lock);
 	mutex_destroy(&queue->pf_cache_lock);
 }
 
@@ -1855,7 +1854,6 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 	int ret, rcv_pdu_size;
 	struct file *sock_file;
 
-	mutex_init(&queue->queue_lock);
 	queue->ctrl = ctrl;
 	init_llist_head(&queue->req_list);
 	INIT_LIST_HEAD(&queue->send_list);
@@ -1993,7 +1991,6 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 	queue->sock = NULL;
 err_destroy_mutex:
 	mutex_destroy(&queue->send_mutex);
-	mutex_destroy(&queue->queue_lock);
 	mutex_destroy(&queue->pf_cache_lock);
 	return ret;
 }
@@ -2922,18 +2919,33 @@ static void nvme_tcp_map_queues(struct blk_mq_tag_set *set)
 static int nvme_tcp_poll(struct blk_mq_hw_ctx *hctx, struct io_comp_batch *iob)
 {
 	struct nvme_tcp_queue *queue = hctx->driver_data;
-	struct sock *sk = queue->sock->sk;
-	int ret;
+	struct sock *sk;
+	int ret = 0;
 
 	if (!test_bit(NVME_TCP_Q_LIVE, &queue->flags))
 		return 0;
 
+	/*
+	 * Nothing in the block layer keeps a poller out while the queue is
+	 * torn down.  The lock keeps the socket until we are through; if
+	 * somebody else has it, he polls, or the queue is being stopped.
+	 */
+	if (!mutex_trylock(&queue->queue_lock))
+		return 0;
+	if (!test_bit(NVME_TCP_Q_LIVE, &queue->flags))
+		goto unlock;
+
+	sk = queue->sock->sk;
 	set_bit(NVME_TCP_Q_POLLING, &queue->flags);
 	if (sk_can_busy_loop(sk) && skb_queue_empty_lockless(&sk->sk_receive_queue))
 		sk_busy_loop(sk, true);
 	ret = nvme_tcp_try_recv(queue);
 	clear_bit(NVME_TCP_Q_POLLING, &queue->flags);
-	return ret < 0 ? ret : queue->nr_cqe;
+	if (ret >= 0)
+		ret = queue->nr_cqe;
+unlock:
+	mutex_unlock(&queue->queue_lock);
+	return ret;
 }
 
 static int nvme_tcp_get_address(struct nvme_ctrl *ctrl, char *buf, int size)
@@ -3020,7 +3032,7 @@ static struct nvme_tcp_ctrl *nvme_tcp_alloc_ctrl(struct device *dev,
 		struct nvmf_ctrl_options *opts)
 {
 	struct nvme_tcp_ctrl *ctrl;
-	int ret;
+	int ret, i;
 
 	ctrl = kzalloc_obj(*ctrl);
 	if (!ctrl)
@@ -3089,6 +3101,9 @@ static struct nvme_tcp_ctrl *nvme_tcp_alloc_ctrl(struct device *dev,
 		ret = -ENOMEM;
 		goto out_free_ctrl;
 	}
+	/* A poller may try the lock of a queue that has been freed */
+	for (i = 0; i < ctrl->ctrl.queue_count; i++)
+		mutex_init(&ctrl->queues[i].queue_lock);
 
 	ctrl->net = get_net(current->nsproxy->net_ns);
 
-- 
2.56.0

