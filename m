Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370C83D0A4
	for <linux-block@vger.kernel.org>; Mon, 22 Jan 2024 11:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705921664; cv=none; b=FQp6U4wM6WbCIbNrBK2LtDFwQw3Xb3Cj9qjtDVSVNoppQ4rllqB21cT164KzyOy/xUkucQG+gWFJIoKvln3vVAAVEKI87M/rIBIB+G1mSWBQZZBR4RThYKA3XEslFvY82JGanKV691IDQ3eDGiJm3CFEAuBMf6N+LmjAvlem1jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705921664; c=relaxed/simple;
	bh=tEBM8ROgFnpAjPpGkQqFn+5G7qisAii32clsfbRevhI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e6kyKFpTrGMtLBisP77xn2N/KKYg+VlvCWn7sKddN7hgiqdQGDAyR2MPnMIeimXysxdLq7tlOYDjzat/TvGLzggRR/1N2bn4KzM5oOcef2iZsVNH6vjc9RyBjlVacxxKsWZlD70EFdqZhhFPhuFTKnasYmE1ebv39YqrrQvbhjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 40MB7TmP062317;
	Mon, 22 Jan 2024 19:07:29 +0800 (+08)
	(envelope-from Yi.Sun@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4TJS153t0qz2RcY8P;
	Mon, 22 Jan 2024 19:00:09 +0800 (CST)
Received: from tj10379pcu.spreadtrum.com (10.5.32.15) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Mon, 22 Jan 2024 19:07:27 +0800
From: Yi Sun <yi.sun@unisoc.com>
To: <axboe@kernel.dk>, <mst@redhat.com>, <jasowang@redhat.com>
CC: <xuanzhuo@linux.alibaba.com>, <pbonzini@redhat.com>, <stefanha@redhat.com>,
        <virtualization@lists.linux.dev>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yi.sun@unisoc.com>,
        <zhiguo.niu@unisoc.com>, <hongyu.jin@unisoc.com>,
        <sunyibuaa@gmail.com>
Subject: [PATCH 2/2] virtio-blk: Ensure no requests in virtqueues before deleting vqs.
Date: Mon, 22 Jan 2024 19:07:22 +0800
Message-ID: <20240122110722.690223-3-yi.sun@unisoc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240122110722.690223-1-yi.sun@unisoc.com>
References: <20240122110722.690223-1-yi.sun@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL:SHSQR01.spreadtrum.com 40MB7TmP062317

Ensure no remaining requests in virtqueues before resetting vdev and
deleting virtqueues. Otherwise these requests will never be completed.
It may cause the system to become unresponsive. So it is better to place
blk_mq_quiesce_queue() in front of virtio_reset_device().

Function blk_mq_quiesce_queue() can ensure that requests have become
in_flight status, but it cannot guarantee that requests have been
processed by the device. Virtqueues should never be deleted before
all requests become complete status.

New function blk_mq_tagset_wait_request_completed() ensure that all
requests in virtqueues become complete status.

Signed-off-by: Yi Sun <yi.sun@unisoc.com>
---
 drivers/block/virtio_blk.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 3b6b9abb8ce1..380f009953dd 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -1595,14 +1595,16 @@ static int virtblk_freeze(struct virtio_device *vdev)
 {
 	struct virtio_blk *vblk = vdev->priv;
 
+	/* Ensure no requests in virtqueues before deleting vqs. */
+	blk_mq_quiesce_queue(vblk->disk->queue);
+	blk_mq_tagset_wait_request_completed(vblk->disk->queue->tag_set);
+
 	/* Ensure we don't receive any more interrupts */
 	virtio_reset_device(vdev);
 
 	/* Make sure no work handler is accessing the device. */
 	flush_work(&vblk->config_work);
 
-	blk_mq_quiesce_queue(vblk->disk->queue);
-
 	vdev->config->del_vqs(vdev);
 	kfree(vblk->vqs);
 
-- 
2.25.1

