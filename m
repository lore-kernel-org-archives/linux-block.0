Return-Path: <SRS0=95tF=6C=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE86AC3A5A0
	for <linux-block@archiver.kernel.org>; Sat, 18 Apr 2020 14:49:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B184521D79
	for <linux-block@archiver.kernel.org>; Sat, 18 Apr 2020 14:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587221375;
	bh=mPI7dZVIo4iPlgnoF2Ep7DFHWMf+nmIW9xdSfeatkag=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gS5Bu2UMyp7ji/2/1WleuK9pH4MrarQ3ZKO/Uv2k7+Ujk0tBw7HN4FkN6INz2b347
	 u3YKjvIgDhn0oOtHFpY4WV6EJ8VMUndf1c3Qd3QUNAcVQkECaSUXR5JDmTCtA9VUqd
	 Oyyz3suvw054m9Dfufp7fEkCNQhc1AXnHf4AFxKs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728577AbgDROnZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 18 Apr 2020 10:43:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:54430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728570AbgDROnY (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 18 Apr 2020 10:43:24 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3613222251;
        Sat, 18 Apr 2020 14:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587221004;
        bh=mPI7dZVIo4iPlgnoF2Ep7DFHWMf+nmIW9xdSfeatkag=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FmzAfwVYaOjh/O88VylBa2OfXxOz+svFYVgNHxTBrPM+rvi0NchqXvJSDVsn/UB7j
         DJb+htZ0w6Q2HQ1plcHueaKezxKgglkjeYBJKAr42rASeX7vlqzxu6d+8v6GwaJQQk
         fbClgMoHJONXF8srSs8cP7t+rb9LHXB9MYwXdQtQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Halil Pasic <pasic@linux.ibm.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Sasha Levin <sashal@kernel.org>,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 45/47] virtio-blk: improve virtqueue error to BLK_STS
Date:   Sat, 18 Apr 2020 10:42:25 -0400
Message-Id: <20200418144227.9802-45-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200418144227.9802-1-sashal@kernel.org>
References: <20200418144227.9802-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Halil Pasic <pasic@linux.ibm.com>

[ Upstream commit 3d973b2e9a625996ee997c7303cd793b9d197c65 ]

Let's change the mapping between virtqueue_add errors to BLK_STS
statuses, so that -ENOSPC, which indicates virtqueue full is still
mapped to BLK_STS_DEV_RESOURCE, but -ENOMEM which indicates non-device
specific resource outage is mapped to BLK_STS_RESOURCE.

Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
Link: https://lore.kernel.org/r/20200213123728.61216-3-pasic@linux.ibm.com
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/virtio_blk.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 728c9a9609f0c..9a3c2b14ac378 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -277,9 +277,14 @@ static blk_status_t virtio_queue_rq(struct blk_mq_hw_ctx *hctx,
 		if (err == -ENOSPC)
 			blk_mq_stop_hw_queue(hctx);
 		spin_unlock_irqrestore(&vblk->vqs[qid].lock, flags);
-		if (err == -ENOMEM || err == -ENOSPC)
+		switch (err) {
+		case -ENOSPC:
 			return BLK_STS_DEV_RESOURCE;
-		return BLK_STS_IOERR;
+		case -ENOMEM:
+			return BLK_STS_RESOURCE;
+		default:
+			return BLK_STS_IOERR;
+		}
 	}
 
 	if (bd->last && virtqueue_kick_prepare(vblk->vqs[qid].vq))
-- 
2.20.1

