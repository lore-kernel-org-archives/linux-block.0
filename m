Return-Path: <linux-block-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:55575 "EHLO newverein.lst.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754714AbcFPPQQ (ORCPT <rfc822;linux-block@vger.kernel.org>);
	Thu, 16 Jun 2016 11:16:16 -0400
Date: Thu, 16 Jun 2016 17:16:13 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, axboe@fb.com, tglx@linutronix.de,
	bart.vanassche@sandisk.com
Subject: Re: [PATCH 06/13] irq: add a helper spread an affinity mask for
	MSI/MSI-X vectors
Message-ID: <20160616151613.GA13433@lst.de>
References: <1465934346-20648-1-git-send-email-hch@lst.de> <1465934346-20648-7-git-send-email-hch@lst.de> <57607D0E.1060907@linux.vnet.ibm.com> <20160615101045.GB16425@lst.de> <5761538D.6060303@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5761538D.6060303@linux.vnet.ibm.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

>
> ...but now I'll focus on the common/general case! Thanks for the suggestion 
> Christoph. I guess would be even better to have a generic function that 
> retrieves an optimal mask, something like topology_get_optimal_mask(n, 
> *cpumask), in which we get the best distribution of n CPUs among all cores 
> and return such a mask - interesting case is when n < num_online_cpus. So, 
> this function could be used inside your irq_create_affinity_mask() and 
> maybe in other places it is needed.

Yes, we should probably just plug this in where we're using the current
routines.  Block very much optimizes for the cases of either 1 queue
or enough queues for all cpus at the moments.  It would be good to check
what the network drivers currently do.
