Return-Path: <linux-block-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:40844 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756009AbeAORnx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 15 Jan 2018 12:43:53 -0500
Date: Mon, 15 Jan 2018 18:43:47 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Ming Lei <ming.lei@redhat.com>
cc: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Laurence Oberman <loberman@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>
Subject: Re: [PATCH 0/2] genirq/affinity: try to make sure online CPU is
 assgined to irq vector
In-Reply-To: <20180115160345.2611-1-ming.lei@redhat.com>
Message-ID: <alpine.DEB.2.20.1801151842080.2143@nanos>
References: <20180115160345.2611-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, 16 Jan 2018, Ming Lei wrote:
> These two patches fixes IO hang issue reported by Laurence.
> 
> 84676c1f21 ("genirq/affinity: assign vectors to all possible CPUs")
> may cause one irq vector assigned to all offline CPUs, then this vector
> can't handle irq any more.
> 
> The 1st patch moves irq vectors spread into one function, and prepares
> for the fix done in 2nd patch.
> 
> The 2nd patch fixes the issue by trying to make sure online CPUs assigned
> to irq vector.

Which means it's completely undoing the intent and mechanism of managed
interrupts. Not going to happen.

Which driver is that which abuses managed interrupts and does not keep its
queues properly sorted on cpu hotplug?

Thanks,

	tglx
