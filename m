Return-Path: <ming.lei@redhat.com>
Date: Fri, 18 May 2018 09:01:48 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Keith Busch <keith.busch@linux.intel.com>
Cc: Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@kernel.dk>,
	Laurence Oberman <loberman@redhat.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	James Smart <james.smart@broadcom.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	Jianchao Wang <jianchao.w.wang@oracle.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V6 11/11] nvme: pci: support nested EH
Message-ID: <20180518010147.GB2742@ming.t460p>
References: <20180516040313.13596-1-ming.lei@redhat.com>
 <20180516040313.13596-12-ming.lei@redhat.com>
 <20180516141242.GA20119@localhost.localdomain>
 <20180516231058.GB28727@ming.t460p>
 <20180517022030.GB21959@localhost.localdomain>
 <20180518001958.GA2742@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180518001958.GA2742@ming.t460p>
List-ID: <linux-block@vger.kernel.org>

On Fri, May 18, 2018 at 08:19:58AM +0800, Ming Lei wrote:
> On Wed, May 16, 2018 at 08:20:31PM -0600, Keith Busch wrote:
> > Hi Ming,
> > 
> > I'm developing the answers in code the issues you raised. It will just
> > take a moment to complete flushing those out. In the meantime just want
> > to point out why I think block/011 isn't a real test.
> > 
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
> What I think block/011 is helpful is that it can trigger IO timeout
> during reset, which can be triggered in reality too.
> 
> That is one big problem of NVMe driver, IMO.
> 
> And this patch does fix this issue, together other timeout related
> races.

BTW, the above patch may not be enough to 'fix' this NVMe issue, I guess
you may have to figure out another one to remove fault-injection, or at
least disable io-timeout-fail on NVMe.

Thanks,
Ming
