Return-Path: <keith.busch@linux.intel.com>
Date: Fri, 18 May 2018 10:28:04 -0600
From: Keith Busch <keith.busch@linux.intel.com>
To: Johannes Thumshirn <jthumshirn@suse.de>
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
Message-ID: <20180518162804.GA27795@localhost.localdomain>
References: <20180516040313.13596-1-ming.lei@redhat.com>
 <20180516040313.13596-12-ming.lei@redhat.com>
 <20180516141242.GA20119@localhost.localdomain>
 <20180516231058.GB28727@ming.t460p>
 <20180517022030.GB21959@localhost.localdomain>
 <20180517084129.GA26570@lst.de>
 <20180517142051.GB22063@localhost.localdomain>
 <20180517142345.t6bnyfne7ndgrxkg@linux-x5ow.site>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180517142345.t6bnyfne7ndgrxkg@linux-x5ow.site>
List-ID: <linux-block@vger.kernel.org>

On Thu, May 17, 2018 at 04:23:45PM +0200, Johannes Thumshirn wrote:
> > Agreed. Alternatively possibly call the driver's reset_preparei/done
> > callbacks.
> 
> Exactly, but as long as we can issue the reset via sysfs the test-case
> is still valid.

I disagree the test case is valid. The test writes '0' to the
pci-sysfs 'enable', but the driver also disables the pci device as part
of resetting, which is a perfectly reasonable thing for a driver to do.

If the timing of the test's loop happens to write '0' right after the
driver disabled the device that it owns, a 'write error' on that sysfs
write occurs, and blktests then incorrectly claims the test failed.
