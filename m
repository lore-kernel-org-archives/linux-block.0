Return-Path: <SRS0=SzsG=WD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1286C433FF
	for <linux-block@archiver.kernel.org>; Wed,  7 Aug 2019 09:52:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD1F921BE6
	for <linux-block@archiver.kernel.org>; Wed,  7 Aug 2019 09:52:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729107AbfHGJwV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 7 Aug 2019 05:52:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:46136 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726902AbfHGJwV (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 7 Aug 2019 05:52:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 68BA0B0B6;
        Wed,  7 Aug 2019 09:52:19 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id EBD7B1E43FE; Wed,  7 Aug 2019 11:45:20 +0200 (CEST)
Date:   Wed, 7 Aug 2019 11:45:20 +0200
From:   Jan Kara <jack@suse.cz>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jan Kara <jack@suse.cz>, John Lenton <john.lenton@canonical.com>,
        Kai-Heng Feng <kaihengfeng@me.com>,
        Jens Axboe <axboe@kernel.dk>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-block@vger.kernel.org, jean-baptiste.lallement@canonical.com
Subject: Re: [PATCH] loop: Don't change loop device under exclusive opener
Message-ID: <20190807094520.GB14658@quack2.suse.cz>
References: <20190516140127.23272-1-jack@suse.cz>
 <50edd0fa-9cfa-38e1-8870-0fbc5c618522@kernel.dk>
 <20190527122915.GB9998@quack2.suse.cz>
 <b0f27980-be75-bded-3e74-bce14fc7ea47@kernel.dk>
 <894DDAA8-2ADD-467C-8E4F-4DE6B9A50625@me.com>
 <20190730092939.GB28829@quack2.suse.cz>
 <CAL1QPZQWDx2YEAP168C+Eb4g4DmGg8eOBoOqkbUOBKTMDc9gjg@mail.gmail.com>
 <20190730101646.GC28829@quack2.suse.cz>
 <20190730133607.GD28829@quack2.suse.cz>
 <43344436-99b5-f0a7-b71e-2bbb025dfd09@acm.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="nFreZHaLTZJo0R7j"
Content-Disposition: inline
In-Reply-To: <43344436-99b5-f0a7-b71e-2bbb025dfd09@acm.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon 05-08-19 09:41:39, Bart Van Assche wrote:
> On 7/30/19 6:36 AM, Jan Kara wrote:
> > On Tue 30-07-19 12:16:46, Jan Kara wrote:
> > > On Tue 30-07-19 10:36:59, John Lenton wrote:
> > > > On Tue, 30 Jul 2019 at 10:29, Jan Kara <jack@suse.cz> wrote:
> > > > > 
> > > > > Thanks for the notice and the references. What's your version of
> > > > > util-linux? What your test script does is indeed racy. You have there:
> > > > > 
> > > > > echo Running:
> > > > > for i in {a..z}{a..z}; do
> > > > >      mount $i.squash /mnt/$i &
> > > > > done
> > > > > 
> > > > > So all mount(8) commands will run in parallel and race to setup loop
> > > > > devices with LOOP_SET_FD and mount them. However util-linux (at least in
> > > > > the current version) seems to handle EBUSY from LOOP_SET_FD just fine and
> > > > > retries with the new loop device. So at this point I don't see why the patch
> > > > > makes difference... I guess I'll need to reproduce and see what's going on
> > > > > in detail.
> > > > 
> > > > We've observed this in arch with util-linux 2.34, and ubuntu 19.10
> > > > (eoan ermine) with util-linux 2.33.
> > > > 
> > > > just to be clear, the initial reports didn't involve a zany loop of
> > > > mounts, but were triggered by effectively the same thing as systemd
> > > > booted a system with a lot of snaps. The reroducer tries to makes
> > > > things simpler to reproduce :-). FWIW,  systemd versions were 244 and
> > > > 242 for those systems, respectively.
> > > 
> > > Thanks for info! So I think I see what's going on. The two mounts race
> > > like:
> > > 
> > > MOUNT1					MOUNT2
> > > num = ioctl(LOOP_CTL_GET_FREE)
> > > 					num = ioctl(LOOP_CTL_GET_FREE)
> > > ioctl("/dev/loop$num", LOOP_SET_FD, ..)
> > >   - returns OK
> > > 					ioctl("/dev/loop$num", LOOP_SET_FD, ..)
> > > 					  - acquires exclusine loop$num
> > > 					    reference
> > > mount("/dev/loop$num", ...)
> > >   - sees exclusive reference from MOUNT2 and fails
> > > 					  - sees loop device is already
> > > 					    bound and fails
> > > 
> > > It is a bug in the scheme I've chosen that racing LOOP_SET_FD can block
> > > perfectly valid mount. I'll think how to fix this...
> > 
> > So how about attached patch? It fixes the regression for me.
 
Hi Bart,

> A new kernel warning is triggered by blktests block/001 that did not happen
> without this patch. Reverting commit 89e524c04fa9 ("loop: Fix mount(2)
> failure due to race with LOOP_SET_FD") makes that kernel warning disappear.
> Is this reproducible on your setup?

Thanks for report! Hum, no, it seems the warning doesn't trigger in my test
VM. But reviewing the mentioned commit with fresh head, I can see where I
did a mistake during my conversion of blkdev_get(). Does attached patch fix
the warning for you?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

--nFreZHaLTZJo0R7j
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="0001-bdev-Fixup-error-handling-in-blkdev_get.patch"

From c4cd39244088d8de548264bc33dc9fb8f0f1db2d Mon Sep 17 00:00:00 2001
From: Jan Kara <jack@suse.cz>
Date: Wed, 7 Aug 2019 11:36:47 +0200
Subject: [PATCH] bdev: Fixup error handling in blkdev_get()

Commit 89e524c04fa9 ("loop: Fix mount(2) failure due to race with
LOOP_SET_FD") converted blkdev_get() to use the new helpers for
finishing claiming of a block device. However the conversion botched the
error handling in blkdev_get() and thus the bdev has been marked as held
even in case __blkdev_get() returned error. This led to occasional
warnings with block/001 test from blktests like:

kernel: WARNING: CPU: 5 PID: 907 at fs/block_dev.c:1899 __blkdev_put+0x396/0x3a0

Correct the error handling.

CC: stable@vger.kernel.org
Fixes: 89e524c04fa9 ("loop: Fix mount(2) failure due to race with LOOP_SET_FD")
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/block_dev.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index a6f7c892cb4a..7db181581606 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -1754,7 +1754,10 @@ int blkdev_get(struct block_device *bdev, fmode_t mode, void *holder)
 
 		/* finish claiming */
 		mutex_lock(&bdev->bd_mutex);
-		bd_finish_claiming(bdev, whole, holder);
+		if (!res)
+			bd_finish_claiming(bdev, whole, holder);
+		else
+			bd_abort_claiming(bdev, whole, holder);
 		/*
 		 * Block event polling for write claims if requested.  Any
 		 * write holder makes the write_holder state stick until
-- 
2.16.4


--nFreZHaLTZJo0R7j--
