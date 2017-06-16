Return-Path: <tglx@linutronix.de>
Date: Fri, 16 Jun 2017 09:28:04 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Christoph Hellwig <hch@lst.de>
cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <keith.busch@intel.com>,
    linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
    linux-nvme@lists.infradead.org
Subject: Re: spread MSI(-X) vectors to all possible CPUs V2
In-Reply-To: <20170616064802.GA7445@lst.de>
Message-ID: <alpine.DEB.2.20.1706160927340.2254@nanos>
References: <20170603140403.27379-1-hch@lst.de> <20170616064802.GA7445@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-block@vger.kernel.org>

On Fri, 16 Jun 2017, Christoph Hellwig wrote:
> can you take a look at the generic patches as they are the required
> base for the block work?

It's next on my ever growing todo list....
