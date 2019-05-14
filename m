Return-Path: <SRS0=Dkg2=TO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 948BAC04AB4
	for <linux-block@archiver.kernel.org>; Tue, 14 May 2019 14:32:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63C2D2085A
	for <linux-block@archiver.kernel.org>; Tue, 14 May 2019 14:32:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726060AbfENOcv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 May 2019 10:32:51 -0400
Received: from verein.lst.de ([213.95.11.211]:46149 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725928AbfENOcv (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 May 2019 10:32:51 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 4D5BA68B05; Tue, 14 May 2019 16:32:31 +0200 (CEST)
Date:   Tue, 14 May 2019 16:32:31 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, axboe@fb.com,
        Matias Bjorling <mb@lightnvm.io>, linux-block@vger.kernel.org
Subject: Re: [PATCH 01/10] block: don't decrement nr_phys_segments for
 physically contigous segments
Message-ID: <20190514143231.GA14556@lst.de>
References: <20190513063754.1520-1-hch@lst.de> <20190513063754.1520-2-hch@lst.de> <20190513094544.GA30381@ming.t460p> <20190513120344.GA22993@lst.de> <20190514043642.GB10824@ming.t460p> <20190514051441.GA6294@lst.de> <20190514090544.GC20468@ming.t460p> <20190514135141.GA13683@lst.de> <20190514142716.GB25519@ming.t460p> <20190514143102.GA14401@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190514143102.GA14401@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, May 14, 2019 at 04:31:02PM +0200, Christoph Hellwig wrote:
> On Tue, May 14, 2019 at 10:27:17PM +0800, Ming Lei wrote:
> > I am wondering if it can be done easily, given mkfs is userspace
> > which only calls write syscall on block device. Or could you share
> > something about how to fix the stupid things?
> 
> mkfs.ext4 at least uses buffered I/O on the block device.  And the
> block device uses the really old buffer head based address_space ops,
> which will submit one bio per buffer_head, that is per logic block.
> mkfs probably writes much larger sizes than that..

As a first step we could try something like that patch below.  Although
the mpage ops still aren't exactly optimal:


diff --git a/fs/block_dev.c b/fs/block_dev.c
index bded2ee3788d..b2ee74f1c669 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -608,12 +608,12 @@ EXPORT_SYMBOL(thaw_bdev);
 
 static int blkdev_writepage(struct page *page, struct writeback_control *wbc)
 {
-	return block_write_full_page(page, blkdev_get_block, wbc);
+	return mpage_writepage(page, blkdev_get_block, wbc);
 }
 
 static int blkdev_readpage(struct file * file, struct page * page)
 {
-	return block_read_full_page(page, blkdev_get_block);
+	return mpage_readpage(page, blkdev_get_block);
 }
 
 static int blkdev_readpages(struct file *file, struct address_space *mapping,
@@ -1984,7 +1984,7 @@ static int blkdev_releasepage(struct page *page, gfp_t wait)
 static int blkdev_writepages(struct address_space *mapping,
 			     struct writeback_control *wbc)
 {
-	return generic_writepages(mapping, wbc);
+	return mpage_writepages(mapping, wbc, blkdev_get_block);
 }
 
 static const struct address_space_operations def_blk_aops = {
