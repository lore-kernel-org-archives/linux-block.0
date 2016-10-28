Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jens Axboe <axboe@kernel.dk>, Paolo Valente <paolo.valente@linaro.org>, Christoph Hellwig <hch@infradead.org>, Bart Van Assche <bart.vanassche@sandisk.com>, Jan Kara <jack@suse.cz>, Tejun Heo <tj@kernel.org>, linux-block@vger.kernel.org, Linux-Kernal <linux-kernel@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Mark Brown <broonie@kernel.org>, Hannes Reinecke <hare@suse.de>, Grant Likely <grant.likely@secretlab.ca>, James Bottomley <James.Bottomley@hansenpartnership.com>
Subject: Re: [PATCH 00/14] introduce the BFQ-v0 I/O scheduler as an extra scheduler
Date: Fri, 28 Oct 2016 14:07:29 +0200
Message-ID: <14538128.U7izDYD32A@wuerfel>
In-Reply-To: <CAPDyKFoi64Q0H9x2F35oY85PMDNq4hRsmqGYiP+En+qtQ4+Bag@mail.gmail.com>
References: <1477474082-2846-1-git-send-email-paolo.valente@linaro.org> <15ee2d0e-2d3a-81e2-9f83-f875e41bf388@kernel.dk> <CAPDyKFoi64Q0H9x2F35oY85PMDNq4hRsmqGYiP+En+qtQ4+Bag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-block@vger.kernel.org>

On Thursday, October 27, 2016 8:13:08 PM CEST Ulf Hansson wrote:
> On 27 October 2016 at 19:43, Jens Axboe <axboe@kernel.dk> wrote:
> > On 10/27/2016 11:32 AM, Ulf Hansson wrote:
> >>
> >> [...]
> >>
> >>>
> >>> I'm hesistant to add a new scheduler because it's very easy to add, very
> >>> difficult to get rid of. If we do add BFQ as a legacy scheduler now,
> >>> it'll take us years and years to get rid of it again. We should be
> >>> moving towards LESS moving parts in the legacy path, not more.
> >>
> >>
> >> Jens, I think you are wrong here and let me try to elaborate on why.
> >>
> >> 1)
> >> We already have legacy schedulers like CFQ, DEADLINE, etc - and most
> >> block device drivers are still using the legacy blk interface.
> >
> >
> > I don't think that's an accurate statement. In terms of coverage, most
> > drivers do support blk-mq. Anything SCSI, nvme, virtio-blk, SATA runs on
> > (or can run on) top of blk-mq.
> 
> Well, I just used "git grep" and found that many drivers didn't use
> blkmq. Apologize if I gave the wrong impressions.

To clarify, this seems to be a complete list:

$ git grep -wl '\(__\|\)blk_\(fetch\|end\|start\)_request' | xargs grep -L blk_mq
Documentation/scsi/scsi_eh.txt
arch/um/drivers/ubd_kern.c
block/blk-tag.c
block/bsg-lib.c
drivers/block/DAC960.c
drivers/block/amiflop.c
drivers/block/aoe/aoeblk.c
drivers/block/aoe/aoecmd.c
drivers/block/aoe/aoedev.c
drivers/block/ataflop.c
drivers/block/cciss.c
drivers/block/floppy.c
drivers/block/hd.c
drivers/block/mg_disk.c
drivers/block/osdblk.c
drivers/block/paride/pcd.c
drivers/block/paride/pd.c
drivers/block/paride/pf.c
drivers/block/ps3disk.c
drivers/block/skd_main.c
drivers/block/sunvdc.c
drivers/block/swim.c
drivers/block/swim3.c
drivers/block/sx8.c
drivers/block/xsysace.c
drivers/block/z2ram.c
drivers/cdrom/gdrom.c
drivers/ide/ide-atapi.c
drivers/ide/ide-io.c
drivers/ide/ide-pm.c
drivers/memstick/core/ms_block.c
drivers/memstick/core/mspro_block.c
drivers/mmc/card/block.c
drivers/mmc/card/queue.c
drivers/mtd/mtd_blkdevs.c
drivers/s390/block/dasd.c
drivers/s390/block/scm_blk.c
drivers/sbus/char/jsflash.c
drivers/scsi/osd/osd_initiator.c
drivers/scsi/scsi_transport_fc.c
drivers/scsi/scsi_transport_sas.c
samples/bpf/tracex3_kern.c

>From what I can tell, most of these are hopelessly obsolete, but
there are some notable exceptions: aoe, osdblk, skd, sunvdc, mtdblk,
mmc, dasd and scm. I've never used any of the first four, but the
last four of the list are certainly important (for very different
reasons).

	Arnd
