Return-Path: <linux-block-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:48467 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750752AbdFHGGE (ORCPT
        <rfc822;groupwise-linux-block@vger.kernel.org:0:0>);
        Thu, 8 Jun 2017 02:06:04 -0400
From: James Wang <jnwang@suse.com>
To: axboe@fb.com, efault@gmx.de
Cc: ming.lei@redhat.com, hare@suse.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, mgorman@suse.com,
        James Wang <jnwang@suse.com>
Subject: [PATCH] Fix loop device flush before configure
Date: Thu,  8 Jun 2017 14:05:20 +0800
Message-Id: <20170608060520.12179-1-jnwang@suse.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

While installing SLES-12 (based on v4.4), I found that the installer
will stall for 60+ seconds during LVM disk scan.  The root cause was
determined to be the removal of a bound device check in loop_flush()
by commit b5dd2f6047ca ("block: loop: improve performance via blk-mq").

Restoring this check, examining ->lo_state as set by loop_set_fd()
eliminates the bad behavior.

Test method:
modprobe loop max_loop=64
dd if=/dev/zero of=disk bs=512 count=200K
for((i=0;i<4;i++))do losetup -f disk; done
mkfs.ext4 -F /dev/loop0
for((i=0;i<4;i++))do mkdir t$i; mount /dev/loop$i t$i;done
for f in `ls /dev/loop[0-9]*|sort`; do \
	echo $f; dd if=$f of=/dev/null  bs=512 count=1; \
	done

Test output:  stock          patched
/dev/loop0    18.1217e-05    8.3842e-05
/dev/loop1     6.1114e-05    0.000147979
/dev/loop10    0.414701      0.000116564
/dev/loop11    0.7474        6.7942e-05
/dev/loop12    0.747986      8.9082e-05
/dev/loop13    0.746532      7.4799e-05
/dev/loop14    0.480041      9.3926e-05
/dev/loop15    1.26453       7.2522e-05

Note that from loop10 onward, the device is not mounted, yet the
stock kernel consumes several orders of magnitude more wall time
than it does for a mounted device.
(Thanks for Mike Galbraith <efault@gmx.de>, give a changelog review.)

Reviewed-by: Hannes Reinecke <hare@suse.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: James Wang <jnwang@suse.com>
Fixes: b5dd2f6047ca ("block: loop: improve performance via blk-mq")
---
 drivers/block/loop.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 48f6fa6f810e..2e5b8538760c 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -625,6 +625,9 @@ static int loop_switch(struct loop_device *lo, struct file *file)
  */
 static int loop_flush(struct loop_device *lo)
 {
+	/* loop not yet configured, no running thread, nothing to flush */
+	if (lo->lo_state != Lo_bound)
+		return 0;
 	return loop_switch(lo, NULL);
 }
 
-- 
2.12.3
