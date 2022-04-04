Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CECBBC433EF
	for <linux-block@archiver.kernel.org>; Mon,  4 Apr 2022 04:58:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357939AbiDDFAG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Apr 2022 01:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355325AbiDDFAE (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Apr 2022 01:00:04 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A88553467E;
        Sun,  3 Apr 2022 21:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/kQQ0Ce7ItIErUl8b3zHGRYCU91340rT8tmKbUdZKfw=; b=o6W5oX625kH8ElQ1YX6J8UrwOu
        iE3+LtgmO9Fa0TeNxVHxjvArv8vDqmcueVgsD8lIEofbMaJUm0RU4e7qlK479ce91yqTZBAiToYAh
        YCALe9Fle+/VIlLATcZozKq+8xgG8qSUKhUdkPEj+NdCy96pnCejiXwuwRIwnInY8VPudEltFRzrr
        2+3MGuhe/cJ2mCoKW1yxZrbLuBRQ6CCpHB2ESjVnaRqCePxh9PIO0SGDJn7tGKYoJwGwXrw/qjV9B
        swOVEgDOKQT4+GQP4x1kg/BBznmgKL8tQ6qle8ZRNU9slFQlARp4bPAA7vgJHxYeD+Pux1zc/DNrI
        rTiGHRzg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nbEn0-00D7g3-HQ; Mon, 04 Apr 2022 04:58:06 +0000
Date:   Sun, 3 Apr 2022 21:58:06 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     syzbot <syzbot+4f1a237abaf14719db49@syzkaller.appspotmail.com>,
        axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        Jan Kara <jack@suse.cz>
Subject: Re: [syzbot] INFO: task can't die in blkdev_common_ioctl
Message-ID: <Ykp63pk7aSj/bNRT@infradead.org>
References: <0000000000007a4a2d05dba6baa6@google.com>
 <d3213c1a-f82a-02f6-b5b2-0d3242e0242a@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d3213c1a-f82a-02f6-b5b2-0d3242e0242a@I-love.SAKURA.ne.jp>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Apr 02, 2022 at 08:26:23PM +0900, Tetsuo Handa wrote:
> > git tree:       linux-next
> > console output: https://syzkaller.appspot.com/x/log.txt?x=168d578db00000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=be9183de0824e4d7
> > dashboard link: https://syzkaller.appspot.com/bug?extid=4f1a237abaf14719db49
> > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> > 
> > Unfortunately, I don't have any reproducer for this issue yet.
> 
> This is a known problem, and Christoph does not like a mitigation patch.
> https://lkml.kernel.org/r/YgoQBTzb3b0l1SzP@infradead.org

And this report shows why: your patch makes the lock acquisition in
blkdev_fallocate killable.  Which would not help with this problem at
all, as it does not come through blkdev_fallocate.  The problem is that
the loop writing actual zeroes to the disk can take forever, and we
hold the invalidate_lock over that.
