Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793205957;
	b=CyckKirZZYr1F5dr7sRs1yAvJLtF3wyRqImm01qRLpxoqbNwJ9IjlxOtHquCu68AVzQb
	 1WNb2Vzt0vC8xMECu7bsgen9qh8wV7i4S9MLxNvvWaFfE07jhVZq/JYzGCMO6/XI496wt
	 5yDoloVPV5NUJEUQKQPhNlQmbKTIuCmdN2ytQeAhVw6tE9t1nGU0xMuPfXIUQwpchgPck
	 /3pwufPWcu4xgHXAd0V8erNgegevx+yqAzgy6ip5LeQ0NM+yxvBPO1wBBU7uogL6HHoED
	 vep666emnh8+uQAqB7yD9iwts5V0d59KuzbVj5FH4Ze3rlXyYlWHoCMIZKaIGy3GFlw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793205957;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=0yyVHnQAONT+EmgcmIfmXULaneSpLwENXFzePU/qa7M=;
	b=Pttvt1rEbZ9YKThfGwLJQlXh04jz22zb1PqWpXtzcucg22urE8M2LqmbgS/YpBx12tWP
	 O/0gqBxurcaIh0GVu+C6Bj0u91nhEagUY0rgmT/eLIImxZjoF5M3P7Msx+NVmac2r/piV
	 oTss76EWO/5kFh7oowSLvsiLDt/l1uL2C8hMc2aEtuGteqg/99Hv1us5Cc5P+lSiTgP1b
	 A+pMaW23hDcpkwcNLnIA0upCkYF8tS8W61JP/FKbhqsrsnp6g8y2BfHL+om2aRG1Q//RD
	 TQIOECUGbTdqU6W6qTDjAlJrx7AKEDu+EcQ5UQ1yRf1kOXIeEe9H+60x6lAnDPO+oeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=PAiTDzpA;
	arc=none smtp.remote-ip=209.85.210.49
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9F7606A31F
	for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 16:45:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1A9F7606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=PAiTDzpA
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7f84a55e31aso754501a34.2
        for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 09:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793205956; x=1793810756; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0yyVHnQAONT+EmgcmIfmXULaneSpLwENXFzePU/qa7M=;
        b=PAiTDzpAb8e0jnHIxmNIpb28jDNaKpojO1b2NiTQcfn2z4NqgO6CC9YKpfZGsy+Tzr
         ygspvnpq/HBvJtS4uCdZxssknKQE8V2iynHFyArPMJO6kZILCrzXoJL38wexi3s7y5Bb
         x8ua6cUu3CTueltRTKZi/HCPtaZmEzU3ikw3S+aSU5nQYiHrejxTvDuKsL9uqBMG7tSW
         xMU2nmaUKF5fA7hMEF8mH0B6koSyTpKfU3s/TeKfeBJwq5fXHOL8nHriroW9EZs0yz2u
         N7lev89OwA2ZEtDKPWjqmR4neG6rPhgBlKiESz4g0NQSlvLOf3/LQEVVHAp2SDAzS2rn
         iV2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793205956; x=1793810756;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0yyVHnQAONT+EmgcmIfmXULaneSpLwENXFzePU/qa7M=;
        b=TTa0SZkvfIU9Xxy76H4Dh6AoGszV8wbzNC4WMoMgkvPepm9AkZJhfHvJqW8lUwI6zD
         YLkj72ckjcSmoJhouAWozxeZo06F2hGsWUqifmryMsHiKXdRYX6jHNe5wZyJDCNANOjP
         u3ojVGcX7XSUPcAndC8rJp2mDK8vBAyxsGPF2HERuf1X1fnqcrEW0+L+l/5mPXdMw7g5
         5eqf9KalBM9wP1tslnbdrKMYLBY18Q4sQjXs2LVUqTLFI9bw2SkcNZOFKhZNMg5mEl2H
         qWMj7B/6NNaSTidkTFbK90jh+nFZTd1WcAUyBJ3KtNRrBmOprjZIV+7v4GyDMrLvCnM7
         bX+w==
X-Gm-Message-State: AFq9FYLf5qpEt/5N8emjhdpqh9dKwdaooNHfn1fdKMiBXce+P+jznJeU
	5rpkiISEOamPOxPDrn+kWpqK+QxdSuWnEEIfrtalnAKNPuLxlJqR4OUUUV/fRr/47ISikl+MsX/
	ljksaaec=
X-Gm-Gg: AYBFou1kTkeIPm4/RNbdi4WMIsggzVMOgjHp4xny2hgFYSQV+5DbkMM1X5pmb8Nr9ak
	cWEZvTzsZmPgV6PfvkLG6VoPGVzH71JcUND6Ui8UBti9M/M7FPvlySgluQWxhOTzFTgN9hb4kfQ
	SVv5TQcXmCk72jm6PxpuPxcXIgjEfw2sVU03nJUN8VPrNtxtB+XKbCNPXBfRqNWFzrTfESvfXbl
	XGLrcAxZK1oniDtixXzl2TK5lAYtZaLoE2PnMd5KwALJeP8FBaLR2AjD9oAmfqop2+0n8byJeTv
	GPaSkHbvMKwS440k1ORnPQgON5/Arl5smdN/5zOVJ6Q6SUHl9qig45L1rq3ZAgzxziZUMGMpSgc
	kwyeDIVMD2zI9+gLI3rQt03aoWPMp9oTK3IU3jgn3GRejAwlgj/Kf0vx5nvucRGTSZzbGu0Z2ZB
	z7ODIIM0TgLikNocJlHv7sHDnAw9tuaN7P7cDCKzI+PLKZ1SD5GBKObZ5xbjqO2+6DCnvpp1zq8
	PrFNedZyc+bIXH7jC1JYjCUmXzMI8GVOkirmVbiHj80UXorAQFAfeSyPfjs5jUE3iKizgAmYK82
	qlW04pLsdh/ndyrHmERZpND8y7EZOgFJrMuQtjNW5zYKhiecLmdu/1aW5vEOrAHPX7+C1hKNqw=
	=
X-Received: by 2002:a05:6830:211a:b0:85b:895:a01b with SMTP id 46e09a7af769-85b0895b5c2mr2043041a34.31.1793205956029;
        Wed, 28 Oct 2026 09:45:56 -0700 (PDT)
Received: from xps16 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85b20216828sm2416941a34.19.2026.10.28.09.45.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:45:55 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 78/98] nvmet-tcp: don't read a removed port at Connect time
Date: Wed, 28 Oct 2026 10:42:21 -0600
Message-ID: <20261028164415.1262013-79-axboe@kernel.dk>
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

nvmet_tcp_alloc_cmd() takes the nvmet port of a command from
queue->port, and the commands of a queue are allocated from the io work
when the Connect arrives. nvmet_tcp_remove_port() shuts down the queues
that have no controller yet and frees the port without waiting for
them, they're released later from a work. An io work handling a Connect
at that moment reads the freed port for every command of the queue and
hands the result to the core.

Note the nvmet port in the queue at allocation. It outlives the
transport port.

Fixes: 872d26a391da ("nvmet-tcp: add NVMe over TCP target driver")
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/nvme/target/tcp.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index a0adcc7f0740..4cc65decb02e 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -151,6 +151,7 @@ enum nvmet_tcp_queue_state {
 struct nvmet_tcp_queue {
 	struct socket		*sock;
 	struct nvmet_tcp_port	*port;
+	struct nvmet_port	*nport;
 	struct work_struct	io_work;
 	struct nvmet_cq		nvme_cq;
 	struct nvmet_sq		nvme_sq;
@@ -1544,7 +1545,7 @@ static int nvmet_tcp_alloc_cmd(struct nvmet_tcp_queue *queue,
 	u8 hdgst = nvmet_tcp_hdgst_len(queue);
 
 	c->queue = queue;
-	c->req.port = queue->port->nport;
+	c->req.port = queue->nport;
 
 	c->cmd_pdu = page_frag_alloc(&queue->pf_cache,
 			sizeof(*c->cmd_pdu) + hdgst, GFP_KERNEL | __GFP_ZERO);
@@ -2048,6 +2049,8 @@ static void nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port,
 	kref_init(&queue->kref);
 	queue->sock = newsock;
 	queue->port = port;
+	/* The port may be gone when the commands are allocated */
+	queue->nport = port->nport;
 	queue->nr_cmds = 0;
 	spin_lock_init(&queue->state_lock);
 	if (queue->port->nport->disc_addr.tsas.tcp.sectype ==
-- 
2.56.0

