Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:19818 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750766AbeDXWIJ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Apr 2018 18:08:09 -0400
Date: Tue, 24 Apr 2018 16:09:26 -0600
From: Keith Busch <keith.busch@intel.com>
To: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Omar Sandoval <osandov@osandov.com>, linux-block@vger.kernel.org
Subject: Re: [PATCH blktests] Add surprise removal block test
Message-ID: <20180424220925.GF30375@localhost.localdomain>
References: <20180424214146.31168-1-keith.busch@intel.com>
 <20180424220421.cwu5bat74633r4ga@linux-x5ow.site>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180424220421.cwu5bat74633r4ga@linux-x5ow.site>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Apr 24, 2018 at 04:04:22PM -0600, Johannes Thumshirn wrote:
> On Tue, Apr 24, 2018 at 03:41:46PM -0600, Keith Busch wrote:
> 
> [...]
> 
> > +DESCRIPTION="break PCI link while doing I/O"
> > +TIMED=1
> 
> I _think_ we can set QUICK=1 here, Omar?
> 
> > +
> > +requires() {
> > +	_have_fio
> > +}
> 
> You're using setpci below, so please add it to requires,
> i.e. _have_fio && _have_program setpci
> 
> > +
> > +device_requires() {
> > +	_test_dev_is_pci
> > +	_test_hotplug_slot
> > +}
> 
> I think this sould be _test_dev_is_pci && _test_hotplug_slot

Sounds good. Thanks for the feedback!
