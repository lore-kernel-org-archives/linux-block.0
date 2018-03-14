Return-Path: <dedekind1@gmail.com>
Message-ID: <1521018450.20980.220.camel@gmail.com>
Subject: Re: [PATCH V3 0/4] genirq/affinity: irq vector spread among online
 CPUs as far as possible
From: Artem Bityutskiy <dedekind1@gmail.com>
Reply-To: dedekind1@gmail.com
To: Dou Liyang <douly.fnst@cn.fujitsu.com>, "Rafael J. Wysocki"
	 <rafael@kernel.org>
Cc: Ming Lei <ming.lei@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>, Linux
 Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-block@vger.kernel.org, Laurence Oberman <loberman@redhat.com>
Date: Wed, 14 Mar 2018 11:07:30 +0200
In-Reply-To: <a8770022-a437-9b8c-0b2e-cd6bdc0764ef@cn.fujitsu.com>
References: <20180308105358.1506-1-ming.lei@redhat.com>
	 <1520515113.20980.31.camel@gmail.com> <20180308133440.GA2713@ming.t460p>
	 <alpine.DEB.2.21.1803090011150.1454@nanos.tec.linutronix.de>
	 <20180309012458.GD5228@ming.t460p>
	 <alpine.DEB.2.21.1803091107520.1364@nanos.tec.linutronix.de>
	 <20180309120833.GB30257@ming.t460p>
	 <alpine.DEB.2.21.1803091531000.1364@nanos.tec.linutronix.de>
	 <5e5f3852-5314-c479-245e-d0a575e533a5@cn.fujitsu.com>
	 <1520926721.20980.210.camel@gmail.com> <20180313083535.GA21612@ming.t460p>
	 <1520930375.20980.213.camel@gmail.com>
	 <CAJZ5v0gcmkKVcgDBdt-aePgU0zvQwyf1yX5Qi_zRc1JfzaA5fg@mail.gmail.com>
	 <ec20381d-b5d9-9e22-d94e-96bbb8d6278e@cn.fujitsu.com>
	 <a8770022-a437-9b8c-0b2e-cd6bdc0764ef@cn.fujitsu.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Wed, 2018-03-14 at 12:11 +0800, Dou Liyang wrote:
> > At 03/13/2018 05:35 PM, Rafael J. Wysocki wrote:
> > > On Tue, Mar 13, 2018 at 9:39 AM, Artem Bityutskiy 
> > > > Longer term, yeah, I agree. Kernel's notion of possible CPU
> > > > count
> > > > should be realistic.
> > 
> > I did a patch for that, Artem, could you help me to test it.
> > 
> 
> I didn't consider the nr_cpu_ids before. please ignore the old patch
> and
> try the following RFC patch.

Sure I can help with testing a patch, could we please:

1. Start a new thread for this
2. Include ACPI forum/folks

Thanks,
Artem.
