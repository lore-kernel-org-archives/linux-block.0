Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8220DC433FE
	for <linux-block@archiver.kernel.org>; Tue, 26 Apr 2022 03:08:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242722AbiDZDL0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Apr 2022 23:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242595AbiDZDLZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Apr 2022 23:11:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 872556EB2E
        for <linux-block@vger.kernel.org>; Mon, 25 Apr 2022 20:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650942498;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Y5nY5MfTdK8kOF2lVHvtuzvo/2OzhksSwBML+M9Puro=;
        b=II23MhS4ZPPEGa2mKqG/W6JlKBHuGr7XKJHuWkejmFUXlsTuf2ebjegjKmVCfc1tqR3W59
        Vsx8cpjTXv0KqjQA2GMaJR0yr9votBdh/Cu8Zx50tHbyRfXpCwXYpD7/cXjTKlwRF1k3lk
        c6jasxehgP7N6B7Ua4gjuguNg62ki2Q=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-237-89OoSqTFNZWXHPMBQTklUA-1; Mon, 25 Apr 2022 23:08:15 -0400
X-MC-Unique: 89OoSqTFNZWXHPMBQTklUA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8522729AB410;
        Tue, 26 Apr 2022 03:08:09 +0000 (UTC)
Received: from T590 (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2D9422024CC3;
        Tue, 26 Apr 2022 03:07:48 +0000 (UTC)
Date:   Tue, 26 Apr 2022 11:07:43 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Dan Williams <dan.j.williams@intel.com>,
        yukuai <yukuai3@huawei.com>
Subject: Re: [PATCH V2 2/2] block: fix "Directory XXXXX with parent 'block'
 already present!"
Message-ID: <Ymdh/0MpsjxUV48z@T590>
References: <20220423143952.3162999-3-ming.lei@redhat.com>
 <68e17ba8-24ec-5b60-d52e-18d41f91892c@suse.de>
 <YmUX/Q9o08rOSTaQ@T590>
 <682a215d-de50-40f1-b6f8-48801617bcad@suse.de>
 <YmU86/YZ18CtbLgb@T590>
 <YmVUl8m0Kak4JeKa@kroah.com>
 <YmX5O0dzHs09aFbh@T590>
 <YmYtVnC3QzfukbSu@kroah.com>
 <YmZk2GN1/Z8a0v7O@T590>
 <186f4002-0359-95e7-889f-af065210cd74@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <186f4002-0359-95e7-889f-af065210cd74@suse.de>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Apr 25, 2022 at 11:32:15AM +0200, Hannes Reinecke wrote:
> On 4/25/22 11:07, Ming Lei wrote:
> > On Mon, Apr 25, 2022 at 07:10:46AM +0200, Greg Kroah-Hartman wrote:
> > > On Mon, Apr 25, 2022 at 09:28:27AM +0800, Ming Lei wrote:
> > > > On Sun, Apr 24, 2022 at 03:45:59PM +0200, Greg Kroah-Hartman wrote:
> > > > > On Sun, Apr 24, 2022 at 08:04:59PM +0800, Ming Lei wrote:
> > > > > > On Sun, Apr 24, 2022 at 01:51:45PM +0200, Hannes Reinecke wrote:
> > > > > > > On 4/24/22 11:28, Ming Lei wrote:
> > > > > > > > On Sun, Apr 24, 2022 at 10:53:29AM +0200, Hannes Reinecke wrote:
> > > > > > > > > On 4/23/22 16:39, Ming Lei wrote:
> > > > > > > > > > q->debugfs_dir is used by blk-mq debugfs and blktrace. The dentry is
> > > > > > > > > > created when adding disk, and removed when releasing request queue.
> > > > > > > > > > 
> > > > > > > > > > There is small window between releasing disk and releasing request
> > > > > > > > > > queue, and during the period, one disk with same name may be created
> > > > > > > > > > and added, so debugfs_create_dir() may complain with "Directory XXXXX
> > > > > > > > > > with parent 'block' already present!"
> > > > > > > > > > 
> > > > > > > > > > Fixes the issue by moving debugfs_create_dir() into blk_alloc_queue(),
> > > > > > > > > > and the dir name is named with q->id from beginning, and switched to
> > > > > > > > > > disk name when adding disk, and finally changed to q->id in disk_release().
> > > > > > > > > > 
> > > > > > > > > > Tested-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> > > > > > > > > > Reported-by: Dan Williams <dan.j.williams@intel.com>
> > > > > > > > > > Cc: yukuai (C) <yukuai3@huawei.com>
> > > > > > > > > > Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> > > > > > > > > > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > > > > > > > > > ---
> > > > > > > > > >     block/blk-core.c  | 4 ++++
> > > > > > > > > >     block/blk-sysfs.c | 4 ++--
> > > > > > > > > >     block/genhd.c     | 8 ++++++++
> > > > > > > > > >     3 files changed, 14 insertions(+), 2 deletions(-)
> > > > > > > > > > 
> > > > > > > > > Errm.
> > > > > > > > > 
> > > > > > > > > Isn't this superfluous now that Jens merged Yu Kuais patch?
> > > > > > > > 
> > > > > > > > Jens has dropped Yu Kuai's patch which caused kernel panic.
> > > > > > > > 
> > > > > > > Right.
> > > > > > > But still, this patch looks really odd.
> > > > > > > How is userspace supposed to use the directories prior to the renaming?
> > > > > > 
> > > > > > That doesn't make any difference for current uses, but we may extend it
> > > > > > to support debugfs for non-blk request queue in future by exporting q->id
> > > > > > somewhere. Even though now the interested q->id can be figured out
> > > > > > easily by very simple ebpf trace prog.
> > > > > > 
> > > > > > > 
> > > > > > > And as you already have identified the places where we can safely create
> > > > > > > (and remove) the debugfs directories, why can't we move the call to create
> > > > > > > and remove the debugfs directories to those locations and do away with the
> > > > > > > renaming?
> > > > > > 
> > > > > > First it needs more change to fix the kernel panic.
> > > > > > 
> > > > > > Second removing debugfs dir in del_gendisk will break blktests block/002.
> > > > > 
> > > > > Then fix the test?  debugfs interactions that cause kernel bugs should
> > > > > be ok to change the functionality of.  Remember, this is for
> > > > > debugging...
> > > > 
> > > > But what is wrong with the test? Isn't it reasonable to keep debugfs dir
> > > > when blktrace is collecting log?
> > > 
> > > How can you collect something from a device that is gone?
> > 
> > Here the 'gone' may be just in logical/soft viewpoint, such as, one disk
> > is removed by sysfs, and the driver still may send sync cache command
> > to make sure the cache inside drive is flushed, such as scsi's
> > SYNCHRONIZE_CACHE.
> > 
> And that is my argument: what does this buy us?

Isn't the posted patch simple enough for fixing the whole issue?

Not only in lines of code, but also in principle.

So far q->debugfs_dir is used by elevator, rq_qos, blktrace and blk-mq
debugfs.

The 1st three can have same lifetime with gendisk, but blk-mq debugfs
more share same lifetime with request_queue.

That is why I make ->debugfs_dir sharing same lifetime with request
queue since request queue has longer lifetime than gendisk.

With this way, we can clean the mess for delaying to add blk-mq debugfs.

Not mention this approach can allow us to add debugfs support for
non-disk request queue.

> Is is relevant (for blktrace) to have the SYNCHRONIZE_CACHE to be present in
> the logs?

SYNCHRONIZE_CACHE is just one example, and there can be more from
/dev/sg or kernel. As one user of trace tool, it is important to get
intact request trace.

> From my POV, blktrace is there to analyze I/O flow; device shutdown is not
> really relevant for that as the results of that operation depend on other
> factors which won't show up in blktrace at all.
> 
> So we're not losing much by (maybe) missing shutdown commands in blktrace;
> if needs be device shutdown can be traced by other means.
> 
> I'd rather keep the code simple, and not having an operation in the core
> block layer which requires quite some explanation.

Please write one workable patch following your idea, then compare yours
and this patch, then you will see which one is simpler.



Thanks,
Ming

