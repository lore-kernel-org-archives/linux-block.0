Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48878 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750716AbeAPBe6 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 15 Jan 2018 20:34:58 -0500
Date: Tue, 16 Jan 2018 09:34:40 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Laurence Oberman <loberman@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>
Subject: Re: [PATCH 0/2] genirq/affinity: try to make sure online CPU is
 assgined to irq vector
Message-ID: <20180116013439.GB3213@ming.t460p>
References: <20180115160345.2611-1-ming.lei@redhat.com>
 <alpine.DEB.2.20.1801151842080.2143@nanos>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.2.20.1801151842080.2143@nanos>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Jan 15, 2018 at 06:43:47PM +0100, Thomas Gleixner wrote:
> On Tue, 16 Jan 2018, Ming Lei wrote:
> > These two patches fixes IO hang issue reported by Laurence.
> > 
> > 84676c1f21 ("genirq/affinity: assign vectors to all possible CPUs")
> > may cause one irq vector assigned to all offline CPUs, then this vector
> > can't handle irq any more.
> > 
> > The 1st patch moves irq vectors spread into one function, and prepares
> > for the fix done in 2nd patch.
> > 
> > The 2nd patch fixes the issue by trying to make sure online CPUs assigned
> > to irq vector.
> 
> Which means it's completely undoing the intent and mechanism of managed
> interrupts. Not going to happen.

As I replied in previous mail, some of offline CPUs may be assigned to
some of irq vectors after we assign vectors to all possible CPUs, some
of which are not present.

> 
> Which driver is that which abuses managed interrupts and does not keep its
> queues properly sorted on cpu hotplug?

It isn't related with driver/device, and I can trigger this issue on NVMe
easily except for HPSA.


Thanks,
Ming
