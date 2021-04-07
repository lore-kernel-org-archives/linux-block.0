Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D58DC433B4
	for <linux-block@archiver.kernel.org>; Wed,  7 Apr 2021 11:50:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 165476139E
	for <linux-block@archiver.kernel.org>; Wed,  7 Apr 2021 11:50:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233806AbhDGLug (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 7 Apr 2021 07:50:36 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:16015 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbhDGLuf (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 7 Apr 2021 07:50:35 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FFjLc6qYpzPnW4;
        Wed,  7 Apr 2021 19:47:36 +0800 (CST)
Received: from [10.174.179.174] (10.174.179.174) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.498.0; Wed, 7 Apr 2021 19:50:20 +0800
Subject: [Question] do we need fail __device_add_disk when functions in it
 return error
References: <3d3dce33-a2d7-ebfa-c35e-55c2de7df7af@huawei.com>
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        "Ming Lei" <ming.lei@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <rafael@kernel.org>
From:   Yufen Yu <yuyufen@huawei.com>
X-Forwarded-Message-Id: <3d3dce33-a2d7-ebfa-c35e-55c2de7df7af@huawei.com>
Message-ID: <5d610970-2bf1-4f4f-143f-9d78d41f7a6b@huawei.com>
Date:   Wed, 7 Apr 2021 19:50:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <3d3dce33-a2d7-ebfa-c35e-55c2de7df7af@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.174]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi, all

Recently, our syzbot test reported NULL pointer dereference in device_del()
by injecting memory allocation fail in device_add() invoking from register_disk(),
as following:

general protection fault, probably for non-canonical address 0xdffffc0000000021: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000108-0x000000000000010f]
CPU: 0 PID: 9441 Comm: syz-executor348 Tainted: G        W         5.10.0+ #6
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Ubuntu-1.8.2-1ubuntu1 04/01/2014
RIP: 0010:kill_device+0x9b/0x160 drivers/base/core.c:3050
Code: fd 49 83 c6 48 4c 89 f3 48 c1 eb 03 42 80 3c 3b 00 74 08 4c 89 f7 e8 94 ef 8c fd bd 08 01 00 00 49 03 2e 48 89 e8 48 c1 e8 03 <42> 8a 04 38 84 c0 0f 85 89 00 00 00 0f b6 6d 00 83 e5 01 31 ff 89
RSP: 0018:ffffc900032bfd38 EFLAGS: 00010206
RAX: 0000000000000021 RBX: 1ffff1100299b816 RCX: ffff8881115cc200
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000005
RBP: 0000000000000108 R08: dffffc0000000000 R09: ffff8881115cc200
R10: ffffed100299b830 R11: 0000000000000000 R12: dffffc0000000000
R13: 0000000000000008 R14: ffff888014cdc0b0 R15: dffffc0000000000
FS:  0000000000e29880(0000) GS:ffff888061000000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000006cc098 CR3: 0000000018764000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  device_del+0x62/0xa00 drivers/base/core.c:3078
  del_gendisk+0x725/0x880 block/genhd.c:952
  loop_remove+0x42/0xa0 drivers/block/loop.c:2193
  loop_control_ioctl+0x31d/0x3a0 drivers/block/loop.c:2292
  vfs_ioctl+0xa2/0xf0 fs/ioctl.c:48
  __do_sys_ioctl fs/ioctl.c:753 [inline]
  __se_sys_ioctl fs/ioctl.c:739 [inline]
  __x64_sys_ioctl+0xfe/0x140 fs/ioctl.c:739
  do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
  entry_SYSCALL_64_after_hwframe+0x44/0xa9

When device_add() fail caused by some memory allocation fail, it will free
'dev->p' and set the pointer as NULL. Since add_disk() will ignore the functions
fail and go on working, it will cause various NULL pointer dereference in del_gendisk(),
including 'dev->p' is NULL in kill_device() from device_del(), 'name' is NULL in
sysfs_remove_link() from del_gendisk(), kobj->sd is 'NULL' when call dpm_sysfs_remove()
from device_del(), and so on.

I try to fix the the problem by passing device_del() when device_add() fail[1], which is
is not complete. And Greg thinks we should fix up users of device_del().

My question is do we need to check return value of register_disk() and fail __device_add_disk()
when functions in it fail.
Is there some historical reason that let us ignore various fail from __device_add_disk()
and register_disk()?

[1] https://lore.kernel.org/linux-block/20210401130138.2164928-1-yuyufen@huawei.com/

Thanks,
Yufen
