Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E912E1DB15F;
	Fri, 31 Oct 2025 14:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761921253; cv=none; b=JF0I6JYLxH/Zr7acmy2oHyMtxLkI6/ZwWG4akUzvf3elGo4CodmyS2q2vKofARk/oxWF6PCl18XF3wy/t8BbQ0Y9aiq8WPDYqbklOqUEGIUyvHkTzOQOpVM0jAML+Nsfi+SV28wA7Fd4NpFb7RKwxFWu1jjnQxXl/rh1YfpUci0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761921253; c=relaxed/simple;
	bh=uuFJKQhG0HltRTkQmhj740X0ylgNZVTihawUTCIoVHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S1ip6+f78K422Ez/LMClfDfWEDARxlvygdO1P6RSqw65HgD63x1hrE5CjWXYu774UMGc3530y9mYMDjrAseTL5fb4yuuTccboAf+beu7uasOkIdNK5mZ+XJvPhJLd/1sansWIOVIAwx/ach4iDZipFJuoHo3pXOUWV4tby8JXNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xvTgD5Ou; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xvTgD5Ou"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5E76C4CEE7;
	Fri, 31 Oct 2025 14:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761921252;
	bh=uuFJKQhG0HltRTkQmhj740X0ylgNZVTihawUTCIoVHE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=xvTgD5Ou0de5Mlq6rDLWFU/y2jZRZtEVNKHLPFFOC/I2sKgfPn9WZ1dEag/bN2CBW
	 FXG8tW0epeg1HfxilWbEY410R96fkBcXFNXzM7Q/OPzD7OqUkxvXDdl7JxHezpEZIi
	 Tjr/WsP9srDyEzLB0h/jYS7mXT9KWT4ueuScKDgA=
Date: Fri, 31 Oct 2025 15:34:09 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Luis Chamberlain <mcgrof@kernel.org>, linux-block@vger.kernel.org,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	guanghuifeng@linux.alibaba.com, zongyong.wzy@alibaba-inc.com,
	zyfjeff@linux.alibaba.com, "Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: question about bd_inode hashing against device_add() // Re:
 [PATCH 03/11] block: call bdev_add later in device_add_disk
Message-ID: <2025103106-proposal-jogging-a076@gregkh>
References: <20210818144542.19305-1-hch@lst.de>
 <20210818144542.19305-4-hch@lst.de>
 <43375218-2a80-4a7a-b8bb-465f6419b595@linux.alibaba.com>
 <20251031090925.GA9379@lst.de>
 <ae38c5dc-da90-4fb3-bb72-61b66ab5a0d2@linux.alibaba.com>
 <20251031094552.GA10011@lst.de>
 <7d0d8480-13a2-449f-a46d-d9b164d44089@linux.alibaba.com>
 <2025103155-definite-stays-ebfe@gregkh>
 <2a9ab583-07fc-4147-949e-7c68feda82f2@linux.alibaba.com>
 <ec8b1c76-c211-49a5-a056-6a147faddd3b@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ec8b1c76-c211-49a5-a056-6a147faddd3b@linux.alibaba.com>

On Fri, Oct 31, 2025 at 08:23:32PM +0800, Gao Xiang wrote:
> 
> 
> On 2025/10/31 18:12, Gao Xiang wrote:
> > Hi Greg,
> > 
> > On 2025/10/31 17:58, Greg Kroah-Hartman wrote:
> > > On Fri, Oct 31, 2025 at 05:54:10PM +0800, Gao Xiang wrote:
> > > > 
> > > > 
> > > > On 2025/10/31 17:45, Christoph Hellwig wrote:
> 
> ...
> 
> > > > > But why does the device node
> > > > > get created earlier?  My assumption was that it would only be
> > > > > created by the KOBJ_ADD uevent.  Adding the device model maintainers
> > > > > as my little dig through the core drivers/base/ code doesn't find
> > > > > anything to the contrary, but maybe I don't fully understand it.
> > > > 
> > > > AFAIK, device_add() is used to trigger devtmpfs file
> > > > creation, and it can be observed if frequently
> > > > hotpluging device in the VM and mount.  Currently
> > > > I don't have time slot to build an easy reproducer,
> > > > but I think it's a real issue anyway.
> > > 
> > > As I say above, that's not normal, and you have to be root to do this,
> I just spent time to reproduce with dynamic loop devices and
> actually it's easy if msleep() is located artificiallly,
> the diff as below:
> 
> diff --git a/block/bdev.c b/block/bdev.c
> index 810707cca970..a4273b5ad456 100644
> --- a/block/bdev.c
> +++ b/block/bdev.c
> @@ -821,7 +821,7 @@ struct block_device *blkdev_get_no_open(dev_t dev, bool autoload)
>  	struct inode *inode;
> 
>  	inode = ilookup(blockdev_superblock, dev);
> -	if (!inode && autoload && IS_ENABLED(CONFIG_BLOCK_LEGACY_AUTOLOAD)) {
> +	if (0) {
>  		blk_request_module(dev);
>  		inode = ilookup(blockdev_superblock, dev);
>  		if (inode)
> diff --git a/block/genhd.c b/block/genhd.c
> index 9bbc38d12792..3c9116fdc1ce 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -428,6 +428,8 @@ static void add_disk_final(struct gendisk *disk)
>  	set_bit(GD_ADDED, &disk->state);
>  }
> 
> +#include <linux/delay.h>
> +
>  static int __add_disk(struct device *parent, struct gendisk *disk,
>  		      const struct attribute_group **groups,
>  		      struct fwnode_handle *fwnode)
> @@ -497,6 +499,9 @@ static int __add_disk(struct device *parent, struct gendisk *disk,
>  	if (ret)
>  		goto out_free_ext_minor;
> 
> +	if (disk->major == LOOP_MAJOR)
> +		msleep(2500);           // delay 2.5s for all loops
> +

Yes, so you need to watch for the uevent to happen, THEN it is safe to
access the block device.  Doing it before then isn't a good idea :)

But, if you think this is an issue, do you have a patch that passes your
testing to fix it?

thanks,

greg k-h
