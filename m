Return-Path: <ming.lei@redhat.com>
Date: Sat, 8 Sep 2018 00:23:32 +0800
From: Ming Lei <ming.lei@redhat.com>
To: "jianchao.wang" <jianchao.w.wang@oracle.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, jsmart2021@gmail.com,
	sagi@grimberg.me, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, keith.busch@intel.com,
	jthumshirn@suse.de, bart.vanassche@wdc.com
Subject: Re: [PATCH 3/3] nvme-pci: use queue close instead of queue freeze
Message-ID: <20180907162331.GB9056@ming.t460p>
References: <1536120586-3378-1-git-send-email-jianchao.w.wang@oracle.com>
 <1536120586-3378-4-git-send-email-jianchao.w.wang@oracle.com>
 <20180905220910.GC21352@ming.t460p>
 <8ba97c77-0c3b-75df-0259-3c97ef7b774e@oracle.com>
 <20180906130715.GB31250@ming.t460p>
 <165989bc-949f-570e-c1d2-0ee1f0d4472a@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <165989bc-949f-570e-c1d2-0ee1f0d4472a@oracle.com>
List-ID: <linux-block@vger.kernel.org>

On Thu, Sep 06, 2018 at 10:19:27PM +0800, jianchao.wang wrote:
> 
> 
> On 09/06/2018 09:07 PM, Ming Lei wrote:
> > On Thu, Sep 06, 2018 at 09:28:46AM +0800, jianchao.wang wrote:
> >> Hi Ming
> >>
> >> On 09/06/2018 06:09 AM, Ming Lei wrote:
> >>> nvme_dev_add() still may call freeze & unfreeze queue, so your patch
> >>> can't avoid draining queue completely here.
> >>
> >> Yes, I know this. We still need to freeze queue when update nr_hw_queues.
> >> But we move forward a step at least. :)
> >> We don't need to drain request queue in normal case of nvme_reset_work.
> > 
> > It is hard to say who is the normal case. In case of CPU hotplug, it is quite
> > easy to trigger updating nr_hw_queues.
> > 
> >>
> >> As for updating nr_hw_queues, we could try some other method on it next.
> > 
> > The thing is that draining queue may be inevitable inside reset work
> > function because of updating nr_hw_queues, that means the approach in
> > this patchset is just a partial solution
> > 
> > Or it may not make sense to do that because we may never remove the draining
> > queue in the code path of updating nr_hw_queues.
> > 
> > Given they belong to same issue, I suggest to solve them all.
> 
> I still think if just prevent new IO, freeze queue is over-kill.
> 
> With respect to update nr_hw_queues, we could try to take the bios down from the
> queued requests as the blk_steal_bios. Then re-issue these bios after updating the
> nr_hw_queues.

It is always easier to say than done, :-)

Please go ahead and post patches, and I am happy to review.


Thanks,
Ming
