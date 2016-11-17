Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:25066 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751464AbcKQTj3 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Nov 2016 14:39:29 -0500
Date: Thu, 17 Nov 2016 12:33:23 -0700
From: Scott Bauer <scott.bauer@intel.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-block@vger.kernel.org, sagi@grimberg.me,
        Rafael.Antognolli@intel.com, axboe@fb.com,
        linux-nvme@lists.infradead.org, keith.busch@intel.com,
        jonathan.derrick@intel.com, j.naumann@fu-berlin.de
Subject: Re: [PATCH v1 0/7] SED OPAL Library
Message-ID: <20161117193322.GA3044@sbauer-Z170X-UD5>
References: <1479338252-8777-1-git-send-email-scott.bauer@intel.com>
 <20161117131251.GA15852@infradead.org>
 <20161117173613.GA13865@sbauer-Z170X-UD5>
 <20161117192807.GA31515@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161117192807.GA31515@infradead.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Nov 17, 2016 at 11:28:07AM -0800, Christoph Hellwig wrote:
> On Thu, Nov 17, 2016 at 10:36:14AM -0700, Scott Bauer wrote:
> > 
> > I want some further clarification, if you don't mind. We call sec_ops
> > inside the actual logic for the opal code. Which is only accessible via the
> > ioctls, is that what you were meaning?  When you say "the driver calls"
> > do you mean that the nvme/sata/et al drivers would implement some generic
> > block sed function that would be called via ioctl?
> > So the call chain would be:
> > 
> > Userland
> >  block/ioctl  ops->blkdev_sed()
> > 
> >   nvme/et al (implements blkdev_sed()) which calls:
> > 
> >    sed.c blkdev_sed_ioctl(with passed in combined fn to get data to controller)?
> > 
> > Is this what you were thinking, if so I agree it will alleviate a bunch of clutter
> > in block/ioctl.c. If this isn't what you were thinking please let me know.
> 
> Similar, but not quite the same.  We already have an ioctl method in
> struct block_device_operations, so in that we'd do something like
> this for nvme:

Ah okay this was the piece I was missing. I was mixed up on how we would
agnostically get it into the nvme drive and allow sata etc to do the same.

Thanks for your help i'll get working.
