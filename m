Return-Path: <keith.busch@intel.com>
Date: Wed, 23 May 2018 08:08:57 -0600
From: Keith Busch <keith.busch@intel.com>
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Tejun Heo <tj@kernel.org>,
	Jianchao Wang <jianchao.w.wang@oracle.com>,
	Ming Lei <ming.lei@redhat.com>,
	Sebastian Ott <sebott@linux.ibm.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Israel Rukshin <israelr@mellanox.com>,
	Max Gurtovoy <maxg@mellanox.com>
Subject: Re: [PATCH v13] blk-mq: Rework blk-mq timeout handling again
Message-ID: <20180523140857.GA10852@localhost.localdomain>
References: <20180522162515.20650-1-bart.vanassche@wdc.com>
 <20180523140231.GA9028@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180523140231.GA9028@localhost.localdomain>
List-ID: <linux-block@vger.kernel.org>

On Wed, May 23, 2018 at 08:02:31AM -0600, Keith Busch wrote:
> Looks like the cmpxchg is also needed if old_state is MQ_RQ_TIMED_OUT,
> otherwise its guaranteed to return 'true' and there's no point to the
> loop and 'if' check.

And I see v14 is already posted with that fix! :)
