Return-Path: <ming.lei@redhat.com>
Date: Sat, 19 May 2018 06:26:28 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Keith Busch <keith.busch@linux.intel.com>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <keith.busch@intel.com>,
	Laurence Oberman <loberman@redhat.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	James Smart <james.smart@broadcom.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	Jianchao Wang <jianchao.w.wang@oracle.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V6 11/11] nvme: pci: support nested EH
Message-ID: <20180518222622.GA18334@ming.t460p>
References: <20180516040313.13596-1-ming.lei@redhat.com>
 <20180516040313.13596-12-ming.lei@redhat.com>
 <20180516141242.GA20119@localhost.localdomain>
 <20180516231058.GB28727@ming.t460p>
 <20180517022030.GB21959@localhost.localdomain>
 <20180518001958.GA2742@ming.t460p>
 <20180518135751.GI23555@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180518135751.GI23555@localhost.localdomain>
List-ID: <linux-block@vger.kernel.org>

On Fri, May 18, 2018 at 07:57:51AM -0600, Keith Busch wrote:
> On Fri, May 18, 2018 at 08:20:05AM +0800, Ming Lei wrote:
> > What I think block/011 is helpful is that it can trigger IO timeout
> > during reset, which can be triggered in reality too.
> 
> As I mentioned earlier, there is nothing wrong with the spirit of
> the test. What's wrong with it is the misguided implemention.
> 
> Do you underestand why it ever passes? The success happens when the
> enabling part of the loop happens to coincide with the driver's enabling,
> creating the pci_dev->enable_cnt > 1, making subsequent disable parts
> of the loop do absolutely nothing; the exact same as the one-liner
> (non-serious) patch I sent to defeat the test.
> 
> A better way to induce the timeout is:
> 
>   # setpci -s <B:D.f> 4.w=0:6
> 
> This will halt the device without messing with the kernel structures,
> just like how a real device failure would occur.

Frankly speaking, I don't care how the test-case is implemented at all.

The big problem is that NVMe driver can't handle IO time-out during
reset context, and finally either the controller becomes DEAD or reset
context hangs forever, and everything can't move on.

The issue can be reproduced easier via io-timeout-fail fault injection.

So could we please face to the real issue instead of working around
test case?

Thanks,
Ming
