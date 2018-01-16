Return-Path: <linux-block-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:42507 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750802AbeAPLZY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Jan 2018 06:25:24 -0500
Date: Tue, 16 Jan 2018 12:25:19 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Ming Lei <ming.lei@redhat.com>
cc: Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@fb.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Laurence Oberman <loberman@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>
Subject: Re: [PATCH 0/2] genirq/affinity: try to make sure online CPU is
 assgined to irq vector
In-Reply-To: <20180116013043.GA3213@ming.t460p>
Message-ID: <alpine.DEB.2.20.1801161223500.1823@nanos>
References: <20180115160345.2611-1-ming.lei@redhat.com> <20180115174036.GA20191@infradead.org> <20180116013043.GA3213@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, 16 Jan 2018, Ming Lei wrote:

> On Mon, Jan 15, 2018 at 09:40:36AM -0800, Christoph Hellwig wrote:
> > On Tue, Jan 16, 2018 at 12:03:43AM +0800, Ming Lei wrote:
> > > Hi,
> > > 
> > > These two patches fixes IO hang issue reported by Laurence.
> > > 
> > > 84676c1f21 ("genirq/affinity: assign vectors to all possible CPUs")
> > > may cause one irq vector assigned to all offline CPUs, then this vector
> > > can't handle irq any more.
> > 
> > Well, that very much was the intention of managed interrupts.  Why
> > does the device raise an interrupt for a queue that has no online
> > cpu assigned to it?
> 
> It is because of irq_create_affinity_masks().

That still does not answer the question. If the interrupt for a queue is
assigned to an offline CPU, then the queue should not be used and never
raise an interrupt. That's how managed interrupts have been designed.

Thanks,

	tglx
