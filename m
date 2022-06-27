Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31482C43334
	for <linux-block@archiver.kernel.org>; Mon, 27 Jun 2022 23:44:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242322AbiF0XoA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Jun 2022 19:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242330AbiF0XoA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Jun 2022 19:44:00 -0400
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 006EE186D4
        for <linux-block@vger.kernel.org>; Mon, 27 Jun 2022 16:43:58 -0700 (PDT)
Received: by mail-pl1-f176.google.com with SMTP id q18so9518802pld.13
        for <linux-block@vger.kernel.org>; Mon, 27 Jun 2022 16:43:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mWEdUNf63h0nD8vBGcfJSzzSQBu9wEwV18+U9TSXL50=;
        b=p8CRHLxgPH57V1D3h/gs5X1J9qbqr+P4MWYgzRJadLrAtZjEeNnIwPIOaXtNoexDRT
         4G82q6xqLhv+p6RaHnG0r8vmx/bfKeoybkEyMmJAqF9BeQGLluCnlIFPlxXh++5WTha7
         bTx46Qs0CfxQvxjTpEp717MBWcA8OH5+RdKisskJ7SXceIrLl/5jDA/VejxGVyYCZhju
         3M6Kcb4ylybVkrqosEJ3JURe8PZlAo123YHtkrWqSB1wJbm9dr0esHEaVQ9M6baD559v
         oJ0KLxmBfD+RE/TF3ic/QQ0Fex2sZbK87/DsYq0gvsL5BUSx4cPiWvFrFbjI4gAh2OXW
         jR+g==
X-Gm-Message-State: AJIora+ksYHAYw6raIcX3IWRhrN4jtBj+o6Iqdb5XuV/IcQASKPSajCf
        jCTqv3tgirhz0mCSYiGW/ho=
X-Google-Smtp-Source: AGRyM1u86Pk5SL67Jr25AXE41LTwmfdfGIJjYS5g0ZXMu5wReHSUpQViorSAIMCOeJ4nj/uY7/NJaA==
X-Received: by 2002:a17:902:d4c4:b0:16a:2d0a:b609 with SMTP id o4-20020a170902d4c400b0016a2d0ab609mr1895170plg.5.1656373438093;
        Mon, 27 Jun 2022 16:43:58 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:3879:b18f:db0d:205])
        by smtp.gmail.com with ESMTPSA id md6-20020a17090b23c600b001e305f5cd22sm7907456pjb.47.2022.06.27.16.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 16:43:57 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: [PATCH v3 6/8] block/null_blk: Add support for pipelining zoned writes
Date:   Mon, 27 Jun 2022 16:43:33 -0700
Message-Id: <20220627234335.1714393-7-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
In-Reply-To: <20220627234335.1714393-1-bvanassche@acm.org>
References: <20220627234335.1714393-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add a new configfs attribute for enabling pipelining of zoned writes. If
that attribute has been set, retry zoned writes that are not aligned with
the write pointer. The test script below reports 244 K IOPS with no I/O
scheduler, 5.79 K IOPS with mq-deadline and pipelining disabled and 79.6 K
IOPS with mq-deadline and pipelining enabled. This shows that pipelining
results in about 14 times more IOPS for this particular test case.

    #!/bin/bash

    for mode in "none 0" "mq-deadline 0" "mq-deadline 1"; do
        set +e
        for d in /sys/kernel/config/nullb/*; do
            [ -d "$d" ] && rmdir "$d"
        done
        modprobe -r null_blk
        set -e
        read -r iosched pipelining <<<"$mode"
        modprobe null_blk nr_devices=0
        (
            cd /sys/kernel/config/nullb
            mkdir nullb0
            cd nullb0
            params=(
                completion_nsec=100000
                hw_queue_depth=64
                irqmode=2                # NULL_IRQ_TIMER
                max_sectors=$((4096/512))
                memory_backed=1
                pipeline_zoned_writes="${pipelining}"
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
        udevadm settle
        dev=/dev/nullb0
        [ -b "${dev}" ]
        params=(
            --direct=1
            --filename="${dev}"
            --iodepth=64
            --iodepth_batch=16
            --ioengine=io_uring
            --ioscheduler="${iosched}"
            --gtod_reduce=1
            --hipri=0
            --name=nullb0
            --runtime=30
            --rw=write
            --time_based=1
            --zonemode=zbd
        )
        fio "${params[@]}"
    done

Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/block/null_blk/main.c     |  9 +++++++++
 drivers/block/null_blk/null_blk.h |  3 +++
 drivers/block/null_blk/zoned.c    | 13 ++++++++++++-
 3 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index fd68e6f4637f..de9ed9a4ca10 100644
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
+		cmd->max_attempts = rq->q->nr_requests;
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
index 2fdd7b20c224..7138954dc01c 100644
--- a/drivers/block/null_blk/zoned.c
+++ b/drivers/block/null_blk/zoned.c
@@ -403,7 +403,18 @@ static blk_status_t null_zone_write(struct nullb_cmd *cmd, sector_t sector,
 		else
 			cmd->bio->bi_iter.bi_sector = sector;
 	} else if (sector != zone->wp) {
-		ret = BLK_STS_IOERR;
+		/*
+		 * In case of a misaligned write and if pipelining of zoned
+		 * writes has been enabled, request the block layer to retry
+		 * until the maximum number of attempts has been reached. If
+		 * the maximum number of attempts has been reached, fail the
+		 * misaligned write.
+		 */
+		if (dev->pipeline_zoned_writes &&
+		    ++cmd->retries < cmd->max_attempts)
+			ret = BLK_STS_DEV_RESOURCE;
+		else
+			ret = BLK_STS_IOERR;
 		goto unlock;
 	}
 
