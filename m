Return-Path: <SRS0=ireV=RX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CD8DC43381
	for <linux-block@archiver.kernel.org>; Wed, 20 Mar 2019 13:44:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 126792184D
	for <linux-block@archiver.kernel.org>; Wed, 20 Mar 2019 13:44:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbfCTNoC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Mar 2019 09:44:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:54916 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725905AbfCTNoC (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Mar 2019 09:44:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DB714AFE9;
        Wed, 20 Mar 2019 13:43:43 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 368F81E4255; Wed, 20 Mar 2019 14:43:43 +0100 (CET)
Date:   Wed, 20 Mar 2019 14:43:43 +0100
From:   Jan Kara <jack@suse.cz>
To:     Dongli Zhang <dongli.zhang@oracle.com>
Cc:     Jan Kara <jack@suse.cz>,
        syzbot <syzbot+9bdc1adc1c55e7fe765b@syzkaller.appspotmail.com>,
        axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        penguin-kernel@i-love.sakura.ne.jp
Subject: Re: general protection fault in loop_validate_file (2)
Message-ID: <20190320134343.GF9485@quack2.suse.cz>
References: <00000000000098bf7d05845616d7@google.com>
 <cb7aa6d1-6d1e-a9ac-239a-1b5d8160f8cd@oracle.com>
 <20190319094136.GE17334@quack2.suse.cz>
 <a6a6fda6-4911-69a1-9db1-97e3ec7cce99@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6a6fda6-4911-69a1-9db1-97e3ec7cce99@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed 20-03-19 12:21:29, Dongli Zhang wrote:
> On 3/19/19 5:41 PM, Jan Kara wrote:
> > On Mon 18-03-19 20:27:02, Dongli Zhang wrote:
> >> Hi Jan,
> >>
> >> Indeed there is another issue implicitly reported by below console output from
> >> syzkaller:
> >>
> >> [  245.524424][ T9455] loop_reread_partitions: partition scan of loop0 () failed
> >> (rc=-13)
> >> [  245.563340][ T9499] kasan: CONFIG_KASAN_INLINE enabled
> >> [  245.576412][ T9489] __loop_clr_fd: partition scan of loop0 failed (rc=-13)
> >> [  245.581275][ T9499] kasan: GPF could be caused by NULL-ptr deref or user
> >> memory access
> >> [  245.602596][ T9499] general protection fault: 0000 [#1] PREEMPT SMP KASAN
> >>
> >> I think rc=-13 is because of below code at line 168:
> >>
> >> 162 int __blkdev_reread_part(struct block_device *bdev)
> >> 163 {
> >> 164         struct gendisk *disk = bdev->bd_disk;
> >> 165
> >> 166         if (!disk_part_scan_enabled(disk) || bdev != bdev->bd_contains)
> >> 167                 return -EINVAL;
> >> 168         if (!capable(CAP_SYS_ADMIN))
> >> 169                 return -EACCES;
> >> 170
> >> 171         lockdep_assert_held(&bdev->bd_mutex);
> >> 172
> >> 173         return rescan_partitions(disk, bdev);
> >> 174 }
> >> 175 EXPORT_SYMBOL(__blkdev_reread_part);
> >>
> >> I can reproduce this by 'chown username /dev/loop0' on my test machine.
> >>
> >> Taking 'losetup -d /dev/loop0' as sample, as /dev/loop0 belongs to my username,
> >> I am able to detach the loop without 'su'.
> >>
> >> However, because of above line 168, the partition scan would fail.
> >>
> >> Should we always assume the user should have admin privilege to detach
> >> the loop and this is not a bug?
> > 
> > Firstly, __blkdev_reread_part() is used for all devices so we have to be
> > *very* careful when we relax the permission checks there.
> > 
> > Secondly, I'm not convinced it is always safe to allow non-priviledged user
> > to force repartitioning of a device. That exposes the whole partition table
> > parsing code to non-priviledged user and thus increases possible attack
> > surface.
> > 
> > But in this specific case we call __blkdev_reread_part() only to tear down
> > partitions. So in this specific case calling it by unpriviledged user is
> > fine plus leaving stale partitions behind is certainly not nice. What we
> > could do is:
> > 
> > Export drop_partitions() functionality as a function like
> > __blkdev_drop_part() that would call drop_partitions(bdev->bd_disk, bdev).
> > It would expect (and assert) that &bdev->bd_mutex is already locked. It
> > should probably also replicate the check:
> > 
> >         if (!disk_part_scan_enabled(disk) || bdev != bdev->bd_contains)
> >                 return -EINVAL;
> > 
> > from __blkdev_reread_part(). And we can call this from __loop_clr_fd().
> > 
> > Then we can just unexport __blkdev_reread_part() (since only loop.c is
> > using it) and fold it inside blkdev_reread_part().
> > 
> > What do you think?
> > 
> > 								Honza
> > 
> 
> The idea is to duplicate a new caller of drop_partitions() which is
> specifically used by loop. I think it works. It is safe as well as the
> functionality is limited within loop.
> 
> However, perhaps we should not regard this as a bug? Below is the sample
> to reproduce this issue:
> 
> $ dd if=/dev/zero of=tmp.raw bs=1M count=100 oflag=direct
> 
> $ parted tmp.raw --script mklabel msdos mkpart primary 0% 50% mkpart primary 50%
> 100%
> 
> $ sudo chown zhang /dev/loop0
> 
> $ losetup -P /dev/loop0 tmp.raw
> 
> $ ls -l /dev | grep loop0
> brw-rw---- 1 zhang disk      7,   0 Mar  20 11:42 loop0   --> user (zhang)
> brw-rw---- 1 root  disk    259,   0 Mar  20 11:42 loop0p1 --> root
> brw-rw---- 1 root  disk    259,   1 Mar  20 11:42 loop0p2 --> root
> 
> $ losetup -d /dev/loop
> 
> From above case, /dev/loop0 is owned by user (zhang), while the partitions are
> owned by root.
> 
> Should the detach of loop owned by user also unmaps all related partitions owned
> by root?
> 
> Perhaps we should assume the '-P' option is always used by root?

Yes, that's another option. And since I'm not aware of any user reports of
the problem you've found I'd just say that non-root users don't use loop
devices with partitions.

> This is similar to the fact that the administrator should always use '-P'
> in order to enforce partscan when the loop is detached. Otherwise, the
> partitions belong to the loop would remain after 'losetup -d'.

Yeah. That seems like another slight catch for the users. Honestly, I don't
feel either of these issues is serious enough that I'd go and fix them. But
if someone wanted to spend the time with them, I won't object :).

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
