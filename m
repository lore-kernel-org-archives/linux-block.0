Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793205927;
	b=PklogLnTTAatlMrbDVl16psHaXwa0UzdXN+uByV4KHCerm20v2sSeYmS63+dRTK6e5m1
	 FSrjRSZT1x38GPCd97Zw/Rez5lHyDbj7EdnTUJ/jkKh28bgKvAk1vD25dzvZXrZLJHxpb
	 9VsIUlB+aTbtrspKCcBbShsp1gbYVfwmScFn4rsB+5+RSayUPgqMUjzAeiLTP0Y9SBdPC
	 mYz7RyZH3EZxnWRU52Mz47XTPT5GSYMSaASih+4MfN+wKmaBNMccCjLWFitGpgP3rdcF8
	 zcGfUbYAgwuPydeXMQKmp+02BMMiEfKIr//p4VrtakmU4rviWlCWIWAgmVZaDQldniQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793205927;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=0kgEuQr/iNjDTurptGr3W7klYFGGTireCXR8P/qdB+A=;
	b=AV9v/BeUQU/0PVbYT9IlRmcWH+6ikzwDfwZpHHqdGnggAhZH3cc+E9AZ5rykj0pogpex
	 r7FSp6yJ7GQoCOpuy1Ec2lZ3OcEaMWOCQ8pa/xqVtpyUYNudc+4H8cUaf9p0wS1J2Hcom
	 7ST3frOYi2rOsWkDwX9aFzeygV3FHRFf1MPb7VUOYA51Qmg/5Wg8vu8kric1Rk1otAc3m
	 I7Y86VqhraJPzkgUs5BugWGaJ+oXrgnDuqaQqktqzvFrCsQrWG0vgDNkjByDqMS1dtulj
	 N6UemrfcFy9WoiDAM8mppc8CaZEYzNdYYx3Yds9sxTJhc8K/CGQKHEI9zjjS22RzBcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=jKpXfiGK;
	arc=none smtp.remote-ip=209.85.210.42
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC75606A324
	for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 16:45:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5AC75606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=jKpXfiGK
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-823b938464fso825673a34.2
        for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 09:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793205926; x=1793810726; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0kgEuQr/iNjDTurptGr3W7klYFGGTireCXR8P/qdB+A=;
        b=jKpXfiGK8Fn9nrjC34gYpV2VmPREZmeV3saNaumMeN8hTraHWuJbhnC17Aq9Wltq+0
         8F29LEOj5B9hkv+jhPSm7Nokn/SZboQhuurg30Tfo5wkgxu5cJ6xPpP5pPhgITxtubZf
         eMAF7Yk2vR7tl0fbTsC1UL33LJgDLk3PgclRkvfLyREMjN/B9CphRYcGX1xrSeEV78tT
         PGPanb4I67X+NsG+ON++hDFhrNSOGHMT1ohDB6dQDVNwAh3HOtAp9c3TP05HU5bYg0Uf
         cLZcTG21BCldCH9Zty2OxqOdydeAnPTYK/yD2rkClERaI0RPHy+2K2/joNMBRtCG8vYX
         gyIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793205926; x=1793810726;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0kgEuQr/iNjDTurptGr3W7klYFGGTireCXR8P/qdB+A=;
        b=QdHLGEUIWZIrDRC3A5y7FItk7YIu8nuRDvWyyM6+RCVGo1XIHU2faOQIVVi4tmkf2n
         HbFkytsAbzfJjIVJPN+oyQtPO6Bh1BFpABSRWQ1SAGE3IjOk6U8iUzFKiA6bth1U9dyY
         kFHtbL1wJA6PFYy8GxDtc9DiQlRHsUyuiBvt9bJoBv2F3L30SY8Qa/yUrs/+LcCne/s7
         qjw8Tf/Bf+bqyuybj3l2RLXVjGJ1FsYJ+bcKUu/AgLw8whM4yLix3m68OCL8mabSCSzO
         HVv7vR0DY+jdVN6esD8GtSUXUWCUxAuh/Qy3sfOy7BGy0URwJCxiWAvA2CQs50nvoLC1
         NdTw==
X-Gm-Message-State: AFq9FYLvsZxav8wXPHCKKg2Ji/aQXLhtP+YkM+maYvPdUEI9B1locP8s
	sPKzYsA+pwrwKt86X4GVq1TkTA7NT7eEeB1W/cjIy6Oo4fIYUJli7MSdayBjsgWKk7vcvgiky0A
	BEUsIUOA=
X-Gm-Gg: AYBFou3Yrw+F7sfftrzdK4s+zLjJE82/lVAwK60tNdGev0IG/65hFF6kuR/hIEgC0PM
	tbpSuEGAWotoVD4nKsAS+8gmXCcoVhzb72JkeVs1ABtmJcBPTNvTD0gnN63Ow8tBxmJfjLXjcmY
	JL3HwbJUDhswtUKNOJmboxNZNmaubuOtbCjKsT8Mu+t6w7PybVQDyOvTsTOUCt5RbWo801Ae/7c
	IFdtlcQwGJBpLxPsb42hw+jQOi2fnehjnf5lsNToF+HNsKJ0AmST9B9a+xcBMUJ3l8BbBSLNTWj
	zwskqgOu9CgtbgKqloTsWVbCF64Ok7YyuzBEat9ky2Bc6oNyJyext+kQ3CNRWO0wA7azOjfsXmK
	kXrNDqZFLO8GWCugLvtET0UImp9Cq6vgvpPs3D5mJnJoZ0BDKqCgibYW0z8cV4GZDhlfGFsRkjr
	U0Kkbzf9DAk2i9NfKhMpq8IDPZiJq4e/+Gu/gUG+IJXD5Jh+YnGUHwNJHh4IJE79AJw8NA3IsUd
	QfOC5Qo4mXzxNt9Gc15i02+py4UM5xVSUGTjKoZcKxLVmcroCauNXHU0c8XjXr9WndF8ady3eTg
	PiFGNowhBtA4pT7A74TlzpDSY9DPF2nJyz+LQ9E20nphBLy4if2oBZeETp/ESwF8YfK3KsLXdg=
	=
X-Received: by 2002:a05:6830:3490:b0:822:ce5a:4ab with SMTP id 46e09a7af769-85ab9d504femr2870603a34.26.1793205926292;
        Wed, 28 Oct 2026 09:45:26 -0700 (PDT)
Received: from xps16 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85b20216828sm2416941a34.19.2026.10.28.09.45.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:45:25 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 55/98] nvme-tcp: don't act on PDUs for a command being sent
Date: Wed, 28 Oct 2026 10:41:58 -0600
Message-ID: <20261028164415.1262013-56-axboe@kernel.dk>
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

A request belongs to the send path from the moment it's put on req_list
until its last byte is handed to the socket, but the receive path acts
on whatever the controller sends for it. A response completes the
request while the send side is still reading from its bio:

  BUG: KASAN: slab-use-after-free in nvme_tcp_try_send_data+0x175/0x6b0
   nvme_tcp_try_send+0x4af/0x600
   nvme_tcp_io_work+0x249/0x380

and an R2T resets and requeues it, since the queued check only looks at
the two lists and a request being sent is on neither, so it ends up
completed twice. An honest controller doesn't do that, but its answer
can legitimately overtake a sender that has handed over the last byte
and not yet cleared queue->request.

Make such a PDU wait: don't consume the bytes that complete its header,
so it's seen again by the next receive. For that nvme_tcp_req_busy()
has to find the request in one of the three places at all times, so
nvme_tcp_fetch_request() sets queue->request before taking it off the
lists. io_work reruns when the sender was io_work or the socket was
full, waits for send_mutex when the submitter was sending, and a poller
just polls again.

Fixes: 3f2304f8c6d6 ("nvme-tcp: add NVMe over TCP host driver")
Cc: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/nvme/host/tcp.c | 87 ++++++++++++++++++++++++++++++++++-------
 1 file changed, 73 insertions(+), 14 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 64f563686938..06c205703cf5 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -123,6 +123,7 @@ struct nvme_tcp_queue {
 	size_t			data_remaining;
 	size_t			ddgst_remaining;
 	unsigned int		nr_cqe;
+	bool			rcv_parked;
 
 	/* send state */
 	struct nvme_tcp_request *request;
@@ -465,11 +466,29 @@ nvme_tcp_fetch_request(struct nvme_tcp_queue *queue)
 			return NULL;
 	}
 
+	WRITE_ONCE(queue->request, req);
+	/* nvme_tcp_req_busy() must find the request in one place at any time */
+	smp_wmb();
 	list_del_init(&req->entry);
 	init_llist_node(&req->lentry);
 	return req;
 }
 
+/*
+ * Does the send path still hold @req? As long as it does the request must
+ * neither be completed nor be queued once more, whatever the controller says.
+ */
+static bool nvme_tcp_req_busy(struct nvme_tcp_queue *queue,
+			      struct nvme_tcp_request *req)
+{
+	if (llist_on_list(&req->lentry) || !list_empty(&req->entry))
+		return true;
+	/* pairs with the barrier in nvme_tcp_fetch_request() */
+	smp_rmb();
+	/* pairs with the release in nvme_tcp_done_send_req() */
+	return smp_load_acquire(&queue->request) == req;
+}
+
 #define NVME_TCP_CRC_SEED (~0)
 
 static inline void nvme_tcp_ddgst_update(u32 *crcp,
@@ -672,6 +691,9 @@ static int nvme_tcp_process_nvme_cqe(struct nvme_tcp_queue *queue,
 	}
 
 	req = blk_mq_rq_to_pdu(rq);
+	if (unlikely(nvme_tcp_req_busy(queue, req)))
+		return -EBUSY;
+
 	if (req->status == cpu_to_le16(NVME_SC_SUCCESS))
 		req->status = cqe->status;
 
@@ -707,6 +729,9 @@ static int nvme_tcp_handle_c2h_data(struct nvme_tcp_queue *queue,
 	}
 
 	req = blk_mq_rq_to_pdu(rq);
+	if (unlikely(nvme_tcp_req_busy(queue, req)))
+		return -EBUSY;
+
 	if (!blk_rq_payload_bytes(rq) || !req->curr_bio || !req->data_len) {
 		dev_err(queue->ctrl->ctrl.device,
 			"queue %d tag %#x unexpected data\n",
@@ -800,6 +825,8 @@ static int nvme_tcp_handle_r2t(struct nvme_tcp_queue *queue,
 		return -ENOENT;
 	}
 	req = blk_mq_rq_to_pdu(rq);
+	if (unlikely(nvme_tcp_req_busy(queue, req)))
+		return -EBUSY;
 
 	if (unlikely(rq_data_dir(rq) != WRITE)) {
 		dev_err(queue->ctrl->ctrl.device,
@@ -829,14 +856,6 @@ static int nvme_tcp_handle_r2t(struct nvme_tcp_queue *queue,
 		return -EPROTO;
 	}
 
-	if (llist_on_list(&req->lentry) ||
-	    !list_empty(&req->entry)) {
-		dev_err(queue->ctrl->ctrl.device,
-			"req %d unexpected r2t while processing request\n",
-			rq->tag);
-		return -EPROTO;
-	}
-
 	req->pdu_len = 0;
 	req->h2cdata_left = r2t_length;
 	req->h2cdata_offset = r2t_offset;
@@ -939,17 +958,32 @@ static int nvme_tcp_recv_pdu(struct nvme_tcp_queue *queue, struct sk_buff *skb,
 
 	switch (hdr->type) {
 	case nvme_tcp_c2h_data:
-		return nvme_tcp_handle_c2h_data(queue, (void *)queue->pdu);
+		ret = nvme_tcp_handle_c2h_data(queue, (void *)queue->pdu);
+		break;
 	case nvme_tcp_rsp:
-		nvme_tcp_init_recv_ctx(queue);
-		return nvme_tcp_handle_comp(queue, (void *)queue->pdu);
+		ret = nvme_tcp_handle_comp(queue, (void *)queue->pdu);
+		break;
 	case nvme_tcp_r2t:
-		nvme_tcp_init_recv_ctx(queue);
-		return nvme_tcp_handle_r2t(queue, (void *)queue->pdu);
+		ret = nvme_tcp_handle_r2t(queue, (void *)queue->pdu);
+		break;
 	default:
 		goto unsupported_pdu;
 	}
 
+	if (unlikely(ret == -EBUSY)) {
+		/*
+		 * The command is still being sent. Leave the end of the header
+		 * in the socket and look at it again when that is done.
+		 */
+		queue->pdu_remaining += rcv_len;
+		queue->pdu_offset -= rcv_len;
+		*offset -= rcv_len;
+		*len += rcv_len;
+	} else if (hdr->type != nvme_tcp_c2h_data) {
+		nvme_tcp_init_recv_ctx(queue);
+	}
+	return ret;
+
 unsupported_pdu:
 	dev_err(queue->ctrl->ctrl.device,
 		"unsupported pdu type (%d)\n", hdr->type);
@@ -1110,6 +1144,10 @@ static int nvme_tcp_recv_skb(read_descriptor_t *desc, struct sk_buff *skb,
 		default:
 			result = -EFAULT;
 		}
+		if (unlikely(result == -EBUSY)) {
+			queue->rcv_parked = true;
+			return consumed - len;
+		}
 		if (result) {
 			dev_err(queue->ctrl->ctrl.device,
 				"receive failed:  %d\n", result);
@@ -1182,7 +1220,8 @@ static void nvme_tcp_state_change(struct sock *sk)
 
 static inline void nvme_tcp_done_send_req(struct nvme_tcp_queue *queue)
 {
-	queue->request = NULL;
+	/* pairs with nvme_tcp_req_busy() */
+	smp_store_release(&queue->request, NULL);
 }
 
 static void nvme_tcp_fail_request(struct nvme_tcp_request *req)
@@ -1430,6 +1469,7 @@ static int nvme_tcp_read_sock(struct nvme_tcp_queue *queue)
 	rd_desc.count = 1;
 	lock_sock(sk);
 	queue->nr_cqe = 0;
+	queue->rcv_parked = false;
 	consumed = sock->ops->read_sock(sk, &rd_desc, nvme_tcp_recv_skb);
 	release_sock(sk);
 	return consumed;
@@ -1527,6 +1567,22 @@ static int nvme_tcp_try_recv(struct nvme_tcp_queue *queue)
 	return consumed == -EAGAIN ? 0 : consumed;
 }
 
+/*
+ * A PDU has been left in the socket because its command is still being sent.
+ * A sender in another context does not wake us when it is done: wait for it.
+ * If there is something left to send then, either the socket is full and tells
+ * us when it has room, or io_work has been queued.
+ */
+static bool nvme_tcp_recv_again(struct nvme_tcp_queue *queue)
+{
+	bool again;
+
+	mutex_lock(&queue->send_mutex);
+	again = !queue->request && !nvme_tcp_queue_has_pending(queue);
+	mutex_unlock(&queue->send_mutex);
+	return again;
+}
+
 static void nvme_tcp_io_work(struct work_struct *w)
 {
 	struct nvme_tcp_queue *queue =
@@ -1552,6 +1608,9 @@ static void nvme_tcp_io_work(struct work_struct *w)
 		else if (unlikely(result < 0))
 			return;
 
+		if (unlikely(queue->rcv_parked) && nvme_tcp_recv_again(queue))
+			pending = true;
+
 		/* did we get some space after spending time in recv? */
 		if (nvme_tcp_queue_has_pending(queue) &&
 		    sk_stream_is_writeable(queue->sock->sk))
-- 
2.56.0

