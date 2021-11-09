Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD725C433F5
	for <linux-block@archiver.kernel.org>; Tue,  9 Nov 2021 10:47:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4E5561131
	for <linux-block@archiver.kernel.org>; Tue,  9 Nov 2021 10:47:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbhKIKuM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 9 Nov 2021 05:50:12 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:41961 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231173AbhKIKuL (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 Nov 2021 05:50:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1636454846; x=1667990846;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TvEJR52VpTseyGuwEn/1dM85pl7YDY52MtV5VZuDI8w=;
  b=ZgnTqBxVhCKD9aPud95sEZrSZFOmhF8sYUGajgRu+hX/8oHo3RRpWCH/
   NFaI03LHhj9X1BjOZHTvFJfeyHVZ+n5U0oDOMC76NQFBvABwnYJu0sR1k
   7Aro3Va1jF34JajI/J5OQouD9F2lHQ1KtFis9+ZTLU4jlMkHwuUprSgAr
   tKr+ymqmOZZDL9JEPiB+6f378Kg+QmjlSIRou+yYUesH/VzjqEn6nuNv2
   +EuH19mBGO30p701CXdwTbLgQUglzSBJa5c7nDsvNw0m2UNTgJjCyqCk4
   FT14Go62ssX8zWXo3VBcB7m9RpZ39P6S8XZefEN/isIV1gwLka3enZNUS
   Q==;
X-IronPort-AV: E=Sophos;i="5.87,220,1631548800"; 
   d="scan'208";a="296901845"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 09 Nov 2021 18:47:26 +0800
IronPort-SDR: aQqXPkYV5+9NnDNrU8Zs5isa78fMaM5BlXmdOhGwx6zWS6cPVdEpxT1lK5OstT4kVr8WKlXyKO
 6x8igtcE+N4w8t3RRAvOZarh98f9mn3MdSx73OAjviF4bu3sHiccHFU8up4KD+qrRCDVgbSxam
 gpyP3DDC+gOQxiwe64HbzsVDCLWMXgKqPtLWe1SMsmhDmY2oiyGtyRmuO0a2fxBGzKPlSGEfsF
 B+E10C6hGPm4MfLfqDp3ANZ8lQfQpkXNiAniJVAGscoFMMKCIFFqY/PSjglMr+hNQjVJs8Wids
 fHGoah/VaVqJ3NyMz0KS3Xmj
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2021 02:22:38 -0800
IronPort-SDR: D5pNxYDy3HRoYpT070hWqMEvjgyZsBUVm25TUwUSjogBxcKq15vfpWcON4xVfboaDNme72TyTo
 hvfxLVRQaDlMSxbEPPeEy4V7zBw/92MLSs+PX3h4du1nL2Nsg0E/bKIBKdocj6gUGDQ2V3ifI/
 fLU7A59yhI3hxBacolqCo703zjW3BL4j+EXcyVkZ3lvh97nwxhgSkjVkZmV9UGnPQ9UwpAildL
 FjdAlPiqtfoLa0jYpTCug3ypTnj/fABQeS3+GXS+v7fBeFUwZdbOProdle8RTrzNrB+YY1Omhp
 iTg=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.52.173])
  by uls-op-cesaip01.wdc.com with ESMTP; 09 Nov 2021 02:47:26 -0800
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc:     Jan Kara <jack@suse.cz>, Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH 1/2] block: Hold invalidate_lock in BLKDISCARD ioctl
Date:   Tue,  9 Nov 2021 19:47:22 +0900
Message-Id: <20211109104723.835533-2-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211109104723.835533-1-shinichiro.kawasaki@wdc.com>
References: <20211109104723.835533-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When BLKDISCARD ioctl and data read race, the data read leaves stale
page cache. To avoid the stale page cache, hold invalidate_lock of the
block device file mapping. The stale page cache is observed when
blktests test case block/009 is repeated hundreds of times.

This patch can be applied back to the stable kernel version v5.15.y
with slight patch edit. Rework is required for older stable kernels.

Fixes: 351499a172c0 ("block: Invalidate cache on discard v2")
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: stable@vger.kernel.org # v5.15
---
 block/ioctl.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/block/ioctl.c b/block/ioctl.c
index d6af0ac97e57..9fa87f64f703 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -113,6 +113,7 @@ static int blk_ioctl_discard(struct block_device *bdev, fmode_t mode,
 	uint64_t range[2];
 	uint64_t start, len;
 	struct request_queue *q = bdev_get_queue(bdev);
+	struct inode *inode = bdev->bd_inode;
 	int err;
 
 	if (!(mode & FMODE_WRITE))
@@ -135,12 +136,17 @@ static int blk_ioctl_discard(struct block_device *bdev, fmode_t mode,
 	if (start + len > bdev_nr_bytes(bdev))
 		return -EINVAL;
 
+	filemap_invalidate_lock(inode->i_mapping);
 	err = truncate_bdev_range(bdev, mode, start, start + len - 1);
 	if (err)
-		return err;
+		goto fail;
+
+	err = blkdev_issue_discard(bdev, start >> 9, len >> 9,
+				   GFP_KERNEL, flags);
 
-	return blkdev_issue_discard(bdev, start >> 9, len >> 9,
-				    GFP_KERNEL, flags);
+fail:
+	filemap_invalidate_unlock(inode->i_mapping);
+	return err;
 }
 
 static int blk_ioctl_zeroout(struct block_device *bdev, fmode_t mode,
-- 
2.33.1

