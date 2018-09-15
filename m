Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] block: remove bio_rewind_iter()
To: Christoph Hellwig <hch@infradead.org>, Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org, Kent Overstreet <kent.overstreet@gmail.com>,
 Dmitry Monakhov <dmonakhov@openvz.org>, Christoph Hellwig <hch@lst.de>,
 Hannes Reinecke <hare@suse.com>
References: <20180905033335.12666-1-ming.lei@redhat.com>
 <20180915070301.GB15555@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <e04d57cd-2ed1-2141-41c3-099a348ed80d@kernel.dk>
Date: Sat, 15 Sep 2018 08:41:32 -0600
MIME-Version: 1.0
In-Reply-To: <20180915070301.GB15555@infradead.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 9/15/18 1:03 AM, Christoph Hellwig wrote:
> On Wed, Sep 05, 2018 at 11:33:35AM +0800, Ming Lei wrote:
>> It is pointed that bio_rewind_iter() is one very bad API[1]:
>>
>> 1) bio size may not be restored after rewinding
>>
>> 2) it causes some bogus change, such as 5151842b9d8732 (block: reset
>> bi_iter.bi_done after splitting bio)
>>
>> 3) rewinding really makes things complicated wrt. bio splitting
>>
>> 4) unnecessary updating of .bi_done in fast path
>>
>> [1] https://marc.info/?t=153549924200005&r=1&w=2
> 
> Based on that this is a bug fix and should go to 4.19 instead of 4.20
> as it is queued up right now..

It's not a new issue (in fact not even close, we're about a year back),
hence not a strong reason to shove it into 4.19 vs 4.20. I'm fine
with subsequently marking it for stable.

-- 
Jens Axboe
