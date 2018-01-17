Return-Path: <borntraeger@de.ibm.com>
Subject: Re: [PATCH 2/2] blk-mq: convert WARN_ON in __blk_mq_run_hw_queue to
 printk
To: Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
        linux-block@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Cc: Christoph Hellwig <hch@infradead.org>,
        "jianchao . wang" <jianchao.w.wang@oracle.com>,
        Stefan Haberland <sth@linux.vnet.ibm.com>,
        Christoph Hellwig <hch@lst.de>
References: <20180117123444.18393-1-ming.lei@redhat.com>
 <20180117123444.18393-3-ming.lei@redhat.com>
 <39203c80-e718-3aa6-6b21-05a6bf0ad9b0@kernel.dk>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 17 Jan 2018 17:05:46 +0100
MIME-Version: 1.0
In-Reply-To: <39203c80-e718-3aa6-6b21-05a6bf0ad9b0@kernel.dk>
Content-Type: text/plain; charset=utf-8
Message-Id: <e8acbff6-3263-e4e9-0a5c-025d999a6134@de.ibm.com>
List-ID: <linux-block@vger.kernel.org>



On 01/17/2018 04:46 PM, Jens Axboe wrote:
> On 1/17/18 5:34 AM, Ming Lei wrote:
>> We know this WARN_ON is harmless and the stack trace isn't useful too,
>> so convert it to printk(), and avoid to confuse people.
> 
> I disagree, it is useful to know the exact path it happened from,
> in case it's a valid warning. It could be an inline run and
> we screwed up the logic, or it could be from a workqueue and
> the reason would be entirely different.

Then add a dump_stack or whatever, but WARN_ON does have fatal effects
for some setups. If it can happen then WARN_ON is just wrong.
