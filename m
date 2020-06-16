Return-Path: <SRS0=kfbW=75=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1930BC433E0
	for <linux-block@archiver.kernel.org>; Tue, 16 Jun 2020 10:28:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E470F2074D
	for <linux-block@archiver.kernel.org>; Tue, 16 Jun 2020 10:28:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="NqIJ1TZH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728371AbgFPK2t (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 Jun 2020 06:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728357AbgFPK2o (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Jun 2020 06:28:44 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEFFAC08C5C2
        for <linux-block@vger.kernel.org>; Tue, 16 Jun 2020 03:28:43 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id j10so20172058wrw.8
        for <linux-block@vger.kernel.org>; Tue, 16 Jun 2020 03:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=lWd87k2+YO9oIrJMsR3kbdwYQQ5BwfAiJZE+DlsHT+8=;
        b=NqIJ1TZHZnCGgie0Hi2SYxfe2IRNRJJlgAkph6yJZj8DMMtCouJX6S9ngbLt0jA35y
         wWcKtGRG+LOzNh6KpJjaRVcLsWqxmTvfysywJ9fUhO+ig9ZOSbIi9RsyjM1cybPE6CzF
         bXmCMSmC6LkBeP4ki1OvZvdjb5HJ3r+fd8ke9HzGTFRHBEzrjopiLZnjO75pdHYlWE6P
         czIkPHR0MRcEEKl79nn2uLTk5EB4emVLYDzH+5oBg/p/zz+kW2JbivMEogXluTFSO2JG
         NBI7V2Dqf9Zs3oKRyBSneB978AdNUOdrmwoKS7ZYd6CIoyhr0J0l95ZS6eCKpvLYV7bJ
         5hcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=lWd87k2+YO9oIrJMsR3kbdwYQQ5BwfAiJZE+DlsHT+8=;
        b=BeiqQaclgg8MFONvrmoEIL1eFAcMDp4mLtKgzwI8ZB2bi5cEEx4ljZuB8+IsbG+HVS
         iSsTzZcmZeM52DSlVqVrHYAoB5SmWkfAgnLHGLimlm9pzG0D9dIj4ZiR/+yxWaELGq5v
         WF78qryzrJ8+4GUJnoT5JHIc1GDTsv2ryzvwM7QnFNle1wVuqKCrfhEi4kDxZyWOfFUB
         Ax8xQTUEy6wL1BcNgC94o762rv/Vn2FOA+C/CQOZKlwN3fJWRHLoPUCO2KoE/StzOe7O
         k3OXyJwlPEa7lpKckvPrHcvuSUc0mwkFyoxwjKRPGFY1ETqmCEqpGa8JNqdhX/LrWbGR
         sGZw==
X-Gm-Message-State: AOAM5317RiyC0s3P9Rg0UV5yWnX8C+vyrisjfmpp1XuA1DhrC/07jcHB
        BWGjbf+qy6s1Q9mi4gCf4THZPw==
X-Google-Smtp-Source: ABdhPJwreQ4baLleQTG5f6a9XetfYJeZfUi89U3IrXCnT6tUbPxGNZBjLykPbtdUIAYBLAfRSWgbWw==
X-Received: by 2002:adf:8b18:: with SMTP id n24mr799716wra.372.1592303322537;
        Tue, 16 Jun 2020 03:28:42 -0700 (PDT)
Received: from localhost ([194.62.217.57])
        by smtp.gmail.com with ESMTPSA id c5sm3180820wmb.24.2020.06.16.03.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 03:28:41 -0700 (PDT)
Date:   Tue, 16 Jun 2020 12:28:40 +0200
From:   Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
To:     Keith Busch <keith.busch@wdc.com>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Matias =?utf-8?B?QmrDuHJsaW5n?= <matias.bjorling@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 1/5] block: add capacity field to zone descriptors
Message-ID: <20200616102504.xj6o4lsziosy2dfk@mpHalley.local>
References: <20200615233424.13458-1-keith.busch@wdc.com>
 <20200615233424.13458-2-keith.busch@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200615233424.13458-2-keith.busch@wdc.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 16.06.2020 08:34, Keith Busch wrote:
>From: Matias Bjørling <matias.bjorling@wdc.com>
>
>In the zoned storage model, the sectors within a zone are typically all
>writeable. With the introduction of the Zoned Namespace (ZNS) Command
>Set in the NVM Express organization, the model was extended to have a
>specific writeable capacity.
>
>Extend the zone descriptor data structure with a zone capacity field to
>indicate to the user how many sectors in a zone are writeable.
>
>Introduce backward compatibility in the zone report ioctl by extending
>the zone report header data structure with a flags field to indicate if
>the capacity field is available.
>
>Signed-off-by: Matias Bjørling <matias.bjorling@wdc.com>
>---
> block/blk-zoned.c              |  1 +
> drivers/block/null_blk_zoned.c |  2 ++
> drivers/scsi/sd_zbc.c          |  1 +
> include/uapi/linux/blkzoned.h  | 15 +++++++++++++--
> 4 files changed, 17 insertions(+), 2 deletions(-)
>
>diff --git a/block/blk-zoned.c b/block/blk-zoned.c
>index 23831fa8701d..81152a260354 100644
>--- a/block/blk-zoned.c
>+++ b/block/blk-zoned.c
>@@ -312,6 +312,7 @@ int blkdev_report_zones_ioctl(struct block_device *bdev, fmode_t mode,
> 		return ret;
>
> 	rep.nr_zones = ret;
>+	rep.flags = BLK_ZONE_REP_CAPACITY;
> 	if (copy_to_user(argp, &rep, sizeof(struct blk_zone_report)))
> 		return -EFAULT;
> 	return 0;
>diff --git a/drivers/block/null_blk_zoned.c b/drivers/block/null_blk_zoned.c
>index cc47606d8ffe..624aac09b005 100644
>--- a/drivers/block/null_blk_zoned.c
>+++ b/drivers/block/null_blk_zoned.c
>@@ -47,6 +47,7 @@ int null_init_zoned_dev(struct nullb_device *dev, struct request_queue *q)
>
> 		zone->start = sector;
> 		zone->len = dev->zone_size_sects;
>+		zone->capacity = zone->len;
> 		zone->wp = zone->start + zone->len;
> 		zone->type = BLK_ZONE_TYPE_CONVENTIONAL;
> 		zone->cond = BLK_ZONE_COND_NOT_WP;
>@@ -59,6 +60,7 @@ int null_init_zoned_dev(struct nullb_device *dev, struct request_queue *q)
>
> 		zone->start = zone->wp = sector;
> 		zone->len = dev->zone_size_sects;
>+		zone->capacity = zone->len;
> 		zone->type = BLK_ZONE_TYPE_SEQWRITE_REQ;
> 		zone->cond = BLK_ZONE_COND_EMPTY;
>
>diff --git a/drivers/scsi/sd_zbc.c b/drivers/scsi/sd_zbc.c
>index 6f7eba66687e..183a20720da9 100644
>--- a/drivers/scsi/sd_zbc.c
>+++ b/drivers/scsi/sd_zbc.c
>@@ -59,6 +59,7 @@ static int sd_zbc_parse_report(struct scsi_disk *sdkp, u8 *buf,
> 		zone.non_seq = 1;
>
> 	zone.len = logical_to_sectors(sdp, get_unaligned_be64(&buf[8]));
>+	zone.capacity = zone.len;
> 	zone.start = logical_to_sectors(sdp, get_unaligned_be64(&buf[16]));
> 	zone.wp = logical_to_sectors(sdp, get_unaligned_be64(&buf[24]));
> 	if (zone.type != ZBC_ZONE_TYPE_CONV &&
>diff --git a/include/uapi/linux/blkzoned.h b/include/uapi/linux/blkzoned.h
>index 0cdef67135f0..42c3366cc25f 100644
>--- a/include/uapi/linux/blkzoned.h
>+++ b/include/uapi/linux/blkzoned.h
>@@ -73,6 +73,15 @@ enum blk_zone_cond {
> 	BLK_ZONE_COND_OFFLINE	= 0xF,
> };
>
>+/**
>+ * enum blk_zone_report_flags - Feature flags of reported zone descriptors.
>+ *
>+ * @BLK_ZONE_REP_CAPACITY: Zone descriptor has capacity field.
>+ */
>+enum blk_zone_report_flags {
>+	BLK_ZONE_REP_CAPACITY	= (1 << 0),
>+};
>+
> /**
>  * struct blk_zone - Zone descriptor for BLKREPORTZONE ioctl.
>  *
>@@ -99,7 +108,9 @@ struct blk_zone {
> 	__u8	cond;		/* Zone condition */
> 	__u8	non_seq;	/* Non-sequential write resources active */
> 	__u8	reset;		/* Reset write pointer recommended */
>-	__u8	reserved[36];
>+	__u8	resv[4];
>+	__u64	capacity;	/* Zone capacity in number of sectors */
>+	__u8	reserved[24];
> };
>
> /**
>@@ -115,7 +126,7 @@ struct blk_zone {
> struct blk_zone_report {
> 	__u64		sector;
> 	__u32		nr_zones;
>-	__u8		reserved[4];
>+	__u32		flags;
> 	struct blk_zone zones[0];
> };
>
>-- 
>2.24.1
>

Looks good to me.

Reviewed-by: Javier González <javier.gonz@samsung.com>
