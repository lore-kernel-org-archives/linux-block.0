Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: Paolo Valente <paolo.valente@linaro.org>
CC: "aherrmann@suse.com" <aherrmann@suse.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: bfq-mq performance comparison to cfq
Date: Wed, 19 Apr 2017 05:01:36 +0000
Message-ID: <CY1PR0401MB15362FAB3D841CDF2C421A2981180@CY1PR0401MB1536.namprd04.prod.outlook.com>
References: <20170410090538.GA11473@suselix.suse.de>
 <82BCEB46-8D05-42DA-AE06-3426895A7842@linaro.org>
 <1491837330.4199.1.camel@sandisk.com>
 <B7819549-81C3-4952-A31D-5E4A0732AB14@linaro.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On 04/11/17 00:29, Paolo Valente wrote:=0A=
>=0A=
>> Il giorno 10 apr 2017, alle ore 17:15, Bart Van Assche <bart.vanassche@s=
andisk.com> ha scritto:=0A=
>>=0A=
>> On Mon, 2017-04-10 at 11:55 +0200, Paolo Valente wrote:=0A=
>>> That said, if you do always want maximum throughput, even at the=0A=
>>> expense of latency, then just switch off low-latency heuristics, i.e.,=
=0A=
>>> set low_latency to 0.  Depending on the device, setting slice_ilde to=
=0A=
>>> 0 may help a lot too (as well as with CFQ).  If the throughput is=0A=
>>> still low also after forcing BFQ to an only-throughput mode, then you=
=0A=
>>> hit some bug, and I'll have a little more work to do ...=0A=
>>=0A=
>> Has it been considered to make applications tell the I/O scheduler=0A=
>> whether to optimize for latency or for throughput? It shouldn't be that=
=0A=
>> hard for window managers and shells to figure out whether or not a new=
=0A=
>> application that is being started is interactive or not. This would=0A=
>> require a mechanism that allows applications to provide such information=
=0A=
>> to the I/O scheduler. Wouldn't that be a better approach than the I/O=0A=
>> scheduler trying to guess whether or not an application is an interactiv=
e=0A=
>> application?=0A=
>=0A=
> IMO that would be an (or maybe the) optimal solution, in terms of both=0A=
> throughput and latency.  We have even developed a prototype doing what=0A=
> you propose, for Android.  Unfortunately, I have not yet succeeded in=0A=
> getting support, to turn it into candidate production code, or to make=0A=
> a similar solution for lsb-compliant systems.=0A=
=0A=
Hello Paolo,=0A=
=0A=
What API was used by the Android application to tell the I/O scheduler =0A=
to optimize for latency? Do you think that it would be sufficient if the =
=0A=
application uses the ioprio_set() system call to set the I/O priority to =
=0A=
IOPRIO_CLASS_RT?=0A=
=0A=
Thanks,=0A=
=0A=
Bart.=0A=
