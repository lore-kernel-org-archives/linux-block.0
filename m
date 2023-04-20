Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3708EC77B73
	for <linux-block@archiver.kernel.org>; Thu, 20 Apr 2023 19:04:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbjDTTE1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Apr 2023 15:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjDTTE0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Apr 2023 15:04:26 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B13DF1995
        for <linux-block@vger.kernel.org>; Thu, 20 Apr 2023 12:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
        bh=RfNgPtw61OyXdqzdEXtsDqjj7xuVb+mqq0iAopWMIRo=; b=ssUvaWL97Ke7BHOjGG4uA02Rxy
        x7Wv/S2UxzlK6Ua2oxN1G9RuEasuk+2tLOzaXW/1dkoTEMRBXBRd9JUBNVQHUCr9/WBQBmoDL1W8r
        Nt/1my+Zmm7b9ZJqsjlSHYQtqZM2lnsXVG0e8yv78cEX2Zwt+MRXzPRGZ8C/LUiVF1jfBR/6RKOzx
        FGCyhqoKHZgbC3CB+7B622Slze8minl/xZNV2MqoJDgJ+kyNtfumtf/goXYKeh1JBrPV5OHgN74nu
        HfKPlWhBGx6rnSiEv8OWi3dK6SJQTQXDVnIWmPPoOg3CY1sxjDxnKEFaOgMK9osJx6gqEgws1Mj7U
        Ti3Rp0tQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1ppZZj-00Aw3q-2Y;
        Thu, 20 Apr 2023 19:04:11 +0000
Date:   Thu, 20 Apr 2023 20:04:11 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jason Yan <yanaijie@huawei.com>
Cc:     Kanchan Joshi <joshi.k@samsung.com>,
        David Howells <dhowells@redhat.com>, hch@lst.de,
        linux-block@vger.kernel.org
Subject: Re: How best to get the size of a blockdev from a file?
Message-ID: <20230420190411.GM3390869@ZenIV>
References: <CGME20230418100108epcas5p2d0f2a7a274e78731373986b3d4fced9b@epcas5p2.samsung.com>
 <1609851.1681812012@warthog.procyon.org.uk>
 <20230418122833.GA14457@green245>
 <e4f7df06-ccba-700b-5a69-ea44bd54e672@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e4f7df06-ccba-700b-5a69-ea44bd54e672@huawei.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Apr 18, 2023 at 10:05:12PM +0800, Jason Yan wrote:
> On 2023/4/18 20:28, Kanchan Joshi wrote:
> > On Tue, Apr 18, 2023 at 11:00:12AM +0100, David Howells wrote:
> > > Hi Christoph,
> > > 
> > > It seems that my use of i_size_read(file_inode(in)) in
> > > filemap_splice_read()
> > > to get the size of the file to be spliced from doesn't work in the
> > > case of
> > > blockdevs and it always returns 0.
> > > 
> > > What would be the best way to get the blockdev size?  Look at
> > > file->f_mapping->i_size maybe?
> > 
> > bdev_nr_bytes(I_BDEV(file->f_mapping->host))
> > should work I suppose.
> > 
> 
> This needs the caller to check if the file is a blockdev. Can we fill the
> upper inode size which belongs to devtmpfs so that the generic code do not
> need to aware the low level inode type?

We do:

static inline loff_t bdev_nr_bytes(struct block_device *bdev)
{
	return (loff_t)bdev_nr_sectors(bdev) << SECTOR_SHIFT;
}

static inline sector_t bdev_nr_sectors(struct block_device *bdev)
{
        return bdev->bd_nr_sectors;
}

$ git grep -n -w bd_nr_sectors
block/genhd.c:64:       bdev->bd_nr_sectors = sectors;
block/partitions/core.c:92:     bdev->bd_nr_sectors = sectors;
include/linux/blk_types.h:42:   sector_t                bd_nr_sectors;
include/linux/blkdev.h:785:     return bdev->bd_nr_sectors;

and if you look into the functions with those assignments you'll see
void set_capacity(struct gendisk *disk, sector_t sectors)
{
        struct block_device *bdev = disk->part0;

	spin_lock(&bdev->bd_size_lock);
	i_size_write(bdev->bd_inode, (loff_t)sectors << SECTOR_SHIFT);
	bdev->bd_nr_sectors = sectors;
	spin_unlock(&bdev->bd_size_lock);
}

and

static void bdev_set_nr_sectors(struct block_device *bdev, sector_t sectors)
{
        spin_lock(&bdev->bd_size_lock);
	i_size_write(bdev->bd_inode, (loff_t)sectors << SECTOR_SHIFT);
	bdev->bd_nr_sectors = sectors;
	spin_unlock(&bdev->bd_size_lock);
}

As you can see, both do i_size_write() on bdev->bd_inode with the value
equal to what bdev_nr_bytes() will return after the store to ->bd_nr_sectors.

Now, bdev->bd_inode always points to inode coallocated with bdev
(see bdev_alloc() for details) and that's what we have
->f_mapping->host pointing to for opened file after
blkdev_open() - see
        filp->f_mapping = bdev->bd_inode->i_mapping;
in there combined with inode->i_mapping.host set to inode by
inode_init_always()<-alloc_inode()<-new_inode_pseudo()<-new_inode()<-bdev_alloc().

IOW, i_size_read(file->f_mapping->host) is correct answer for any kind of file.
