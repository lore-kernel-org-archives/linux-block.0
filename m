Return-Path: <hch@lst.de>
Date: Tue, 8 Nov 2016 22:20:25 +0100
From: Christoph Hellwig <hch@lst.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, tglx@linutronix.de, axboe@kernel.dk,
	linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/7] pci/msi: Provide pci_alloc_irq_vectors_affinity()
Message-ID: <20161108212025.GA24698@lst.de>
References: <1478544462-9549-1-git-send-email-hch@lst.de> <1478544462-9549-6-git-send-email-hch@lst.de> <20161108211732.GC14322@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161108211732.GC14322@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-block@vger.kernel.org>

On Tue, Nov 08, 2016 at 03:17:32PM -0600, Bjorn Helgaas wrote:
> On Mon, Nov 07, 2016 at 10:47:40AM -0800, Christoph Hellwig wrote:
> > From: Christogh Hellwig <hch@lst.de>
> 
> s/Christogh/Christoph/ (also below)

Haha, so much for taking Thomas' split of my patches and not proof-reading
them..
