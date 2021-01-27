Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F92FC433E6
	for <linux-block@archiver.kernel.org>; Wed, 27 Jan 2021 05:53:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69E0F2070A
	for <linux-block@archiver.kernel.org>; Wed, 27 Jan 2021 05:53:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231585AbhA0Fx0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Jan 2021 00:53:26 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:5785 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235506AbhA0Fiq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Jan 2021 00:38:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611725926; x=1643261926;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3d2QpFwVqA+EAwziR0sxGf4TezRzuprvOs57VuIcJj4=;
  b=ad/nWqaLRZTF3+dlm+Sx0XMP8lS6AYuhsWvhU2m6E5fLNmZqtp9eAryl
   sRYpmWV8HILMaPVVfc3KENR3bHIhPvQ46RD7fYz/0BhZK2qNsw4aYHmuM
   TTBu5BON+sZylB27PnI9/uz7LNbGmGvZARolZZbJQijHNAILMaZKIOPs9
   /AHJCqv/7st/Hk72/4YHIy1rKYU6fbeI7lQImbeqVSWn1d4lCD7Z7GHGI
   /8uVwFNce2YKU0qfu3ZF5O6DyvwVAzc6IZBaLcIO468wQg1l8oRl9WetN
   UCV2ykfAKq0ZZ7F5AXj4CsW3gLQ/yEttBZXrSUGoiAS0KhNu0HG7DvRTs
   g==;
IronPort-SDR: ABxqyQCAyqNBzhvhezXRIjFSzpzT1N/d2Rw7Nzsrd1NscYLVdVbf6FADAZZOaIUMGAb8zG9OAG
 ISuSUDR3+5+wq6DuxBf6+NjUMd/BVVhRhVxEflqSxK7mVzIqQLgUhpz/C6hn9gfUn19Io+M1re
 R2qr5F1l67Mi1rv5wpT+82PkJ+Ur8JqwOa6XejZz0a+T3WdSx3K/952fIAa233GX4ynntQUDgV
 ScMVfV47asvJtSGz5LWRksthEopK7I9323lsS8+wyswmHVOV3+yoS8bCLQmrtrtX4rCFnuzvIC
 ETQ=
X-IronPort-AV: E=Sophos;i="5.79,378,1602518400"; 
   d="scan'208";a="158419055"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 27 Jan 2021 13:37:40 +0800
IronPort-SDR: DMcC1ngxjKv/WpWewRTv/cyUrJCLU2/CALW+51zxSgA+azyMVmD6WybRMTgDHTquJFmq4Z0Da4
 Cylt3lb03JkuRpPWQ+V6DAYlabZWCeOmcAmJfMj13PKO273c1w1xHFwqTocPtQUaOKzzh4mz9A
 zG6+2xkiPc4OyCRLtgXFmh6Q2C1EWx7U9+GjqfRB2uSdC/Y+KuGh1ZVcQ2BN5CNm7kt5b8QoQe
 GUoRZqkTUrxRwsbcG/uI6fuQW6Ci0ZYoi7H1eMBxLoQuJzQj2OIHvPEwkhvJXRInLKre81tIr9
 jbz9ar5u9Fr60TDFQnh8jm66
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2021 21:22:05 -0800
IronPort-SDR: p2RVAto3NVZEFEdYg56+AOpjFxHaZlO32pDzXYz9ZiALpMijuVvecEucsyuBUv+UyZUOOFmqm/
 /aI4710kLPvPyY1kqDU8ku+BZFb7Sg7uNJQunWXBu+6KunD/y61O+xTCe6RV9gNeZopBPpDe5q
 4AfW8wCT4lM1Jdbme/0VwT8+roaRYJzwKuibj85uRQ8c/ctG4Y619e21GKBiBF3s43PKBrnBeg
 Hr/PnkyeIcums+8I5XfC525qYVz0jlLqLcWO7UgP878eS4ROYxgOAg74otvwt629mWP6uqpdwF
 wLE=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 26 Jan 2021 21:37:40 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     axboe@fb.com, hch@lst.de, kbusch@kernel.org,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH] nvme-core: check bdev value for NULL
Date:   Tue, 26 Jan 2021 21:37:38 -0800
Message-Id: <20210127053738.4922-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The nvme-core sets the bdev to NULL when admin comamnd is issued from
IOCTL in the following path e.g. nvme list :-

block_ioctl()
 blkdev_ioctl()
  nvme_ioctl()
   nvme_user_cmd()
    nvme_submit_user_cmd()

The commit 309dca309fc3 ("block: store a block_device pointer in struct bio")
now uses bdev unconditionally in the macro bio_set_dev() and assumes
that bdev value is not NULL which results in the following crash in
since thats where bdev is actually accessed :-

void bio_associate_blkg_from_css(struct bio *bio,
				 struct cgroup_subsys_state *css)
{
	if (bio->bi_blkg)
		blkg_put(bio->bi_blkg);

	if (css && css->parent) {
		bio->bi_blkg = blkg_tryget_closest(bio, css);
	} else {
-------------->	blkg_get(bio->bi_bdev->bd_disk->queue->root_blkg);
		bio->bi_blkg = bio->bi_bdev->bd_disk->queue->root_blkg;
	}
}
EXPORT_SYMBOL_GPL(bio_associate_blkg_from_css);

<1>[  345.385947] BUG: kernel NULL pointer dereference, address: 0000000000000690
<1>[  345.387103] #PF: supervisor read access in kernel mode
<1>[  345.387894] #PF: error_code(0x0000) - not-present page
<6>[  345.388756] PGD 162a2b067 P4D 162a2b067 PUD 1633eb067 PMD 0
<4>[  345.389625] Oops: 0000 [#1] SMP NOPTI
<4>[  345.390206] CPU: 15 PID: 4100 Comm: nvme Tainted: G           OE     5.11.0-rc5blk+ #141
<4>[  345.391377] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-59-gc9ba52764
<4>[  345.393074] RIP: 0010:bio_associate_blkg_from_css.cold.47+0x58/0x21f

<4>[  345.396362] RSP: 0018:ffffc90000dbbce8 EFLAGS: 00010246
<4>[  345.397078] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000027
<4>[  345.398114] RDX: 0000000000000000 RSI: ffff888813be91f0 RDI: ffff888813be91f8
<4>[  345.399039] RBP: ffffc90000dbbd30 R08: 0000000000000001 R09: 0000000000000001
<4>[  345.399950] R10: 0000000064c66670 R11: 00000000ef955201 R12: ffff888812d32800
<4>[  345.401031] R13: 0000000000000000 R14: ffff888113e51540 R15: ffff888113e51540
<4>[  345.401976] FS:  00007f3747f1d780(0000) GS:ffff888813a00000(0000) knlGS:0000000000000000
<4>[  345.402997] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
<4>[  345.403737] CR2: 0000000000000690 CR3: 000000081a4bc000 CR4: 00000000003506e0
<4>[  345.404685] Call Trace:
<4>[  345.405031]  bio_associate_blkg+0x71/0x1c0
<4>[  345.405649]  nvme_submit_user_cmd+0x1aa/0x38e [nvme_core]
<4>[  345.406348]  nvme_user_cmd.isra.73.cold.98+0x54/0x92 [nvme_core]
<4>[  345.407117]  nvme_ioctl+0x226/0x260 [nvme_core]
<4>[  345.407707]  blkdev_ioctl+0x1c8/0x2b0
<4>[  345.408183]  block_ioctl+0x3f/0x50
<4>[  345.408627]  __x64_sys_ioctl+0x84/0xc0
<4>[  345.409117]  do_syscall_64+0x33/0x40
<4>[  345.409592]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
<4>[  345.410233] RIP: 0033:0x7f3747632107

<4>[  345.413125] RSP: 002b:00007ffe461b6648 EFLAGS: 00000206 ORIG_RAX: 0000000000000010
<4>[  345.414086] RAX: ffffffffffffffda RBX: 00000000007b7fd0 RCX: 00007f3747632107
<4>[  345.414998] RDX: 00007ffe461b6650 RSI: 00000000c0484e41 RDI: 0000000000000004
<4>[  345.415966] RBP: 0000000000000004 R08: 00000000007b7fe8 R09: 00000000007b9080
<4>[  345.416883] R10: 00007ffe461b62c0 R11: 0000000000000206 R12: 00000000007b7fd0
<4>[  345.417808] R13: 0000000000000000 R14: 0000000000000003 R15: 0000000000000000

Add a NULL check before we set the bdev for bio.

This issue is found on block/for-next tree.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/host/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index ba5df80881ea..1a3cdc6b1036 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1133,7 +1133,8 @@ static int nvme_submit_user_cmd(struct request_queue *q,
 		if (ret)
 			goto out;
 		bio = req->bio;
-		bio_set_dev(bio, bdev);
+		if (bdev)
+			bio_set_dev(bio, bdev);
 		if (bdev && meta_buffer && meta_len) {
 			meta = nvme_add_user_metadata(bio, meta_buffer, meta_len,
 					meta_seed, write);
-- 
2.22.1

