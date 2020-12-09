Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FE04C433FE
	for <linux-block@archiver.kernel.org>; Wed,  9 Dec 2020 08:22:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1421923B97
	for <linux-block@archiver.kernel.org>; Wed,  9 Dec 2020 08:22:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725997AbgLIIWP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Dec 2020 03:22:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbgLIIWP (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Dec 2020 03:22:15 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 320C5C0617A6
        for <linux-block@vger.kernel.org>; Wed,  9 Dec 2020 00:20:59 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id d17so825060ejy.9
        for <linux-block@vger.kernel.org>; Wed, 09 Dec 2020 00:20:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CA2w/lh8ZkqeTZgM/LEMkBOMEtxjc9/IiyW2kEytwok=;
        b=IzIoKlPKjezOrSWhINuQARrCH4wL2jNfYKv1y2X9NCvQI+KEIhXKObFz+0IqsXCzda
         LIhldRUEKuQ/F8ENOzmchr2/qqKLMtZG6Vf0ZcewZtUqC47R7ppPabcuw87NUWMGak9Y
         KNHgWVI+nx4ikZihv+QFD1WHGK3MD4i4w7q4BH31d4NZs6ehFKyq4LzBxAHP1l+OFPK0
         9rcZhsf2jJs9ro8HOta/7vaH2beq5Eo3EyAmx0kNp8FMY4bdOVuFKpu+eKZex1kYvOjt
         H1SItUo4vvN3ICHYLEgX89wbiCDBCwlmGZC3tV1hHlSQ5X93mewLM4DV0F3BORVDRJO6
         iqhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CA2w/lh8ZkqeTZgM/LEMkBOMEtxjc9/IiyW2kEytwok=;
        b=Y6UOlVVHzb7r72cVJS17xY/DvwU6Uk65b7g0bGT/9pChLf++R0+JTtyi8zIB15Kq88
         p5wZO/yQWxfE//ies44izGeyF4RZsWOOXyueS/u3njPeOVflUn3D/Dsl7OIT79+ZLn8A
         BvfHgOQrp3E8/OTgCiPN7t5SjjzocCXg44dxsuCzkHVv+mq2DybCg+BxkXNI29URrOMs
         siKFdQGl2OZiZth4OFL7hITS0AS54stXF6ogE2ZNDksSk9CCNfocpTxgyr9RZofDICOA
         mWCTGV96qGaLUS14yt+EziYIchXvOFPWxt/+k2/LveeSs6NubZ6nJ+y4mMgodaesP2ZW
         FkjQ==
X-Gm-Message-State: AOAM531tsbiWxdDfI156UmqFlqZ7nR3sseVONdINnipEilxFNr2vPpXg
        RYq+UAfKYbIg9YWA5ybLvWsxDCV3Dd0MfQ==
X-Google-Smtp-Source: ABdhPJzztrAF4g2a5Zo2pZGeaqNTXNMozVoMrUZ6ZPGtYXA3vGmfKyhGf/u91ZnXoSWnUSHu4rk8rw==
X-Received: by 2002:a17:906:2857:: with SMTP id s23mr1082751ejc.218.1607502057771;
        Wed, 09 Dec 2020 00:20:57 -0800 (PST)
Received: from jwang-Latitude-5491.fkb.profitbricks.net ([2001:16b8:49e0:2500:1d14:118d:b29c:98ec])
        by smtp.gmail.com with ESMTPSA id cf17sm823225edb.16.2020.12.09.00.20.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 00:20:57 -0800 (PST)
From:   Jack Wang <jinpu.wang@cloud.ionos.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, danil.kipnis@cloud.ionos.com,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>
Subject: [PATCH for-next 5/7] block/rnbd: Set write-back cache and fua same to the target device
Date:   Wed,  9 Dec 2020 09:20:49 +0100
Message-Id: <20201209082051.12306-6-jinpu.wang@cloud.ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201209082051.12306-1-jinpu.wang@cloud.ionos.com>
References: <20201209082051.12306-1-jinpu.wang@cloud.ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Gioh Kim <gi-oh.kim@cloud.ionos.com>

The rnbd-client always sets the write-back cache and fua attributes
of the rnbd device queue regardless of the target device on the server.
That generates IO hang issue when the target device does not
support both of write-back cacne and fua.

This patch adds more fields for the cache policy and fua into the
device opening message. The rnbd-server sends the information
if the target device supports the write-back cache and fua
and rnbd-client recevives it and set the device queue accordingly.

Signed-off-by: Gioh Kim <gi-oh.kim@cloud.ionos.com>
[jwang: some minor change, rename a few varables, remove unrelated comments.]
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
---
 drivers/block/rnbd/rnbd-clt.c   | 8 +++++---
 drivers/block/rnbd/rnbd-clt.h   | 2 ++
 drivers/block/rnbd/rnbd-proto.h | 9 ++++++++-
 drivers/block/rnbd/rnbd-srv.c   | 9 +++++++--
 4 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.c
index 9641afa17095..fe8c738a1797 100644
--- a/drivers/block/rnbd/rnbd-clt.c
+++ b/drivers/block/rnbd/rnbd-clt.c
@@ -88,6 +88,8 @@ static int rnbd_clt_set_dev_attr(struct rnbd_clt_dev *dev,
 	dev->discard_alignment	    = le32_to_cpu(rsp->discard_alignment);
 	dev->secure_discard	    = le16_to_cpu(rsp->secure_discard);
 	dev->rotational		    = rsp->rotational;
+	dev->wc 		    = !!(rsp->cache_policy & RNBD_WRITEBACK);
+	dev->fua		    = !!(rsp->cache_policy & RNBD_FUA);
 
 	dev->max_hw_sectors = sess->max_io_size / SECTOR_SIZE;
 	dev->max_segments = BMAX_SEGMENTS;
@@ -1305,7 +1307,7 @@ static void setup_request_queue(struct rnbd_clt_dev *dev)
 	blk_queue_max_segments(dev->queue, dev->max_segments);
 	blk_queue_io_opt(dev->queue, dev->sess->max_io_size);
 	blk_queue_virt_boundary(dev->queue, SZ_4K - 1);
-	blk_queue_write_cache(dev->queue, true, true);
+	blk_queue_write_cache(dev->queue, dev->wc, dev->fua);
 	dev->queue->queuedata = dev;
 }
 
@@ -1530,13 +1532,13 @@ struct rnbd_clt_dev *rnbd_clt_map_device(const char *sessname,
 	}
 
 	rnbd_clt_info(dev,
-		       "map_device: Device mapped as %s (nsectors: %zu, logical_block_size: %d, physical_block_size: %d, max_write_same_sectors: %d, max_discard_sectors: %d, discard_granularity: %d, discard_alignment: %d, secure_discard: %d, max_segments: %d, max_hw_sectors: %d, rotational: %d)\n",
+		       "map_device: Device mapped as %s (nsectors: %zu, logical_block_size: %d, physical_block_size: %d, max_write_same_sectors: %d, max_discard_sectors: %d, discard_granularity: %d, discard_alignment: %d, secure_discard: %d, max_segments: %d, max_hw_sectors: %d, rotational: %d, wc: %d, fua: %d)\n",
 		       dev->gd->disk_name, dev->nsectors,
 		       dev->logical_block_size, dev->physical_block_size,
 		       dev->max_write_same_sectors, dev->max_discard_sectors,
 		       dev->discard_granularity, dev->discard_alignment,
 		       dev->secure_discard, dev->max_segments,
-		       dev->max_hw_sectors, dev->rotational);
+		       dev->max_hw_sectors, dev->rotational, dev->wc, dev->fua);
 
 	mutex_unlock(&dev->lock);
 
diff --git a/drivers/block/rnbd/rnbd-clt.h b/drivers/block/rnbd/rnbd-clt.h
index b193d5904050..efd67ae286ca 100644
--- a/drivers/block/rnbd/rnbd-clt.h
+++ b/drivers/block/rnbd/rnbd-clt.h
@@ -112,6 +112,8 @@ struct rnbd_clt_dev {
 	enum rnbd_access_mode	access_mode;
 	bool			read_only;
 	bool			rotational;
+	bool			wc;
+	bool			fua;
 	u32			max_hw_sectors;
 	u32			max_write_same_sectors;
 	u32			max_discard_sectors;
diff --git a/drivers/block/rnbd/rnbd-proto.h b/drivers/block/rnbd/rnbd-proto.h
index ca166241452c..c1bc5c0fef71 100644
--- a/drivers/block/rnbd/rnbd-proto.h
+++ b/drivers/block/rnbd/rnbd-proto.h
@@ -108,6 +108,11 @@ struct rnbd_msg_close {
 	__le32		device_id;
 };
 
+enum rnbd_cache_policy {
+	RNBD_FUA = 1 << 0,
+	RNBD_WRITEBACK = 1 << 1,
+};
+
 /**
  * struct rnbd_msg_open_rsp - response message to RNBD_MSG_OPEN
  * @hdr:		message header
@@ -124,6 +129,7 @@ struct rnbd_msg_close {
  * @max_segments:	max segments hardware support in one transfer
  * @secure_discard:	supports secure discard
  * @rotation:		is a rotational disc?
+ * @cache_policy: 	support write-back caching or FUA?
  */
 struct rnbd_msg_open_rsp {
 	struct rnbd_msg_hdr	hdr;
@@ -139,7 +145,8 @@ struct rnbd_msg_open_rsp {
 	__le16			max_segments;
 	__le16			secure_discard;
 	u8			rotational;
-	u8			reserved[11];
+	u8			cache_policy;
+	u8			reserved[10];
 };
 
 /**
diff --git a/drivers/block/rnbd/rnbd-srv.c b/drivers/block/rnbd/rnbd-srv.c
index 066411cce5e2..b8e44331e494 100644
--- a/drivers/block/rnbd/rnbd-srv.c
+++ b/drivers/block/rnbd/rnbd-srv.c
@@ -550,6 +550,7 @@ static void rnbd_srv_fill_msg_open_rsp(struct rnbd_msg_open_rsp *rsp,
 					struct rnbd_srv_sess_dev *sess_dev)
 {
 	struct rnbd_dev *rnbd_dev = sess_dev->rnbd_dev;
+	struct request_queue *q = bdev_get_queue(rnbd_dev->bdev);
 
 	rsp->hdr.type = cpu_to_le16(RNBD_MSG_OPEN_RSP);
 	rsp->device_id =
@@ -574,8 +575,12 @@ static void rnbd_srv_fill_msg_open_rsp(struct rnbd_msg_open_rsp *rsp,
 		cpu_to_le32(rnbd_dev_get_discard_alignment(rnbd_dev));
 	rsp->secure_discard =
 		cpu_to_le16(rnbd_dev_get_secure_discard(rnbd_dev));
-	rsp->rotational =
-		!blk_queue_nonrot(bdev_get_queue(rnbd_dev->bdev));
+	rsp->rotational = !blk_queue_nonrot(q);
+	rsp->cache_policy = 0;
+	if (test_bit(QUEUE_FLAG_WC, &q->queue_flags))
+		rsp->cache_policy |= RNBD_WRITEBACK;
+	if (blk_queue_fua(q))
+		rsp->cache_policy |= RNBD_FUA;
 }
 
 static struct rnbd_srv_sess_dev *
-- 
2.25.1

