Return-Path: <linux-block-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:47704 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751543AbdFGJBt (ORCPT
        <rfc822;groupwise-linux-block@vger.kernel.org:0:0>);
        Wed, 7 Jun 2017 05:01:49 -0400
From: James Wang <jnwang@suse.com>
To: axboe@fb.com
Cc: hare@suse.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, mgorman@suse.com,
        James Wang <jnwang@suse.com>
Subject: [PATCH] Fix loop device flush before configure
Date: Wed,  7 Jun 2017 17:01:04 +0800
Message-Id: <20170607090104.17337-1-jnwang@suse.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

This condition check was exist at before commit b5dd2f6047ca ("block: loop:
improve performance via blk-mq") When add MQ support to loop device, it be
removed because the member of '->lo_thread' be removed. And then upstream
add '->worker_task', I think they forget add it to here.

When I install SLES-12 product is base on 4.4 kernel, I found installer will
hang +60 second at scan disks. and I found LVM tools would take this action.
finally I found this problem is more obvious on AMD platform. This problem
will impact all scenarios that scan loop devcies.

When the loop device didn't configure backing file or Request Queue, we
shouldn't to cost a lot of time to flush it.

Testing steps are following:
modprobe loop max_loop=64
dd if=/dev/zero of=disk bs=512 count=200K
for((i=0;i<4;i++))do losetup -f disk; done
mkfs.ext4 -F /dev/loop0
for((i=0;i<4;i++))do mkdir t$i; mount /dev/loop$i t$i;done
for f in `ls /dev/loop[0-9]*|sort`; do \
	echo $f; dd if=$f of=/dev/null  bs=512 count=1; \
	done

Testing data is following:
/dev/loop0	<rpm-4.4.68-2> <+patched>
		8.1217e-05 	8.3842e-05
/dev/loop1
		6.1114e-05 	0.000147979
/dev/loop10
		0.414701 	0.000116564
/dev/loop11
		0.7474 		6.7942e-05
/dev/loop12
		0.747986 	8.9082e-05
/dev/loop13
		0.746532 	7.4799e-05
/dev/loop14
		0.480041 	9.3926e-05
/dev/loop15
		1.26453 	7.2522e-05

>From /dev/loop10 start, loop isn't mounted. but it take more time than
mounted devices. And The data differ by several orders of magnitude.

Reviewed-by: Hannes Reinecke <hare@suse.com>

Signed-off-by: James Wang <jnwang@suse.com>
---
 drivers/block/loop.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 48f6fa6f810e..c1807e91db08 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -625,6 +625,9 @@ static int loop_switch(struct loop_device *lo, struct file *file)
  */
 static int loop_flush(struct loop_device *lo)
 {
+	/* loop not yet configured, no running thread, nothing to flush */
+	if (!lo->worker_task)
+		return 0;
 	return loop_switch(lo, NULL);
 }
 
-- 
2.12.3
