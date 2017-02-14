Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-ot0-f195.google.com ([74.125.82.195]:34757 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754460AbdBNP3T (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Feb 2017 10:29:19 -0500
From: Ming Lei <tom.leiming@gmail.com>
To: Shaohua Li <shli@kernel.org>, Jens Axboe <axboe@fb.com>,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        NeilBrown <neilb@suse.com>
Cc: Ming Lei <tom.leiming@gmail.com>
Subject: [PATCH v2 2/5] md: fail if mddev->bio_set can't be created
Date: Tue, 14 Feb 2017 23:29:00 +0800
Message-Id: <1487086143-10255-3-git-send-email-tom.leiming@gmail.com>
In-Reply-To: <1487086143-10255-1-git-send-email-tom.leiming@gmail.com>
References: <1487086143-10255-1-git-send-email-tom.leiming@gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

The current behaviour is to fall back to allocate
bio from 'fs_bio_set', that isn't a correct way
because it might cause deadlock.

So this patch simply return failure if mddev->bio_set
can't be created.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 drivers/md/md.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 7e9a495e4160..b5e2adf3493b 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -5228,8 +5228,11 @@ int md_run(struct mddev *mddev)
 		sysfs_notify_dirent_safe(rdev->sysfs_state);
 	}
 
-	if (mddev->bio_set == NULL)
+	if (mddev->bio_set == NULL) {
 		mddev->bio_set = bioset_create(BIO_POOL_SIZE, 0);
+		if (!mddev->bio_set)
+			return -ENOMEM;
+	}
 
 	spin_lock(&pers_lock);
 	pers = find_pers(mddev->level, mddev->clevel);
-- 
2.7.4
