Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:47280 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932500AbdA0MK6 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 Jan 2017 07:10:58 -0500
Subject: Re: [PATCH 0/5] blk-mq: various blk-mq/blk-mq-sched fixes
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
References: <1485460098-16608-1-git-send-email-axboe@fb.com>
Cc: bart.vanassche@sandisk.com, hch@lst.de, osandov@fb.com,
        paolo.valente@linaro.org, hare@suse.com
From: Hannes Reinecke <hare@suse.de>
Message-ID: <1f162b4f-7aa1-d19b-53d8-2b621da36d27@suse.de>
Date: Fri, 27 Jan 2017 13:10:54 +0100
MIME-Version: 1.0
In-Reply-To: <1485460098-16608-1-git-send-email-axboe@fb.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 01/26/2017 08:48 PM, Jens Axboe wrote:
> I've been diving into the problems that Hannes reported, both the
> stalls related to shared tag maps and multiple hardware queues,
> but also the cases where we get suboptimal merging.
> 
> This series attempts to fix that.
> 
> Hannes, this should be identical to what I sent you as a bundled up
> patch earlier today. Would be great if you could run this through
> your testing.
> 
> The patches are against for-4.11/block
> 
Yep, full success:

4k  seq read : io=59850MB, bw=997.36MB/s, iops=255241, runt= 60028msec
4k rand read : io=399676KB, bw=6127.9KB/s, iops=1531, runt= 65231msec
4k seq write: io=12194MB, bw=207576KB/s, iops=51893, runt= 60155msec
4k rand write: io=111100KB, bw=1315.7KB/s, iops=328, runt= 84445msec

Although I'm getting a lockdep splat:
------------[ cut here ]------------
WARNING: CPU: 4 PID: 3211 at kernel/locking/lockdep.c:3514 lock_release+
DEBUG_LOCKS_WARN_ON(depth <= 0)
Modules linked in: nfsv3 nfs_acl rpcsec_gss_krb5 auth_rpcgss nfsv4 nfs l
uhci_hcd ahci ehci_hcd libahci ttm crc32c_intel serio_raw hpsa usbcore
CPU: 4 PID: 3211 Comm: fio Not tainted 4.10.0-rc3+ #598
Hardware name: HP ProLiant DL380p Gen8, BIOS P70 09/18/2013
Call Trace:
 dump_stack+0x85/0xc9
 __warn+0xd1/0xf0
 ? aio_write+0x118/0x170
 warn_slowpath_fmt+0x4f/0x60
 lock_release+0x2a7/0x490
 ? blkdev_write_iter+0x89/0xd0
 aio_write+0x138/0x170
 do_io_submit+0x4d2/0x8f0
 ? do_io_submit+0x413/0x8f0
 SyS_io_submit+0x10/0x20
 entry_SYSCALL_64_fastpath+0x23/0xc6

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: F. Imend�rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N�rnberg)
