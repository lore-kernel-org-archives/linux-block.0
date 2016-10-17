Return-Path: <hch@lst.de>
Date: Mon, 17 Oct 2016 16:20:36 +0200
From: Christoph Hellwig <hch@lst.de>
To: Don Brace <don.brace@microsemi.com>
Cc: Johannes Thumshirn <jthumshirn@suse.de>, Christoph Hellwig <hch@lst.de>,
	"martin.petersen@oracle.com" <martin.petersen@oracle.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 3/3] smartpqi: switch to pci_alloc_irq_vectors
Message-ID: <20161017142036.GA17678@lst.de>
References: <1476521241-32765-1-git-send-email-hch@lst.de> <1476521241-32765-4-git-send-email-hch@lst.de> <20161017073428.27xzw6du4j3r4qro@linux-x5ow.site> <4993A297653ECB4581FA5C3C31323D193B070B79@avsrvexchmbx1.microsemi.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4993A297653ECB4581FA5C3C31323D193B070B79@avsrvexchmbx1.microsemi.net>
List-ID: <linux-block@vger.kernel.org>

Hi Don,

did you also have a chance to test the patch and verify that the
queues are properly set up with a smartpqi controller?
