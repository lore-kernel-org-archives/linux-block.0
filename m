Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:35235 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750811AbeDQWH7 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Apr 2018 18:07:59 -0400
Date: Tue, 17 Apr 2018 16:09:01 -0600
From: Keith Busch <keith.busch@intel.com>
To: Matias =?iso-8859-1?Q?Bj=F8rling?= <mb@lightnvm.io>
Cc: Wei Xu <wxu@cnexlabs.com>, linux-nvme@lists.infradead.org,
        javier@cnexlabs.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: lightnvm: add granby support
Message-ID: <20180417220901.GG11513@localhost.localdomain>
References: <1523930112-7402-1-git-send-email-wxu@cnexlabs.com>
 <6e50972d-f806-52ac-7983-2642bd211afa@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <6e50972d-f806-52ac-7983-2642bd211afa@lightnvm.io>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Apr 17, 2018 at 08:16:25AM +0200, Matias Bjørling wrote:
> On 4/17/18 3:55 AM, Wei Xu wrote:
> > Add a new lightnvm quirk to identify CNEX’s Granby controller.
> > 
> > Signed-off-by: Wei Xu <wxu@cnexlabs.com>
> > ---
> >   drivers/nvme/host/pci.c | 2 ++
> >   1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> > index cb73bc8..9419e88 100644
> > --- a/drivers/nvme/host/pci.c
> > +++ b/drivers/nvme/host/pci.c
> > @@ -2529,6 +2529,8 @@ static const struct pci_device_id nvme_id_table[] = {
> >   		.driver_data = NVME_QUIRK_LIGHTNVM, },
> >   	{ PCI_DEVICE(0x1d1d, 0x2807),	/* CNEX WL */
> >   		.driver_data = NVME_QUIRK_LIGHTNVM, },
> > +	{ PCI_DEVICE(0x1d1d, 0x2601),	/* CNEX Granby */
> > +		.driver_data = NVME_QUIRK_LIGHTNVM, },
> >   	{ PCI_DEVICE_CLASS(PCI_CLASS_STORAGE_EXPRESS, 0xffffff) },
> >   	{ PCI_DEVICE(PCI_VENDOR_ID_APPLE, 0x2001) },
> >   	{ PCI_DEVICE(PCI_VENDOR_ID_APPLE, 0x2003) },
> > 
> 
> Looks good to me.
> 
> Reviewed-by: Matias Bjørling <mb@lightnvm.io>
> 
> Keith, when convenient can you pick this up for 4.18?

This looks safe for 4.17-rc2, no? Unless you want to wait for the next
release.
