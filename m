Return-Path: <rjwysocki@gmail.com>
MIME-Version: 1.0
Sender: rjwysocki@gmail.com
In-Reply-To: <1520930375.20980.213.camel@gmail.com>
References: <20180308105358.1506-1-ming.lei@redhat.com> <1520515113.20980.31.camel@gmail.com>
 <20180308133440.GA2713@ming.t460p> <alpine.DEB.2.21.1803090011150.1454@nanos.tec.linutronix.de>
 <20180309012458.GD5228@ming.t460p> <alpine.DEB.2.21.1803091107520.1364@nanos.tec.linutronix.de>
 <20180309120833.GB30257@ming.t460p> <alpine.DEB.2.21.1803091531000.1364@nanos.tec.linutronix.de>
 <5e5f3852-5314-c479-245e-d0a575e533a5@cn.fujitsu.com> <1520926721.20980.210.camel@gmail.com>
 <20180313083535.GA21612@ming.t460p> <1520930375.20980.213.camel@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 13 Mar 2018 10:35:30 +0100
Message-ID: <CAJZ5v0gcmkKVcgDBdt-aePgU0zvQwyf1yX5Qi_zRc1JfzaA5fg@mail.gmail.com>
Subject: Re: [PATCH V3 0/4] genirq/affinity: irq vector spread among online
 CPUs as far as possible
To: Artem Bityutskiy <dedekind1@gmail.com>
Cc: Ming Lei <ming.lei@redhat.com>, Dou Liyang <douly.fnst@cn.fujitsu.com>,
	Thomas Gleixner <tglx@linutronix.de>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@infradead.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-block@vger.kernel.org,
	Laurence Oberman <loberman@redhat.com>, "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Tue, Mar 13, 2018 at 9:39 AM, Artem Bityutskiy <dedekind1@gmail.com> wrote:
> On Tue, 2018-03-13 at 16:35 +0800, Ming Lei wrote:
>> Then looks this issue need to fix by making possible CPU count
>> accurate
>> because there are other resources allocated according to
>> num_possible_cpus(),
>> such as percpu variables.
>
> Short term the regression should be fixed. It is already v4.16-rc6, we
> have little time left.

Right.

> Longer term, yeah, I agree. Kernel's notion of possible CPU count
> should be realistic.

I agree.

Moreover, there are not too many systems where physical CPU hotplug
actually works in practice AFAICS, so IMO we should default to "no
physical CPU hotplug" and only change that default in special cases
(which may be hard to figure out, but that's a different matter).

What platform firmware tells us may be completely off.
