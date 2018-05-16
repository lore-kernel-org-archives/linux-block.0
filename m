Return-Path: <ming.lei@redhat.com>
Date: Thu, 17 May 2018 06:18:44 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Keith Busch <keith.busch@linux.intel.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Laurence Oberman <loberman@redhat.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	James Smart <james.smart@broadcom.com>,
	linux-nvme@lists.infradead.org, Keith Busch <keith.busch@intel.com>,
	Jianchao Wang <jianchao.w.wang@oracle.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V5 0/9] nvme: pci: fix & improve timeout handling
Message-ID: <20180516221838.GA28727@ming.t460p>
References: <20180511122933.27155-1-ming.lei@redhat.com>
 <20180511205028.GB7772@localhost.localdomain>
 <20180512002110.GA23631@ming.t460p>
 <20180514151821.GE7772@localhost.localdomain>
 <20180514234701.GA21743@ming.t460p>
 <20180515003335.GB15199@localhost.localdomain>
 <20180516043127.GD17412@ming.t460p>
 <20180516151826.GB20223@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180516151826.GB20223@localhost.localdomain>
List-ID: <linux-block@vger.kernel.org>

On Wed, May 16, 2018 at 09:18:26AM -0600, Keith Busch wrote:
> On Wed, May 16, 2018 at 12:31:28PM +0800, Ming Lei wrote:
> > Hi Keith,
> > 
> > This issue may probably be fixed by Jianchao's patch of 'nvme: pci: set nvmeq->cq_vector
> > after alloc cq/sq'[1] and my another patch of 'nvme: pci: unquiesce admin
> > queue after controller is shutdown'[2], and both two have been included in the
> > posted V6.
> 
> No, it's definitely not related to that patch. The link is down in this
> test, I can assure you we're bailing out long before we ever even try to
> create an IO queue. The failing condition is detected by nvme_pci_enable's
> check for all 1's completions at the very beginning.

OK, this kind of failure during reset can be triggered in my test easily, then
nvme_remove_dead_ctrl() is called too, but not see IO hang from remove path.

As we discussed, it shouldn't be so, since queues are unquiesced &
killed, all IO should have been failed immediately. Also controller has
been shutdown, the queues are frozen too, so blk_mq_freeze_queue_wait()
won't wait on one unfrozen queue.

So could you post the debugfs log when the hang happens so that we may
find some clue?

Also, I don't think your issue is caused by this patchset, since
nvme_remove_dead_ctrl_work() and nvme_remove() aren't touched by this patch.
That means this issue may be triggered without this patchset too,
so could we start to review this patchset meantime?


Thanks,
Ming
