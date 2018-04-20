Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:47246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752778AbeDTX7M (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 20 Apr 2018 19:59:12 -0400
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org
Cc: jack@suse.cz, bart.vanassche@wdc.com, ming.lei@redhat.com,
        rjw@rjwysocki.net, mguzik@redhat.com, linux-pm@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: [PATCH 3/3] fs: fix corner case race on freeze_bdev() when sb disappears
Date: Fri, 20 Apr 2018 16:59:04 -0700
Message-Id: <20180420235904.27496-4-mcgrof@kernel.org>
In-Reply-To: <20180420235904.27496-1-mcgrof@kernel.org>
References: <20180420235904.27496-1-mcgrof@kernel.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

freeze_bdev() will bail but leave the bd_fsfreeze_count incremented
if the get_active_super() does not find the superblock on our
super_blocks list to match.

This issue has been present since v2.6.29 during the introduction of the
ioctl_fsfreeze() and ioctl_fsthaw() via commit fcccf502540e3 ("filesystem
freeze: implement generic freeze feature").

I am not aware of any existing races which have triggered this
situation, however, if it does trigger it could mean leaving a
superblock with bd_fsfreeze_count always positive.

Fixes: fcccf502540e3 ("filesystem freeze: implement generic freeze feature")
Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
---
 fs/block_dev.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index b54966679833..7a532aa58c07 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -507,8 +507,10 @@ struct super_block *freeze_bdev(struct block_device *bdev)
 	}
 
 	sb = get_active_super(bdev);
-	if (!sb)
+	if (!sb) {
+		bdev->bd_fsfreeze_count--;
 		goto out;
+	}
 	if (sb->s_op->freeze_super)
 		error = sb->s_op->freeze_super(sb);
 	else
-- 
2.16.3
