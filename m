Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:41173 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751529AbcFOPzS (ORCPT <rfc822;linux-block@vger.kernel.org>);
	Wed, 15 Jun 2016 11:55:18 -0400
Date: Wed, 15 Jun 2016 12:03:17 -0400
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
Message-ID: <20160615160316.GB1919@localhost.localdomain>
References: <1465934346-20648-1-git-send-email-hch@lst.de>
 <1465934346-20648-3-git-send-email-hch@lst.de>
 <0412b942-ea0d-d4eb-c724-8243d12ff6f3@sandisk.com>
 <20160615102311.GA16619@lst.de>
 <67ef7a1c-56e1-db2c-b038-f9784fc1f52f@sandisk.com>
 <20160615151415.GA1919@localhost.localdomain>
 <7f0b16bd-b39f-99e6-c1c1-6a508bf9bbbf@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <7f0b16bd-b39f-99e6-c1c1-6a508bf9bbbf@sandisk.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Jun 15, 2016 at 05:28:54PM +0200, Bart Van Assche wrote:
> On 06/15/2016 05:14 PM, Keith Busch wrote:
> >I think the idea is have the irq_affinity mask match the CPU mapping on
> >the submission side context associated with that particular vector. If
> >two identical adapters generate the same submission CPU mapping, I don't
> >think we can do better than matching irq_affinity masks.
> 
> Has this been verified by measurements? Sorry but I'm not convinced that
> using the same mapping for multiple identical adapters instead of spreading
> interrupts will result in better performance.

The interrupts automatically spread based on which CPU submitted the
work. If you want to spread interrupts across more CPUs, then you can
spread submissions to the CPUs you want to service the interrupts.

Completing work on the same CPU that submitted it is quickest with
its cache hot access. I have equipment available to demo this. What
affinty_mask policy would you like to see compared with the proposal?
