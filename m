Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43780C433EF
	for <linux-block@archiver.kernel.org>; Thu, 23 Jun 2022 23:26:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbiFWX0V (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Jun 2022 19:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiFWX0T (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Jun 2022 19:26:19 -0400
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F4EE52E67
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 16:26:19 -0700 (PDT)
Received: by mail-pj1-f42.google.com with SMTP id g10-20020a17090a708a00b001ea8aadd42bso1161194pjk.0
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 16:26:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IrMdzGs0zmYyXqBODn8sQ9FYeoF6iisrzUHqYhgPeWs=;
        b=DYWsrUy1eMDruomeDaKj0f+G4KHCg4IWnvsagua9aKYmkkXdTGT7EdxFWLodgAYx/g
         5HgoXxymObyiOLstN5V3p/+JiyYZkGAI+E/i4GblxmkQBu9p2jsh9l9vjscAbW4owqkS
         V/j0C7p2rhFVtQ413wHg24jGUkWzPUA/ihpoatD/0tQzg7bn6ufYRLqwI8c/k8T1IqI4
         Al2HWQQpjzxUGmOcWgN9a6HvcDEOJrC9P09YJtzkwUAM/GMJlLwjKvdV2/fVPT4frjPj
         82Mu0B7DN+lIJlYswRKirDFCY54VO3+eFG9pWLk1eWXsbtAD6jC2hwe/Vp769nlaqrX+
         eNeQ==
X-Gm-Message-State: AJIora/4o7ZRNALaP2UzxfMoJq8GD6tJDqmNXQ+DQ2W9lULQ/fr+yYkb
        2s34mD9tGcvMl/gSpyyIPMYnqglnSb1IvA==
X-Google-Smtp-Source: AGRyM1smZBqAnz2zNP1T7BAYlVpInJbeM7DZw1PUD1AvOXNGukk+82tN1l6ipC6nYF2i9+0GX8fyvw==
X-Received: by 2002:a17:903:234e:b0:16a:2d02:add7 with SMTP id c14-20020a170903234e00b0016a2d02add7mr19542427plh.10.1656026778844;
        Thu, 23 Jun 2022 16:26:18 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:85b2:5fa3:f71e:1b43])
        by smtp.gmail.com with ESMTPSA id f11-20020a62380b000000b0051829b1595dsm184709pfa.130.2022.06.23.16.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 16:26:18 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: [PATCH v2 6/6] block/null_blk: Add support for pipelining zoned writes
Date:   Thu, 23 Jun 2022 16:26:03 -0700
Message-Id: <20220623232603.3751912-7-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
In-Reply-To: <20220623232603.3751912-1-bvanassche@acm.org>
References: <20220623232603.3751912-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add a new configfs attribute for enabling pipelining of zoned writes. If
that attribute has been set, retry zoned writes that are not aligned with
the write pointer. The test script below reports 236 K IOPS with no I/O
scheduler, 81 K IOPS with mq-deadline and pipelining disabled and 121 K
IOPS with mq-deadline and pipelining enabled (+49%).

    #!/bin/bash

    for d in /sys/kernel/config/nullb/*; do
        [ -d "$d" ] && rmdir "$d"
    done
    modprobe -r null_blk
    set -e
    modprobe null_blk nr_devices=0
    udevadm settle
    (
        cd /sys/kernel/config/nullb
        mkdir nullb0
        cd nullb0
        params=(
	    completion_nsec=100000
	    hw_queue_depth=64
	    irqmode=2
	    memory_backed=1
	    pipeline_zoned_writes=1
	    size=1
	    submit_queues=1
	    zone_size=1
	    zoned=1
	    power=1
        )
        for p in "${params[@]}"; do
	    echo "${p//*=}" > "${p//=*}"
        done
    )
    params=(
        --direct=1
        --filename=/dev/nullb0
        --iodepth=64
        --iodepth_batch=16
        --ioengine=io_uring
        --ioscheduler=mq-deadline
	--hipri=0
        --name=nullb0
        --runtime=30
        --rw=write
        --time_based=1
        --zonemode=zbd
    )
    fio "${params[@]}"

Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/block/null_blk/main.c     | 9 +++++++++
 drivers/block/null_blk/null_blk.h | 3 +++
 drivers/block/null_blk/zoned.c    | 4 +++-
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index fd68e6f4637f..d5fc651ffc3d 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -408,6 +408,7 @@ NULLB_DEVICE_ATTR(zone_capacity, ulong, NULL);
 NULLB_DEVICE_ATTR(zone_nr_conv, uint, NULL);
 NULLB_DEVICE_ATTR(zone_max_open, uint, NULL);
 NULLB_DEVICE_ATTR(zone_max_active, uint, NULL);
+NULLB_DEVICE_ATTR(pipeline_zoned_writes, bool, NULL);
 NULLB_DEVICE_ATTR(virt_boundary, bool, NULL);
 
 static ssize_t nullb_device_power_show(struct config_item *item, char *page)
@@ -531,6 +532,7 @@ static struct configfs_attribute *nullb_device_attrs[] = {
 	&nullb_device_attr_zone_nr_conv,
 	&nullb_device_attr_zone_max_open,
 	&nullb_device_attr_zone_max_active,
+	&nullb_device_attr_pipeline_zoned_writes,
 	&nullb_device_attr_virt_boundary,
 	NULL,
 };
@@ -1626,6 +1628,11 @@ static blk_status_t null_queue_rq(struct blk_mq_hw_ctx *hctx,
 	cmd->error = BLK_STS_OK;
 	cmd->nq = nq;
 	cmd->fake_timeout = should_timeout_request(rq);
+	if (!(rq->rq_flags & RQF_DONTPREP)) {
+		rq->rq_flags |= RQF_DONTPREP;
+		cmd->retries = 0;
+		cmd->max_attempts = rq->q->nr_hw_queues * rq->q->nr_requests;
+	}
 
 	blk_mq_start_request(rq);
 
@@ -2042,6 +2049,8 @@ static int null_add_dev(struct nullb_device *dev)
 	nullb->q->queuedata = nullb;
 	blk_queue_flag_set(QUEUE_FLAG_NONROT, nullb->q);
 	blk_queue_flag_clear(QUEUE_FLAG_ADD_RANDOM, nullb->q);
+	if (dev->pipeline_zoned_writes)
+		blk_queue_flag_set(QUEUE_FLAG_PIPELINE_ZONED_WRITES, nullb->q);
 
 	mutex_lock(&lock);
 	nullb->index = ida_simple_get(&nullb_indexes, 0, 0, GFP_KERNEL);
diff --git a/drivers/block/null_blk/null_blk.h b/drivers/block/null_blk/null_blk.h
index 8359b43842f2..bbe2cb17bdbd 100644
--- a/drivers/block/null_blk/null_blk.h
+++ b/drivers/block/null_blk/null_blk.h
@@ -23,6 +23,8 @@ struct nullb_cmd {
 	unsigned int tag;
 	blk_status_t error;
 	bool fake_timeout;
+	u16 retries;
+	u16 max_attempts;
 	struct nullb_queue *nq;
 	struct hrtimer timer;
 };
@@ -112,6 +114,7 @@ struct nullb_device {
 	bool memory_backed; /* if data is stored in memory */
 	bool discard; /* if support discard */
 	bool zoned; /* if device is zoned */
+	bool pipeline_zoned_writes;
 	bool virt_boundary; /* virtual boundary on/off for the device */
 };
 
diff --git a/drivers/block/null_blk/zoned.c b/drivers/block/null_blk/zoned.c
index 2fdd7b20c224..8d0a5e16f4b1 100644
--- a/drivers/block/null_blk/zoned.c
+++ b/drivers/block/null_blk/zoned.c
@@ -403,7 +403,9 @@ static blk_status_t null_zone_write(struct nullb_cmd *cmd, sector_t sector,
 		else
 			cmd->bio->bi_iter.bi_sector = sector;
 	} else if (sector != zone->wp) {
-		ret = BLK_STS_IOERR;
+		ret = dev->pipeline_zoned_writes &&
+			++cmd->retries < cmd->max_attempts ?
+			BLK_STS_DEV_RESOURCE : BLK_STS_IOERR;
 		goto unlock;
 	}
 
