Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: Alexander Gordeev <agordeev@redhat.com>, Keith Busch
	<keith.busch@intel.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jens Axboe
	<axboe@kernel.dk>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>
Subject: Re: [PATCH RFC 00/21] blk-mq: Introduce combined hardware queues
Date: Mon, 19 Sep 2016 13:33:15 +0000
Message-ID: <BLUPR02MB1683C205076B5CFAFAA87B1681F40@BLUPR02MB1683.namprd02.prod.outlook.com>
References: <cover.1474014910.git.agordeev@redhat.com>
 <20160916210448.GA1178@localhost.localdomain>
 <20160919103805.GA22169@agordeev.lab.eng.brq.redhat.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On 09/19/16 03:38, Alexander Gordeev wrote:=0A=
> On Fri, Sep 16, 2016 at 05:04:48PM -0400, Keith Busch wrote:=0A=
>=0A=
> CC-ing linux-block@vger.kernel.org=0A=
>=0A=
>> I'm not sure I see how this helps. That probably means I'm not consideri=
ng=0A=
>> the right scenario. Could you elaborate on when having multiple hardware=
=0A=
>> queues to choose from a given CPU will provide a benefit?=0A=
>=0A=
> No, I do not keep in mind any particular scenario besides common=0A=
> sense. Just an assumption deeper queues are better (in this RFC=0A=
> a virtual combined queue consisting of multipe h/w queues).=0A=
>=0A=
> Apparently, there could be positive effects only in systems where=0A=
> # of queues / # of CPUs > 1 or # of queues / # of cores > 1. But=0A=
> I do not happen to have ones. If I had numbers this would not be=0A=
> the RFC and I probably would not have posted in the first place ;)=0A=
>=0A=
> Would it be possible to give it a try on your hardware?=0A=
=0A=
Hello Alexander,=0A=
=0A=
It is your task to measure the performance impact of these patches and =0A=
not Keith's task. BTW, I'm not convinced that multiple hardware queues =0A=
per CPU will result in a performance improvement. I have not yet seen =0A=
any SSD for which a queue depth above 512 results in better performance =0A=
than queue depth equal to 512. Which applications do you think will =0A=
generate and sustain a queue depth above 512? Additionally, my =0A=
experience from another high performance context (RDMA) is that reducing =
=0A=
the number of queues can result in higher IOPS due to fewer interrupts =0A=
per I/O.=0A=
=0A=
Bart.=0A=
