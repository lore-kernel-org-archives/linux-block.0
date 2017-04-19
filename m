Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: bfq-mq performance comparison to cfq
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <CY1PR0401MB15362FAB3D841CDF2C421A2981180@CY1PR0401MB1536.namprd04.prod.outlook.com>
Date: Wed, 19 Apr 2017 09:02:49 +0200
Cc: "aherrmann@suse.com" <aherrmann@suse.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "axboe@kernel.dk" <axboe@kernel.dk>
Message-Id: <4C1ABADD-6751-45E4-8DA1-ACA5A9E1379D@linaro.org>
References: <20170410090538.GA11473@suselix.suse.de> <82BCEB46-8D05-42DA-AE06-3426895A7842@linaro.org> <1491837330.4199.1.camel@sandisk.com> <B7819549-81C3-4952-A31D-5E4A0732AB14@linaro.org> <CY1PR0401MB15362FAB3D841CDF2C421A2981180@CY1PR0401MB1536.namprd04.prod.outlook.com>
To: Bart Van Assche <bart.vanassche@sandisk.com>
List-ID: <linux-block@vger.kernel.org>


> Il giorno 19 apr 2017, alle ore 07:01, Bart Van Assche =
<bart.vanassche@sandisk.com> ha scritto:
>=20
> On 04/11/17 00:29, Paolo Valente wrote:
>>=20
>>> Il giorno 10 apr 2017, alle ore 17:15, Bart Van Assche =
<bart.vanassche@sandisk.com> ha scritto:
>>>=20
>>> On Mon, 2017-04-10 at 11:55 +0200, Paolo Valente wrote:
>>>> That said, if you do always want maximum throughput, even at the
>>>> expense of latency, then just switch off low-latency heuristics, =
i.e.,
>>>> set low_latency to 0.  Depending on the device, setting slice_ilde =
to
>>>> 0 may help a lot too (as well as with CFQ).  If the throughput is
>>>> still low also after forcing BFQ to an only-throughput mode, then =
you
>>>> hit some bug, and I'll have a little more work to do ...
>>>=20
>>> Has it been considered to make applications tell the I/O scheduler
>>> whether to optimize for latency or for throughput? It shouldn't be =
that
>>> hard for window managers and shells to figure out whether or not a =
new
>>> application that is being started is interactive or not. This would
>>> require a mechanism that allows applications to provide such =
information
>>> to the I/O scheduler. Wouldn't that be a better approach than the =
I/O
>>> scheduler trying to guess whether or not an application is an =
interactive
>>> application?
>>=20
>> IMO that would be an (or maybe the) optimal solution, in terms of =
both
>> throughput and latency.  We have even developed a prototype doing =
what
>> you propose, for Android.  Unfortunately, I have not yet succeeded in
>> getting support, to turn it into candidate production code, or to =
make
>> a similar solution for lsb-compliant systems.
>=20
> Hello Paolo,
>=20
> What API was used by the Android application to tell the I/O scheduler=20=

> to optimize for latency? Do you think that it would be sufficient if =
the=20
> application uses the ioprio_set() system call to set the I/O priority =
to=20
> IOPRIO_CLASS_RT?
>=20

That's exactly the hack we are using in our prototype.  However, it
can only be a temporary hack, because it mixes two slightly different
concepts: 1) the activation of weight raising and other mechanisms for
reducing latency for the target app, 2) the assignment of a different
priority class, which (cleanly) means just that processes in a lower
priority class will be served only when the processes of the target
app have no pending I/O request.  Finding a clean boosting API would
be one of the main steps to turn our prototype into a usable solution.

Thanks,
Paolo

> Thanks,
>=20
> Bart.
