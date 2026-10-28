Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793205973;
	b=BN6lkO1Hr/lCw80LnfkzoUyYor3Hx5C12RiVmXgteZhp/7CTbTxCxuSr4cIjrm4chI+V
	 u50l7xjLOYmUAknRSWV62bEJrmVFqY/1vHYzepvOPJMFClUqXdc4/t1CqwxnxujOSQmUt
	 Bn2Hs6i208D4g4+bkD99lkbDA+I8A15LRlLlgkhq9AzeRx59x6a0CWv+a/Js5VWEVBkwR
	 9HVghbqTIVpeVr+9j4m35GEEu+8Qo2tRIvrElBy1qruRUEAQ20/nX2QIWyqTDSFkpc30C
	 5YUOt4BPVGho/yg4ASnTmQY18GjYiZrW7jWM6CG9Y2o7lAKxMHCRtoSSzSN7yuUB4bw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793205973;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=KWOc7K7KL6lErEb/pWIQGuayxXTGZEdeP+xLi0GLtO8=;
	b=IBJ2ZzYbnJDZtQxIS7dwYpJ88qz+gjQ9rWzELRkHnOazWyeXpVr3Y8hz3TfhOAt0JLLU
	 sIQakVoRDSVNGaoKKLZNrKx3SqH7jSgGtx+sW1MfMADBGRmcYvfyagiFlS/RV8KtAIaAZ
	 a3Tgw0enjWvR2A/tgHwnUzr2XYBWnxNwH+FjxHOpiq8ObRIHLLcJUCzJioK7ZLSpvguUo
	 FYxhqYpHGKuHAjrGtKvkh9ZIlK5yUN/V32RYEpWzWpy72pWQjnsPzF+Vq+I6TOJW9H+S4
	 AJC7zrho08CV39zdBweNqBv0ZWP8l/aoH17RNnmih1uy7HatlaX6275cGu7tTUnSaVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=puPwaygd;
	arc=none smtp.remote-ip=209.85.210.45
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA5E606A325
	for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 16:46:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7CA5E606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=puPwaygd
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-84e513877a3so1113046a34.0
        for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 09:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793205972; x=1793810772; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KWOc7K7KL6lErEb/pWIQGuayxXTGZEdeP+xLi0GLtO8=;
        b=puPwaygdhRny6mLrFnQxSXWKfVVyqWn1BllA9lwze7tNwqPnmEOmO5g5kKgjQQdw5y
         7EZvMKoCKlyS1+FNj0QfsIt+5Sn02iYD+TbmTqaSaCrU1kBdT1486e5MhYs2LNQdRbee
         UCeg0YNE1Lx6lVlV2F0vnwgcjEOfuHOLEgxyDXULaz+KWGzFfcco45owVJ6FyaKQ/c+w
         ILF0o0EW+B7S0ma4+yiCp9POzFa0FnmkzwbfBnlhJQQd6jFONO0AyVDUNkigHuppWH4P
         J53J2BfTV9g57h4HdWjvQBTUSIo3Xxbh9a5HJt31HuiOBKS5jlqQV0YfPvn9culadjh7
         jb6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793205972; x=1793810772;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KWOc7K7KL6lErEb/pWIQGuayxXTGZEdeP+xLi0GLtO8=;
        b=ae4cIa8h3bwTNFBl9UEhQI7ByUbeBT0cdtFnjh/0q1rKn46d0+VoxsvKtVnx/rzd3J
         ormTQnRS/zeKSwgJze+0Hk4hFjBhSr/gzKNKq/bqfbRQq/mS9I9sECdfa2S6104X4040
         lISw7pakpgqbwVqaXjllFg996OzjvLL/1TOk6pOSeZBQKBuemijGJ/ujw+N6gw/fEdyA
         b2p3YqAXvHdbuPpd406le4UoOrMMgppy0C9MPeq7C47m0i8WiGVv7PnQaa/tbyo+/I4i
         tLvWWQo/qxS9iPxIT9xVrL5tCc09DoeMjR/0TuA56ZyiW4OBnPTb7LrdVRms2NdcYois
         mg1g==
X-Gm-Message-State: AFq9FYKtK3g5etVuB9dIVFcQXvPSXCm/J9CLFMGY4DqxaeL59tSbzoet
	0tRhzn1rDrsZny2+zQ7/ngyC2W1N5dCGh8ZYMO7VeNOTnunFt/C+ObYbkU5B/y9t/Yq+JrVTDx4
	ihAO3fGI=
X-Gm-Gg: AYBFou0uhYQOFsS+G9Rn7R3jWWFhZIWj70cTIh7Qn1U1sHWX1S6yueVdgDZnuaR8nRe
	lgkF0Ggm/K6FaRT6KLrh0GlsO0HSclcssoucYxDHxaLPVreampeP1qXZKfEMYTKwatutYF7ydPa
	a1JDtLpbY5lXGrh7Hvp1f0qHZrl836wo44pkZWMbc5QU7KYHXrPisillj+Cc9J1wcaP+sqHKLrq
	R4/WLn/2FlTWSoEWfiWkT3NfMCmDOfBNRDEaZzCfXXKfc2ZLx3BHRbZOsakMfSj/1xUpSLjWjBm
	pIASF+KFTYuSU3TQW8AGwrnAj5cFoACO63nD82qsR1xuoLkQg7ODTFoJJ3rColPa5/EKddFh/Fz
	cMxc8EM99kbaW83h9uYN5gOHB2Yetxr66WigIw84D4nlR3Y2er7C6YRc6B9piQFOPMceEp8fPcE
	Z7tXhfgH8/6h4/5+Bb55kq7jrGYmMh9ywBAIkUxLByn4CLGE1FamH7ItP0MJv3+LgeglT21+zVk
	nyLAGLbbk/HP3zTtCsTlP1x2BuaWLqDEWR5gP9CUHBTnlYOhv1JXNnBXtQnmElv3OZ17ahTOGMW
	wWBiKjTFjQ2obVrFax792vPEjUQdbCPscJADoR483M1O0RzzeZGpMQ/7KWs7b4qvWKfaEsEN0hk
	3UD0U2xztTLdin8Tmg1k=
X-Received: by 2002:a05:6830:6758:b0:81d:9acd:ee04 with SMTP id 46e09a7af769-85c1aba578cmr108205a34.0.1793205972363;
        Wed, 28 Oct 2026 09:46:12 -0700 (PDT)
Received: from xps16 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85b20216828sm2416941a34.19.2026.10.28.09.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:46:11 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: Chris Mason <mason@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 90/98] nvmet-rdma: disable interrupts under rsp_wr_wait_lock
Date: Wed, 28 Oct 2026 10:42:33 -0600
Message-ID: <20261028164415.1262013-91-axboe@kernel.dk>
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

From: Chris Mason <mason@kernel.org>

rsp_wr_wait_lock protects the list of commands waiting for room in the
send queue, and it's taken with plain spin_lock(). But
nvmet_rdma_queue_response() calls nvmet_rdma_release_rsp() directly if
ib_post_send() fails, and that processes the wait list. The call chain
starts in nvmet_req_complete(), which for a block device namespace runs
from the bio end_io callback, which can be in hard interrupt context.
An interrupt that completes a command on a CPU holding the lock for the
same queue spins forever. Lockdep over siw with a null_blk namespace:

  inconsistent {HARDIRQ-ON-W} -> {IN-HARDIRQ-W} usage

Use spin_lock_irqsave() for both takers. The processing loop still
drops the lock, and restores the caller's interrupt state, around
nvmet_rdma_execute_command().

Fixes: 8f000cac6e7a ("nvmet-rdma: add a NVMe over Fabrics RDMA target driver")
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Chris Mason <mason@kernel.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/nvme/target/rdma.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 26ea4e1d62b3..7c97a47e305a 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -513,7 +513,9 @@ static int nvmet_rdma_post_recv(struct nvmet_rdma_device *ndev,
 
 static void nvmet_rdma_process_wr_wait_list(struct nvmet_rdma_queue *queue)
 {
-	spin_lock(&queue->rsp_wr_wait_lock);
+	unsigned long flags;
+
+	spin_lock_irqsave(&queue->rsp_wr_wait_lock, flags);
 	while (!list_empty(&queue->rsp_wr_wait_list)) {
 		struct nvmet_rdma_rsp *rsp;
 		bool ret;
@@ -522,16 +524,16 @@ static void nvmet_rdma_process_wr_wait_list(struct nvmet_rdma_queue *queue)
 				struct nvmet_rdma_rsp, wait_list);
 		list_del(&rsp->wait_list);
 
-		spin_unlock(&queue->rsp_wr_wait_lock);
+		spin_unlock_irqrestore(&queue->rsp_wr_wait_lock, flags);
 		ret = nvmet_rdma_execute_command(rsp);
-		spin_lock(&queue->rsp_wr_wait_lock);
+		spin_lock_irqsave(&queue->rsp_wr_wait_lock, flags);
 
 		if (!ret) {
 			list_add(&rsp->wait_list, &queue->rsp_wr_wait_list);
 			break;
 		}
 	}
-	spin_unlock(&queue->rsp_wr_wait_lock);
+	spin_unlock_irqrestore(&queue->rsp_wr_wait_lock, flags);
 }
 
 static u16 nvmet_rdma_check_pi_status(struct ib_mr *sig_mr)
@@ -976,6 +978,7 @@ static bool nvmet_rdma_execute_command(struct nvmet_rdma_rsp *rsp)
 static void nvmet_rdma_handle_command(struct nvmet_rdma_queue *queue,
 		struct nvmet_rdma_rsp *cmd)
 {
+	unsigned long flags;
 	u16 status;
 
 	ib_dma_sync_single_for_cpu(queue->dev->device,
@@ -993,9 +996,9 @@ static void nvmet_rdma_handle_command(struct nvmet_rdma_queue *queue,
 		goto out_err;
 
 	if (unlikely(!nvmet_rdma_execute_command(cmd))) {
-		spin_lock(&queue->rsp_wr_wait_lock);
+		spin_lock_irqsave(&queue->rsp_wr_wait_lock, flags);
 		list_add_tail(&cmd->wait_list, &queue->rsp_wr_wait_list);
-		spin_unlock(&queue->rsp_wr_wait_lock);
+		spin_unlock_irqrestore(&queue->rsp_wr_wait_lock, flags);
 	}
 
 	return;
-- 
2.56.0

