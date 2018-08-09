Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH v5 1/3] blkcg: Introduce blkg_root_lookup()
To: Bart Van Assche <Bart.VanAssche@wdc.com>, "tj@kernel.org" <tj@kernel.org>
Cc: "jthumshirn@suse.de" <jthumshirn@suse.de>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "hch@lst.de" <hch@lst.de>, "stable@vger.kernel.org"
 <stable@vger.kernel.org>, "ming.lei@redhat.com" <ming.lei@redhat.com>,
 "osandov@fb.com" <osandov@fb.com>,
 "00moses.alexander00@gmail.com" <00moses.alexander00@gmail.com>,
 "joseph.qi@linux.alibaba.com" <joseph.qi@linux.alibaba.com>
References: <20180809145338.6160-1-bart.vanassche@wdc.com>
 <20180809145338.6160-2-bart.vanassche@wdc.com>
 <20180809195612.GE3978217@devbig004.ftw2.facebook.com>
 <794ba3894d7099fa7a855d3eb4d51c30faecd248.camel@wdc.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <f51e9e5e-0f8c-c9bb-5318-c442ed242449@kernel.dk>
Date: Thu, 9 Aug 2018 14:23:57 -0600
MIME-Version: 1.0
In-Reply-To: <794ba3894d7099fa7a855d3eb4d51c30faecd248.camel@wdc.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>

On 8/9/18 2:17 PM, Bart Van Assche wrote:
> On Thu, 2018-08-09 at 12:56 -0700, Tejun Heo wrote:
>> Hello,
>>
>> On Thu, Aug 09, 2018 at 07:53:36AM -0700, Bart Van Assche wrote:
>>> +/**
>>> + * blkg_lookup - look up blkg for the specified request queue
>>> + * @q: request_queue of interest
>>> + *
>>> + * Lookup blkg for @q at the root level. See also blkg_lookup().
>>> + */
>>> +static inline struct blkcg_gq *blkg_root_lookup(struct request_queue *q)
>>> +{
>>> +	struct blkcg_gq *blkg;
>>> +
>>> +	rcu_read_lock();
>>> +	blkg = blkg_lookup(&blkcg_root, q);
>>> +	rcu_read_unlock();
>>> +
>>> +	return blkg;
>>> +}
>>
>> So, root blkg is always available as long as the request_queue is
>> alive.  Sth like the following would be simpler?
>>
>> static inline struct blkcg_gq *blk_queue_root_blkg(struct request_queue *q)
>> {
>> 	return q->root_blkg;
>> }
> 
> That would not only be simpler, it would also avoid that blk_queue_root_blkg()
> returns NULL if bypass mode is enabled and the request queue is still associated
> with the block cgroup controller. How do you want to proceed with this change?

Do a followup patch?

-- 
Jens Axboe
