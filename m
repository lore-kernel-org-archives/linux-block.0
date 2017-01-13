Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:45401 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751305AbdAMKJt (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Jan 2017 05:09:49 -0500
Subject: Re: [PATCHSET v6] blk-mq scheduling framework
To: Jens Axboe <axboe@fb.com>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org
References: <1484170803-9311-1-git-send-email-axboe@fb.com>
Cc: osandov@osandov.com, bart.vanassche@sandisk.com
From: Hannes Reinecke <hare@suse.de>
Message-ID: <878e9633-bbb1-755a-c070-4105beecc300@suse.de>
Date: Fri, 13 Jan 2017 11:09:46 +0100
MIME-Version: 1.0
In-Reply-To: <1484170803-9311-1-git-send-email-axboe@fb.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 01/11/2017 10:39 PM, Jens Axboe wrote:
> Another year, another posting of this patchset. The previous posting
> was here:
> 
> https://www.spinics.net/lists/kernel/msg2406106.html
> 
> (yes, I've skipped v5, it was fixes on top of v4, not the rework).
> 
> I've reworked bits of this to get rid of the shadow requests, thanks
> to Bart for the inspiration. The missing piece, for me, was the fact
> that we have the tags->rqs[] indirection array already. I've done this
> somewhat differently, though, by having the internal scheduler tag
> map be allocated/torn down when an IO scheduler is attached or
> detached. This also means that when we run without a scheduler, we
> don't have to do double tag allocations, it'll work like before.
> 
> The patchset applies on top of 4.10-rc3, or can be pulled here:
> 
> git://git.kernel.dk/linux-block blk-mq-sched.6
> 
Fun continues:

[   28.976708] ata3.00: configured for UDMA/100
[   28.987625] BUG: unable to handle kernel NULL pointer dereference at
0000000000000048
[   28.987632] IP: deadline_add_request+0x15/0x70
[   28.987633] PGD 0
[   28.987634]
[   28.987636] Oops: 0000 [#1] SMP
[   28.987638] Modules linked in: ahci libahci libata uhci_hcd(+)
mgag200(+) i2c_algo_bit drm_kms_helper syscopyarea sysfillrect sysimgblt
fb_sys_fops ttm drm tg3 libphy ehci_pci ehci_hcd usbcore usb_common
ixgbe mdio hpsa(+) dca ptp pps_core scsi_transport_sas fjes(+) sg
dm_multipath dm_mod scsi_dh_rdac scsi_dh_emc scsi_dh_alua autofs4
[   28.987654] CPU: 0 PID: 268 Comm: kworker/u2:2 Not tainted
4.10.0-rc3+ #535
[   28.987655] Hardware name: HP ProLiant ML350p Gen8, BIOS P72 09/08/2013
[   28.987660] Workqueue: events_unbound async_run_entry_fn
[   28.987661] task: ffff880029391600 task.stack: ffffc9000038c000
[   28.987663] RIP: 0010:deadline_add_request+0x15/0x70
[   28.987664] RSP: 0018:ffffc9000038fb00 EFLAGS: 00010286
[   28.987665] RAX: ffff88003260c400 RBX: 0000000000000000 RCX:
0000000000000000
[   28.987666] RDX: ffffc9000038fb68 RSI: 0000000000000000 RDI:
ffff8800293b9040
[   28.987666] RBP: ffffc9000038fb18 R08: 000000000087668] R13:
ffff88003260c400 R14: 0000000000000000 R15: 0000000000000000
[   28.987670] FS:  0000000000000000(0000) GS:ffff880035c00000(0000)
knlGS:0000000000000000
[   28.987670] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   28.987671] CR2: 0000000000000048 CR3: 0000000032b64000 CR4:
00000000000406f0
[   28.987672] Call Trace:
[   28.987677]  blk_mq_sched_get_request+0x12e/0x310
[   28.987678]  ? blk_mq_sched_get_request+0x5/0x310
[   28.987681]  blk_mq_alloc_request+0x40/0x90
[   28.987684]  blk_get_request+0x35/0x110
[   28.987689]  __scsi_execute.isra.24+0x3c/0x160
[   28.987691]  scsi_execute_req_flags+0x94/0x100
[   28.987694]  scsi_probe_and_add_lun+0x207/0xd60
[   28.987699]  ? __pm_rme_resume+0x5c/0x80
[   28.987701]  __scsi_add_device+0x103/0x120
[   28.987709]  ata_scsi_scan_host+0xa3/0x1d0 [libata]
[   28.987716]  async_port_probe+0x43/0x60 [libata]
[   28.987718]  async_run_entry_fn+0x37/0x150
[   28.987722]  process_one_work+0x1d0/0x660

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: F. Imend�rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N�rnberg)
