Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD014C28B2B
	for <linux-block@archiver.kernel.org>; Fri, 12 Aug 2022 21:09:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232206AbiHLVId (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 12 Aug 2022 17:08:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233914AbiHLVIY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 12 Aug 2022 17:08:24 -0400
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9819B56E0
        for <linux-block@vger.kernel.org>; Fri, 12 Aug 2022 14:08:23 -0700 (PDT)
Received: by mail-pf1-f178.google.com with SMTP id q19so1936006pfg.8
        for <linux-block@vger.kernel.org>; Fri, 12 Aug 2022 14:08:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=P/sq4hXt1uCG2JqLepvokP4VqlPP8ukc1qMIMsYWwfc=;
        b=1+cPu9szGt1v8mfpf9YviX+ZtwPWAY3rAxNeMu4o4W8x7+MNdbR4woIL2FTOkOdEiV
         HYwNchWeipGmGskCClrOhJuCGAL0FYhQ6jOOFmi6t59ksAR83IX8Tv9trAWqRkt9hxp1
         VH+qoXvPrzQdYYPPLDTtXe6XPGzaDLLmtaPL3PtVcbUF+D7OcWLlpkO8pzaLujlCoAD6
         yOoEjOuabY8r72TBTdGaEtsHHoEQL1LXtdOxjyKoSJ7U3ezw9ELFI14HluHowjr1kp4q
         pnVnuxAFQ835ZqTOqhDTwPHA3KgTGq0hWMZy0nM+bjEDs94CD9EAIVwhUTrgMexw5zRv
         wiAg==
X-Gm-Message-State: ACgBeo0SKu5u3RC/jLe+Q3rP6OwY8BAtClaOcugTcaPp68X/SEar1q96
        98E+1FyZvbGTKhW1IUb72dw=
X-Google-Smtp-Source: AA6agR5aVHjEGDzqOLufi77rEJB4FUPhUyF9FzWr3Wq055n9zccT0PlsveWJFxyh+tjMGmbgeO5gOA==
X-Received: by 2002:a63:2cd:0:b0:41d:95d6:2a02 with SMTP id 196-20020a6302cd000000b0041d95d62a02mr4569045pgc.458.1660338492862;
        Fri, 12 Aug 2022 14:08:12 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:2414:9f13:41de:d21d])
        by smtp.gmail.com with ESMTPSA id w62-20020a17090a6bc400b001f3095af6a9sm245905pjj.38.2022.08.12.14.08.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Aug 2022 14:08:11 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCH 3/6] block: Change the return type of blk_mq_virtio_map_queues() into void
Date:   Fri, 12 Aug 2022 14:07:57 -0700
Message-Id: <20220812210800.2253972-4-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
In-Reply-To: <20220812210800.2253972-1-bvanassche@acm.org>
References: <20220812210800.2253972-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Since blk_mq_virtio_map_queues() always returns 0, change its return
type into void.

Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Martin K. Petersen <martin.petersen@oracle.com>
Cc: Keith Busch <keith.busch@intel.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-mq-virtio.c         | 6 +++---
 drivers/scsi/virtio_scsi.c    | 3 ++-
 include/linux/blk-mq-virtio.h | 2 +-
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/block/blk-mq-virtio.c b/block/blk-mq-virtio.c
index fa84e748cb69..6589f076a096 100644
--- a/block/blk-mq-virtio.c
+++ b/block/blk-mq-virtio.c
@@ -21,7 +21,7 @@
  * that maps a queue to the CPUs that have irq affinity for the corresponding
  * vector.
  */
-int blk_mq_virtio_map_queues(struct blk_mq_queue_map *qmap,
+void blk_mq_virtio_map_queues(struct blk_mq_queue_map *qmap,
 		struct virtio_device *vdev, int first_vec)
 {
 	const struct cpumask *mask;
@@ -39,9 +39,9 @@ int blk_mq_virtio_map_queues(struct blk_mq_queue_map *qmap,
 			qmap->mq_map[cpu] = qmap->queue_offset + queue;
 	}
 
-	return 0;
+	return;
+
 fallback:
 	blk_mq_map_queues(qmap);
-	return 0;
 }
 EXPORT_SYMBOL_GPL(blk_mq_virtio_map_queues);
diff --git a/drivers/scsi/virtio_scsi.c b/drivers/scsi/virtio_scsi.c
index 578c4b6d0f7d..afc12e25b715 100644
--- a/drivers/scsi/virtio_scsi.c
+++ b/drivers/scsi/virtio_scsi.c
@@ -716,7 +716,8 @@ static int virtscsi_map_queues(struct Scsi_Host *shost)
 	struct virtio_scsi *vscsi = shost_priv(shost);
 	struct blk_mq_queue_map *qmap = &shost->tag_set.map[HCTX_TYPE_DEFAULT];
 
-	return blk_mq_virtio_map_queues(qmap, vscsi->vdev, 2);
+	blk_mq_virtio_map_queues(qmap, vscsi->vdev, 2);
+	return 0;
 }
 
 static void virtscsi_commit_rqs(struct Scsi_Host *shost, u16 hwq)
diff --git a/include/linux/blk-mq-virtio.h b/include/linux/blk-mq-virtio.h
index 687ae287e1dc..13226e9b22dd 100644
--- a/include/linux/blk-mq-virtio.h
+++ b/include/linux/blk-mq-virtio.h
@@ -5,7 +5,7 @@
 struct blk_mq_queue_map;
 struct virtio_device;
 
-int blk_mq_virtio_map_queues(struct blk_mq_queue_map *qmap,
+void blk_mq_virtio_map_queues(struct blk_mq_queue_map *qmap,
 		struct virtio_device *vdev, int first_vec);
 
 #endif /* _LINUX_BLK_MQ_VIRTIO_H */
