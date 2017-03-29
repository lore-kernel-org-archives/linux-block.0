Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:33767 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756023AbdC2K43 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Mar 2017 06:56:29 -0400
From: Jan Kara <jack@suse.cz>
To: <linux-fsdevel@vger.kernel.org>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH 02/25] block: Unregister bdi on last reference drop
Date: Wed, 29 Mar 2017 12:56:00 +0200
Message-Id: <20170329105623.18241-3-jack@suse.cz>
In-Reply-To: <20170329105623.18241-1-jack@suse.cz>
References: <20170329105623.18241-1-jack@suse.cz>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Most users will want to unregister bdi when dropping last reference to a
bdi. Only a few users (like block devices) want to play more complex
tricks with bdi registration and unregistration. So unregister bdi when
the last reference to bdi is dropped and just make sure we don't
unregister the bdi the second time if it is already unregistered.

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
2.10.2
