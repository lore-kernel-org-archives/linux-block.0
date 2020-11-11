Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B26BC56201
	for <linux-block@archiver.kernel.org>; Wed, 11 Nov 2020 05:16:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4474020729
	for <linux-block@archiver.kernel.org>; Wed, 11 Nov 2020 05:16:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="R2cvq3X3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725984AbgKKFQy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Nov 2020 00:16:54 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:43931 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbgKKFQx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Nov 2020 00:16:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1605071813; x=1636607813;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=YqMtHkmhnXJnHlDZwv4XX+IidTqWrb1YHJe15NPnTHg=;
  b=R2cvq3X3JfrIQNaVrdZ5oVmf0aLBH59qGrzyhh4o1dFG1R10hm0+8OzA
   DyfDcSjqltkA8M8dGkSlaST+sh9ElgecgmfYqN/uUJGoA2nrEYFhOJW7r
   a9Tcdyp3vPD0drwS2WPbv5wyMG7A1sXMozCy0w4aga87aX1brewP/m/ie
   H5PMLs+4fwCe7B/bE5WWxuqpaEktXV2VxmbIFX5hfVwPbKVvjL8vHBMKC
   jJaWs3lLXtCiu06mpOGLetsWQs5dKJLLbplJDUgdnTWUasjcCE1B6ik76
   QMvvvorJI9xKJ5Z9B29wXiI+CpKuQ4oIbJQ5cMN8H5gO2dIdDzWZLGtKZ
   A==;
IronPort-SDR: tgbh6gnalYf65/eBAJngBqUg3APqGkqYGWTpGADxtDAPUP/uiPkd2rjmUyqjEOOvU1KYcqgsQZ
 td38PhjBpEm1LbJQD6Ar3oG3oGqdVHRDCmqGBC3NvQ6yj2XBonEjtq2lIuwUkkSsCUimM8eepJ
 JsttB6EjC+SwfP5CwRgL0U5Xyc6b0uvChHDnm2Mx8d7QUGF7j9045CAK6bB9S1GCx2gQfrP4It
 7JaMJ5Zf7+nqtC+7m+FrtlBL19QkTWgI/+GMoUxrkyLJKfPB9ZK6cX0SLGgAyw0n0KVbUdmynK
 pn8=
X-IronPort-AV: E=Sophos;i="5.77,468,1596470400"; 
   d="scan'208";a="152254631"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Nov 2020 13:16:53 +0800
IronPort-SDR: uMV0qaE6CCIjZMk5dxQN364PMjxK9ZePlgC+oetm6+BrGaYuAzP1Fp/9m7RULMJfQDVAncKJ6P
 +Ic10EX7dA0ADl8a/9Crc7YKB9moppR36QSpbh9YhLi8FbeDi9/MzYlGPtbhalOc105L+wucwu
 NTf8WvathVfBspRgZ/jHIInERndpha1F/icAtHuSsOOK2wKEAx+jfWHGhK+prX6CYRgR/mGgnm
 yyVtQ1aOsr1rMQ2ttNHPXHc8kEP85TccGsNoK4pyx7LpW/J5o3+ZpfJ60yqUgD+mUmd5R6C4Gy
 0THqbb1E22aM9KkqDVFZDAKz
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2020 21:01:39 -0800
IronPort-SDR: HmXsrh850Jx6GIW27OJjZTaa0EEzvJbtiF5t7HGZLhjeHsom0KxDq5dQwoHwRpCSevTcr6xKz3
 pMBriRmWtOoUlm9GVSadR6ucksQ9QzchRj1FbBDEvANHLy9vByQHNs/qD/68uiaGCgiYzpF+12
 pPwJqo477D5vYRqgBfU7yVZXZhg8l4R9HC/lubrgF32LVH0P1CR4ieUuNCFqMuB3CtTFC4XXjL
 t6kXQHQh4l5TzFBrubpx4he2r7Qy7kuMHv7Cwqg/6WPq25BMASyVNxsEnSZX7bmsNDCInjOq63
 Cys=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 10 Nov 2020 21:16:52 -0800
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v2 3/9] null_blk: Align max_hw_sectors to blocksize
Date:   Wed, 11 Nov 2020 14:16:42 +0900
Message-Id: <20201111051648.635300-4-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201111051648.635300-1-damien.lemoal@wdc.com>
References: <20201111051648.635300-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

null_blk always uses the default BLK_SAFE_MAX_SECTORS value for the
max_hw_sectors and max_sectors queue limits resulting in a maximum
request size of 127 sectors. When the blocksize setting is larger than
the default 512B, this maximum request size is not aligned to the
block size. To emulate a real device more accurately, fix this by
setting the max_hw_sectors and max_sectors queue limits to a value
that is aligned to the block size.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 drivers/block/null_blk_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.c
index 4685ea401d5b..b77a506a4ae4 100644
--- a/drivers/block/null_blk_main.c
+++ b/drivers/block/null_blk_main.c
@@ -1866,6 +1866,9 @@ static int null_add_dev(struct nullb_device *dev)
 
 	blk_queue_logical_block_size(nullb->q, dev->blocksize);
 	blk_queue_physical_block_size(nullb->q, dev->blocksize);
+	blk_queue_max_hw_sectors(nullb->q,
+				 round_down(queue_max_hw_sectors(nullb->q),
+					    dev->blocksize >> SECTOR_SHIFT));
 
 	null_config_discard(nullb);
 
-- 
2.26.2

