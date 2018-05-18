Return-Path: <ming.lei@redhat.com>
Date: Sat, 19 May 2018 07:51:29 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Keith Busch <keith.busch@linux.intel.com>
Cc: Jens Axboe <axboe@kernel.dk>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	Laurence Oberman <loberman@redhat.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	James Smart <james.smart@broadcom.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Keith Busch <keith.busch@intel.com>,
	Jianchao Wang <jianchao.w.wang@oracle.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V6 11/11] nvme: pci: support nested EH
Message-ID: <20180518235128.GA19799@ming.t460p>
References: <20180516040313.13596-1-ming.lei@redhat.com>
 <20180516040313.13596-12-ming.lei@redhat.com>
 <20180516141242.GA20119@localhost.localdomain>
 <20180516231058.GB28727@ming.t460p>
 <20180517022030.GB21959@localhost.localdomain>
 <20180518001958.GA2742@ming.t460p>
 <20180518135751.GI23555@localhost.localdomain>
 <20180518222622.GA18334@ming.t460p>
 <20180518234500.GB31749@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180518234500.GB31749@localhost.localdomain>
List-ID: <linux-block@vger.kernel.org>

On Fri, May 18, 2018 at 05:45:00PM -0600, Keith Busch wrote:
> On Sat, May 19, 2018 at 06:26:28AM +0800, Ming Lei wrote:
> > So could we please face to the real issue instead of working around
> > test case?
> 
> Yes, that's why I want you to stop referencing the broken test.

Unfortunately I don't care if it is broken or not, and I think
the test case is great because it can expose the real problem.
That is its value!

The reason why I referenced this test is that everyone can reproduce
this real issue easily, that is it.

Thanks,
Ming
