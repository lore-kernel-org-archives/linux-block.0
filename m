Return-Path: <SRS0=J0qc=5I=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E936C3F2CD
	for <linux-block@archiver.kernel.org>; Mon, 23 Mar 2020 16:36:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73F8C20658
	for <linux-block@archiver.kernel.org>; Mon, 23 Mar 2020 16:36:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LXue7MQ/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727630AbgCWQfl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 23 Mar 2020 12:35:41 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46681 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727564AbgCWQfk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Mar 2020 12:35:40 -0400
Received: by mail-lj1-f193.google.com with SMTP id v16so8281762ljk.13;
        Mon, 23 Mar 2020 09:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0wrb1jawDZ/OoSKSRa4jhXauQnVpnBi/wzx5vJ7NjQo=;
        b=LXue7MQ/ynT2Qwn4Q8TkmyOyQlQ4Cl2ZdMW1YqwqkG1D/M0wI9BzolDLdIaer31yzj
         zOLwVklExyWur1HIb64j6GxGiZxeVjzi1a+yoLrxYoZ7xg6xoz2izPmpZPYWZCHCp+++
         DMjQUZPfh+SkW0G0pPW/JHkwWA7sl8Ww9IM/Y5DGKxgIINsREoSx3aVyjswp6BAO51mp
         25xipyCqLfeuv17YaDx2+uuQ2w+G1GT7u5dK0Wc9dEO0K2fc9dzxe3UZxs11U5SmFyHH
         FHjet48tQUbsfS4oZYz/67kQ6em5slQ7Ya31tnTI6xza5GuCsXmToLM5AAGAZoghr2jY
         MvWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0wrb1jawDZ/OoSKSRa4jhXauQnVpnBi/wzx5vJ7NjQo=;
        b=ZwrcqWsJD9cslX1JBE9B7brD3mHOygumUCe4VDoKMl9iLAZlYYbXULzXQ7EVbF9rr/
         qdN7SQL+2Axsfcy6p+d/v1K1bxjjTy+Ku6osWiRjW/TRp9P+nJaRrKUQXSaJYNumCciu
         X10vdp+4MCjOOKKcyHKLNekZPmfDAsmUUyBVWrA2FhzhaixpFzzETZvtSAWd74FXxO4z
         Xen1W88V0kz8vvZ4fiQol4MYbce3wjg+UVR/V4ltzIvs1X4yUe5qbCqvmOOfSAIasKIO
         5feM3zEnUtA91IoVHq1F5h04z30LqAL/0JTBrqIEtBDl0qr9ggZVHDfHVYuXUOD1nils
         eerA==
X-Gm-Message-State: ANhLgQ1pCSNB4D2geBdF0Ny42nFZL7WSEoMYPLEaUVhJ/s9SFouEynby
        nhLigY44/74h5Jx7qILNKbY=
X-Google-Smtp-Source: ADFU+vstcQ7obgecuz7XRtqThNdaDgYd6CA+FmepLrt9ZGbs/ZU6P+XLZBTC9u7wsH0SAcNbkpBItg==
X-Received: by 2002:a2e:90da:: with SMTP id o26mr14720812ljg.254.1584981338066;
        Mon, 23 Mar 2020 09:35:38 -0700 (PDT)
Received: from localhost.localdomain (94-29-39-224.dynamic.spd-mgts.ru. [94.29.39.224])
        by smtp.gmail.com with ESMTPSA id m14sm4820017lfo.25.2020.03.23.09.35.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 09:35:37 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        David Heidelberg <david@ixit.cz>,
        Peter Geis <pgwipeout@gmail.com>,
        Stephen Warren <swarren@wwwdotorg.org>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Billy Laws <blaws05@gmail.com>
Cc:     linux-tegra@vger.kernel.org, linux-block@vger.kernel.org,
        Andrey Danin <danindrey@mail.ru>,
        Gilles Grandou <gilles@grandou.net>,
        Ryan Grachek <ryan@edited.us>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 04/10] block: Introduce GENHD_FL_PART_SCAN_ONCE
Date:   Mon, 23 Mar 2020 19:34:25 +0300
Message-Id: <20200323163431.7678-5-digetx@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200323163431.7678-1-digetx@gmail.com>
References: <20200323163431.7678-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Some NVIDIA Tegra devices store partition table on a boot eMMC partition,
and thus, partition-scanner should read out partition table from the boot
block device without assigning found partitions to the block device. The
new disk flag allows MMC core to enable boot partitions scanning, without
changing the old behavior.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 block/genhd.c             |  2 +-
 block/partition-generic.c | 13 ++++++++++++-
 include/linux/genhd.h     | 12 ++++++++++++
 3 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index b210c12c4870..e66a8fcc963b 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -700,7 +700,7 @@ static void register_disk(struct device *parent, struct gendisk *disk,
 	}
 
 	/* No minors to use for partitions */
-	if (!disk_part_scan_enabled(disk))
+	if (!disk_part_scan_enabled(disk) && !disk_part_scan_once(disk))
 		goto exit;
 
 	/* No such device (e.g., media were just removed) */
diff --git a/block/partition-generic.c b/block/partition-generic.c
index 564fae77711d..bd31b71f49f7 100644
--- a/block/partition-generic.c
+++ b/block/partition-generic.c
@@ -537,7 +537,7 @@ int blk_add_partitions(struct gendisk *disk, struct block_device *bdev)
 	struct parsed_partitions *state;
 	int ret = -EAGAIN, p, highest;
 
-	if (!disk_part_scan_enabled(disk))
+	if (!disk_part_scan_enabled(disk) && !disk_part_scan_once(disk))
 		return 0;
 
 	state = check_partition(disk, bdev);
@@ -580,6 +580,17 @@ int blk_add_partitions(struct gendisk *disk, struct block_device *bdev)
 			goto out_free_state;
 	}
 
+	/*
+	 * Partitions were found, but they should stay inactive for a
+	 * scan-only disk.
+	 */
+	if (disk_part_scan_once(disk)) {
+		pr_warn("%s: ignoring partition table on scan-only block device\n",
+			disk->disk_name);
+		ret = 0;
+		goto out_free_state;
+	}
+
 	/* tell userspace that the media / partition table may have changed */
 	kobject_uevent(&disk_to_dev(disk)->kobj, KOBJ_CHANGE);
 
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index d5c75df64bba..79831481142f 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -179,6 +179,12 @@ struct hd_struct {
  * Implies ``GENHD_FL_SUPPRESS_PARTITION_INFO`` and
  * ``GENHD_FL_NO_PART_SCAN``.
  * Used for multipath devices.
+ *
+ * ``GENHD_FL_PART_SCAN_ONCE`` (0x0800): the block device will be scanned for
+ * partition table presence, but found partition won't be assigned to the
+ * block device.
+ * Used for embedded devices with a non-standard partition table, where
+ * partition table is stored on a separate block device.
  */
 #define GENHD_FL_REMOVABLE			0x0001
 /* 2 is unused (used to be GENHD_FL_DRIVERFS) */
@@ -191,6 +197,7 @@ struct hd_struct {
 #define GENHD_FL_BLOCK_EVENTS_ON_EXCL_WRITE	0x0100
 #define GENHD_FL_NO_PART_SCAN			0x0200
 #define GENHD_FL_HIDDEN				0x0400
+#define GENHD_FL_PART_SCAN_ONCE			0x0800
 
 enum {
 	DISK_EVENT_MEDIA_CHANGE			= 1 << 0, /* media changed */
@@ -292,6 +299,11 @@ static inline bool disk_part_scan_enabled(struct gendisk *disk)
 		!(disk->flags & GENHD_FL_NO_PART_SCAN);
 }
 
+static inline bool disk_part_scan_once(struct gendisk *disk)
+{
+	return !!(disk->flags & GENHD_FL_PART_SCAN_ONCE);
+}
+
 static inline dev_t disk_devt(struct gendisk *disk)
 {
 	return MKDEV(disk->major, disk->first_minor);
-- 
2.25.1

