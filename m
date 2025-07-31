Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919082248AC
	for <linux-block@vger.kernel.org>; Thu, 31 Jul 2025 11:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753960076; cv=none; b=KBfsLh9xQS3lc3b60BGO0/qIpM89X+4e/x/7ha0u68QfXvTmuen0I7ftc8mFyG/P7TyS8WPSK9tw3LKykqATPfRlDRgemjIJ6HSI16Oe3gfmidaVUjEgBEyjOGjUIThtCd9ZRaBOE5/nGs/tcoJ9jlD/kW4lIm5b4SoLPzs6S4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753960076; c=relaxed/simple;
	bh=hD4mG4bH6EgPXmUIEpf1aRwgzJyfjmfnBylsvDs29/s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SvpDRWa5GWg4GrCYSG2MSyRT//TKAKGwB/gGoARwxJgxa+gqPoXkPW4xdq0+PsrBnVQ0bvoo9Auz4YNZQ0QAhd+AQ8B2ddEUhv+Xf0MX6dD9n4PGAsjCYnExKLqu6kh0ooKXVJRd0O3BjU3pd5LnDTRnJwieWWc18KekfV3Lx6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=FWgHnEwp; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="FWgHnEwp"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1753960074; x=1785496074;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=hD4mG4bH6EgPXmUIEpf1aRwgzJyfjmfnBylsvDs29/s=;
  b=FWgHnEwp3LCjk7nZ/mRimpqSYr2iJpEm0G12HWlzbPFWyBbx4eWzS9Du
   GqF7zpeceOJ1k3rhYZogOygZqYcoI+7zK0i++c3xvPXcANqARB657uCn2
   gtWx/zQglXpV97egUXPKvTnH1Z62/lwknKhl3MoT/ePcPC6iSUfN1PeQ6
   WPH3Ng/So1QIu0QGp/I8VvYZ1JfpazoaKuhCEuRZtjZ1e2UByNQGzwd8p
   MAe4DDBjpvKJQFrkBBqE+7EArKKV0RoRHY29HDtxan7ayTEDCWdnysCKe
   rMnubEaOCoTeC9mXqyQeWZxnjcDECBEibaefuPkdedvOY4w/qUGRoEHzJ
   A==;
X-CSE-ConnectionGUID: sDO29UhNS5Km0Iv8seNBvg==
X-CSE-MsgGUID: hglLpTySSyuP8u7CpN1zvg==
X-IronPort-AV: E=Sophos;i="6.16,353,1744041600"; 
   d="scan'208";a="106069309"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 31 Jul 2025 19:07:53 +0800
IronPort-SDR: PuKvwERlPMCyqZD31bspZyBzfo+bn2ijc4GWh/6s7QifLRFY/T+Z07LODlBN7PdDwAA7Xll9LG
 jztl5tociiI6aXYhMW8hP2R/RtdG29tAfWQHs9X5CJ/AxUqg564i8P4x5WHwTwR7n+zi9f82P1
 o2orOUd3gAzx01EVp2kvjSGx9VkA8L3TN/lZrUJfevBFIyIUqSeZryAN3KMp32JWxyoLxAov3Y
 CxSMgbaW7B78A+dGvmZ2A1CGr0u0GgP+uCw8sxikMOaBGC26stJgyxFonWAgMoObssTBu2A/yy
 pX0=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 31 Jul 2025 03:04:04 -0700
WDCIronportException: Internal
Received: from wdap-hbkxphu7b7.ad.shared (HELO shinmob.wdc.com) ([10.224.163.9])
  by uls-op-cesaip02.wdc.com with ESMTP; 31 Jul 2025 04:07:46 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH] zloop: fix KASAN use-after-free of tag set
Date: Thu, 31 Jul 2025 20:07:45 +0900
Message-ID: <20250731110745.165751-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a zoned loop device, or zloop device, is removed, KASAN enabled
kernel reports "BUG KASAN use-after-free" in blk_mq_free_tag_set(). The
BUG happens because zloop_ctl_remove() calls put_disk(), which invokes
zloop_free_disk(). The zloop_free_disk() frees the memory allocated for
the zlo pointer. However, after the memory is freed, zloop_ctl_remove()
calls blk_mq_free_tag_set(&zlo->tag_set), which accesses the freed zlo.
Hence the KASAN use-after-free.

 zloop_ctl_remove()
  put_disk(zlo->disk)
   put_device()
    kobject_put()
     ...
      zloop_free_disk()
        kvfree(zlo)
  blk_mq_free_tag_set(&zlo->tag_set)

To avoid the BUG, move the call to blk_mq_free_tag_set(&zlo->tag_set)
from zloop_ctl_remove() into zloop_free_disk(). This ensures that
the tag_set is freed before the call to kvfree(zlo).

Fixes: eb0570c7df23 ("block: new zoned loop block device driver")
CC: stable@vger.kernel.org
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 drivers/block/zloop.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/block/zloop.c b/drivers/block/zloop.c
index 553b1a713ab9..a423228e201b 100644
--- a/drivers/block/zloop.c
+++ b/drivers/block/zloop.c
@@ -700,6 +700,8 @@ static void zloop_free_disk(struct gendisk *disk)
 	struct zloop_device *zlo = disk->private_data;
 	unsigned int i;
 
+	blk_mq_free_tag_set(&zlo->tag_set);
+
 	for (i = 0; i < zlo->nr_zones; i++) {
 		struct zloop_zone *zone = &zlo->zones[i];
 
@@ -1080,7 +1082,6 @@ static int zloop_ctl_remove(struct zloop_options *opts)
 
 	del_gendisk(zlo->disk);
 	put_disk(zlo->disk);
-	blk_mq_free_tag_set(&zlo->tag_set);
 
 	pr_info("Removed device %d\n", opts->id);
 
-- 
2.50.1

