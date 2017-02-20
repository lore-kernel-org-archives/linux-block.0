Return-Path: <axboe@kernel.dk>
Subject: Re: [GIT PULL] Block pull request for- 4.11-rc1
To: Bart Van Assche <Bart.VanAssche@sandisk.com>,
 Christoph Hellwig <hch@lst.de>
References: <dea6290e-0cfa-a93d-b03d-f6f3cd74d20f@kernel.dk>
 <1D08B61A9CF0974AA09887BE32D889DA0A74F3@ULS-OP-MBXIP03.sdcorp.global.sandisk.com>
 <633d226d-cec3-a01f-a069-ffff307e9715@kernel.dk>
 <20170220073539.GA17687@lst.de>
 <1D08B61A9CF0974AA09887BE32D889DA0A8CBD@ULS-OP-MBXIP03.sdcorp.global.sandisk.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Mike Snitzer <snitzer@redhat.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <f9b3b2ca-b19b-7c4a-52bb-789c3e2b39e5@kernel.dk>
Date: Mon, 20 Feb 2017 09:32:38 -0700
MIME-Version: 1.0
In-Reply-To: <1D08B61A9CF0974AA09887BE32D889DA0A8CBD@ULS-OP-MBXIP03.sdcorp.global.sandisk.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 02/20/2017 09:16 AM, Bart Van Assche wrote:
> On 02/19/2017 11:35 PM, Christoph Hellwig wrote:
>> On Sun, Feb 19, 2017 at 06:15:41PM -0700, Jens Axboe wrote:
>>> That said, we will look into this again, of course. Christoph, any idea?
>>
>> No idea really - this seems so far away from the code touched, and there
>> are no obvious signs for a memory scamble from another object touched
>> that I think if it really bisects down to that issue it must be a timing
>> issue.
>>
>> But reading Bart's message again:  Did you actually bisect it down
>> to the is commit?  Or just test the whole tree?  Between the 4.10-rc5
>> merge and all the block tree there might a few more likely suspects
>> like the scsi bdi lifetime fixes that James mentioned.
> 
> Hello Christoph,
> 
> As far as I know Jens does not rebase his trees so we can use the commit
> date to check which patch went in when. From the first of Jan's bdi patches:
> 
> CommitDate: Thu Feb 2 08:18:41 2017 -0700
> 
> So the bdi patches went in several days after I reported the general protection
> fault issue.
> 
> In an e-mail of January 30th I wrote the following: "Running the srp-test
> software against kernel 4.9.6 and kernel 4.10-rc5 went fine.  With your
> for-4.11/block branch (commit 400f73b23f457a) however I just ran into
> the following warning: [ ... ]" That means that I did not hit the crash with
> Jens' for-4.11/block branch but only with the for-next branch. The patches
> on Jens' for-next branch after that commit that were applied before I ran
> my test are:
> 
> $ PAGER= git log --format=oneline 400f73b23f457a..fb045ca25cc7 block drivers/md/dm{,-mpath,-table}.[ch]
> fb045ca25cc7b6d46368ab8221774489c2a81648 block: don't assign cmd_flags in __blk_rq_prep_clone
> 82ed4db499b8598f16f8871261bff088d6b0597f block: split scsi_request out of struct request
> 8ae94eb65be9425af4d57a4f4cfebfdf03081e93 block/bsg: move queue creation into bsg_setup_queue
> eb8db831be80692bf4bda3dfc55001daf64ec299 dm: always defer request allocation to the owner of the request_queue
> 6d247d7f71d1fa4b66a5f4da7b1daa21510d529b block: allow specifying size for extra command data
> 5ea708d15a928f7a479987704203616d3274c03b block: simplify blk_init_allocated_queue
> e6f7f93d58de74700f83dd0547dd4306248a093d block: fix elevator init check
> f924ba70c1b12706c6679d793202e8f4c125f7ae Merge branch 'for-4.11/block' into for-4.11/rq-refactor
> 88a7503376f4f3bf303c809d1a389739e1205614 blk-mq: Remove unused variable
> bef13315e990fd3d3fb4c39013aefd53f06c3657 block: don't try to discard from __blkdev_issue_zeroout
> f99e86485cc32cd16e5cc97f9bb0474f28608d84 block: Rename blk_queue_zone_size and bdev_zone_size
> 
> Do you see any patch in the above list that does not belong to the "split
> scsi passthrough fields out of struct request" series and that could have
> caused the reported behavior change?

Bart, since you are the only one that can reproduce this, can you just bisect
your way through that series?

-- 
Jens Axboe
