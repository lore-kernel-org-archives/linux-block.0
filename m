Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.mpynet.fi ([82.197.21.85]:39346 "EHLO mx2.mpynet.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751598AbdIUNkC (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Sep 2017 09:40:02 -0400
Date: Thu, 21 Sep 2017 16:40:00 +0300
From: Rakesh Pandit <rakesh@tuxera.com>
To: Matias =?iso-8859-1?Q?Bj=F8rling?= <mb@lightnvm.io>
CC: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Javier =?iso-8859-1?Q?Gonz=E1lez?= <jg@lightnvm.io>
Subject: Re: [PATCH 6/6] lightnvm: include NVM Express driver if OCSSD is
 selected for build
Message-ID: <20170921134000.GA29269@dhcp-216.srv.tuxera.com>
References: <20170921112832.GA28582@dhcp-216.srv.tuxera.com>
 <b33a3e2a-2465-a0f4-5807-868a259e8850@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
In-Reply-To: <b33a3e2a-2465-a0f4-5807-868a259e8850@lightnvm.io>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Sep 21, 2017 at 01:32:40PM +0200, Matias Bj�rling wrote:
> On 09/21/2017 01:28 PM, Rakesh Pandit wrote:
> > Because NVM needs BLK_DEV_NVME, select it automatically if we mark NVM
> > in config file before building kernel.
> > 
> > Signed-off-by: Rakesh Pandit <rakesh@tuxera.com>
> > ---
> >   drivers/lightnvm/Kconfig | 1 +
> >   1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/lightnvm/Kconfig b/drivers/lightnvm/Kconfig
> > index ead61a9..b3c00cb 100644
> > --- a/drivers/lightnvm/Kconfig
> > +++ b/drivers/lightnvm/Kconfig
> > @@ -5,6 +5,7 @@
> >   menuconfig NVM
> >   	bool "Open-Channel SSD target support"
> >   	depends on BLOCK && HAS_DMA
> > +	select BLK_DEV_NVME
> >   	help
> >   	  Say Y here to get to enable Open-channel SSDs.
> > 
> 
> Thanks Rakesh. I've picked it up for 4.15.

As discussed (IRC) I wasn't very careful first time and missed
appending PCI to depends as select doesn't visit dependencies
automatically.  Will post a version 2 soon.

Will only post version 2 of this very patch.

Doesn't make sense to push anything else from set.  Thank you in
advance,
