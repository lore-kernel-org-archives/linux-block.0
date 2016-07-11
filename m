Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53621 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753461AbcGKKin (ORCPT <rfc822;linux-block@vger.kernel.org>);
	Mon, 11 Jul 2016 06:38:43 -0400
Date: Mon, 11 Jul 2016 12:43:41 +0200
From: Alexander Gordeev <agordeev@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: tglx@linutronix.de, axboe@fb.com, linux-block@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/13] pci: Provide sensible irq vector alloc/free
 routines
Message-ID: <20160711104340.GB21169@agordeev.lab.eng.brq.redhat.com>
References: <1467621574-8277-1-git-send-email-hch@lst.de>
 <1467621574-8277-8-git-send-email-hch@lst.de>
 <20160706080545.GA14583@dhcp-27-118.brq.redhat.com>
 <20160710034737.GB15720@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160710034737.GB15720@lst.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Sun, Jul 10, 2016 at 05:47:37AM +0200, Christoph Hellwig wrote:
> On Wed, Jul 06, 2016 at 10:05:45AM +0200, Alexander Gordeev wrote:
> > > + pci_enable_msi, pci_enable_msi_range, pci_enable_msi_exact, pci_disable_msi,
> > > + pci_msi_vec_count, pci_enable_msix_range, pci_enable_msix_exact,
> > > + pci_disable_msix, pci_msix_vec_count
> > 
> > Description of these functions can be removed when all drivers migrated
> > to the new API. Also implementation descriptions + examples would still
> > be needed AFAICT.
> 
> I diagreed - if we deprecated functions the only thing that should
> be mentioned is a "don't use these". 

I will try to paraphrase myself. The new API deprecates pci_enable_msi*_range
functions, but I am not that sure about others. Certainly, pci_msi*_vec_count
and pci_enable_msi*_exact could have (and AFAIR do have) uses that can not be
covered by automatic initialization of pci_alloc_irq_vectors().
