Return-Path: <jthumshirn@suse.de>
Date: Tue, 22 May 2018 09:35:39 +0200
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Keith Busch <keith.busch@linux.intel.com>
Cc: Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
	Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@kernel.dk>,
	Laurence Oberman <loberman@redhat.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	James Smart <james.smart@broadcom.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	Jianchao Wang <jianchao.w.wang@oracle.com>, bhelgaas@google.com,
	linux-pci@vger.kernel.org, arjan@linux.intel.com
Subject: Re: [PATCH V6 11/11] nvme: pci: support nested EH
Message-ID: <20180522073539.ygl4ibokbohnjxlj@linux-x5ow.site>
References: <20180516040313.13596-1-ming.lei@redhat.com>
 <20180516040313.13596-12-ming.lei@redhat.com>
 <20180516141242.GA20119@localhost.localdomain>
 <20180516231058.GB28727@ming.t460p>
 <20180517022030.GB21959@localhost.localdomain>
 <20180517084129.GA26570@lst.de>
 <20180517142051.GB22063@localhost.localdomain>
 <20180517142345.t6bnyfne7ndgrxkg@linux-x5ow.site>
 <20180518162804.GA27795@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20180518162804.GA27795@localhost.localdomain>
List-ID: <linux-block@vger.kernel.org>

On Fri, May 18, 2018 at 10:28:04AM -0600, Keith Busch wrote:
> On Thu, May 17, 2018 at 04:23:45PM +0200, Johannes Thumshirn wrote:
> > > Agreed. Alternatively possibly call the driver's reset_preparei/done
> > > callbacks.
> > 
> > Exactly, but as long as we can issue the reset via sysfs the test-case
> > is still valid.
> 
> I disagree the test case is valid. The test writes '0' to the
> pci-sysfs 'enable', but the driver also disables the pci device as part
> of resetting, which is a perfectly reasonable thing for a driver to do.
> 
> If the timing of the test's loop happens to write '0' right after the
> driver disabled the device that it owns, a 'write error' on that sysfs
> write occurs, and blktests then incorrectly claims the test failed.

Hmm, ok that's a valid point. But seeing you have sent a patch for
blktests anyways I think it's gone now.

-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: Felix Imend�rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N�rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
