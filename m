Return-Path: <keith.busch@linux.intel.com>
Date: Thu, 17 May 2018 08:20:51 -0600
From: Keith Busch <keith.busch@linux.intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>, Keith Busch <keith.busch@intel.com>,
	Jens Axboe <axboe@kernel.dk>,
	Laurence Oberman <loberman@redhat.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	James Smart <james.smart@broadcom.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	Jianchao Wang <jianchao.w.wang@oracle.com>,
	Johannes Thumshirn <jthumshirn@suse.de>, bhelgaas@google.com,
	linux-pci@vger.kernel.org, arjan@linux.intel.com
Subject: Re: [PATCH V6 11/11] nvme: pci: support nested EH
Message-ID: <20180517142051.GB22063@localhost.localdomain>
References: <20180516040313.13596-1-ming.lei@redhat.com>
 <20180516040313.13596-12-ming.lei@redhat.com>
 <20180516141242.GA20119@localhost.localdomain>
 <20180516231058.GB28727@ming.t460p>
 <20180517022030.GB21959@localhost.localdomain>
 <20180517084129.GA26570@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180517084129.GA26570@lst.de>
List-ID: <linux-block@vger.kernel.org>

On Thu, May 17, 2018 at 10:41:29AM +0200, Christoph Hellwig wrote:
> On Wed, May 16, 2018 at 08:20:31PM -0600, Keith Busch wrote:
> > On Thu, May 17, 2018 at 07:10:59AM +0800, Ming Lei wrote:
> > > All simulation in block/011 may happen in reality.
> > 
> > If this test actually simulates reality, then the following one line
> > patch (plus explanation for why) would be a real "fix" as this is very
> > successful in passing block/011. :)
> > 
> > ---
> > diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> > index 1faa32cd07da..dcc5746304c4 100644
> > --- a/drivers/nvme/host/pci.c
> > +++ b/drivers/nvme/host/pci.c
> > @@ -2118,6 +2118,12 @@ static int nvme_pci_enable(struct nvme_dev *dev)
> >  
> >  	if (pci_enable_device_mem(pdev))
> >  		return result;
> > +	/*
> > +	 * blktests block/011 disables the device without the driver knowing.
> > +	 * We'll just enable the device twice to get the enable_cnt > 1
> > +	 * so that the test's disabling does absolutely nothing.
> > +	 */
> > +	pci_enable_device_mem(pdev);
> 
> Heh.  But yes, this test and the PCI "enable" interface in sysfs look
> horribly wrong. pci_disable_device/pci_enable_device aren't something we
> can just do underneath the driver.  Even if injecting the lowlevel
> config space manipulations done by it might be useful and a good test
> the Linux state ones are just killing the driver.

Yes, I'm totally fine with injecting errors into the config space, but
for goodness sakes, don't fuck with the internal kernel structures out
from under drivers using them.

My suggestion is to use 'setpci' to disable the device if you want to
inject this scenario. That way you get the desired broken device
scenario you want to test, but struct pci_dev hasn't been altered.
 
> The enable attribute appears to have been added by Arjan for the
> Xorg driver.  I think if we have a driver bound to the device we
> should not allow it.

Agreed. Alternatively possibly call the driver's reset_preparei/done
callbacks.
