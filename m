Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC353C433EF
	for <linux-block@archiver.kernel.org>; Sun, 24 Apr 2022 12:05:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbiDXMIP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 24 Apr 2022 08:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiDXMIO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 24 Apr 2022 08:08:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C23F4E75
        for <linux-block@vger.kernel.org>; Sun, 24 Apr 2022 05:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650801911;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rgUE7aLScrqOUciS7yjLk1jCKvoNpSvP9M0TfuZR8cc=;
        b=QiomXWU2D5ZUZuVWCJJSGFvU/HMFmCaEMcum3XYtrrBLa0FN6ALWtyuDDqnk2pa3+gPgT5
        S6OkcfxFYW416AhgQ4kUw68UlDKqceoY/FnfMF9kGbUxvDfYvyaRxQxnb1o2opYTNHRLiP
        UP1U0QEdQstqXuzyAqPfBYt6uNcw4fw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-584-l8NSxJb0Mim9cxWNf9AOwg-1; Sun, 24 Apr 2022 08:05:10 -0400
X-MC-Unique: l8NSxJb0Mim9cxWNf9AOwg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CE88885A5A8;
        Sun, 24 Apr 2022 12:05:09 +0000 (UTC)
Received: from T590 (ovpn-8-21.pek2.redhat.com [10.72.8.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7764040D017E;
        Sun, 24 Apr 2022 12:05:04 +0000 (UTC)
Date:   Sun, 24 Apr 2022 20:04:59 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Dan Williams <dan.j.williams@intel.com>,
        yukuai <yukuai3@huawei.com>
Subject: Re: [PATCH V2 2/2] block: fix "Directory XXXXX with parent 'block'
 already present!"
Message-ID: <YmU86/YZ18CtbLgb@T590>
References: <20220423143952.3162999-1-ming.lei@redhat.com>
 <20220423143952.3162999-3-ming.lei@redhat.com>
 <68e17ba8-24ec-5b60-d52e-18d41f91892c@suse.de>
 <YmUX/Q9o08rOSTaQ@T590>
 <682a215d-de50-40f1-b6f8-48801617bcad@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <682a215d-de50-40f1-b6f8-48801617bcad@suse.de>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Apr 24, 2022 at 01:51:45PM +0200, Hannes Reinecke wrote:
> On 4/24/22 11:28, Ming Lei wrote:
> > On Sun, Apr 24, 2022 at 10:53:29AM +0200, Hannes Reinecke wrote:
> > > On 4/23/22 16:39, Ming Lei wrote:
> > > > q->debugfs_dir is used by blk-mq debugfs and blktrace. The dentry is
> > > > created when adding disk, and removed when releasing request queue.
> > > > 
> > > > There is small window between releasing disk and releasing request
> > > > queue, and during the period, one disk with same name may be created
> > > > and added, so debugfs_create_dir() may complain with "Directory XXXXX
> > > > with parent 'block' already present!"
> > > > 
> > > > Fixes the issue by moving debugfs_create_dir() into blk_alloc_queue(),
> > > > and the dir name is named with q->id from beginning, and switched to
> > > > disk name when adding disk, and finally changed to q->id in disk_release().
> > > > 
> > > > Tested-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> > > > Reported-by: Dan Williams <dan.j.williams@intel.com>
> > > > Cc: yukuai (C) <yukuai3@huawei.com>
> > > > Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> > > > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > > > ---
> > > >    block/blk-core.c  | 4 ++++
> > > >    block/blk-sysfs.c | 4 ++--
> > > >    block/genhd.c     | 8 ++++++++
> > > >    3 files changed, 14 insertions(+), 2 deletions(-)
> > > > 
> > > Errm.
> > > 
> > > Isn't this superfluous now that Jens merged Yu Kuais patch?
> > 
> > Jens has dropped Yu Kuai's patch which caused kernel panic.
> > 
> Right.
> But still, this patch looks really odd.
> How is userspace supposed to use the directories prior to the renaming?

That doesn't make any difference for current uses, but we may extend it
to support debugfs for non-blk request queue in future by exporting q->id
somewhere. Even though now the interested q->id can be figured out
easily by very simple ebpf trace prog.

> 
> And as you already have identified the places where we can safely create
> (and remove) the debugfs directories, why can't we move the call to create
> and remove the debugfs directories to those locations and do away with the
> renaming?

First it needs more change to fix the kernel panic.

Second removing debugfs dir in del_gendisk will break blktests block/002.

Finally this patch's approach is more flexible, since it provides chance to
export debugfs for request queue without disk attached, such as scsi queue
without disk attached, nvme admin queue, ...

Thanks,
Ming

