Return-Path: <SRS0=XMJ3=U3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 910BAC4321A
	for <linux-block@archiver.kernel.org>; Fri, 28 Jun 2019 20:07:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D6F4208C4
	for <linux-block@archiver.kernel.org>; Fri, 28 Jun 2019 20:07:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbfF1UH6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 Jun 2019 16:07:58 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35754 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726809AbfF1UH5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Jun 2019 16:07:57 -0400
Received: by mail-pg1-f193.google.com with SMTP id s27so3064922pgl.2
        for <linux-block@vger.kernel.org>; Fri, 28 Jun 2019 13:07:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ystmvT3hcHG5GcUUUJ7CBMWhBvBULg4zwoaXWWT5Oy0=;
        b=XSz6Nxpr6Xq9xGHXu4548I/e92oA43vkqz9ePcNnqUfgPTDug01Kk6KUI3YqCVI+Ac
         hsyHbZRk3RXaltgTWfgEUGr0DqvX6k14nCSsjHU0qMtCwUmNAli1iMbhvvxb8nxLM/5S
         +2vKy9WOoFmqcP4nW0TxsPf2Yxf9zU5dKLb/bs44u09SD/Wfqo86eE9TjMkeritt8fcc
         mRyTuUlDlzbMGgfCZxb7OM0eFF+IyHzpfu4WKBA+3AVwkQu7jNl0VXxl6D/p4DpSQHOb
         sDm9KPAJBnfkX8DyrgBiV6AQQfkqJhpTeN7W3ZKLMBZ8oEWYlw3AGTOugmE56+vOF7OQ
         K2/g==
X-Gm-Message-State: APjAAAWR7EF+Dld30Tb7DX33M97bkfvtpR0r/A1w1WpAs5ytErHFY2yL
        v4gAIgcvayEqOtogW48V7ykfoucMRik=
X-Google-Smtp-Source: APXvYqy8pFMNA0ND1tyaHpe1SFbWHAujdHfmTh9AQFryvR0m9wqOD3l5i2IDXIU3lYbyeEc/THQlOg==
X-Received: by 2002:a63:2f44:: with SMTP id v65mr10752921pgv.185.1561752477045;
        Fri, 28 Jun 2019 13:07:57 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id 65sm1186010pff.148.2019.06.28.13.07.55
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 28 Jun 2019 13:07:55 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@wdc.com>
Subject: [PATCH 2/4] block, documentation: Sort queue sysfs attribute names alphabetically
Date:   Fri, 28 Jun 2019 13:07:43 -0700
Message-Id: <20190628200745.206110-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
In-Reply-To: <20190628200745.206110-1-bvanassche@acm.org>
References: <20190628200745.206110-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Commit f9824952ee1c ("block: update sysfs documentation") # v5.0 broke the
alphabetical order of the sysfs attribute names. List queue sysfs attribute
names alphabetically.

Cc: Damien Le Moal <damien.lemoal@wdc.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 Documentation/block/queue-sysfs.txt | 30 ++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/Documentation/block/queue-sysfs.txt b/Documentation/block/queue-sysfs.txt
index 3eaf86806621..f6da2efe2105 100644
--- a/Documentation/block/queue-sysfs.txt
+++ b/Documentation/block/queue-sysfs.txt
@@ -14,6 +14,15 @@ add_random (RW)
 This file allows to turn off the disk entropy contribution. Default
 value of this file is '1'(on).
 
+chunk_sectors (RO)
+------------------
+This has different meaning depending on the type of the block device.
+For a RAID device (dm-raid), chunk_sectors indicates the size in 512B sectors
+of the RAID volume stripe segment. For a zoned block device, either host-aware
+or host-managed, chunk_sectors indicates the size in 512B sectors of the zones
+of the device, with the eventual exception of the last zone of the device which
+may be smaller.
+
 dax (RO)
 --------
 This file indicates whether the device supports Direct Access (DAX),
@@ -132,6 +141,12 @@ per-block-cgroup request pool.  IOW, if there are N block cgroups,
 each request queue may have up to N request pools, each independently
 regulated by nr_requests.
 
+nr_zones (RO)
+-------------
+For zoned block devices (zoned attribute indicating "host-managed" or
+"host-aware"), this indicates the total number of zones of the device.
+This is always 0 for regular block devices.
+
 optimal_io_size (RO)
 --------------------
 This is the optimal IO size reported by the device.
@@ -213,19 +228,4 @@ devices are described in the ZBC (Zoned Block Commands) and ZAC
 do not support zone commands, they will be treated as regular block devices
 and zoned will report "none".
 
-nr_zones (RO)
--------------
-For zoned block devices (zoned attribute indicating "host-managed" or
-"host-aware"), this indicates the total number of zones of the device.
-This is always 0 for regular block devices.
-
-chunk_sectors (RO)
-------------------
-This has different meaning depending on the type of the block device.
-For a RAID device (dm-raid), chunk_sectors indicates the size in 512B sectors
-of the RAID volume stripe segment. For a zoned block device, either host-aware
-or host-managed, chunk_sectors indicates the size in 512B sectors of the zones
-of the device, with the eventual exception of the last zone of the device which
-may be smaller.
-
 Jens Axboe <jens.axboe@oracle.com>, February 2009
-- 
2.22.0.410.gd8fdbe21b5-goog

