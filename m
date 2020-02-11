Return-Path: <SRS0=uOpu=37=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40AC2C352A3
	for <linux-block@archiver.kernel.org>; Tue, 11 Feb 2020 09:16:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04D2F20870
	for <linux-block@archiver.kernel.org>; Tue, 11 Feb 2020 09:16:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="NUeXCYX4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727669AbgBKJQm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Feb 2020 04:16:42 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:38269 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727558AbgBKJQm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Feb 2020 04:16:42 -0500
Received: by mail-lf1-f65.google.com with SMTP id r14so6451864lfm.5
        for <linux-block@vger.kernel.org>; Tue, 11 Feb 2020 01:16:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=k0WMuprZxo/iCOfAVR7QEXu/mzkUnhwQ/IguI5j1vig=;
        b=NUeXCYX4hCDUVSqL7hnm/DZ3cO14iRNPC+85GPHH1Vywj33PhOCXCiLV3O0lseGV56
         sgeM5pdLYaOjgW/cSgXP7f2YyD04T2izWhWTmyIFtvCD3mSNLa3188ab7S8evMWnS1rp
         fkfwLwElNekSWMIp5DDrg1rrBp5j8SHvqlo6TXpSxoEu0pHAKUo5vlj64O2mvsiP8DwD
         b6esQ5nPqAB6oF+aT7CXXHAk8XBC9WsgYZIwome48saFCDjI7z08twkbREkHjbuzGYtg
         q/C7rLzZ+gQJEec/5BouVqEVBh6+FiGitbOPYf7796k2ETGyhXsN3u7dWciPdAWxpk6Y
         DuiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=k0WMuprZxo/iCOfAVR7QEXu/mzkUnhwQ/IguI5j1vig=;
        b=mgx6dXDbcwVLDWDGorr9dAkdR5MWmnHxjqRV22b2pkmFlQATwpUdbzS/cCklhNjAFr
         KzZb9znmCwtqM1NN1IZ9lwckZsWYngO5cV2CMZ2NhvjjIrDF3oHzqlRnzOy3CW3oDnZ7
         md/M8cJzocoT2MCuDuaz5zUJA0oKZIfLB2wQf7E+itjChHZkPAyBeWOfO7InPmLQ/+Ah
         /t8bpoZDBop00w3CqG7wpktQv7ohxsZ1mtsBEO8Jazo2pUfXJrG/bmF7I3aZ0xqLpNsi
         793RNCDH6WMMPKXXpabrJXSH3UPg6iRo3tfaYHoAyLdd9g1CmZwFbQES9QhWSNCxvAiG
         e5rg==
X-Gm-Message-State: APjAAAUvt/35XMymsfkLcabusCHZUJAfcgbTx59e73MlyUdq/S8F2jww
        nqQcnEfBVI7gzgRkZPbXxI7lxZE75Xo=
X-Google-Smtp-Source: APXvYqwdqX+6fp10TqiglY/jzDIx0a8qXJ3vN+PrGeOaJBknwz57gWc3s4+meuU0iP448yZ2U5ahJw==
X-Received: by 2002:a19:5503:: with SMTP id n3mr2136520lfe.136.1581412599243;
        Tue, 11 Feb 2020 01:16:39 -0800 (PST)
Received: from localhost ([165.225.194.200])
        by smtp.gmail.com with ESMTPSA id h24sm1698855ljc.84.2020.02.11.01.16.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2020 01:16:38 -0800 (PST)
Date:   Tue, 11 Feb 2020 10:16:37 +0100
From:   Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org, damien.lemoal@wdc.com
Subject: Re: [PATCH v2] block: support arbitrary zone size
Message-ID: <20200211091637.nkawa73iwgznqgcm@mpHalley.local>
References: <20200210220816.GA7769@avx2>
 <20200210222045.GA1495@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20200210222045.GA1495@avx2>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11.02.2020 01:20, Alexey Dobriyan wrote:
>SK hynix is going to ship ZNS device with zone size not being power of 2.
>
>Signed-off-by: Alexey Dobriyan (SK hynix) <adobriyan@gmail.com>
>---
>
>	v2: fixup one ">>ilog2"/div conversion :-/
>
> block/blk-settings.c           |    4 +---
> block/blk-zoned.c              |   10 +++++-----
> drivers/block/null_blk_main.c  |   11 ++++++-----
> drivers/block/null_blk_zoned.c |   10 ++--------
> 4 files changed, 14 insertions(+), 21 deletions(-)
>
>--- a/block/blk-settings.c
>+++ b/block/blk-settings.c
>@@ -206,15 +206,13 @@ EXPORT_SYMBOL(blk_queue_max_hw_sectors);
>  *
>  * Description:
>  *    If a driver doesn't want IOs to cross a given chunk size, it can set
>- *    this limit and prevent merging across chunks. Note that the chunk size
>- *    must currently be a power-of-2 in sectors. Also note that the block
>+ *    this limit and prevent merging across chunks. Note that the block
>  *    layer must accept a page worth of data at any offset. So if the
>  *    crossing of chunks is a hard limitation in the driver, it must still be
>  *    prepared to split single page bios.
>  **/
> void blk_queue_chunk_sectors(struct request_queue *q, unsigned int chunk_sectors)
> {
>-	BUG_ON(!is_power_of_2(chunk_sectors));
> 	q->limits.chunk_sectors = chunk_sectors;
> }
> EXPORT_SYMBOL(blk_queue_chunk_sectors);
>--- a/block/blk-zoned.c
>+++ b/block/blk-zoned.c
>@@ -83,7 +83,7 @@ unsigned int blkdev_nr_zones(struct gendisk *disk)
>
> 	if (!blk_queue_is_zoned(disk->queue))
> 		return 0;
>-	return (get_capacity(disk) + zone_sectors - 1) >> ilog2(zone_sectors);
>+	return div64_u64(get_capacity(disk) + zone_sectors - 1, zone_sectors);
> }
> EXPORT_SYMBOL_GPL(blkdev_nr_zones);
>
>@@ -363,14 +363,14 @@ static int blk_revalidate_zone_cb(struct blk_zone *zone, unsigned int idx,
> 	 * smaller last zone.
> 	 */
> 	if (zone->start == 0) {
>-		if (zone->len == 0 || !is_power_of_2(zone->len)) {
>-			pr_warn("%s: Invalid zoned device with non power of two zone size (%llu)\n",
>-				disk->disk_name, zone->len);
>+		if (zone->len == 0) {
>+			pr_warn("%s: Invalid zoned device with length 0\n",
>+				disk->disk_name);
> 			return -ENODEV;
> 		}
>
> 		args->zone_sectors = zone->len;
>-		args->nr_zones = (capacity + zone->len - 1) >> ilog2(zone->len);
>+		args->nr_zones = div64_u64(capacity + zone->len - 1, zone->len);
> 	} else if (zone->start + args->zone_sectors < capacity) {
> 		if (zone->len != args->zone_sectors) {
> 			pr_warn("%s: Invalid zoned device with non constant zone size\n",
>--- a/drivers/block/null_blk_main.c
>+++ b/drivers/block/null_blk_main.c
>@@ -187,7 +187,7 @@ MODULE_PARM_DESC(zoned, "Make device as a host-managed zoned block device. Defau
>
> static unsigned long g_zone_size = 256;
> module_param_named(zone_size, g_zone_size, ulong, S_IRUGO);
>-MODULE_PARM_DESC(zone_size, "Zone size in MB when block device is zoned. Must be power-of-two: Default: 256");
>+MODULE_PARM_DESC(zone_size, "Zone size in MB when block device is zoned. Default: 256");
>
> static unsigned int g_zone_nr_conv;
> module_param_named(zone_nr_conv, g_zone_nr_conv, uint, 0444);
>@@ -1641,10 +1641,11 @@ static int null_validate_conf(struct nullb_device *dev)
> 	if (dev->queue_mode == NULL_Q_BIO)
> 		dev->mbps = 0;
>
>-	if (dev->zoned &&
>-	    (!dev->zone_size || !is_power_of_2(dev->zone_size))) {
>-		pr_err("zone_size must be power-of-two\n");
>-		return -EINVAL;
>+	if (dev->zoned) {
>+		if (dev->zone_size == 0) {
>+			pr_err("zone_size must be positive\n");
>+			return -EINVAL;
>+		}
> 	}
>
> 	return 0;
>--- a/drivers/block/null_blk_zoned.c
>+++ b/drivers/block/null_blk_zoned.c
>@@ -7,7 +7,7 @@
>
> static inline unsigned int null_zone_no(struct nullb_device *dev, sector_t sect)
> {
>-	return sect >> ilog2(dev->zone_size_sects);
>+	return div64_u64(sect, dev->zone_size_sects);
> }
>
> int null_zone_init(struct nullb_device *dev)
>@@ -16,14 +16,8 @@ int null_zone_init(struct nullb_device *dev)
> 	sector_t sector = 0;
> 	unsigned int i;
>
>-	if (!is_power_of_2(dev->zone_size)) {
>-		pr_err("zone_size must be power-of-two\n");
>-		return -EINVAL;
>-	}
>-
> 	dev->zone_size_sects = dev->zone_size << ZONE_SIZE_SHIFT;
>-	dev->nr_zones = dev_size >>
>-				(SECTOR_SHIFT + ilog2(dev->zone_size_sects));
>+	dev->nr_zones = div64_u64(dev_size, dev->zone_size_sects * SECTOR_SIZE);
> 	dev->zones = kvmalloc_array(dev->nr_zones, sizeof(struct blk_zone),
> 			GFP_KERNEL | __GFP_ZERO);
> 	if (!dev->zones)

Same response from here. You will need to add some changes to support
arbitrary zone capacities, but the zone size needs to be a power-of-2 to
plug into the zoned framework.

Javier
