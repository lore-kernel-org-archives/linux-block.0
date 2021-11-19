Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01625C433F5
	for <linux-block@archiver.kernel.org>; Fri, 19 Nov 2021 02:24:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAD7861AA7
	for <linux-block@archiver.kernel.org>; Fri, 19 Nov 2021 02:24:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232696AbhKSC1w (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 18 Nov 2021 21:27:52 -0500
Received: from pv50p00im-ztdg10021801.me.com ([17.58.6.56]:55136 "EHLO
        pv50p00im-ztdg10021801.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232306AbhKSC1w (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Nov 2021 21:27:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1637288691;
        bh=8vYZO0LWaE15RGe4/pfToj2bMOVx6MxVCPDXTmhGJUk=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=Ninv7MS2Ak0Z760EnJhSr+3LDm8oCxEB0dUSDPbYpGCD38JxRj65CYmDTgkDQ71Wd
         OYHFSwqTYfTIgjTh6dkO0U4XEyyx4hJkviq3rs5QAAg82Da0X2y6JJsfJU0FWBFWM/
         o5e9MQG99zGP5M/0Be9ALnHLPTcxS8DTUxScib4+SLDvGGznGJvdtHYUTva02uKxN+
         IBfqfnCKQ6TZxddyp1fMAUqH9iYoV22zDbO3XCDXG4yY+rGKK3qKdUaIY62pLSKznc
         8Luj2El/R4Ctk/t9JiSEWyLu50QCGQpG3Q68JcpuX4/941eFOq9dGY09eDR3gjkz7a
         kMt38tI2oC47w==
Received: from localhost.localdomain (unknown [58.240.82.166])
        by pv50p00im-ztdg10021801.me.com (Postfix) with ESMTPSA id 4A81E36050F;
        Fri, 19 Nov 2021 02:24:49 +0000 (UTC)
From:   wangyangbo <yangbonis@icloud.com>
To:     axboe@kernel.dk
Cc:     penguin-kernel@i-love.sakura.ne.jp, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, wangyangbo <yangbonis@icloud.com>
Subject: [PATCH] loop: check loop_control_ioctl parameter in range of minor
Date:   Fri, 19 Nov 2021 10:24:07 +0800
Message-Id: <20211119022406.20803-1-yangbonis@icloud.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211118023640.32559-1-yangbonis@icloud.com>
References: <20211118023640.32559-1-yangbonis@icloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.790
 definitions=2021-11-19_01:2021-11-17,2021-11-18 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2009150000 definitions=main-2111190009
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

loop_control_ioctl call add_disk of block layer, but may pass number beyond MAX MINOR.
So check loop_control_ioctl parameter in range of minor, and delete redundant code.

Reproduce:
touch file
losetup /dev/loop1048576 file
losetup /dev/loop0 file

Problem:
sysfs: cannot create duplicate filename '/dev/block/7:0'
CPU: 0 PID: 529 Comm: losetup Not tainted 5.14.16-arch1-1 #1 ad87b876fa2ab6fdbd995dc1c9aab0ad8f767b2c
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
Call Trace:
 dump_stack_lvl+0x46/0x5a
 sysfs_warn_dup.cold+0x17/0x24
 sysfs_do_create_link_sd+0xbe/0xd0
 device_add+0x580/0x970
 ? dev_set_name+0x5b/0x80
 __device_add_disk+0xb5/0x2f0
 loop_add+0x236/0x290 [loop 2ed923fc8fbd84fdc093bf55ac085973636a3936]
 loop_control_ioctl+0x7f/0x1f0 [loop 2ed923fc8fbd84fdc093bf55ac085973636a3936]
 __x64_sys_ioctl+0x82/0xb0
 do_syscall_64+0x5c/0x80
 ? syscall_exit_to_user_mode+0x23/0x40
 ? do_syscall_64+0x69/0x80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7ff3e8ba259b
Code: ff ff ff 85 c0 79 9b 49 c7 c4 ff ff ff ff 5b 5d 4c 89 e0 41 5c c3 66 0f 1f 84 00 00 00 00 00 f3 0f 1e fa b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d a5 a8 0c 00 f7 d8 64 89 01 48
RSP: 002b:00007ffe6d2eaa18 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007ffe6d2eb038 RCX: 00007ff3e8ba259b
RDX: 0000000000000000 RSI: 0000000000004c80 RDI: 0000000000000003
RBP: 00007ffe6d2eaae0 R08: 1999999999999999 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000003
R13: 00007ffe6d2eaa24 R14: 0000560b131bd200 R15: 0000560b131c44a0
---
 drivers/block/loop.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index a154cab6cd98..3b19ffaa63e9 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -2102,11 +2102,6 @@ static int loop_control_remove(int idx)
 	struct loop_device *lo;
 	int ret;
 
-	if (idx < 0) {
-		pr_warn("deleting an unspecified loop device is not supported.\n");
-		return -EINVAL;
-	}
-		
 	/* Hide this loop device for serialization. */
 	ret = mutex_lock_killable(&loop_ctl_mutex);
 	if (ret)
@@ -2145,7 +2140,7 @@ static int loop_control_remove(int idx)
 	return ret;
 }
 
-static int loop_control_get_free(int idx)
+static int loop_control_get_free(void)
 {
 	struct loop_device *lo;
 	int id, ret;
@@ -2168,13 +2163,16 @@ static int loop_control_get_free(int idx)
 static long loop_control_ioctl(struct file *file, unsigned int cmd,
 			       unsigned long parm)
 {
+	if (parm > MINORMASK)
+		pr_warn("ioctl parameter is out of max_minor.\n");
+		return -EINVAL;
 	switch (cmd) {
 	case LOOP_CTL_ADD:
 		return loop_add(parm);
 	case LOOP_CTL_REMOVE:
 		return loop_control_remove(parm);
 	case LOOP_CTL_GET_FREE:
-		return loop_control_get_free(parm);
+		return loop_control_get_free();
 	default:
 		return -ENOSYS;
 	}
-- 
2.20.1

