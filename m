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
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <b95e3ebf-f08d-2cbf-3f82-89424d7bf60d@kernel.dk>
Date: Mon, 15 Oct 2018 10:27:12 -0600
MIME-Version: 1.0
In-Reply-To: <7f27a68f-9cbe-c4c2-5c35-70763a5b1484@infradead.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 10/15/18 10:22 AM, Geoff Levand wrote:
> Hi Jens,
> 
> On 10/12/2018 05:58 PM, Jens Axboe wrote:
>> On 10/12/18 4:47 PM, Geoff Levand wrote:
>>> On 10/11/2018 09:58 AM, Jens Axboe wrote:
>>>> Convert from the old request_fn style driver to blk-mq.
>>>
>>> I tested this on PS3 applied to v4.19-rc7, and on boot it either
>>> gets a deadlock message or becomes unstable with various other
>>> block related error messages.
>>>
>>> For what its worth, I put an image of the deadlock message here:
>>>
>>>   https://storage.googleapis.com/public-tmp-files/blk-deadlock.jpg
>>
>> Thanks for testing! Can you try this incremental? It's mostly just
>> a cleanup on top, but the last hunk should be the thing that
>> hopefully makes this tick again. If you prefer just using a new
>> patch, this one is updated:
>>
>> http://git.kernel.dk/cgit/linux-block/commit/?h=mq-conversions&id=5c86f76f45e7c8d5a47a1f20b3e7b93fc945168a
> 
> I tested your V2 applied to v4.19-rc8 and it works a little
> better, in that the system will now boot up, but the ps3disk
> still gets hung up.
> 
> I added a '#define DEBUG' to ps3disk.c and saved the dmesg
> output with and without the patch here:
> 
>   https://storage.googleapis.com/public-tmp-files/dmesg-ok.txt
>   https://storage.googleapis.com/public-tmp-files/dmesg-ng.txt
> 
> Looking at dmesg-ng.txt, it seems things are going OK, but then
> go wrong with a 'tag mismatch':
> 
> [    6.068298] ps3disk sb_03: ps3disk_do_request:193
> [    6.068318] ps3disk sb_03: ps3disk_submit_request_sg:140: read req has 2 bvecs for 16 sectors
> [    6.068339] ps3disk sb_03: ps3disk_submit_request_sg:146: read 16 sectors starting at 256
> [    6.074231] ps3disk sb_03: ps3disk_interrupt:239: tag mismatch, got 0, expected 1
> [    6.084125] ps3disk sb_03: ps3disk_interrupt:271: read completed
> [    6.084147] ps3disk sb_03: ps3disk_scatter_gather:107: bio 0: 16 sectors from 256
> [    6.084174] ps3disk sb_03: ps3disk_scatter_gather:107: bio 1: 16 sectors from 256
> [    6.084405] ps3disk sb_03: ps3disk_interrupt:252 non-block layer request completed
> ...
> [  242.657694] INFO: task blkid:563 blocked for more than 120 seconds.
> 
> Geert is the original author of the PS3 disk support.  Geert,
> can you see anything wrong in the patch?

Can you try and change the queue depth to 1 instead of 2? It's set in
the tag_set, as ->queue_depth.

-- 
Jens Axboe
