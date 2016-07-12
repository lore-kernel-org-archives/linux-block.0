Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43411 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750743AbcGLGoq (ORCPT <rfc822;linux-block@vger.kernel.org>);
	Tue, 12 Jul 2016 02:44:46 -0400
Date: Tue, 12 Jul 2016 08:49:43 +0200
From: Alexander Gordeev <agordeev@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: tglx@linutronix.de, axboe@fb.com, linux-block@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/13] pci: spread interrupt vectors in
 pci_alloc_irq_vectors
Message-ID: <20160712064943.GB26968@agordeev.lab.eng.brq.redhat.com>
References: <1467621574-8277-1-git-send-email-hch@lst.de>
 <1467621574-8277-9-git-send-email-hch@lst.de>
 <20160707110501.GA4917@dhcp-27-118.brq.redhat.com>
 <20160710035751.GC15720@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160710035751.GC15720@lst.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Sun, Jul 10, 2016 at 05:57:51AM +0200, Christoph Hellwig wrote:
> On Thu, Jul 07, 2016 at 01:05:01PM +0200, Alexander Gordeev wrote:
> > irq_create_affinity_mask() bails out with no affinity in case of single
> > vector, but alloc_descs() (see below (*)) assigns the whole affinity
> > mask. It should be consistent instead.
> 
> I don't understand the comment.  If we only have one vector (of any
> kinds) there is no need to create an affinity mask, we'll leave the
> interrupt to the existing irq balancing code.

I got impression the affinity mask is assigned differently i.e. for
single MSI mode vs legacy mode. But I might be wrong here - I have to
look into the code again. Anyway, if it is the case it could be
addressed afterwards IMHO.
