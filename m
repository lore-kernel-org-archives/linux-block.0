Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F43CC77B73
	for <linux-block@archiver.kernel.org>; Fri, 21 Apr 2023 01:38:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232543AbjDUBiz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Apr 2023 21:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbjDUBiy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Apr 2023 21:38:54 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C58C3AAE
        for <linux-block@vger.kernel.org>; Thu, 20 Apr 2023 18:38:41 -0700 (PDT)
Received: from canpemm100004.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Q2cWp4P4LzSwFq;
        Fri, 21 Apr 2023 09:34:30 +0800 (CST)
Received: from [10.174.179.14] (10.174.179.14) by
 canpemm100004.china.huawei.com (7.192.105.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 21 Apr 2023 09:38:39 +0800
Subject: Re: How best to get the size of a blockdev from a file?
To:     Al Viro <viro@zeniv.linux.org.uk>
CC:     Kanchan Joshi <joshi.k@samsung.com>,
        David Howells <dhowells@redhat.com>, <hch@lst.de>,
        <linux-block@vger.kernel.org>
References: <CGME20230418100108epcas5p2d0f2a7a274e78731373986b3d4fced9b@epcas5p2.samsung.com>
 <1609851.1681812012@warthog.procyon.org.uk> <20230418122833.GA14457@green245>
 <e4f7df06-ccba-700b-5a69-ea44bd54e672@huawei.com>
 <20230420190411.GM3390869@ZenIV>
From:   Jason Yan <yanaijie@huawei.com>
Message-ID: <66975b71-7b50-cec7-af17-95380657b946@huawei.com>
Date:   Fri, 21 Apr 2023 09:38:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20230420190411.GM3390869@ZenIV>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.14]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm100004.china.huawei.com (7.192.105.92)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2023/4/21 3:04, Al Viro wrote:
> On Tue, Apr 18, 2023 at 10:05:12PM +0800, Jason Yan wrote:
>> On 2023/4/18 20:28, Kanchan Joshi wrote:
>>> On Tue, Apr 18, 2023 at 11:00:12AM +0100, David Howells wrote:
>>>> Hi Christoph,
>>>>
>>>> It seems that my use of i_size_read(file_inode(in)) in
>>>> filemap_splice_read()
>>>> to get the size of the file to be spliced from doesn't work in the
>>>> case of
>>>> blockdevs and it always returns 0.
>>>>
>>>> What would be the best way to get the blockdev size?  Look at
>>>> file->f_mapping->i_size maybe?
>>>
>>> bdev_nr_bytes(I_BDEV(file->f_mapping->host))
>>> should work I suppose.
>>>
>>
>> This needs the caller to check if the file is a blockdev. Can we fill the
>> upper inode size which belongs to devtmpfs so that the generic code do not
>> need to aware the low level inode type?
> 
> We do:
> 
> static inline loff_t bdev_nr_bytes(struct block_device *bdev)
> {
> 	return (loff_t)bdev_nr_sectors(bdev) << SECTOR_SHIFT;
> }
> 
> static inline sector_t bdev_nr_sectors(struct block_device *bdev)
> {
>          return bdev->bd_nr_sectors;
> }
> 
> $ git grep -n -w bd_nr_sectors
> block/genhd.c:64:       bdev->bd_nr_sectors = sectors;
> block/partitions/core.c:92:     bdev->bd_nr_sectors = sectors;
> include/linux/blk_types.h:42:   sector_t                bd_nr_sectors;
> include/linux/blkdev.h:785:     return bdev->bd_nr_sectors;
> 
> and if you look into the functions with those assignments you'll see
> void set_capacity(struct gendisk *disk, sector_t sectors)
> {
>          struct block_device *bdev = disk->part0;
> 
> 	spin_lock(&bdev->bd_size_lock);
> 	i_size_write(bdev->bd_inode, (loff_t)sectors << SECTOR_SHIFT);
> 	bdev->bd_nr_sectors = sectors;
> 	spin_unlock(&bdev->bd_size_lock);
> }
> 
> and
> 
> static void bdev_set_nr_sectors(struct block_device *bdev, sector_t sectors)
> {
>          spin_lock(&bdev->bd_size_lock);
> 	i_size_write(bdev->bd_inode, (loff_t)sectors << SECTOR_SHIFT);
> 	bdev->bd_nr_sectors = sectors;
> 	spin_unlock(&bdev->bd_size_lock);
> }
> 
> As you can see, both do i_size_write() on bdev->bd_inode with the value
> equal to what bdev_nr_bytes() will return after the store to ->bd_nr_sectors.
> 
> Now, bdev->bd_inode always points to inode coallocated with bdev
> (see bdev_alloc() for details) and that's what we have
> ->f_mapping->host pointing to for opened file after
> blkdev_open() - see
>          filp->f_mapping = bdev->bd_inode->i_mapping;
> in there combined with inode->i_mapping.host set to inode by
> inode_init_always()<-alloc_inode()<-new_inode_pseudo()<-new_inode()<-bdev_alloc().
> 
> IOW, i_size_read(file->f_mapping->host) is correct answer for any kind of file.

Ah, yes. Thanks for your patient explanation.

Jason
