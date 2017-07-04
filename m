Return-Path: <ming.lei@redhat.com>
Date: Tue, 4 Jul 2017 16:08:19 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Max Gurtovoy <maxg@mellanox.com>, Jens Axboe <axboe@kernel.dk>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: NVMe induced NULL deref in bt_iter()
Message-ID: <20170704080818.GA29053@ming.t460p>
References: <bcc46757-6027-ed7f-22b4-e6964d0dedf0@kernel.dk>
 <9afc0fd3-e598-dea9-a505-d8fa0f608d16@mellanox.com>
 <7138df5a-b1ce-7f46-281f-ae15172c61e5@grimberg.me>
 <20170703093951.GA28651@ming.t460p>
 <bc6e2ecf-031b-45c0-8fbb-98c12c790ee4@grimberg.me>
 <20170703120348.GB28651@ming.t460p>
 <92224329-0933-4e80-94d6-2ba3c88f3f3e@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <92224329-0933-4e80-94d6-2ba3c88f3f3e@grimberg.me>
List-ID: <linux-block@vger.kernel.org>

On Tue, Jul 04, 2017 at 10:56:23AM +0300, Sagi Grimberg wrote:
> 
> > There are at least one case in which we have to use stop queues:
> > 
> > 	- when QUEUE_BUSY(now it becomes BLK_STS_RESOURCE) happens, some drivers
> > 	need to stop queues for avoiding to hurt CPU, such as virtio-blk, ...
> 
> Why isn't virtio_blk using blk_mq_delay_run_hw_queue like scsi does?

IMO it shouldn't be easy to figure out one perfect delay time, and it
should have been self-adaptive.

Also I think it might be possible to move this kind of stop action into
blk-mq core code, and not let drivers touch stop state. Finally we
may kill all stopping in drivers.

Thanks,
Ming
