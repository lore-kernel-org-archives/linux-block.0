Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 11/14] rq-qos: introduce dio_bio callback
To: Randy Dunlap <rdunlap@infradead.org>, Josef Bacik <josef@toxicpanda.com>,
 linux-kernel@vger.kernel.org, akpm@linux-foundation.org, hannes@cmpxchg.org,
 tj@kernel.org, linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
 kernel-team@fb.com
Cc: Josef Bacik <jbacik@fb.com>
References: <20180703151503.2549-1-josef@toxicpanda.com>
 <20180703151503.2549-12-josef@toxicpanda.com>
 <be66a8be-f55b-3899-b6a6-3db6446acf2b@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <c4473939-548a-e8de-ab9f-ae6b7ffba345@kernel.dk>
Date: Tue, 3 Jul 2018 13:33:07 -0600
MIME-Version: 1.0
In-Reply-To: <be66a8be-f55b-3899-b6a6-3db6446acf2b@infradead.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 7/3/18 1:29 PM, Randy Dunlap wrote:
> On 07/03/2018 08:15 AM, Josef Bacik wrote:
>> From: Josef Bacik <jbacik@fb.com>
>>
>> wbt cares only about request completion time, but controllers may need
> 
> Please spell out wt^Hbt.
> whatever it is.

It's blk-wbt, so wbt is fine, I think it should be pretty clear from
the context of what is being changed.

-- 
Jens Axboe
