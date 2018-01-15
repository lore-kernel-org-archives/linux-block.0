Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:41644 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755690AbeAORkk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 15 Jan 2018 12:40:40 -0500
Date: Mon, 15 Jan 2018 09:40:36 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Laurence Oberman <loberman@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>
Subject: Re: [PATCH 0/2] genirq/affinity: try to make sure online CPU is
 assgined to irq vector
Message-ID: <20180115174036.GA20191@infradead.org>
References: <20180115160345.2611-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180115160345.2611-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Jan 16, 2018 at 12:03:43AM +0800, Ming Lei wrote:
> Hi,
> 
> These two patches fixes IO hang issue reported by Laurence.
> 
> 84676c1f21 ("genirq/affinity: assign vectors to all possible CPUs")
> may cause one irq vector assigned to all offline CPUs, then this vector
> can't handle irq any more.

Well, that very much was the intention of managed interrupts.  Why
does the device raise an interrupt for a queue that has no online
cpu assigned to it?
