Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F643A1D8
	for <linux-block@vger.kernel.org>; Fri,  1 Mar 2024 19:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709321203; cv=none; b=kYRFd1tIplkfJEifEe1opOG8kcudd65//GSZPjSmRy7lV+9nvwAFektaxAAs2LLkjO0hNCnLqMA3yRMOTd1czNvYFAmpnGp1ksJb/uNMSOt89/VHyZ2zpS07axK7CTfJsAX97tQMCgXd6EsjvaJ+5ub6+ET+P2Wm/uyYnx7E49k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709321203; c=relaxed/simple;
	bh=9BRqlpGezbpmeEDIDjIy0uF9xAZYDoSBU/efNeoSCH8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lann47yMLgwecCPCUZeufROPPg3o2AkmVpFlGuHXyiXaJcHx0rqJC2KbFjC5bZlj5ySvlKzvotyaQzboY/awtMIs6c7vEyfktzzCXdxzjaiOSh9a2CTc3ZsoFyCgOi9XEeFd6EfvcEoxM26IK3PZZmKn2MeUmH7tH1tDWkyAFMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CEKHfEZ5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CEKHfEZ5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11C0DC433F1;
	Fri,  1 Mar 2024 19:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709321202;
	bh=9BRqlpGezbpmeEDIDjIy0uF9xAZYDoSBU/efNeoSCH8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CEKHfEZ5ot0nzgefhVb33i8zaavCp0CnDuxTYW+EXrWMF1N+W2JxFKWyNSXpnVGvX
	 QIzDxWLOmKxGr8zZ+Gu5lC9q+tZ5W8UDXjxAr2rsaBil3Sswvi6N9CShDGmgwktzl8
	 CFqTvLVpF5kU8tv7L9fexOKfAscC1CqIspAYW+jkhuQNE/J643ieuhl9+3OJRpYItz
	 o+OAksw2FKMQqyHmWCa61rjww1oqqT/+zcEOl2o4p5NB6DwMkd92Ec+klodErDyQib
	 U6QpBqgr/I4+++GIP+U0+JsvaVBbrBYY2GZiK19UgjE6JeUEq7gNinm+rUPliOu3XS
	 NndhVHqyC/PIA==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 1/3] virtio_blk: Do not use disk_set_max_open/active_zones()
Date: Sat,  2 Mar 2024 04:26:37 +0900
Message-ID: <20240301192639.410183-2-dlemoal@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240301192639.410183-1-dlemoal@kernel.org>
References: <20240301192639.410183-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In virtblk_read_zoned_limits(), setting a zoned block device maximum
number of open and active zones using the functions
disk_set_max_open_zones() and disk_set_max_active_zones() is incorrect
as setting the limits for the request queue is now done atomically when
the gendisk is created (with blk_mq_alloc_disk()). The value set by the
disk_set_max_open/active_zones() functions will be overwritten.
Fix this by setting the maximum number of open and active zones directly
in the queue_limits structure passed to virtblk_read_zoned_limits().

Fixes: 8b837256560c ("virtio_blk: pass queue_limits to blk_mq_alloc_disk")
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/block/virtio_blk.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index d8b55874cd59..aa9f86507719 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -732,12 +732,12 @@ static int virtblk_read_zoned_limits(struct virtio_blk *vblk,
 
 	virtio_cread(vdev, struct virtio_blk_config,
 		     zoned.max_open_zones, &v);
-	disk_set_max_open_zones(vblk->disk, v);
+	lim->max_open_zones = v;
 	dev_dbg(&vdev->dev, "max open zones = %u\n", v);
 
 	virtio_cread(vdev, struct virtio_blk_config,
 		     zoned.max_active_zones, &v);
-	disk_set_max_active_zones(vblk->disk, v);
+	lim->max_active_zones = v;
 	dev_dbg(&vdev->dev, "max active zones = %u\n", v);
 
 	virtio_cread(vdev, struct virtio_blk_config,
-- 
2.44.0

