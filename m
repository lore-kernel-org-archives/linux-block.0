Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEDB0C433DB
	for <linux-block@archiver.kernel.org>; Wed, 23 Dec 2020 16:28:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83E7C22242
	for <linux-block@archiver.kernel.org>; Wed, 23 Dec 2020 16:28:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726047AbgLWQ2W (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Dec 2020 11:28:22 -0500
Received: from verein.lst.de ([213.95.11.211]:34933 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725807AbgLWQ2W (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Dec 2020 11:28:22 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2FC4F67373; Wed, 23 Dec 2020 17:27:38 +0100 (CET)
Date:   Wed, 23 Dec 2020 17:27:37 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Minwoo Im <minwoo.im.dev@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [RFC] nvme: set block size during namespace validation
Message-ID: <20201223162737.GA8688@lst.de>
References: <20201223150136.4221-1-minwoo.im.dev@gmail.com> <20201223154904.GA5967@lst.de> <20201223161650.GA13354@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201223161650.GA13354@localhost.localdomain>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Dec 24, 2020 at 01:16:50AM +0900, Minwoo Im wrote:
> Hello,
> 
> On 20-12-23 16:49:04, Christoph Hellwig wrote:
> > set_blocksize just sets the block sise used for buffer heads and should
> > not be called by the driver.  blkdev_get updates the block size, so
> > you must already have the fd re-reading the partition table open?
> > I'm not entirely sure how we can work around this except by avoiding
> > buffer head I/O in the partition reread code.  Note that this affects
> > all block drivers where the block size could change at runtime.
> 
> Thank you Christoph for your comment on this.
> 
> Agreed.  BLKRRPART leads us to block_read_full_page which takes buffer
> heads for I/O.
> 
> Yes, __blkdev_get() sets i_blkbits of block device inode via
> set_init_blocksize.  And Yes again as nvme-cli already opened the block
> device fd and requests the BLKRRPART with that fd.  Also, __bdev_get()
> only updates the i_blkbits(blocksize) in case bdev->bd_openers == 0 which
> is the first time to open this block device.
> 
> Then, how about having NVMe driver prevent underflow case for the
> request->__data_len is smaller than the logical block size like:

Not sure this helps.  I think we need to fix this proper and in the
block layer.  The long term fix is to stop messing with i_blksize
at all, but that is going to take very long.

I think for now the only thing we can do is to set a flag in the
gendisk when the block size changes and then reject all I/O until
the next first open that sets the blocksize.
