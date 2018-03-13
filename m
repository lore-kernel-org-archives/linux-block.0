Return-Path: <rjwysocki@gmail.com>
MIME-Version: 1.0
Sender: rjwysocki@gmail.com
In-Reply-To: <5e5f3852-5314-c479-245e-d0a575e533a5@cn.fujitsu.com>
References: <20180308105358.1506-1-ming.lei@redhat.com> <1520515113.20980.31.camel@gmail.com>
 <20180308133440.GA2713@ming.t460p> <alpine.DEB.2.21.1803090011150.1454@nanos.tec.linutronix.de>
 <20180309012458.GD5228@ming.t460p> <alpine.DEB.2.21.1803091107520.1364@nanos.tec.linutronix.de>
 <20180309120833.GB30257@ming.t460p> <alpine.DEB.2.21.1803091531000.1364@nanos.tec.linutronix.de>
 <5e5f3852-5314-c479-245e-d0a575e533a5@cn.fujitsu.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 13 Mar 2018 10:25:19 +0100
Message-ID: <CAJZ5v0hKYJY9W3Gjo-KZzmfXhT7JqBxbe=AGPSQOSd4DCThJVA@mail.gmail.com>
Subject: Re: [PATCH V3 0/4] genirq/affinity: irq vector spread among online
 CPUs as far as possible
To: Dou Liyang <douly.fnst@cn.fujitsu.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ming Lei <ming.lei@redhat.com>,
	Artem Bityutskiy <dedekind1@gmail.com>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@infradead.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-block@vger.kernel.org,
	Laurence Oberman <loberman@redhat.com>, "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Tue, Mar 13, 2018 at 4:11 AM, Dou Liyang <douly.fnst@cn.fujitsu.com> wrote:
> Hi Thomas,
>
> At 03/09/2018 11:08 PM, Thomas Gleixner wrote:
> [...]
>>
>>
>> I'm not sure if there is a clear indicator whether physcial hotplug is
>> supported or not, but the ACPI folks (x86) and architecture maintainers
>
> +cc Rafael
>
>> should be able to answer that question. I have a machine which says:
>>
>>     smpboot: Allowing 128 CPUs, 96 hotplug CPUs
>>
>> There is definitely no way to hotplug anything on that machine and sure
>> the
>
>
> AFAIK, in ACPI based dynamic reconfiguration, there is no clear
> indicator. In theory, If the ACPI tables have the hotpluggable
> CPU resources, the OS can support physical hotplug.

In order for the ACPI-based CPU hotplug (I mean physical, not just the
software offline/online we do in the kernel) to work, there have to be
objects in the ACPI namespace corresponding to all of the processors
in question.

If they are not present, there is no way to signal insertion and eject
the processors safely.
