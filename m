Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D6D4C433DB
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 18:20:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65A39601FB
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 18:20:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238506AbhBBSTt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Feb 2021 13:19:49 -0500
Received: from mx2.suse.de ([195.135.220.15]:58352 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238339AbhBBSSU (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 2 Feb 2021 13:18:20 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5D36AAD29;
        Tue,  2 Feb 2021 18:17:39 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 2E3141E14C3; Tue,  2 Feb 2021 19:17:39 +0100 (CET)
Date:   Tue, 2 Feb 2021 19:17:39 +0100
From:   Jan Kara <jack@suse.cz>
To:     "Gong, Sishuai" <sishuai@purdue.edu>
Cc:     "axboe@kernel.dk" <axboe@kernel.dk>, "hch@lst.de" <hch@lst.de>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: PROBLEM: potential concurrency bug between do_vfs_ioctl() and
 do_readv()
Message-ID: <20210202181739.GA21224@quack2.suse.cz>
References: <ED916641-1E2F-4256-9F4B-F3DEAEBE17E7@purdue.edu>
 <EB9B1A40-87F9-44ED-AED0-80167DC9E2E2@purdue.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <EB9B1A40-87F9-44ED-AED0-80167DC9E2E2@purdue.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue 26-01-21 02:18:03, Gong, Sishuai wrote:
> Hello,
> 
> We have found out why this bug happens. When a kernel thread is executing
> loop_clr_fd(), it will release the loop_ctl_mutex lock for a short period
> of time, before calling __loop_clr_fd(). However, another kernel thread
> may take use of this small gap, open the loop device, read it and cause a
> BLK_STS_IOERR eventually. This bug may lead to error messages on the
> kernel console, as mentioned in the previous email.
> 
> The following interleavings of this bug is shown below:
> 
> Thread 1				Thread 2
> // Execute loop_clr_fd()
> lo->lo_state = Lo_rundown
> mutex_unlock(&loop_ctl_mutex);
> 					// Execute lo_open()
> 					err = mutex_lock_killable(&loop_ctl_mutex);
> 					…
> 					lo = bdev->bd_disk->private_data;
> 					// lo_open return a success
> 					// User makes a ksys_read() request
> 					// loop_queue_rq()
> 					if (lo->lo_state != Lo_bound)
> 										return BLK_STS_IOERR;
> // Execute __loop_clr_fd()
> mutex_lock(&loop_ctl_mutex);
> ...

So you are right a race like this can happen. However generally it is
expected that you will see IO errors when you run loop_clr_fd() while there
may be other processes submitting IO. The particular scenario you've shown
above could possibly be handled by more careful checking in lo_open() but if
we just slightly modify it like:

Thread 1				Thread 2
					// Execute lo_open()
					err = mutex_lock_killable(&loop_ctl_mutex);
					…
					lo = bdev->bd_disk->private_data;
					// lo_open return a success
// Execute loop_clr_fd()
lo->lo_state = Lo_rundown
mutex_unlock(&loop_ctl_mutex);
					// User makes a ksys_read() request
					// loop_queue_rq()
					if (lo->lo_state != Lo_bound)
// Execute __loop_clr_fd()
mutex_lock(&loop_ctl_mutex);

Then it's kind of obvious that no checking in lo_open() can prevent IO
errors when loop device is being torn down. So to summarize the error
messages are expected when loop device is torn down while IO is in
progress...

								Honza


> > On Sep 28, 2020, at 10:44 AM, Gong, Sishuai <sishuai@purdue.edu> wrote:
> > 
> > Hi,
> > 
> > We found a potential concurrency bug in linux kernel 5.3.11. We are able to reproduce this bug in x86 under specific thread interleavings. This bug causes a blk_update_request I/O error.
> > 
> > ------------------------------------------
> > Kernel console output
> > blk_update_request: I/O error, dev loop0, sector 0 op 0x0:(READ) flags 0x80700 phys_seg 1 prio class 0
> > 
> > ------------------------------------------
> > Test input
> > This bug occurs when kernel functions do_vfs_ioctl() and do_readv() are executed with certain parameters in two separate threads and run concurrently.
> > 
> > The test program is generated in Syzkaller’s format as follows:
> > Test 1 [run in thread 1]
> > syz_read_part_table(0x0, 0x1, &(0x7f00000006c0)=[{0x0, 0x0, 0x100}])
> > Test 2 [run in thread 2]
> > r0 = syz_open_dev$loop(&(0x7f0000000000)='/dev/loop#\x00', 0x0, 0x0)
> > readv(r0, &(0x7f0000000340)=[{&(0x7f0000000440)=""/4096, 0x1000}], 0x1)
> > 
> > ------------------------------------------
> > Interleaving
> > Thread 1													Thread 2
> > 														do_readv()
> > 														-vfs_readv()
> > 														--do_iter_read()
> > 														---do_iter_readv_writev()
> > 														----blkdev_read_iter()
> > do_vfs_ioctl()						
> > --vfs_ioctl()	
> > --blkdev_ioctl()
> > ---blkdev_driver_ioctl()				
> > ----loop_set_fd()
> > -----bd_set_size()
> > 															(fs/blk_dev.c:1999)
> > 															loff_t size = i_size_read(bd_inode);
> > 															loff_t pos = iocb->ki_pos;
> > 															if (pos >= size)
> > 																return 0;
> > 															size -= pos;
> > 
> > 														----generic_file_read_iter()
> > 															(mm/filemap.c:2069)	
> > 															page = find_get_page(mapping, index);
> > 							  								if (!page) {
> > 																if (iocb->ki_flags & IOCB_NOWAIT)
> > 																	goto would_block;
> > 															page_cache_sync_readahead(mapping,
> > 
> > 															-----page_cache_sync_readahead()
> > 															------ondemand_readahead()
> > 															…
> > 															-----------...blk_update_request()
> > 															(error)
> > -----loop_sysfs_init()
> > …
> > 
> > ------------------------------------------
> > Analysis
> > We observed that when thread 2 is executed alone without thread 1, i_size_read() at fs/blk_dev.c:1999 returns a size of 0, thus in sequential mode blkdev_read_iter() returns directly at “return 0;” However, when two threads are executed concurrently, thread 1 changes the size of the same inode that thread 2 is concurrently accessing, then thread 2 goes into a different path, eventually causing the blk_update_request I/O error.
> > 
> > 
> > Thanks,
> > Sishuai
> > 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
