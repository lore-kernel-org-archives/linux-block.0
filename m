Return-Path: <ming.lei@redhat.com>
Date: Thu, 18 Jan 2018 00:17:32 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Christoph Hellwig <hch@infradead.org>,
	"jianchao . wang" <jianchao.w.wang@oracle.com>,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	Stefan Haberland <sth@linux.vnet.ibm.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 2/2] blk-mq: convert WARN_ON in __blk_mq_run_hw_queue to
 printk
Message-ID: <20180117161731.GC21896@ming.t460p>
References: <20180117123444.18393-1-ming.lei@redhat.com>
 <20180117123444.18393-3-ming.lei@redhat.com>
 <39203c80-e718-3aa6-6b21-05a6bf0ad9b0@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <39203c80-e718-3aa6-6b21-05a6bf0ad9b0@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Wed, Jan 17, 2018 at 08:46:40AM -0700, Jens Axboe wrote:
> On 1/17/18 5:34 AM, Ming Lei wrote:
> > We know this WARN_ON is harmless and the stack trace isn't useful too,
> > so convert it to printk(), and avoid to confuse people.
> 
> I disagree, it is useful to know the exact path it happened from,
> in case it's a valid warning. It could be an inline run and

inline run is only possible in theory, since the window is too
small.

> we screwed up the logic, or it could be from a workqueue and
> the reason would be entirely different.

OK, if you don't agree, I will just add the comment on the races
we found.

-- 
Ming
