Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:47232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752775AbeDTX7L (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 20 Apr 2018 19:59:11 -0400
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org
Cc: jack@suse.cz, bart.vanassche@wdc.com, ming.lei@redhat.com,
        rjw@rjwysocki.net, mguzik@redhat.com, linux-pm@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: [PATCH 2/3] fs: make thaw_super_locked() really just a helper
Date: Fri, 20 Apr 2018 16:59:03 -0700
Message-Id: <20180420235904.27496-3-mcgrof@kernel.org>
In-Reply-To: <20180420235904.27496-1-mcgrof@kernel.org>
References: <20180420235904.27496-1-mcgrof@kernel.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

thaw_super_locked() was added via commit 08fdc8a0138a ("buffer.c: call
thaw_super during emergency thaw") merged on v4.17 to help with the
ability so that the caller can take charge of handling the s_umount lock,
however, it has left all* of the failure handling including unlocking
lock of s_umount inside thaw_super_locked().

This does not make thaw_super_locked() flexible. For instance we may
later want to use it with the abilty to handle unfolding of the locks
ourselves.

Change thaw_super_locked() to really just be a helper, and let the
callers deal with all the error handling.

This commit introeuces no functional changes.

Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
---
 fs/super.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index 9d0eb5e20a1f..82bc74a16f06 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -937,10 +937,15 @@ void emergency_remount(void)
 
 static void do_thaw_all_callback(struct super_block *sb)
 {
+	int error;
+
 	down_write(&sb->s_umount);
 	if (sb->s_root && sb->s_flags & MS_BORN) {
 		emergency_thaw_bdev(sb);
-		thaw_super_locked(sb);
+		error = thaw_super_locked(sb);
+		if (error)
+			up_write(&sb->s_umount);
+		deactivate_locked_super(sb);
 	} else {
 		up_write(&sb->s_umount);
 	}
@@ -1532,14 +1537,13 @@ int freeze_super(struct super_block *sb)
 }
 EXPORT_SYMBOL(freeze_super);
 
+/* Caller takes the sb->s_umount rw_semaphore lock and handles active count */
 static int thaw_super_locked(struct super_block *sb)
 {
 	int error;
 
-	if (sb->s_writers.frozen != SB_FREEZE_COMPLETE) {
-		up_write(&sb->s_umount);
+	if (sb->s_writers.frozen != SB_FREEZE_COMPLETE)
 		return -EINVAL;
-	}
 
 	if (sb_rdonly(sb)) {
 		sb->s_writers.frozen = SB_UNFROZEN;
@@ -1554,7 +1558,6 @@ static int thaw_super_locked(struct super_block *sb)
 			printk(KERN_ERR
 				"VFS:Filesystem thaw failed\n");
 			lockdep_sb_freeze_release(sb);
-			up_write(&sb->s_umount);
 			return error;
 		}
 	}
@@ -1563,7 +1566,6 @@ static int thaw_super_locked(struct super_block *sb)
 	sb_freeze_unlock(sb);
 out:
 	wake_up(&sb->s_writers.wait_unfrozen);
-	deactivate_locked_super(sb);
 	return 0;
 }
 
@@ -1575,7 +1577,18 @@ static int thaw_super_locked(struct super_block *sb)
  */
 int thaw_super(struct super_block *sb)
 {
+	int error;
+
 	down_write(&sb->s_umount);
-	return thaw_super_locked(sb);
+	error = thaw_super_locked(sb);
+	if (error) {
+		up_write(&sb->s_umount);
+		goto out;
+	}
+
+	deactivate_locked_super(sb);
+
+out:
+	return error;
 }
 EXPORT_SYMBOL(thaw_super);
-- 
2.16.3
