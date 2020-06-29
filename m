Return-Path: <SRS0=rGXo=AK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF36DC433E0
	for <linux-block@archiver.kernel.org>; Mon, 29 Jun 2020 19:42:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8989620842
	for <linux-block@archiver.kernel.org>; Mon, 29 Jun 2020 19:42:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="IWRI9ZZW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387566AbgF2TmU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387425AbgF2TmT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 29 Jun 2020 15:42:19 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 813C0C03E97B
        for <linux-block@vger.kernel.org>; Mon, 29 Jun 2020 12:42:19 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id dm19so7723516edb.13
        for <linux-block@vger.kernel.org>; Mon, 29 Jun 2020 12:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=qPRWIOr57ZYTUxHr8TbMRvU0I6oEVGESocMJLPUw7ak=;
        b=IWRI9ZZWLmSqGaFLlS/Q6+qqYEFfzGMcZO3qmaAQ222cW5zAaZhN5PnKbKVGkZFa9P
         1aJerDy40vcxH8EXTXo/GOJj58Rru+hjCZrXQVluj99YOX1GJPZkpk9DjI6INTAuhVsb
         D6AWuWbM4FmHFpre6LyWjdPXgbAI12W25S66rAFqRfrJEiv0IwdqrG1ar8NQVW3XUKqs
         oEV36lnW27cU1eFXGVDPYNS1uEOX+5khJ6iktErth6Ud4c3dYDclRZS9upgG4nYCde2E
         kwP+AA0xNE2iAO3zu/Ah5/tr6V7SEIB3G+SOw4DaRZIwUEsGb+7O7daxFKwPsZ2PBrDN
         cYRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=qPRWIOr57ZYTUxHr8TbMRvU0I6oEVGESocMJLPUw7ak=;
        b=BpAm8exg7E5Zf7BLO/pPygKtWxBatl+HCO8KJgP86eYlaAttXFoWRtM4ylN0awNXB7
         eOwpVujzfEw+kD3IaNCfuj9BDOSrIx0ruAS3c5oHuRbnewPIYoWeRQ1GhgwwW4HU2w7U
         FAuaj0zJ1GezWJShyOv6X0naPyr0AEkDvO27QPjAUpdUNKi2vol2rrpvNlGf/3dkaxjc
         pa0rvJndb5oJ968Ww9Nf3xbmpe2TDFgdVLaIHIZNZiBl6CrHm5SQOHOCWhLq7zUc/XNC
         +folduicwspMqRrUn2/JmbH9Nrc1gOjGV0H4/9W4bg4Tsm9ZeLr9vQ5QazH4j4J/QAHp
         Korg==
X-Gm-Message-State: AOAM5311FCKEwAgwCA3eRTjoEcjFH78oNqsSIr7qJ2xS/oqbsuZYgDIQ
        QQ9W6ONCYtX5TRyUaq11fEf73Q==
X-Google-Smtp-Source: ABdhPJyGAI3oTGH5RV/GlMVT+ru8LjoquevNNsqLlOGBediZBG3+4tQ6abxqVDJntY6y9wJG9eSZ2Q==
X-Received: by 2002:aa7:da8d:: with SMTP id q13mr15080761eds.339.1593459738252;
        Mon, 29 Jun 2020 12:42:18 -0700 (PDT)
Received: from localhost (5.186.127.235.cgn.fibianet.dk. [5.186.127.235])
        by smtp.gmail.com with ESMTPSA id c4sm371603ejb.17.2020.06.29.12.42.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 12:42:17 -0700 (PDT)
Date:   Mon, 29 Jun 2020 21:42:16 +0200
From:   Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
To:     Niklas Cassel <niklas.cassel@wdc.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 2/2] block: add max_active_zones to blk-sysfs
Message-ID: <20200629194216.iykvd74rw6d7vqpl@MacBook-Pro.localdomain>
References: <20200616102546.491961-1-niklas.cassel@wdc.com>
 <20200616102546.491961-3-niklas.cassel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200616102546.491961-3-niklas.cassel@wdc.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 16.06.2020 12:25, Niklas Cassel wrote:
>Add a new max_active zones definition in the sysfs documentation.
>This definition will be common for all devices utilizing the zoned block
>device support in the kernel.
>
>Export max_active_zones according to this new definition for NVMe Zoned
>Namespace devices, ZAC ATA devices (which are treated as SCSI devices by
>the kernel), and ZBC SCSI devices.
>
>Add the new max_active_zones struct member to the request_queue, rather
>than as a queue limit, since this property cannot be split across stacking
>drivers.
>
>For SCSI devices, even though max active zones is not part of the ZBC/ZAC
>spec, export max_active_zones as 0, signifying "no limit".
>
>Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
>---
> Documentation/block/queue-sysfs.rst |  7 +++++++
> block/blk-sysfs.c                   | 14 +++++++++++++-
> drivers/nvme/host/zns.c             |  1 +
> drivers/scsi/sd_zbc.c               |  1 +
> include/linux/blkdev.h              | 20 ++++++++++++++++++++
> 5 files changed, 42 insertions(+), 1 deletion(-)
>
>diff --git a/Documentation/block/queue-sysfs.rst b/Documentation/block/queue-sysfs.rst
>index f01cf8530ae4..f261a5c84170 100644
>--- a/Documentation/block/queue-sysfs.rst
>+++ b/Documentation/block/queue-sysfs.rst
>@@ -117,6 +117,13 @@ Maximum number of elements in a DMA scatter/gather list with integrity
> data that will be submitted by the block layer core to the associated
> block driver.
>
>+max_active_zones (RO)
>+---------------------
>+For zoned block devices (zoned attribute indicating "host-managed" or
>+"host-aware"), the sum of zones belonging to any of the zone states:
>+EXPLICIT OPEN, IMPLICIT OPEN or CLOSED, is limited by this value.
>+If this value is 0, there is no limit.
>+
> max_open_zones (RO)
> -------------------
> For zoned block devices (zoned attribute indicating "host-managed" or
>diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
>index fa42961e9678..624bb4d85fc7 100644
>--- a/block/blk-sysfs.c
>+++ b/block/blk-sysfs.c
>@@ -310,6 +310,11 @@ static ssize_t queue_max_open_zones_show(struct request_queue *q, char *page)
> 	return queue_var_show(queue_max_open_zones(q), page);
> }
>
>+static ssize_t queue_max_active_zones_show(struct request_queue *q, char *page)
>+{
>+	return queue_var_show(queue_max_active_zones(q), page);
>+}
>+
> static ssize_t queue_nomerges_show(struct request_queue *q, char *page)
> {
> 	return queue_var_show((blk_queue_nomerges(q) << 1) |
>@@ -677,6 +682,11 @@ static struct queue_sysfs_entry queue_max_open_zones_entry = {
> 	.show = queue_max_open_zones_show,
> };
>
>+static struct queue_sysfs_entry queue_max_active_zones_entry = {
>+	.attr = {.name = "max_active_zones", .mode = 0444 },
>+	.show = queue_max_active_zones_show,
>+};
>+
> static struct queue_sysfs_entry queue_nomerges_entry = {
> 	.attr = {.name = "nomerges", .mode = 0644 },
> 	.show = queue_nomerges_show,
>@@ -776,6 +786,7 @@ static struct attribute *queue_attrs[] = {
> 	&queue_zoned_entry.attr,
> 	&queue_nr_zones_entry.attr,
> 	&queue_max_open_zones_entry.attr,
>+	&queue_max_active_zones_entry.attr,
> 	&queue_nomerges_entry.attr,
> 	&queue_rq_affinity_entry.attr,
> 	&queue_iostats_entry.attr,
>@@ -803,7 +814,8 @@ static umode_t queue_attr_visible(struct kobject *kobj, struct attribute *attr,
> 		(!q->mq_ops || !q->mq_ops->timeout))
> 			return 0;
>
>-	if (attr == &queue_max_open_zones_entry.attr &&
>+	if ((attr == &queue_max_open_zones_entry.attr ||
>+	     attr == &queue_max_active_zones_entry.attr) &&
> 	    !blk_queue_is_zoned(q))
> 		return 0;
>
>diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c
>index af156529f3b6..502070763266 100644
>--- a/drivers/nvme/host/zns.c
>+++ b/drivers/nvme/host/zns.c
>@@ -83,6 +83,7 @@ int nvme_update_zone_info(struct gendisk *disk, struct nvme_ns *ns,
> 	q->limits.zoned = BLK_ZONED_HM;
> 	blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, q);
> 	blk_queue_max_open_zones(q, le32_to_cpu(id->mor) + 1);
>+	blk_queue_max_active_zones(q, le32_to_cpu(id->mar) + 1);
> free_data:
> 	kfree(id);
> 	return status;
>diff --git a/drivers/scsi/sd_zbc.c b/drivers/scsi/sd_zbc.c
>index aa3564139b40..d8b2c49d645b 100644
>--- a/drivers/scsi/sd_zbc.c
>+++ b/drivers/scsi/sd_zbc.c
>@@ -721,6 +721,7 @@ int sd_zbc_read_zones(struct scsi_disk *sdkp, unsigned char *buf)
> 		blk_queue_max_open_zones(q, 0);
> 	else
> 		blk_queue_max_open_zones(q, sdkp->zones_max_open);
>+	blk_queue_max_active_zones(q, 0);
> 	nr_zones = round_up(sdkp->capacity, zone_blocks) >> ilog2(zone_blocks);
>
> 	/* READ16/WRITE16 is mandatory for ZBC disks */
>diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
>index 2f332f00501d..3776140f8f20 100644
>--- a/include/linux/blkdev.h
>+++ b/include/linux/blkdev.h
>@@ -521,6 +521,7 @@ struct request_queue {
> 	unsigned long		*conv_zones_bitmap;
> 	unsigned long		*seq_zones_wlock;
> 	unsigned int		max_open_zones;
>+	unsigned int		max_active_zones;
> #endif /* CONFIG_BLK_DEV_ZONED */
>
> 	/*
>@@ -741,6 +742,17 @@ static inline unsigned int queue_max_open_zones(const struct request_queue *q)
> {
> 	return q->max_open_zones;
> }
>+
>+static inline void blk_queue_max_active_zones(struct request_queue *q,
>+		unsigned int max_active_zones)
>+{
>+	q->max_active_zones = max_active_zones;
>+}
>+
>+static inline unsigned int queue_max_active_zones(const struct request_queue *q)
>+{
>+	return q->max_active_zones;
>+}
> #else /* CONFIG_BLK_DEV_ZONED */
> static inline unsigned int blk_queue_nr_zones(struct request_queue *q)
> {
>@@ -764,6 +776,14 @@ static inline unsigned int queue_max_open_zones(const struct request_queue *q)
> {
> 	return 0;
> }
>+static inline void blk_queue_max_active_zones(struct request_queue *q,
>+		unsigned int max_active_zones)
>+{
>+}
>+static inline unsigned int queue_max_active_zones(const struct request_queue *q)
>+{
>+	return 0;
>+}
> #endif /* CONFIG_BLK_DEV_ZONED */
>
> static inline bool rq_is_sync(struct request *rq)
>-- 
>2.26.2
>
>
>_______________________________________________
>linux-nvme mailing list
>linux-nvme@lists.infradead.org
>http://lists.infradead.org/mailman/listinfo/linux-nvme

Looks good to me

Reviewed-by: Javier González <javier@javigon.com>
