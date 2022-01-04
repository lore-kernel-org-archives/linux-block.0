Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62674C433EF
	for <linux-block@archiver.kernel.org>; Tue,  4 Jan 2022 00:55:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbiADAz2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 3 Jan 2022 19:55:28 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:64929 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbiADAz1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 3 Jan 2022 19:55:27 -0500
Received: from fsav117.sakura.ne.jp (fsav117.sakura.ne.jp [27.133.134.244])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 2040tI56061367;
        Tue, 4 Jan 2022 09:55:18 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav117.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav117.sakura.ne.jp);
 Tue, 04 Jan 2022 09:55:18 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav117.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 2040tIBZ061359
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 4 Jan 2022 09:55:18 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <7899bf0e-0ff7-2cac-7751-a3561e5a0067@I-love.SAKURA.ne.jp>
Date:   Tue, 4 Jan 2022 09:55:17 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH] block: deprecate autoloading based on dev_t
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
References: <20220103190342.146980-1-hch@lst.de>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20220103190342.146980-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2022/01/04 4:03, Christoph Hellwig wrote:
> Make the legacy dev_t based autoloading optional and add a deprecation
> warning.  This kind of autoloading has ceased to be useful about 20 years
> ago.

This is good for locking dependency simplification. But

> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/Kconfig | 11 +++++++++++
>  block/bdev.c  |  9 ++++++---
>  block/genhd.c |  6 ++++++
>  3 files changed, 23 insertions(+), 3 deletions(-)
> 
> diff --git a/block/Kconfig b/block/Kconfig
> index d5d4197b7ed2d..9cd8706faa7be 100644
> --- a/block/Kconfig
> +++ b/block/Kconfig
> @@ -26,6 +26,17 @@ menuconfig BLOCK
>  
>  if BLOCK
>  
> +config BLOCK_LEGACY_AUTOLOAD
> +	bool "Legacy autoloading support"
> +	help
> +	  Enable loading modules and creating block device instances based on
> +	  accesses through their device special file.  This is a historic Linux
> +	  feature and makes no sense in a udev world where device files are
> +	  created on demand.
> +
> +	  Say N here unless your boot broke without it, in which case you should
> +	  send a report to linux-block@vger.kernel.org and your distribution.

I don't think the affected scope is limited to the boot process.
This change affects userspace programs which do not run in the boot process.
A program which do not use ioctl(LOOP_CTL_GET_FREE) would be possible.

Current:
----------
root@fuzz:~# ls -l /dev/loop*
crw-rw---- 1 root disk 10, 237 Jan  4 09:29 /dev/loop-control
root@fuzz:~# mknod /dev/loop0 b 7 0
root@fuzz:~# cat /dev/loop0
root@fuzz:~# echo $?
0
----------

With CONFIG_BLOCK_LEGACY_AUTOLOAD=n:
----------
root@fuzz:~# ls -l /dev/loop*
crw-rw---- 1 root disk 10, 237 Jan  4 09:33 /dev/loop-control
root@fuzz:~# mknod /dev/loop0 b 7 0
root@fuzz:~# cat /dev/loop0
cat: /dev/loop0: No such device or address
root@fuzz:~# echo $?
1
root@fuzz:~# losetup /dev/loop0 testfile
losetup: /dev/loop0: failed to set up loop device: No such device or address
----------

> +
>  config BLK_RQ_ALLOC_TIME
>  	bool
>  
> diff --git a/block/bdev.c b/block/bdev.c
> index 8bf93a19041b7..dd6fd5b807b30 100644
> --- a/block/bdev.c
> +++ b/block/bdev.c
> @@ -738,12 +738,15 @@ struct block_device *blkdev_get_no_open(dev_t dev)
>  	struct inode *inode;
>  
>  	inode = ilookup(blockdev_superblock, dev);
> -	if (!inode) {
> +	if (!inode && IS_ENABLED(CONFIG_BLOCK_LEGACY_AUTOLOAD)) {
>  		blk_request_module(dev);
>  		inode = ilookup(blockdev_superblock, dev);
> -		if (!inode)
> -			return NULL;
> +		if (inode)
> +			pr_warn_ratelimited(
> +"block device autoloading is deprecated in will be removed in Linux 5.19\n");

s/deprecated in/deprecated; it/

>  	}
> +	if (!inode)
> +		return NULL;
>  
>  	/* switch from the inode reference to a device mode one: */
>  	bdev = &BDEV_I(inode)->bdev;

