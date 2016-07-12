Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57805 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933170AbcGLMlG (ORCPT <rfc822;linux-block@vger.kernel.org>);
	Tue, 12 Jul 2016 08:41:06 -0400
Date: Tue, 12 Jul 2016 14:46:03 +0200
From: Alexander Gordeev <agordeev@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: tglx@linutronix.de, axboe@fb.com, linux-block@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/13] pci: Provide sensible irq vector alloc/free
 routines
Message-ID: <20160712124603.GB26969@agordeev.lab.eng.brq.redhat.com>
References: <1467621574-8277-1-git-send-email-hch@lst.de>
 <1467621574-8277-8-git-send-email-hch@lst.de>
 <20160706080545.GA14583@dhcp-27-118.brq.redhat.com>
 <20160710034737.GB15720@lst.de>
 <20160711104340.GB21169@agordeev.lab.eng.brq.redhat.com>
 <20160712091300.GA4845@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160712091300.GA4845@lst.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Jul 12, 2016 at 11:13:00AM +0200, Christoph Hellwig wrote:
> On Mon, Jul 11, 2016 at 12:43:41PM +0200, Alexander Gordeev wrote:
> > > I diagreed - if we deprecated functions the only thing that should
> > > be mentioned is a "don't use these". 
> > 
> > I will try to paraphrase myself. The new API deprecates pci_enable_msi*_range
> > functions, but I am not that sure about others. Certainly, pci_msi*_vec__ount
> > and pci_enable_msi*_exact could have (and AFAIR do have) uses that can not be
> > covered by automatic initialization of pci_alloc_irq_vectors().
> 
> pci_enable_msi*_exact is the equivalent of pci_enable_msi*_range
> with minvecs == maxvecs and treating any return value >= 0 as 0.

Right. And people asked explicitly to introduce these helpers when
range functions were introduced in the first place. Since there is
handful of drivers that do use pci_enable_msi*_exact() I suppose a
need for them persists.

> I've updated the documentation so that the old usage examples are kept
> around, but now use pci_alloc_irq_vectors.  I've also added a more detaild
> blurb on pci_msi*_vec_count - I think there is no need for them, but
> if I'm proven wrong we'll have to add a pci_irq_vector_count that handles
> all interrupt types later.

I guess, it is up to Bjorn. But.

Your proposed pci_nr_irq_vectors() function (a) is not a replacement for
pci_msi*_vec_count() and (b) would be useless if I read its description
properly:

(a) Functions pci_msi*_vec_count() return number of vectors reported by
a PCI device. It is a constant for the device and a driver may make an
assumption based on this number;

(b) A number returned by pci_nr_irq_vectors() is not guaranteed what a
following call to pci_alloc_irq_vectors() can return (since the number
of actually allocated vectors might change between the two calls).
Therefore, a value returned by pci_nr_irq_vectors() can not be used for
anything.
