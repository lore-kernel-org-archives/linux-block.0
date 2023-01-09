Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CF80C5479D
	for <linux-block@archiver.kernel.org>; Mon,  9 Jan 2023 23:28:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235477AbjAIX2G (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Jan 2023 18:28:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237928AbjAIX16 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Jan 2023 18:27:58 -0500
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB48B49B
        for <linux-block@vger.kernel.org>; Mon,  9 Jan 2023 15:27:57 -0800 (PST)
Received: by mail-pf1-f170.google.com with SMTP id h7so3223015pfq.4
        for <linux-block@vger.kernel.org>; Mon, 09 Jan 2023 15:27:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VTWtv50Jtxyv1f5j/Gay7tfPjI4FYKNdpnJ4KOOz+hI=;
        b=sJAHTHSB2LbIHJKH6D15a0HMOnbM2VyAKuvAOSqLt2gpuedAR7ZmuezKRvJRovg1W2
         X5DvFPv/ZI2BRNzc4AUof0VB5xDuUPosMFC0/W32BBM1UnVBXvpiMb+eXTOuczCX6N33
         GW2rMh/ODlhNI6WyZNbCIckCgXFssBrq53dJK6FuLigRjE4Xk25P/MDcj173/S1B07i/
         M4ZWzB/U9RImBoQlK/sQrhiL79jV5XzRZPhytXKCRPJrfQhZ2sWJEJlo0qQ/PS20U69s
         LlMPqePpRo59YYkGfEc28JGPTunwuBxwbBoukbfu1kC5y/bPmFsoGjySNrLYHQ8ymCwq
         zGdA==
X-Gm-Message-State: AFqh2kraCDp1wl+qhWhZawTmZ5Pt+JMxRUEEqvUP0ZaZHtRcPz8Dw+p3
        MVZDNNw9N0hWwJ+be3vrY/6qGDwe+bE=
X-Google-Smtp-Source: AMrXdXsOLkK3kGqXmlfmjW5YlILZhjRPZKCt+avP/5yZQ5m5REfVOC/GRBr99tDG7JfoEQ+naeTMXw==
X-Received: by 2002:a05:6a00:400e:b0:577:9807:543b with SMTP id by14-20020a056a00400e00b005779807543bmr74003698pfb.16.1673306877192;
        Mon, 09 Jan 2023 15:27:57 -0800 (PST)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:9f06:14dd:484f:e55c])
        by smtp.gmail.com with ESMTPSA id s2-20020a625e02000000b0057ef155103asm5032244pfb.155.2023.01.09.15.27.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 15:27:56 -0800 (PST)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: [PATCH 6/8] block/null_blk: Add support for pipelining zoned writes
Date:   Mon,  9 Jan 2023 15:27:36 -0800
Message-Id: <20230109232738.169886-7-bvanassche@acm.org>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
In-Reply-To: <20230109232738.169886-1-bvanassche@acm.org>
References: <20230109232738.169886-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add a new configfs attribute for enabling pipelining of zoned writes. If
that attribute has been set, retry zoned writes that are not aligned with
the write pointer. The test script below reports 234 K IOPS with no I/O
scheduler, 5.32 K IOPS with mq-deadline and pipelining disabled and 92.2 K
IOPS with mq-deadline and pipelining enabled. This shows that pipelining
results in about 17 times more IOPS for this particular test case.

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
index d401230b1e20..851b55b7284f 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -424,6 +424,7 @@ NULLB_DEVICE_ATTR(zone_capacity, ulong, NULL);
 NULLB_DEVICE_ATTR(zone_nr_conv, uint, NULL);
 NULLB_DEVICE_ATTR(zone_max_open, uint, NULL);
 NULLB_DEVICE_ATTR(zone_max_active, uint, NULL);
+NULLB_DEVICE_ATTR(pipeline_zoned_writes, bool, NULL);
 NULLB_DEVICE_ATTR(virt_boundary, bool, NULL);
 NULLB_DEVICE_ATTR(no_sched, bool, NULL);
 NULLB_DEVICE_ATTR(shared_tag_bitmap, bool, NULL);
@@ -569,6 +570,7 @@ static struct configfs_attribute *nullb_device_attrs[] = {
 	&nullb_device_attr_zone_max_active,
 	&nullb_device_attr_zone_readonly,
 	&nullb_device_attr_zone_offline,
+	&nullb_device_attr_pipeline_zoned_writes,
 	&nullb_device_attr_virt_boundary,
 	&nullb_device_attr_no_sched,
 	&nullb_device_attr_shared_tag_bitmap,
@@ -1677,6 +1679,11 @@ static blk_status_t null_queue_rq(struct blk_mq_hw_ctx *hctx,
 	cmd->error = BLK_STS_OK;
 	cmd->nq = nq;
 	cmd->fake_timeout = should_timeout_request(rq);
+	if (!(rq->rq_flags & RQF_DONTPREP)) {
+		rq->rq_flags |= RQF_DONTPREP;
+		cmd->retries = 0;
+		cmd->max_attempts = rq->q->nr_requests;
+	}
 
 	blk_mq_start_request(rq);
 
@@ -2109,6 +2116,8 @@ static int null_add_dev(struct nullb_device *dev)
 	nullb->q->queuedata = nullb;
 	blk_queue_flag_set(QUEUE_FLAG_NONROT, nullb->q);
 	blk_queue_flag_clear(QUEUE_FLAG_ADD_RANDOM, nullb->q);
+	if (dev->pipeline_zoned_writes)
+		blk_queue_flag_set(QUEUE_FLAG_PIPELINE_ZONED_WRITES, nullb->q);
 
 	mutex_lock(&lock);
 	rv = ida_simple_get(&nullb_indexes, 0, 0, GFP_KERNEL);
diff --git a/drivers/block/null_blk/null_blk.h b/drivers/block/null_blk/null_blk.h
index eb5972c50be8..c44c3fdb1025 100644
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
 	bool no_sched; /* no IO scheduler for the device */
 	bool shared_tag_bitmap; /* use hostwide shared tags */
diff --git a/drivers/block/null_blk/zoned.c b/drivers/block/null_blk/zoned.c
index 635ce0648133..cffc4985a7df 100644
--- a/drivers/block/null_blk/zoned.c
+++ b/drivers/block/null_blk/zoned.c
@@ -405,7 +405,18 @@ static blk_status_t null_zone_write(struct nullb_cmd *cmd, sector_t sector,
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
 
