Return-Path: <linux-block-owner@vger.kernel.org>
Received: from g4t3427.houston.hpe.com ([15.241.140.73]:4667 "EHLO
	g4t3427.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751062AbcEROK0 (ORCPT
	<rfc822;linux-block@vger.kernel.org>);
	Wed, 18 May 2016 10:10:26 -0400
Message-ID: <1463580074.1575.7.camel@hpe.com>
Subject: Re: [PATCH] remove unused blkdev_dax_capable() function
From: Toshi Kani <toshi.kani@hpe.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: dan.j.williams@intel.com, jack@suse.cz, david@fromorbit.com,
	viro@zeniv.linux.org.uk, axboe@fb.com, hch@infradead.org,
	boaz@plexistor.com, tytso@mit.edu, adilger.kernel@dilger.ca,
	ross.zwisler@linux.intel.com, micah.parrish@hpe.com,
	linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 18 May 2016 08:01:14 -0600
In-Reply-To: <3280835.MNk2ItMooy@wuerfel>
References: <1462897437-16626-1-git-send-email-toshi.kani@hpe.com>
	 <1462897437-16626-7-git-send-email-toshi.kani@hpe.com>
	 <3280835.MNk2ItMooy@wuerfel>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, 2016-05-18 at 09:54 +0200, Arnd Bergmann wrote:
> The change from blkdev_dax_capable() to bdev_dax_capable() removed the
> only user of the former, so we now get a build warning:
> 
> fs/block_dev.c:1244:13: error: 'blkdev_dax_capable' defined but not used
> [-Werror=unused-function]
>  static bool blkdev_dax_capable(struct block_device *bdev)
> 
> This removes the now-unused function.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: a8078b1fc616 ("block: Update blkdev_dax_capable() for
> consistency")
 :
> It's not entirely from the patch description what the intention was here
> in keeping two slightly different implementations of the same function
> in one file, my best guess is that it was not intentional and we should
> just remove this.

Thanks for the build fix.  Looks like there was a conflict
between 8044aae6f374 and a8078b1fc616d, which resulted this build error.
Both patches moved blkdev_dax_capable() from block/ioctl.c
to fs/block_dev.c.

Acked-by: Toshi Kani <toshi.kani@hpe.com>

Thanks,
-Toshi
