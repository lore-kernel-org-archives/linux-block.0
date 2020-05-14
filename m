Return-Path: <SRS0=D5/G=64=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E187C433DF
	for <linux-block@archiver.kernel.org>; Thu, 14 May 2020 16:26:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC3972065D
	for <linux-block@archiver.kernel.org>; Thu, 14 May 2020 16:26:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="PipeU8/J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbgENQ05 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 May 2020 12:26:57 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:40452 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbgENQ05 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 May 2020 12:26:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1589473616; x=1621009616;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CA+EBso6724C2qKYmiAap8JG45mqjbf0Gjz/KIrBzpw=;
  b=PipeU8/J9L3cDN4QBJupFML4t8TP8nM79f6aAvldnDF5klihwEuYU3xr
   ROw0OzMRmZFgl1vfdKOfo2v7RiT+HG6vzdME3Z3guBX4NOc59QMLXvQQU
   P/mwof4oyYjjyU2O/pDURR+QDWdZTJcBYFKPs5+N7jxJsjluDFCo0XO3n
   2RZv58kzOFuc8vkr6MSa+Cvg1hkz/Ps/06SrdRHgymFBz2HpBnn553D3y
   O5eFnvWGIkNjAUHVgo5ZiBcVMRyVtSsK0HQW9t5FCyl+KgxO5SJAdfWlJ
   a9buBJORUk8oblw5MNWI3TZZigx2nzUob3FF1UIyfMUZVLPen6AWDLMTc
   w==;
IronPort-SDR: U45I+D3z/vM4glYMMpOSCBr39k+/oUsF2H+EYLbHfUwFJllnoByzLl0szTFE3mDMeuXLCZl4ia
 i4kuh07oHXiawpmZ6f54Lscc5dcuPTiGqWcwMXjlygR1Vw4tU6d45yguh/9BnqB9cONywX2ZpQ
 64mi8DWaSy7oL1hmOmN+577gUAoyf8PWM8pQvrkAy+PXj04NwF271e3lrx+GtKEGF8R3ceNNcA
 1Gyrwx4r/x4SGjquF/Sdh6aXM2gh9F09csypl2rVbA5uXyrrc86shIfJgnZitZg47rVuVi2cw8
 Se8=
X-IronPort-AV: E=Sophos;i="5.73,392,1583164800"; 
   d="scan'208";a="246653213"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 15 May 2020 00:26:48 +0800
IronPort-SDR: a89zb5UswCC28rqTsPYCat3fQOdE9EP6QzNJga8M8LhQCa8UHFU4Xxs7Dg+NgQCxKI7TndgHnE
 8FytjA8GHGF9mCFZBTZUlScvlbaArj+AU=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2020 09:16:27 -0700
IronPort-SDR: 4BtLXHs7uBnt8LOC16vAwyrxsU/4gLShJDP7cI3dehDo5sjnn0e27tmUPzMqNacuEr/EZ+LAdZ
 0DtKGxZ3mPew==
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 14 May 2020 09:26:47 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "linux-block @ vger . kernel . org" <linux-block@vger.kernel.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Christoph Hellwig <hch@lst.de>, Coly Li <colyli@suse.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH] block: deny zone management ioctl on mounted fs
Date:   Fri, 15 May 2020 01:26:43 +0900
Message-Id: <20200514162643.11880-1-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If a user submits a zone management ioctl from user-space, like a zone
reset and a file-system (like zonefs or f2fs) is mounted on the zoned
block device, the zone will get reset and the file-system's cached value
of the zone's write-pointer becomes invalid.

Subsequent writes to this zone from the file-system will result in
unaligned writes and the drive will error out.

Deny zone management ioctls when a super_block is found on the block
device.

Reported-by: Coly Li <colyli@suse.de>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---

Is there a better way to check for a mounted FS than get_super()/drop_super()?

 block/blk-zoned.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 23831fa8701d..6923695ec414 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -325,6 +325,7 @@ int blkdev_zone_mgmt_ioctl(struct block_device *bdev, fmode_t mode,
 			   unsigned int cmd, unsigned long arg)
 {
 	void __user *argp = (void __user *)arg;
+	struct super_block *sb;
 	struct request_queue *q;
 	struct blk_zone_range zrange;
 	enum req_opf op;
@@ -345,6 +346,12 @@ int blkdev_zone_mgmt_ioctl(struct block_device *bdev, fmode_t mode,
 	if (!(mode & FMODE_WRITE))
 		return -EBADF;
 
+	sb = get_super(bdev);
+	if (sb) {
+		drop_super(sb);
+		return -EINVAL;
+	}
+
 	if (copy_from_user(&zrange, argp, sizeof(struct blk_zone_range)))
 		return -EFAULT;
 
-- 
2.24.1

