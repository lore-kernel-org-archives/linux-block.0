Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 2/2] blk-mq: convert WARN_ON in __blk_mq_run_hw_queue to
 printk
To: Christian Borntraeger <borntraeger@de.ibm.com>,
 Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>
Cc: Christoph Hellwig <hch@infradead.org>,
 "jianchao . wang" <jianchao.w.wang@oracle.com>,
 Stefan Haberland <sth@linux.vnet.ibm.com>, Christoph Hellwig <hch@lst.de>
References: <20180117123444.18393-1-ming.lei@redhat.com>
 <20180117123444.18393-3-ming.lei@redhat.com>
 <39203c80-e718-3aa6-6b21-05a6bf0ad9b0@kernel.dk>
 <e8acbff6-3263-e4e9-0a5c-025d999a6134@de.ibm.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <8b86704f-24cd-fddb-c9ca-60263bee4174@kernel.dk>
Date: Wed, 17 Jan 2018 09:07:44 -0700
MIME-Version: 1.0
In-Reply-To: <e8acbff6-3263-e4e9-0a5c-025d999a6134@de.ibm.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 1/17/18 9:05 AM, Christian Borntraeger wrote:
> 
> 
> On 01/17/2018 04:46 PM, Jens Axboe wrote:
>> On 1/17/18 5:34 AM, Ming Lei wrote:
>>> We know this WARN_ON is harmless and the stack trace isn't useful too,
>>> so convert it to printk(), and avoid to confuse people.
>>
>> I disagree, it is useful to know the exact path it happened from,
>> in case it's a valid warning. It could be an inline run and
>> we screwed up the logic, or it could be from a workqueue and
>> the reason would be entirely different.
> 
> Then add a dump_stack or whatever, but WARN_ON does have fatal effects
> for some setups. If it can happen then WARN_ON is just wrong.

dump_stack() is fine - and the intent is for it to never happen, it
would be nice to close those holes so we're only catching cases that
are due to bad code.

-- 
Jens Axboe
