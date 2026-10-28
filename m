Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793205963;
	b=m7XDPIxmiBOxUPuqi1+heQFlS8GgToTxZMx6d7GuhpfSJAocKzZJVf6sQjGosPICy0cV
	 wNaZLgrLYmwmxF9Z8BNrQzawptMOXfpLrPlnRS3x7V4BY9ushqpYwUU5+3xGfMYwXleMl
	 Q7cnvL1K0aeh0MIUZHNGKkr5yLjLkdbSwlRsEI/Wm5trubPuh5czrD1wDKU+J3ntYH1+j
	 DXB3AHtxn/9w6PLzZ5eeCPr9oCeyMm+99aYgkCfmTGu6hwRjjw5YRnaYdkl9L1PCfjqN6
	 nLJLclS8mKEz19ttx4l4fzqvopJnf8qBCGJEbC3MvHl6G7HNt6V8CSp5a672NfOwxQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793205963;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=1NNaeja9CPQdNWDiA6GhYzCVGaHovmQ4cPZ+vjHlOj0=;
	b=ovFfWnvD1BEZfhDrfHK+4FmABlkrUxtDdZ9dUXIVesY78KGr2DgYhgp8HOT6qFFzFucs
	 PTsM4abkKu+GAi1dYS/vHPKESntYl2VBohbieqUbjheA9YIo46NapKeDD31NapOH3Byxi
	 kePexLWc2c6A+UmsnYZ7lLEF6iphpzSOKKJ9JkbU8l/OfTWzYanbT9Bwh3sooPIwc9Cqs
	 gAvA3WyVyXFfIL0yqtk0rbo/UA7d/y4UX/ETq8Tt6Sb/rWJuxMGBboZoj6ClZGJAVszlq
	 kfbUA40IrAV6ej8YU5CRxyVF1yXaTlTozs/bKVkh3ld5zeuntrqQkq+rn0DCs9hKiZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=mE3ZShLZ;
	arc=none smtp.remote-ip=209.85.210.45
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758DB606A31C
	for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 16:46:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 758DB606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=mE3ZShLZ
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-84e513877a3so1112827a34.0
        for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 09:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793205962; x=1793810762; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1NNaeja9CPQdNWDiA6GhYzCVGaHovmQ4cPZ+vjHlOj0=;
        b=mE3ZShLZUnRmv/oWQ1heoUxcUdeg9cIXjqTB3IPCGYT5NW74wZ1sDhLFZ3/flNeSX+
         2F9w3e5Tr/G7VPLCIOFUHKvz4eV2TBESXvmIZWog2Lu+oaSA7GFTc8Jz/m7A7QEl0ULi
         AZVvw6488OOtXRtrxn6D8coxYAspQ4MIoxzEtKwamzFCoXpisf8gFxVqRca3nvspKCXF
         rRz6f9RUfDU3OjhxlddlDsgGwgHum/4r8irhKMAwtLmNR5rXtGTRGZozNDd2vUKTyOLE
         BF0hAA3fOWRoPG8r0m2RUtVdCS0G6rWRjqHUxp2OqV66Soo3NV5J2uuFLX0Pmr1BOYXH
         m57g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793205962; x=1793810762;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1NNaeja9CPQdNWDiA6GhYzCVGaHovmQ4cPZ+vjHlOj0=;
        b=UcNkaIQEfnSsEoJf0lIXeDcTV/Jm1X8WvPbNphZx7maSbMwlx4jIGkVm5PywnY4z+a
         9WI4dJrsIDltUTNPZbV1jaCUdcEMRVsTKPPM89aKtd/HOOhgwTIWdEr/P4FhfQUNpnUh
         yPyOOgpH7JtnX3cafFbHowlymy0CK5O2V+pmEtCywD9jl53hHWwdXhvurB1fMvTF9ff9
         8iX1H9ZV09O04dL3HmZyk56arfSYPkzH5rLtsOpFshtNCF7Gjs+5BASZxFhHJm/oFdeS
         Fqop1XyLMz1wqLBJtC6jzfVRmNfvu9Mm9wXxmTMDgKf0AEyEkFS6MpkFW9TkP+Ugwo5r
         wx5g==
X-Gm-Message-State: AFq9FYJkK4RtmbkhrrOAVLv1hDppYhv89Kmp5hjPAozkEGF4pCW+H1Tj
	L9lNtap5N//KelxbQSrreHtOVkvgN7Nl8pETQezKf4NiDW6qM9cI1ONUxG7so9MrHo/V6Qy8JTc
	145iMP6Q=
X-Gm-Gg: AYBFou2X6xWziAvp1dk0HnFBC2Itt+ege6VXywgYJ1Zbmm6moeLWzjWzb9/Bj6ENQHg
	6hJiHIHV3irARDtKJXa0PLOdFrJw70u+HH9xG7JtrmmhqLKjj8jugmn0tezUyE79X4dC9hGdFaD
	ALA0H3JhNHcXMOOdGcqVHLMN0v0Bii/DrQBQnJaGPlugI/qTYJ+BKavacc5R5vQ9beJp36DsGjr
	/fQe/xuIVpnj4IaB7IdSsModMWF6rDvp0r0bcfnBGcp59+0I5ZhrgdNTlr6HEFFVLdduluzOwGX
	LZ7UO9ztptPZJR1XfOHnQBE4jhmNj0baP+58hbTEiyNEZlDksiPSE+8WuOHIwcKtGDm5VhiBf85
	R+9DrIiOiCaIqcST6F7o3HdsHe5UqQZj4/m7hJHVs2mnFqlt/iFc2iJzAxgrpuXk+/v0XIde8RF
	bgmF0FSb7sFoawJ4b3wrfzvK/Qeop+BR0nJ7FzVMk409oe7BkBdDM9+Bhnl83poY1LmDGpNBeOC
	OKmbrl5CP+4hLsCiNrkeDnH6/ZaQkAf3sSBrz00/fhIZopbldCBPAIFn18c0fJh+c3xClMESdNv
	0y1JGYuDIKvxNYcgYLfCuaeZZxpdgGXZwKPWUPIREGtWHp/jsOr8D42kQglpOh3zCLT+LtbMHvX
	CKMUIWn1EoEt5T29lAIM=
X-Received: by 2002:a05:6830:920:b0:81e:a314:7f70 with SMTP id 46e09a7af769-85c1e2b73f8mr91662a34.1.1793205962426;
        Wed, 28 Oct 2026 09:46:02 -0700 (PDT)
Received: from xps16 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85b20216828sm2416941a34.19.2026.10.28.09.46.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:46:01 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: Chris Mason <mason@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 83/98] nvmet-rdma: treat a failed connect as a disconnect
Date: Wed, 28 Oct 2026 10:42:26 -0600
Message-ID: <20261028164415.1262013-84-axboe@kernel.dk>
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

Once a connect request has been accepted, a queue is only freed by its
release_work, so that must be queued once. The disconnect paths take
the queue off nvmet_rdma_queue_list first and queue the work only if it
was still on it. nvmet_rdma_queue_connect_fail(), for REJECTED,
UNREACHABLE and CONNECT_ERROR, queues it unconditionally and only warns
if the queue isn't connecting. But the IB CM delivers a REJ from the
peer while the connection is established and even after we've sent a
DREQ, so a peer that causes a disconnect with a short capsule and then
sends a REJ while the release work is running queues it a second time
and the work runs on a freed queue. No credentials needed, just RoCE or
IB reachability, reproduced over rxe with a UDP socket.

Route connect failures through nvmet_rdma_queue_disconnect(), so only
the path that takes the queue off the list queues the work. A REJ on an
established connection still frees the queue, the RDMA CM reports no
disconnect after one.

Fixes: 8f000cac6e7a ("nvmet-rdma: add a NVMe over Fabrics RDMA target driver")
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Chris Mason <mason@kernel.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/nvme/target/rdma.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index c4b848f84465..13243e3edca5 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -1738,15 +1738,14 @@ static void nvmet_rdma_queue_disconnect(struct nvmet_rdma_queue *queue)
 static void nvmet_rdma_queue_connect_fail(struct rdma_cm_id *cm_id,
 		struct nvmet_rdma_queue *queue)
 {
-	WARN_ON_ONCE(queue->state != NVMET_RDMA_Q_CONNECTING);
-
-	mutex_lock(&nvmet_rdma_queue_mutex);
-	if (!list_empty(&queue->queue_list))
-		list_del_init(&queue->queue_list);
-	mutex_unlock(&nvmet_rdma_queue_mutex);
-
 	pr_err("failed to connect queue %d\n", queue->idx);
-	queue_work(nvmet_wq, &queue->release_work);
+
+	/*
+	 * The peer decides when these events arrive: a REJ is also delivered
+	 * for a connection that is established, or that we are disconnecting.
+	 * Whoever takes the queue off the list queues release_work, once.
+	 */
+	nvmet_rdma_queue_disconnect(queue);
 }
 
 /**
-- 
2.56.0

