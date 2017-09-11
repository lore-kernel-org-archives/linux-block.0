Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 11 Sep 2017 06:13:31 -0700
From: Tejun Heo <tj@kernel.org>
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Christoph Lameter <cl@linux.com>,
	NeilBrown <neilb@suse.com>
Subject: Re: [PATCH 1/5] percpu-refcount: Introduce
 percpu_ref_switch_to_atomic_nowait()
Message-ID: <20170911131331.GE1774378@devbig577.frc2.facebook.com>
References: <20170908235226.26622-1-bart.vanassche@wdc.com>
 <20170908235226.26622-2-bart.vanassche@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170908235226.26622-2-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Fri, Sep 08, 2017 at 04:52:22PM -0700, Bart Van Assche wrote:
> The blk-mq core keeps track of the number of request queue users
> through q->q_usage_count. Make it possible to switch this counter
> to atomic mode from the context of the block layer power management
> code by introducing percpu_ref_switch_to_atomic_nowait().

Do you ever have to switch back?  If so, how do you know whether the
previous transition finished?

Thanks.

-- 
tejun
