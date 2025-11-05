Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B703321146C;
	Wed,  5 Nov 2025 12:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762345831; cv=none; b=YLIxf4QcyzmDqs1Xvzoln0ovZgbIBe3EoXMxoUZmDYeogx4mtTVkeYmjxWfIzdj+hGJCpy5GYcR4gqQXoy7/pEueblDCg+mmHFJN3XTK/wwnnsQ8wRX6vvjzOdSEn6VGlkrvSTkbnPqrrxXccvnPzeXcIM9dO1y+IjLEOGix1A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762345831; c=relaxed/simple;
	bh=525xIYhnqs6gU0i43TmewTm6+Cpp9ybaLuwXK2KBlks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t+GWLtD+lOct1pk06SjYo7pcqyb3z+1NblAlKQoQGbmsERqjGFuSmLIWfK+srdDCdoqnhT2HEVpMBq43RmEL60DlttT/PeAksOXMJwywd0ZAk2cSGTLDk13VHJWImI1ktMLvb1Usi880X0IbuYjgBZjOWvChqgSFecW0mi/m5iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uU2jGNff; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uU2jGNff"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CAA8C4CEFB;
	Wed,  5 Nov 2025 12:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762345831;
	bh=525xIYhnqs6gU0i43TmewTm6+Cpp9ybaLuwXK2KBlks=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uU2jGNffhWp6PpiTw1kv8C4LS8KSEJ+m3+958NRPn71F67CuaAn6j2hddjjAT2nVB
	 KwKQTUmb0Lt6S79/mg87FUDYSn2Vm7SZYGiXOpi9oVAw04exHv7BxkN98VGu+yFdSt
	 3I1zhERvSZGSwUUdBlBPUD2haRJeQlQTmEWDz/xNXY3vf61zim9U/g22KMxg+A0CNG
	 ufZCjVR86XBviXe+ubV7jNL0rMkG2z+ile3WNTz910ZatYq0D3n15+u7U1ol+HJOHp
	 pVMcTpOZOWnK8dZORtUIdAgNMQxHg6vJcor3Ko/ROALzwCmQTWen6XxVLc1m/6GDmx
	 DGSrizQXVt9Kg==
Date: Wed, 5 Nov 2025 13:30:24 +0100
From: Christian Brauner <brauner@kernel.org>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Luis Chamberlain <mcgrof@kernel.org>, 
	linux-block@vger.kernel.org, Joseph Qi <joseph.qi@linux.alibaba.com>, 
	guanghuifeng@linux.alibaba.com, zongyong.wzy@alibaba-inc.com, zyfjeff@linux.alibaba.com, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: question about bd_inode hashing against device_add() // Re:
 [PATCH 03/11] block: call bdev_add later in device_add_disk
Message-ID: <20251105-elstern-wippen-3af38a8f40f3@brauner>
References: <43375218-2a80-4a7a-b8bb-465f6419b595@linux.alibaba.com>
 <20251031090925.GA9379@lst.de>
 <ae38c5dc-da90-4fb3-bb72-61b66ab5a0d2@linux.alibaba.com>
 <20251031094552.GA10011@lst.de>
 <7d0d8480-13a2-449f-a46d-d9b164d44089@linux.alibaba.com>
 <2025103155-definite-stays-ebfe@gregkh>
 <2a9ab583-07fc-4147-949e-7c68feda82f2@linux.alibaba.com>
 <ec8b1c76-c211-49a5-a056-6a147faddd3b@linux.alibaba.com>
 <2025103106-proposal-jogging-a076@gregkh>
 <83b9dac8-815e-4990-8cc7-5aaf4ba85f42@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <83b9dac8-815e-4990-8cc7-5aaf4ba85f42@linux.alibaba.com>

On Fri, Oct 31, 2025 at 10:44:53PM +0800, Gao Xiang wrote:
> 
> 
> On 2025/10/31 22:34, Greg Kroah-Hartman wrote:
> > On Fri, Oct 31, 2025 at 08:23:32PM +0800, Gao Xiang wrote:
> > > 
> > > 
> > > On 2025/10/31 18:12, Gao Xiang wrote:
> > > > Hi Greg,
> > > > 
> > > > On 2025/10/31 17:58, Greg Kroah-Hartman wrote:
> > > > > On Fri, Oct 31, 2025 at 05:54:10PM +0800, Gao Xiang wrote:
> > > > > > 
> > > > > > 
> > > > > > On 2025/10/31 17:45, Christoph Hellwig wrote:
> > > 
> > > ...
> > > 
> > > > > > > But why does the device node
> > > > > > > get created earlier?  My assumption was that it would only be
> > > > > > > created by the KOBJ_ADD uevent.  Adding the device model maintainers
> > > > > > > as my little dig through the core drivers/base/ code doesn't find
> > > > > > > anything to the contrary, but maybe I don't fully understand it.
> > > > > > 
> > > > > > AFAIK, device_add() is used to trigger devtmpfs file
> > > > > > creation, and it can be observed if frequently
> > > > > > hotpluging device in the VM and mount.  Currently
> > > > > > I don't have time slot to build an easy reproducer,
> > > > > > but I think it's a real issue anyway.
> > > > > 
> > > > > As I say above, that's not normal, and you have to be root to do this,
> > > I just spent time to reproduce with dynamic loop devices and
> > > actually it's easy if msleep() is located artificiallly,
> > > the diff as below:
> > > 
> > > diff --git a/block/bdev.c b/block/bdev.c
> > > index 810707cca970..a4273b5ad456 100644
> > > --- a/block/bdev.c
> > > +++ b/block/bdev.c
> > > @@ -821,7 +821,7 @@ struct block_device *blkdev_get_no_open(dev_t dev, bool autoload)
> > >   	struct inode *inode;
> > > 
> > >   	inode = ilookup(blockdev_superblock, dev);
> > > -	if (!inode && autoload && IS_ENABLED(CONFIG_BLOCK_LEGACY_AUTOLOAD)) {
> > > +	if (0) {
> > >   		blk_request_module(dev);
> > >   		inode = ilookup(blockdev_superblock, dev);
> > >   		if (inode)
> > > diff --git a/block/genhd.c b/block/genhd.c
> > > index 9bbc38d12792..3c9116fdc1ce 100644
> > > --- a/block/genhd.c
> > > +++ b/block/genhd.c
> > > @@ -428,6 +428,8 @@ static void add_disk_final(struct gendisk *disk)
> > >   	set_bit(GD_ADDED, &disk->state);
> > >   }
> > > 
> > > +#include <linux/delay.h>
> > > +
> > >   static int __add_disk(struct device *parent, struct gendisk *disk,
> > >   		      const struct attribute_group **groups,
> > >   		      struct fwnode_handle *fwnode)
> > > @@ -497,6 +499,9 @@ static int __add_disk(struct device *parent, struct gendisk *disk,
> > >   	if (ret)
> > >   		goto out_free_ext_minor;
> > > 
> > > +	if (disk->major == LOOP_MAJOR)
> > > +		msleep(2500);           // delay 2.5s for all loops
> > > +
> > 
> > Yes, so you need to watch for the uevent to happen, THEN it is safe to
> > access the block device.  Doing it before then isn't a good idea :)
> > 
> > But, if you think this is an issue, do you have a patch that passes your
> > testing to fix it?
> 
> I just raise it up for some ideas, and this change is
> buried into the code refactor and honestly I need to
> look into the codebase and related patchsets first.
> 
> Currently I have dozens of other development stuffs
> on hand, if it's really a regression, I do hope
> Christoph or other folks who are familiar with the code
> could try to address this.

If it's easy to do without much of a regression or performance risk then
the device node should only show up once the device is actually ready.
It's certainly best-practive to wait for the uevent though.
