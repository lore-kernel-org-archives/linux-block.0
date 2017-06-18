Return-Path: <axboe@kernel.dk>
Date: Sun, 18 Jun 2017 14:26:05 -0600
From: Jens Axboe <axboe@kernel.dk>
To: Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
	Bart Van Assche <bart.vanassche@sandisk.com>
Subject: Re: [PATCH v5 00/12] blk-mq: fix & improve queue quiescing
Message-ID: <20170618202604.GA14417@kernel.dk>
References: <20170606152210.22806-1-ming.lei@redhat.com>
 <08a2b32d-866e-a71f-4ac6-9c131edb88e2@fb.com>
 <20170613021518.GB15043@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170613021518.GB15043@ming.t460p>
List-ID: <linux-block@vger.kernel.org>

On Tue, Jun 13 2017, Ming Lei wrote:
> On Tue, Jun 06, 2017 at 10:03:12AM -0600, Jens Axboe wrote:
> > On 06/06/2017 09:21 AM, Ming Lei wrote:
> > > Hi,
> > > 
> > > There is one big issue in current blk_mq_quiesce_queue():
> > > 
> > >     - in case of direct issue or BLK_MQ_S_START_ON_RUN, dispatch won't
> > >     be prevented after blk_mq_quiesce_queue() is returned.
> > > 
> > > 
> > > The 1st two patches fix two problems in direct issue, please consider
> > > it for v4.12.
> > > 
> > > The other 10 patches improves blk_mq_quiesce_queue(), and
> > > make is easy to use, and avoid race between queue restart and
> > > quiescing. These 10 patches should be for v4.13.
> > 
> > I've added 1-2 for 4.12, I'll review the rest for 4.13 when some
> > cycles free up.
> 
> Hi Jens,
> 
> If you are fine with 3-12, could you consider it for v4.13?
> 
> The fixes on uses of blk_mq_tagset_busy_iter() depends on
> this patchset.

Yes, I think it looks fine. I've applied the rest, except the nvme
patch, which no longer applies since start/stop changes have been made
there. Please resend that one against for-4.13/block, thanks.

-- 
Jens Axboe
