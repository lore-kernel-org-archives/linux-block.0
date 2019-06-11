Return-Path: <SRS0=2dDp=UK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59B3AC4321A
	for <linux-block@archiver.kernel.org>; Tue, 11 Jun 2019 14:51:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F7662054F
	for <linux-block@archiver.kernel.org>; Tue, 11 Jun 2019 14:51:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391453AbfFKOvP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Jun 2019 10:51:15 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:35762 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S2389777AbfFKOvP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Jun 2019 10:51:15 -0400
Received: (qmail 2357 invoked by uid 2102); 11 Jun 2019 10:51:14 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 11 Jun 2019 10:51:14 -0400
Date:   Tue, 11 Jun 2019 10:51:14 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Christoph Hellwig <hch@lst.de>
cc:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: Re: How to resolve an issue in swiotlb environment?
In-Reply-To: <20190611064158.GA20601@lst.de>
Message-ID: <Pine.LNX.4.44L0.1906110956510.1535-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 11 Jun 2019, Christoph Hellwig wrote:

> Hi Alan,
> 
> thanks for the explanation.  It seems like what usb wants is to:
> 
>  - set sg_tablesize to 1 for devices that can't handle scatterlist at all

Hmmm.  usb-storage (and possible other drivers too) currently handles
such controllers by setting up an SG transfer as a series of separate
URBs, one for each scatterlist entry.  But this is not the same thing,
for two reasons:

	It has less I/O overhead than setting sg_tablesize to 1 because 
	it sets up the whole transfer as a single SCSI command, which 
	requires much less time and traffic on the USB bus than sending 
	multiple commands.

	It has that requirement about each scatterlist element except
	the last being a multiple of the maximum packet size in length.
	(This is because the USB protocol says that a transfer ends
	whenever a less-than-maximum-size packet is encountered.)

We would like to avoid the extra I/O overhead for host controllers that
can't handle SG.  In fact, switching to sg_tablesize = 1 would probably
be considered a regression.

>  - set the virt boundary as-is for devices supporting "basic" scatterlist,
>    although that still assumes they can rejiggle them because for example
>    you could still get a smaller than expected first segment ala (assuming
>    a 1024 byte packet size and thus 1023 virt_boundary_mask):
> 
>         | 0 .. 511 | 512 .. 1023 | 1024 .. 1535 |
> 
>    as the virt_bondary does not guarantee that the first segment is
>    the same size as all the mid segments.

But that is exactly the problem we need to solve.

The issue which prompted the commit this thread is about arose in a
situation where the block layer set up a scatterlist containing buffer
sizes something like:

	4096 4096 1536 1024

and the maximum packet size was 1024.  The situation was a little 
unusual, because it involved vhci-hcd (a virtual HCD).  This doesn't 
matter much in normal practice because:

	Block devices normally have a block size of 512 bytes or more.
	Smaller values are very uncommon.  So scatterlist element sizes
	are always divisible by 512.

	xHCI is the only USB host controller type with a maximum packet 
	size larger than 512, and xHCI hardware can do full 
	scatter-gather so it doesn't care what the buffer sizes are.

So another approach would be to fix vhci-hcd and then trust that the
problem won't arise again, for the reasons above.  We would be okay so
long as nobody tried to use a USB-SCSI device with a block size of 256
bytes or less.

>  - do not set any limit on xhci
> 
> But that just goes back to the original problem, and that is that with
> swiotlb we are limited in the total dma mapping size, and recent block
> layer changes in the way we handle the virt_boundary mean we now build
> much larger requests by default.  For SCSI ULDs to take that into
> account I need to call dma_max_mapping_size() and use that as the
> upper bound for the request size.  My plan is to do that in scsi_lib.c,
> but for that we need to expose the actual struct device that the dma
> mapping is perfomed on to the scsi layer.  If that device is different
> from the sysfs hierchary struct device, which it is for usb the ULDD
> needs to scsi_add_host_with_dma and pass the dma device as well.  How
> do I get at the dma device (aka the HCDs pci_dev or similar) from
> usb-storage/uas?

From usb_stor_probe2(): us->pusb_dev->bus->sysdev.
From uas_probe(): udev->bus->sysdev.

The ->sysdev field points to the device used for DMA mapping.  It is
often the same as ->controller, but sometimes it is
->controller->parent because of the peculiarities of some platforms.

Alan Stern

