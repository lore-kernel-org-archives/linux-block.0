Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC: Linus Torvalds <torvalds@linux-foundation.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Mike Snitzer
	<snitzer@redhat.com>
Subject: RE: [GIT PULL] Block pull request for- 4.11-rc1
Date: Mon, 20 Feb 2017 16:16:57 +0000
Message-ID: <1D08B61A9CF0974AA09887BE32D889DA0A8CBD@ULS-OP-MBXIP03.sdcorp.global.sandisk.com>
References: <dea6290e-0cfa-a93d-b03d-f6f3cd74d20f@kernel.dk>
 <1D08B61A9CF0974AA09887BE32D889DA0A74F3@ULS-OP-MBXIP03.sdcorp.global.sandisk.com>
 <633d226d-cec3-a01f-a069-ffff307e9715@kernel.dk>,<20170220073539.GA17687@lst.de>
In-Reply-To: <20170220073539.GA17687@lst.de>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Return-Path: Bart.VanAssche@sandisk.com
List-ID: <linux-block@vger.kernel.org>

On 02/19/2017 11:35 PM, Christoph Hellwig wrote:=0A=
> On Sun, Feb 19, 2017 at 06:15:41PM -0700, Jens Axboe wrote:=0A=
>> That said, we will look into this again, of course. Christoph, any idea?=
=0A=
> =0A=
> No idea really - this seems so far away from the code touched, and there=
=0A=
> are no obvious signs for a memory scamble from another object touched=0A=
> that I think if it really bisects down to that issue it must be a timing=
=0A=
> issue.=0A=
> =0A=
> But reading Bart's message again:  Did you actually bisect it down=0A=
> to the is commit?  Or just test the whole tree?  Between the 4.10-rc5=0A=
> merge and all the block tree there might a few more likely suspects=0A=
> like the scsi bdi lifetime fixes that James mentioned.=0A=
=0A=
Hello Christoph,=0A=
=0A=
As far as I know Jens does not rebase his trees so we can use the commit=0A=
date to check which patch went in when. From the first of Jan's bdi patches=
:=0A=
=0A=
CommitDate: Thu Feb 2 08:18:41 2017 -0700=0A=
=0A=
So the bdi patches went in several days after I reported the general protec=
tion=0A=
fault issue.=0A=
=0A=
In an e-mail of January 30th I wrote the following: "Running the srp-test=
=0A=
software against kernel 4.9.6 and kernel 4.10-rc5 went fine.  With your=0A=
for-4.11/block branch (commit 400f73b23f457a) however I just ran into=0A=
the following warning: [ ... ]" That means that I did not hit the crash wit=
h=0A=
Jens' for-4.11/block branch but only with the for-next branch. The patches=
=0A=
on Jens' for-next branch after that commit that were applied before I ran=
=0A=
my test are:=0A=
=0A=
$ PAGER=3D git log --format=3Doneline 400f73b23f457a..fb045ca25cc7 block dr=
ivers/md/dm{,-mpath,-table}.[ch]=0A=
fb045ca25cc7b6d46368ab8221774489c2a81648 block: don't assign cmd_flags in _=
_blk_rq_prep_clone=0A=
82ed4db499b8598f16f8871261bff088d6b0597f block: split scsi_request out of s=
truct request=0A=
8ae94eb65be9425af4d57a4f4cfebfdf03081e93 block/bsg: move queue creation int=
o bsg_setup_queue=0A=
eb8db831be80692bf4bda3dfc55001daf64ec299 dm: always defer request allocatio=
n to the owner of the request_queue=0A=
6d247d7f71d1fa4b66a5f4da7b1daa21510d529b block: allow specifying size for e=
xtra command data=0A=
5ea708d15a928f7a479987704203616d3274c03b block: simplify blk_init_allocated=
_queue=0A=
e6f7f93d58de74700f83dd0547dd4306248a093d block: fix elevator init check=0A=
f924ba70c1b12706c6679d793202e8f4c125f7ae Merge branch 'for-4.11/block' into=
 for-4.11/rq-refactor=0A=
88a7503376f4f3bf303c809d1a389739e1205614 blk-mq: Remove unused variable=0A=
bef13315e990fd3d3fb4c39013aefd53f06c3657 block: don't try to discard from _=
_blkdev_issue_zeroout=0A=
f99e86485cc32cd16e5cc97f9bb0474f28608d84 block: Rename blk_queue_zone_size =
and bdev_zone_size=0A=
=0A=
Do you see any patch in the above list that does not belong to the "split=
=0A=
scsi passthrough fields out of struct request" series and that could have=
=0A=
caused the reported behavior change?=0A=
=0A=
Thanks,=0A=
=0A=
Bart.=
