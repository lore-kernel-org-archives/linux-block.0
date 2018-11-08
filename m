Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:34090 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726927AbeKHWgq (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 8 Nov 2018 17:36:46 -0500
From: Jan Kara <jack@suse.cz>
To: Jens Axboe <axboe@kernel.dk>
Cc: <linux-block@vger.kernel.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH 16/16] loop: Get rid of 'nested' acquisition of loop_ctl_mutex
Date: Thu,  8 Nov 2018 14:01:16 +0100
Message-Id: <20181108130116.12140-17-jack@suse.cz>
In-Reply-To: <20181108130116.12140-1-jack@suse.cz>
References: <20181108130116.12140-1-jack@suse.cz>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

The nested acquisition of loop_ctl_mutex (->lo_ctl_mutex back then) has
been introduced by commit f028f3b2f987e "loop: fix circular locking in
loop_clr_fd()" to fix lockdep complains about bd_mutex being acquired
after lo_ctl_mutex during partition rereading. Now that these are
properly fixed, let's stop fooling lockdep.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 drivers/block/loop.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 112afc9bc604..bf6bc35aaf88 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -681,7 +681,7 @@ static int loop_change_fd(struct loop_device *lo, struct block_device *bdev,
 	int		error;
 	bool		partscan;
 
-	error = mutex_lock_killable_nested(&loop_ctl_mutex, 1);
+	error = mutex_lock_killable(&loop_ctl_mutex);
 	if (error)
 		return error;
 	error = -ENXIO;
@@ -919,7 +919,7 @@ static int loop_set_fd(struct loop_device *lo, fmode_t mode,
 	if (!file)
 		goto out;
 
-	error = mutex_lock_killable_nested(&loop_ctl_mutex, 1);
+	error = mutex_lock_killable(&loop_ctl_mutex);
 	if (error)
 		goto out_putf;
 
@@ -1135,7 +1135,7 @@ static int loop_clr_fd(struct loop_device *lo)
 {
 	int err;
 
-	err = mutex_lock_killable_nested(&loop_ctl_mutex, 1);
+	err = mutex_lock_killable(&loop_ctl_mutex);
 	if (err)
 		return err;
 	if (lo->lo_state != Lo_bound) {
@@ -1172,7 +1172,7 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 	struct block_device *bdev;
 	bool partscan = false;
 
-	err = mutex_lock_killable_nested(&loop_ctl_mutex, 1);
+	err = mutex_lock_killable(&loop_ctl_mutex);
 	if (err)
 		return err;
 	if (lo->lo_encrypt_key_size &&
@@ -1277,7 +1277,7 @@ loop_get_status(struct loop_device *lo, struct loop_info64 *info)
 	struct kstat stat;
 	int ret;
 
-	ret = mutex_lock_killable_nested(&loop_ctl_mutex, 1);
+	ret = mutex_lock_killable(&loop_ctl_mutex);
 	if (ret)
 		return ret;
 	if (lo->lo_state != Lo_bound) {
@@ -1466,7 +1466,7 @@ static int lo_simple_ioctl(struct loop_device *lo, unsigned int cmd,
 {
 	int err;
 
-	err = mutex_lock_killable_nested(&loop_ctl_mutex, 1);
+	err = mutex_lock_killable(&loop_ctl_mutex);
 	if (err)
 		return err;
 	switch (cmd) {
-- 
2.16.4
