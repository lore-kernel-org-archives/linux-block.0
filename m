Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH v4 2/2] block: Ensure that a request queue is dissociated
 from the cgroup controller
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "jthumshirn@suse.de" <jthumshirn@suse.de>, "hch@lst.de" <hch@lst.de>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "ming.lei@redhat.com" <ming.lei@redhat.com>, "tj@kernel.org"
 <tj@kernel.org>,
 "00moses.alexander00@gmail.com" <00moses.alexander00@gmail.com>,
 "joseph.qi@linux.alibaba.com" <joseph.qi@linux.alibaba.com>
References: <20180730211056.18570-1-bart.vanassche@wdc.com>
 <20180730211056.18570-3-bart.vanassche@wdc.com>
 <d04d4403-8b56-27c6-8601-56b5a45da936@kernel.dk>
 <7dacc4f78f7d4379e1f561afe526fbe23405fe6e.camel@wdc.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <1d4001a8-1d43-7973-e09a-d79b734b5b35@kernel.dk>
Date: Wed, 8 Aug 2018 09:05:39 -0600
MIME-Version: 1.0
In-Reply-To: <7dacc4f78f7d4379e1f561afe526fbe23405fe6e.camel@wdc.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>

On 8/8/18 9:04 AM, Bart Van Assche wrote:
> On Wed, 2018-08-08 at 08:41 -0600, Jens Axboe wrote:
>> On 7/30/18 3:10 PM, Bart Van Assche wrote:
>>> +#ifdef CONFIG_BLK_CGROUP
>>> +	{
>>> +		struct blkcg_gq *blkg;
>>> +
>>> +		rcu_read_lock();
>>> +		blkg = blkg_lookup(&blkcg_root, q);
>>> +		rcu_read_unlock();
>>> +
>>> +		WARN(blkg,
>>> +		     "request queue %p is being released but it has not yet been removed from the blkcg controller\n",
>>> +		     q);
>>> +	}
>>> +#endif
>>
>> This last hunk should go in the cgroup code.
> 
> Hello Jens,
> 
> How about leaving out the #ifdef CONFIG_BLK_CGROUP / #endif? Would that be
> sufficient? I just noticed that blkg_lookup() returns NULL anyway if cgroup support
> is disabled in the kernel config.

That's even better.

-- 
Jens Axboe
