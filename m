Return-Path: <ming.lei@redhat.com>
Date: Mon, 3 Jul 2017 23:54:44 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Max Gurtovoy <maxg@mellanox.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: NVMe induced NULL deref in bt_iter()
Message-ID: <20170703155443.GC28651@ming.t460p>
References: <bcc46757-6027-ed7f-22b4-e6964d0dedf0@kernel.dk>
 <9afc0fd3-e598-dea9-a505-d8fa0f608d16@mellanox.com>
 <7138df5a-b1ce-7f46-281f-ae15172c61e5@grimberg.me>
 <20170703093951.GA28651@ming.t460p>
 <bc6e2ecf-031b-45c0-8fbb-98c12c790ee4@grimberg.me>
 <20170703120348.GB28651@ming.t460p>
 <c381e5ab-51b6-494f-db62-09cd4bfdfe39@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <c381e5ab-51b6-494f-db62-09cd4bfdfe39@mellanox.com>
List-ID: <linux-block@vger.kernel.org>

On Mon, Jul 03, 2017 at 03:46:34PM +0300, Max Gurtovoy wrote:
> 
> 
> On 7/3/2017 3:03 PM, Ming Lei wrote:
> > On Mon, Jul 03, 2017 at 01:07:44PM +0300, Sagi Grimberg wrote:
> > > Hi Ming,
> > > 
> > > > Yeah, the above change is correct, for any canceling requests in this
> > > > way we should use blk_mq_quiesce_queue().
> > > 
> > > I still don't understand why should blk_mq_flush_busy_ctxs hit a NULL
> > > deref if we don't touch the tagset...
> > 
> > Looks no one mentioned the steps for reproduction, then it isn't easy
> > to understand the related use case, could anyone share the steps for
> > reproduction?
> 
> Hi Ming,
> I create 500 ns per 1 subsystem (using with CX4 target and C-IB initiator
> but also saw it in CX5 vs. CX5 setup).
> The null deref happens when I remove all configuration in the target (1 port
> 1 subsystem and 500 namespaces and nvmet modules unload) during traffic to 1
> nvme device/ns from the intiator.
> I get Null deref in blk_mq_flush_busy_ctxs function that calls
> sbitmap_for_each_set in the initiator. seems like the "struct sbitmap_word
> *word = &sb->map[i];" is null. It's actually might be not null in the
> beginning of the func and become null during running the while loop there.

So looks it is still a normal release in initiator.

Per my experience, without quiescing queue before
blk_mq_tagset_busy_iter() for canceling requests, request double free
can be caused: one submitted req in .queue_rq can completed in
blk_mq_end_request(), meantime it can be completed in
nvme_cancel_request(). That is why we have to quiescing queue
first before canceling request in this way. Except for NVMe, looks
NBD and mtip32xx need fix too.

This way might cause blk_cleanup_queue() to complete early, then NULL
deref can be triggered in blk_mq_flush_busy_ctxs(). But in my previous
debug in PCI NVMe, this wasn't seen yet.

It should have been verified if the above is true by adding some debug
message inside blk_cleanup_queue(). 


Thanks,
Ming
