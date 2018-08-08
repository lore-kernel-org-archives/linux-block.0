Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 8 Aug 2018 08:23:51 -0700
From: Tejun Heo <tj@kernel.org>
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
	Jianchao Wang <jianchao.w.wang@oracle.com>,
	Hannes Reinecke <hare@suse.com>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH v5 4/9] percpu-refcount: Introduce percpu_ref_is_in_use()
Message-ID: <20180808152351.GD3978217@devbig004.ftw2.facebook.com>
References: <20180807225133.27221-1-bart.vanassche@wdc.com>
 <20180807225133.27221-5-bart.vanassche@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180807225133.27221-5-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Hello,

On Tue, Aug 07, 2018 at 03:51:28PM -0700, Bart Van Assche wrote:
> Introduce a function that allows to determine whether a per-cpu refcount
> is in use. This function will be used in a later patch to determine
> whether or not any block layer requests are being executed.

I thought about it a bit and am having a bit of difficulty convincing
myself this is necessary.  Switching a percpu_ref to atomic mode isn't
expensive - it's one spinlock cycle, a rcu wait and one sweep of the
percpu counters.  The most expensive part - the percpu sweep - needs
to be there even with optimization, the wait doesn't really matter as
all it'll do is slightly delaying timer based PM operation and can be
overlayed with the propagation of set_pm_only() anyway.

So, how about just doing the simple thing?  Switch it to atomic mode
and check the counter and switch back to percpu mode afterwards.  If
we see any issues with that, we can try to optimize it later but that
seems unlikely to me.

Thanks.

-- 
tejun
