Return-Path: <dedekind1@gmail.com>
Message-ID: <1520926721.20980.210.camel@gmail.com>
Subject: Re: [PATCH V3 0/4] genirq/affinity: irq vector spread among online
 CPUs as far as possible
From: Artem Bityutskiy <dedekind1@gmail.com>
Reply-To: dedekind1@gmail.com
To: Dou Liyang <douly.fnst@cn.fujitsu.com>, Thomas Gleixner
 <tglx@linutronix.de>,  Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, Laurence Oberman
	 <loberman@redhat.com>, "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 13 Mar 2018 09:38:41 +0200
In-Reply-To: <5e5f3852-5314-c479-245e-d0a575e533a5@cn.fujitsu.com>
References: <20180308105358.1506-1-ming.lei@redhat.com>
	 <1520515113.20980.31.camel@gmail.com> <20180308133440.GA2713@ming.t460p>
	 <alpine.DEB.2.21.1803090011150.1454@nanos.tec.linutronix.de>
	 <20180309012458.GD5228@ming.t460p>
	 <alpine.DEB.2.21.1803091107520.1364@nanos.tec.linutronix.de>
	 <20180309120833.GB30257@ming.t460p>
	 <alpine.DEB.2.21.1803091531000.1364@nanos.tec.linutronix.de>
	 <5e5f3852-5314-c479-245e-d0a575e533a5@cn.fujitsu.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Tue, 2018-03-13 at 11:11 +0800, Dou Liyang wrote:
>  I also
> met the situation that BIOS told to ACPI that it could support
> physical
> CPUs hotplug, But actually, there was no hardware slots in the
> machine.
> the ACPI tables like user inputs which should be validated when we
> use.

This is exactly what happens on Skylake Xeon systems. When I check
dmesg or this file:

/sys/devices/system/cpu/possible

on 2S (two socket) and 4S (four socket) systems, I see the same number
432.

This number comes from ACPI MADT. I will speculate (did not see myself)
that 8S systems will report the same number as well, because of the
Skylake-SP (Scalable Platform) architecture.

Number 432 is good for 8S systems, but it is way too large for 2S and
4S systems - 4x or 2x larger than the theoretical maximum.

I do not know why BIOSes have to report unrealistically high numbers, I
am just sharing my observation.

So yes, Linux kernel's possible CPU count knowledge may be too large.
If we use that number to evenly spread IRQ vectors among the CPUs, we
end up with wasted vectors, and even bugs, as I observe on a 2S
Skylake.

Artem.
