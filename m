Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:60359 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751739AbdAMPEF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Jan 2017 10:04:05 -0500
Date: Fri, 13 Jan 2017 08:03:58 -0700
From: Jens Axboe <axboe@fb.com>
To: Hannes Reinecke <hare@suse.de>
CC: <linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <osandov@osandov.com>, <bart.vanassche@sandisk.com>
Subject: Re: [PATCHSET v6] blk-mq scheduling framework
Message-ID: <20170113150358.GC23338@kernel.dk>
References: <1484170803-9311-1-git-send-email-axboe@fb.com>
 <e1f8f6c5-5347-d8d8-57a2-0367d828dd22@suse.de>
 <5850a4ad-74a1-8d30-e865-fbd35679e84f@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <5850a4ad-74a1-8d30-e865-fbd35679e84f@suse.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Jan 13 2017, Hannes Reinecke wrote:
> On 01/13/2017 09:15 AM, Hannes Reinecke wrote:
> > On 01/11/2017 10:39 PM, Jens Axboe wrote:
> >> Another year, another posting of this patchset. The previous posting
> >> was here:
> >>
> >> https://www.spinics.net/lists/kernel/msg2406106.html
> >>
> >> (yes, I've skipped v5, it was fixes on top of v4, not the rework).
> >>
> >> I've reworked bits of this to get rid of the shadow requests, thanks
> >> to Bart for the inspiration. The missing piece, for me, was the fact
> >> that we have the tags->rqs[] indirection array already. I've done this
> >> somewhat differently, though, by having the internal scheduler tag
> >> map be allocated/torn down when an IO scheduler is attached or
> >> detached. This also means that when we run without a scheduler, we
> >> don't have to do double tag allocations, it'll work like before.
> >>
> >> The patchset applies on top of 4.10-rc3, or can be pulled here:
> >>
> >> git://git.kernel.dk/linux-block blk-mq-sched.6
> >>
> > Well ... something's wrong here on my machine:
> > 
> > [   39.886886] ------------[ cut here ]------------
> > [   39.886895] WARNING: CPU: 9 PID: 62 at block/blk-mq.c:342
> > __blk_mq_finish_request+0x124/0x140
> > [   39.886895] Modules linked in: sd_mod ahci uhci_hcd ehci_pci
> > mpt3sas(+) libahci ehci_hcd serio_raw crc32c_intel raid_class drm libata
> > usbcore hpsa usb_common scsi_transport_sas sg dm_multipath dm_mod
> > scsi_dh_rdac scsi_dh_emc scsi_dh_alua autofs4
> > [   39.886910] CPU: 9 PID: 62 Comm: kworker/u130:0 Not tainted
> > 4.10.0-rc3+ #528
> > [   39.886911] Hardware name: HP ProLiant ML350p Gen8, BIOS P72 09/08/2013
> > [   39.886917] Workqueue: events_unbound async_run_entry_fn
> > [   39.886918] Call Trace:
> > [   39.886923]  dump_stack+0x85/0xc9
> > [   39.886927]  __warn+0xd1/0xf0
> > [   39.886928]  warn_slowpath_null+0x1d/0x20
> > [   39.886930]  __blk_mq_finish_request+0x124/0x140
> > [   39.886932]  blk_mq_finish_request+0x55/0x60
> > [   39.886934]  blk_mq_sched_put_request+0x78/0x80
> > [   39.886936]  blk_mq_free_request+0xe/0x10
> > [   39.886938]  blk_put_request+0x25/0x60
> > [   39.886944]  __scsi_execute.isra.24+0x104/0x160
> > [   39.886946]  scsi_execute_req_flags+0x94/0x100
> > [   39.886948]  scsi_report_opcode+0xab/0x100
> > 
> > checking ...
> > 
> Ah.
> Seems like the elevator switch races with device setup:

Huh, funky, haven't seen that. I'll see if I can reproduce it here. I
don't have SCAN_ASYNC turned on, on my test box.

-- 
Jens Axboe

