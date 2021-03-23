Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE5B9C433DB
	for <linux-block@archiver.kernel.org>; Tue, 23 Mar 2021 11:07:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8CA4619C3
	for <linux-block@archiver.kernel.org>; Tue, 23 Mar 2021 11:07:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbhCWLHP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Mar 2021 07:07:15 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:23494 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbhCWLHL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Mar 2021 07:07:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1616497630; x=1648033630;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=PSigW5l4uj53gvIzjqtg7mzBZlTvWpQ3zlmEYHHRAlQ=;
  b=VYkssNVKR6D+KP2fi1T2e9QWTS/c1jefpOCtpXak0y4yu+15eEO90mDZ
   kGRviUYH6h+1ENZgKT6uFDHnCoRJ+GTuGVbz+n5GJLt43us8t1qvBMSkh
   qYFECwR0PiZbBiwHblKneb4KG2AvyIiurDdgnCzcIaIiuIwfLyxszV5Oh
   SYPo5E9FhhCeG8r3RrAi1gIMaDKZBYGRLGbqQW4c7FtJVLvC0UIZELSbP
   Zcl/N7SUrCxikwWDrYjD8mEO/HuS6ghKuQCoYlPSt5ybEMIzijDoyZKfB
   VmhiGCSM2PdEAGhNpAFVQdYHlCUc1Lx27d/Hgcw+juTPR3hou5r9qvBRI
   Q==;
IronPort-SDR: RdmW8UJiaag9A4GY260pXqB2DlH5HPx8bJqo648rM+l7BBzvIO4+i5BqyVaJ5H2zY3bxEABD9h
 YeVNBBC08UsSfTVOJjwovcAq97IShEs3FcX0CyF8iszB9erIy63wEKmqp8YAJeCevB46BK3Yev
 7neR1SjfQMb0iHt1oYNT8QRGt733MmtaYwXMKHsop4OhYy4cqUBROgdHWB059uozDuL7uQE0la
 c+7a1lAY1cGuXRUnM3w17S9FXfYmMgYkwkQKAf4DOznBHpVJHIayG0H59RJYGno/QxUNWmk98O
 kAE=
X-IronPort-AV: E=Sophos;i="5.81,271,1610380800"; 
   d="scan'208";a="162781588"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 23 Mar 2021 19:07:09 +0800
IronPort-SDR: d8ctiPdg6u2VnEY+0mfP7ysYkS4OczDav/FNJBexlrkETmubZ2FkX/OS0nEvNvI6ki//f5VTw6
 MM33byJxdJ7FRMuof3ZECe+1t5wKR9ZvPr3OEcGzyJHYPjFJy5uvkRvqPq2WMLi0wE/kSfHHbS
 ikf4pcCR2pXAEPgtdpFZfNdLU2KBB+sjACVtvxt8TujJxZ1NTdTJ1mHPeR/T5PCMr+XdTkLkyU
 eZhWjsr5zFkVo+IILcIHipUGz9tht/g7YhQ6zhkbChpJw+Bc1eCzU2XJSJXV9ckiXXZrVPTAS2
 f9S5lI5mlgOnmbMYdjpdklkL
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2021 03:49:16 -0700
IronPort-SDR: 7AGweo7Kh/Sk4Do2fMyiJNDwmxbD3jT6XWvKDswphevV18+EMj/NC5g6AnTJJqSptDLMaXtSix
 ba8vGG91yMR7ObrughJ1ijSPZ/pUjG/rwldZWgVWNA7WHgIqXWiMEsGDduuItF8QcV/kjRnJpD
 Di89P7Rh7OFH5ugMN85sOmdMOooFDEN23rXAePVddvJHodamH8BW8RQ/LalE+ilXWnoghy1CQp
 8+MJUSVUZzyqJVg8FsfvASgH5fQcRXwcbMc0/HFVah9p4AqsjRckvVK/5BdmPLdy29jWcvelkD
 FmU=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 23 Mar 2021 04:07:09 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH] block: support zone append bvecs
Date:   Tue, 23 Mar 2021 20:06:56 +0900
Message-Id: <739a96e185f008c238fcf06cb22068016149ad4a.1616497531.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Christoph reported that we'll likely trigger the WARN_ON_ONCE() checking
that we're not submitting a bvec with REQ_OP_ZONE_APPEND in
bio_iov_iter_get_pages() some time ago using zoned btrfs, but I couldn't
reproduce it back then.

Now Naohiro was able to trigger the bug as well with xfstests generic/095
on a zoned btrfs.

There is nothing that prevents bvec submissions via REQ_OP_ZONE_APPEND if
the hardware's zone append limit is met.

Reported-by: Naohiro Aota <naohiro.aota@wdc.com>
Reported-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 block/bio.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 26b7f721cda8..215fe24a01ee 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1094,8 +1094,14 @@ int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 	int ret = 0;
 
 	if (iov_iter_is_bvec(iter)) {
-		if (WARN_ON_ONCE(bio_op(bio) == REQ_OP_ZONE_APPEND))
-			return -EINVAL;
+		if (bio_op(bio) == REQ_OP_ZONE_APPEND) {
+			struct request_queue *q = bio->bi_bdev->bd_disk->queue;
+			unsigned int max_append =
+				queue_max_zone_append_sectors(q) << 9;
+
+			if (WARN_ON_ONCE(iter->count > max_append))
+				return -EINVAL;
+		}
 		return bio_iov_bvec_set(bio, iter);
 	}
 
-- 
2.30.0

