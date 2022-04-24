Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE770C433F5
	for <linux-block@archiver.kernel.org>; Sun, 24 Apr 2022 13:46:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233530AbiDXNtI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 24 Apr 2022 09:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233019AbiDXNtH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 24 Apr 2022 09:49:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AB6438797
        for <linux-block@vger.kernel.org>; Sun, 24 Apr 2022 06:46:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3CFEBB80DD4
        for <linux-block@vger.kernel.org>; Sun, 24 Apr 2022 13:46:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 805CDC385A9;
        Sun, 24 Apr 2022 13:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1650807963;
        bh=gkOxDvsuCUaoNavhO9QanryWbRwesTmvdSxVwa4Mz+o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bz82gjCTrJw51k6I+qJONUpFMpbdxcmUPvtWkJfxT+EGE0wcSUQLWMW7y2xtns3p6
         mtbGLRQM9+idyp3rU2C3Ddw5sS+qyd/12Ntzn2TDUnmnqsBCCEs7uPu8jBZef0bqzV
         vMWTqufKQQVDyzUZ9XxamYKkfCobve4lA1dHeZA8=
Date:   Sun, 24 Apr 2022 15:45:59 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Hannes Reinecke <hare@suse.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Dan Williams <dan.j.williams@intel.com>,
        yukuai <yukuai3@huawei.com>
Subject: Re: [PATCH V2 2/2] block: fix "Directory XXXXX with parent 'block'
 already present!"
Message-ID: <YmVUl8m0Kak4JeKa@kroah.com>
References: <20220423143952.3162999-1-ming.lei@redhat.com>
 <20220423143952.3162999-3-ming.lei@redhat.com>
 <68e17ba8-24ec-5b60-d52e-18d41f91892c@suse.de>
 <YmUX/Q9o08rOSTaQ@T590>
 <682a215d-de50-40f1-b6f8-48801617bcad@suse.de>
 <YmU86/YZ18CtbLgb@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmU86/YZ18CtbLgb@T590>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Apr 24, 2022 at 08:04:59PM +0800, Ming Lei wrote:
> On Sun, Apr 24, 2022 at 01:51:45PM +0200, Hannes Reinecke wrote:
> > On 4/24/22 11:28, Ming Lei wrote:
> > > On Sun, Apr 24, 2022 at 10:53:29AM +0200, Hannes Reinecke wrote:
> > > > On 4/23/22 16:39, Ming Lei wrote:
> > > > > q->debugfs_dir is used by blk-mq debugfs and blktrace. The dentry is
> > > > > created when adding disk, and removed when releasing request queue.
> > > > > 
> > > > > There is small window between releasing disk and releasing request
> > > > > queue, and during the period, one disk with same name may be created
> > > > > and added, so debugfs_create_dir() may complain with "Directory XXXXX
> > > > > with parent 'block' already present!"
> > > > > 
> > > > > Fixes the issue by moving debugfs_create_dir() into blk_alloc_queue(),
> > > > > and the dir name is named with q->id from beginning, and switched to
> > > > > disk name when adding disk, and finally changed to q->id in disk_release().
> > > > > 
> > > > > Tested-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> > > > > Reported-by: Dan Williams <dan.j.williams@intel.com>
> > > > > Cc: yukuai (C) <yukuai3@huawei.com>
> > > > > Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> > > > > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > > > > ---
> > > > >    block/blk-core.c  | 4 ++++
> > > > >    block/blk-sysfs.c | 4 ++--
> > > > >    block/genhd.c     | 8 ++++++++
> > > > >    3 files changed, 14 insertions(+), 2 deletions(-)
> > > > > 
> > > > Errm.
> > > > 
> > > > Isn't this superfluous now that Jens merged Yu Kuais patch?
> > > 
> > > Jens has dropped Yu Kuai's patch which caused kernel panic.
> > > 
> > Right.
> > But still, this patch looks really odd.
> > How is userspace supposed to use the directories prior to the renaming?
> 
> That doesn't make any difference for current uses, but we may extend it
> to support debugfs for non-blk request queue in future by exporting q->id
> somewhere. Even though now the interested q->id can be figured out
> easily by very simple ebpf trace prog.
> 
> > 
> > And as you already have identified the places where we can safely create
> > (and remove) the debugfs directories, why can't we move the call to create
> > and remove the debugfs directories to those locations and do away with the
> > renaming?
> 
> First it needs more change to fix the kernel panic.
> 
> Second removing debugfs dir in del_gendisk will break blktests block/002.

Then fix the test?  debugfs interactions that cause kernel bugs should
be ok to change the functionality of.  Remember, this is for
debugging...

thanks,

greg k-h
