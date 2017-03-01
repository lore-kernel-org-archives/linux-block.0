Return-Path: <osandov@osandov.com>
Return-Path: <osandov@osandov.com>
Date: Tue, 28 Feb 2017 23:26:53 -0800
From: Omar Sandoval <osandov@osandov.com>
To: Jan Kara <jack@suse.cz>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
	Lekshmi Pillai <lekshmicpillai@in.ibm.com>,
	Tejun Heo <tj@kernel.org>, NeilBrown <neilb@suse.de>
Subject: Re: [PATCH 0/13 v2] block: Fix block device shutdown related races
Message-ID: <20170301072653.GB9377@vader>
References: <20170221170958.21845-1-jack@suse.cz>
 <7734fd93-e4fd-65a7-bf32-08012de83c1e@kernel.dk>
 <20170222102425.GB23312@quack2.suse.cz>
 <20170301072528.GA9377@vader>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170301072528.GA9377@vader>
List-ID: <linux-block@vger.kernel.org>

On Tue, Feb 28, 2017 at 11:25:28PM -0800, Omar Sandoval wrote:
> On Wed, Feb 22, 2017 at 11:24:25AM +0100, Jan Kara wrote:
> > On Tue 21-02-17 10:19:28, Jens Axboe wrote:
> > > On 02/21/2017 10:09 AM, Jan Kara wrote:
> > > > Hello,
> > > > 
> > > > this is a second revision of the patch set to fix several different races and
> > > > issues I've found when testing device shutdown and reuse. The first three
> > > > patches are fixes to problems in my previous series fixing BDI lifetime issues.
> > > > Patch 4 fixes issues with reuse of BDI name with scsi devices. With it I cannot
> > > > reproduce the BDI name reuse issues using Omar's stress test using scsi_debug
> > > > so it can be used as a replacement of Dan's patches. Patches 5-11 fix oops that
> > > > is triggered by __blkdev_put() calling inode_detach_wb() too early (the problem
> > > > reported by Thiago). Patches 12 and 13 fix oops due to a bug in gendisk code
> > > > where get_gendisk() can return already freed gendisk structure (again triggered
> > > > by Omar's stress test).
> > > > 
> > > > People, please have a look at patches. They are mostly simple however the
> > > > interactions are rather complex so I may have missed something. Also I'm
> > > > happy for any additional testing these patches can get - I've stressed them
> > > > with Omar's script, tested memcg writeback, tested static (not udev managed)
> > > > device inodes.
> > > > 
> > > > Jens, I think at least patches 1-3 should go in together with my fixes you
> > > > already have in your tree (or shortly after them). It is up to you whether
> > > > you decide to delay my first fixes or pick these up quickly. Patch 4 is
> > > > (IMHO a cleaner) replacement of Dan's patches so consider whether you want
> > > > to use it instead of those patches.
> > > 
> > > I have applied 1-3 to my for-linus branch, which will go in after
> > > the initial pull request has been pulled by Linus. Consider fixing up
> > > #4 so it applies, I like it.
> > 
> > OK, attached is patch 4 rebased on top of Linus' tree from today which
> > already has linux-block changes pulled in. I've left put_disk_devt() in
> > blk_cleanup_queue() to maintain the logic in the original patch (now commit
> > 0dba1314d4f8) that request_queue and gendisk each hold one devt reference.
> > The bdi_unregister() call that is moved to del_gendisk() by this patch is
> > now protected by the gendisk reference instead of the request_queue one
> > so it still maintains the property that devt reference protects bdi
> > registration-unregistration lifetime (as much as that is not needed anymore
> > after this patch).
> > 
> > I have also updated the comment in the code and the changelog - they were
> > somewhat stale after changes to the whole series Tejun suggested.
> > 
> > 								Honza
> 
> Hey, Jan, I just tested this out when I was seeing similar crashes with
> sr instead of sd, and this fixed it.
> 
> Tested-by: Omar Sandoval <osandov@fb.com>

Just realized it wasn't clear, I'm talking about patch 4 specifically.
