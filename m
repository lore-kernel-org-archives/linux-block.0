Return-Path: <ming.lei@redhat.com>
Date: Tue, 22 May 2018 16:51:44 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <keith.busch@intel.com>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>
Subject: Re: [RFC PATCH 3/3] blk-mq: Remove generation seqeunce
Message-ID: <20180522085143.GB20604@ming.t460p>
References: <20180521231131.6685-1-keith.busch@intel.com>
 <20180521231131.6685-4-keith.busch@intel.com>
 <20180522024910.GD20430@ming.t460p>
 <34ba4583-25be-acf7-8407-755e920def6b@kernel.dk>
 <20180522034727.GE20430@ming.t460p>
 <29D40550-AF2A-4357-B87F-95C28259A334@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <29D40550-AF2A-4357-B87F-95C28259A334@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Mon, May 21, 2018 at 09:51:19PM -0600, Jens Axboe wrote:
> On May 21, 2018, at 9:47 PM, Ming Lei <ming.lei@redhat.com> wrote:
> > 
> >> On Mon, May 21, 2018 at 09:16:33PM -0600, Jens Axboe wrote:
> >>> On 5/21/18 8:49 PM, Ming Lei wrote:
> >>>> On Mon, May 21, 2018 at 05:11:31PM -0600, Keith Busch wrote:
> >>>> This patch simplifies the timeout handling by relying on the request
> >>>> reference counting to ensure the iterator is operating on an inflight
> >>> 
> >>> The reference counting isn't free, what is the real benefit in this way?
> >> 
> >> Neither is the current scheme and locking, and this is a hell of a lot
> >> simpler. I'd get rid of the kref stuff and just do a simple
> >> atomic_dec_and_test(). Most of the time we should be uncontended on
> >> that, which would make it pretty darn cheap. I'd be surprised if it
> >> wasn't better than the current alternatives.
> > 
> > The explicit memory barriers by atomic_dec_and_test() isn't free.
> 
> I’m not saying it’s free. Neither is our current synchronization.
> 
> > Also the double completion issue need to be fixed before discussing
> > this approach further.
> 
> Certainly. Also not saying that the current patch is perfect. But it’s a lot more palatable than the alternatives, hence my interest. And I’d like for this issue to get solved, we seem to be a bit stuck atm. 
> 

It may not be something we are stuck at, and seems no alternatives for
this patchset.

It is a new requirement from NVMe, and Keith wants driver to complete
timed-out request in .timeout(). We never support that before for both
mq and non-mq code path.

Thanks,
Ming
