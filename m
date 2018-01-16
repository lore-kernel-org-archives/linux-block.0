Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49206 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750918AbeAPBbL (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 15 Jan 2018 20:31:11 -0500
Date: Tue, 16 Jan 2018 09:30:48 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Laurence Oberman <loberman@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>
Subject: Re: [PATCH 0/2] genirq/affinity: try to make sure online CPU is
 assgined to irq vector
Message-ID: <20180116013043.GA3213@ming.t460p>
References: <20180115160345.2611-1-ming.lei@redhat.com>
 <20180115174036.GA20191@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180115174036.GA20191@infradead.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Jan 15, 2018 at 09:40:36AM -0800, Christoph Hellwig wrote:
> On Tue, Jan 16, 2018 at 12:03:43AM +0800, Ming Lei wrote:
> > Hi,
> > 
> > These two patches fixes IO hang issue reported by Laurence.
> > 
> > 84676c1f21 ("genirq/affinity: assign vectors to all possible CPUs")
> > may cause one irq vector assigned to all offline CPUs, then this vector
> > can't handle irq any more.
> 
> Well, that very much was the intention of managed interrupts.  Why
> does the device raise an interrupt for a queue that has no online
> cpu assigned to it?

It is because of irq_create_affinity_masks().

Once irq vectors spread across possible CPUs, some of which are offline,
may be assigned to one vector.

For example of HPSA, there are 8 irq vectors in this device, and the
system supports at most 32 CPUs, but only 16 presents(0-15) after booting,
we should allow to assign at least one CPU for handling each irq vector for
HPSA, but:

1) before commit 84676c1f21:

	irq 25, cpu list 0
	irq 26, cpu list 2
	irq 27, cpu list 4
	irq 28, cpu list 6
	irq 29, cpu list 8
	irq 30, cpu list 10
	irq 31, cpu list 12
	irq 32, cpu list 14
	irq 33, cpu list 1
	irq 34, cpu list 3
	irq 35, cpu list 5
	irq 36, cpu list 7
	irq 37, cpu list 9
	irq 38, cpu list 11
	irq 39, cpu list 13
	irq 40, cpu list 15

2) after commit 84676c1f21:

	irq 25, cpu list 0, 2
	irq 26, cpu list 4, 6
	irq 27, cpu list 8, 10
	irq 28, cpu list 12, 14
	irq 29, cpu list 16, 18
	irq 30, cpu list 20, 22
	irq 31, cpu list 24, 26
	irq 32, cpu list 28, 30
	irq 33, cpu list 1, 3
	irq 34, cpu list 5, 7
	irq 35, cpu list 9, 11
	irq 36, cpu list 13, 15
	irq 37, cpu list 17, 19
	irq 38, cpu list 21, 23
	irq 39, cpu list 25, 27
	irq 40, cpu list 29, 31

And vectors of 29-32, 37-40 are assigned to offline CPUs.

-- 
Ming
