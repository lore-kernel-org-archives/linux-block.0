Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65DD5C433F5
	for <linux-block@archiver.kernel.org>; Mon, 20 Dec 2021 19:16:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237449AbhLTTQh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Dec 2021 14:16:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234420AbhLTTQe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Dec 2021 14:16:34 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD984C061574
        for <linux-block@vger.kernel.org>; Mon, 20 Dec 2021 11:16:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=a7TrgPHHAzy4HbjawWSIf5gw2wlAamW95KFkfuF/gn8=; b=BJwdhjZORXaX/Aa3ewMdrpjA/8
        br9qwsXRWIkTyCxR5drwuXm7xb7kA/qXIY68Me/tOg8QcPRxiJvcQdCWd+XJ7e4Jfon+tLWCJLhLB
        3bw2frT3lajldyd7K2RU5EUCDS8s+UqZekyA/mS7bGaeSlWeMQk1aKwmLbsi/SO/S/p4YM/c+PYtC
        gk4R6uLBsga7L9R9AdsZecxhEDXPNo7Xl/VmmGkjpGg+urGa7aARemF2GQvxJHNH4YkB14SVRdS+L
        1XcaCqc/1Y/HuqEx0eViSOvnla3jSNV5eo60c/1Rh34uZp2xtkKPs9GnrFyGHUwlh/oV9V590Ut1Q
        sLLG/Y2Q==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mzO98-0042VJ-9i; Mon, 20 Dec 2021 19:16:30 +0000
Date:   Mon, 20 Dec 2021 11:16:30 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>
Subject: Re: [PATCH] block: fix error handling for device_add_disk
Message-ID: <YcDWjrTgNG8/vkmJ@bombadil.infradead.org>
References: <c614deb3-ce75-635e-a311-4f4fc7aa26e3@i-love.sakura.ne.jp>
 <20211216161806.GA31879@lst.de>
 <20211216161928.GB31879@lst.de>
 <c3e48497-480b-79e8-b483-b50667eb9bbf@i-love.sakura.ne.jp>
 <Yb+Pbz1pCNEs4xw3@bombadil.infradead.org>
 <11adfb69-9ce6-c1f6-7b0d-c435e1856412@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11adfb69-9ce6-c1f6-7b0d-c435e1856412@i-love.sakura.ne.jp>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Dec 20, 2021 at 05:23:08PM +0900, Tetsuo Handa wrote:
> On 2021/12/20 5:00, Luis Chamberlain wrote:
> > On Fri, Dec 17, 2021 at 07:37:43PM +0900, Tetsuo Handa wrote:
> >> I think we can apply this patch as-is...
> > 
> > Unfortunately I don't think so, don't we end up still with a race
> > in between the first part of device_add() and the kobject_add()
> > which adds the kobject to generic layer and in return enables the
> > disk_release() call for the disk? I count 5 error paths in between
> > including kobject_add() which can fail as well.
> 
> I can't catch which path you are talking about.
> Will you explain more details using call trace (or line numbers in
> https://elixir.bootlin.com/linux/v5.16-rc6/source/block/genhd.c#L397 ) ?

I mean right after disk_alloc_events():

https://elixir.bootlin.com/linux/v5.16-rc6/source/block/genhd.c#L440

And right inside device_add()

https://elixir.bootlin.com/linux/v5.16-rc6/source/block/genhd.c#L452

Within device_add(), there are about 5 things which can
from the beginning of device_add() on line 3275 up to where
kobject_add() completes successfully in line 3329:

https://elixir.bootlin.com/linux/v5.16-rc6/source/drivers/base/core.c#L3275
https://elixir.bootlin.com/linux/v5.16-rc6/source/drivers/base/core.c#L3329

> > If correct then something like the following may be needed:
> > 
> > diff --git a/block/genhd.c b/block/genhd.c
> > index 3c139a1b6f04..08ab7ce63e57 100644
> > --- a/block/genhd.c
> > +++ b/block/genhd.c
> > @@ -539,9 +539,10 @@ int __must_check device_add_disk(struct device *parent, struct gendisk *disk,
> >  out_device_del:
> >  	device_del(ddev);
> >  out_disk_release_events:
> > -	disk_release_events(disk);
> > +	if (!kobject_alive(&ddev->kobj))
> > +		disk_release_events(disk);
> >  out_free_ext_minor:
> > -	if (disk->major == BLOCK_EXT_MAJOR)
> > +	if (!kobject_alive(&ddev->kobj) && disk->major == BLOCK_EXT_MAJOR)
> 
> How can kobject_alive() matter?

There are two hunks here. The first one I hope the above explains it.

As for the second one, the assumption is that if device_add() succeeded
the free_inode super op would do the respective blk_free_ext_minor()
however now I am not sure if this is true.

The kobject_alive() tells us if at least the device_add() had the
kobject_add() complete.

Since we have two hunks to consider I think we should be clear about
differentiating between both.

  Luis
