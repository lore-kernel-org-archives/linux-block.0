Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8DD8C433F5
	for <linux-block@archiver.kernel.org>; Fri, 14 Jan 2022 15:59:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235921AbiANP7F (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 14 Jan 2022 10:59:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243051AbiANP7A (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Jan 2022 10:59:00 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37525C06161C
        for <linux-block@vger.kernel.org>; Fri, 14 Jan 2022 07:59:00 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id w26so7075310wmi.0
        for <linux-block@vger.kernel.org>; Fri, 14 Jan 2022 07:59:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=szw02yiK6W7tpFgSfwd3kajTRZIxL193SsZX0/IZf0Y=;
        b=awoHZAzqy0dI0bh2d9Neqnja9z5Yjg90dsUbQypA6oSb4jwdywDqVpzoNCi1ZGNqVe
         GHaezCl5X2uh2V1kX5g5AvnN25Mkfp2pIN6TUb0qBPXUSlBQKw3JG3UePEsROPQ7li7O
         dwc+UhZo8EdA1BXzUGekW5EqcvAlyddlmI504vxeX0AFuDpwkNhB8HcRisap7fAdovV1
         s9dYjrba1vaYop58d9ZTsHPIgtuGbBTz4gNKUW6LHZLTHUidoO0yHl2Wgb7jRwvdmGCE
         NLljQHhs1OD327MX3l4uZSm2dqN0dnJ6kd2kbniSSSC7RkGy/ShTTkh5sgPT1QHeKDIO
         0M0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=szw02yiK6W7tpFgSfwd3kajTRZIxL193SsZX0/IZf0Y=;
        b=S4ynzFt3+4r2zZdFr71u7WBO2rYKkGIRqu5JV84cjkUHzWPpD77EOB4FfAyN81oFk9
         qx7a5FVl0MQXNZv8udAsqVOZW3W3LvqCm7rW62oJ6F1wt5CNyakUjdcglyk6zKGZ9uc6
         mWCeXuvh78exTFkV+l1XRC0eCu0blLV1mPMD0wRCRaqgshyHZgxJcTAmDArVjDtIvVIO
         cyDIGJKfMgk2ZQANNzdwnWtkKo2MQ/U9dU4W/P8RbokpXnZx4GD3EfQ/mJytHPBewRuw
         Cnn9uPEXEtroRr849F8IhWG+NpG825MepFvQF3c4jWBlEve88tGQKdkSGItCS/og+tpr
         IkIg==
X-Gm-Message-State: AOAM532WRV7NcqEIV280GO7zn8jz1QnKoheZRpmKWp1Adk+oxdlCINMO
        xIHUl23ZvEr84i1AcieFYG0xfH33v/Du9A==
X-Google-Smtp-Source: ABdhPJwDKOR+cpkeEIVRE84nu9Mg0ZWUiH5CyKQTVpjBcr5pGNDnchY/mcUHuzC8JI8qj8LnVb72/w==
X-Received: by 2002:aa7:dc15:: with SMTP id b21mr9295760edu.237.1642175938816;
        Fri, 14 Jan 2022 07:58:58 -0800 (PST)
Received: from lb01533.fkb.profitbricks.net ([85.214.13.132])
        by smtp.gmail.com with ESMTPSA id j5sm1930246ejo.171.2022.01.14.07.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jan 2022 07:58:58 -0800 (PST)
From:   Md Haris Iqbal <haris.iqbal@ionos.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCH for-next 2/2] block/rnbd: client device does not care queue/rotational
Date:   Fri, 14 Jan 2022 16:58:55 +0100
Message-Id: <20220114155855.984144-3-haris.iqbal@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220114155855.984144-1-haris.iqbal@ionos.com>
References: <20220114155855.984144-1-haris.iqbal@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Gioh Kim <gi-oh.kim@ionos.com>

On client side, the device is a network device. There is no reason
to set rotational even-if the target device on server is rotational.

Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
---
 drivers/block/rnbd/rnbd-clt.c   | 11 ++++++-----
 drivers/block/rnbd/rnbd-clt.h   |  1 -
 drivers/block/rnbd/rnbd-proto.h |  4 ++--
 drivers/block/rnbd/rnbd-srv.c   |  1 -
 4 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.c
index 8c24d3dfe35f..6ace401baf8a 100644
--- a/drivers/block/rnbd/rnbd-clt.c
+++ b/drivers/block/rnbd/rnbd-clt.c
@@ -87,7 +87,6 @@ static int rnbd_clt_set_dev_attr(struct rnbd_clt_dev *dev,
 	dev->discard_granularity    = le32_to_cpu(rsp->discard_granularity);
 	dev->discard_alignment	    = le32_to_cpu(rsp->discard_alignment);
 	dev->secure_discard	    = le16_to_cpu(rsp->secure_discard);
-	dev->rotational		    = rsp->rotational;
 	dev->wc			    = !!(rsp->cache_policy & RNBD_WRITEBACK);
 	dev->fua		    = !!(rsp->cache_policy & RNBD_FUA);
 
@@ -1410,8 +1409,10 @@ static int rnbd_clt_setup_gen_disk(struct rnbd_clt_dev *dev, int idx)
 		dev->read_only = false;
 	}
 
-	if (!dev->rotational)
-		blk_queue_flag_set(QUEUE_FLAG_NONROT, dev->queue);
+	/*
+	 * Network device does not need rotational
+	 */
+	blk_queue_flag_set(QUEUE_FLAG_NONROT, dev->queue);
 	err = add_disk(dev->gd);
 	if (err)
 		blk_cleanup_disk(dev->gd);
@@ -1610,13 +1611,13 @@ struct rnbd_clt_dev *rnbd_clt_map_device(const char *sessname,
 	}
 
 	rnbd_clt_info(dev,
-		       "map_device: Device mapped as %s (nsectors: %zu, logical_block_size: %d, physical_block_size: %d, max_write_same_sectors: %d, max_discard_sectors: %d, discard_granularity: %d, discard_alignment: %d, secure_discard: %d, max_segments: %d, max_hw_sectors: %d, rotational: %d, wc: %d, fua: %d)\n",
+		       "map_device: Device mapped as %s (nsectors: %zu, logical_block_size: %d, physical_block_size: %d, max_write_same_sectors: %d, max_discard_sectors: %d, discard_granularity: %d, discard_alignment: %d, secure_discard: %d, max_segments: %d, max_hw_sectors: %d, wc: %d, fua: %d)\n",
 		       dev->gd->disk_name, dev->nsectors,
 		       dev->logical_block_size, dev->physical_block_size,
 		       dev->max_write_same_sectors, dev->max_discard_sectors,
 		       dev->discard_granularity, dev->discard_alignment,
 		       dev->secure_discard, dev->max_segments,
-		       dev->max_hw_sectors, dev->rotational, dev->wc, dev->fua);
+		       dev->max_hw_sectors, dev->wc, dev->fua);
 
 	mutex_unlock(&dev->lock);
 	rnbd_clt_put_sess(sess);
diff --git a/drivers/block/rnbd/rnbd-clt.h b/drivers/block/rnbd/rnbd-clt.h
index 9ef8c4f306f2..715e616b8a91 100644
--- a/drivers/block/rnbd/rnbd-clt.h
+++ b/drivers/block/rnbd/rnbd-clt.h
@@ -118,7 +118,6 @@ struct rnbd_clt_dev {
 	enum rnbd_access_mode	access_mode;
 	u32			nr_poll_queues;
 	bool			read_only;
-	bool			rotational;
 	bool			wc;
 	bool			fua;
 	u32			max_hw_sectors;
diff --git a/drivers/block/rnbd/rnbd-proto.h b/drivers/block/rnbd/rnbd-proto.h
index de5d5a8df81d..c4a68b3a1cbe 100644
--- a/drivers/block/rnbd/rnbd-proto.h
+++ b/drivers/block/rnbd/rnbd-proto.h
@@ -128,7 +128,7 @@ enum rnbd_cache_policy {
  * @logical_block_size: logical block size device supports in bytes
  * @max_segments:	max segments hardware support in one transfer
  * @secure_discard:	supports secure discard
- * @rotation:		is a rotational disc?
+ * @obsolete_rotational: obsolete, not in used.
  * @cache_policy: 	support write-back caching or FUA?
  */
 struct rnbd_msg_open_rsp {
@@ -144,7 +144,7 @@ struct rnbd_msg_open_rsp {
 	__le16			logical_block_size;
 	__le16			max_segments;
 	__le16			secure_discard;
-	u8			rotational;
+	u8			obsolete_rotational;
 	u8			cache_policy;
 	u8			reserved[10];
 };
diff --git a/drivers/block/rnbd/rnbd-srv.c b/drivers/block/rnbd/rnbd-srv.c
index aafecfe97055..4f5d919f3760 100644
--- a/drivers/block/rnbd/rnbd-srv.c
+++ b/drivers/block/rnbd/rnbd-srv.c
@@ -568,7 +568,6 @@ static void rnbd_srv_fill_msg_open_rsp(struct rnbd_msg_open_rsp *rsp,
 		cpu_to_le32(rnbd_dev_get_discard_alignment(rnbd_dev));
 	rsp->secure_discard =
 		cpu_to_le16(rnbd_dev_get_secure_discard(rnbd_dev));
-	rsp->rotational = !blk_queue_nonrot(q);
 	rsp->cache_policy = 0;
 	if (test_bit(QUEUE_FLAG_WC, &q->queue_flags))
 		rsp->cache_policy |= RNBD_WRITEBACK;
-- 
2.25.1

