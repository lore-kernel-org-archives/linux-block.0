Return-Path: <hch@lst.de>
Date: Tue, 8 Nov 2016 16:25:20 +0100
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Thomas Gleixner <tglx@linutronix.de>,
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
	Hannes Reinecke <hare@suse.com>
Subject: Re: [RFC PATCH] pci: add pci_irq_get_affinity_vector()
Message-ID: <20161108152520.GA15350@lst.de>
References: <1478591241-123356-1-git-send-email-hare@suse.de> <20161108145652.GA12817@lst.de> <40d6e3d4-7e63-0d23-3e5c-a877cebd539a@suse.de> <20161108151150.GA14002@lst.de> <85806bd8-b4a5-8820-cf7a-207a38fe5505@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <85806bd8-b4a5-8820-cf7a-207a38fe5505@suse.de>
List-ID: <linux-block@vger.kernel.org>

If people want to use multiple queues they should use blk-mq, period.
And while we can't just rip out existing code in lpfc that supports
multiple queues without blk-mq we should not let any new users in
either.
