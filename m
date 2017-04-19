Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "paolo.valente@linaro.org" <paolo.valente@linaro.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"aherrmann@suse.com" <aherrmann@suse.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: bfq-mq performance comparison to cfq
Date: Wed, 19 Apr 2017 15:43:21 +0000
Message-ID: <1492616599.2543.2.camel@sandisk.com>
References: <20170410090538.GA11473@suselix.suse.de>
	 <82BCEB46-8D05-42DA-AE06-3426895A7842@linaro.org>
	 <1491837330.4199.1.camel@sandisk.com>
	 <B7819549-81C3-4952-A31D-5E4A0732AB14@linaro.org>
	 <CY1PR0401MB15362FAB3D841CDF2C421A2981180@CY1PR0401MB1536.namprd04.prod.outlook.com>
	 <4C1ABADD-6751-45E4-8DA1-ACA5A9E1379D@linaro.org>
In-Reply-To: <4C1ABADD-6751-45E4-8DA1-ACA5A9E1379D@linaro.org>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Wed, 2017-04-19 at 09:02 +0200, Paolo Valente wrote:
> > Il giorno 19 apr 2017, alle ore 07:01, Bart Van Assche <bart.vanassche@=
sandisk.com> ha scritto:
> > What API was used by the Android application to tell the I/O scheduler=
=20
> > to optimize for latency? Do you think that it would be sufficient if th=
e=20
> > application uses the ioprio_set() system call to set the I/O priority t=
o=20
> > IOPRIO_CLASS_RT?
>=20
> That's exactly the hack we are using in our prototype.  However, it
> can only be a temporary hack, because it mixes two slightly different
> concepts: 1) the activation of weight raising and other mechanisms for
> reducing latency for the target app, 2) the assignment of a different
> priority class, which (cleanly) means just that processes in a lower
> priority class will be served only when the processes of the target
> app have no pending I/O request.  Finding a clean boosting API would
> be one of the main steps to turn our prototype into a usable solution.

Hello Paolo,

Sorry but I do not agree that you call this use of I/O priorities a hack.
I also do not agree that I/O requests submitted by processes in a lower
priority class will only be served by the I/O scheduler when there are no
pending requests in a higher class. It wouldn't be that hard to modify I/O
schedulers that support I/O priorities to avoid the starvation you referred
to. What I expect that will happen is that sooner or later a Linux
distributor will start receiving bug reports about the heuristics for
detecting interactive and streaming applications and that the person who
will work on that bug report will realize that it will be easier to remove
those heuristics from BFQ and to modify streaming applications and the
software that starts interactive applications (e.g. a window manager) to
use a higher I/O priority.

Please also note that what I described above may require to introduce
additional I/O priorities in the Linux kernel next to the existing I/O
priorities RT, BE and NONE and that this may require to map multiple of
these priorities onto the same drive priority.

Bart.=
