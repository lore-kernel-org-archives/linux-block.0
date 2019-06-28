Return-Path: <SRS0=XMJ3=U3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87591C4321A
	for <linux-block@archiver.kernel.org>; Fri, 28 Jun 2019 20:08:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63596208C4
	for <linux-block@archiver.kernel.org>; Fri, 28 Jun 2019 20:08:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbfF1UIA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 Jun 2019 16:08:00 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41575 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726809AbfF1UIA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Jun 2019 16:08:00 -0400
Received: by mail-pf1-f193.google.com with SMTP id m30so3515572pff.8
        for <linux-block@vger.kernel.org>; Fri, 28 Jun 2019 13:08:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ek8qE1fiI2toyR6h4GSeKfgpYT40/3E34bwIIlJLMOg=;
        b=ecWeQ8OYbdfLgWfyfqB4lbidfwi0yGSgMyaqjgavf3cROyrE+F2+bMg9ihal5HK1h5
         3ewokUj1zwKjbqnf88NL2BdZyt5XeOYwO3qyDqXUrmDaXPKj7n8kSRlaejolN6dBYQ+l
         PxF6suodRDBLEMWjhhiuPyk16wjynmDgbBBXNazp7ngWK3edI9WVL/r2ZmS5rRl9GKVi
         A2IObBj+/byDOZr9t4o4e6O3BgvMsG7q9jgjxgygX5Y26uxHO/47XiN1L9Q2O+b5Avi9
         NC3Y7UgCA38xdfMsrodADtI/iBXAyABNbewMc/3FbPYNL7D5LsK5fPlD2vMBXMNuXi5z
         LkRA==
X-Gm-Message-State: APjAAAXXgtThYxLr9+vKH/EIaUi9agufgzk0/LSfR8wLd781NG1GZwxi
        FfwXN11bW5LbbE0yZXwdWW2esJ9HGxI=
X-Google-Smtp-Source: APXvYqwvj5PTsqyqvpes6Rwjurzi+eJep2spD22+QffYUj0pDXJ4sJfbkvPhBVSest1i/mW37jY3nQ==
X-Received: by 2002:a17:90a:a00d:: with SMTP id q13mr15165007pjp.80.1561752479735;
        Fri, 28 Jun 2019 13:07:59 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id 65sm1186010pff.148.2019.06.28.13.07.58
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 28 Jun 2019 13:07:58 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 4/4] block, documentation: Document discard_zeroes_data, fua, max_discard_segments and write_zeroes_max_bytes
Date:   Fri, 28 Jun 2019 13:07:45 -0700
Message-Id: <20190628200745.206110-5-bvanassche@acm.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
In-Reply-To: <20190628200745.206110-1-bvanassche@acm.org>
References: <20190628200745.206110-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 Documentation/block/queue-sysfs.txt | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/Documentation/block/queue-sysfs.txt b/Documentation/block/queue-sysfs.txt
index 1515dcf3dec4..b40b5b7cebd9 100644
--- a/Documentation/block/queue-sysfs.txt
+++ b/Documentation/block/queue-sysfs.txt
@@ -52,6 +52,16 @@ large discards are issued, setting this value lower will make Linux issue
 smaller discards and potentially help reduce latencies induced by large
 discard operations.
 
+discard_zeroes_data (RO)
+------------------------
+Obsolete. Always zero.
+
+fua (RO)
+--------
+Whether or not the block driver supports the FUA flag for write requests.
+FUA stands for Force Unit Access. If the FUA flag is set that means that
+write requests must bypass the volatile cache of the storage device.
+
 hw_sector_size (RO)
 -------------------
 This is the hardware sector size of the device, in bytes.
@@ -92,6 +102,10 @@ logical_block_size (RO)
 -----------------------
 This is the logical block size of the device, in bytes.
 
+max_discard_segments (RO)
+-------------------------
+The maximum number of DMA scatter/gather entries in a discard request.
+
 max_hw_sectors_kb (RO)
 ----------------------
 This is the maximum number of kilobytes supported in a single data transfer.
@@ -218,6 +232,12 @@ blk-throttle makes decision based on the samplings. Lower time means cgroups
 have more smooth throughput, but higher CPU overhead. This exists only when
 CONFIG_BLK_DEV_THROTTLING_LOW is enabled.
 
+write_zeroes_max_bytes (RO)
+---------------------------
+For block drivers that support REQ_OP_WRITE_ZEROES, the maximum number of
+bytes that can be zeroed at once. The value 0 means that REQ_OP_WRITE_ZEROES
+is not supported.
+
 zoned (RO)
 ----------
 This indicates if the device is a zoned block device and the zone model of the
-- 
2.22.0.410.gd8fdbe21b5-goog

