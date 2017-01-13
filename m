Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:58616 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751240AbdAMIdx (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Jan 2017 03:33:53 -0500
Subject: Re: [PATCHSET v6] blk-mq scheduling framework
To: Jens Axboe <axboe@fb.com>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org
References: <1484170803-9311-1-git-send-email-axboe@fb.com>
Cc: osandov@osandov.com, bart.vanassche@sandisk.com
From: Hannes Reinecke <hare@suse.de>
Message-ID: <e1f8f6c5-5347-d8d8-57a2-0367d828dd22@suse.de>
Date: Fri, 13 Jan 2017 09:15:20 +0100
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
Well ... something's wrong here on my machine:

[   39.886886] ------------[ cut here ]------------
[   39.886895] WARNING: CPU: 9 PID: 62 at block/blk-mq.c:342
__blk_mq_finish_request+0x124/0x140
[   39.886895] Modules linked in: sd_mod ahci uhci_hcd ehci_pci
mpt3sas(+) libahci ehci_hcd serio_raw crc32c_intel raid_class drm libata
usbcore hpsa usb_common scsi_transport_sas sg dm_multipath dm_mod
scsi_dh_rdac scsi_dh_emc scsi_dh_alua autofs4
[   39.886910] CPU: 9 PID: 62 Comm: kworker/u130:0 Not tainted
4.10.0-rc3+ #528
[   39.886911] Hardware name: HP ProLiant ML350p Gen8, BIOS P72 09/08/2013
[   39.886917] Workqueue: events_unbound async_run_entry_fn
[   39.886918] Call Trace:
[   39.886923]  dump_stack+0x85/0xc9
[   39.886927]  __warn+0xd1/0xf0
[   39.886928]  warn_slowpath_null+0x1d/0x20
[   39.886930]  __blk_mq_finish_request+0x124/0x140
[   39.886932]  blk_mq_finish_request+0x55/0x60
[   39.886934]  blk_mq_sched_put_request+0x78/0x80
[   39.886936]  blk_mq_free_request+0xe/0x10
[   39.886938]  blk_put_request+0x25/0x60
[   39.886944]  __scsi_execute.isra.24+0x104/0x160
[   39.886946]  scsi_execute_req_flags+0x94/0x100
[   39.886948]  scsi_report_opcode+0xab/0x100

checking ...

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: F. Imend�rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N�rnberg)
