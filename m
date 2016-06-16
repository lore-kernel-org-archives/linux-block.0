Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:65089 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754720AbcFPPPc (ORCPT <rfc822;linux-block@vger.kernel.org>);
	Thu, 16 Jun 2016 11:15:32 -0400
Date: Thu, 16 Jun 2016 11:19:51 -0400
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
Message-ID: <20160616151950.GA11840@localhost.localdomain>
References: <0412b942-ea0d-d4eb-c724-8243d12ff6f3@sandisk.com>
 <20160615102311.GA16619@lst.de>
 <67ef7a1c-56e1-db2c-b038-f9784fc1f52f@sandisk.com>
 <20160615151415.GA1919@localhost.localdomain>
 <7f0b16bd-b39f-99e6-c1c1-6a508bf9bbbf@sandisk.com>
 <20160615160316.GB1919@localhost.localdomain>
 <86aa652b-48d0-a7bb-683e-bf43939aa811@sandisk.com>
 <20160615200655.GB7637@localhost.localdomain>
 <20160615201213.GC7637@localhost.localdomain>
 <7a61fe73-2808-70b4-e3b2-b6a924559d9d@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <7a61fe73-2808-70b4-e3b2-b6a924559d9d@sandisk.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Jun 15, 2016 at 10:50:53PM +0200, Bart Van Assche wrote:
> Does it matter on x86 systems whether or not these interrupt vectors are
> also associated with a CPU with a higher CPU number? Although multiple bits
> can be set in /proc/irq/<n>/smp_affinity only the first bit counts on x86
> platforms. In default_cpu_mask_to_apicid_and() it is easy to see that only
> the first bit that has been set in that mask counts on x86 systems.

Wow, thanks for the information. I didn't know the apic wasn't using
the full cpu mask, so this changes how I need to look at this, and will
experiment with such a configuration.
