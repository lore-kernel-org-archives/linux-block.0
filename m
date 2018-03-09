Return-Path: <ming.lei@redhat.com>
Date: Fri, 9 Mar 2018 20:08:34 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Artem Bityutskiy <dedekind1@gmail.com>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, Laurence Oberman <loberman@redhat.com>
Subject: Re: [PATCH V3 0/4] genirq/affinity: irq vector spread among online
 CPUs as far as possible
Message-ID: <20180309120833.GB30257@ming.t460p>
References: <20180308105358.1506-1-ming.lei@redhat.com>
 <1520515113.20980.31.camel@gmail.com>
 <20180308133440.GA2713@ming.t460p>
 <alpine.DEB.2.21.1803090011150.1454@nanos.tec.linutronix.de>
 <20180309012458.GD5228@ming.t460p>
 <alpine.DEB.2.21.1803091107520.1364@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.2.21.1803091107520.1364@nanos.tec.linutronix.de>
List-ID: <linux-block@vger.kernel.org>

On Fri, Mar 09, 2018 at 11:08:54AM +0100, Thomas Gleixner wrote:
> On Fri, 9 Mar 2018, Ming Lei wrote:
> > On Fri, Mar 09, 2018 at 12:20:09AM +0100, Thomas Gleixner wrote:
> > > On Thu, 8 Mar 2018, Ming Lei wrote:
> > > > Actually, it isn't a real fix, the real one is in the following two:
> > > > 
> > > > 	0c20244d458e scsi: megaraid_sas: fix selection of reply queue
> > > > 	ed6d043be8cd scsi: hpsa: fix selection of reply queue
> > > 
> > > Where are these commits? Neither Linus tree not -next know anything about
> > > them....
> > 
> > Both aren't merged yet, but they should land V4.16, IMO.
> > 
> > > 
> > > > This patchset can't guarantee that all IRQ vectors are assigned by one
> > > > online CPU, for example, in a quad-socket system, if only one processor
> > > > is present, then some of vectors are still assigned by all offline CPUs,
> > > > and it is a valid case, but still may cause io hang if drivers(hpsa,
> > > > megaraid_sas) select reply queue in current way.
> > > 
> > > So my understanding is that these irq patches are enhancements and not bug
> > > fixes. I'll queue them for 4.17 then.
> > 
> > Wrt. this IO hang issue, these patches shouldn't be bug fix, but they may
> > fix performance regression[1] for some systems caused by 84676c1f21 ("genirq/affinity:
> > assign vectors to all possible CPUs").
> > 
> > [1] https://marc.info/?l=linux-block&m=152050347831149&w=2
> 
> Hmm. The patches are rather large for urgent and evtl. backporting. Is
> there a simpler way to address that performance issue?

Not thought of a simpler solution. The problem is that number of active msix vector
is decreased a lot by commit 84676c1f21.

However, if someone wants to backport, this patchset can be applied cleanly, no
any conflict.

Thanks,
Ming
