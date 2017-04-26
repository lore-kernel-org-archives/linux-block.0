Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "paolo.valente@linaro.org" <paolo.valente@linaro.org>,
	"juri.lelli@arm.com" <juri.lelli@arm.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"peterz@infradead.org" <peterz@infradead.org>, "patrick.bellasi@arm.com"
	<patrick.bellasi@arm.com>, "axboe@kernel.dk" <axboe@kernel.dk>,
	"joelaf@google.com" <joelaf@google.com>, "andresoportus@google.com"
	<andresoportus@google.com>, "morten.rasmussen@arm.com"
	<morten.rasmussen@arm.com>, "aherrmann@suse.com" <aherrmann@suse.com>
Subject: Re: bfq-mq performance comparison to cfq
Date: Wed, 26 Apr 2017 22:12:36 +0000
Message-ID: <1493244753.2632.22.camel@sandisk.com>
References: <20170410090538.GA11473@suselix.suse.de>
	 <82BCEB46-8D05-42DA-AE06-3426895A7842@linaro.org>
	 <1491837330.4199.1.camel@sandisk.com>
	 <B7819549-81C3-4952-A31D-5E4A0732AB14@linaro.org>
	 <CY1PR0401MB15362FAB3D841CDF2C421A2981180@CY1PR0401MB1536.namprd04.prod.outlook.com>
	 <4C1ABADD-6751-45E4-8DA1-ACA5A9E1379D@linaro.org>
	 <20170425094043.GB7959@e106622-lin>
	 <AA9E8536-4CD0-4A67-80F4-90445C331C90@linaro.org>
In-Reply-To: <AA9E8536-4CD0-4A67-80F4-90445C331C90@linaro.org>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Wed, 2017-04-26 at 10:18 +0200, Paolo Valente wrote:
> I guess that both the above issues may not be dramatic. In contrast,
> the following last issue seems harder to address: BFQ uses two
> different privileging schemes, one suitable for interactive
> applications, and one suitable for soft real-time applications. So,
> what scheme should BFQ enable for processes in the RT I/O class?
>
> Because of these concerns, also for I/O I would find much clearer and
> flexible an ad-hoc, complete and explicit solution like the one(s)
> Juri reports (I've already nagged some of the recipients here to get
> support and collaboration on such sort of extensions of the basic
> benefits of a good I/O scheduler).

The numerical values of I/O priorities are part of the API between kernel
and user space API and hence the numerical value associated with a class
must not change. But we would associate different priority values with
interactive and soft real-time applications, e.g. IOPRIO_CLASS_RT(0) for
soft real-time applications and IOPRIO_CLASS_RT(7) for interactive
applications. See also http://man7.org/linux/man-pages/man2/ioprio_set.2.ht=
ml.

In my opinion the above proposal does not contradict with what has been
proposed for informed run-times. We could e.g. add support for configuring
the I/O priority to the block I/O controller cgroup.

No matter how informed run-times communicate application constraints to the
kernel, the configured I/O scheduler and the block layer will have to reali=
ze
these constraints. If anyone thinks that there is a mechanism that is bette=
r
suited to communicate these constraints to the kernel than I/O priorities I=
'm
interested to hear about that alternative.

Bart.=
