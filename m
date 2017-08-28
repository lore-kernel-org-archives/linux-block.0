Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH RFC] Block/blk-wbt: do not let background writes block
 sync writes
To: bo.li.liu@oracle.com
Cc: linux-block@vger.kernel.org
References: <20170826001427.23012-1-bo.li.liu@oracle.com>
 <b73a59d9-952b-d1f0-aa0a-86ba2b60a52c@kernel.dk>
 <20170828174531.GA21790@dhcp-10-211-47-181.usdhcp.oraclecorp.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <6d776a8d-e7ba-341e-33a7-bed0455d6e75@kernel.dk>
Date: Mon, 28 Aug 2017 15:05:14 -0600
MIME-Version: 1.0
In-Reply-To: <20170828174531.GA21790@dhcp-10-211-47-181.usdhcp.oraclecorp.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 08/28/2017 11:45 AM, Liu Bo wrote:
> On Sun, Aug 27, 2017 at 11:14:20AM -0600, Jens Axboe wrote:
>> On 08/25/2017 06:14 PM, Liu Bo wrote:
>>> While using blk-wbt, sometimes sync writes are blocked by background
>>> writes, for example,
>>>
>>> a) a background write reaches the (background) limit returned by
>>> get_limit(), so it's added into the rqw->wait (non kswapd's rqw in
>>> this case) and goes to sleep.
>>>
>>> b) then a sync write gets queued and goes to sleep when finding that
>>> waitqueue_active() returns true and someone else is already on the
>>> waiting list.
>>>
>>> Thus, the sync write will get its rq after the background write
>>> getting rq.
>>>
>>> With this, only background writes will check waitqueue's status and
>>> sync writes will only be throttled by the (max) limit returned by
>>> get_limit().
>>
>> Curious how you ran into this. Is this just speculation, or is it
>> observed behavior?
>>
> 
> I got that from a simple test,
> 
> xfs_io -f -c "falloc 0 4K" /mnt/btrfs/foobar
> xfs_io -f -c "falloc 0 5G" /mnt/btrfs/dummy
> xfs_io -f -c "pwrite -b 128M 0 5G" /mnt/btrfs/dummy &
> 
> off=0
> while true; do
>         date
> 	let $((off = off + 1))
>         xfs_io -s -c "pwrite $off 1"  /mnt/btrfs/foobar > /dev/null
>         sleep 1
> done
> 
> ---
> 
> So a lot of writeback is happening in background, and a write with
> O_SYNC is issued every 1 sec.
> 
> My ftrace observation shows that, write with O_SYNC is waiting in
> may_queue() because of the running writeback writes.
> 
>    kworker/u16:2-137   [003] ....  3104.193996: block_bio_queue: 8,64 W 8751312 + 2048 [kworker/u16:2]
>    kworker/u16:2-137   [003] ....  3104.194003: may_queue.part.12: inflight 23 limit 24 wait ffffc900007cb500
>    kworker/u16:2-137   [003] ....  3104.194003: block_getrq: 8,64 W 8751312 + 2048 [kworker/u16:2]
>    kworker/u16:2-137   [003] ....  3104.194004: blk_mq_flush_plug_list <-blk_flush_plug_list
>    kworker/u16:2-137   [003] ....  3104.194004: block_unplug: [kworker/u16:2] 1
>    kworker/u16:2-137   [003] ....  3104.194005: block_rq_insert: 8,64 W 1048576 () 8749264 + 2048 [kworker/u16:2]
>    kworker/u16:2-137   [003] ....  3104.194006: block_rq_issue: 8,64 W 1048576 () 8749264 + 2048 [kworker/u16:2]
>    kworker/u16:2-137   [003] ....  3104.194017: block_plug: [kworker/u16:2]
>    kworker/u16:2-137   [003] d.h.  3104.194454: block_rq_complete: 8,64 W () 8704208 + 2048 [0]
>    kworker/u16:2-137   [003] ....  3104.194978: block_bio_queue: 8,64 W 8753360 + 2048 [kworker/u16:2]
>    kworker/u16:2-137   [003] ....  3104.194985: may_queue.part.12: inflight 23 limit 24 wait ffffc900007cb500
>    kworker/u16:2-137   [003] ....  3104.194985: block_getrq: 8,64 W 8753360 + 2048 [kworker/u16:2]
>    kworker/u16:2-137   [003] ....  3104.194986: blk_mq_flush_plug_list <-blk_flush_plug_list
>    kworker/u16:2-137   [003] ....  3104.194987: block_unplug: [kworker/u16:2] 1
>    kworker/u16:2-137   [003] ....  3104.194987: block_rq_insert: 8,64 W 1048576 () 8751312 + 2048 [kworker/u16:2]
>    kworker/u16:2-137   [003] ....  3104.194990: block_rq_issue: 8,64 W 1048576 () 8751312 + 2048 [kworker/u16:2]
>    kworker/u16:2-137   [003] ....  3104.195001: block_plug: [kworker/u16:2]
>    kworker/u16:2-137   [003] ....  3104.195654: block_bio_queue: 8,64 W 8755408 + 2048 [kworker/u16:2]
>    kworker/u16:2-137   [003] ....  3104.195661: may_queue.part.12: inflight 24 limit 24 wait ffffc900007cb500
>    kworker/u16:2-137   [003] ....  3104.195662: may_queue.part.12: inflight 24 limit 24 wait ffffc900007cb500
>                                                                    ^^^^^^^^^^^^^^^
> 								   (wb write puts itself on rqw->wait when reaching the limit)
> 								   
>    kworker/u16:2-137   [003] ....  3104.195662: io_schedule <-wbt_wait
>    kworker/u16:2-137   [003] ....  3104.195662: blk_mq_flush_plug_list <-blk_flush_plug_list
>    kworker/u16:2-137   [003] ....  3104.195663: block_unplug: [kworker/u16:2] 1
>    kworker/u16:2-137   [003] ....  3104.195663: block_rq_insert: 8,64 W 1048576 () 8753360 + 2048 [kworker/u16:2]
>     kworker/3:1H-162   [003] ....  3104.195680: block_rq_issue: 8,64 W 1048576 () 8753360 + 2048 [kworker/3:1H]
>           <idle>-0     [003] d.h.  3104.200533: block_rq_complete: 8,64 W () 8706256 + 2048 [0]
>           <idle>-0     [003] d.h.  3104.205473: block_rq_complete: 8,64 W () 8708304 + 2048 [0]
>           <idle>-0     [003] d.h.  3104.211451: block_rq_complete: 8,64 W () 8710352 + 2048 [0]
>           <idle>-0     [003] d.h.  3104.216163: block_rq_complete: 8,64 W () 8712400 + 2048 [0]
>           <idle>-0     [003] d.h.  3104.222072: block_rq_complete: 8,64 W () 8714448 + 2048 [0]
>           <idle>-0     [003] d.h.  3104.226931: block_rq_complete: 8,64 W () 8716496 + 2048 [0]
>           <idle>-0     [003] d.h.  3104.232915: block_rq_complete: 8,64 W () 8718544 + 2048 [0]
>           <idle>-0     [003] d.h.  3104.238851: block_rq_complete: 8,64 W () 8720592 + 2048 [0]
>           <idle>-0     [003] d.h.  3104.243593: block_rq_complete: 8,64 W () 8722640 + 2048 [0]
>           <idle>-0     [003] d.h.  3104.249667: block_rq_complete: 8,64 W () 8724688 + 2048 [0]
>           <idle>-0     [003] d.h.  3104.254248: block_rq_complete: 8,64 W () 8726736 + 2048 [0]
>           xfs_io-1045  [007] ....  3104.254347: btrfs_sync_file: 77102a7b-fc17-42cb-afb7-ac57020b6bfb: root=5(FS_TREE) ino=257 parent=256 datasync=0
>           xfs_io-1045  [007] ....  3104.254384: cow_file_range.isra.58: ino 257 start 0x0 disk_num_bytes 0x1000
>           xfs_io-1045  [007] ....  3104.254402: btrfs_ordered_extent_add: 77102a7b-fc17-42cb-afb7-ac57020b6bfb: root=5(FS_TREE) ino=257 file_offset=0 start=12615680 len=4096 disk_len=4096 truncated_len=18446744073709551615 bytes_left=4096 flags= compress_type=0 refs=1
>           xfs_io-1045  [007] ....  3104.254441: block_bio_queue: 8,64 WS 24640 + 8 [xfs_io]
>           xfs_io-1045  [007] ....  3104.254446: wbt_wait: someone is waiting ffffc900007cb500
>           xfs_io-1045  [007] ....  3104.254448: wbt_wait: someone is waiting ffffc900007cb500
>           xfs_io-1045  [007] ....  3104.254449: io_schedule <-wbt_wait
> 	                                                    ^^^^^^^^^^^^^^^^^^^
> 							    (write with O_SYNC waits for wb write,
> 							    while the sync limit is more than 24)
> 
>           <idle>-0     [003] d.h.  3104.260393: block_rq_complete: 8,64 W () 8728784 + 2048 [0]
>           <idle>-0     [003] d.h.  3104.266310: block_rq_complete: 8,64 W () 8730832 + 2048 [0]
>           <idle>-0     [003] d.h.  3104.271152: block_rq_complete: 8,64 W () 8732880 + 2048 [0]
>           <idle>-0     [003] d.h.  3104.277141: block_rq_complete: 8,64 W () 8734928 + 2048 [0]
>           <idle>-0     [003] d.h.  3104.281908: block_rq_complete: 8,64 W () 8736976 + 2048 [0]
>           <idle>-0     [003] d.h.  3104.287744: block_rq_complete: 8,64 W () 8739024 + 2048 [0]
>           <idle>-0     [003] d.h.  3104.292584: block_rq_complete: 8,64 W () 8741072 + 2048 [0]
>           <idle>-0     [003] d.h.  3104.298541: block_rq_complete: 8,64 W () 8743120 + 2048 [0]
>           <idle>-0     [003] d.h.  3104.303266: block_rq_complete: 8,64 W () 8745168 + 2048 [0]
>           <idle>-0     [003] d.h.  3104.309273: block_rq_complete: 8,64 W () 8747216 + 2048 [0]
>           <idle>-0     [003] d.h.  3104.315312: block_rq_complete: 8,64 W () 8749264 + 2048 [0]
>           <idle>-0     [003] d.h.  3104.320060: block_rq_complete: 8,64 W () 8751312 + 2048 [0]
>           <idle>-0     [003] d.h.  3104.326148: block_rq_complete: 8,64 W () 8753360 + 2048 [0]
>    kworker/u16:2-137   [003] ....  3104.326534: may_queue.part.12: inflight 0 limit 24 wait ffffc900007cb500
>    kworker/u16:2-137   [003] ....  3104.326537: block_getrq: 8,64 W 8755408 + 2048 [kworker/u16:2]
>    kworker/u16:2-137   [003] ....  3104.326543: block_plug: [kworker/u16:2]
>           xfs_io-1045  [007] ....  3104.326546: may_queue.part.12: inflight 1 limit 96 wait ffffc90000ab7890
>           xfs_io-1045  [007] ....  3104.326548: block_getrq: 8,64 WS 24640 + 8 [xfs_io]
>           xfs_io-1045  [007] ....  3104.326553: block_rq_insert: 8,64 WS 4096 () 24640 + 8 [xfs_io]
> 	                                        ^^^^^^^^^^^^^^^^^
> 						(wb write and write with O_SYNC got waked up one by one)
> 
> 
>> I don't think the patch makes sense, conceptually. If you end up in
>> may_queue(), you are (by definition) in a class of writes that
>> should be throttled. Skipping the wait line would be unfair.
>>
> 
> OK, got it.
> 
>> One modification would be to check the depth, as we assign
>> different allowances to different types of writes. If the sync
>> write isn't above it's limit, we should not sleep.
>>
> 
> Yeah, that seems better, so it'd be like
> 
> if ((rw & REQ_HIPRIO) &&
>     atomic_inc_below(&rqw->inflight, get_limit(rwb, rw)))
>     return true;
> 
> if (waitqueue_active(&rqw->wait) &&
>     rqw->wait.head.next != &wait->entry)
> 	return false;

I thought a bit more about this, and one potential issue with doing it
this way, is that we'll potentially starve the background writes
forever. Let's say in the current system the stable limits are 4/8/16
for background/normal/high priority writes. Let's further assume that we
have some normal or sync writers that keep the queue depth at eg 6.
Background writes would be added to the wait queue, and the normal write
would proceed. If the normal write keeps the queue depth over the
background limit, then we'll never do any background writes. That's
probably worse than the current approach, since at least'll we'll ensure
forward progress.

We could split the wait queues for the bg/normal/high priority writes,
and add some heuristics to ensure fairness.

> What about kswapd?  It's also a high priority write, isn't it?

As you discovered in the next email, kswapd has its own wait queue.

-- 
Jens Axboe
