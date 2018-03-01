Return-Path: <keith.busch@intel.com>
Date: Thu, 1 Mar 2018 10:17:44 -0700
From: Keith Busch <keith.busch@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	Laurence Oberman <loberman@redhat.com>,
	Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 5/5] nvme: pci: pass max vectors as num_possible_cpus()
 to pci_alloc_irq_vectors
Message-ID: <20180301171744.GE14799@localhost.localdomain>
References: <20180206121742.29336-1-ming.lei@redhat.com>
 <20180206121742.29336-6-ming.lei@redhat.com>
 <20180301005220.GB29500@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180301005220.GB29500@lst.de>
List-ID: <linux-block@vger.kernel.org>

On Thu, Mar 01, 2018 at 01:52:20AM +0100, Christoph Hellwig wrote:
> Looks fine,
> 
> and we should pick this up for 4.16 independent of the rest, which
> I might need a little more review time for.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Thanks, queued up for 4.16.
