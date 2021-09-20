Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ACC5C433EF
	for <linux-block@archiver.kernel.org>; Mon, 20 Sep 2021 12:28:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63C8B60F58
	for <linux-block@archiver.kernel.org>; Mon, 20 Sep 2021 12:28:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238095AbhITMaR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Sep 2021 08:30:17 -0400
Received: from verein.lst.de ([213.95.11.211]:51189 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233543AbhITMaR (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Sep 2021 08:30:17 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id C5A8268AFE; Mon, 20 Sep 2021 14:28:46 +0200 (CEST)
Date:   Mon, 20 Sep 2021 14:28:46 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        syzbot <syzbot+d6c75f383e01426a40b4@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com, Waiman Long <llong@redhat.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, hch@lst.de
Subject: Re: [syzbot] WARNING in __init_work
Message-ID: <20210920122846.GA16661@lst.de>
References: <000000000000423e0a05cc0ba2c4@google.com> <20210915161457.95ad5c9470efc70196d48410@linux-foundation.org> <163175937144.763609.2073508754264771910@swboyd.mtv.corp.google.com> <87sfy07n69.ffs@tglx> <20210920040336.GV2361455@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210920040336.GV2361455@dread.disaster.area>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Sep 20, 2021 at 02:03:36PM +1000, Dave Chinner wrote:
> > >> >  bdi_remove_from_list mm/backing-dev.c:938 [inline]
> > >> >  bdi_unregister+0x177/0x5a0 mm/backing-dev.c:946
> > >> >  release_bdi+0xa1/0xc0 mm/backing-dev.c:968
> > >> >  kref_put include/linux/kref.h:65 [inline]
> > >> >  bdi_put+0x72/0xa0 mm/backing-dev.c:976
> > >> >  bdev_free_inode+0x116/0x220 fs/block_dev.c:819
> > >> >  i_callback+0x3f/0x70 fs/inode.c:224
> > 
> > The inode code uses RCU for freeing an inode object which then ends up
> > calling bdi_put() and subsequently in synchronize_rcu_expedited().
> 
> Commit 889c05cc5834 ("block: ensure the bdi is freed after
> inode_detach_wb") might be a good place to start looking here. It
> moved the release of the bdi from ->evict context to the RCU freeing
> of the blockdev inode...

Well, the block code already does a bdi_unregister in del_gendisk.
So if we end up freeing the whole device bdev with a registered bdi
something is badly going wrong.  Unfortunately the log in this report
isn't much help on how we got there.  IIRC syzbot will eventually spew
out a reproducer, so it might be worth to wait for that.
