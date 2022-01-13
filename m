Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1DC7C433F5
	for <linux-block@archiver.kernel.org>; Thu, 13 Jan 2022 10:44:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231667AbiAMKoa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Jan 2022 05:44:30 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:42296 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233028AbiAMKoa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Jan 2022 05:44:30 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id D70311F3A5;
        Thu, 13 Jan 2022 10:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1642070668; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TCgATi/m4azEbIHlxBaCRn3iRlbVFUXL15I0kom16+g=;
        b=z8sf9i8fwcwZImaKwCMLCsv1IqIJaeZafUMTvtQDkQH7gRZimzofw+6iDOhlbJIRgj24D0
        FjM0/OsIH8tYQy/AQOfllRO+9wwSyrfiGlA52l3PDfr//hVOUGjJSHV4WAoU1r2i1MqUj0
        TJnc41ONxHrhsTQUTrHnnxzWLvVZ4vQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1642070668;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TCgATi/m4azEbIHlxBaCRn3iRlbVFUXL15I0kom16+g=;
        b=roJq0srrCtTPqbbZass+jK44DQPJTSK9D0/ZkHJlQspVw8AOg94iumFgeV4fHO90EZnCu1
        xBtkjrEF6T3oDgAQ==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 56398A3B98;
        Thu, 13 Jan 2022 10:44:28 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id EC9D7A05E2; Thu, 13 Jan 2022 11:44:24 +0100 (CET)
Date:   Thu, 13 Jan 2022 11:44:24 +0100
From:   Jan Kara <jack@suse.cz>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Dan Schatzberg <schatzberg.dan@gmail.com>,
        kernel test robot <oliver.sang@intel.com>,
        Jan Stancek <jstancek@redhat.com>,
        linux-block <linux-block@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] loop: use task_work for autoclear operation
Message-ID: <20220113104424.u6fj3z2zd34ohthc@quack3.lan>
References: <969f764d-0e0f-6c64-de72-ecfee30bdcf7@I-love.SAKURA.ne.jp>
 <bcaf38e6-055e-0d83-fd1d-cb7c0c649372@I-love.SAKURA.ne.jp>
 <20220110103057.h775jv2br2xr2l5k@quack3.lan>
 <fc15d4a1-a9d2-1a26-71dc-827b0445d957@I-love.SAKURA.ne.jp>
 <20220110134234.qebxn5gghqupsc7t@quack3.lan>
 <d1ca4fa4-ac3e-1354-3d94-1bf55f2000a9@I-love.SAKURA.ne.jp>
 <20220112131615.qsdxx6r7xvnvlwgx@quack3.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220112131615.qsdxx6r7xvnvlwgx@quack3.lan>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed 12-01-22 14:16:15, Jan Kara wrote:
> On Tue 11-01-22 00:08:56, Tetsuo Handa wrote:
> > On 2022/01/10 22:42, Jan Kara wrote:
> > > a) We didn't fully establish a real deadlock scenario from the lockdep
> > > report, did we? The lockdep report involved suspend locks, some locks on
> > > accessing files in /proc etc. and it was not clear whether it all reflects
> > > a real deadlock possibility or just a fact that lockdep tracking is rather
> > > coarse-grained at times. Now lockdep report is unpleasant and loop device
> > > locking was ugly anyway so your async change made sense but once lockdep is
> > > silenced we should really establish whether there is real deadlock and more
> > > work is needed or not.
> > 
> > Not /proc files but /sys/power/resume file.
> > Here is a reproducer but I can't test whether we can trigger a real deadlock.
> > 
> > ----------------------------------------
> > #include <stdio.h>
> > #include <sys/types.h>
> > #include <sys/stat.h>
> > #include <fcntl.h>
> > #include <unistd.h>
> > #include <sys/ioctl.h>
> > #include <linux/loop.h>
> > #include <sys/sendfile.h>
> > 
> > int main(int argc, char *argv[])
> > {
> > 	const int file_fd = open("testfile", O_RDWR | O_CREAT, 0600);
> > 	ftruncate(file_fd, 1048576);
> > 	char filename[128] = { };
> > 	const int loop_num = ioctl(open("/dev/loop-control", 3), LOOP_CTL_GET_FREE, 0);
> > 	snprintf(filename, sizeof(filename) - 1, "/dev/loop%d", loop_num);
> > 	const int loop_fd_1 = open(filename, O_RDWR);
> > 	ioctl(loop_fd_1, LOOP_SET_FD, file_fd);
> > 	const int loop_fd_2 = open(filename, O_RDWR);
> > 	ioctl(loop_fd_1, LOOP_CLR_FD, 0);
> > 	const int sysfs_fd = open("/sys/power/resume", O_RDWR);
> > 	sendfile(file_fd, sysfs_fd, 0, 1048576);
> > 	sendfile(loop_fd_2, file_fd, 0, 1048576);
> > 	write(sysfs_fd, "700", 3);
> > 	close(loop_fd_2);
> > 	close(loop_fd_1); // Lockdep complains.
> > 	close(file_fd);
> > 	return 0;
> > }
> > ----------------------------------------
> 
> Thanks for the reproducer. I will try to simplify it even more and figure
> out whether there is a real deadlock potential in the lockdep complaint or
> not...

OK, so I think I understand the lockdep complaint better. Lockdep
essentially complains about the following scenario:

blkdev_put()
  lock disk->open_mutex
  lo_release
    __loop_clr_fd()
        |
        | wait for IO to complete
        v
loop worker
  write to backing file
    sb_start_write(file)
        |
        | wait for fs with backing file to unfreeze
        v
process holding fs frozen
  freeze_super()
        |
        | wait for remaining writers on the fs so that fs can be frozen
        v
sendfile()
  sb_start_write()
  do_splice_direct()
        |
        | blocked on read from /sys/power/resume, waiting for kernfs file
	| lock
        v
write() "/dev/loop0" (in whatever form) to /sys/power/resume
  calls blkdev_get_by_dev("/dev/loop0")
    lock disk->open_mutex => deadlock

So there are three other ingredients to this locking loop besides loop device
behavior:
1) sysfs files which serialize reads & writes
2) sendfile which holds freeze protection while reading data to write
3) "resume" file behavior opening bdev from write to sysfs file

We cannot sensibly do anything about 1) AFAICT. You cannot get a coherent
view of a sysfs file while it is changing.

We could actually change 2) (to only hold freeze protection while splicing
from pipe) but that will fix the problem only for sendfile(2). E.g.
splice(2) may also block waiting for data to become available in the pipe
while holding freeze protection. Changing that would require some surgery
in our splice infrastructure and at this point I'm not sure whether we
would not introduce other locking problems due to pipe_lock lock ordering.

For 3), we could consider stuff like not resuming from a loop device or
postponing resume to a workqueue but it all looks ugly.

Maybe the most disputable thing in this locking chain seems to be splicing
from sysfs files. That does not seem terribly useful and due to special
locking and behavior of sysfs files it allows for creating interesting lock
dependencies. OTOH maybe there is someone out there who (possibly
inadvertedly through some library) ends up using splice on sysfs files so
chances for userspace breakage, if we disable splice for sysfs, would be
non-negligible. Hum, tough.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
