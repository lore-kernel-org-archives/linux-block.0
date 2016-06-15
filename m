Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:10710 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751867AbcFOUEP (ORCPT <rfc822;linux-block@vger.kernel.org>);
	Wed, 15 Jun 2016 16:04:15 -0400
Date: Wed, 15 Jun 2016 16:12:13 -0400
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
Message-ID: <20160615201213.GC7637@localhost.localdomain>
References: <1465934346-20648-1-git-send-email-hch@lst.de>
 <1465934346-20648-3-git-send-email-hch@lst.de>
 <0412b942-ea0d-d4eb-c724-8243d12ff6f3@sandisk.com>
 <20160615102311.GA16619@lst.de>
 <67ef7a1c-56e1-db2c-b038-f9784fc1f52f@sandisk.com>
 <20160615151415.GA1919@localhost.localdomain>
 <7f0b16bd-b39f-99e6-c1c1-6a508bf9bbbf@sandisk.com>
 <20160615160316.GB1919@localhost.localdomain>
 <86aa652b-48d0-a7bb-683e-bf43939aa811@sandisk.com>
 <20160615200655.GB7637@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160615200655.GB7637@localhost.localdomain>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Jun 15, 2016 at 04:06:55PM -0400, Keith Busch wrote:
> > 
> > 0: A0 B0
> > 1: A1 B1
> > 2: A2 B2
> > 3: A3 B3
> > 4: A4 B4
> > 5: A5 B5
> > 6: A6 B6
> > 7: A7 B7
> > 8: (none)
> > ...
> > 31: (none)
> 
> I'll need to look at the follow on patches do to confirm, but that's
> not what this should do. All CPU's should have a vector assigned because
> every CPU needs to be assigned a submission context using a vector. In
> your example, every vector's affinity mask should be assigned to 4 CPUs:
> vector '8' starts over with A0 B0, '9' gets A1 B1, and so on.

  ^^^^^^

Sorry, I meant "CPU '8'", not "vector '8'".
