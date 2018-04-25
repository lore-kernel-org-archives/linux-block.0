Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:64897 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755794AbeDYRrn (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Apr 2018 13:47:43 -0400
Date: Wed, 25 Apr 2018 11:49:02 -0600
From: Keith Busch <keith.busch@intel.com>
To: Omar Sandoval <osandov@osandov.com>
Cc: linux-block@vger.kernel.org,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: Re: [PATCH blktests] Add surprise removal block test
Message-ID: <20180425174901.GB31318@localhost.localdomain>
References: <20180424214146.31168-1-keith.busch@intel.com>
 <20180425155602.GB30070@vader>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180425155602.GB30070@vader>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Apr 25, 2018 at 08:56:02AM -0700, Omar Sandoval wrote:
> On Tue, Apr 24, 2018 at 03:41:46PM -0600, Keith Busch wrote:
> > +_test_hotplug_slot() {
> 
> I'd call this _test_dev_in_hotplug_slot().

Sounds good.
 
> > +	parent="$(_get_pci_parent_from_blkdev)"
> 
> I haven't been consistent about asking people to do this, but could you
> make these variables local? I.e.,
> 
> local parent
> parent="$(_get_pci_parent_from_blkdev)"
> local slt_cap
> slt_cap=...

No problem.

> > +	setpci -s ${parent} CAP_EXP+10.w=10:10
> > +	sleep 10
> > +	setpci -s ${parent} CAP_EXP+10.w=00:10
> 
> For the sake of people of me who don't speak PCI, what do each of these
> commands do? :)

:) Will add to the change log.

This command finds the PCI Express Capability register of the slot the
device is in, then at offset 0x10 (the Link Control Register) writes a
1 to bit 4 (Link Disable). This is happening unbeknownst to any of the
drivers, just like a surprise removal. If this is a capable slot, the
drivers will find out about this through the pcie hotplug handler.

> Should we make the fio job --time_based instead of using
> --size so that we're sure it runs long enough for the sleep?

Right, that makes sense.

Will resend with the fix-ups, but probably not until tomorrow.
