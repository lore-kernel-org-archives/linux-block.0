Return-Path: <douly.fnst@cn.fujitsu.com>
Subject: Re: [PATCH V3 0/4] genirq/affinity: irq vector spread among online
 CPUs as far as possible
To: Thomas Gleixner <tglx@linutronix.de>, Ming Lei <ming.lei@redhat.com>
CC: Artem Bityutskiy <dedekind1@gmail.com>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-block@vger.kernel.org>, Laurence Oberman <loberman@redhat.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>
References: <20180308105358.1506-1-ming.lei@redhat.com>
 <1520515113.20980.31.camel@gmail.com> <20180308133440.GA2713@ming.t460p>
 <alpine.DEB.2.21.1803090011150.1454@nanos.tec.linutronix.de>
 <20180309012458.GD5228@ming.t460p>
 <alpine.DEB.2.21.1803091107520.1364@nanos.tec.linutronix.de>
 <20180309120833.GB30257@ming.t460p>
 <alpine.DEB.2.21.1803091531000.1364@nanos.tec.linutronix.de>
From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Message-ID: <5e5f3852-5314-c479-245e-d0a575e533a5@cn.fujitsu.com>
Date: Tue, 13 Mar 2018 11:11:02 +0800
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1803091531000.1364@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="gbk"; format=flowed
List-ID: <linux-block@vger.kernel.org>

Hi Thomas,

At 03/09/2018 11:08 PM, Thomas Gleixner wrote:
[...]
> 
> I'm not sure if there is a clear indicator whether physcial hotplug is
> supported or not, but the ACPI folks (x86) and architecture maintainers
+cc Rafael

> should be able to answer that question. I have a machine which says:
> 
>     smpboot: Allowing 128 CPUs, 96 hotplug CPUs
> 
> There is definitely no way to hotplug anything on that machine and sure the

AFAIK, in ACPI based dynamic reconfiguration, there is no clear
indicator. In theory, If the ACPI tables have the hotpluggable
CPU resources, the OS can support physical hotplug.

For your machine, Did your CPUs support multi-threading, but not enable
it?

And, sometimes we should not trust the number of possible CPUs. I also
met the situation that BIOS told to ACPI that it could support physical
CPUs hotplug, But actually, there was no hardware slots in the machine.
the ACPI tables like user inputs which should be validated when we use.

> existing spread algorithm will waste vectors to no end.
> 
> Sure then there is virt, which can pretend to have a gazillion of possible
> hotpluggable CPUs, but virt is an insanity on its own. Though someone might
> come up with reasonable heuristics for that as well.
> 
> Thoughts?

Do we have to map the vectors to CPU statically? Can we map them when
we hotplug/enable the possible CPU?

Thanks,

	dou
