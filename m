Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 03/17] ps3disk: convert to blk-mq
To: Geoff Levand <geoff@infradead.org>, linux-block@vger.kernel.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>
References: <20181011165909.32615-1-axboe@kernel.dk>
 <20181011165909.32615-4-axboe@kernel.dk>
 <17539e5f-742b-796e-8e36-31327120f883@infradead.org>
 <ee11f577-5766-13bc-2ff5-e3d672041462@kernel.dk>
 <7f27a68f-9cbe-c4c2-5c35-70763a5b1484@infradead.org>
 <b95e3ebf-f08d-2cbf-3f82-89424d7bf60d@kernel.dk>
 <3403ae47-1aaa-9d01-817c-cd52a7daa272@infradead.org>
 <ef7c0fb3-a31f-68e3-25f6-478958c08602@kernel.dk>
 <6d7ccd4c-0d41-e2d3-6ecd-b9efbd7358b5@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <870de740-005f-ff82-ef33-7c8aac1a2c86@kernel.dk>
Date: Mon, 15 Oct 2018 13:30:48 -0600
MIME-Version: 1.0
In-Reply-To: <6d7ccd4c-0d41-e2d3-6ecd-b9efbd7358b5@infradead.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 10/15/18 1:24 PM, Geoff Levand wrote:
> Hi Jens,
> 
> On 10/15/2018 11:38 AM, Jens Axboe wrote:
>> Weird, it looks like we're waiting for something to complete, and then
>> we have a few others waiting for queue new IO.
>>
>> Can you try and move the blk_mq_end_request() inside the priv->lock
>> section and see if that helps?
> 
> With the change below to your V2 I can't get it to have an
> error.  I did mkfs.ext4, some big file downloads, and ran
> 'fsck.ext3 -c' for a while.

OK good, that's better than having to make the bigger change I
just sent out.

> Thanks for working late on it.

Thanks for testing! I'll add your tested-by.

-- 
Jens Axboe
