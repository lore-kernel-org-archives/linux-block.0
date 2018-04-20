Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:47216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752771AbeDTX7L (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 20 Apr 2018 19:59:11 -0400
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org
Cc: jack@suse.cz, bart.vanassche@wdc.com, ming.lei@redhat.com,
        rjw@rjwysocki.net, mguzik@redhat.com, linux-pm@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: [PATCH 1/3] fs: move documentation for thaw_super() where appropriate
Date: Fri, 20 Apr 2018 16:59:02 -0700
Message-Id: <20180420235904.27496-2-mcgrof@kernel.org>
In-Reply-To: <20180420235904.27496-1-mcgrof@kernel.org>
References: <20180420235904.27496-1-mcgrof@kernel.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On commit 08fdc8a0138a ("buffer.c: call thaw_super during emergency thaw")
Mateusz added thaw_super_locked() and made thaw_super() use it, but
forgot to move the documentation.

Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
---
 fs/super.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index 5fa9a8d8d865..9d0eb5e20a1f 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1532,12 +1532,6 @@ int freeze_super(struct super_block *sb)
 }
 EXPORT_SYMBOL(freeze_super);
 
-/**
- * thaw_super -- unlock filesystem
- * @sb: the super to thaw
- *
- * Unlocks the filesystem and marks it writeable again after freeze_super().
- */
 static int thaw_super_locked(struct super_block *sb)
 {
 	int error;
@@ -1573,6 +1567,12 @@ static int thaw_super_locked(struct super_block *sb)
 	return 0;
 }
 
+/**
+ * thaw_super -- unlock filesystem
+ * @sb: the super to thaw
+ *
+ * Unlocks the filesystem and marks it writeable again after freeze_super().
+ */
 int thaw_super(struct super_block *sb)
 {
 	down_write(&sb->s_umount);
-- 
2.16.3
