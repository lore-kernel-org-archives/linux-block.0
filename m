Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "aherrmann@suse.com" <aherrmann@suse.com>, "paolo.valente@linaro.org"
	<paolo.valente@linaro.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: bfq-mq performance comparison to cfq
Date: Mon, 10 Apr 2017 15:15:31 +0000
Message-ID: <1491837330.4199.1.camel@sandisk.com>
References: <20170410090538.GA11473@suselix.suse.de>
	 <82BCEB46-8D05-42DA-AE06-3426895A7842@linaro.org>
In-Reply-To: <82BCEB46-8D05-42DA-AE06-3426895A7842@linaro.org>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Mon, 2017-04-10 at 11:55 +0200, Paolo Valente wrote:
> That said, if you do always want maximum throughput, even at the
> expense of latency, then just switch off low-latency heuristics, i.e.,
> set low_latency to 0.  Depending on the device, setting slice_ilde to
> 0 may help a lot too (as well as with CFQ).  If the throughput is
> still low also after forcing BFQ to an only-throughput mode, then you
> hit some bug, and I'll have a little more work to do ...

Hello Paolo,

Has it been considered to make applications tell the I/O scheduler
whether to optimize for latency or for throughput? It shouldn't be that
hard for window managers and shells to figure out whether or not a new
application that is being started is interactive or not. This would
require a mechanism that allows applications to provide such information
to the I/O scheduler. Wouldn't that be a better approach than the I/O
scheduler trying to guess whether or not an application is an interactive
application?

Bart.=
