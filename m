Return-Path: <SRS0=Z/Mq=AG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F395FC433DF
	for <linux-block@archiver.kernel.org>; Thu, 25 Jun 2020 12:22:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5AD620707
	for <linux-block@archiver.kernel.org>; Thu, 25 Jun 2020 12:22:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="pKwqM6/B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404619AbgFYMWY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Jun 2020 08:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404508AbgFYMWY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Jun 2020 08:22:24 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4B78C0613ED
        for <linux-block@vger.kernel.org>; Thu, 25 Jun 2020 05:22:22 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id h15so5613172wrq.8
        for <linux-block@vger.kernel.org>; Thu, 25 Jun 2020 05:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Uplg47+RomE9YaWxZaB8jq75+RVgxneSzcAc8bd9ca0=;
        b=pKwqM6/BNNtcXKCnqMZeye8/adtX0X/kD2BvhvoojAvfru7Z8ZK4mKkjbZbxp9tbWo
         HxBdLz44Pni9xhrCCnd1oFt9oJPzvizNfc78+H5GGICH+/lGRMs85hCDdmPwoXSmoJWx
         at8xpmekaKwqpaNJaMuZRrmjniqcFCJNPPnTVEvl27FQZXMuXayOxT9X+zBX7oK23xsX
         nUD9rOQ52tE5Yn9OZHGOBlXhWWJjJVl6dziT27/AxnVGLJLunr3bGLnHw451QsydaDDc
         hlc4yoAUoY6iy/JrUOGAxRvOTpwG9/fEakD1h5bJK/4gahehBNDeLxdoJ0JOWImgk3r1
         SULw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Uplg47+RomE9YaWxZaB8jq75+RVgxneSzcAc8bd9ca0=;
        b=eVwOjU+uoAcgp2N+omUoxt7/40x6tVUc/t32YqfQ0MQIrDsel24Ed2L0XVrJDVNmhp
         d4W+XULnfWB3y8baJX40yHDFftykIwj0NrQkCxhUk8VcA8GYAscyNBGiHhSKM/7nllq2
         CWI71pWQnIJE3yvGJuib/R6+MU5g+Rr+lV+AUA1cZHwgwy4ff6G1TZCUS7TSefLM6f0k
         vKF0HX9hSN9szKORBih4vbEqVpLUJnp84RpE95UqpiPC75bHE4U5gTYeTXg61igSn2Il
         LImJRAMCSvjJ3pFPRSI2EO/6rVkU37Fcr/xYFiVTG1BmNVRE1zOeFmVpgAPW7p0hi/96
         pQYw==
X-Gm-Message-State: AOAM533FdPrZYUQ6MkhpBPhLw/2M8NKgHfc/TW4PmRK0x6fVRQ+0R69E
        b8/ohwxUy3xpqtFEGwpNGbFPeA==
X-Google-Smtp-Source: ABdhPJzl2u7SbnklyFfMa/Qyq7hFxasyRw6r1/oAry3ecNHjaxknZiMpQeqk9tjHTb1+Tl39UBn2Qg==
X-Received: by 2002:a5d:68cc:: with SMTP id p12mr2763592wrw.111.1593087741592;
        Thu, 25 Jun 2020 05:22:21 -0700 (PDT)
Received: from localhost.localdomain ([194.62.217.57])
        by smtp.gmail.com with ESMTPSA id f186sm11934307wmf.29.2020.06.25.05.22.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jun 2020 05:22:20 -0700 (PDT)
From:   =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@javigon.com>
To:     linux-nvme@lists.infradead.org
Cc:     linux-block@vger.kernel.org, hch@lst.de, kbusch@kernel.org,
        sagi@grimberg.me, axboe@kernel.dk,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier.gonz@samsung.com>,
        SelvaKumar S <selvakuma.s1@samsung.com>,
        Kanchan Joshi <joshi.k@samsung.com>,
        Nitesh Shetty <nj.shetty@samsung.com>
Subject: [PATCH 5/6] block: add zone attr. to zone mgmt IOCTL struct
Date:   Thu, 25 Jun 2020 14:21:51 +0200
Message-Id: <20200625122152.17359-6-javier@javigon.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200625122152.17359-1-javier@javigon.com>
References: <20200625122152.17359-1-javier@javigon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Javier González <javier.gonz@samsung.com>

Add zone attributes field to the blk_zone structure. Use ZNS attributes
as base for zoned block devices in general.

Signed-off-by: Javier González <javier.gonz@samsung.com>
Signed-off-by: SelvaKumar S <selvakuma.s1@samsung.com>
Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
---
 drivers/nvme/host/zns.c       |  1 +
 include/uapi/linux/blkzoned.h | 13 ++++++++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c
index 258d03610cc0..7d8381fe7665 100644
--- a/drivers/nvme/host/zns.c
+++ b/drivers/nvme/host/zns.c
@@ -195,6 +195,7 @@ static int nvme_zone_parse_entry(struct nvme_ns *ns,
 	zone.capacity = nvme_lba_to_sect(ns, le64_to_cpu(entry->zcap));
 	zone.start = nvme_lba_to_sect(ns, le64_to_cpu(entry->zslba));
 	zone.wp = nvme_lba_to_sect(ns, le64_to_cpu(entry->wp));
+	zone.attr = entry->za;
 
 	return cb(&zone, idx, data);
 }
diff --git a/include/uapi/linux/blkzoned.h b/include/uapi/linux/blkzoned.h
index 0c49a4b2ce5d..2e43a00e3425 100644
--- a/include/uapi/linux/blkzoned.h
+++ b/include/uapi/linux/blkzoned.h
@@ -82,6 +82,16 @@ enum blk_zone_report_flags {
 	BLK_ZONE_REP_CAPACITY	= (1 << 0),
 };
 
+/**
+ * Zone Attributes
+ */
+enum blk_zone_attr {
+	BLK_ZONE_ATTR_ZFC	= 1 << 0,
+	BLK_ZONE_ATTR_FZR	= 1 << 1,
+	BLK_ZONE_ATTR_RZR	= 1 << 2,
+	BLK_ZONE_ATTR_ZDEV	= 1 << 7,
+};
+
 /**
  * struct blk_zone - Zone descriptor for BLKREPORTZONE ioctl.
  *
@@ -108,7 +118,8 @@ struct blk_zone {
 	__u8	cond;		/* Zone condition */
 	__u8	non_seq;	/* Non-sequential write resources active */
 	__u8	reset;		/* Reset write pointer recommended */
-	__u8	resv[4];
+	__u8	attr;		/* Zone attributes */
+	__u8	resv[3];
 	__u64	capacity;	/* Zone capacity in number of sectors */
 	__u8	reserved[24];
 };
-- 
2.17.1

