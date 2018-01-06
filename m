Return-Path: <axboe@kernel.dk>
Date: Sat, 6 Jan 2018 09:21:31 -0700
From: Jens Axboe <axboe@kernel.dk>
To: Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 00/10] block: cleanup on direct access to bvec
 table(prepare for multipage bvec)
Message-ID: <20180106162130.GB6343@kernel.dk>
References: <20171208131409.11889-1-ming.lei@redhat.com>
 <dd24b1c7-ac28-89dd-985a-bab54d8192c0@fb.com>
 <20180106091800.GB13472@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180106091800.GB13472@ming.t460p>
List-ID: <linux-block@vger.kernel.org>

On Sat, Jan 06 2018, Ming Lei wrote:
> On Fri, Jan 05, 2018 at 12:02:10PM -0700, Jens Axboe wrote:
> > On 12/8/17 6:13 AM, Ming Lei wrote:
> > > Hi,
> > > 
> > > This patchse cleans up most of direct access to bvec table in tree, and
> > > these patches are the follow-up of patch1 ~ 16 in the patchset of 'block:
> > > support multipage bvec(V3)'[1]. 
> > > 
> > > Changes against [1]:
> > > 1) split the cleanup patches from [1]
> > > 2) address comments from Christoph:
> > > 	- introduce bio helpers for dealing with the cleanup
> > > 	- move bio_alloc_pages() to bcache
> > > 
> > > 
> > > [1] https://marc.info/?t=150218197600001&r=1&w=2
> > 
> > Looks like good cleanups to me. I will apply this for 4.16, thanks.
> 
> Hi Jens,
> 
> Sorry for forgetting to update in this thread, the latest cleanup patchset
> has been included into the following patchset of '[PATCH V4 00/45] block: support
> multipage bvec' as patch 1 ~ 17: 
> 
> 	https://marc.info/?t=151359981400006&r=1&w=2
> 
> If possible, please revert this 10 patches in your block-tree, and apply
> the whole patchset of '[PATCH V4 00/45] block: support multipage bvec'
> on the above link, and the V4 is much more clean than before.

OK, we can do that, even if I generally dislike doing it. I applied the
first part of the series, I haven't had time to review the latter part,
and others haven't either. So timing isn't great for 4.16.

-- 
Jens Axboe
