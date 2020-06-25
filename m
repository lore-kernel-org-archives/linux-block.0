Return-Path: <SRS0=Z/Mq=AG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3822C433E1
	for <linux-block@archiver.kernel.org>; Thu, 25 Jun 2020 19:42:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA40920789
	for <linux-block@archiver.kernel.org>; Thu, 25 Jun 2020 19:42:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="l9yRZIal"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406598AbgFYTmw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Jun 2020 15:42:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406069AbgFYTmv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Jun 2020 15:42:51 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B7F2C08C5C1
        for <linux-block@vger.kernel.org>; Thu, 25 Jun 2020 12:42:51 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id w6so7124594ejq.6
        for <linux-block@vger.kernel.org>; Thu, 25 Jun 2020 12:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Yft3YI9mBWfaLsELFbWHBv0KtTLiopcEBpffEnb0D8g=;
        b=l9yRZIalqardlDkc/v27K/tlH6zzyFCw/j+2sSzKKoJbrOWJIdzaD684hnyGxeo+0e
         g6PJTRlLLrsSNLPRj3rwX4FkM6LJSL8c3mpvbNx+CLXsFkjfznG72tH4DxBBM+qkPkcP
         fc3bb+ns0iy79HsHCniYO0QEsMbK/DWw6pWnCrTMM1Y8bP8KDh2W7X9arfs7dMNLP8MX
         H21MJUsEKV0OZTJWaFu0Hh+KXILrhM1j7x67ybXK4EoJo4AGTR7f3JnsAe/gjtawDOAH
         AB+uRQDVmhrdoQEVYuKasBFT3cGs4Vgl4iTja00ugursqwcAfrWLZJ9b0TC/8wBOTuqY
         EVhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Yft3YI9mBWfaLsELFbWHBv0KtTLiopcEBpffEnb0D8g=;
        b=sgUEtUSSB9iTEvJBHodtoFWslE16+azwkx5Qa9yv1H/Cu5/Xj6E3G6Ec8r0EAPQNw4
         JNQWSZ0bpiHQmAdUQnM16dhzXNPsyDLjDyAvgsE1Lx/6mH6USvZNosVsWdxQ2prHUymD
         rzlfqZrp8u5VZaGRzUh2wweK4Z9fpFXsRiMjxWDReU7td+Rsg3RgZc+sb9wbgtlsCjL1
         WI+wY2QtdjAuiUjMr34wyGHtuVXwpsAGIvah8jwSdU0X/R8/+TX3dOuKsqQMfvWorHMJ
         BpLtnLdCyruzsdgV+sNI5PfiySB2O39ImO0GKNar//Obw+RSudiuBQ6/HyVugfn7MbNE
         qvfw==
X-Gm-Message-State: AOAM532Pp79FEn/Hk+9LCTX3qku/FxzLP7AtXmCBO5dFYO+L6ws4Np4J
        UmdAS/j2a0GfZEq4xPhvBTbH/Q==
X-Google-Smtp-Source: ABdhPJwfb/iDPhf5JLWL9mbHNEu93iyxMyagK6uathkYyTPwLK1sPGUtMUOpCZJTJPK2jR2RO0O7kA==
X-Received: by 2002:a17:906:4086:: with SMTP id u6mr14830730ejj.9.1593114170020;
        Thu, 25 Jun 2020 12:42:50 -0700 (PDT)
Received: from localhost (ip-5-186-127-235.cgn.fibianet.dk. [5.186.127.235])
        by smtp.gmail.com with ESMTPSA id cb6sm19045225edb.18.2020.06.25.12.42.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 12:42:49 -0700 (PDT)
Date:   Thu, 25 Jun 2020 21:42:48 +0200
From:   Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
To:     Matias =?utf-8?B?QmrDuHJsaW5n?= <mb@lightnvm.io>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, axboe@kernel.dk,
        SelvaKumar S <selvakuma.s1@samsung.com>,
        Kanchan Joshi <joshi.k@samsung.com>,
        Nitesh Shetty <nj.shetty@samsung.com>
Subject: Re: [PATCH 4/6] block: introduce IOCTL to report dev properties
Message-ID: <20200625194248.44rwwestffgz4jks@MacBook-Pro.localdomain>
References: <20200625122152.17359-1-javier@javigon.com>
 <20200625122152.17359-5-javier@javigon.com>
 <6333b2f1-a4f1-166f-5e0d-03f47389458a@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6333b2f1-a4f1-166f-5e0d-03f47389458a@lightnvm.io>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 25.06.2020 15:10, Matias Bjørling wrote:
>On 25/06/2020 14.21, Javier González wrote:
>>From: Javier González <javier.gonz@samsung.com>
>>
>>With the addition of ZNS, a new set of properties have been added to the
>>zoned block device. This patch introduces a new IOCTL to expose these
>>rroperties to user space.
>>
>>Signed-off-by: Javier González <javier.gonz@samsung.com>
>>Signed-off-by: SelvaKumar S <selvakuma.s1@samsung.com>
>>Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
>>Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
>>---
>>  block/blk-zoned.c             | 46 ++++++++++++++++++++++++++
>>  block/ioctl.c                 |  2 ++
>>  drivers/nvme/host/core.c      |  2 ++
>>  drivers/nvme/host/nvme.h      | 11 +++++++
>>  drivers/nvme/host/zns.c       | 61 +++++++++++++++++++++++++++++++++++
>>  include/linux/blkdev.h        |  9 ++++++
>>  include/uapi/linux/blkzoned.h | 13 ++++++++
>>  7 files changed, 144 insertions(+)
>>
>>diff --git a/block/blk-zoned.c b/block/blk-zoned.c
>>index 704fc15813d1..39ec72af9537 100644
>>--- a/block/blk-zoned.c
>>+++ b/block/blk-zoned.c
>>@@ -169,6 +169,17 @@ int blkdev_report_zones(struct block_device *bdev, sector_t sector,
>>  }
>>  EXPORT_SYMBOL_GPL(blkdev_report_zones);
>>+static int blkdev_report_zonedev_prop(struct block_device *bdev,
>>+				      struct blk_zone_dev *zprop)
>>+{
>>+	struct gendisk *disk = bdev->bd_disk;
>>+
>>+	if (WARN_ON_ONCE(!bdev->bd_disk->fops->report_zone_p))
>>+		return -EOPNOTSUPP;
>>+
>>+	return disk->fops->report_zone_p(disk, zprop);
>>+}
>>+
>>  static inline bool blkdev_allow_reset_all_zones(struct block_device *bdev,
>>  						sector_t sector,
>>  						sector_t nr_sectors)
>>@@ -430,6 +441,41 @@ int blkdev_zone_mgmt_ioctl(struct block_device *bdev, fmode_t mode,
>>  				GFP_KERNEL);
>>  }
>>+int blkdev_zonedev_prop(struct block_device *bdev, fmode_t mode,
>>+			unsigned int cmd, unsigned long arg)
>>+{
>>+	void __user *argp = (void __user *)arg;
>>+	struct request_queue *q;
>>+	struct blk_zone_dev zprop;
>>+	int ret;
>>+
>>+	if (!argp)
>>+		return -EINVAL;
>>+
>>+	q = bdev_get_queue(bdev);
>>+	if (!q)
>>+		return -ENXIO;
>>+
>>+	if (!blk_queue_is_zoned(q))
>>+		return -ENOTTY;
>>+
>>+	if (!capable(CAP_SYS_ADMIN))
>>+		return -EACCES;
>>+
>>+	if (!(mode & FMODE_WRITE))
>>+		return -EBADF;
>>+
>>+	ret = blkdev_report_zonedev_prop(bdev, &zprop);
>>+	if (ret)
>>+		goto out;
>>+
>>+	if (copy_to_user(argp, &zprop, sizeof(struct blk_zone_dev)))
>>+		return -EFAULT;
>>+
>>+out:
>>+	return ret;
>>+}
>>+
>>  static inline unsigned long *blk_alloc_zone_bitmap(int node,
>>  						   unsigned int nr_zones)
>>  {
>>diff --git a/block/ioctl.c b/block/ioctl.c
>>index 0ea29754e7dd..f7b4e0f2dd4c 100644
>>--- a/block/ioctl.c
>>+++ b/block/ioctl.c
>>@@ -517,6 +517,8 @@ static int blkdev_common_ioctl(struct block_device *bdev, fmode_t mode,
>>  		return blkdev_zone_ops_ioctl(bdev, mode, cmd, arg);
>>  	case BLKMGMTZONE:
>>  		return blkdev_zone_mgmt_ioctl(bdev, mode, cmd, arg);
>>+	case BLKZONEDEVPROP:
>>+		return blkdev_zonedev_prop(bdev, mode, cmd, arg);
>>  	case BLKGETZONESZ:
>>  		return put_uint(argp, bdev_zone_sectors(bdev));
>>  	case BLKGETNRZONES:
>>diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>>index 5b95c81d2a2d..a32c909a915f 100644
>>--- a/drivers/nvme/host/core.c
>>+++ b/drivers/nvme/host/core.c
>>@@ -2254,6 +2254,7 @@ static const struct block_device_operations nvme_fops = {
>>  	.getgeo		= nvme_getgeo,
>>  	.revalidate_disk= nvme_revalidate_disk,
>>  	.report_zones	= nvme_report_zones,
>>+	.report_zone_p	= nvme_report_zone_prop,
>>  	.pr_ops		= &nvme_pr_ops,
>>  };
>>@@ -2280,6 +2281,7 @@ const struct block_device_operations nvme_ns_head_ops = {
>>  	.compat_ioctl	= nvme_compat_ioctl,
>>  	.getgeo		= nvme_getgeo,
>>  	.report_zones	= nvme_report_zones,
>>+	.report_zone_p	= nvme_report_zone_prop,
>>  	.pr_ops		= &nvme_pr_ops,
>>  };
>>  #endif /* CONFIG_NVME_MULTIPATH */
>>diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
>>index ecf443efdf91..172e0531f37f 100644
>>--- a/drivers/nvme/host/nvme.h
>>+++ b/drivers/nvme/host/nvme.h
>>@@ -407,6 +407,14 @@ struct nvme_ns {
>>  	u8 pi_type;
>>  #ifdef CONFIG_BLK_DEV_ZONED
>>  	u64 zsze;
>>+
>>+	u32 nr_zones;
>>+	u32 mar;
>>+	u32 mor;
>>+	u32 rrl;
>>+	u32 frl;
>>+	u16 zoc;
>>+	u16 ozcs;
>>  #endif
>>  	unsigned long features;
>>  	unsigned long flags;
>>@@ -704,11 +712,14 @@ int nvme_update_zone_info(struct gendisk *disk, struct nvme_ns *ns,
>>  int nvme_report_zones(struct gendisk *disk, sector_t sector,
>>  		      unsigned int nr_zones, report_zones_cb cb, void *data);
>>+int nvme_report_zone_prop(struct gendisk *disk, struct blk_zone_dev *zprop);
>>+
>>  blk_status_t nvme_setup_zone_mgmt_send(struct nvme_ns *ns, struct request *req,
>>  				       struct nvme_command *cmnd,
>>  				       enum nvme_zone_mgmt_action action);
>>  #else
>>  #define nvme_report_zones NULL
>>+#define nvme_report_zone_prop NULL
>>  static inline blk_status_t nvme_setup_zone_mgmt_send(struct nvme_ns *ns,
>>  		struct request *req, struct nvme_command *cmnd,
>>diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c
>>index 2e6512ac6f01..258d03610cc0 100644
>>--- a/drivers/nvme/host/zns.c
>>+++ b/drivers/nvme/host/zns.c
>>@@ -32,6 +32,28 @@ static int nvme_set_max_append(struct nvme_ctrl *ctrl)
>>  	return 0;
>>  }
>>+static u64 nvme_zns_nr_zones(struct nvme_ns *ns)
>>+{
>>+	struct nvme_command c = { };
>>+	struct nvme_zone_report report;
>>+	int buflen = sizeof(struct nvme_zone_report);
>>+	int ret;
>>+
>>+	c.zmr.opcode = nvme_cmd_zone_mgmt_recv;
>>+	c.zmr.nsid = cpu_to_le32(ns->head->ns_id);
>>+	c.zmr.slba = cpu_to_le64(0);
>>+	c.zmr.numd = cpu_to_le32(nvme_bytes_to_numd(buflen));
>>+	c.zmr.zra = NVME_ZRA_ZONE_REPORT;
>>+	c.zmr.zrasf = NVME_ZRASF_ZONE_REPORT_ALL;
>>+	c.zmr.pr = 0;
>>+
>>+	ret = nvme_submit_sync_cmd(ns->queue, &c, &report, buflen);
>>+	if (ret)
>>+		return ret;
>>+
>>+	return le64_to_cpu(report.nr_zones);
>>+}
>>+
>>  int nvme_update_zone_info(struct gendisk *disk, struct nvme_ns *ns,
>>  			  unsigned lbaf)
>>  {
>>@@ -87,6 +109,13 @@ int nvme_update_zone_info(struct gendisk *disk, struct nvme_ns *ns,
>>  		goto free_data;
>>  	}
>>+	ns->nr_zones = nvme_zns_nr_zones(ns);
>>+	ns->mar = le32_to_cpu(id->mar);
>>+	ns->mor = le32_to_cpu(id->mor);
>>+	ns->rrl = le32_to_cpu(id->rrl);
>>+	ns->frl = le32_to_cpu(id->frl);
>>+	ns->zoc = le16_to_cpu(id->zoc);
>>+
>>  	q->limits.zoned = BLK_ZONED_HM;
>>  	blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, q);
>>  free_data:
>>@@ -230,6 +259,38 @@ int nvme_report_zones(struct gendisk *disk, sector_t sector,
>>  	return ret;
>>  }
>>+static int nvme_ns_report_zone_prop(struct nvme_ns *ns, struct blk_zone_dev *zprop)
>>+{
>>+	zprop->nr_zones = ns->nr_zones;
>>+	zprop->zoc = ns->zoc;
>>+	zprop->ozcs = ns->ozcs;
>>+	zprop->mar = ns->mar;
>>+	zprop->mor = ns->mor;
>>+	zprop->rrl = ns->rrl;
>>+	zprop->frl = ns->frl;
>>+
>>+	return 0;
>>+}
>>+
>>+int nvme_report_zone_prop(struct gendisk *disk, struct blk_zone_dev *zprop)
>>+{
>>+	struct nvme_ns_head *head = NULL;
>>+	struct nvme_ns *ns;
>>+	int srcu_idx, ret;
>>+
>>+	ns = nvme_get_ns_from_disk(disk, &head, &srcu_idx);
>>+	if (unlikely(!ns))
>>+		return -EWOULDBLOCK;
>>+
>>+	if (ns->head->ids.csi == NVME_CSI_ZNS)
>>+		ret = nvme_ns_report_zone_prop(ns, zprop);
>>+	else
>>+		ret = -EINVAL;
>>+	nvme_put_ns_from_disk(head, srcu_idx);
>>+
>>+	return ret;
>>+}
>>+
>>  blk_status_t nvme_setup_zone_mgmt_send(struct nvme_ns *ns, struct request *req,
>>  		struct nvme_command *c, enum nvme_zone_mgmt_action action)
>>  {
>>diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
>>index 8308d8a3720b..0c0faa58b7f4 100644
>>--- a/include/linux/blkdev.h
>>+++ b/include/linux/blkdev.h
>>@@ -372,6 +372,8 @@ extern int blkdev_zone_ops_ioctl(struct block_device *bdev, fmode_t mode,
>>  				  unsigned int cmd, unsigned long arg);
>>  extern int blkdev_zone_mgmt_ioctl(struct block_device *bdev, fmode_t mode,
>>  				  unsigned int cmd, unsigned long arg);
>>+extern int blkdev_zonedev_prop(struct block_device *bdev, fmode_t mode,
>>+			unsigned int cmd, unsigned long arg);
>>  #else /* CONFIG_BLK_DEV_ZONED */
>>  static inline unsigned int blkdev_nr_zones(struct gendisk *disk)
>>@@ -400,6 +402,12 @@ static inline int blkdev_zone_mgmt_ioctl(struct block_device *bdev,
>>  	return -ENOTTY;
>>  }
>>+static inline int blkdev_zonedev_prop(struct block_device *bdev, fmode_t mode,
>>+				      unsigned int cmd, unsigned long arg)
>>+{
>>+	return -ENOTTY;
>>+}
>>+
>>  #endif /* CONFIG_BLK_DEV_ZONED */
>>  struct request_queue {
>>@@ -1770,6 +1778,7 @@ struct block_device_operations {
>>  	int (*report_zones)(struct gendisk *, sector_t sector,
>>  			unsigned int nr_zones, report_zones_cb cb, void *data);
>>  	char *(*devnode)(struct gendisk *disk, umode_t *mode);
>>+	int (*report_zone_p)(struct gendisk *disk, struct blk_zone_dev *zprop);
>>  	struct module *owner;
>>  	const struct pr_ops *pr_ops;
>>  };
>>diff --git a/include/uapi/linux/blkzoned.h b/include/uapi/linux/blkzoned.h
>>index d0978ee10fc7..0c49a4b2ce5d 100644
>>--- a/include/uapi/linux/blkzoned.h
>>+++ b/include/uapi/linux/blkzoned.h
>>@@ -142,6 +142,18 @@ struct blk_zone_range {
>>  	__u64		nr_sectors;
>>  };
>>+struct blk_zone_dev {
>>+	__u32	nr_zones;
>>+	__u32	mar;
>>+	__u32	mor;
>>+	__u32	rrl;
>>+	__u32	frl;
>>+	__u16	zoc;
>>+	__u16	ozcs;
>>+	__u32	rsv31[2];
>>+	__u64	rsv63[4];
>>+};
>>+
>>  /**
>>   * enum blk_zone_action - Zone state transitions managed from user-space
>>   *
>>@@ -209,5 +221,6 @@ struct blk_zone_mgmt {
>>  #define BLKCLOSEZONE	_IOW(0x12, 135, struct blk_zone_range)
>>  #define BLKFINISHZONE	_IOW(0x12, 136, struct blk_zone_range)
>>  #define BLKMGMTZONE	_IOR(0x12, 137, struct blk_zone_mgmt)
>>+#define BLKZONEDEVPROP	_IOR(0x12, 138, struct blk_zone_dev)
>>  #endif /* _UAPI_BLKZONED_H */
>
>Nak. These properties can already be retrieved using the nvme ioctl 
>passthru command and support have also been added to nvme-cli.
>

These properties are intended to be consumed by an application, so
nvme-cli is of not much use. I would also like to avoid sysfs variables.

We can use nvme passthru, but this bypasses the zoned block abstraction.
Why not representing ZNS features in the standard zoned block API? I am
happy to iterate on the actual implementation if you have feedback.

Javier

