Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 05/14] swap,blkcg: issue swap io with the appropriate
 context
To: Randy Dunlap <rdunlap@infradead.org>, Josef Bacik <josef@toxicpanda.com>,
 linux-kernel@vger.kernel.org, akpm@linux-foundation.org, hannes@cmpxchg.org,
 tj@kernel.org, linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
 kernel-team@fb.com
References: <20180703151503.2549-1-josef@toxicpanda.com>
 <20180703151503.2549-6-josef@toxicpanda.com>
 <da01afa9-ee89-3c54-9e41-b10875ff0787@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <e871d2ac-1c63-071a-a61d-df22b94fe89c@kernel.dk>
Date: Tue, 3 Jul 2018 13:32:45 -0600
MIME-Version: 1.0
In-Reply-To: <da01afa9-ee89-3c54-9e41-b10875ff0787@infradead.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 7/3/18 1:27 PM, Randy Dunlap wrote:
> On 07/03/2018 08:14 AM, Josef Bacik wrote:
>> From: Tejun Heo <tj@kernel.org>
>>
>> For backcharging we need to know who the page belongs to when swapping
>> it out.  We don't worry about things that do ->rw_page (zram etc) at the
>> moment, we're only worried about pages that actually go to a block
>> device.
>>
>> Signed-off-by: Tejun Heo <tj@kernel.org>
>> Signed-off-by: Josef Bacik <jbacik@fb.com>
>> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
>> cked-by: Andrew Morton <akpm@linux-foundation.org>
> 
> Checked-by:  ?  :)
> copy-pasto

I fixed that one up.

-- 
Jens Axboe
