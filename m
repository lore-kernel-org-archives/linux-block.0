Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86793C4332F
	for <linux-block@archiver.kernel.org>; Thu, 16 Dec 2021 16:18:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239422AbhLPQSK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Dec 2021 11:18:10 -0500
Received: from verein.lst.de ([213.95.11.211]:33009 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239400AbhLPQSJ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Dec 2021 11:18:09 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7489C68AA6; Thu, 16 Dec 2021 17:18:06 +0100 (CET)
Date:   Thu, 16 Dec 2021 17:18:06 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-block <linux-block@vger.kernel.org>
Subject: Re: [PATCH] block: fix error handling for device_add_disk
Message-ID: <20211216161806.GA31879@lst.de>
References: <c614deb3-ce75-635e-a311-4f4fc7aa26e3@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c614deb3-ce75-635e-a311-4f4fc7aa26e3@i-love.sakura.ne.jp>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Dec 17, 2021 at 01:00:00AM +0900, Tetsuo Handa wrote:
> syzbot is reporting double kfree() bug in disk_release_events() [1], for
> commit 9be68dd7ac0e13be ("md: add error handling support for add_disk()")
> is calling blk_cleanup_disk() which will call disk_release_events() from
> regular kobject_release() path when device_add_disk() from add_disk()
> failed.
> 
> Since kobject_release() will be always called regardless of whether
> device_add_disk() from add_disk() succeeds, we should leave
> disk_release_events() to regular kobject_release() path.
> 
> Link: https://syzkaller.appspot.com/bug?extid=28a66a9fbc621c939000 [1]
> Reported-by: syzbot <syzbot+28a66a9fbc621c939000@syzkaller.appspotmail.com>
> Tested-by: syzbot <syzbot+28a66a9fbc621c939000@syzkaller.appspotmail.com>
> Fixes: 83cbce9574462c6b ("block: add error handling for device_add_disk / add_disk")
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> ---
>  block/genhd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block/genhd.c b/block/genhd.c
> index 30362aeacac4..47bb34ab967b 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -540,7 +540,7 @@ int __must_check device_add_disk(struct device *parent, struct gendisk *disk,
>  out_device_del:
>  	device_del(ddev);
>  out_disk_release_events:
> -	disk_release_events(disk);
> +	/* disk_release() will call disk_release_events(). */
>  out_free_ext_minor:
>  	if (disk->major == BLOCK_EXT_MAJOR)
>  		blk_free_ext_minor(disk->first_minor);

.. actually while you're at it - blk_free_ext_minor is also done
by bdev_free_inode called from disk_release.

So we can just remove the out_disk_release_events and out_free_ext_minor
labels entirely. 

> -- 
> 2.32.0
---end quoted text---
