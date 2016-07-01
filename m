Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55256 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751953AbcGAHW3 (ORCPT <rfc822;linux-block@vger.kernel.org>);
	Fri, 1 Jul 2016 03:22:29 -0400
Date: Fri, 1 Jul 2016 09:25:27 +0200
From: Alexander Gordeev <agordeev@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: tglx@linutronix.de, axboe@fb.com, linux-block@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/13] irq: add a helper spread an affinity mask for
 MSI/MSI-X vectors
Message-ID: <20160701072527.GA20160@agordeev.lab.eng.brq.redhat.com>
References: <1465934346-20648-1-git-send-email-hch@lst.de>
 <1465934346-20648-7-git-send-email-hch@lst.de>
 <20160625200518.GA29251@dhcp-27-118.brq.redhat.com>
 <20160630174854.GA23578@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160630174854.GA23578@lst.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Jun 30, 2016 at 07:48:54PM +0200, Christoph Hellwig wrote:
> On Sat, Jun 25, 2016 at 10:05:19PM +0200, Alexander Gordeev wrote:
> > > + * and generate an output cpumask suitable for spreading MSI/MSI-X vectors
> > > + * so that they are distributed as good as possible around the CPUs.  If
> > > + * more vectors than CPUs are available we'll map one to each CPU,
> > 
> > Unless I do not misinterpret a loop from msix_setup_entries() (patch 08/13),
> > the above is incorrect:
> 
> What part do you think is incorrect?

With your explanations below and no immediate intention to fix the
algorithm it is correct.

> > (*) I guess, in some topology configurations a total number of all
> > first siblings may be less than the number of vectors.
> 
> Yes, in that case we'll assign imcompetely.  I've already heard people
> complaining about that at LSF/MM, but no one volunteered patches.
> I only have devices with 1 or enough vectores to test, so I don't
> really dare to touch the algorithm.  Either way the algorithm
> change should probably be a different patch than refactoring it and
> moving it around.

I see your approach now. Thanks!
