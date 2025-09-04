Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7086B28934F;
	Thu,  4 Sep 2025 08:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756973879; cv=none; b=NNSvi9i29PihlUq1jFQYCJ6gRTilHGyXj/2YAjJNu744fFEoEJGfONw3a6jMa7KORfeBhAN1kdWlFvJbqK7ZEIx3BSl2Lak/ohtuLlVr7jxYo8sKHkb0OS9gOqz/1C8ex/DGS+mMdLI2vrqyITqQeZLV7HPaEnBsAnpjKNRm79I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756973879; c=relaxed/simple;
	bh=iB8zf4ILLJtrhXWACql/9RfpikVB1vZodKodgHO7l2M=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=q7Je1wpqpOQcAFE229981K/ijP7BqWME44sM0cLIiMwHeBf4lAJ0tDwzvvK8nMsYbGqiQS5uTSrkHJ7QnFWRKswot/FA1VfYfDtl2KQrYUwmKdiHcWhBWf2UTqILQW4IBhl3VOfAhQNV6DxLvhWyGR+4AIWN3G99MhQLHM3o5xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=KUwYP7X/; arc=none smtp.client-ip=162.62.57.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="KUwYP7X/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1756973864;
	bh=gkJTf2c1jzQR5OVVEr7uU0ySLW7GWWkeJTjOv6J6hGk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KUwYP7X/0SLY51bF3laX/H+jmhb3g25s0lnndGhL2sGBD/M1PSJO4wAlcMju7HbZv
	 Fx5ehgaLpPbaSMiWKFYyVf9Nx4MrFUVUv5WBxPFe1hOgVmpjE1W2+gTWvPqzge98Db
	 ZnASVxnepi0RAb8fvDR9UGavce7uhwHwX4uYDgfE=
Received: from SSOC3-SH.company.local ([58.33.109.195])
	by newxmesmtplogicsvrszc41-0.qq.com (NewEsmtp) with SMTP
	id 45E044AB; Thu, 04 Sep 2025 16:17:30 +0800
X-QQ-mid: xmsmtpt1756973850tuug394uz
Message-ID: <tencent_2B678DA920124B08854638A6BE68746CCC05@qq.com>
X-QQ-XMAILINFO: N2bAIxLK0elnhXEhPkfXE/RSi6PihdH4cXUbzQ0GGcOAG32Qhxgni3WQaKSVHI
	 pRmntZwJtpUeAE507+g9Q3g63Y1T3y/vhMZD89SZnn3YZU02ZWLUFmBVRDfAOZlJ+uc9J5bcvgIs
	 zJ4nqLuVLpnWZTqtVjLJ3Bht2UOxsZDhcmRX22rY+43hd/4aZkfRamGs2A08Z33vlXXykWuMwSH+
	 0ZnJcBS3ey5ABVx8sojnRJMubsSHhFtfJKzU6Y8kULz4hitlNKsSMZL0WUX8+67ioGjd7S5Vmyls
	 xWUDbLrpEK7J54PYb4/Whw/24gpXmpAkfifO60NUDScQQ5SHIdarpFRKVcFd0WFM5aUgt3kUsMoO
	 SrLctRWZOORFmz7165O4nVhiX3RoAwyJ26IfYO+JIgbI5/t3XaA1ZxD27xsJhxxVGn/ebkcR76v7
	 34GTasWshqzU9DT35H8u3PhYYCcYVEDmtiXm8DYOqELECFBgSPPPLxzehYvcAqJbvxubG5YHDPLf
	 p4wKJZ/FKyLHjpag+h6boHAQylzevEgsTDhpm94z3VHosp5lWqzRLkhUBBguCM927sbgdt5QjGun
	 3gc9oj89FEXWdrfWobXcm6TqZw6ub1whPa/PXB+91E4lldSViMrh5GVnfwITqcbyL7lCuTaBKlG1
	 gfhAWSx40P16RvU6XDYteu7PKjs5YYeAsVqwfNHXuZZz5OOvL9e9dcm+/6eL3n8cS3Yi14ZR3X3D
	 DDouRsD/ehhXjU6AU2NAMoz9dTZVWGFhLNF/r9iCIF81MmYGC7Kc9FQ2DB19hqQXDTDf6Ah3OMqo
	 GyxScuPL6sxvUP0dmhEExoWd78A9/7dvofok+bCZBOKpOY/lRN8gajzTYnMdRtOGH+RvoQk0VWG0
	 aKJhrIcoplhIIl7k8RthT2oOmfAZ3eSKgx6Ur7za3/jEheYTA7nzgsOz4Z4DAYHNY/qblYSdVjzy
	 RCLziPTySMPuin2F9eEgSkYTdYk05TfkPgQXzj3imHCs0TgoXXPOAQS6720M0x
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: Han Guangjiang <gj.han@foxmail.com>
To: yukuai1@huaweicloud.com,
	Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org (open list:BLOCK LAYER),
	linux-kernel@vger.kernel.org (open list)
Cc: hanguangjiang@lixiang.com,
	fanggeng@lixiang.com,
	yangchen11@lixiang.com,
	liangjie@lixiang.com
Subject: [PATCH v2] blk-throttle: fix access race during throttle policy activation
Date: Thu,  4 Sep 2025 16:17:26 +0800
X-OQ-MSGID: <20250904081727.3975758-1-gj.han@foxmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <59464ad0-856c-4ec3-b5b7-e7799c337a84@yukuai.org.cn>
References: <59464ad0-856c-4ec3-b5b7-e7799c337a84@yukuai.org.cn>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Han Guangjiang <hanguangjiang@lixiang.com>

On repeated cold boots we occasionally hit a NULL pointer crash in
blk_should_throtl() when throttling is consulted before the throttle
policy is fully enabled for the queue. Checking only q->td != NULL is
insufficient during early initialization, so blkg_to_pd() for the
throttle policy can still return NULL and blkg_to_tg() becomes NULL,
which later gets dereferenced.

 Unable to handle kernel NULL pointer dereference
 at virtual address 0000000000000156
 ...
 pc : submit_bio_noacct+0x14c/0x4c8
 lr : submit_bio_noacct+0x48/0x4c8
 sp : ffff800087f0b690
 x29: ffff800087f0b690 x28: 0000000000005f90 x27: ffff00068af393c0
 x26: 0000000000080000 x25: 000000000002fbc0 x24: ffff000684ddcc70
 x23: 0000000000000000 x22: 0000000000000000 x21: 0000000000000000
 x20: 0000000000080000 x19: ffff000684ddcd08 x18: ffffffffffffffff
 x17: 0000000000000000 x16: ffff80008132a550 x15: 0000ffff98020fff
 x14: 0000000000000000 x13: 1fffe000d11d7021 x12: ffff000688eb810c
 x11: ffff00077ec4bb80 x10: ffff000688dcb720 x9 : ffff80008068ef60
 x8 : 00000a6fb8a86e85 x7 : 000000000000111e x6 : 0000000000000002
 x5 : 0000000000000246 x4 : 0000000000015cff x3 : 0000000000394500
 x2 : ffff000682e35e40 x1 : 0000000000364940 x0 : 000000000000001a
 Call trace:
  submit_bio_noacct+0x14c/0x4c8
  verity_map+0x178/0x2c8
  __map_bio+0x228/0x250
  dm_submit_bio+0x1c4/0x678
  __submit_bio+0x170/0x230
  submit_bio_noacct_nocheck+0x16c/0x388
  submit_bio_noacct+0x16c/0x4c8
  submit_bio+0xb4/0x210
  f2fs_submit_read_bio+0x4c/0xf0
  f2fs_mpage_readpages+0x3b0/0x5f0
  f2fs_readahead+0x90/0xe8

Tighten blk_throtl_activated() to also require that the throttle policy
bit is set on the queue:

  return q->td != NULL &&
         test_bit(blkcg_policy_throtl.plid, q->blkcg_pols);

This prevents blk_should_throtl() from accessing throttle group state
until policy data has been attached to blkgs.

Fixes: a3166c51702b ("blk-throttle: delay initialization until configuration")
Co-developed-by: Liang Jie <liangjie@lixiang.com>
Signed-off-by: Liang Jie <liangjie@lixiang.com>
Signed-off-by: Han Guangjiang <hanguangjiang@lixiang.com>
---
v2:
 - remove the comment about freeze queue in blk_should_throtl()
 - Retitle: "blk-throttle: fix access race during throttle policy activation"
---
 block/blk-throttle.h | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/block/blk-throttle.h b/block/blk-throttle.h
index 3b27755bfbff..fbf97c531c48 100644
--- a/block/blk-throttle.h
+++ b/block/blk-throttle.h
@@ -156,7 +156,7 @@ void blk_throtl_cancel_bios(struct gendisk *disk);
 
 static inline bool blk_throtl_activated(struct request_queue *q)
 {
-	return q->td != NULL;
+	return q->td != NULL && test_bit(blkcg_policy_throtl.plid, q->blkcg_pols);
 }
 
 static inline bool blk_should_throtl(struct bio *bio)
@@ -164,11 +164,6 @@ static inline bool blk_should_throtl(struct bio *bio)
 	struct throtl_grp *tg;
 	int rw = bio_data_dir(bio);
 
-	/*
-	 * This is called under bio_queue_enter(), and it's synchronized with
-	 * the activation of blk-throtl, which is protected by
-	 * blk_mq_freeze_queue().
-	 */
 	if (!blk_throtl_activated(bio->bi_bdev->bd_queue))
 		return false;
 
-- 
2.25.1

