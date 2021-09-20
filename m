Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBD01C433EF
	for <linux-block@archiver.kernel.org>; Mon, 20 Sep 2021 06:40:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF68360F56
	for <linux-block@archiver.kernel.org>; Mon, 20 Sep 2021 06:40:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232465AbhITGl5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Sep 2021 02:41:57 -0400
Received: from verein.lst.de ([213.95.11.211]:50289 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232430AbhITGl5 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Sep 2021 02:41:57 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id E671767373; Mon, 20 Sep 2021 08:40:28 +0200 (CEST)
Date:   Mon, 20 Sep 2021 08:40:28 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     axboe@kernel.dk, Christoph Hellwig <hch@lst.de>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] block: genhd: fix double kfree() in __alloc_disk_node()
Message-ID: <20210920064028.GB26999@lst.de>
References: <0000000000004a5adf05cc593ca9@google.com> <41766564-08cb-e7f2-4cb2-9ad102f21324@I-love.SAKURA.ne.jp> <3999c511-cd27-1554-d3a6-4288c3eca298@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3999c511-cd27-1554-d3a6-4288c3eca298@i-love.sakura.ne.jp>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Sep 19, 2021 at 11:44:29PM +0900, Tetsuo Handa wrote:
> syzbot is reporting use-after-free read at bdev_free_inode() [1], for
> kfree() from __alloc_disk_node() is called before bdev_free_inode()
> (which is called after RCU grace period) reads bdev->bd_disk and calls
> kfree(bdev->bd_disk).
> 
> Fix use-after-free read followed by double kfree() problem
> by explicitly resetting bdev->bd_disk to NULL before calling iput().
> 
> Link: https://syzkaller.appspot.com/bug?extid=8281086e8a6fbfbd952a [1]
> Reported-by: syzbot <syzbot+8281086e8a6fbfbd952a@syzkaller.appspotmail.com>
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> ---
> This patch is not tested due to lack of reproducer. Is this fix correct?
> 
>  block/bdev.c  | 1 +
>  block/genhd.c | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/block/bdev.c b/block/bdev.c
> index cf2780cb44a7..f6b8bac83bd8 100644
> --- a/block/bdev.c
> +++ b/block/bdev.c
> @@ -495,6 +495,7 @@ struct block_device *bdev_alloc(struct gendisk *disk, u8 partno)
>  	bdev->bd_inode = inode;
>  	bdev->bd_stats = alloc_percpu(struct disk_stats);
>  	if (!bdev->bd_stats) {
> +		bdev->bd_disk = NULL;
>  		iput(inode);
>  		return NULL;
>  	}

I was going to suggest to just move the bd_disk initialization after
the bd_stats allocations,  but iseems like we currently don't even
the zero the bdev on allocation.  So I suspect we should do that first
to avoid nasty surprises.
