Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Content-Type: text/plain; charset=iso-8859-1
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: bfq-mq performance comparison to cfq
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <1491837330.4199.1.camel@sandisk.com>
Date: Tue, 11 Apr 2017 09:29:46 +0200
Cc: "aherrmann@suse.com" <aherrmann@suse.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "axboe@kernel.dk" <axboe@kernel.dk>
Message-Id: <B7819549-81C3-4952-A31D-5E4A0732AB14@linaro.org>
References: <20170410090538.GA11473@suselix.suse.de> <82BCEB46-8D05-42DA-AE06-3426895A7842@linaro.org> <1491837330.4199.1.camel@sandisk.com>
To: Bart Van Assche <bart.vanassche@sandisk.com>
List-ID: <linux-block@vger.kernel.org>


> Il giorno 10 apr 2017, alle ore 17:15, Bart Van Assche =
<bart.vanassche@sandisk.com> ha scritto:
>=20
> On Mon, 2017-04-10 at 11:55 +0200, Paolo Valente wrote:
>> That said, if you do always want maximum throughput, even at the
>> expense of latency, then just switch off low-latency heuristics, =
i.e.,
>> set low_latency to 0.  Depending on the device, setting slice_ilde to
>> 0 may help a lot too (as well as with CFQ).  If the throughput is
>> still low also after forcing BFQ to an only-throughput mode, then you
>> hit some bug, and I'll have a little more work to do ...
>=20
> Hello Paolo,
>=20
> Has it been considered to make applications tell the I/O scheduler
> whether to optimize for latency or for throughput? It shouldn't be =
that
> hard for window managers and shells to figure out whether or not a new
> application that is being started is interactive or not. This would
> require a mechanism that allows applications to provide such =
information
> to the I/O scheduler. Wouldn't that be a better approach than the I/O
> scheduler trying to guess whether or not an application is an =
interactive
> application?
>=20

IMO that would be an (or maybe the) optimal solution, in terms of both
throughput and latency.  We have even developed a prototype doing what
you propose, for Android.  Unfortunately, I have not yet succeeded in
getting support, to turn it into candidate production code, or to make
a similar solution for lsb-compliant systems.

Thanks,
Paolo


> Bart.
