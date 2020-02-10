Return-Path: <SRS0=SfBO=36=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85476C352A4
	for <linux-block@archiver.kernel.org>; Mon, 10 Feb 2020 22:08:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5696020838
	for <linux-block@archiver.kernel.org>; Mon, 10 Feb 2020 22:08:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f31MFElp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727385AbgBJWIW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Feb 2020 17:08:22 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40525 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727254AbgBJWIW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Feb 2020 17:08:22 -0500
Received: by mail-wm1-f68.google.com with SMTP id t14so1042438wmi.5
        for <linux-block@vger.kernel.org>; Mon, 10 Feb 2020 14:08:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=XfRs1Z/gkEiU+y6kKP5DVhnKr86XXD3K2Le+pLZJl9E=;
        b=f31MFElpqkv6cJQ4vP4a9oGuEHuECQvNnr6USgQEbu2Q2BuJx35QinQMX7uG30I+eb
         NpBfd/T1ybbl25gYJ16klX1GIkhU0rZZazdMVRhSG+059agt5XI9UPcoScZBk3EHcESV
         d71Qv3Phgu5VpM+/Adw97H1aARowCN3VatbY2vkggFksr6OVEKyBRMFNJvmcMr8W13jT
         zyfya9TO9J9w8/stya2CI2TtmAV3K+POD5IR5C3aaUmbGBXrratP44EXhYnvHfcp9Cgi
         sPtUDTI69fa3Rs2P+sh2poUccnYXcgT74qcWMrC0iEdPGK6BlfSLQ80Jv8nbNB2Y6EMV
         3JGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=XfRs1Z/gkEiU+y6kKP5DVhnKr86XXD3K2Le+pLZJl9E=;
        b=UemFXZqIeFOA6QjNUBL0jxTMAI4n5ijP7sQhgqZ2fLKsBhvYkyik42621xSoeIYpyb
         AjTMweW5rNOed09O5MuGz0K5ki4kFN7B9KYj05SZZIdExp60CbGGS8g7XPLhpre8vxoX
         cUhm6ttLxu+K++EsWNC2Vo3xwxOhxGxywP8xc/Yghg7VU4dFoVVGwES9y0zp2b4KA/Jq
         74Z9qinlBqvskQXKRRQNoPeCI65Gq9/RDMspqwONu3lnT8hFcYYB3ghDdv35g5pJNMp4
         6hg7CSTEX5pEUSIiT4ygI1wNtbW6ASSPM/3fIAWNoguv74p3AzgNDICrhaq2Ns8HCwFb
         Wl5g==
X-Gm-Message-State: APjAAAVwMaR+wXo7pekJEmrVjvvWk59Wcik14AYvjQbyJ0NXZBCGutt5
        rBC8aYehTnZQXM2odKrEEg==
X-Google-Smtp-Source: APXvYqyfgzxJePa9xTqEWgkH8DXZIIPYWzNNhfGRr+MTHtKajaf9KVGFAcQeUNTrLfpyn875jrOEQg==
X-Received: by 2002:a05:600c:d7:: with SMTP id u23mr1126780wmm.145.1581372498884;
        Mon, 10 Feb 2020 14:08:18 -0800 (PST)
Received: from avx2 ([46.53.254.169])
        by smtp.gmail.com with ESMTPSA id w22sm887242wmk.34.2020.02.10.14.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2020 14:08:18 -0800 (PST)
Date:   Tue, 11 Feb 2020 01:08:16 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, damien.lemoal@wdc.com
Subject: [PATCH] block: support arbitrary zone size
Message-ID: <20200210220816.GA7769@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

SK hynix is going to ship ZNS device with zone size not being power of 2.

Signed-off-by: Alexey Dobriyan (SK hynix) <adobriyan@gmail.com>
---

 block/blk-settings.c           |    4 +---
 block/blk-zoned.c              |   10 +++++-----
 drivers/block/null_blk_main.c  |   11 ++++++-----
 drivers/block/null_blk_zoned.c |   10 ++--------
 4 files changed, 14 insertions(+), 21 deletions(-)

--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -206,15 +206,13 @@ EXPORT_SYMBOL(blk_queue_max_hw_sectors);
  *
  * Description:
  *    If a driver doesn't want IOs to cross a given chunk size, it can set
- *    this limit and prevent merging across chunks. Note that the chunk size
- *    must currently be a power-of-2 in sectors. Also note that the block
+ *    this limit and prevent merging across chunks. Note that the block
  *    layer must accept a page worth of data at any offset. So if the
  *    crossing of chunks is a hard limitation in the driver, it must still be
  *    prepared to split single page bios.
  **/
 void blk_queue_chunk_sectors(struct request_queue *q, unsigned int chunk_sectors)
 {
-	BUG_ON(!is_power_of_2(chunk_sectors));
 	q->limits.chunk_sectors = chunk_sectors;
 }
 EXPORT_SYMBOL(blk_queue_chunk_sectors);
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -83,7 +83,7 @@ unsigned int blkdev_nr_zones(struct gendisk *disk)
 
 	if (!blk_queue_is_zoned(disk->queue))
 		return 0;
-	return (get_capacity(disk) + zone_sectors - 1) >> ilog2(zone_sectors);
+	return div64_u64(get_capacity(disk) + zone_sectors - 1, zone_sectors);
 }
 EXPORT_SYMBOL_GPL(blkdev_nr_zones);
 
@@ -363,14 +363,14 @@ static int blk_revalidate_zone_cb(struct blk_zone *zone, unsigned int idx,
 	 * smaller last zone.
 	 */
 	if (zone->start == 0) {
-		if (zone->len == 0 || !is_power_of_2(zone->len)) {
-			pr_warn("%s: Invalid zoned device with non power of two zone size (%llu)\n",
-				disk->disk_name, zone->len);
+		if (zone->len == 0) {
+			pr_warn("%s: Invalid zoned device with length 0\n",
+				disk->disk_name);
 			return -ENODEV;
 		}
 
 		args->zone_sectors = zone->len;
-		args->nr_zones = (capacity + zone->len - 1) >> ilog2(zone->len);
+		args->nr_zones = div64_u64(capacity + zone->len - 1, zone->len);
 	} else if (zone->start + args->zone_sectors < capacity) {
 		if (zone->len != args->zone_sectors) {
 			pr_warn("%s: Invalid zoned device with non constant zone size\n",
--- a/drivers/block/null_blk_main.c
+++ b/drivers/block/null_blk_main.c
@@ -187,7 +187,7 @@ MODULE_PARM_DESC(zoned, "Make device as a host-managed zoned block device. Defau
 
 static unsigned long g_zone_size = 256;
 module_param_named(zone_size, g_zone_size, ulong, S_IRUGO);
-MODULE_PARM_DESC(zone_size, "Zone size in MB when block device is zoned. Must be power-of-two: Default: 256");
+MODULE_PARM_DESC(zone_size, "Zone size in MB when block device is zoned. Default: 256");
 
 static unsigned int g_zone_nr_conv;
 module_param_named(zone_nr_conv, g_zone_nr_conv, uint, 0444);
@@ -1641,10 +1641,11 @@ static int null_validate_conf(struct nullb_device *dev)
 	if (dev->queue_mode == NULL_Q_BIO)
 		dev->mbps = 0;
 
-	if (dev->zoned &&
-	    (!dev->zone_size || !is_power_of_2(dev->zone_size))) {
-		pr_err("zone_size must be power-of-two\n");
-		return -EINVAL;
+	if (dev->zoned) {
+		if (dev->zone_size == 0) {
+			pr_err("zone_size must be positive\n");
+			return -EINVAL;
+		}
 	}
 
 	return 0;
--- a/drivers/block/null_blk_zoned.c
+++ b/drivers/block/null_blk_zoned.c
@@ -7,7 +7,7 @@
 
 static inline unsigned int null_zone_no(struct nullb_device *dev, sector_t sect)
 {
-	return sect >> ilog2(dev->zone_size_sects);
+	return div64_u64(sect, dev->zone_size_sects * SECTOR_SIZE);
 }
 
 int null_zone_init(struct nullb_device *dev)
@@ -16,14 +16,8 @@ int null_zone_init(struct nullb_device *dev)
 	sector_t sector = 0;
 	unsigned int i;
 
-	if (!is_power_of_2(dev->zone_size)) {
-		pr_err("zone_size must be power-of-two\n");
-		return -EINVAL;
-	}
-
 	dev->zone_size_sects = dev->zone_size << ZONE_SIZE_SHIFT;
-	dev->nr_zones = dev_size >>
-				(SECTOR_SHIFT + ilog2(dev->zone_size_sects));
+	dev->nr_zones = div64_u64(dev_size, dev->zone_size_sects * SECTOR_SIZE);
 	dev->zones = kvmalloc_array(dev->nr_zones, sizeof(struct blk_zone),
 			GFP_KERNEL | __GFP_ZERO);
 	if (!dev->zones)
