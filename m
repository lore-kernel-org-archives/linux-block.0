Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20230601.gappssmtp.com header.i=@smartx-com.20230601.gappssmtp.com header.b="wT5VYrmQ"
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01ACAD4B
	for <linux-block@vger.kernel.org>; Wed,  6 Dec 2023 20:33:03 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id 5614622812f47-3b84e328327so434685b6e.2
        for <linux-block@vger.kernel.org>; Wed, 06 Dec 2023 20:33:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1701923582; x=1702528382; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f/Lf0+IIfQE0io2nHdmDYhVLqD8zUaOijlO0hMGWTXo=;
        b=wT5VYrmQHNPb1qQ3+Ylr9AB94gfVkmZCFtEREN9DtQks6bAY4XrND3mEdttHR1wUFc
         iTMAjQlS3o3LvUrt8m1x0G1eUlxaF3TpDvc1sl6Iqnv8z3Q+K/pRmBXMRfRo4+yDjRGl
         ghcAxp3IzknCeqJbtDbB2MlB1RyGOM2LDvqOqWYvjd5uHkHxjkfAHdLuYfLhb8hWdMS5
         MTaSlG6GHaZbIC04MgNmA1u1mJJSYnxM0tRpJ+3m8orCYnGracbeMtYooR1sH/1hbjEg
         at7BC0WM+rm9qm5t8GXilCu/mYYtKbpy7L6s3BCL1IFgBtZvYBRa7wovb16RpUfuvPUR
         ELPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701923582; x=1702528382;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f/Lf0+IIfQE0io2nHdmDYhVLqD8zUaOijlO0hMGWTXo=;
        b=KyJx4fyqf96JHF43ShU5dhCwUtNo97T9c6yQzQdchh/b7aHvpxy4QysfYrAvfU8cH0
         hT/c9rh+AmhlMPQkiezgjMOfS8UtRLG8c0FI5iSwENMSbOO1yfoUBBsmUoarXJrjYHgo
         Hyj7RaVmOfIpZkr/ouJHMQrNZPdLWHrzSAsr1ndn1md7nJwFWQY/66xB83botvqPWLhH
         XXhpLui7RLyH96LzkIMUIefzodo662/vehIO9X38a8pRpVDnA1kjnxtBKMvhcnFUBUAC
         ZELvSSHKD+fUSxWIwQi7U3w7RyYanO7YTJrx2SqcVMsM57Xj/jYDw3mo6xRiXWjqYNsf
         RrRQ==
X-Gm-Message-State: AOJu0Yy1MEzYKH8kmWnYuzhdTzPhOR/cwNUR9q/GXJbvxoASYmbmmZBC
	XuNjBixtdwErmslOKUVdhDFy7w==
X-Google-Smtp-Source: AGHT+IHJYbFIUTZB44VBOizgu6C4ZjGpZ8ov/2VlLfUy+pzKCRy95+hHpycf+1VuZxTdnNIi7xPU9A==
X-Received: by 2002:aca:1b02:0:b0:3b9:dcf0:63b9 with SMTP id b2-20020aca1b02000000b003b9dcf063b9mr615047oib.23.1701923581661;
        Wed, 06 Dec 2023 20:33:01 -0800 (PST)
Received: from localhost.localdomain.localdomain ([8.210.91.195])
        by smtp.gmail.com with ESMTPSA id v19-20020aa78513000000b006cea1e12564sm332971pfn.81.2023.12.06.20.32.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 20:33:01 -0800 (PST)
From: Li Feng <fengli@smartx.com>
To: Jens Axboe <axboe@kernel.dk>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	linux-block@vger.kernel.org (open list:BLOCK LAYER),
	linux-kernel@vger.kernel.org (open list),
	virtualization@lists.linux.dev (open list:VIRTIO BLOCK AND SCSI DRIVERS)
Cc: Li Feng <fengli@smartx.com>
Subject: [PATCH] virtio_blk: set the default scheduler to none
Date: Thu,  7 Dec 2023 12:31:05 +0800
Message-ID: <20231207043118.118158-1-fengli@smartx.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

virtio-blk is generally used in cloud computing scenarios, where the
performance of virtual disks is very important. The mq-deadline scheduler
has a big performance drop compared to none with single queue. In my tests,
mq-deadline 4k readread iops were 270k compared to 450k for none. So here
the default scheduler of virtio-blk is set to "none".

Signed-off-by: Li Feng <fengli@smartx.com>
---
 drivers/block/virtio_blk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index d53d6aa8ee69..5183ec8e00be 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -1367,7 +1367,7 @@ static int virtblk_probe(struct virtio_device *vdev)
 	vblk->tag_set.ops = &virtio_mq_ops;
 	vblk->tag_set.queue_depth = queue_depth;
 	vblk->tag_set.numa_node = NUMA_NO_NODE;
-	vblk->tag_set.flags = BLK_MQ_F_SHOULD_MERGE;
+	vblk->tag_set.flags = BLK_MQ_F_SHOULD_MERGE | BLK_MQ_F_NO_SCHED_BY_DEFAULT;
 	vblk->tag_set.cmd_size =
 		sizeof(struct virtblk_req) +
 		sizeof(struct scatterlist) * VIRTIO_BLK_INLINE_SG_CNT;
-- 
2.42.0

