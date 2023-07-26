Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E87F7EB64DD
	for <linux-block@archiver.kernel.org>; Wed, 26 Jul 2023 00:58:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbjGZA6E (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 Jul 2023 20:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjGZA6D (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Jul 2023 20:58:03 -0400
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F36C612E
        for <linux-block@vger.kernel.org>; Tue, 25 Jul 2023 17:58:01 -0700 (PDT)
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-666ecb21f86so5753262b3a.3
        for <linux-block@vger.kernel.org>; Tue, 25 Jul 2023 17:58:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690333081; x=1690937881;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uuKws2rBoncGscGCPbcpPhXe4qyr3T65eDTeSQZyG68=;
        b=LZgK5FZu2ySzQ/gv0HmQZDsvTsZntZRXgztUG9e05ZCNP7buhMnSAypVfUAwRZDkjc
         JHBqh0fhZPs/c/MbEPkIoKIHfFlFhpOO5WNzYJiRGGk77a+n1GGMb3DRg0iAiALc4q+Q
         WxgspM6ihVAdUJAZruKAPCz6sqdEEAUZ+Pcsh78btem8h7SQdl+6x/yMn7Wl5Rtf1KKe
         EdPy51CZ8HgavAigoUTpzUk1lY1u6xdEhf+MhZYTlKihdsHjKxgeM4Nm5XFtdG6R9YHZ
         +rnLMtCJ2aGIos0/LJ0CwQQfzxNOOpBnAb8OmDp383MtN8Ew5Wtbet9HQcMaV7jUKJ+x
         q3iQ==
X-Gm-Message-State: ABy/qLbJtIOQqshyL9tro99pCjkiWWxLE/50/0ENk2LmmhGnW5HvWEPa
        wal5dF64B48yNBb3wdiZzD0=
X-Google-Smtp-Source: APBJJlG34VH3g6xF1HXezotWfbdYQa9II/4DmCAZ+w6xZjq5GBhLcetlMboWFzv0Wmk1klJ/pPV/pA==
X-Received: by 2002:a05:6a00:a06:b0:64c:4f2f:a235 with SMTP id p6-20020a056a000a0600b0064c4f2fa235mr1103214pfh.30.1690333081316;
        Tue, 25 Jul 2023 17:58:01 -0700 (PDT)
Received: from bvanassche-glaptop2.roam.corp.google.com ([2601:642:4c05:4a8d:dbda:6b13:2798:9795])
        by smtp.gmail.com with ESMTPSA id t10-20020a63954a000000b005634bd81331sm11090138pgn.72.2023.07.25.17.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 17:58:00 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ming Lei <ming.lei@redhat.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        Nitesh Shetty <nj.shetty@samsung.com>,
        Vincent Fu <vincent.fu@samsung.com>,
        Dan Carpenter <error27@gmail.com>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        "Shin'ichiro Kawasaki" <shinichiro.kawasaki@wdc.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v3 3/6] block/null_blk: Support disabling zone write locking
Date:   Tue, 25 Jul 2023 17:57:27 -0700
Message-ID: <20230726005742.303865-4-bvanassche@acm.org>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
In-Reply-To: <20230726005742.303865-1-bvanassche@acm.org>
References: <20230726005742.303865-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add a new configfs attribute for disabling zone write locking. The test
script below reports 250 K IOPS with no I/O scheduler, 6 K IOPS with
mq-deadline and write locking enabled and 123 K IOPS with mq-deadline
and write locking disabled. This shows that disabling write locking
results in about 20 times more IOPS for this particular test case.

    #!/bin/bash

    for mode in "none 0" "mq-deadline 0" "mq-deadline 1"; do
        set +e
        for d in /sys/kernel/config/nullb/*; do
            [ -d "$d" ] && rmdir "$d"
        done
        modprobe -r null_blk
        set -e
        read -r iosched no_write_locking <<<"$mode"
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
                no_zone_write_lock="${no_write_locking}"
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

Cc: Christoph Hellwig <hch@lst.de>
Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/block/null_blk/main.c     | 2 ++
 drivers/block/null_blk/null_blk.h | 1 +
 drivers/block/null_blk/zoned.c    | 3 +++
 3 files changed, 6 insertions(+)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 864013019d6b..5c0578137f51 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -424,6 +424,7 @@ NULLB_DEVICE_ATTR(zone_capacity, ulong, NULL);
 NULLB_DEVICE_ATTR(zone_nr_conv, uint, NULL);
 NULLB_DEVICE_ATTR(zone_max_open, uint, NULL);
 NULLB_DEVICE_ATTR(zone_max_active, uint, NULL);
+NULLB_DEVICE_ATTR(no_zone_write_lock, bool, NULL);
 NULLB_DEVICE_ATTR(virt_boundary, bool, NULL);
 NULLB_DEVICE_ATTR(no_sched, bool, NULL);
 NULLB_DEVICE_ATTR(shared_tag_bitmap, bool, NULL);
@@ -569,6 +570,7 @@ static struct configfs_attribute *nullb_device_attrs[] = {
 	&nullb_device_attr_zone_max_active,
 	&nullb_device_attr_zone_readonly,
 	&nullb_device_attr_zone_offline,
+	&nullb_device_attr_no_zone_write_lock,
 	&nullb_device_attr_virt_boundary,
 	&nullb_device_attr_no_sched,
 	&nullb_device_attr_shared_tag_bitmap,
diff --git a/drivers/block/null_blk/null_blk.h b/drivers/block/null_blk/null_blk.h
index 929f659dd255..b521096bcc3f 100644
--- a/drivers/block/null_blk/null_blk.h
+++ b/drivers/block/null_blk/null_blk.h
@@ -117,6 +117,7 @@ struct nullb_device {
 	bool memory_backed; /* if data is stored in memory */
 	bool discard; /* if support discard */
 	bool zoned; /* if device is zoned */
+	bool no_zone_write_lock;
 	bool virt_boundary; /* virtual boundary on/off for the device */
 	bool no_sched; /* no IO scheduler for the device */
 	bool shared_tag_bitmap; /* use hostwide shared tags */
diff --git a/drivers/block/null_blk/zoned.c b/drivers/block/null_blk/zoned.c
index 55c5b48bc276..31c8364a63e9 100644
--- a/drivers/block/null_blk/zoned.c
+++ b/drivers/block/null_blk/zoned.c
@@ -96,6 +96,9 @@ int null_init_zoned_dev(struct nullb_device *dev, struct request_queue *q)
 
 	spin_lock_init(&dev->zone_res_lock);
 
+	if (dev->no_zone_write_lock)
+		blk_queue_flag_set(QUEUE_FLAG_NO_ZONE_WRITE_LOCK, q);
+
 	if (dev->zone_nr_conv >= dev->nr_zones) {
 		dev->zone_nr_conv = dev->nr_zones - 1;
 		pr_info("changed the number of conventional zones to %u",
