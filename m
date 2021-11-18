Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF91FC433EF
	for <linux-block@archiver.kernel.org>; Thu, 18 Nov 2021 02:42:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90D4F61AEC
	for <linux-block@archiver.kernel.org>; Thu, 18 Nov 2021 02:42:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242040AbhKRCpr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 Nov 2021 21:45:47 -0500
Received: from pv50p00im-hyfv10021501.me.com ([17.58.6.48]:37330 "EHLO
        pv50p00im-hyfv10021501.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242012AbhKRCpq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 Nov 2021 21:45:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1637203006;
        bh=eLz6UTl5BLdUYofgE9brU1W96vGw23aT4QaPN/JuEV4=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=hK2nvNHFXthOL6kRdXkiIUizo765ZaIHoV8zhcri6sokNYBks6195b3RZzv4wpwe6
         AsSTBhAxBZnesPOBeetFytmF6ryAdIGvjKf4fqvNkF3rSjGSRoXAWFI4BNLJluGNvg
         8uZ+4six2IRGfQM5A7pls16UUwf10CvL3N/30aiDNbTWEexA3o8uNw0ln0IHXwZfOy
         2JG2oJvjKlAt6AkM8Ap4JvkRorAzxTG2Vj+pUySfsWaCsoP/ZaDrwdx2I+7aVs+aYH
         MpbJhdQCBovWyrtDWhOsBAruV50BFMe+ZF/rfwPwS2gHqTR/ybfHJ86HKsNfDFW4gq
         Ca6y6sA4Xa1uQ==
Received: from localhost.localdomain (unknown [58.240.82.166])
        by pv50p00im-hyfv10021501.me.com (Postfix) with ESMTPSA id 286A45406D4;
        Thu, 18 Nov 2021 02:36:44 +0000 (UTC)
From:   wangyangbo <yangbonis@icloud.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        wangyangbo <yangbonis@icloud.com>
Subject: [PATCH] loop: mask loop_control_ioctl parameter only as minor
Date:   Thu, 18 Nov 2021 10:36:40 +0800
Message-Id: <20211118023640.32559-1-yangbonis@icloud.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.790
 definitions=2021-11-18_01:2021-11-17,2021-11-17 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011 mlxscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2009150000 definitions=main-2111180013
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: wangyangbo <wangyangbo@uniontech.com>

loop_control_ioctl call add_disk of block layer, but may pass number beyond MAX MINOR.
So mask loop_control_ioctl parameter only as minor.

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
 drivers/block/loop.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index a154cab6cd98..0d8240a7e66d 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -2170,11 +2170,11 @@ static long loop_control_ioctl(struct file *file, unsigned int cmd,
 {
 	switch (cmd) {
 	case LOOP_CTL_ADD:
-		return loop_add(parm);
+		return loop_add(MINOR(parm));
 	case LOOP_CTL_REMOVE:
-		return loop_control_remove(parm);
+		return loop_control_remove(MINOR(parm));
 	case LOOP_CTL_GET_FREE:
-		return loop_control_get_free(parm);
+		return loop_control_get_free(MINOR(parm));
 	default:
 		return -ENOSYS;
 	}
-- 
2.20.1

