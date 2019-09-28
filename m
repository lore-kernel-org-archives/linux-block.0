Return-Path: <SRS0=y3Aw=XX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D83A0C4360C
	for <linux-block@archiver.kernel.org>; Sat, 28 Sep 2019 02:40:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAA4F20869
	for <linux-block@archiver.kernel.org>; Sat, 28 Sep 2019 02:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569638433;
	bh=h2njq1vJkcfwtI+56dxihbhds6Qb1mamZ+2/Z87FA/c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dBsDH61S1DglLQl40JgSEfSzFmMWNzAanYTPKwQNzIg7FkVOntLn4/tUfZhKU2NNO
	 GMgQvoxAs5myfhQFdbL9UKwir/6WyXhd7p6g84IEJtcYNJBnOx7mo4xs2QyjecnW7J
	 NmqJNoO4gzO3NMp4HHNUcvDD0THCjpMDyE4uhvc4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725815AbfI1Ckc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 27 Sep 2019 22:40:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:34202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725306AbfI1Ckc (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 Sep 2019 22:40:32 -0400
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B58820869;
        Sat, 28 Sep 2019 02:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569638431;
        bh=h2njq1vJkcfwtI+56dxihbhds6Qb1mamZ+2/Z87FA/c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HTifdSFmwMqxAmAk6Y+efXUCTyVezDCuUudoFxFcl+UJI4QZTNOe3k4QgD6cxIVVj
         1RD8e2+dk1lR+DGy6qP/gV9Z4tCLIc1BPp0WIjAJEwNp9AZ/TeVcQAMZd2ZkeKpXVq
         kwoAJd8L+FVx+cQTFDcfpiWTRvtVY55mM2CumdvE=
Date:   Fri, 27 Sep 2019 19:40:29 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: WARNING in blk_mq_init_sched
Message-ID: <20190928024029.GB1079@sol.localdomain>
Mail-Followup-To: Damien Le Moal <Damien.LeMoal@wdc.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>,
        Ming Lei <ming.lei@redhat.com>
References: <0000000000007909bf059363878e@google.com>
 <BYAPR04MB5816244183004247FD3D1074E7870@BYAPR04MB5816.namprd04.prod.outlook.com>
 <BYAPR04MB58169DBC0647FE4C91338844E7870@BYAPR04MB5816.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR04MB58169DBC0647FE4C91338844E7870@BYAPR04MB5816.namprd04.prod.outlook.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Sep 25, 2019 at 10:13:30PM +0000, Damien Le Moal wrote:
> On 2019/09/25 10:56, Damien Le Moal wrote:
> > On 2019/09/25 9:56, syzbot wrote:
> >> Hello,
> >>
> >> syzbot found the following crash on:
> >>
> >> HEAD commit:    f7c3bf8f Merge tag 'gfs2-for-5.4' of git://git.kernel.org/..
> >> git tree:       upstream
> >> console output: https://syzkaller.appspot.com/x/log.txt?x=15f5baf9600000
> >> kernel config:  https://syzkaller.appspot.com/x/.config?x=50d4af03d68a470c
> >> dashboard link: https://syzkaller.appspot.com/bug?extid=b2c197f98f86543b69c8
> >> compiler:       clang version 9.0.0 (/home/glider/llvm/clang  
> >> 80fee25776c2fb61e74c1ecb1a523375c2500b69)
> >>
> >> Unfortunately, I don't have any reproducer for this crash yet.
> >>
> >> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> >> Reported-by: syzbot+b2c197f98f86543b69c8@syzkaller.appspotmail.com
> > 
> > Oh... When the queue is initialized and the elevator initialization done by
> > elevator_init_mq() is executed without the queue sysfs lock held. In that step,
> > if the elevator initialization fails, blk_mq_sched_free_requests() is called and
> > will trip on the lockdep_assert_held(&q->sysfs_lock) check on entry. I guess
> > that is what is causing the crash ? But I thought lockdep_assert_held() only
> > spits out warnings...
> > 
> > Ming,
> > 
> > Your patch c48dac137a62 ("block: don't hold q->sysfs_lock in elevator_init_mq")
> > removed the sysfs_lock use in elevator_init_mq(). With that, should we move the
> > lockdep_assert_held(&q->sysfs_lock) call out of blk_mq_sched_free_requests() and
> > directly call it lockdep before calling that function (that's ugly) or do you
> > see a nice trick for handling the special case that is the first initialization ?
> 
> Please ignore. It looks like the gfs2 tree tested does not have commit
> 954b4a5ce4a8 ("block: Change elevator_init_mq() to always succeed") which
> removes the possibility of having blk_mq_sched_free_requests() being called
> during the first elevator initialization without the sysfs lock being held.
> 
> So if the crash is indeed triggered by the lockdep_assert_held() call, then this
> problem will be fixed after a rebase on 5.4-rc1.
> 

No, as the report says, this occurred on commit f7c3bf8f.  Commit 954b4a5ce4a8
("block: Change elevator_init_mq() to always succeed") was already merged then.

- Eric
