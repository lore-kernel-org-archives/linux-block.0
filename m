Return-Path: <tglx@linutronix.de>
Date: Fri, 9 Mar 2018 00:20:09 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Ming Lei <ming.lei@redhat.com>
cc: Artem Bityutskiy <dedekind1@gmail.com>, Jens Axboe <axboe@kernel.dk>,
    Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
    linux-block@vger.kernel.org, Laurence Oberman <loberman@redhat.com>
Subject: Re: [PATCH V3 0/4] genirq/affinity: irq vector spread among online
 CPUs as far as possible
In-Reply-To: <20180308133440.GA2713@ming.t460p>
Message-ID: <alpine.DEB.2.21.1803090011150.1454@nanos.tec.linutronix.de>
References: <20180308105358.1506-1-ming.lei@redhat.com> <1520515113.20980.31.camel@gmail.com> <20180308133440.GA2713@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-block@vger.kernel.org>

On Thu, 8 Mar 2018, Ming Lei wrote:
> Actually, it isn't a real fix, the real one is in the following two:
> 
> 	0c20244d458e scsi: megaraid_sas: fix selection of reply queue
> 	ed6d043be8cd scsi: hpsa: fix selection of reply queue

Where are these commits? Neither Linus tree not -next know anything about
them....

> This patchset can't guarantee that all IRQ vectors are assigned by one
> online CPU, for example, in a quad-socket system, if only one processor
> is present, then some of vectors are still assigned by all offline CPUs,
> and it is a valid case, but still may cause io hang if drivers(hpsa,
> megaraid_sas) select reply queue in current way.

So my understanding is that these irq patches are enhancements and not bug
fixes. I'll queue them for 4.17 then.

Thanks,

	tglx
