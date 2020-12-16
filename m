Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCD81C4361B
	for <linux-block@archiver.kernel.org>; Wed, 16 Dec 2020 14:18:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71B8723384
	for <linux-block@archiver.kernel.org>; Wed, 16 Dec 2020 14:18:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726432AbgLPOSU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Dec 2020 09:18:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726398AbgLPOST (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Dec 2020 09:18:19 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82B5AC061794
        for <linux-block@vger.kernel.org>; Wed, 16 Dec 2020 06:17:39 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id 81so24033645ioc.13
        for <linux-block@vger.kernel.org>; Wed, 16 Dec 2020 06:17:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tnR8884gSF/ToNxD9ZJLfcD1C5koR6y38QuhZr7EhUI=;
        b=A8usURjrL2FUCVWduvGpULb5cAzCdXYJnPxZUM3xFUzMJiTjTKjAVCLoE4N24dbn3O
         que5P4u01+qr3uiPeCdCYCRSDn4LYGWstvYYVBNMIayVX54MscSzzqtBeyWKVMElF3sP
         6sL+3ezM2TGrf6XrI5XyiU5MESIEgclPgSUROx81wmLiF9aqx1Tq08Fm1mFSMz1ewfdi
         cFVPrOIHfpWOv+pby/9BxfNVKcyoSJ66locID1krv7d4xijte6745LxlVK+6A5ut1VwV
         /MhU0mTkJpYBNTzs7Ib5TVCZzhE/7zwPwjMFpT4LZfUlc1p8GfFUHgWO2CY1WHv7Nh4t
         d3aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tnR8884gSF/ToNxD9ZJLfcD1C5koR6y38QuhZr7EhUI=;
        b=a2viuCu/qjRUBjhTFQ+jmTIXrYMNEVoW2E716ehONMxkfmgZ8L/CBnRYZXdjcaJn0F
         JNZFqt8iXjmJabSd50QN1kx5D/h32GWTRWZbsHlRHRvgfuSGX35Y50YRiFNuPAw/Hakz
         eJ3NRNFstbr5w1yOHowzlFW6BZtkpp3J9SM5+3ThMCnNCOVr/jlvDro3rrFFsAheJkA8
         3d+2XywPG2ICpC3PdNMxDIALmc1bhSv/21yvwEudInl08JqxXlB6xO1wdV5GCvx5I/TK
         5iLyIBFQMbGAMigRA1Cuxn/ruzO7dKgjLAcXJKMZaq6CGzb15fRLIlyU2nm0Tz5tbMgq
         vFdQ==
X-Gm-Message-State: AOAM530t0awcqYuxMyIBAdNJ/qnJryUZ6wZwcj3BU4yzx+TOs75Hadae
        +fpkN6j48gQSo01I3bNesrhkDZWYV0GA6w==
X-Google-Smtp-Source: ABdhPJyH1lAHNn3txjw5nHIxTRMp1FoC3vIKDkxpwwIRgMOqHOmXFfXS3hItEEuEdXcjbND3F86LfA==
X-Received: by 2002:a6b:7717:: with SMTP id n23mr42367552iom.73.1608128258653;
        Wed, 16 Dec 2020 06:17:38 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id u24sm1375726ili.47.2020.12.16.06.17.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Dec 2020 06:17:38 -0800 (PST)
Subject: Re: [GIT PULL] Block changes for 5.10
From:   Jens Axboe <axboe@kernel.dk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <774c987e-0743-6a7b-cfa7-1c65c35931b3@kernel.dk>
Message-ID: <527578f5-4fab-206d-1bb6-2b943c1c94ed@kernel.dk>
Date:   Wed, 16 Dec 2020 07:17:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <774c987e-0743-6a7b-cfa7-1c65c35931b3@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/14/20 8:06 AM, Jens Axboe wrote:
> Hi Linus,
> 
> Another series of killing more code than what is being added, again
> thanks to Christoph's relentless cleanups and tech debt tackling. Note
> that there are a fix merge resolutions that need to be done, see below
> changelog.
> 
> This pull request contains:
> 
> - blk-iocost improvements (Baolin Wang)
> 
> - part0 iostat fix (Jeffle Xu)
> 
> - Disable iopoll for split bios (Jeffle Xu)
> 
> - block tracepoint cleanups (Christoph Hellwig)
> 
> - Merging of struct block_device and hd_struct (Christoph Hellwig)
> 
> - Rework/cleanup of how block device sizes are updated (Christoph
>   Hellwig)
> 
> - Simplification of gendisk lookup and removal of block device aliasing
>   (Christoph Hellwig)
> 
> - Block device ioctl cleanups (Christoph Hellwig)
> 
> - Removal of bdget()/blkdev_get() as exported API (Christoph Hellwig)
> 
> - Disk change rework, avoid ->revalidate_disk() (Christoph Hellwig)
> 
> - sbitmap improvements (Pavel Begunkov)
> 
> - Hybrid polling fix (Pavel Begunkov)
> 
> - bvec iteration improvements (Pavel Begunkov)
> 
> - Zone revalidation fixes (Damien Le Moal)
> 
> - blk-throttle limit fix (Yu Kuai)
> 
> - Various little fixes
> 
> Note that pulling this will throw a merge conflict due to the late
> reverts of the md discard bits, and also a silent merge failure due to a
> late fix (b7131ee0bac5) for 5.10 fixing a memory leak. Three in total,
> they are:
> 
> - drivers/md/md.c: this one does throw a merge error, fix is simply
>   removing md_submit_discard_bio().
> 
> - drivers/md/raid0.c: Remove the first argument to
>   trace_block_bio_remap().
> 
> - block/blk-cgroup.c: remove disk_put_part(part) in
>   blkcg_fill_root_iostats().
> 
> I've pushed out a for-5.11/block-merged branch that has these
> resolutions in place, for reference.

With the btrfs tree merged, you'll know need to edit fs/btrfs/zoned.c
and apply the below incremental when this is pulled:

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 155545180046..c38846659019 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -165,7 +165,7 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device)
 	if (!zone_info)
 		return -ENOMEM;
 
-	nr_sectors = bdev->bd_part->nr_sects;
+	nr_sectors = bdev_nr_sectors(bdev);
 	zone_sectors = bdev_zone_sectors(bdev);
 	/* Check if it's power of 2 (see is_power_of_2) */
 	ASSERT(zone_sectors != 0 && (zone_sectors & (zone_sectors - 1)) == 0);
@@ -505,7 +505,7 @@ int btrfs_sb_log_location_bdev(struct block_device *bdev, int mirror, int rw,
 		return -EINVAL;
 	zone_size = zone_sectors << SECTOR_SHIFT;
 	zone_sectors_shift = ilog2(zone_sectors);
-	nr_sectors = bdev->bd_part->nr_sects;
+	nr_sectors = bdev_nr_sectors(bdev);
 	nr_zones = nr_sectors >> zone_sectors_shift;
 
 	sb_zone = sb_zone_number(zone_sectors_shift + SECTOR_SHIFT, mirror);
@@ -603,7 +603,7 @@ int btrfs_reset_sb_log_zones(struct block_device *bdev, int mirror)
 
 	zone_sectors = bdev_zone_sectors(bdev);
 	zone_sectors_shift = ilog2(zone_sectors);
-	nr_sectors = bdev->bd_part->nr_sects;
+	nr_sectors = bdev_nr_sectors(bdev);
 	nr_zones = nr_sectors >> zone_sectors_shift;
 
 	sb_zone = sb_zone_number(zone_sectors_shift + SECTOR_SHIFT, mirror);

-- 
Jens Axboe

