Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:54814 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750708AbcLAKE7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 1 Dec 2016 05:04:59 -0500
Date: Thu, 1 Dec 2016 02:04:56 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Keith Busch <keith.busch@intel.com>
Cc: Scott Bauer <scott.bauer@intel.com>, hch@infradead.org,
        sagi@grimberg.me, Rafael.Antognolli@intel.com,
        linux-nvme@lists.infradead.org, axboe@fb.com,
        linux-block@vger.kernel.org, jonathan.derrick@intel.com,
        j.naumann@fu-berlin.de
Subject: Re: [PATCH v2 2/4] block: Add Sed-opal library
Message-ID: <20161201100456.GA17592@infradead.org>
References: <1480456322-27339-1-git-send-email-scott.bauer@intel.com>
 <1480456322-27339-3-git-send-email-scott.bauer@intel.com>
 <20161201005006.GE21081@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161201005006.GE21081@localhost.localdomain>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Nov 30, 2016 at 07:50:07PM -0500, Keith Busch wrote:
> I think we should get rid of the "majmin" stuff

Absolutely agreed.

>
> and directly use
> block_device. Then if we add the security send/receive operations to the
> block_device_operations, that will simplify chaining the security request
> to the driver without needing to thread the driver's requested callback
> and data the way you have to here since all the necessary information
> is encapsulated in the block_device.

Maybe.  I need to look at the TCG spec again (oh my good, what a fucking
mess), but if I remember the context if it is the whole nvme controller
and not just a namespace, so a block_device might be the wrong context.
Then again we can always go from the block_device to the controller
fairly easily.  So instead of adding the security operation to the
block_device_operations which we don't really need for now maybe we
should add a security_conext to the block device so that we can avoid
all the lookup code?

> We shouldn't need to be allocating an 'opal_dev' for every range. The
> range-specific parts should be in a different structure that the opal_dev
> can have a list of. That will simpify the unlock from suspend a bit.

Agreed.

> I can appreciate how compact this is, but this is a little harder to
> read IMO, and it works only because you were so careful in setting up
> the array. I think expanding the ioctl into a switch will be easier to
> follow, and has a more tolerent coding convention for future additions.

Agreed.
