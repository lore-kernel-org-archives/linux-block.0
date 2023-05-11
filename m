Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80BF1C77B7C
	for <linux-block@archiver.kernel.org>; Thu, 11 May 2023 15:28:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238132AbjEKP2O (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 May 2023 11:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232006AbjEKP2N (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 May 2023 11:28:13 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAD26197;
        Thu, 11 May 2023 08:28:12 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9F56D68D08; Thu, 11 May 2023 17:28:08 +0200 (CEST)
Date:   Thu, 11 May 2023 17:28:08 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     hch@lst.de, ming.lei@redhat.com, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH -next] block: fix blktrace debugfs entries leak
Message-ID: <20230511152808.GA8641@lst.de>
References: <20230511065633.710045-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230511065633.710045-1-yukuai1@huaweicloud.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, May 11, 2023 at 02:56:33PM +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Commit 99d055b4fd4b ("block: remove per-disk debugfs files in
> blk_unregister_queue") moves blk_trace_shutdown() from
> blk_release_queue() to blk_unregister_queue(), this is safe if blktrace
> is created through sysfs, however, there are some regression in corner
> cases:
> 
> 1) for scsi, passthrough io can still be issued after del_gendisk, and
>    blktrace debugfs entries will be removed immediately after
>    del_gendisk(), therefor passthrough io can't be tracked and blktrace
>    will complain:
> 
>    failed read of /sys/kernel/debug/block/sdb/trace0: 5/Input/output error

But that is the right thing.  The only thing that has a name is the
gendisk and it is gone at this point.  Leaking the debugfs entries
that are named after, and ultimatively associated with the gendisk
(even if the code is still a bit confused about this) will create a lot
of trouble for us.

> 2) blktrace can still be enabled after del_gendisk() through ioctl if the
>    disk is opened before del_gendisk(), and if blktrace is not shutdown
>    through ioctl before closing the disk, debugfs entries will be
>    leaked.

Yes.

> It seems 1) is not important, while 2) needs to be fixed apparently.
> 
> Fix this problem by shutdown blktrace in blk_free_queue(),
> disk_release() is not used because scsi sg support blktrace without
> gendisk, and this is safe because queue is not freed yet, and
> blk_trace_shutdown() is reentrant.

I think disk_release is the right place for "normal" blktrace.  The
odd cdev based blktrace for /dev/sg will need separate handling.
To be honest I'm not even sure how /dev/sg based passthrough is
even supposed to work in practice, but I'll need to spend some more
time to familarize myself with it.
