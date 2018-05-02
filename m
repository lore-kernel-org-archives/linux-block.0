Return-Path: <linux-block-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:43252 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751021AbeEBGVe (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 2 May 2018 02:21:34 -0400
Message-ID: <16794bf8075a3103279cbb4fe83aa8af7ce72d69.camel@kernel.crashing.org>
Subject: [BUG ?] lockdep report from nbd on 4.16
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linux-block@vger.kernel.org
Cc: Josef Bacik <jbacik@fb.com>, linux-kernel@vger.kernel.org
Date: Wed, 02 May 2018 16:21:28 +1000
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi !

I was playing with nbd on some little ARM bmc here with lockdep enabled and I
get the following report. I don't have the bandwidth to dig into it this week
to check if it's a false positive so I'm posting it here instead.

Cheers,
Ben.

# nbd-client pasglop /dev/nbd0 
Warning: the oldstyle protocol is no longer supported.
This method now uses the newstyle protocol with a default export
Negotiation: ..size = 1431MB
bs=1024, sz=1501[  518.762967] 
[  518.765614] ======================================================
[  518.771800] WARNING: possible circular locking dependency detected
[  518.777983] 4.16.0-00009-ga7c2ef9375ca #240 Not tainted
[  518.783212] ------------------------------------------------------
[  518.789393] nbd-client/586 is trying to acquire lock:
[  518.794446]  (&bdev->bd_mutex){+.+.}, at: [<d2ad63df>] blkdev_reread_part+0x18/0x34
[  518.802185] 
[  518.802185] but task is already holding lock:
[  518.808024]  (&nbd->config_lock){+.+.}, at: [<67337fb4>] nbd_ioctl+0x50/0x35c
[  518.815210] 
[  518.815210] which lock already depends on the new lock.
[  518.815210] 
[  518.823389] 
[  518.823389] the existing dependency chain (in reverse order) is:
[  518.830867] 
[  518.830867] -> #2 (&nbd->config_lock){+.+.}:
[  518.836655]        mutex_lock_nested+0x1c/0x24
[  518.841110]        nbd_open+0x70/0xd8
[  518.844792]        __blkdev_get+0xa0/0x3f4
[  518.848896]        blkdev_get+0x13c/0x358
[  518.852933]        do_dentry_open.constprop.4+0x124/0x308
[  518.858347]        path_openat+0x554/0x1168
[  518.862536]        do_filp_open+0x60/0xc4
[  518.866556]        do_sys_open+0x14c/0x1e8
[  518.870657]        ret_fast_syscall+0x0/0x28
[  518.874936]        0x7ef7c980
[  518.877903] 
[  518.877903] -> #1 (nbd_index_mutex){+.+.}:
[  518.883517]        mutex_lock_nested+0x1c/0x24
[  518.887980]        nbd_open+0x14/0xd8
[  518.891662]        __blkdev_get+0xa0/0x3f4
[  518.895764]        blkdev_get+0x13c/0x358
[  518.899795]        do_dentry_open.constprop.4+0x124/0x308
[  518.905204]        path_openat+0x554/0x1168
[  518.909394]        do_filp_open+0x60/0xc4
[  518.913407]        do_sys_open+0x14c/0x1e8
[  518.917508]        ret_fast_syscall+0x0/0x28
[  518.921785]        0x7ef7c980
[  518.924755] 
[  518.924755] -> #0 (&bdev->bd_mutex){+.+.}:
[  518.930368]        __mutex_lock+0x74/0x638
[  518.934470]        mutex_lock_nested+0x1c/0x24
[  518.938938]        blkdev_reread_part+0x18/0x34
[  518.943490]        nbd_ioctl+0x2d0/0x35c
[  518.947425]        blkdev_ioctl+0x5a4/0xb18
[  518.951626]        do_vfs_ioctl+0x8c/0x7cc
[  518.955727]        SyS_ioctl+0x34/0x58
[  518.959490]        ret_fast_syscall+0x0/0x28
[  518.963767]        0x7ef7c984
[  518.966736] 
[  518.966736] other info that might help us debug this:
[  518.966736] 
[  518.974734] Chain exists of:
[  518.974734]   &bdev->bd_mutex --> nbd_index_mutex --> &nbd->config_lock
[  518.974734] 
[  518.985715]  Possible unsafe locking scenario:
[  518.985715] 
[  518.991634]        CPU0                    CPU1
[  518.996157]        ----                    ----
[  519.000681]   lock(&nbd->config_lock);
[  519.004443]                                lock(nbd_index_mutex);
[  519.010544]                                lock(&nbd->config_lock);
[  519.016810]   lock(&bdev->bd_mutex);
[  519.020399] 
[  519.020399]  *** DEADLOCK ***
[  519.020399] 
[  519.026323] 1 lock held by nbd-client/586:
[  519.030419]  #0:  (&nbd->config_lock){+.+.}, at: [<67337fb4>] nbd_ioctl+0x50/0x35c
[  519.038030] 
[  519.038030] stack backtrace:
[  519.042397] CPU: 0 PID: 586 Comm: nbd-client Not tainted 4.16.0-00009-ga7c2ef9375ca #240
[  519.050484] Hardware name: Generic DT based system
[  519.055328] [<8000ff20>] (unwind_backtrace) from [<8000da4c>] (show_stack+0x10/0x14)
[  519.063110] [<8000da4c>] (show_stack) from [<8004bbf4>] (print_circular_bug.constprop.19+0x264/0x2bc)
[  519.072348] [<8004bbf4>] (print_circular_bug.constprop.19) from [<8004a2ec>] (__lock_acquire+0x14f0/0x18d0)
[  519.082101] [<8004a2ec>] (__lock_acquire) from [<8004ae30>] (lock_acquire+0x68/0x88)
[  519.089866] [<8004ae30>] (lock_acquire) from [<8044db04>] (__mutex_lock+0x74/0x638)
[  519.097540] [<8044db04>] (__mutex_lock) from [<8044e0e4>] (mutex_lock_nested+0x1c/0x24)
[  519.105576] [<8044e0e4>] (mutex_lock_nested) from [<801d1c70>] (blkdev_reread_part+0x18/0x34)
[  519.114129] [<801d1c70>] (blkdev_reread_part) from [<802abd44>] (nbd_ioctl+0x2d0/0x35c)
[  519.122152] [<802abd44>] (nbd_ioctl) from [<801d2a88>] (blkdev_ioctl+0x5a4/0xb18)
[  519.129655] [<801d2a88>] (blkdev_ioctl) from [<800f3c40>] (do_vfs_ioctl+0x8c/0x7cc)
[  519.137325] [<800f3c40>] (do_vfs_ioctl) from [<800f43b4>] (SyS_ioctl+0x34/0x58)
[  519.144649] [<800f43b4>] (SyS_ioctl) from [<80009000>] (ret_fast_syscall+0x0/0x28)
[  519.152218] Exception stack(0x9f707fa8 to 0x9f707ff0)
[  519.157275] 7fa0:                   59790000 00000000 00000004 0000ab04 76f316ac 00000001
[  519.165454] 7fc0: 59790000 00000000 00000004 00000036 00000001 00000000 00000000 7ef7ce04
[  519.173633] 7fe0: 00023a9c 7ef7c984 000125c4 76ebcb7c
102080 bytes
# [  519.219735]  nbd0: p1 p2
[  519.222468] nbd0: p1 size 5863680 extends beyond EOD, truncated
[  519.237500] nbd0: p2 start 5761760 is beyond EOD, truncated
