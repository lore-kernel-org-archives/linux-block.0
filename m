Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5BB236944;
	Wed, 11 Dec 2024 18:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733943116; cv=none; b=RPM4W4xUEo9jQj5H+GwqeXNqRVk6TO+tyGcr8kRXK2u547Tdpk+0cX6ohr1IcZWtb9d+s103z7CpM7TBfFPQz3Ty8WjQolALHZj6W4dmA+UxGiRKyjAM7xNA14PHMy2iLh5ZW8hymtQeGraY3r/MrJ2oyLmHSYrtZE436oF+Vwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733943116; c=relaxed/simple;
	bh=jK7Ym91sZIs2S5R6EZ6uVUch5cY/xLwIjcbdyjg5/mg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OhGfrrc7/Zaguk8ctxHUwYCvDHQJVGp0ZpELidry6tvGZ4bi0onf0QT5pmzALV9iQIxWDz/Q/Z17Xtat+am0ZsPb3Y/Z/tm8ozmzTZCPAr5NBQSRiF5noCHwkCuciu0jywVUUeAEjp4uEOryKTxa4UBlLmk0JBPGM7/751PsxVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ppZ0cnAb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ppZ0cnAb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B155C4CED2;
	Wed, 11 Dec 2024 18:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733943115;
	bh=jK7Ym91sZIs2S5R6EZ6uVUch5cY/xLwIjcbdyjg5/mg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ppZ0cnAbgRYpzL908gehe+OvZEM6qSIH8TYKtCnhNm2ZfqgOHMA7HU4dwGnhS3o+/
	 otwBgAmwdBY6G8Gcqum99pl8VawpZ/IpOYsrSby/zkYrJ76FQYR4KRjClFRanfwjJn
	 u9Q+BtBftBYUJmx8h4VlJFy7EejEXHHmnI2Xg76M7wzRxfXH2COU+RYawFUPQPwWTB
	 QZWZDMjs+bfrAQ7rJ5zMHCZ+Aqo9NKzftJv5oZ0r1euFaxfzwqgDUCbCuKoZzlH5ZA
	 Pvm91Y4Os3AQ9vdPp7ZWyHPgxQwPWr9osPS1/JrqxYm0K1501FPgbuY/0/YHDhq47d
	 xWhwSMwvAnNdA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>,
	Yi Sun <yi.sun@unisoc.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	virtualization@lists.linux.dev,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>,
	linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 34/36] virtio-blk: don't keep queue frozen during system suspend
Date: Wed, 11 Dec 2024 13:49:50 -0500
Message-ID: <20241211185028.3841047-34-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241211185028.3841047-1-sashal@kernel.org>
References: <20241211185028.3841047-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.4
Content-Transfer-Encoding: 8bit

From: Ming Lei <ming.lei@redhat.com>

[ Upstream commit 7678abee0867e6b7fb89aa40f6e9f575f755fb37 ]

Commit 4ce6e2db00de ("virtio-blk: Ensure no requests in virtqueues before
deleting vqs.") replaces queue quiesce with queue freeze in virtio-blk's
PM callbacks. And the motivation is to drain inflight IOs before suspending.

block layer's queue freeze looks very handy, but it is also easy to cause
deadlock, such as, any attempt to call into bio_queue_enter() may run into
deadlock if the queue is frozen in current context. There are all kinds
of ->suspend() called in suspend context, so keeping queue frozen in the
whole suspend context isn't one good idea. And Marek reported lockdep
warning[1] caused by virtio-blk's freeze queue in virtblk_freeze().

[1] https://lore.kernel.org/linux-block/ca16370e-d646-4eee-b9cc-87277c89c43c@samsung.com/

Given the motivation is to drain in-flight IOs, it can be done by calling
freeze & unfreeze, meantime restore to previous behavior by keeping queue
quiesced during suspend.

Cc: Yi Sun <yi.sun@unisoc.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Cc: virtualization@lists.linux.dev
Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
Link: https://lore.kernel.org/r/20241112125821.1475793-1-ming.lei@redhat.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/virtio_blk.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 43c96b73a7118..0e50b65e1dbf5 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -1587,9 +1587,12 @@ static void virtblk_remove(struct virtio_device *vdev)
 static int virtblk_freeze(struct virtio_device *vdev)
 {
 	struct virtio_blk *vblk = vdev->priv;
+	struct request_queue *q = vblk->disk->queue;
 
 	/* Ensure no requests in virtqueues before deleting vqs. */
-	blk_mq_freeze_queue(vblk->disk->queue);
+	blk_mq_freeze_queue(q);
+	blk_mq_quiesce_queue_nowait(q);
+	blk_mq_unfreeze_queue(q);
 
 	/* Ensure we don't receive any more interrupts */
 	virtio_reset_device(vdev);
@@ -1613,8 +1616,8 @@ static int virtblk_restore(struct virtio_device *vdev)
 		return ret;
 
 	virtio_device_ready(vdev);
+	blk_mq_unquiesce_queue(vblk->disk->queue);
 
-	blk_mq_unfreeze_queue(vblk->disk->queue);
 	return 0;
 }
 #endif
-- 
2.43.0

