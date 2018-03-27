Return-Path: <linux-fsdevel-owner@vger.kernel.org>
From: Omar Sandoval <osandov@osandov.com>
To: linux-block@vger.kernel.org
Cc: Jens Axboe <axboe@fb.com>, kernel-team@fb.com,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 0/2] loop: don't hang on lo_ctl_mutex in ioctls
Date: Mon, 26 Mar 2018 21:39:10 -0700
Message-Id: <cover.1522125370.git.osandov@fb.com>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

From: Omar Sandoval <osandov@fb.com>

Hi, Jens,

We hit an issue where a loop device on NFS (yes, I know) got stuck and a
bunch of losetup processes got stuck in uninterruptible sleep waiting
for lo_ctl_mutex as a result. Calling into the filesystem while holding
lo_ctl_mutex isn't necessary, and there's no reason to be
uninterruptible here. These two patches fix this issue, based on your
for-next branch.

Changed from v1: use mutex_lock_killable() instead of
mutex_lock_interruptible().

Thanks!

Omar Sandoval (2):
  loop: don't call into filesystem while holding lo_ctl_mutex
  loop: use killable lock in ioctls

 drivers/block/loop.c | 65 +++++++++++++++++++++++++++++++++-------------------
 1 file changed, 42 insertions(+), 23 deletions(-)

-- 
2.16.2
