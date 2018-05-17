Return-Path: <jthumshirn@suse.de>
Date: Thu, 17 May 2018 16:23:45 +0200
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
Message-ID: <20180517142345.t6bnyfne7ndgrxkg@linux-x5ow.site>
References: <20180516040313.13596-1-ming.lei@redhat.com>
 <20180516040313.13596-12-ming.lei@redhat.com>
 <20180516141242.GA20119@localhost.localdomain>
 <20180516231058.GB28727@ming.t460p>
 <20180517022030.GB21959@localhost.localdomain>
 <20180517084129.GA26570@lst.de>
 <20180517142051.GB22063@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20180517142051.GB22063@localhost.localdomain>
List-ID: <linux-block@vger.kernel.org>

On Thu, May 17, 2018 at 08:20:51AM -0600, Keith Busch wrote:
> > Heh.  But yes, this test and the PCI "enable" interface in sysfs look
> > horribly wrong. pci_disable_device/pci_enable_device aren't something we
> > can just do underneath the driver.  Even if injecting the lowlevel
> > config space manipulations done by it might be useful and a good test
> > the Linux state ones are just killing the driver.
> 
> Yes, I'm totally fine with injecting errors into the config space, but
> for goodness sakes, don't fuck with the internal kernel structures out
> from under drivers using them.
> 
> My suggestion is to use 'setpci' to disable the device if you want to
> inject this scenario. That way you get the desired broken device
> scenario you want to test, but struct pci_dev hasn't been altered.
>  
> > The enable attribute appears to have been added by Arjan for the
> > Xorg driver.  I think if we have a driver bound to the device we
> > should not allow it.
> 
> Agreed. Alternatively possibly call the driver's reset_preparei/done
> callbacks.

Exactly, but as long as we can issue the reset via sysfs the test-case
is still valid.

-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: Felix Imend�rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N�rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
