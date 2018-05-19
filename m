Return-Path: <ming.lei@redhat.com>
Date: Sat, 19 May 2018 08:01:42 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Keith Busch <keith.busch@linux.intel.com>
Cc: Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@kernel.dk>,
	Laurence Oberman <loberman@redhat.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	James Smart <james.smart@broadcom.com>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	Johannes Thumshirn <jthumshirn@suse.de>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/6] nvme: Sync request queues on reset
Message-ID: <20180519000141.GB19799@ming.t460p>
References: <20180518163823.27820-1-keith.busch@intel.com>
 <20180518223210.GB18334@ming.t460p>
 <20180518234408.GA31749@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180518234408.GA31749@localhost.localdomain>
List-ID: <linux-block@vger.kernel.org>

On Fri, May 18, 2018 at 05:44:08PM -0600, Keith Busch wrote:
> On Sat, May 19, 2018 at 06:32:11AM +0800, Ming Lei wrote:
> > This way can't sync timeout reliably, since timeout events can
> > come from two NS at the same time, and one may be handled as
> > RESET_TIMER, and another one can be handled as EH_HANDLED.
> 
> You keep saying that, but the controller state is global to the
> controller. It doesn't matter which namespace request_queue started the
> reset: every namespaces request queue sees the RESETTING controller state

When timeouts come, the global state of RESETTING may not be updated
yet, so all the timeouts may not observe the state.

Please see my previous explanation:

https://marc.info/?l=linux-block&m=152600464317808&w=2


Thanks,
Ming
