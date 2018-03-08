Return-Path: <ming.lei@redhat.com>
Date: Thu, 8 Mar 2018 21:34:45 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Artem Bityutskiy <dedekind1@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, Laurence Oberman <loberman@redhat.com>
Subject: Re: [PATCH V3 0/4] genirq/affinity: irq vector spread among online
 CPUs as far as possible
Message-ID: <20180308133440.GA2713@ming.t460p>
References: <20180308105358.1506-1-ming.lei@redhat.com>
 <1520515113.20980.31.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1520515113.20980.31.camel@gmail.com>
List-ID: <linux-block@vger.kernel.org>

On Thu, Mar 08, 2018 at 03:18:33PM +0200, Artem Bityutskiy wrote:
> On Thu, 2018-03-08 at 18:53 +0800, Ming Lei wrote:
> > Hi,
> > 
> > This patchset tries to spread among online CPUs as far as possible, so
> > that we can avoid to allocate too less irq vectors with online CPUs
> > mapped.
> > 
> > For example, in a 8cores system, 4 cpu cores(4~7) are offline/non present,
> > on a device with 4 queues:
> > 
> > 1) before this patchset
> > 	irq 39, cpu list 0-2
> > 	irq 40, cpu list 3-4,6
> > 	irq 41, cpu list 5
> > 	irq 42, cpu list 7
> > 
> > 2) after this patchset
> > 	irq 39, cpu list 0,4
> > 	irq 40, cpu list 1,6
> > 	irq 41, cpu list 2,5
> > 	irq 42, cpu list 3,7
> > 
> > Without this patchset, only two vectors(39, 40) can be active, but there
> > can be 4 active irq vectors after applying this patchset.
> 
> Tested-by: Artem Bityutskiy <artem.bityutskiy@intel.com>
> Link: https://lkml.kernel.org/r/1519311270.2535.53.camel@intel.com

Hi Artem,

Thanks for your test!

> 
> Ming,
> 
> this patchset fixes the v4.16-rcX regression that I reported few weeks
> ago. I applied it and verified that Dell R640 server that I mentioned
> in the bug report boots up and the disk works.
> 
> So this is not just an improvement, it also includes a bugfix. 

Actually, it isn't a real fix, the real one is in the following two:

	0c20244d458e scsi: megaraid_sas: fix selection of reply queue
	ed6d043be8cd scsi: hpsa: fix selection of reply queue

This patchset can't guarantee that all IRQ vectors are assigned by one
online CPU, for example, in a quad-socket system, if only one processor
is present, then some of vectors are still assigned by all offline CPUs,
and it is a valid case, but still may cause io hang if drivers(hpsa, megaraid_sas)
select reply queue in current way.

Thanks,
Ming
