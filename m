Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:1415 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750896AbdGEP47 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 5 Jul 2017 11:56:59 -0400
Date: Wed, 5 Jul 2017 12:03:35 -0400
From: Keith Busch <keith.busch@intel.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Wei Zhang <wzhang@fb.com>, linux-block@vger.kernel.org,
        kernel-team@fb.com, linux-nvme@lits.infradead.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] nvme: remove pci device if no longer present
Message-ID: <20170705160335.GA22200@localhost.localdomain>
References: <20170630235604.880695-1-wzhang@fb.com>
 <20170702153151.GA12387@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170702153151.GA12387@infradead.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Sun, Jul 02, 2017 at 08:31:51AM -0700, Christoph Hellwig wrote:
> Please CC the linux-nvme list on any nvme issues.  Also this
> code is getting a little too fancy for living in nvme, I think we
> need to move it into the PCI core, ensure we properly take drv->lock
> to synchronize it, and check for dev->drv instead of the private data
> which is a guestimate.

I agree this sort of thing needs to go in the PCI layer to as common
solution for all devices. The NVMe driver shouldn't be responsible for bus
enumeration events. When we did that before, races with pciehp were a
problem.

Also, we don't have a once-per-second health check event that would have
been needed to even catch this event in the first place. To get here now,
you'll have to issue an nvme reset or wait 60 seconds after sending an
admin or IO command.
 
> On Fri, Jun 30, 2017 at 04:56:04PM -0700, Wei Zhang wrote:
> > This patch removes the PCI device from the kernel's topology tree
> > if the device is no longer present.
> > 
> > Commit ddf097ec1d44c9648c4738d7cf2819411b44253a (NVMe: Unbind driver on
> > failure) left the PCI device in the kernel's topology upon device failure.
> > However, this does not work well for the slot power off/on test cases.
> > After a slot power off, we need to manually remove the PCI device
> > before triggering the rescan, in order for the SSD to be rediscovered.
> > 
> > Fixes: ddf097ec1d44c9648c4738d7cf2819411b44253a
> > Signed-off-by: Wei Zhang <wzhang@fb.com>
> > Reviewed-by: Jens Axboe <axboe@fb.com>
> > ---
> >  drivers/nvme/host/pci.c | 15 +++++++++++++--
> >  1 file changed, 13 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> > index 32a98e2..094b22f 100644
> > --- a/drivers/nvme/host/pci.c
> > +++ b/drivers/nvme/host/pci.c
> > @@ -2174,8 +2174,19 @@ static void nvme_remove_dead_ctrl_work(struct work_struct *work)
> >  	struct pci_dev *pdev = to_pci_dev(dev->dev);
> >  
> >  	nvme_kill_queues(&dev->ctrl);
> > -	if (pci_get_drvdata(pdev))
> > -		device_release_driver(&pdev->dev);
> > +
> > +	/*
> > +	 * Remove the PCI device from the topology tree if the device is no longer
> > +	 * present.  Without removing, slot power off/on test cannot re-discover
> > +	 * the SSD.
> > +	 */
> > +	if (pci_get_drvdata(pdev)) {
> > +		if (!pci_device_is_present(pdev)) {
> > +			pci_stop_and_remove_bus_device_locked(pdev);
> > +		} else {
> > +			device_release_driver(&pdev->dev);
> > +		}
> > +	}
> >  	nvme_put_ctrl(&dev->ctrl);
> >  }
