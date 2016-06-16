Return-Path: <linux-block-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:55591 "EHLO newverein.lst.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754447AbcFPPUO (ORCPT <rfc822;linux-block@vger.kernel.org>);
	Thu, 16 Jun 2016 11:20:14 -0400
Date: Thu, 16 Jun 2016 17:20:06 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Keith Busch <keith.busch@intel.com>,
	Christoph Hellwig <hch@lst.de>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"axboe@fb.com" <axboe@fb.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 02/13] irq: Introduce IRQD_AFFINITY_MANAGED flag
Message-ID: <20160616152006.GA13615@lst.de>
References: <1465934346-20648-1-git-send-email-hch@lst.de> <1465934346-20648-3-git-send-email-hch@lst.de> <0412b942-ea0d-d4eb-c724-8243d12ff6f3@sandisk.com> <20160615102311.GA16619@lst.de> <67ef7a1c-56e1-db2c-b038-f9784fc1f52f@sandisk.com> <20160615151415.GA1919@localhost.localdomain> <7f0b16bd-b39f-99e6-c1c1-6a508bf9bbbf@sandisk.com> <20160615160316.GB1919@localhost.localdomain> <86aa652b-48d0-a7bb-683e-bf43939aa811@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <86aa652b-48d0-a7bb-683e-bf43939aa811@sandisk.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Jun 15, 2016 at 09:36:54PM +0200, Bart Van Assche wrote:
> Do you agree that - ignoring other interrupt assignments - that the latter 
> interrupt assignment scheme would result in higher throughput and lower 
> interrupt processing latency?

Probably.  Once we've got it in the core IRQ code we can tweak the
algorithm to be optimal.
