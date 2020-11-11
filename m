Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF09DC5517A
	for <linux-block@archiver.kernel.org>; Wed, 11 Nov 2020 13:00:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E8A120829
	for <linux-block@archiver.kernel.org>; Wed, 11 Nov 2020 13:00:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Ysr+XBE1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbgKKNAz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Nov 2020 08:00:55 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:32526 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbgKKNAy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Nov 2020 08:00:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1605099654; x=1636635654;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=Tx6ngQbprsGSbKzexnBLKGloPuxLNdw3lvebue4OKuQ=;
  b=Ysr+XBE1VGG7VPY+GPkLmAAmNiArYhhkbFb9DW3ehmLw4W3tKZjTRCn4
   3zDUpaiCoLT2QmBtpne9fFdh5jn/l0RPAmXJDhXjYkcZI/u86OBH5TH2s
   DRdFyyqx62RsYtWxFwEuphH3X9v3B3/56K9jwrAY4XkgxEqGOcdm2eyAb
   uTQKsSE7sTQaUVl0Wtv8EKgHgp3AswCeotk42EoOyyz+K5lstOFIqzxD+
   7kCAEnDsR5C1RY7B/zL/fN7ojNVANhZSd5PNOr9u+3d9vMy3wme9crRhZ
   ELJNxm5uLOg4gr4Mtjswn1Zzu6G2shvqTNWFe3S7VWPyD3pQnXTj+dbPe
   w==;
IronPort-SDR: LEsGNn85N9FgaxhAwlQD9LfNA+/bmxnb6vyDvBpypj4DxzavDjqsanxU1irP/fXYOfCZW8/2va
 UCqHIRiH/tLhebcx7ZrXp2zqG9TAKMNLG51AG/sQKDGBG/T/k/hH7MSARaH7wAIz8E/lerom89
 mQHyZM4m2Jpfu8Je1HWWxd1M0we1rtRc3SLpvvhvNl6HXXFMlv4S0YqkeIuKR/NaCK7uXLkgFR
 MRChzXRhyhm1s29XAEjeMSibId/XducqUTqA5iVQTrSE4Jimt+HAagqBixJRi23i5ZnTZX+yz1
 XWI=
X-IronPort-AV: E=Sophos;i="5.77,469,1596470400"; 
   d="scan'208";a="152283540"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Nov 2020 21:00:54 +0800
IronPort-SDR: mN6GEQ5THRScRQLUdSA02n0aXoIqV4tyhYMmu5KqFwZpO9GmUiUhK8FprOmER685HfT1wmAJb3
 KBXuuk3t4aJYX7vd0IMZAN/2B4l+eEYZ9M5uHIDF47W98yn9hWCjG1A+q98lq8oduwK91PniQ+
 CWlKVY4SLp6HHZidob5T5rfQL8JC56mChhTWIZscV6QC4y51GB8CWN8Rba85NJm5c48cV+3DDF
 laZhQCdIZTPNefZy8P2nPWGsdh2ofWuOHXsZ71NUL+UpMzv7VH/ET6cXYNHROtUmfz8OLRY9r5
 JRyGFGiliMbcKPj6g0yJSjag
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2020 04:45:37 -0800
IronPort-SDR: PjL24/dZCJTGvfFQokNt3hF6Le8kyKDyMMTsLtufooyB3GQhJs/HLo72VFzNn/hSU7k1OMtzVx
 Y9nLuccQsFnikbCSiFp/qw03lWd8qWfW1UK1JP3FUZ82GSsammfxLWirMRVJ/QTrVTVlSi808c
 xsluYEgFksJpyHwEVUO5ozr1hNKY5LUn/7ijC7gUckFsASCZb3eok1PjulZ38Mxxz0bUupq9Cc
 g5GuGemFJ6PSwJWYlIsSN380zYCNlk49H0ZLfN8gmvXaOQ9lb5vnJyQXSKL8SiEvCPOMsgo2EX
 RyI=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Nov 2020 05:00:55 -0800
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v3 3/9] block: Align max_hw_sectors to logical blocksize
Date:   Wed, 11 Nov 2020 22:00:43 +0900
Message-Id: <20201111130049.967902-4-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201111130049.967902-1-damien.lemoal@wdc.com>
References: <20201111130049.967902-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Block device drivers do not have to call blk_queue_max_hw_sectors() to
set a limit on request size if the default limit BLK_SAFE_MAX_SECTORS
is acceptable. However, this limit (255 sectors) may not be aligned
to the device logical block size which cannot be used as is for a
request maximum size. This is the case for the null_blk device driver.

Modify blk_queue_max_hw_sectors() to make sure that the request size
limits specified by the max_hw_sectors and max_sectors queue limits
are always aligned to the device logical block size. Additionally, to
avoid introducing a dependence on the execution order of this function
with blk_queue_logical_block_size(), also modify
blk_queue_logical_block_size() to perform the same alignment when the
logical block size is set after max_hw_sectors.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 block/blk-settings.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index 9741d1d83e98..dde5c2e9a728 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -157,10 +157,16 @@ void blk_queue_max_hw_sectors(struct request_queue *q, unsigned int max_hw_secto
 		       __func__, max_hw_sectors);
 	}
 
+	max_hw_sectors = round_down(max_hw_sectors,
+				    limits->logical_block_size >> SECTOR_SHIFT);
 	limits->max_hw_sectors = max_hw_sectors;
+
 	max_sectors = min_not_zero(max_hw_sectors, limits->max_dev_sectors);
 	max_sectors = min_t(unsigned int, max_sectors, BLK_DEF_MAX_SECTORS);
+	max_sectors = round_down(max_sectors,
+				 limits->logical_block_size >> SECTOR_SHIFT);
 	limits->max_sectors = max_sectors;
+
 	q->backing_dev_info->io_pages = max_sectors >> (PAGE_SHIFT - 9);
 }
 EXPORT_SYMBOL(blk_queue_max_hw_sectors);
@@ -321,13 +327,20 @@ EXPORT_SYMBOL(blk_queue_max_segment_size);
  **/
 void blk_queue_logical_block_size(struct request_queue *q, unsigned int size)
 {
-	q->limits.logical_block_size = size;
+	struct queue_limits *limits = &q->limits;
 
-	if (q->limits.physical_block_size < size)
-		q->limits.physical_block_size = size;
+	limits->logical_block_size = size;
 
-	if (q->limits.io_min < q->limits.physical_block_size)
-		q->limits.io_min = q->limits.physical_block_size;
+	if (limits->physical_block_size < size)
+		limits->physical_block_size = size;
+
+	if (limits->io_min < limits->physical_block_size)
+		limits->io_min = limits->physical_block_size;
+
+	limits->max_hw_sectors =
+		round_down(limits->max_hw_sectors, size >> SECTOR_SHIFT);
+	limits->max_sectors =
+		round_down(limits->max_sectors, size >> SECTOR_SHIFT);
 }
 EXPORT_SYMBOL(blk_queue_logical_block_size);
 
-- 
2.26.2

