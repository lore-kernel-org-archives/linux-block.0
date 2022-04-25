Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8285CC433F5
	for <linux-block@archiver.kernel.org>; Mon, 25 Apr 2022 09:08:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbiDYJLG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Apr 2022 05:11:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241368AbiDYJK4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Apr 2022 05:10:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0A9B2BF321
        for <linux-block@vger.kernel.org>; Mon, 25 Apr 2022 02:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650877671;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ODj4kvUT1mYPUS9VGUTzX7a0l+keBQneqXlTV+/cZGY=;
        b=S/dDroNozWhN1DNNzpErAjC+TTF6EgeLb0OSUd0Et93wIg4GtIvDlcN/W5vbFv2i+Qo/K3
        S87gMNud5YqKUm/vojuVF4h0ZVDu22pcB79DsB6/dyHybuWW+joD07mbYaH/pkn06uAPw5
        R9fX/IOy/K7rVAIoAq22k5xlIu0/3eU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-497-Oxt2A9OhPgmANzHSOIOwPg-1; Mon, 25 Apr 2022 05:07:47 -0400
X-MC-Unique: Oxt2A9OhPgmANzHSOIOwPg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9DA3D1C07823;
        Mon, 25 Apr 2022 09:07:46 +0000 (UTC)
Received: from T590 (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 816F1409B413;
        Mon, 25 Apr 2022 09:07:41 +0000 (UTC)
Date:   Mon, 25 Apr 2022 17:07:36 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Hannes Reinecke <hare@suse.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Dan Williams <dan.j.williams@intel.com>,
        yukuai <yukuai3@huawei.com>
Subject: Re: [PATCH V2 2/2] block: fix "Directory XXXXX with parent 'block'
 already present!"
Message-ID: <YmZk2GN1/Z8a0v7O@T590>
References: <20220423143952.3162999-1-ming.lei@redhat.com>
 <20220423143952.3162999-3-ming.lei@redhat.com>
 <68e17ba8-24ec-5b60-d52e-18d41f91892c@suse.de>
 <YmUX/Q9o08rOSTaQ@T590>
 <682a215d-de50-40f1-b6f8-48801617bcad@suse.de>
 <YmU86/YZ18CtbLgb@T590>
 <YmVUl8m0Kak4JeKa@kroah.com>
 <YmX5O0dzHs09aFbh@T590>
 <YmYtVnC3QzfukbSu@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmYtVnC3QzfukbSu@kroah.com>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Apr 25, 2022 at 07:10:46AM +0200, Greg Kroah-Hartman wrote:
> On Mon, Apr 25, 2022 at 09:28:27AM +0800, Ming Lei wrote:
> > On Sun, Apr 24, 2022 at 03:45:59PM +0200, Greg Kroah-Hartman wrote:
> > > On Sun, Apr 24, 2022 at 08:04:59PM +0800, Ming Lei wrote:
> > > > On Sun, Apr 24, 2022 at 01:51:45PM +0200, Hannes Reinecke wrote:
> > > > > On 4/24/22 11:28, Ming Lei wrote:
> > > > > > On Sun, Apr 24, 2022 at 10:53:29AM +0200, Hannes Reinecke wrote:
> > > > > > > On 4/23/22 16:39, Ming Lei wrote:
> > > > > > > > q->debugfs_dir is used by blk-mq debugfs and blktrace. The dentry is
> > > > > > > > created when adding disk, and removed when releasing request queue.
> > > > > > > > 
> > > > > > > > There is small window between releasing disk and releasing request
> > > > > > > > queue, and during the period, one disk with same name may be created
> > > > > > > > and added, so debugfs_create_dir() may complain with "Directory XXXXX
> > > > > > > > with parent 'block' already present!"
> > > > > > > > 
> > > > > > > > Fixes the issue by moving debugfs_create_dir() into blk_alloc_queue(),
> > > > > > > > and the dir name is named with q->id from beginning, and switched to
> > > > > > > > disk name when adding disk, and finally changed to q->id in disk_release().
> > > > > > > > 
> > > > > > > > Tested-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> > > > > > > > Reported-by: Dan Williams <dan.j.williams@intel.com>
> > > > > > > > Cc: yukuai (C) <yukuai3@huawei.com>
> > > > > > > > Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> > > > > > > > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > > > > > > > ---
> > > > > > > >    block/blk-core.c  | 4 ++++
> > > > > > > >    block/blk-sysfs.c | 4 ++--
> > > > > > > >    block/genhd.c     | 8 ++++++++
> > > > > > > >    3 files changed, 14 insertions(+), 2 deletions(-)
> > > > > > > > 
> > > > > > > Errm.
> > > > > > > 
> > > > > > > Isn't this superfluous now that Jens merged Yu Kuais patch?
> > > > > > 
> > > > > > Jens has dropped Yu Kuai's patch which caused kernel panic.
> > > > > > 
> > > > > Right.
> > > > > But still, this patch looks really odd.
> > > > > How is userspace supposed to use the directories prior to the renaming?
> > > > 
> > > > That doesn't make any difference for current uses, but we may extend it
> > > > to support debugfs for non-blk request queue in future by exporting q->id
> > > > somewhere. Even though now the interested q->id can be figured out
> > > > easily by very simple ebpf trace prog.
> > > > 
> > > > > 
> > > > > And as you already have identified the places where we can safely create
> > > > > (and remove) the debugfs directories, why can't we move the call to create
> > > > > and remove the debugfs directories to those locations and do away with the
> > > > > renaming?
> > > > 
> > > > First it needs more change to fix the kernel panic.
> > > > 
> > > > Second removing debugfs dir in del_gendisk will break blktests block/002.
> > > 
> > > Then fix the test?  debugfs interactions that cause kernel bugs should
> > > be ok to change the functionality of.  Remember, this is for
> > > debugging...
> > 
> > But what is wrong with the test? Isn't it reasonable to keep debugfs dir
> > when blktrace is collecting log?
> 
> How can you collect something from a device that is gone?

Here the 'gone' may be just in logical/soft viewpoint, such as, one disk
is removed by sysfs, and the driver still may send sync cache command
to make sure the cache inside drive is flushed, such as scsi's
SYNCHRONIZE_CACHE.

> 
> > After debugfs dir is removed, blktrace may not collect intact log, and
> > people may complain it is one kernel regression.
> 
> What exactly breaks?  The device is removed, why should a trace continue
> to give you data?

Such as the above example, the command of SYNCHRONIZE_CACHE can't be
observed in blktrace any more.


Thanks,
Ming

