Return-Path: <keith.busch@linux.intel.com>
Date: Thu, 19 Jul 2018 09:56:16 -0600
From: Keith Busch <keith.busch@linux.intel.com>
To: "hch@lst.de" <hch@lst.de>
Cc: "axboe@kernel.dk" <axboe@kernel.dk>,
	"keith.busch@intel.com" <keith.busch@intel.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"ming.lei@redhat.com" <ming.lei@redhat.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	Bart Van Assche <Bart.VanAssche@wdc.com>
Subject: Re: [RFC PATCH 3/3] blk-mq: Remove generation seqeunce
Message-ID: <20180719155616.GG32160@localhost.localdomain>
References: <a32b251bd3c0a186e5c5ba82656a85fbdcc0c5e4.camel@wdc.com>
 <20180713184712.GA19419@localhost.localdomain>
 <291a13b35af1b65fbbe99a3a9cfc7d570a620cd9.camel@wdc.com>
 <20180713235807.GA19967@localhost.localdomain>
 <20180718195650.GA20336@lst.de>
 <20180718205321.GA32160@localhost.localdomain>
 <c67f3da64914a436bc76f3ec0bc261ee6178cd14.camel@wdc.com>
 <20180718211711.GB32160@localhost.localdomain>
 <20180719131903.GB13129@lst.de>
 <20180719145931.GF32160@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180719145931.GF32160@localhost.localdomain>
List-ID: <linux-block@vger.kernel.org>

On Thu, Jul 19, 2018 at 08:59:31AM -0600, Keith Busch wrote:
> > And we should never even hit the timeout handler for those as it
> > is rather pointless (although it looks we currently do..).
> 
> I don't see why we'd expect to never hit timeout for at least some of
> these. It's not a stretch to see, for example, that virtio-blk or loop
> could have their requests lost with no way to recover if we revert. I've
> wasted too much time debugging hardware for such lost commands when it
> was in fact functioning perfectly fine. So reintroducing that behavior
> is a bit distressing.

Even some scsi drivers are susceptible to losing their requests with the
reverted behavior: take virtio-scsi for example, which returns RESET_TIMER
from it's timeout handler. With the behavior everyone seems to want,
a natural completion at or around the same time is lost forever because
it was blocked from completion with no way to recover.

While the timing for when requests may be lost is quite narrow, I've
seen it enough with very difficult to reproduce scenarios that hardware
devs no longer trust IO timeouts are their problem because Linux loses
their completions.
