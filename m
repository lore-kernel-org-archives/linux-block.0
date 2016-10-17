Return-Path: <don.brace@microsemi.com>
From: Don Brace <don.brace@microsemi.com>
To: Christoph Hellwig <hch@lst.de>
CC: Johannes Thumshirn <jthumshirn@suse.de>, "martin.petersen@oracle.com"
	<martin.petersen@oracle.com>, "axboe@kernel.dk" <axboe@kernel.dk>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: RE: [PATCH 3/3] smartpqi: switch to pci_alloc_irq_vectors
Date: Mon, 17 Oct 2016 16:34:34 +0000
Message-ID: <4993A297653ECB4581FA5C3C31323D193B07154E@avsrvexchmbx1.microsemi.net>
References: <1476521241-32765-1-git-send-email-hch@lst.de>
 <1476521241-32765-4-git-send-email-hch@lst.de>
 <20161017073428.27xzw6du4j3r4qro@linux-x5ow.site>
 <4993A297653ECB4581FA5C3C31323D193B070B79@avsrvexchmbx1.microsemi.net>
 <20161017142036.GA17678@lst.de>
In-Reply-To: <20161017142036.GA17678@lst.de>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Return-Path: don.brace@microsemi.com
List-ID: <linux-block@vger.kernel.org>


> -----Original Message-----
> From: Christoph Hellwig [mailto:hch@lst.de]
> Sent: Monday, October 17, 2016 9:21 AM
> To: Don Brace
> Cc: Johannes Thumshirn; Christoph Hellwig; martin.petersen@oracle.com;
> axboe@kernel.dk; linux-scsi@vger.kernel.org; linux-block@vger.kernel.org
> Subject: Re: [PATCH 3/3] smartpqi: switch to pci_alloc_irq_vectors
>=20
> EXTERNAL EMAIL
>=20
>=20
> Hi Don,
>=20
> did you also have a chance to test the patch and verify that the
> queues are properly set up with a smartpqi controller?

I need more time to test, I need to apply some other patches to fully test.
