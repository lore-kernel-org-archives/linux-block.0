Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:65174 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161688AbdDUPhN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Apr 2017 11:37:13 -0400
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "axboe@fb.com" <axboe@fb.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: for-4.12/block branch
Date: Fri, 21 Apr 2017 15:32:27 +0000
Message-ID: <1492788745.2550.1.camel@sandisk.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hello Jens,

Since yesterday the following complaint is reported frequently after having
installed the for-4.12/block branch on my test setup. Unless someone has a
better proposal, I will run a bisect.

BUG: sleeping function called from invalid context at ./include/linux/buffe=
r_head.h:349
in_atomic(): 1, irqs_disabled(): 0, pid: 8019, name: find
CPU: 10 PID: 8019 Comm: find Tainted: G=A0=A0=A0=A0=A0=A0=A0=A0W I=A0=A0=A0=
=A0=A04.11.0-rc4-dbg+ #2
Call Trace:
=A0dump_stack+0x68/0x93
=A0___might_sleep+0x16e/0x230
=A0__might_sleep+0x4a/0x80
=A0__ext4_get_inode_loc+0x1e0/0x4e0
=A0ext4_iget+0x70/0xbc0
=A0ext4_iget_normal+0x2f/0x40
=A0ext4_lookup+0xb6/0x1f0
=A0lookup_slow+0x104/0x1e0
=A0walk_component+0x19a/0x330
=A0path_lookupat+0x4b/0x100
=A0filename_lookup+0x9a/0x110
=A0user_path_at_empty+0x36/0x40
=A0vfs_statx+0x67/0xc0
=A0SYSC_newfstatat+0x20/0x40
=A0SyS_newfstatat+0xe/0x10
=A0entry_SYSCALL_64_fastpath+0x18/0xad

Bart.=
