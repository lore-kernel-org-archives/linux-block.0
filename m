Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B815C433F5
	for <linux-block@archiver.kernel.org>; Sat, 23 Apr 2022 16:29:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236347AbiDWQcr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 23 Apr 2022 12:32:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236330AbiDWQcj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 23 Apr 2022 12:32:39 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D0E2BCBD
        for <linux-block@vger.kernel.org>; Sat, 23 Apr 2022 09:29:42 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id EB44768B05; Sat, 23 Apr 2022 18:29:37 +0200 (CEST)
Date:   Sat, 23 Apr 2022 18:29:37 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Dan Williams <dan.j.williams@intel.com>,
        yukuai <yukuai3@huawei.com>
Subject: Re: [PATCH V2 2/2] block: fix "Directory XXXXX with parent 'block'
 already present!"
Message-ID: <20220423162937.GA28340@lst.de>
References: <20220423143952.3162999-1-ming.lei@redhat.com> <20220423143952.3162999-3-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220423143952.3162999-3-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Apr 23, 2022 at 10:39:52PM +0800, Ming Lei wrote:
> q->debugfs_dir is used by blk-mq debugfs and blktrace. The dentry is
> created when adding disk, and removed when releasing request queue.
> 
> There is small window between releasing disk and releasing request
> queue, and during the period, one disk with same name may be created
> and added, so debugfs_create_dir() may complain with "Directory XXXXX
> with parent 'block' already present!"
> 
> Fixes the issue by moving debugfs_create_dir() into blk_alloc_queue(),
> and the dir name is named with q->id from beginning, and switched to
> disk name when adding disk, and finally changed to q->id in disk_release().

As said before I very much think this is going in the wrong direction.

As the debugfs directory use the name of the gendisk, the lifetime rules
should simply match those of the gendisk.  If anyone wants to trace
SCSI commands sent before probing the gendisk or after removing it
they can use blktrace on the /dev/sg node.
