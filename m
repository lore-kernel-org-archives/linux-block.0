Return-Path: <jack@suse.cz>
From: Jan Kara <jack@suse.cz>
To: Jens Axboe <axboe@kernel.dk>
Cc: <linux-block@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 02/25] block: Unregister bdi on last reference drop
Date: Wed, 12 Apr 2017 12:24:26 +0200
Message-Id: <20170412102449.16901-3-jack@suse.cz>
In-Reply-To: <20170412102449.16901-1-jack@suse.cz>
References: <20170412102449.16901-1-jack@suse.cz>
List-ID: <linux-block@vger.kernel.org>

Most users will want to unregister bdi when dropping last reference to a
bdi. Only a few users (like block devices) want to play more complex
tricks with bdi registration and unregistration. So unregister bdi when
the last reference to bdi is dropped and just make sure we don't
unregister the bdi the second time if it is already unregistered.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 mm/backing-dev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index e5e0972bdd6f..164ccc93690f 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -961,6 +961,8 @@ static void release_bdi(struct kref *ref)
 	struct backing_dev_info *bdi =
 			container_of(ref, struct backing_dev_info, refcnt);
 
+	if (test_bit(WB_registered, &bdi->wb.state))
+		bdi_unregister(bdi);
 	bdi_exit(bdi);
 	kfree(bdi);
 }
-- 
2.12.0
