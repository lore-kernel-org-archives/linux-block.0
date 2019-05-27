Return-Path: <SRS0=U0+/=T3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FBE0C04AB3
	for <linux-block@archiver.kernel.org>; Mon, 27 May 2019 12:29:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2042B20859
	for <linux-block@archiver.kernel.org>; Mon, 27 May 2019 12:29:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726371AbfE0M3R (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 May 2019 08:29:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:48712 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726071AbfE0M3R (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 May 2019 08:29:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2F2EAAE14;
        Mon, 27 May 2019 12:29:15 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 5D6B21E3C2F; Mon, 27 May 2019 14:29:15 +0200 (CEST)
Date:   Mon, 27 May 2019 14:29:15 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Jan Kara <jack@suse.cz>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] loop: Don't change loop device under exclusive opener
Message-ID: <20190527122915.GB9998@quack2.suse.cz>
References: <20190516140127.23272-1-jack@suse.cz>
 <50edd0fa-9cfa-38e1-8870-0fbc5c618522@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50edd0fa-9cfa-38e1-8870-0fbc5c618522@kernel.dk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu 16-05-19 14:44:07, Jens Axboe wrote:
> On 5/16/19 8:01 AM, Jan Kara wrote:
> > Loop module allows calling LOOP_SET_FD while there are other openers of
> > the loop device. Even exclusive ones. This can lead to weird
> > consequences such as kernel deadlocks like:
> > 
> > mount_bdev()				lo_ioctl()
> >   udf_fill_super()
> >     udf_load_vrs()
> >       sb_set_blocksize() - sets desired block size B
> >       udf_tread()
> >         sb_bread()
> >           __bread_gfp(bdev, block, B)
> > 					  loop_set_fd()
> > 					    set_blocksize()
> >             - now __getblk_slow() indefinitely loops because B != bdev
> >               block size
> > 
> > Fix the problem by disallowing LOOP_SET_FD ioctl when there are
> > exclusive openers of a loop device.
> > 
> > [Deliberately chosen not to CC stable as a user with priviledges to
> > trigger this race has other means of taking the system down and this
> > has a potential of breaking some weird userspace setup]
> > 
> > Reported-and-tested-by: syzbot+10007d66ca02b08f0e60@syzkaller.appspotmail.com
> > Signed-off-by: Jan Kara <jack@suse.cz>
> > ---
> >  drivers/block/loop.c | 18 +++++++++++++++++-
> >  1 file changed, 17 insertions(+), 1 deletion(-)
> > 
> > Hi Jens!
> > 
> > What do you think about this patch? It fixes the problem but it also
> > changes user visible behavior so there are chances it breaks some
> > existing setup (although I have hard time coming up with a realistic
> > scenario where it would matter).
> 
> I also have a hard time thinking about valid cases where this would be a
> problem. I think, in the end, that fixing the issue is more important
> than a potentially hypothetical use case.
> 
> > Alternatively we could change getblk() code handle changing block
> > size. That would fix the particular issue syzkaller found as well but
> > I'm not sure what else is broken when block device changes while fs
> > driver is working with it.
> 
> I think your solution here is saner.

Will you pick up the patch please? I cannot find it in your tree... Thanks!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
