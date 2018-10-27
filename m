Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 01/14] blk-mq: kill q->mq_map
From: Jens Axboe <axboe@kernel.dk>
To: "jianchao.wang" <jianchao.w.wang@oracle.com>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20181025211626.12692-1-axboe@kernel.dk>
 <20181025211626.12692-2-axboe@kernel.dk>
 <f0b01bcc-fa62-880d-80ef-c44095d82077@oracle.com>
 <2357b785-6730-fb02-f7fb-9f4a230a00ea@kernel.dk>
Message-ID: <b40d8e78-c443-7e10-db4e-4d31acf2695b@kernel.dk>
Date: Sat, 27 Oct 2018 10:52:55 -0600
MIME-Version: 1.0
In-Reply-To: <2357b785-6730-fb02-f7fb-9f4a230a00ea@kernel.dk>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 10/27/18 10:48 AM, Jens Axboe wrote:
> On 10/27/18 8:19 AM, jianchao.wang wrote:
>> Hi Jens
>>
>> On 10/26/18 5:16 AM, Jens Axboe wrote:
>>> It's just a pointer to set->mq_map, use that instead.
>> Instead of using the set->mq_map and then a two-dimensional set->mq_map,
>> how about migrate the mq_map from per-set to per-cpuctx ?
>> something like:
>> q->queue_hw_ctx[ctx->map[type]]
> 
> I think the current series is pretty clean in that regard, it goes
> from members -> map -> map array. I'd be willing to look at a
> conversion on top of that, if it makes things cleaner.

On top of that, this:

q->queue_hw_ctx[set->map[type].mq_map[cpu]]

is one less pointer dereference, so more efficient.

-- 
Jens Axboe
