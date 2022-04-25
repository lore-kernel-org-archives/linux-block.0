Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5B75C433F5
	for <linux-block@archiver.kernel.org>; Mon, 25 Apr 2022 05:11:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235200AbiDYFOA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Apr 2022 01:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240462AbiDYFNz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Apr 2022 01:13:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F2FCB5
        for <linux-block@vger.kernel.org>; Sun, 24 Apr 2022 22:10:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 33C3161050
        for <linux-block@vger.kernel.org>; Mon, 25 Apr 2022 05:10:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47CB8C385A4;
        Mon, 25 Apr 2022 05:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1650863451;
        bh=ijx+1KXU+XKQgivlvclWhCkj86kRCgZkwoD21xMOhME=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JX7nvyjoGESVhJB8MNjdtYkoRrBqE/4/4LY+xRmC0OS2eFSbqXB+dAm+xZpIogNT9
         nD/bpVroHL1s4fiLEdvyV4jJ+tLjaIPH38tloxqO+D25YL1r7DSOD8QPSiZ33XGTRB
         5gK6Vbt8joPmQYiViJgsp4dJBN21ZrAzJ/jrnqho=
Date:   Mon, 25 Apr 2022 07:10:46 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Hannes Reinecke <hare@suse.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Dan Williams <dan.j.williams@intel.com>,
        yukuai <yukuai3@huawei.com>
Subject: Re: [PATCH V2 2/2] block: fix "Directory XXXXX with parent 'block'
 already present!"
Message-ID: <YmYtVnC3QzfukbSu@kroah.com>
References: <20220423143952.3162999-1-ming.lei@redhat.com>
 <20220423143952.3162999-3-ming.lei@redhat.com>
 <68e17ba8-24ec-5b60-d52e-18d41f91892c@suse.de>
 <YmUX/Q9o08rOSTaQ@T590>
 <682a215d-de50-40f1-b6f8-48801617bcad@suse.de>
 <YmU86/YZ18CtbLgb@T590>
 <YmVUl8m0Kak4JeKa@kroah.com>
 <YmX5O0dzHs09aFbh@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmX5O0dzHs09aFbh@T590>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Apr 25, 2022 at 09:28:27AM +0800, Ming Lei wrote:
> On Sun, Apr 24, 2022 at 03:45:59PM +0200, Greg Kroah-Hartman wrote:
> > On Sun, Apr 24, 2022 at 08:04:59PM +0800, Ming Lei wrote:
> > > On Sun, Apr 24, 2022 at 01:51:45PM +0200, Hannes Reinecke wrote:
> > > > On 4/24/22 11:28, Ming Lei wrote:
> > > > > On Sun, Apr 24, 2022 at 10:53:29AM +0200, Hannes Reinecke wrote:
> > > > > > On 4/23/22 16:39, Ming Lei wrote:
> > > > > > > q->debugfs_dir is used by blk-mq debugfs and blktrace. The dentry is
> > > > > > > created when adding disk, and removed when releasing request queue.
> > > > > > > 
> > > > > > > There is small window between releasing disk and releasing request
> > > > > > > queue, and during the period, one disk with same name may be created
> > > > > > > and added, so debugfs_create_dir() may complain with "Directory XXXXX
> > > > > > > with parent 'block' already present!"
> > > > > > > 
> > > > > > > Fixes the issue by moving debugfs_create_dir() into blk_alloc_queue(),
> > > > > > > and the dir name is named with q->id from beginning, and switched to
> > > > > > > disk name when adding disk, and finally changed to q->id in disk_release().
> > > > > > > 
> > > > > > > Tested-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> > > > > > > Reported-by: Dan Williams <dan.j.williams@intel.com>
> > > > > > > Cc: yukuai (C) <yukuai3@huawei.com>
> > > > > > > Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> > > > > > > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > > > > > > ---
> > > > > > >    block/blk-core.c  | 4 ++++
> > > > > > >    block/blk-sysfs.c | 4 ++--
> > > > > > >    block/genhd.c     | 8 ++++++++
> > > > > > >    3 files changed, 14 insertions(+), 2 deletions(-)
> > > > > > > 
> > > > > > Errm.
> > > > > > 
> > > > > > Isn't this superfluous now that Jens merged Yu Kuais patch?
> > > > > 
> > > > > Jens has dropped Yu Kuai's patch which caused kernel panic.
> > > > > 
> > > > Right.
> > > > But still, this patch looks really odd.
> > > > How is userspace supposed to use the directories prior to the renaming?
> > > 
> > > That doesn't make any difference for current uses, but we may extend it
> > > to support debugfs for non-blk request queue in future by exporting q->id
> > > somewhere. Even though now the interested q->id can be figured out
> > > easily by very simple ebpf trace prog.
> > > 
> > > > 
> > > > And as you already have identified the places where we can safely create
> > > > (and remove) the debugfs directories, why can't we move the call to create
> > > > and remove the debugfs directories to those locations and do away with the
> > > > renaming?
> > > 
> > > First it needs more change to fix the kernel panic.
> > > 
> > > Second removing debugfs dir in del_gendisk will break blktests block/002.
> > 
> > Then fix the test?  debugfs interactions that cause kernel bugs should
> > be ok to change the functionality of.  Remember, this is for
> > debugging...
> 
> But what is wrong with the test? Isn't it reasonable to keep debugfs dir
> when blktrace is collecting log?

How can you collect something from a device that is gone?

> After debugfs dir is removed, blktrace may not collect intact log, and
> people may complain it is one kernel regression.

What exactly breaks?  The device is removed, why should a trace continue
to give you data?

thanks,

greg k-h
