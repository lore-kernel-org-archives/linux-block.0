Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F54258DBE;
	Wed, 11 Dec 2024 18:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733943295; cv=none; b=V3NPfCcRQjp7TwYjZ8XjpZMd/6Q6hYFXEAMJVAt6RvJKdJDI3B+SG0cnD/7qkvVcVVbjoeWixElbLkTKC2LH+4T0kBO0Fi2zHlFf9vUMJMYX7W/Kb8xudeTHEFHCbgwGBX36LKkH7AIGi7b4BhU1HYwnolUrB59K1zBghG2+MTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733943295; c=relaxed/simple;
	bh=jNZQ0zi8NAueW2lyQFKyaIzSOngIk/Se6jwSwXItvds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=alOUYwkSli1qkMDnB8BM2QL51jZ0W0ax7KpiT9k3BHB+CbHIZf6AEHnmIO3YHvpSTVuHImX+5IaNJDzaU9kIC3Pme4x4RSPIS3fCImvUYuTra4uLy500qPdygX3XAMyCIDCiH0zwsVlDTPgURuCUT3Sc/Bb5TC6cTHmCltwQr1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QGNwEJRP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QGNwEJRP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 274F6C4CEE0;
	Wed, 11 Dec 2024 18:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733943295;
	bh=jNZQ0zi8NAueW2lyQFKyaIzSOngIk/Se6jwSwXItvds=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QGNwEJRPPwlMm+H/cuJPUnjmptLnKTUhwcqI/UUvV3NWjNKRcO12bz8D3g52xf2Nm
	 YdAUsB2/vszZAANGe1bJCt5eC6P1HfG9HbeyWOTZgdKDVfxreqaThCH3xHTukwO1KU
	 B20yRT+QVV9+xtST45KkupRCGo8ay9u9b6RtrGXFy4QiDJqqsFehV9EaAqJiaqWcF4
	 sLwZfjhFUX5yriVXcZvgTq8DZ8qbfPXtC2fx1o1lsV3nVcGJHP69I16/jPUaJf8yyo
	 jwGn6iTYLtTuRMzU3/SDaF5dtiN5i0Jaox4QJOQDo/8tt1/uX3GrsC/sTc/WlFfJAC
	 hLcGct4lEACUw==
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
Subject: [PATCH AUTOSEL 5.4 7/7] virtio-blk: don't keep queue frozen during system suspend
Date: Wed, 11 Dec 2024 13:54:40 -0500
Message-ID: <20241211185442.3843374-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241211185442.3843374-1-sashal@kernel.org>
References: <20241211185442.3843374-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.286
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
index 3afc07b59477b..b1c5bcae9b318 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -1062,9 +1062,12 @@ static void virtblk_remove(struct virtio_device *vdev)
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
 	vdev->config->reset(vdev);
@@ -1088,8 +1091,8 @@ static int virtblk_restore(struct virtio_device *vdev)
 		return ret;
 
 	virtio_device_ready(vdev);
+	blk_mq_unquiesce_queue(vblk->disk->queue);
 
-	blk_mq_unfreeze_queue(vblk->disk->queue);
 	return 0;
 }
 #endif
-- 
2.43.0

