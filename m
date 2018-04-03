Return-Path: <tglx@linutronix.de>
Date: Tue, 3 Apr 2018 15:32:21 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Ming Lei <ming.lei@redhat.com>
cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>,
    linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
    Laurence Oberman <loberman@redhat.com>
Subject: Re: [PATCH V3 4/4] genirq/affinity: irq vector spread among online
 CPUs as far as possible
In-Reply-To: <20180308105358.1506-5-ming.lei@redhat.com>
Message-ID: <alpine.DEB.2.21.1804031522480.2511@nanos.tec.linutronix.de>
References: <20180308105358.1506-1-ming.lei@redhat.com> <20180308105358.1506-5-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-block@vger.kernel.org>

On Thu, 8 Mar 2018, Ming Lei wrote:
> 1) before 84676c1f21 ("genirq/affinity: assign vectors to all possible CPUs")
> 	irq 39, cpu list 0
> 	irq 40, cpu list 1
> 	irq 41, cpu list 2
> 	irq 42, cpu list 3
> 
> 2) after 84676c1f21 ("genirq/affinity: assign vectors to all possible CPUs")
> 	irq 39, cpu list 0-2
> 	irq 40, cpu list 3-4,6
> 	irq 41, cpu list 5
> 	irq 42, cpu list 7
> 
> 3) after applying this patch against V4.15+:
> 	irq 39, cpu list 0,4
> 	irq 40, cpu list 1,6
> 	irq 41, cpu list 2,5
> 	irq 42, cpu list 3,7

That's more or less window dressing. If the device is already in use when
the offline CPUs get hot plugged, then the interrupts still stay on cpu 0-3
because the effective affinity of interrupts on X86 (and other
architectures) is always a single CPU.

So this only might move interrupts to the hotplugged CPUs when the device
is initialized after CPU hotplug and the actual vector allocation moves an
interrupt out to the higher numbered CPUs if they have less vectors
allocated than the lower numbered ones.

Probably not an issue for the majority of machines where ACPI stupidly
claims that extra CPUs are possible while there is absolute no support for
physical hotplug.

Though in scenarios where "physical" hotplug is possible, e.g. virt, this
might come surprising.

Thanks,

	tglx
