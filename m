Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34689 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S942779AbcJ2IOI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 29 Oct 2016 04:14:08 -0400
From: Ming Lei <tom.leiming@gmail.com>
To: Jens Axboe <axboe@fb.com>, linux-kernel@vger.kernel.org
Cc: linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Ming Lei <tom.leiming@gmail.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        dm-devel@redhat.com (maintainer:DEVICE-MAPPER (LVM)),
        Shaohua Li <shli@kernel.org>,
        linux-raid@vger.kernel.org (open list:SOFTWARE RAID (Multiple Disks)
        SUPPORT)
Subject: [PATCH 29/60] dm: limit the max bio size as BIO_SP_MAX_SECTORS << SECTOR_SHIFT
Date: Sat, 29 Oct 2016 16:08:28 +0800
Message-Id: <1477728600-12938-30-git-send-email-tom.leiming@gmail.com>
In-Reply-To: <1477728600-12938-1-git-send-email-tom.leiming@gmail.com>
References: <1477728600-12938-1-git-send-email-tom.leiming@gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

For BIO based DM, some targets aren't ready for dealing with
bigger incoming bio than 1Mbyte, such as crypt and log write
targets.

Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 drivers/md/dm.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index ef7bf1dd6900..ce454c6c1a4e 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -899,7 +899,16 @@ int dm_set_target_max_io_len(struct dm_target *ti, sector_t len)
 		return -EINVAL;
 	}
 
-	ti->max_io_len = (uint32_t) len;
+	/*
+	 * BIO based queue uses its own splitting. When multipage bvecs
+	 * is switched on, size of the incoming bio may be too big to
+	 * be handled in some targets, such as crypt and log write.
+	 *
+	 * When these targets are ready for the big bio, we can remove
+	 * the limit.
+	 */
+	ti->max_io_len = min_t(uint32_t, len,
+			       BIO_SP_MAX_SECTORS << SECTOR_SHIFT);
 
 	return 0;
 }
-- 
2.7.4

