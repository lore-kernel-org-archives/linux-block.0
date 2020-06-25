Return-Path: <SRS0=Z/Mq=AG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 693FAC433DF
	for <linux-block@archiver.kernel.org>; Thu, 25 Jun 2020 19:48:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C7C32081A
	for <linux-block@archiver.kernel.org>; Thu, 25 Jun 2020 19:48:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="2Dofv6vd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406927AbgFYTsk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Jun 2020 15:48:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406844AbgFYTsi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Jun 2020 15:48:38 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D9C3C08C5C1
        for <linux-block@vger.kernel.org>; Thu, 25 Jun 2020 12:48:38 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id w6so7141820ejq.6
        for <linux-block@vger.kernel.org>; Thu, 25 Jun 2020 12:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=JsbWESuf1N3EoSxpQZgH3zX47S1xeOHHGlAooXqMv5c=;
        b=2Dofv6vdZUXaXGt4BL/XKlYLgBWPPDqWMCD/jJ0/MuwoRnn64QfXgC4U8Vt0GwY4Re
         tpRg6lLShhmOfWXXqXrIHn0EDbNJqRz64ZPBWRTjQoaTfY2xN4SUAkOLu/0igOKTRInV
         GSUTxXu/DmX/IT5nDM6jzmQQeQvi7gSkAc4oSepbhXbF2S8jemEvYzZexq3CCnI20xgQ
         i8a8ykwK12SKKbJaYtZqg+rQ/Pv4WV4PdTrqDoVfGFbPHQJBR1XPo8wmIzA6XJeLrn6h
         dGJ6mCf9I5C1sX1MfDvjQKkCoyFLNh3pIgh5KtI57keqQ0LjIeWuPwW4MGzDn+y5QXSk
         aAbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=JsbWESuf1N3EoSxpQZgH3zX47S1xeOHHGlAooXqMv5c=;
        b=crtmMlcGSpdIXNI/7uUxfA3nqWlK/GCGA43A/vFFUChWptSKL0KJQg4pTxVORZCdiJ
         SIkzylvCQTKz/VpLlQdQkfnTRRjDrz8HSoilF2RgVPOWCn4yARPhXEYU+ea8bKL7tSmw
         fDbLlE1bAYyz/xRWB4KJyOOB1351HKRg6Ha5fLLQUd9L2MDDjvKoe+xy9hZAGb9tSebK
         6jmV6+B3jTT6CewoyTxlowcFcMXBTvq9xTFgEwEnX37aNVSkeUAyaMO3IVWQ6mT+xv3R
         b7ah91bdRpmsTyFihzRSZVgS3J1De5JbeXTaj0W+TEFskiPqmlf2jcbVsBijSmiNLiD9
         aaew==
X-Gm-Message-State: AOAM533q8+UGJvaz9HURSlUI9XnFAS8T6c2GHUEUDMFro3K0f0sqX9nA
        h0PPRwZp8r90ec9llwopqWGPwA==
X-Google-Smtp-Source: ABdhPJzndQl8a0mNwfza261jUGvbdOcKP4odLtPhY4wiohTt5qGbf24Venw0BU1jvsJyrjMZT4rVpQ==
X-Received: by 2002:a17:907:7294:: with SMTP id dt20mr30389411ejc.355.1593114517072;
        Thu, 25 Jun 2020 12:48:37 -0700 (PDT)
Received: from localhost (ip-5-186-127-235.cgn.fibianet.dk. [5.186.127.235])
        by smtp.gmail.com with ESMTPSA id d11sm18472502edy.79.2020.06.25.12.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 12:48:36 -0700 (PDT)
Date:   Thu, 25 Jun 2020 21:48:35 +0200
From:   Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
To:     Matias =?utf-8?B?QmrDuHJsaW5n?= <mb@lightnvm.io>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, axboe@kernel.dk,
        SelvaKumar S <selvakuma.s1@samsung.com>,
        Kanchan Joshi <joshi.k@samsung.com>,
        Nitesh Shetty <nj.shetty@samsung.com>
Subject: Re: [PATCH 3/6] block: add support for zone offline transition
Message-ID: <20200625194835.5hojuvdwtjxtso2l@MacBook-Pro.localdomain>
References: <20200625122152.17359-1-javier@javigon.com>
 <20200625122152.17359-4-javier@javigon.com>
 <b3429226-16ae-df3c-38aa-50e3a8716e71@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b3429226-16ae-df3c-38aa-50e3a8716e71@lightnvm.io>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 25.06.2020 16:12, Matias Bjørling wrote:
>On 25/06/2020 14.21, Javier González wrote:
>>From: Javier González <javier.gonz@samsung.com>
>>
>>Add support for offline transition on the zoned block device using the
>>new zone management IOCTL
>>
>>Signed-off-by: Javier González <javier.gonz@samsung.com>
>>Signed-off-by: SelvaKumar S <selvakuma.s1@samsung.com>
>>Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
>>Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
>>---
>>  block/blk-core.c              | 2 ++
>>  block/blk-zoned.c             | 3 +++
>>  drivers/nvme/host/core.c      | 3 +++
>>  include/linux/blk_types.h     | 3 +++
>>  include/linux/blkdev.h        | 1 -
>>  include/uapi/linux/blkzoned.h | 1 +
>>  6 files changed, 12 insertions(+), 1 deletion(-)
>>
>>diff --git a/block/blk-core.c b/block/blk-core.c
>>index 03252af8c82c..589cbdacc5ec 100644
>>--- a/block/blk-core.c
>>+++ b/block/blk-core.c
>>@@ -140,6 +140,7 @@ static const char *const blk_op_name[] = {
>>  	REQ_OP_NAME(ZONE_CLOSE),
>>  	REQ_OP_NAME(ZONE_FINISH),
>>  	REQ_OP_NAME(ZONE_APPEND),
>>+	REQ_OP_NAME(ZONE_OFFLINE),
>>  	REQ_OP_NAME(WRITE_SAME),
>>  	REQ_OP_NAME(WRITE_ZEROES),
>>  	REQ_OP_NAME(SCSI_IN),
>>@@ -1030,6 +1031,7 @@ generic_make_request_checks(struct bio *bio)
>>  	case REQ_OP_ZONE_OPEN:
>>  	case REQ_OP_ZONE_CLOSE:
>>  	case REQ_OP_ZONE_FINISH:
>>+	case REQ_OP_ZONE_OFFLINE:
>>  		if (!blk_queue_is_zoned(q))
>>  			goto not_supported;
>>  		break;
>>diff --git a/block/blk-zoned.c b/block/blk-zoned.c
>>index 29194388a1bb..704fc15813d1 100644
>>--- a/block/blk-zoned.c
>>+++ b/block/blk-zoned.c
>>@@ -416,6 +416,9 @@ int blkdev_zone_mgmt_ioctl(struct block_device *bdev, fmode_t mode,
>>  	case BLK_ZONE_MGMT_RESET:
>>  		op = REQ_OP_ZONE_RESET;
>>  		break;
>>+	case BLK_ZONE_MGMT_OFFLINE:
>>+		op = REQ_OP_ZONE_OFFLINE;
>>+		break;
>>  	default:
>>  		return -ENOTTY;
>>  	}
>>diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>>index f1215523792b..5b95c81d2a2d 100644
>>--- a/drivers/nvme/host/core.c
>>+++ b/drivers/nvme/host/core.c
>>@@ -776,6 +776,9 @@ blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struct request *req,
>>  	case REQ_OP_ZONE_FINISH:
>>  		ret = nvme_setup_zone_mgmt_send(ns, req, cmd, NVME_ZONE_FINISH);
>>  		break;
>>+	case REQ_OP_ZONE_OFFLINE:
>>+		ret = nvme_setup_zone_mgmt_send(ns, req, cmd, NVME_ZONE_OFFLINE);
>>+		break;
>>  	case REQ_OP_WRITE_ZEROES:
>>  		ret = nvme_setup_write_zeroes(ns, req, cmd);
>>  		break;
>>diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
>>index 16b57fb2b99c..b3921263c3dd 100644
>>--- a/include/linux/blk_types.h
>>+++ b/include/linux/blk_types.h
>>@@ -316,6 +316,8 @@ enum req_opf {
>>  	REQ_OP_ZONE_FINISH	= 12,
>>  	/* write data at the current zone write pointer */
>>  	REQ_OP_ZONE_APPEND	= 13,
>>+	/* Transition a zone to offline */
>>+	REQ_OP_ZONE_OFFLINE	= 14,
>>  	/* SCSI passthrough using struct scsi_request */
>>  	REQ_OP_SCSI_IN		= 32,
>>@@ -456,6 +458,7 @@ static inline bool op_is_zone_mgmt(enum req_opf op)
>>  	case REQ_OP_ZONE_OPEN:
>>  	case REQ_OP_ZONE_CLOSE:
>>  	case REQ_OP_ZONE_FINISH:
>>+	case REQ_OP_ZONE_OFFLINE:
>>  		return true;
>>  	default:
>>  		return false;
>>diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
>>index bd8521f94dc4..8308d8a3720b 100644
>>--- a/include/linux/blkdev.h
>>+++ b/include/linux/blkdev.h
>>@@ -372,7 +372,6 @@ extern int blkdev_zone_ops_ioctl(struct block_device *bdev, fmode_t mode,
>>  				  unsigned int cmd, unsigned long arg);
>>  extern int blkdev_zone_mgmt_ioctl(struct block_device *bdev, fmode_t mode,
>>  				  unsigned int cmd, unsigned long arg);
>>-
>>  #else /* CONFIG_BLK_DEV_ZONED */
>>  static inline unsigned int blkdev_nr_zones(struct gendisk *disk)
>>diff --git a/include/uapi/linux/blkzoned.h b/include/uapi/linux/blkzoned.h
>>index a8c89fe58f97..d0978ee10fc7 100644
>>--- a/include/uapi/linux/blkzoned.h
>>+++ b/include/uapi/linux/blkzoned.h
>>@@ -155,6 +155,7 @@ enum blk_zone_action {
>>  	BLK_ZONE_MGMT_FINISH	= 0x2,
>>  	BLK_ZONE_MGMT_OPEN	= 0x3,
>>  	BLK_ZONE_MGMT_RESET	= 0x4,
>>+	BLK_ZONE_MGMT_OFFLINE	= 0x5,
>>  };
>>  /**
>
>I am not sure this makes sense to expose through the kernel zone api. 
>One of the goals of the kernel zone API is to be a layer that provides 
>an unified zone model across SMR HDDs and ZNS SSDs. The offline zone 
>operation, as defined in the ZNS specification, does not have an 
>equivalent in SMR HDDs (ZAC/ZBC).
>
>This is different from the Zone Capacity change, where the zone 
>capacity simply was zone size for SMR HDDs. Making it easy to support. 
>That is not the same for ZAC/ZBC, that does not offer the offline 
>operation to transition zones in read only state to offline state.

I agree that an unified interface is desirable. However, the truth is
that ZAC/ZBC are different, and will differ more and more and time goes
by. We can deal with the differences at the driver level or with checks
at the API level, but limiting ZNS with ZAC/ZBC is a hard constraint.

Note too that I chose to only support this particular transition on the
new management IOCTL to avoid confusion for existing ZAC/ZBC users.

It would be good to clarify what is the plan for kernel APIs moving
forward, as I believe there is a general desire to support new ZNS
features, which will not necessarily be replicated in SMR drives.

Javier
