Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:52786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753610AbdCTW7C (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Mar 2017 18:59:02 -0400
From: Ming Lin <mlin@kernel.org>
To: nbd-general@lists.sourceforge.net, Josef Bacik <jbacik@fb.com>,
        Ratna Manoj Bolla <manoj.br@gmail.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        jianshu.ljs@alibaba-inc.com, xiongwei.jiang@alibaba-inc.com,
        james.liu@alibaba-inc.com, Markus Pargmann <mpa@pengutronix.de>
Subject: [RFC PATCH 0/1] nbd: fix crash when unmaping nbd device with fs still mounted
Date: Mon, 20 Mar 2017 15:58:48 -0700
Message-Id: <1490050729-3578-1-git-send-email-mlin@kernel.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi all,

I run into a BUG_ON(!buffer_mapped(bh)) crash with below script.

 $ rbd-nbd map mypool/myimg
 $ mkfs.ext4 /dev/nbd0
 $ mount /dev/nbd0 /mnt/
 $ rbd-nbd unmap /dev/nbd0
 $ umount /mnt

[ 1248.870131] kernel BUG at /home/mlin/linux/fs/buffer.c:3103!
[ 1248.871214] invalid opcode: 0000 [#1] SMP
[ 1248.879468] CPU: 0 PID: 2450 Comm: umount Tainted: G            E   4.11.0-rc2+ #2
[ 1248.896579] Call Trace:
[ 1248.897056]  __sync_dirty_buffer+0x6e/0xe0
[ 1248.897870]  ext4_commit_super+0x1eb/0x290 [ext4]
[ 1248.898795]  ext4_put_super+0x2fa/0x3c0 [ext4]
[ 1248.899662]  generic_shutdown_super+0x6f/0x100
[ 1248.900525]  kill_block_super+0x27/0x70
[ 1248.901257]  deactivate_locked_super+0x43/0x70
[ 1248.902112]  deactivate_super+0x46/0x60
[ 1248.902869]  cleanup_mnt+0x3f/0x80
[ 1248.903526]  __cleanup_mnt+0x12/0x20
[ 1248.904218]  task_work_run+0x83/0xb0
[ 1248.904941]  exit_to_usermode_loop+0x59/0x7b
[ 1248.905769]  do_syscall_64+0x165/0x180
[ 1248.907603]  entry_SYSCALL64_slow_path+0x25/0x25

Last year, Ratna posted a patch to fix it.
https://lkml.org/lkml/2016/4/20/257

Ratna's script to reproduce the bug.

 $ qemu-img create -f qcow2 f.img 1G
 $ mkfs.ext4 f.img
 $ qemu-nbd -c /dev/nbd0 f.img
 $ mount /dev/nbd0 dir
 $ killall -KILL qemu-nbd
 $ sleep 1
 $ ls dir
 $ umount dir

I ported Rantna's patch to 4.11-rc2 and confirmed that it fixes the crash.

Jan Kara had some comments about this bug:
http://www.kernelhub.org/?p=2&msg=361407

I hope to fix this bug in the upstream kernel first and then back port it to 
our production system.

Please see "PATCH 1/1" for detail.

Thanks,
Ming
