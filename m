Return-Path: <axboe@kernel.dk>
Subject: Re: [GIT PULL] Block pull request for- 4.11-rc1
To: Bart Van Assche <Bart.VanAssche@sandisk.com>, "hch@lst.de" <hch@lst.de>
References: <dea6290e-0cfa-a93d-b03d-f6f3cd74d20f@kernel.dk>
 <1D08B61A9CF0974AA09887BE32D889DA0A74F3@ULS-OP-MBXIP03.sdcorp.global.sandisk.com>
 <633d226d-cec3-a01f-a069-ffff307e9715@kernel.dk>
 <20170220073539.GA17687@lst.de>
 <1D08B61A9CF0974AA09887BE32D889DA0A8CBD@ULS-OP-MBXIP03.sdcorp.global.sandisk.com>
 <f9b3b2ca-b19b-7c4a-52bb-789c3e2b39e5@kernel.dk>
 <1487957968.2575.6.camel@sandisk.com>
Cc: "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "snitzer@redhat.com" <snitzer@redhat.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <58380de7-0ed5-efae-0b14-ba7d6cd02213@kernel.dk>
Date: Fri, 24 Feb 2017 10:51:21 -0700
MIME-Version: 1.0
In-Reply-To: <1487957968.2575.6.camel@sandisk.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 02/24/2017 10:39 AM, Bart Van Assche wrote:
> On Mon, 2017-02-20 at 09:32 -0700, Jens Axboe wrote:
>> On 02/20/2017 09:16 AM, Bart Van Assche wrote:
>>> On 02/19/2017 11:35 PM, Christoph Hellwig wrote:
>>>> On Sun, Feb 19, 2017 at 06:15:41PM -0700, Jens Axboe wrote:
>>>>> That said, we will look into this again, of course. Christoph, any idea?
>>>>
>>>> No idea really - this seems so far away from the code touched, and there
>>>> are no obvious signs for a memory scamble from another object touched
>>>> that I think if it really bisects down to that issue it must be a timing
>>>> issue.
>>>>
>>>> But reading Bart's message again:  Did you actually bisect it down
>>>> to the is commit?  Or just test the whole tree?  Between the 4.10-rc5
>>>> merge and all the block tree there might a few more likely suspects
>>>> like the scsi bdi lifetime fixes that James mentioned.
>>>
>>> Hello Christoph,
>>>
>>> As far as I know Jens does not rebase his trees so we can use the commit
>>> date to check which patch went in when. From the first of Jan's bdi patches:
>>>
>>> CommitDate: Thu Feb 2 08:18:41 2017 -0700
>>>
>>> So the bdi patches went in several days after I reported the general protection
>>> fault issue.
>>>
>>> In an e-mail of January 30th I wrote the following: "Running the srp-test
>>> software against kernel 4.9.6 and kernel 4.10-rc5 went fine.  With your
>>> for-4.11/block branch (commit 400f73b23f457a) however I just ran into
>>> the following warning: [ ... ]" That means that I did not hit the crash with
>>> Jens' for-4.11/block branch but only with the for-next branch. The patches
>>> on Jens' for-next branch after that commit that were applied before I ran
>>> my test are:
>>>
>>> $ PAGER= git log --format=oneline 400f73b23f457a..fb045ca25cc7 block drivers/md/dm{,-mpath,-table}.[ch]
>>> fb045ca25cc7b6d46368ab8221774489c2a81648 block: don't assign cmd_flags in __blk_rq_prep_clone
>>> 82ed4db499b8598f16f8871261bff088d6b0597f block: split scsi_request out of struct request
>>> 8ae94eb65be9425af4d57a4f4cfebfdf03081e93 block/bsg: move queue creation into bsg_setup_queue
>>> eb8db831be80692bf4bda3dfc55001daf64ec299 dm: always defer request allocation to the owner of the request_queue
>>> 6d247d7f71d1fa4b66a5f4da7b1daa21510d529b block: allow specifying size for extra command data
>>> 5ea708d15a928f7a479987704203616d3274c03b block: simplify blk_init_allocated_queue
>>> e6f7f93d58de74700f83dd0547dd4306248a093d block: fix elevator init check
>>> f924ba70c1b12706c6679d793202e8f4c125f7ae Merge branch 'for-4.11/block' into for-4.11/rq-refactor
>>> 88a7503376f4f3bf303c809d1a389739e1205614 blk-mq: Remove unused variable
>>> bef13315e990fd3d3fb4c39013aefd53f06c3657 block: don't try to discard from __blkdev_issue_zeroout
>>> f99e86485cc32cd16e5cc97f9bb0474f28608d84 block: Rename blk_queue_zone_size and bdev_zone_size
>>>
>>> Do you see any patch in the above list that does not belong to the "split
>>> scsi passthrough fields out of struct request" series and that could have
>>> caused the reported behavior change?
>>
>> Bart, since you are the only one that can reproduce this, can you just bisect
>> your way through that series?
> 
> Hello Jens,
> 
> Since Christoph also has access to IB hardware I will leave it to Christoph
> to do the bisect. Anyway, I just reproduced this crash with Linus' current
> tree (commit f1ef09fde17f) by running srp-test/run_tests -r 10 -t 02-sq-on-mq
> (see also https://github.com/bvanassche/srp-test):
> 
> [ 1629.920553] general protection fault: 0000 [#1] SMP
> [ 1629.921193] CPU: 6 PID: 46 Comm: ksoftirqd/6 Tainted: G          I     4.10.0-dbg+ #1
> [ 1629.921289] RIP: 0010:rq_completed+0x12/0x90 [dm_mod]
> [ 1629.921316] RSP: 0018:ffffc90001bdbda8 EFLAGS: 00010246
> [ 1629.921344] RAX: 0000000000000000 RBX: 6b6b6b6b6b6b6b6b RCX: 0000000000000000
> [ 1629.921372] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 6b6b6b6b6b6b6b6b
> [ 1629.921401] RBP: ffffc90001bdbdc0 R08: ffff8803a3858d48 R09: 0000000000000000
> [ 1629.921429] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> [ 1629.921458] R13: 0000000000000000 R14: ffffffff81c05120 R15: 0000000000000004
> [ 1629.921489] FS:  0000000000000000(0000) GS:ffff88046ef80000(0000) knlGS:0000000000000000
> [ 1629.921520] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 1629.921547] CR2: 00007fb6324486b8 CR3: 0000000001c0f000 CR4: 00000000001406e0
> [ 1629.921576] Call Trace:
> [ 1629.921605]  dm_softirq_done+0xe6/0x1e0 [dm_mod]
> [ 1629.921637]  blk_done_softirq+0x88/0xa0
> [ 1629.921663]  __do_softirq+0xba/0x4c0
> [ 1629.921744]  run_ksoftirqd+0x1a/0x50
> [ 1629.921769]  smpboot_thread_fn+0x123/0x1e0
> [ 1629.921797]  kthread+0x107/0x140
> [ 1629.921944]  ret_from_fork+0x2e/0x40
> [ 1629.921972] Code: ff ff 31 f6 48 89 c7 e8 ed 96 2f e1 5d c3 90 66 2e 0f 1f 84 00 00 00 00 00 55 48 63 f6 48 89 e5 41 55 41 89 d5 41 54 53 48 89 fb <4c> 8b a7 70 02 00 00 f0 ff 8c b7 38 03 00 00 e8 3a 43 ff ff 85 
> [ 1629.922093] RIP: rq_completed+0x12/0x90 [dm_mod] RSP: ffffc90001bdbda8
> 
> $ gdb drivers/md/dm-mod.ko
> (gdb) list *(rq_completed+0x12)    
> 0xdf62 is in rq_completed (drivers/md/dm-rq.c:187).
> 182      * the md may be freed in dm_put() at the end of this function.
> 183      * Or do dm_get() before calling this function and dm_put() later.
> 184      */
> 185     static void rq_completed(struct mapped_device *md, int rw, bool run_queue)
> 186     {
> 187             struct request_queue *q = md->queue;
> 188             unsigned long flags;
> 189
> 190             atomic_dec(&md->pending[rw]);
> 191
> (gdb) disas rq_completed  
> Dump of assembler code for function rq_completed:
>    0x000000000000df50 <+0>:     push   %rbp
>    0x000000000000df51 <+1>:     movslq %esi,%rsi
>    0x000000000000df54 <+4>:     mov    %rsp,%rbp
>    0x000000000000df57 <+7>:     push   %r13
>    0x000000000000df59 <+9>:     mov    %edx,%r13d
>    0x000000000000df5c <+12>:    push   %r12
>    0x000000000000df5e <+14>:    push   %rbx
>    0x000000000000df5f <+15>:    mov    %rdi,%rbx
>    0x000000000000df62 <+18>:    mov    0x270(%rdi),%r12
> [ ... ]
> 
> So the crash is caused by an attempt to dereference address 0x6b6b6b6b6b6b6b6b
> at offset 0x270. I think this means the crash is caused by a use-after-free.

Christoph, if you have the setup to reproduce this now, can you bisect and
see wtf is going on here?

-- 
Jens Axboe
