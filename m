Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38322 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751688AbeDISil (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 9 Apr 2018 14:38:41 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2D0DF76FBA
        for <linux-block@vger.kernel.org>; Mon,  9 Apr 2018 18:38:41 +0000 (UTC)
Date: Mon, 9 Apr 2018 14:38:36 -0400
From: Mike Snitzer <snitzer@redhat.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: dm-devel@redhat.com, linux-block@vger.kernel.org
Subject: Re: limits->max_sectors is getting set to 0, why/where? [was: Re:
 dm: kernel oops by divide error on v4.16+]
Message-ID: <20180409183836.GA11256@redhat.com>
References: <20180408040005.GA19128@ming.t460p>
 <20180409155120.GA10990@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180409155120.GA10990@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Apr 09 2018 at 11:51am -0400,
Mike Snitzer <snitzer@redhat.com> wrote:

> On Sun, Apr 08 2018 at 12:00am -0400,
> Ming Lei <ming.lei@redhat.com> wrote:
> 
> > Hi,
> > 
> > The following kernel oops(divide error) is triggered when running
> > xfstest(generic/347) on ext4.
> > 
> > [  442.632954] run fstests generic/347 at 2018-04-07 18:06:44
> > [  443.839480] divide error: 0000 [#1] PREEMPT SMP PTI
> > [  443.840201] Dumping ftrace buffer:
> > [  443.840692]    (ftrace buffer empty)
...
> > [  443.845756] CPU: 1 PID: 29607 Comm: dmsetup Not tainted 4.16.0_f605ba97fb80_master+ #1
> > [  443.846968] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.10.2-2.fc27 04/01/2014
> > [  443.848147] RIP: 0010:pool_io_hints+0x77/0x153 [dm_thin_pool]

...

> I was able to reproduce (in my case RIP was pool_io_hints+0x45)
> 
> Which on my kernel, is:
> 
> crash> dis -l pool_io_hints+0x45
> /root/snitm/git/linux/drivers/md/dm-thin.c: 2748
> 0xffffffffc0765165 <pool_io_hints+69>:  div    %rdi
> 
> Which is drivers/md/dm-thin.c:is_factor()'s return
> !sector_div(block_size, n);
> 
> SO looking at pool_io_hints() it would seem limits->max_sectors is 0 for
> this xfstests device... why would that be!?
> 
> Clearly pool_io_hints() could stand to be more defensive with a
> !limits->max_sectors negative check but is it ever really valid for
> max_sectors to be 0?
> 
> Pretty sure the ultimate bug is outside DM (but not seeing an obvious
> place where block core would set max_sectors to 0, all blk-settings.c
> uses min_not_zero(), etc).

I successfully ran this test against the linux-dm.git
"for-4.17/dm-changes" tag that Linus merged after the block changes:
 git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-4.17/dm-changes

# ./check tests/generic/347
FSTYP         -- ext4
PLATFORM      -- Linux/x86_64 thegoat 4.16.0-rc5.snitm
MKFS_OPTIONS  -- /dev/mapper/test-xfstests_scratch
MOUNT_OPTIONS -- -o acl,user_xattr /dev/mapper/test-xfstests_scratch /scratch

generic/347      65s
Ran: generic/347
Passed all 1 tests

SO this would seem to implicate some regression in the 4.17 block layer
changes.
