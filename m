Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37632 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750740AbeAPCPz (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 15 Jan 2018 21:15:55 -0500
Date: Tue, 16 Jan 2018 10:15:38 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Laurence Oberman <loberman@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>
Subject: Re: [PATCH 0/2] genirq/affinity: try to make sure online CPU is
 assgined to irq vector
Message-ID: <20180116021537.GG3213@ming.t460p>
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

If pci_alloc_irq_vectors() returns OK, driver may think everything
is just fine, and configure the related hw queues(such as enabling irq
on queues), and finally irq comes and no CPU can handle them.

Also I think there may not drivers which check if the CPUs assigned
for irq vectors are online or not, and seems never a job which is
supposed to do by driver.

-- 
Ming
