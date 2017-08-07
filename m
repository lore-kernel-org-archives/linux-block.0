Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 0/2] null_blk: make sure submit_queues > 0
To: weiping <zhangweiping@didichuxing.com>
References: <20170802162555.GA30489@bogon.didichuxing.com>
 <20170807123600.GA5988@bogon.didichuxing.com>
From: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Message-ID: <e903f35f-ef14-2e53-3ea0-4bc663cd40d5@kernel.dk>
Date: Mon, 7 Aug 2017 15:17:57 -0600
MIME-Version: 1.0
In-Reply-To: <20170807123600.GA5988@bogon.didichuxing.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 08/07/2017 06:36 AM, weiping zhang wrote:
> On Thu, Aug 03, 2017 at 12:26:00AM +0800, weiping zhang wrote:
>> Hi,
>>
>> two misc patch for null_blk,
>>
>> null_blk: simplify logic for use_per_node_hctx
>> simplify code logic, if use_per_node_hctx set submit_queues same as
>> nr_online_nodes.
>>
>> null_blk: make sure submit_queues > 0
>> set submit_queues to 1 by default, and add a handle for it's value < 0,
>> no matter what user want, otherwise kmalloc has a negtive parameters.
>>
>> weiping zhang (2):
>>   null_blk: simplify logic for use_per_node_hctx
>>   null_blk: make sure submit_queues > 0
>>
>>  drivers/block/null_blk.c | 11 ++++-------
>>  1 file changed, 4 insertions(+), 7 deletions(-)
> 
> Hi Jens,
> 
> Have you had a chance to look these two misc changes at your
> convinience.

Looks fine/trivial to me, I've added them for 4.14. Thanks.

-- 
Jens Axboe
