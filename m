Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793205969;
	b=qvEv8YccrcXQeBm0LdBpd6Uv3aKQoF2dQUxemm8v8sgOwRZLcrigNVOs/vaxjQqw3vdh
	 I6ygaGArD3soRQzHwGLdApjwJ3YeiFilrmsip4gcL5ilWwp3XaQpHPW4bjA2x/eLq6vFP
	 MgyfbdHLhntmMDKHif9wnKGATLX06Kjg81CgURa2RRCQrO5khi0PWrkqkbQwskovRD47V
	 Yl7JQrH1oUEnl7wqdm5IXHsfJlMX+U/6oiSVQmFzOtJtGEWmXllleUkZBhbGjsCy2141R
	 aiwmQQ5ZZQo3cWlxIwslqEWViv+6IvfZWAB4abwta/DHTZI3U+5wQ9BD7oqKtqr8YgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793205969;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=lmDH8RAqI1aGhFpWhmraSt7cUZbH2Nj3UM+47vjzRtU=;
	b=GJzLSRntwVWh3EAhZeVgw9t0IMtBbt75YY/lFi1nPa3v+82beDZsJGA8viAr0Zp8j5MI
	 xjUSm2VESCeVNsbT69G5pQDEb0U7bhpHzpaqFIN+Va3NukKBKsfwVI5t1MuYhzMZH0byV
	 v92xzCTGgQ5HLimlIcK6qW8/9whpQfOVzyouNqNba6VpDU+aLJV9tuNN6BhcMzGdPukSn
	 Oggm0pa7U4JXCax2CL6kFY96elyoaxmhfE93yRArNqVMMCKbzX0xNS+Z4NWMDP7p/3C0j
	 G04Gank8STMSzSXJGTnDT8HNv7mfGBRds2lJOoF+FjStdKKqoiHPvjaWjbHpmRr/8PA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=E4xIp+Va;
	arc=none smtp.remote-ip=209.85.161.49
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E80606A33C
	for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 16:46:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D7E80606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=E4xIp+Va
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-6df5e315bd1so912298eaf.2
        for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 09:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793205968; x=1793810768; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lmDH8RAqI1aGhFpWhmraSt7cUZbH2Nj3UM+47vjzRtU=;
        b=E4xIp+VaU7LRIc/RXHt7T+GUj/M3a4V57YXBMzFd9TkxIVy0oBhcImVSWdTX08539p
         XGd5xtOue9fMHE1t9QkCghoMSpxSOAEdjDCutJCK2Sb6aS9TbyRgYT6T5VdOx+6GDAlK
         ZeKXratzgNhu/LONs8WJL5VhWjR8o+Ta+CVBdVY5QC2AZRDD8IjO/Tz84C56erPCw4hz
         COrrBvNsapcZ+dq5PZ6LWDoSSRs/nk+5hkkujM+Z1nJkhVa7/yAau0VScmV8Zaehsov/
         afpRoRaNj2geN46aE7gXj8QozApmnQo72C6oz0vLtJgbKRMoeQIPujsak3KmdH3td8Xg
         t1Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793205968; x=1793810768;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lmDH8RAqI1aGhFpWhmraSt7cUZbH2Nj3UM+47vjzRtU=;
        b=vT9k80bSY1Q1d39kHA+r7fIX4kLJFq+h2kvYAJ2CkazDWqtuZpK227UcojdTPJAkkU
         BQQC8yBxFsFNckvlZksGStqgtQILmglHf+LjQy5Za+2MQmka6IkKxh4YnfQRFDWcPEzS
         FlLmXXPDJQoEDqnIWVrlH4VjvXu/3Ld8K3iJtSP0Xid8R/WPGij0co1d1OkIuSMDo5jA
         zLKVuBO7xG7s1DaZVJLYingIghClvbyttauTYsceQW39ocflKjo2peITC5TLpsuQDH3F
         seBrZnUI2vBrQFDSKUV70fKiInk4tcQ9IU2AUPgKsXg0QX8C7Q/rZ2y+eU8bGAN91Prl
         ePYw==
X-Gm-Message-State: AFq9FYK7thw6RILAeq860E8igqqwfASC9LfqhfjFrYdbmQTCEGQ9tx3h
	f+W/jhDnMRpP+b0LDT1lcIBk/v6p+mzMH3yMxmeE9o/sdM3k2MywP8DvF7j4He5imuHJO85HpLi
	UPblMFg8=
X-Gm-Gg: AYBFou3DSI48eVeWBB+1DGRwqW8PVhP5C9vyKRu8fjlXxhgEG+GWzPidho9/SX/OuGP
	ZlpzXJEn5dUDget+0R/x0lOr9pdlqA6dBxoRQZ+BXRe9AXCnnRSQtevzJ9+IVykBRF5jC/54rMe
	M8nBs30w/AmEvhjHHX00TVcopXYzToAkZYBS4M1X75dwsjr79FTS2CQsAsG1ZR/PeCS2anSUzNI
	mr2mLYvXXzGljZCunDY+2JZB9Ts7Cj5+siNwU/2dTV8ksk3kjD5ywLFL/0mFuUfPUM4Ay8M/MMM
	MhAiGoiK5R/DphDAUS52JDy+kyZ8Rf7BBSB5sNhQFpppVIwbvnAgoOpL5CJA7OzT4fHSQT8ktG/
	6mRhil/TWaQs3rV1BB19YXn97BVeXrAu5vcJpCaIwAwjBvwxOuFNd33BSn9iuCApz5pCVcpE8Os
	Cv5PHp0yoB2F4CXYTXzUhB/MNWI39bPGmxo7KAFwFjKkPzyriNfSTnrtW5AT2fuFvgfu/ht3KRr
	S+oHcUUBjg2aC2wsyR+XUS9SDrIcFTFdZd+TIZZ2I00qNTQ+pfFGM7x7UNBleZo5t3H5mlXPrgI
	wsx+JWnJuGFG+h7u56DQb95AifQ//fTQr1da25SEHcotvMO3rOFN+L0kgtlI/8wHlWnO99DCwA=
	=
X-Received: by 2002:a05:6820:4a13:b0:6cd:3fdb:fa66 with SMTP id 006d021491bc7-713f21710ffmr1396893eaf.81.1793205967735;
        Wed, 28 Oct 2026 09:46:07 -0700 (PDT)
Received: from xps16 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85b20216828sm2416941a34.19.2026.10.28.09.46.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:46:07 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: Chris Mason <mason@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 87/98] nvmet-rdma: disconnect a queue on device removal
Date: Wed, 28 Oct 2026 10:42:30 -0600
Message-ID: <20261028164415.1262013-88-axboe@kernel.dk>
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

cma_remove_one() sends DEVICE_REMOVAL to the owner of every cm_id on
the device and then waits, without timeout, until they're all
destroyed. nvmet_rdma_device_removal() does nothing for a queue cm_id
and leaves the queues to nvmet_rdma_remove_one(), which only works if
that runs first. As a module it does, nvmet-rdma registers after
rdma_cm. Built in, both register at the same initcall level and
drivers/Makefile lists nvme/ ahead of infiniband/, so cma_remove_one()
runs first and waits for cm_ids that only the later callback would
destroy. Since the RDMA CM drops all later events for a cm_id once it
has sent DEVICE_REMOVAL, a peer closing its connection doesn't help
either. One connection from anyone who can reach the port hangs "rdma
link delete" until something else ends the queue.

Call nvmet_rdma_queue_disconnect() for the queue. It unlists the queue
and queues the release work, which destroys the cm_id. Don't wait for
it, rdma_destroy_id() waits for the handler to return, which was the
deadlock before commit f1d4ef7d8883.

Fixes: f1d4ef7d8883 ("nvmet-rdma: register ib_client to not deadlock in device removal")
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Chris Mason <mason@kernel.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/nvme/target/rdma.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 1f71ef2961ba..baaec9a36d8d 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -1773,10 +1773,13 @@ static void nvmet_rdma_queue_connect_fail(struct rdma_cm_id *cm_id,
  * queue cm_id and/or a device bound listener cm_id (where in this
  * case queue will be null).
  *
- * We registered an ib_client to handle device removal for queues,
- * so we only need to handle the listening port cm_ids. In this case
- * we nullify the priv to prevent double cm_id destruction and destroying
- * the cm_id implicitly by returning a non-zero rc to the callout.
+ * The RDMA CM waits until each cm_id of the device is destroyed, so a queue
+ * has to go now. Our ib_client also removes the queues, but it cannot be
+ * relied on here: built in, it is called after the RDMA CM's client.
+ *
+ * For a listening port cm_id we nullify the priv to prevent double cm_id
+ * destruction and destroying the cm_id implicitly by returning a non-zero
+ * rc to the callout.
  */
 static int nvmet_rdma_device_removal(struct rdma_cm_id *cm_id,
 		struct nvmet_rdma_queue *queue)
@@ -1784,11 +1787,7 @@ static int nvmet_rdma_device_removal(struct rdma_cm_id *cm_id,
 	struct nvmet_rdma_port *port;
 
 	if (queue) {
-		/*
-		 * This is a queue cm_id. we have registered
-		 * an ib_client to handle queues removal
-		 * so don't interfere and just return.
-		 */
+		nvmet_rdma_queue_disconnect(queue);
 		return 0;
 	}
 
-- 
2.56.0

