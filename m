Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:41732 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750892AbeAPPrl (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Jan 2018 10:47:41 -0500
Date: Tue, 16 Jan 2018 23:47:02 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Don Brace <don.brace@microsemi.com>
Cc: Laurence Oberman <loberman@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@fb.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mike Snitzer <snitzer@redhat.com>
Subject: Re: [PATCH 0/2] genirq/affinity: try to make sure online CPU is
 assgined to irq vector
Message-ID: <20180116154701.GB3018@ming.t460p>
References: <20180115160345.2611-1-ming.lei@redhat.com>
 <20180115174036.GA20191@infradead.org>
 <20180116013043.GA3213@ming.t460p>
 <alpine.DEB.2.20.1801161223500.1823@nanos>
 <1516109317.9574.1.camel@redhat.com>
 <a6086631efd54749a298add3d6b9a134@microsemi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <a6086631efd54749a298add3d6b9a134@microsemi.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Jan 16, 2018 at 03:22:18PM +0000, Don Brace wrote:
> > -----Original Message-----
> > From: Laurence Oberman [mailto:loberman@redhat.com]
> > Sent: Tuesday, January 16, 2018 7:29 AM
> > To: Thomas Gleixner <tglx@linutronix.de>; Ming Lei <ming.lei@redhat.com>
> > Cc: Christoph Hellwig <hch@infradead.org>; Jens Axboe <axboe@fb.com>;
> > linux-block@vger.kernel.org; linux-kernel@vger.kernel.org; Mike Snitzer
> > <snitzer@redhat.com>; Don Brace <don.brace@microsemi.com>
> > Subject: Re: [PATCH 0/2] genirq/affinity: try to make sure online CPU is assgined
> > to irq vector
> > 
> > > > It is because of irq_create_affinity_masks().
> > >
> > > That still does not answer the question. If the interrupt for a queue
> > > is
> > > assigned to an offline CPU, then the queue should not be used and
> > > never
> > > raise an interrupt. That's how managed interrupts have been designed.
> > >
> > > Thanks,
> > >
> > >       tglx
> > >
> > >
> > >
> > >
> > 
> > I captured a full boot log for this issue for Microsemi, I will send it
> > to Don Brace.
> > I enabled all the HPSA debug and here is snippet
> > 
> > 
> > ..
> > ..
> > ..
> >   246.751135] INFO: task systemd-udevd:413 blocked for more than 120
> > seconds.
> > [��246.788008]�������Tainted: G          I      4.15.0-rc4.noming+ #1
> > [��246.822380] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> > disables this message.
> > [��246.865594] systemd-udevd   D    0   413    411 0x80000004
> > [��246.895519] Call Trace:
> > [��246.909713]��? __schedule+0x340/0xc20
> > [��246.930236]��schedule+0x32/0x80
> > [��246.947905]��schedule_timeout+0x23d/0x450
> > [  246.970047]��? find_held_lock+0x2d/0x90
> > [��246.991774]��? wait_for_completion_io+0x108/0x170
> > [��247.018172]��io_schedule_timeout+0x19/0x40
> > [��247.041208]��wait_for_completion_io+0x110/0x170
> > [��247.067326]��? wake_up_q+0x70/0x70
> > [��247.086801]��hpsa_scsi_do_simple_cmd+0xc6/0x100 [hpsa]
> > [��247.114315]��hpsa_scsi_do_simple_cmd_with_retry+0xb7/0x1c0 [hpsa]
> > [��247.146629]��hpsa_scsi_do_inquiry+0x73/0xd0 [hpsa]
> > [��247.174118]��hpsa_init_one+0x12cb/0x1a59 [hpsa]
> 
> This trace comes from internally generated discovery commands. No SCSI devices have
> been presented to the SML yet.
> 
> At this point we should be running on only one CPU. These commands are meant to use
> reply queue 0 which are tied to CPU 0. It's interesting that the patch helps.

In hpsa_interrupt_mode(), you pass PCI_IRQ_AFFINITY to pci_alloc_irq_vectors(),
which may spread one irq vector across all offline CPUs. That is the cause of
this hang reported by Laurence from my observation.

BTW, if the interrupt handler for the reply queue isn't performance sensitive,
maybe PCI_IRQ_AFFINITY can be removed for avoiding this issue.

But anyway, as I replied in this thread, this patch still improves irq
vectors spread.

Thanks,
Ming
