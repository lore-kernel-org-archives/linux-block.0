Return-Path: <don.brace@microsemi.com>
From: Don Brace <don.brace@microsemi.com>
To: Johannes Thumshirn <jthumshirn@suse.de>, Christoph Hellwig <hch@lst.de>
CC: "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>, "linux-scsi@vger.kernel.org"
	<linux-scsi@vger.kernel.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>
Subject: RE: [PATCH 3/3] smartpqi: switch to pci_alloc_irq_vectors
Date: Mon, 17 Oct 2016 13:44:48 +0000
Message-ID: <4993A297653ECB4581FA5C3C31323D193B070B79@avsrvexchmbx1.microsemi.net>
References: <1476521241-32765-1-git-send-email-hch@lst.de>
 <1476521241-32765-4-git-send-email-hch@lst.de>
 <20161017073428.27xzw6du4j3r4qro@linux-x5ow.site>
In-Reply-To: <20161017073428.27xzw6du4j3r4qro@linux-x5ow.site>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Return-Path: don.brace@microsemi.com
List-ID: <linux-block@vger.kernel.org>


> -----Original Message-----
> From: Johannes Thumshirn [mailto:jthumshirn@suse.de]
> Sent: Monday, October 17, 2016 2:34 AM
> To: Christoph Hellwig
> Cc: martin.petersen@oracle.com; Don Brace; axboe@kernel.dk; linux-
> scsi@vger.kernel.org; linux-block@vger.kernel.org
> Subject: Re: [PATCH 3/3] smartpqi: switch to pci_alloc_irq_vectors
>=20
> EXTERNAL EMAIL
>=20
>=20
> On Sat, Oct 15, 2016 at 10:47:21AM +0200, Christoph Hellwig wrote:
> > Which cleans up a lot of the MSI-X handling, and allows us to use the
> > PCI IRQ layer provided vector mapping, which we can then expose to blk-
> mq.
> >
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > ---
>=20
> Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
> --
> Johannes Thumshirn                                          Storage
> jthumshirn@suse.de                                +49 911 74053 689
> SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N=FCrnberg
> GF: Felix Imend=F6rffer, Jane Smithard, Graham Norton
> HRB 21284 (AG N=FCrnberg)
> Key fingerprint =3D EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850

Acked-by: Don Brace <don.brace@microsemi.com>
