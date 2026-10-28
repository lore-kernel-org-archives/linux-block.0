Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793205977;
	b=iuCe+N6+BiewKaDUSUCnrHR0624dmUHOVL3mEJXk2sKL9arfXBXNLbeDdkc9R1uRdKTX
	 7y4hwdDrTMCaWo5yei5IgTxBMbTOuDA1ODlyP6++wirxpKXWAF/sbJlHYXP+NXwSRAFj9
	 l7PqQ6CnASzQ+EixXFpshseVOyRyScOni7jbuIdrpudpRR3xAusFSZSeiJ+KHQdZ50g+L
	 Oh5kGaPL7t20vBNlso9v/OSOw99LvVJReDjKveR9MfYpctZ9+PgEREIOJQDURE4hfjCVn
	 eTlVgNp59Thcu6qhz/lgSBLcEY4t1oSH3WKytd0VxK6asSFVEm6ic6Rw9Gco9eV15Dg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793205977;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=TfZYwUxmsrhGMp0sH9sEc1IGhPq3mV1XDwEt/z1QfrY=;
	b=KGWW4nod6I20TXyc7S3B5SociEvInOvCv0QPxs9fLK9HOH9cGcgmDmcuZ25K+B2lazmq
	 NHihKrJ2qpCCAGH+OtjJ9K4FU0WBrA66TYlAupALpiW4g+ZPayRJRyMx+tlq92R/7qPCd
	 38ClJ2sYqdcKhlyUOAjj+nuHUrHv8NDOlFTkX0Ur3zaIvQbiRUPMZsX4BTVHNhJviRvAv
	 VFUmKKACHvORgxnQur+vuvdJrw6wiRC7QrQeuV4hDqcbyhxs0oTqgbEpdpYa0LgjNDhfG
	 VafNWKG8T2fvB7it4HVmW2r9wVhrh0yJMKfEOX3Yw2GsmWVCIbb09fBbT5PN1RCEAEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=eTSK2nP3;
	arc=none smtp.remote-ip=209.85.210.49
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CE0606A338
	for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 16:46:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 89CE0606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=eTSK2nP3
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-825b40f8a26so544991a34.1
        for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 09:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793205976; x=1793810776; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TfZYwUxmsrhGMp0sH9sEc1IGhPq3mV1XDwEt/z1QfrY=;
        b=eTSK2nP3/Mdd95esvAy/rHyY3ESEVVefqjscv64VYS2zVqPc4CxFaZpT8dhqrq+d5b
         +mQ+gXBNVqX+MP4FP7fw6RBMdooAmglcwExBNV4no8Akr3M8HNANnaZc9iXW79xiolN4
         hIokj/BvFZVAd7FUTkXW+xWqjULnrBiLlF09vC0IaeoFfyaVWsVllf2sGeVoLwS/Jlwl
         mj39mk3MDfeaQ3soDceFQU2yoZzN2GFZ+gBDX8nkFGVUD+BtRMSThGqwh8MmEHm8ybfO
         pz+hnDvTI5Z2MJs+27mz4AMbH5idF+Jxmnged7bv4oyws9BJAQ1PWb9/pryA5Z+hqxXv
         jnjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793205976; x=1793810776;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TfZYwUxmsrhGMp0sH9sEc1IGhPq3mV1XDwEt/z1QfrY=;
        b=ZMjwNCaAE6CKFsJ7luOO9bscScLjt3smsLkMVJxmnpybLJkAM0B5Bye8t+o6B8aQn7
         mCQVT3r8p0aetT/fcTBRV6Ku3lRj94iOqQ7ffqEIPsshEyVe5y4VsfwcvXAjoQrnl5cL
         5KiWZpnrs2yZwzFj4bJYfRyvi1/gqJ80/Js0/nKfWdiO5ENR+P2/tBGSAYnprHESNOLP
         9O28n10MghtMFZMdJyPCt56tGzBFcFBfPsaSwbuW/llK/KcrqhtMHaKZxIf4GFAIIjtJ
         rpHK1Ca1p5CVEbQ92NYpVJiYxvVjbpVoLJSb6fkxXlGgnSKPtpsJV+WKonlkgZcLQ2EV
         hbtQ==
X-Gm-Message-State: AFq9FYI1NeorxF7NHAVAEP18PP+nBNYitqZVU5do6Y1QDtx9XWFYLUUt
	evSoYdrU81kZ0LuQenhOTmIDnl8ScPALf03MmwMi7FS/IwydHqpxrLQk3VNaIMjlE5lq1SaSJaH
	Qdw3ypik=
X-Gm-Gg: AYBFou3z1Op2CeV9jtRqotfHEQz1XLo8hTt0mvXKaKujQM+OKfK9uJ4mezmwFxYXEH+
	1mqXxZdRBzr/LEpHDEnbqfI5TXrhnRrtEc+5SCeQqgJrUaarAjdZs5/sRtmP1jG5YuQnWiXZ5Gq
	TqJpJyJVrZS4hHIDJVzbucNmkeAdM5p3AvVxZ0a5woisWseLfSRdlQ+CR0G235pFzqUJay4ppN6
	ww4wd6cylc4GG9qzh/7M7XlbY/GA9dNY9sWrj2gRWiTTcLLvylNKgND4Xy99J9kVDNQXrNTMwxH
	NgjfH7DiedJNY7fXdyuxqB0qTE0PwQqQ+MT/ZIc9qiys9t5Elyg+i0Mizafe1Qyy7uhj/BwRDgZ
	bAZFDIlSy+zdMJFY/3fu3eHhjCXDbupJimwcyYR/iVrqP95+BQV37RBbkEZO/MUxJ3ij3l6Kw+R
	IX+q6Kh6/4jaW4Cgpr30oaDXxuLGO4Aj5w4IHJcyJ34alP5qgzA8/oKYlrc1B0K+mcecHa9+Iw2
	sC6Mpw98dO8EzKEB9qfbsDv4xFDWHVmeEp7huqkje0vnwu6du8s+ZM7oO/vyJNQK2KAhz9QThlo
	LBWYHsZwObXr2bYTTnpm4lR/Zh0jubkGCm+uyJGLkx8H3Blf4Oed8UUxDA8ohY8himcNZnjEcw=
	=
X-Received: by 2002:a05:6830:230f:b0:7fa:5c68:d053 with SMTP id 46e09a7af769-85ac14a8d6emr2290603a34.29.1793205976307;
        Wed, 28 Oct 2026 09:46:16 -0700 (PDT)
Received: from xps16 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85b20216828sm2416941a34.19.2026.10.28.09.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:46:15 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: Chris Mason <mason@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 92/98] nvmet-rdma: fix a lost run of the wait list
Date: Wed, 28 Oct 2026 10:42:35 -0600
Message-ID: <20261028164415.1262013-93-axboe@kernel.dk>
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

A command is checked for free send queue slots before it's on the wait
list, in nvmet_rdma_handle_command() and when the processing loop takes
it off to retry, and nvmet_rdma_release_rsp() looks at the list without
a lock after giving slots back. The CQ worker and the CM thread (via
nvmet_rdma_queue_established()) can handle the commands of one queue
concurrently, so a release can see an empty list while the other side
is between the failed slot check and the list add:

    handle a command                  release a response
    too few free slots
                                      give the slots back
                                      wait list empty: return
    add the command to the list       /* nobody runs the list */

If that was the last response in flight the command stays on the list
forever. It holds sq->ref, so nvmet_sq_destroy() hangs at disconnect
and the queue's memory is never freed. A host hits it by sending more
Connects at once than the send queue has slots.

Look at the slots again after a command is on the list: the loop retries
after a put-back with a full barrier in between, nvmet_rdma_release_rsp()
has a matching barrier between returning the slots and looking at the
list, and nvmet_rdma_handle_command() runs the list once after adding
its command.

Fixes: 8f000cac6e7a ("nvmet-rdma: add a NVMe over Fabrics RDMA target driver")
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Chris Mason <mason@kernel.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/nvme/target/rdma.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index b8098ec53d7b..7cbf1caf3208 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -519,7 +519,7 @@ static void nvmet_rdma_process_wr_wait_list(struct nvmet_rdma_queue *queue,
 	unsigned long flags;
 
 	spin_lock_irqsave(&queue->rsp_wr_wait_lock, flags);
-	if (done->wait_released) {
+	if (done && done->wait_released) {
 		/*
 		 * The loop below has not come back from this command yet. It is
 		 * further up this stack if the command completed in place and
@@ -551,6 +551,15 @@ static void nvmet_rdma_process_wr_wait_list(struct nvmet_rdma_queue *queue,
 			WRITE_ONCE(rsp->wait_released, NULL);
 		if (!ret) {
 			list_add(&rsp->wait_list, &queue->rsp_wr_wait_list);
+			/*
+			 * A release that came while the command was off the
+			 * list can have seen an empty list, so look at the
+			 * room again.
+			 * Pairs with the barrier in nvmet_rdma_release_rsp().
+			 */
+			smp_mb();
+			if (atomic_read(&queue->sq_wr_avail) > rsp->n_rdma)
+				continue;
 			break;
 		}
 	}
@@ -698,6 +707,11 @@ static void nvmet_rdma_release_rsp(struct nvmet_rdma_rsp *rsp)
 	struct nvmet_rdma_queue *queue = rsp->queue;
 
 	atomic_add(1 + rsp->n_rdma, &queue->sq_wr_avail);
+	/*
+	 * Give the room back ahead of the look at the wait list below.
+	 * Pairs with the smp_mb() in nvmet_rdma_process_wr_wait_list().
+	 */
+	smp_mb__after_atomic();
 
 	nvmet_rdma_free_rsp_resources(rsp);
 
@@ -1021,6 +1035,8 @@ static void nvmet_rdma_handle_command(struct nvmet_rdma_queue *queue,
 		spin_lock_irqsave(&queue->rsp_wr_wait_lock, flags);
 		list_add_tail(&cmd->wait_list, &queue->rsp_wr_wait_list);
 		spin_unlock_irqrestore(&queue->rsp_wr_wait_lock, flags);
+		/* The last response may have been released in between. */
+		nvmet_rdma_process_wr_wait_list(queue, NULL);
 	}
 
 	return;
-- 
2.56.0

