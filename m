Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 2/2] blk-mq: convert WARN_ON in __blk_mq_run_hw_queue to
 printk
To: Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>
Cc: Christoph Hellwig <hch@infradead.org>,
 "jianchao . wang" <jianchao.w.wang@oracle.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Stefan Haberland <sth@linux.vnet.ibm.com>, Christoph Hellwig <hch@lst.de>
References: <20180117123444.18393-1-ming.lei@redhat.com>
 <20180117123444.18393-3-ming.lei@redhat.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <39203c80-e718-3aa6-6b21-05a6bf0ad9b0@kernel.dk>
Date: Wed, 17 Jan 2018 08:46:40 -0700
MIME-Version: 1.0
In-Reply-To: <20180117123444.18393-3-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 1/17/18 5:34 AM, Ming Lei wrote:
> We know this WARN_ON is harmless and the stack trace isn't useful too,
> so convert it to printk(), and avoid to confuse people.

I disagree, it is useful to know the exact path it happened from,
in case it's a valid warning. It could be an inline run and
we screwed up the logic, or it could be from a workqueue and
the reason would be entirely different.

-- 
Jens Axboe
