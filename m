Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:55508 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932699AbcFOPG1 (ORCPT <rfc822;linux-block@vger.kernel.org>);
	Wed, 15 Jun 2016 11:06:27 -0400
Date: Wed, 15 Jun 2016 11:14:15 -0400
From: Keith Busch <keith.busch@intel.com>
To: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Christoph Hellwig <hch@lst.de>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"axboe@fb.com" <axboe@fb.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 02/13] irq: Introduce IRQD_AFFINITY_MANAGED flag
Message-ID: <20160615151415.GA1919@localhost.localdomain>
References: <1465934346-20648-1-git-send-email-hch@lst.de>
 <1465934346-20648-3-git-send-email-hch@lst.de>
 <0412b942-ea0d-d4eb-c724-8243d12ff6f3@sandisk.com>
 <20160615102311.GA16619@lst.de>
 <67ef7a1c-56e1-db2c-b038-f9784fc1f52f@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <67ef7a1c-56e1-db2c-b038-f9784fc1f52f@sandisk.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Jun 15, 2016 at 12:42:53PM +0200, Bart Van Assche wrote:
> Today irqbalanced is responsible for deciding how to assign interrupts from
> different adapters to CPU cores. Does the above mean that for adapters that
> support multiple MSI-X interrupts the kernel will have full responsibility
> for assigning interrupt vectors to CPU cores?

Hi Bart,

Right, the kernel would be responsible for assigning interrupt vectors to
cores. The kernel is already responsible for setting the affinity hint,
but we want direct control because we can do a better than irqbalance,
which has been a problem point for users.

Many adapters gain significant performance when irqbalance is using
"exact" hint policy. But that's not irqbalance's default setting, and
we don't necessarily want to enforce "exact" on the entire system when
only a subset of devices benefit from such a setup.
 
> If two identical adapters are present in a system, will these generate the
> same irq_affinity mask? Do you agree that interrupt vectors from different
> adapters should be assigned to different CPU cores if enough CPU cores are
> available? If so, which software layer will assign interrupt vectors from
> different adapters to different CPU cores?

I think the idea is have the irq_affinity mask match the CPU mapping on
the submission side context associated with that particular vector. If
two identical adapters generate the same submission CPU mapping, I don't
think we can do better than matching irq_affinity masks.

Thanks,
Keith
