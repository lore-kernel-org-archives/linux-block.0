Return-Path: <tglx@linutronix.de>
Date: Tue, 8 Nov 2016 15:40:22 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Hannes Reinecke <hare@suse.de>
cc: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk,
    linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/7] genirq/affinity: Handle pre/post vectors in
 irq_calc_affinity_vectors()
In-Reply-To: <1daf8fb5-d58e-9cf4-5b33-b39de1db4c20@suse.de>
Message-ID: <alpine.DEB.2.20.1611081538530.3501@nanos>
References: <1478544462-9549-1-git-send-email-hch@lst.de> <1478544462-9549-3-git-send-email-hch@lst.de> <1daf8fb5-d58e-9cf4-5b33-b39de1db4c20@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-block@vger.kernel.org>

On Tue, 8 Nov 2016, Hannes Reinecke wrote:
> Shouldn't you check for NULL affd here?

No. The introduction of the default affinity struct should happen in that
patch and it should be handed down instead of NULL. Ditto for the next
patch.

Thanks,

	tglx
