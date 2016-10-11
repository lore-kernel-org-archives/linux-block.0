Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf0-f67.google.com ([209.85.215.67]:34927 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752377AbcJKJAX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Oct 2016 05:00:23 -0400
Subject: Re: [PATCH][V3] nbd: add multi-connection support
To: Josef Bacik <jbacik@fb.com>, axboe@fb.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, nbd-general@lists.sourceforge.net, w@uter.be
References: <1475092892-8230-1-git-send-email-jbacik@fb.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <4b5da874-dd62-b683-563d-717d710156e4@grimberg.me>
Date: Tue, 11 Oct 2016 12:00:18 +0300
MIME-Version: 1.0
In-Reply-To: <1475092892-8230-1-git-send-email-jbacik@fb.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


> NBD can become contended on its single connection.  We have to serialize all
> writes and we can only process one read response at a time.  Fix this by
> allowing userspace to provide multiple connections to a single nbd device.  This
> coupled with block-mq drastically increases performance in multi-process cases.
> Thanks,

Hey Josef,

I gave this patch a tryout and I'm getting a kernel paging request when
running multi-threaded write workload [1].

I have 2 VMs on my laptop: each is assigned with 2 cpus. I connected
the client to the server via 2 connections and ran:
fio --group_reporting --rw=randwrite --bs=4k --numjobs=2 --iodepth=128 
--runtime=60 --time_based --loops=1 --ioengine=libaio --direct=1 
--invalidate=1 --randrepeat=1 --norandommap --exitall --name task_nbd0 
--filename=/dev/nbd0

The server backend is null_blk btw:
./nbd-server 1022 /dev/nullb0

nbd-client:
./nbd-client -C 2 192.168.100.3 1022 /dev/nbd0

[1]:
[  171.813649] BUG: unable to handle kernel paging request at 
0000000235363130
[  171.816015] IP: [<ffffffffc0645e39>] nbd_queue_rq+0x319/0x580 [nbd]
[  171.816015] PGD 7a080067 PUD 0
[  171.816015] Oops: 0000 [#1] SMP
[  171.816015] Modules linked in: nbd(O) rpcsec_gss_krb5 nfsv4 ib_iser 
iscsi_tcp libiscsi_tcp libiscsi scsi_transport_iscsi 
snd_hda_codec_generic ppdev kvm_intel cirrus snd_hda_intel ttm kvm 
irqbypass drm_kms_helper snd_hda_codec drm snd_hda_core snd_hwdep joydev 
input_leds fb_sys_fops snd_pcm serio_raw syscopyarea snd_timer 
sysfillrect snd sysimgblt soundcore i2c_piix4 nfsd ib_umad parport_pc 
auth_rpcgss nfs_acl rdma_ucm nfs rdma_cm iw_cm lockd grace ib_cm 
configfs sunrpc ib_uverbs mac_hid fscache ib_core lp parport psmouse 
floppy e1000 pata_acpi [last unloaded: nbd]
[  171.816015] CPU: 0 PID: 196 Comm: kworker/0:1H Tainted: G           O 
    4.8.0-rc4+ #61
[  171.816015] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), 
BIOS Bochs 01/01/2011
[  171.816015] Workqueue: kblockd blk_mq_run_work_fn
[  171.816015] task: ffff8f0b37b23280 task.stack: ffff8f0b37bf0000
[  171.816015] RIP: 0010:[<ffffffffc0645e39>]  [<ffffffffc0645e39>] 
nbd_queue_rq+0x319/0x580 [nbd]
[  171.816015] RSP: 0018:ffff8f0b37bf3c20  EFLAGS: 00010206
[  171.816015] RAX: 0000000235363130 RBX: 0000000000000000 RCX: 
0000000000000200
[  171.816015] RDX: 0000000000000200 RSI: ffff8f0b37b23b48 RDI: 
ffff8f0b37b23280
[  171.816015] RBP: ffff8f0b37bf3cc8 R08: 0000000000000001 R09: 
0000000000000000
[  171.816015] R10: 0000000000000000 R11: ffff8f0b37f21000 R12: 
0000000023536303
[  171.816015] R13: 0000000000000000 R14: 0000000023536313 R15: 
ffff8f0b37f21000
[  171.816015] FS:  0000000000000000(0000) GS:ffff8f0b3d200000(0000) 
knlGS:0000000000000000
[  171.816015] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  171.816015] CR2: 0000000235363130 CR3: 00000000789b7000 CR4: 
00000000000006f0
[  171.816015] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
0000000000000000
[  171.816015] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 
0000000000000400
[  171.816015] Stack:
[  171.816015]  ffff8f0b00000000 ffff8f0b37a79480 ffff8f0b378513c8 
0000000000000282
[  171.816015]  ffff8f0b37b28428 ffff8f0b37a795f0 ffff8f0b37f21500 
00000a0023536313
[  171.816015]  ffffea0001c69080 0000000000000000 ffff8f0b37b28280 
1395602537b23280
[  171.816015] Call Trace:
[  171.816015]  [<ffffffffb8426840>] __blk_mq_run_hw_queue+0x260/0x390
[  171.816015]  [<ffffffffb84269b2>] blk_mq_run_work_fn+0x12/0x20
[  171.816015]  [<ffffffffb80aae21>] process_one_work+0x1f1/0x6b0
[  171.816015]  [<ffffffffb80aada2>] ? process_one_work+0x172/0x6b0
[  171.816015]  [<ffffffffb80ab32e>] worker_thread+0x4e/0x490
[  171.816015]  [<ffffffffb80ab2e0>] ? process_one_work+0x6b0/0x6b0
[  171.816015]  [<ffffffffb80ab2e0>] ? process_one_work+0x6b0/0x6b0
[  171.816015]  [<ffffffffb80b1f41>] kthread+0x101/0x120
[  171.816015]  [<ffffffffb88d4ecf>] ret_from_fork+0x1f/0x40
[  171.816015]  [<ffffffffb80b1e40>] ? kthread_create_on_node+0x250/0x250
