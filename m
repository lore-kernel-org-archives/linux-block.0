Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793205967;
	b=ZjXRoPHZaxYItKTuYBFS8gw+qMpkrnBsUf/JOuC8RoAxyXAzwQD9tGezBPFXZonE7+Mo
	 QQR4rsOaRdSdSz/xLxj/uEihst9K3OGRK3QoHgDd/jivIwO1s/c9oe5I51kACx2l4LUGx
	 x9MWLsgC/61EHXuZzXY/QjyG5RfF8qD3F7h4XW/LaOju5LjeF2ptnGKAMJDvaON/qiQNl
	 ykfK3Z6vN0/AbBDlHnH1/T7u7MPONgOSwMwrEEYqKL9a1RHS6oOIjMih6cYLLaSD3pc2A
	 b9YBWJDX/fWqPWfZ6TtgaNI+9N9UxpOAzNOs5CuoSETo47bFH1yglSNBEU78LDiEGSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793205967;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=+jlqB8xzzxUz/wT5YJ6yOAG8soVbouPsJpJ46iQuysc=;
	b=wU8uJcjS3coKouM00YYa/RbZ42qQDY40PqAO+qNjZzPwZJYU87LJVbmXY8RhCKFxaKIh
	 V0CEMk5OlrYQFcKgJlg1iOaZ6OVTgJoWYBzTOdafPYOS/GcKFQCnirywU/+FSa+3Bwi7g
	 aJ0NKgPGjPF0wMkspTo+vBEKTlENRTBLriGDG7vwlYAdYcuwORmVH5G4PaSuYIhZSRljn
	 NyX923Z6VccvMKMZ0xzpQpUxqJ7LrOMteXt2c/XSjpya/eQVt/7/wmW2cZIUQIQrl5yLc
	 gs0y+8QftUBvE8zqeFcdixJBS+sI/R0uWIWZp26eUcMwlqokInmXNW+AEijGxrZLX9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=HDekxJBW;
	arc=none smtp.remote-ip=209.85.210.51
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C36606A32F
	for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 16:46:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 84C36606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=HDekxJBW
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-843cf077f10so1347096a34.1
        for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 09:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793205966; x=1793810766; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+jlqB8xzzxUz/wT5YJ6yOAG8soVbouPsJpJ46iQuysc=;
        b=HDekxJBWSbSXzuYvMvvUsuWa9h/K6A/lUcGbgoAlR5UWNSYx3TWFbmPRDRTSbG2egQ
         Pg+W14QTtQNotHAh24Vy4CxwHU128CkSiHIUxlkNB9DXa1MfxHLZKVrE5oLdanl4zOeQ
         MBiG77BrfiUAelJxZ9mYYYZxM+LD9M2yy+ZPqqzMvQL8hhr1lsoWj64L9vk9xvmAHU4P
         oNPdkTxssJam93AnU4ysrKA/DCeVpTurLNJt5TJ8/xONZW2puWVkzhj4xNx4Ai9OF6sH
         j/LrcBozsFQb92Zdgz0riWQhEn05hKB0qVvwr9trhGnv/NyPBMM8ZXn2WUEf7GcnYuO5
         q43Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793205966; x=1793810766;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+jlqB8xzzxUz/wT5YJ6yOAG8soVbouPsJpJ46iQuysc=;
        b=YGkcu+Yn53SXp3NJG0HxmSqOEXjjIMvr7dsr7d4MAF//uQc04XMClXKS5aaHoMVDix
         8Aa/uhpgebz3zfMVSOZi1I2GhXr0EclJx3isFjwOcfVhlq8szxWWLpYW/dnaPX+1eL24
         W03pXzd3CwECgkSoRGC975gnvz2unvKnkbWUJ7aJM4XfJtoRWMRPg9lWSFfqYMcLS2ny
         eg3UVtG8UVdJ/0MBuNtb2qQDNb2OGOfAH5AMExaOeie+CsgLbbe157ucK/CnVUM8vuA2
         /Dl6LUvj5R50xe67O39EVQdGgEP0C++cDp6FgVMbMdo/o2si7iqu19AJB9Dqh8t8LANP
         A1Yw==
X-Gm-Message-State: AFq9FYICM+3Fo3Bx0h/crJLWDS2WhTt+r9LIdalgaCOWQb82bBua22L7
	t8uUwGneJLQLbQMgBLKCsjBW13UkAbRV0bk0xBwksx2iXQDhqQcrHktA6mlnZjaJp2A4UKgZCCM
	pB1VpaGc=
X-Gm-Gg: AYBFou0npq6MFUWzgyivBkL6HKEbC6kPF9r5a+zgKqYHPRJAsnxXDi9KD7Hgk5KOVTJ
	qOSjjjPs6d46NMQIzsomj2YxtzOhSban5RGF2iIi9sw72TLDhRGZTK0XaYumRShDG5QP8tOUdOO
	D7QbqQgFwCUzsOvLFdjcGKE2rralFBfcWpJRwieMfNEVkqTotMwHIcOMnJ9yBLF/QAVzgU3jbhj
	OWQuvPgfgyjQZFgyTIU0FCwhN6tjD7p7zh+PmvAZMsvFhzKl700RfqXKfiNm9F6Xwl2zaEfy14R
	DFXTGIGQn1+jubcOl++6hP+TEuuEaEltPHvLV5HhAUDF4c33vCi2WdGYcI7i1GJBGzjQAV7f3g1
	GMIhlk/6gYGfO2RE9WGs5BaOEVhYQby/YFnKUEyZ+tgo+Pz/z2xarCDgfS3rtflw2sPsvvt6qa4
	+nCaCPGB/hIqKka0N1IONYVZFWbUO2T8AzFHtpWxPPCYJLIKCVwfZO5jZ7R7PMAZ1748O27j3St
	NpwGO3btVyA/AT7PSfpFcZ+AVeHCTLDCAFBjPAFKcm6Qp6fgfgNHMsRvaIt2s1tw2cG54pUtd7D
	GkgGKTy4BQk6h8u9O4Ln3nV0FQ4a6OtkNZNfOtdYgibwhkWZClcApFrO5MOIJ9aKi23NQYYmJg=
	=
X-Received: by 2002:a05:6830:4391:b0:844:ec25:c7f3 with SMTP id 46e09a7af769-85ac070a18bmr2685712a34.18.1793205966430;
        Wed, 28 Oct 2026 09:46:06 -0700 (PDT)
Received: from xps16 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85b20216828sm2416941a34.19.2026.10.28.09.46.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:46:05 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: Chris Mason <mason@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 86/98] nvmet-rdma: queue the release work under the mutex
Date: Wed, 28 Oct 2026 10:42:29 -0600
Message-ID: <20261028164415.1262013-87-axboe@kernel.dk>
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

nvmet_rdma_remove_one() takes the queue mutex, unlists each queue of
the device and queues its release work, then flushes nvmet-wq. So a
queue that still holds objects on the device must either be on the
list or have its release work queued. nvmet_rdma_queue_disconnect()
breaks that: it unlists the queue under the mutex, drops it, and only
then calls __nvmet_rdma_queue_disconnect() to queue the work. A device
removal in that window finds nothing to wait for, and the release work
then destroys the QP and CQ share on a freed device.

Queue the work before dropping the mutex, as nvmet_rdma_remove_one()
itself does. That's safe now that rdma_disconnect() no longer sleeps on
an iWARP event that needs the same mutex.

Fixes: f1d4ef7d8883 ("nvmet-rdma: register ib_client to not deadlock in device removal")
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Chris Mason <mason@kernel.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/nvme/target/rdma.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index a85e6fa71e0b..1f71ef2961ba 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -1737,17 +1737,17 @@ static void __nvmet_rdma_queue_disconnect(struct nvmet_rdma_queue *queue)
 
 static void nvmet_rdma_queue_disconnect(struct nvmet_rdma_queue *queue)
 {
-	bool disconnect = false;
-
+	/*
+	 * The release work is queued with the mutex held, so that
+	 * nvmet_rdma_remove_one() finds the queue on the list or its work on
+	 * the workqueue.
+	 */
 	mutex_lock(&nvmet_rdma_queue_mutex);
 	if (!list_empty(&queue->queue_list)) {
 		list_del_init(&queue->queue_list);
-		disconnect = true;
+		__nvmet_rdma_queue_disconnect(queue);
 	}
 	mutex_unlock(&nvmet_rdma_queue_mutex);
-
-	if (disconnect)
-		__nvmet_rdma_queue_disconnect(queue);
 }
 
 static void nvmet_rdma_queue_connect_fail(struct rdma_cm_id *cm_id,
-- 
2.56.0

