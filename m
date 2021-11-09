Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 696A2C433EF
	for <linux-block@archiver.kernel.org>; Tue,  9 Nov 2021 10:47:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5503161151
	for <linux-block@archiver.kernel.org>; Tue,  9 Nov 2021 10:47:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245440AbhKIKuN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 9 Nov 2021 05:50:13 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:41961 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231173AbhKIKuM (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 Nov 2021 05:50:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1636454847; x=1667990847;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sAO9YVLKTGi4pH16fhCDk5SXvSzrdc4h6c7Ex9fxxnY=;
  b=kpNnCUhw8KfjGObuwDqb96SPz6IAOd2wQaySKsCD1/XL2G1+xzbK7ENv
   CO/hlVvMc25+yeugXiy/fFDM3PFYFoLy7BXClvYOPXseztFTR/GkzrBrH
   z34MLCzG9fW0oStYPl+fkNL8uUe1EPSksxp3JYz1/gHBN4XU/FDhL8klz
   ZGRrhNY4xH1q4uR/Gv/37LtepVztgq7Z2dkQZPYyXN5j2quQZPqyG5B6d
   RiUhL5DoEimzIEdNzOFQcSowee9m5dzfxDs1TGlPqkz8TTp2BW5zu1C2X
   VT0U5Ku6ZmnFup6b4FZ95dmMTEo+p+jEMaNX7oZQqiTtIXEBUcsHQBTeR
   Q==;
X-IronPort-AV: E=Sophos;i="5.87,220,1631548800"; 
   d="scan'208";a="296901846"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 09 Nov 2021 18:47:27 +0800
IronPort-SDR: 7KZLg3kQs2RsEfuEnw6b61Uy03d+4olnpAiep52Yg1YIQXkjHnwbzOSockEfYWvP732gaeW5zI
 CFSVW5s5MBnpNFrHSWmjLMs7eOz+3zqfN1KqJHYWlDQ0X/sPBEP84Ky6d/cFlISqjoCx4BfPm+
 FZ91wYdljBh3b2ZE4KPgnZr6h7jHcVHwH3o3F6gPsvCRscnSCWmMQHx4Pt1bz0Z1ndzIVtcCno
 9wfPzFXEbjvcBMTrD43AYYRgnnL99dHO8RKqbOpJFVcbcSBnriolRXsuIrjXva3IZwbeVBJzbs
 mFdSsoFOBskBBQ7xKmUWx6ps
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2021 02:22:39 -0800
IronPort-SDR: QO0WCBCaAvS4U7eI9RRX80kDowLv+KGD/rUvpw2+Nxgea3xhR4/d7ZanKTuBuNiuFdop0uA1C8
 BvWsysxyRv4hX6CsCvu6QT30S0DrOXs+ud/cZNiisn2XDIBvQUwkmKGbZ+zeQcZht2sYFlAdN3
 hu6qKtQNAQFicft8/rrN0t5i7syRpNLjUz062Ptn9pDANNZEoU0FdFUUVH7kWn1SMicZiF8ojX
 BFN0N0SdLEbG0F1W8cS7PPJwK+LniHix3G/PwyIalZFhwJn1Dw/RcAE7g2FWS4B94eGrhH8Ejw
 tic=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.52.173])
  by uls-op-cesaip01.wdc.com with ESMTP; 09 Nov 2021 02:47:27 -0800
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc:     Jan Kara <jack@suse.cz>, Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH 2/2] block: Hold invalidate_lock in BLKZEROOUT ioctl
Date:   Tue,  9 Nov 2021 19:47:23 +0900
Message-Id: <20211109104723.835533-3-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211109104723.835533-1-shinichiro.kawasaki@wdc.com>
References: <20211109104723.835533-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When BLKZEROOUT ioctl and data read race, the data read leaves stale
page cache. To avoid the stale page cache, hold invalidate_lock of the
block device file mapping. The stale page cache is observed when
blktests test case block/009 is modified to call "blkdiscard -z" command
and repeated hundreds of times.

This patch can be applied back to the stable kernel version v5.15.y.
Rework is required for older stable kernels.

Fixes: 22dd6d356628 ("block: invalidate the page cache when issuing BLKZEROOUT")
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: stable@vger.kernel.org # v5.15
---
 block/ioctl.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/block/ioctl.c b/block/ioctl.c
index 9fa87f64f703..0a1d10ac2e1a 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -154,6 +154,7 @@ static int blk_ioctl_zeroout(struct block_device *bdev, fmode_t mode,
 {
 	uint64_t range[2];
 	uint64_t start, end, len;
+	struct inode *inode = bdev->bd_inode;
 	int err;
 
 	if (!(mode & FMODE_WRITE))
@@ -176,12 +177,17 @@ static int blk_ioctl_zeroout(struct block_device *bdev, fmode_t mode,
 		return -EINVAL;
 
 	/* Invalidate the page cache, including dirty pages */
+	filemap_invalidate_lock(inode->i_mapping);
 	err = truncate_bdev_range(bdev, mode, start, end);
 	if (err)
-		return err;
+		goto fail;
+
+	err = blkdev_issue_zeroout(bdev, start >> 9, len >> 9, GFP_KERNEL,
+				   BLKDEV_ZERO_NOUNMAP);
 
-	return blkdev_issue_zeroout(bdev, start >> 9, len >> 9, GFP_KERNEL,
-			BLKDEV_ZERO_NOUNMAP);
+fail:
+	filemap_invalidate_unlock(inode->i_mapping);
+	return err;
 }
 
 static int put_ushort(unsigned short __user *argp, unsigned short val)
-- 
2.33.1

