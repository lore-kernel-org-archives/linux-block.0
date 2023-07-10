Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CA61EB64D9
	for <linux-block@archiver.kernel.org>; Mon, 10 Jul 2023 18:02:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231585AbjGJSCu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Jul 2023 14:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232397AbjGJSCt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Jul 2023 14:02:49 -0400
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23A70AB
        for <linux-block@vger.kernel.org>; Mon, 10 Jul 2023 11:02:42 -0700 (PDT)
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-51b4ef5378bso3541364a12.1
        for <linux-block@vger.kernel.org>; Mon, 10 Jul 2023 11:02:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689012161; x=1691604161;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w2J3/6TQmJEZYTGRB9SMk/+oE4pHEwlR8798avx4KTw=;
        b=MngRVTOEL6LphsH+sBRrEbBQtQXsPgGxUMJ1nDCLOTMHh9bapjri7kAres+B+3ESUx
         47z0vBdsFaf//FJsjjYCbMcgDqQCSmDS/QmVsS/Ds7hbM9w6GdCNtDuCom4hkEAQR5Vx
         yVyPWDmSw+FrkFdU+pX7EHvp0kcjzqKLj5qQcIgxLlWyKWYCDIfa/4dGx/qnE60nl18K
         xUkIrHInpltY6bLCxq8JJ37DVdIEm9cWipc1Sw9ZqYRblfEapGYgOHr7lbbgSggfcntY
         nPyze6KBYO9262OZuN9d1oVAP/YiJATw0ZMVwyhnETjL14Whwe4xRkGYvQu2VKf4BeES
         Zyuw==
X-Gm-Message-State: ABy/qLY85LlwvphCu7X8BHdTGjNpTvzhjaPML8QGhPvECJupLxAqW1/q
        u4wuqv2jQ0cS2m0zWXJwwcM=
X-Google-Smtp-Source: APBJJlFs8Niu66WJ5ndYLBlGYA5i6v1Fpb6xkfE4vpqxbqKGC3aTN/nG2rlRdavoxPVHkg4256Hr2g==
X-Received: by 2002:a17:90a:5218:b0:262:f872:fa77 with SMTP id v24-20020a17090a521800b00262f872fa77mr10829024pjh.31.1689012161266;
        Mon, 10 Jul 2023 11:02:41 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:e582:53b1:a691:ab70])
        by smtp.gmail.com with ESMTPSA id gt4-20020a17090af2c400b00263f446d432sm6531846pjb.43.2023.07.10.11.02.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 11:02:40 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Vincent Fu <vincent.fu@samsung.com>,
        "Shin'ichiro Kawasaki" <shinichiro.kawasaki@wdc.com>,
        Akinobu Mita <akinobu.mita@gmail.com>
Subject: [PATCH v2 3/5] block/null_blk: Add support for pipelining zoned writes
Date:   Mon, 10 Jul 2023 11:01:40 -0700
Message-ID: <20230710180210.1582299-4-bvanassche@acm.org>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
In-Reply-To: <20230710180210.1582299-1-bvanassche@acm.org>
References: <20230710180210.1582299-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add a new configfs attribute for enabling pipelining of zoned writes.
The test script below reports 250 K IOPS with no I/O scheduler, 6 K IOPS
with mq-deadline and pipelining disabled and 123 K IOPS with mq-deadline
and pipelining enabled. This shows that pipelining results in about 20
times more IOPS for this particular test case.

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
 drivers/block/null_blk/main.c     | 2 ++
 drivers/block/null_blk/null_blk.h | 1 +
 drivers/block/null_blk/zoned.c    | 3 +++
 3 files changed, 6 insertions(+)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 864013019d6b..1cd6eb4e2c16 100644
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
diff --git a/drivers/block/null_blk/null_blk.h b/drivers/block/null_blk/null_blk.h
index 929f659dd255..248acf288a8e 100644
--- a/drivers/block/null_blk/null_blk.h
+++ b/drivers/block/null_blk/null_blk.h
@@ -117,6 +117,7 @@ struct nullb_device {
 	bool memory_backed; /* if data is stored in memory */
 	bool discard; /* if support discard */
 	bool zoned; /* if device is zoned */
+	bool pipeline_zoned_writes;
 	bool virt_boundary; /* virtual boundary on/off for the device */
 	bool no_sched; /* no IO scheduler for the device */
 	bool shared_tag_bitmap; /* use hostwide shared tags */
diff --git a/drivers/block/null_blk/zoned.c b/drivers/block/null_blk/zoned.c
index 635ce0648133..2bfd5f7cee67 100644
--- a/drivers/block/null_blk/zoned.c
+++ b/drivers/block/null_blk/zoned.c
@@ -96,6 +96,9 @@ int null_init_zoned_dev(struct nullb_device *dev, struct request_queue *q)
 
 	spin_lock_init(&dev->zone_res_lock);
 
+	if (dev->pipeline_zoned_writes)
+		blk_queue_flag_set(QUEUE_FLAG_PIPELINE_ZONED_WRITES, q);
+
 	if (dev->zone_nr_conv >= dev->nr_zones) {
 		dev->zone_nr_conv = dev->nr_zones - 1;
 		pr_info("changed the number of conventional zones to %u",
