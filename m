Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 777D4C433EF
	for <linux-block@archiver.kernel.org>; Fri, 15 Apr 2022 02:10:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348566AbiDOCMk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Apr 2022 22:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348604AbiDOCMf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Apr 2022 22:12:35 -0400
Received: from mx.ewheeler.net (mx.ewheeler.net [173.205.220.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05CE91A393
        for <linux-block@vger.kernel.org>; Thu, 14 Apr 2022 19:10:07 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mx.ewheeler.net (Postfix) with ESMTP id 5438639;
        Thu, 14 Apr 2022 19:10:07 -0700 (PDT)
X-Virus-Scanned: amavisd-new at ewheeler.net
Received: from mx.ewheeler.net ([127.0.0.1])
        by localhost (mx.ewheeler.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id rDU9nMGboJI0; Thu, 14 Apr 2022 19:10:05 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx.ewheeler.net (Postfix) with ESMTPSA id AB1CD46;
        Thu, 14 Apr 2022 19:10:05 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx.ewheeler.net AB1CD46
Date:   Thu, 14 Apr 2022 19:10:04 -0700 (PDT)
From:   Eric Wheeler <linux-block@lists.ewheeler.net>
To:     Ming Lei <ming.lei@redhat.com>
cc:     linux-block@vger.kernel.org
Subject: Re: loop: it looks like REQ_OP_FLUSH could return before IO
 completion.
In-Reply-To: <YldqnL79xH5NJGKW@T590>
Message-ID: <5b3cb173-484e-db3-8224-911a324de7dd@ewheeler.net>
References: <af3e552a-6c77-b295-19e1-d7a1e39b31f3@ewheeler.net> <YjfFHvTCENCC29WS@T590> <c03de7ac-63e9-2680-ca5b-8be62e4e177f@ewheeler.net> <bd5f9817-c65e-7915-18b-9c68bb34488e@ewheeler.net> <YldqnL79xH5NJGKW@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 14 Apr 2022, Ming Lei wrote:
> On Wed, Apr 13, 2022 at 03:49:07PM -0700, Eric Wheeler wrote:
> > On Tue, 22 Mar 2022, Eric Wheeler wrote:
> > > On Mon, 21 Mar 2022, Ming Lei wrote:
> > > > On Sat, Mar 19, 2022 at 10:14:29AM -0700, Eric Wheeler wrote:
> > > > > Hello all,
> > > > > 
> > > > > In loop.c do_req_filebacked() for REQ_OP_FLUSH, lo_req_flush() is called: 
> > > > > it does not appear that lo_req_flush() does anything to make sure 
> > > > > ki_complete has been called for pending work, it just calls vfs_fsync().
> > > > > 
> > > > > Is this a consistency problem?
> > > > 
> > > > No. What FLUSH command provides is just flushing cache in device side to
> > > > storage medium, so it is nothing to do with pending request.
> > > 
> > > If a flush follows a series of writes, would it be best if the flush 
> > > happened _after_ those writes complete?  Then then the storage medium will 
> > > be sure to flush what was intended to be written.
> > > 
> > > It seems that this series of events could lead to inconsistent data:
> > > 	loop		->	filesystem
> > > 	write a
> > > 	write b
> > > 	flush
> > > 				write a
> > > 				flush
> > > 				write b
> > > 				crash, b is lost
> > > 
> > > If write+flush ordering is _not_ important, then can you help me 
> > > understand why?
> > > 
> > 
> > Hi Ming, just checking in: did you see the message above?
> > 
> > Do you really mean to say that reordering writes around a flush is safe 
> > in the presence of a crash?
> 
> Sorry, replied too quick.

Thats ok, thanks for considering the issue!
 
> BTW, what is the actual crash? Any dmesg log? From the above description, b is
> just not flushed to storage when running flush, and sooner or later it will
> land, so what is the real issue?

In this case "crash" is actually a filesystem snapshot using most any 
snapshot technology such as: dm-thin, btrfs, bcachefs, zfs.  From the 
filesystem inside the loop file's point of view, a snapshot is the same as 
a hardware crash.

Some background:

  We've already seen journal commit re-ordering caused by dm-crypt in 
  dm-thin snapshots:
	dm-thin -> dm-crypt -> [kvm with a disk using ext4]

  This is the original email about dm-crypt ordering:
	https://listman.redhat.com/archives/dm-devel/2016-September/msg00035.html 

  We "fixed" the dm-crypt issue by disabling parallel dm-crypt threads 
  with dm-crypt flags same_cpu_crypt+submit_from_crypt_cpus and haven't 
  seen the issue since. (Its noticably slower, but I'll take consistency 
  over performance any day! Not sure if that old dm-crypt ordering has 
  been fixed.)

So back to considering loop devs:

Having seen the dm-crypt issue I would like to verify that loop isn't 
susceptable to the same issue in the presence of lower-level 
snapshots---but it looks like it could be since flushes don't enforce 
ordering.  Here is why:

In ext4/super.c:ext4_sync_fs(), the ext4 code calls 
blkdev_issue_flush(sb->s_bdev) when barriers are enabled (which is 
default).  blkdev_issue_flush() sets REQ_PREFLUSH and according to 
blk_types.h this is a "request for cache flush"; you could think of 
in-flight IO's on the way through loop.ko and into the hypervisor 
filesystem where the loop's backing file lives as being in a "cache" of 
sorts---especially for non-DIO loopdevs hitting the pagecache.

Thus, ext4 critically expects that all IOs preceding a flush will hit 
persistent storage before all future IOs.  Failing that, journal replay 
cannot return the filesystem to a consistent state without a `fsck`.  

(Note that ext4 is just an example, really any journaled filesystem is at 
risk.)

Lets say a virtual machine uses a loopback file for a disk and the VM 
issues the following to delete some file called "/b":

  unlink("/b"):
	write: journal commit: unlink /b
	flush: blkdev_issue_flush()
	write: update fs datastructures (remove /b from a dentry)
	<hypervisor snapshot>

If the flush happens out of order then an operation like unlink("/b")  
could look like this where the guest VM's filesystem is on the left and 
the hypervisor's loop filesystem operations are on the right:

  VM ext4 filesystem            |  Hypervisor loop dev ordering
--------------------------------+--------------------------------
write: journal commit: unlink /b
flush: blkdev_issue_flush()
write: update fs dentry's
                                queued to loop: [journal commit: unlink /b]
                                queued to loop: [update fs dentry's]
                                flush: vfs_fsync() - out of order
                                queued to ext4: [journal commit: unlink /b]
                                queued to ext4: [update fs dentry's]
                                write lands: [update fs dentry's]
                                <snapshot!>
                                write lands: [journal commit: unlink /b]
				
Notice that the last two "write lands" are out of order because the 
vfs_fsync() does not separate them as expected by the VM's ext4 
implementation.

Presently, loop.c will never re-order actual WRITE's: they will be 
submitted to loopdev's `file*` handle in-submit-order because the 
workqueue will keep them ordered.  This is good[*].

But, REQ_FLUSH is not a write:

The vfs_fsync() in lo_req_flush() is _not_ ordered by the writequeue, and 
there exists no mechanism in loop.c to enforce completion of IOs submitted 
to the loopdev's `file*` handle prior to completing the vfs_fsync(), nor 
are subsequent IOs thereby required to complete after the flush.

Thus, the hypervisor's snapshot-capable filesystem can re-order the last 
two writes because the flush happened early.

In the re-ordered case on the hypervisor side:

  If a snapshot happens after the dentry removal but _before_ the journal 
  commit, then a journal replay of the resulting snapshot will be 
  inconsistent.

Flush re-ordering creates an inconsistency in two possible cases:

   a. In the snapshot after dentry removal but before journal commit.
   b. Crash after dentry removal but before journal comit.

Really a snapshot looks like a crash to the filesystem, so (a) and (b) are 
equivalent but (a) is easier to reason about. In either case, mounting the 
out-of-order filesystem (snapshot if (a), origin if (b)) will present 
kernel errors in the VM when the dentry is read:

	kernel: EXT4-fs error (device dm-2): ext4_lookup:1441: inode 
	 #1196093: comm rsync: deleted inode referenced: 1188710
	[ https://listman.redhat.com/archives/dm-devel/2016-September/028121.html ]


Fixing flush ordering provides for two possible improvements:
  ([*] from above about write ordering)

1. Consistency, as above.

2. Performance.  Right now loopdev IOs are serialized by a single write 
   queue per loopdev.  Parallel work queues could be used to submit IOs in 
   parallel to the filesystem serving the loopdev's `file*` handle since 
   VMs may submit IOs from different CPU cores.  Special care would need 
   to be taken for the following cases:

     a. Ordering of dependent IOs (ie, reads or writes of preceding 
        writes).
     b. Flushes need to wait for all workqueues to quiesce.

   W.r.t choosing the number of WQ's: Certainly not 1:1 CPU to workqueue 
   mapping because of the old WQ issue running out of pid's with lots of 
   CPUs, but here are some possibilities:

     a. 1:1 per socket
     b. User configurable as a module parameter
     c. Dedicated pool of workqueues for all loop devs that dispatch 
        queued IOs to the correct `file*` handle.  RCU might be useful.


What next?

Ok, so assuming consistency is an issue, #1 is the priority and #2 is 
nice-to-have.  This might be the right time for to consider these since 
there is so much discussion about loop.c on the list right now.

According to my understanding of the research above this appears to be an 
issue and there are other kernel developers who know this code better than I.  

I want to know if this is correct:

Should others be CC'ed on this topic?  If so, who?


--
Eric Wheeler



> 
> 
> Thanks,
> Ming
> 
> 
