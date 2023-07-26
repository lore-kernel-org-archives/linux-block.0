Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E19F9C001DC
	for <linux-block@archiver.kernel.org>; Wed, 26 Jul 2023 19:35:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229454AbjGZTf0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Jul 2023 15:35:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbjGZTfZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Jul 2023 15:35:25 -0400
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5DE11BD9
        for <linux-block@vger.kernel.org>; Wed, 26 Jul 2023 12:35:24 -0700 (PDT)
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6686a05bc66so185302b3a.1
        for <linux-block@vger.kernel.org>; Wed, 26 Jul 2023 12:35:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690400124; x=1691004924;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0QJms5YcXrYmxRKHOnm5/t0MTK2LPWvAB4sY3WYCkgg=;
        b=jw8pOwaInslUgKOgL4ZUj2aRjzPidK6rrrjkAiYwQ/ngrjSB0GK7flr0hvKoZuOhlu
         i5TpcCwZKri2lAqLYgzP6cm1c7FNH0VBpOLF6y7h11aG1Et3dyv9enNT5C+WtslHj+VB
         KGuMRrHj2tmFGgqUzHgKAJ1q7KPHX0uVjboXsjkUWClOoFs2FSErCUptmS5v2R1kKgJu
         Nk/t9GDpkCqV+vGac1vic5JiPJmbmkn4ir3lsPFHRtyqz7eWiG3Nv0SonizWU17JHCo/
         Gh5Y1nDDu8kqUF0dFWAo72QHjx8m6onB2Cj5x6hH5b7aVh5ATxSkJETNdralRhRkk+E4
         ZF8A==
X-Gm-Message-State: ABy/qLYPZZqMsscYYJhah83WyI5P7dorUpLw3dIRYpxqD/Fl0G6jFGrj
        dHbNG1oE3OPNBycZUiiG9aE=
X-Google-Smtp-Source: APBJJlHzzJbtAKD+r8hZoZVS1wZg5/pijBTWmP7BXVswstGrNs2LOYSPWm5UPzK0FQlnHP8NKUM6wA==
X-Received: by 2002:a05:6a20:7f9e:b0:132:c7de:f71c with SMTP id d30-20020a056a207f9e00b00132c7def71cmr3353038pzj.59.1690400124346;
        Wed, 26 Jul 2023 12:35:24 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:32d2:d535:b137:7ba3])
        by smtp.gmail.com with ESMTPSA id x52-20020a056a000bf400b00682ba300cd1sm11846685pfu.29.2023.07.26.12.35.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 12:35:23 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Vincent Fu <vincent.fu@samsung.com>,
        Keith Busch <kbusch@kernel.org>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        "Shin'ichiro Kawasaki" <shinichiro.kawasaki@wdc.com>
Subject: [PATCH v4 4/7] block/null_blk: Support disabling zone write locking
Date:   Wed, 26 Jul 2023 12:34:08 -0700
Message-ID: <20230726193440.1655149-5-bvanassche@acm.org>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
In-Reply-To: <20230726193440.1655149-1-bvanassche@acm.org>
References: <20230726193440.1655149-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add a new configfs attribute for disabling zone write locking. Tests
show a performance of 250 K IOPS with no I/O scheduler, 6 K IOPS with
mq-deadline and write locking enabled and 123 K IOPS with mq-deadline
and write locking disabled. This shows that disabling write locking
results in about 20 times more IOPS for this particular test case.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Damien Le Moal <dlemoal@kernel.org>
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
