Return-Path: <SRS0=ZBGg=V3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5E33C433FF
	for <linux-block@archiver.kernel.org>; Tue, 30 Jul 2019 09:29:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F60A20665
	for <linux-block@archiver.kernel.org>; Tue, 30 Jul 2019 09:29:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731287AbfG3J3m (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Jul 2019 05:29:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:60974 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727247AbfG3J3m (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Jul 2019 05:29:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 01B83B0DA;
        Tue, 30 Jul 2019 09:29:39 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 4F73E1E15D0; Tue, 30 Jul 2019 11:29:39 +0200 (CEST)
Date:   Tue, 30 Jul 2019 11:29:39 +0200
From:   Jan Kara <jack@suse.cz>
To:     Kai-Heng Feng <kaihengfeng@me.com>
Cc:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-block@vger.kernel.org,
        John Lenton <john.lenton@canonical.com>,
        jean-baptiste.lallement@canonical.com
Subject: Re: [PATCH] loop: Don't change loop device under exclusive opener
Message-ID: <20190730092939.GB28829@quack2.suse.cz>
References: <20190516140127.23272-1-jack@suse.cz>
 <50edd0fa-9cfa-38e1-8870-0fbc5c618522@kernel.dk>
 <20190527122915.GB9998@quack2.suse.cz>
 <b0f27980-be75-bded-3e74-bce14fc7ea47@kernel.dk>
 <894DDAA8-2ADD-467C-8E4F-4DE6B9A50625@me.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <894DDAA8-2ADD-467C-8E4F-4DE6B9A50625@me.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu 18-07-19 16:15:42, Kai-Heng Feng wrote:
> Hi Jan,
> 
> at 21:34, Jens Axboe <axboe@kernel.dk> wrote:
> 
> > On 5/27/19 6:29 AM, Jan Kara wrote:
> > > On Thu 16-05-19 14:44:07, Jens Axboe wrote:
> > > > On 5/16/19 8:01 AM, Jan Kara wrote:
> > > > > Loop module allows calling LOOP_SET_FD while there are other openers of
> > > > > the loop device. Even exclusive ones. This can lead to weird
> > > > > consequences such as kernel deadlocks like:
> > > > > 
> > > > > mount_bdev()				lo_ioctl()
> > > > >    udf_fill_super()
> > > > >      udf_load_vrs()
> > > > >        sb_set_blocksize() - sets desired block size B
> > > > >        udf_tread()
> > > > >          sb_bread()
> > > > >            __bread_gfp(bdev, block, B)
> > > > > 					  loop_set_fd()
> > > > > 					    set_blocksize()
> > > > >              - now __getblk_slow() indefinitely loops because B != bdev
> > > > >                block size
> > > > > 
> > > > > Fix the problem by disallowing LOOP_SET_FD ioctl when there are
> > > > > exclusive openers of a loop device.
> > > > > 
> > > > > [Deliberately chosen not to CC stable as a user with priviledges to
> > > > > trigger this race has other means of taking the system down and this
> > > > > has a potential of breaking some weird userspace setup]
> > > > > 
> > > > > Reported-and-tested-by:
> > > > > syzbot+10007d66ca02b08f0e60@syzkaller.appspotmail.com
> > > > > Signed-off-by: Jan Kara <jack@suse.cz>
> > > > > ---
> > > > >   drivers/block/loop.c | 18 +++++++++++++++++-
> > > > >   1 file changed, 17 insertions(+), 1 deletion(-)
> > > > > 
> > > > > Hi Jens!
> > > > > 
> > > > > What do you think about this patch? It fixes the problem but it also
> > > > > changes user visible behavior so there are chances it breaks some
> > > > > existing setup (although I have hard time coming up with a realistic
> > > > > scenario where it would matter).
> > > > 
> > > > I also have a hard time thinking about valid cases where this would be a
> > > > problem. I think, in the end, that fixing the issue is more important
> > > > than a potentially hypothetical use case.
> > > > 
> > > > > Alternatively we could change getblk() code handle changing block
> > > > > size. That would fix the particular issue syzkaller found as well but
> > > > > I'm not sure what else is broken when block device changes while fs
> > > > > driver is working with it.
> > > > 
> > > > I think your solution here is saner.
> > > 
> > > Will you pick up the patch please? I cannot find it in your tree...
> > > Thanks!
> > 
> > Done!
> 
> This patch introduced a regression [1].
> A reproducer can be found at [2].
> 
> [1] https://bugs.launchpad.net/bugs/1836914
> [2] https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1836914/comments/4

Thanks for the notice and the references. What's your version of
util-linux? What your test script does is indeed racy. You have there:

echo Running:
for i in {a..z}{a..z}; do
    mount $i.squash /mnt/$i &
done

So all mount(8) commands will run in parallel and race to setup loop
devices with LOOP_SET_FD and mount them. However util-linux (at least in
the current version) seems to handle EBUSY from LOOP_SET_FD just fine and
retries with the new loop device. So at this point I don't see why the patch
makes difference... I guess I'll need to reproduce and see what's going on
in detail.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
