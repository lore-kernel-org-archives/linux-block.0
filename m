Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 6 Aug 2018 10:18:12 -0700
From: Tejun Heo <tj@kernel.org>
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Jianchao Wang <jianchao.w.wang@oracle.com>,
	Ming Lei <ming.lei@redhat.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Johannes Thumshirn <jthumshirn@suse.de>
Subject: Re: [PATCH v3 4/9] percpu-refcount: Introduce percpu_ref_read()
Message-ID: <20180806171812.GB410235@devbig004.ftw2.facebook.com>
References: <20180802182944.14442-1-bart.vanassche@wdc.com>
 <20180802182944.14442-5-bart.vanassche@wdc.com>
 <20180802190649.GV1206094@devbig004.ftw2.facebook.com>
 <aa524e89-6626-ed22-ff46-25674354ba58@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <aa524e89-6626-ed22-ff46-25674354ba58@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Hello, Bart.

On Thu, Aug 02, 2018 at 01:04:43PM -0700, Bart Van Assche wrote:
> As you probably know one of the long term goals for the block layer
> is to switch to blk-mq and to drop the legacy block layer. Hence
> this patch series that adds support for runtime power management to
> blk-mq because today that feature is missing from blk-mq. The
> approach is the same as for the legacy block layer: if the
> autosuspend timer expires and no
> requests are in flight, suspend the block device. So we need a
> mechanism to track whether or not any requests are in flight. One
> possible approach is to check the value of q_usage_counter.
> percpu_ref_is_zero() could only be used to check q_usage_counter if
> that counter would be switched to atomic mode first and if the
> initial reference would be dropped too. I want to avoid the overhead
> of that switch to atomic mode whenever possible. Hence the proposal
> to introduce the percpu_ref_read() function. If the value returned
> by that function is larger than one then we know that requests are
> in flight and hence that the switch to atomic mode can be skipped.
> 
> Proposals for alternative approaches are welcome.

I'm worried that this is too inviting for misuses and subtle problems.
For example, your patch which uses this function uses
synchronize_rcu() to synchronize against per-cpu counts after the
first snoop; however, percpu_ref uses sched rcu, not the regular one,
so depending on the config, this will lead to *really* subtle
failures.  Even if that gets fixed, it's still leaking percpu-ref
internal details to its users - details which may change in the future
and will cause super subtle bugs.

I'd go for something a lot more specific, like percpu_ref_is_one(), so
that all the magics can be contained in percpu-ref implementation
proper.

Thanks.

-- 
tejun
