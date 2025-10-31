Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB7B33372E;
	Fri, 31 Oct 2025 09:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761904735; cv=none; b=UOwr7qk3MLiLPHLW/c8m7BBYSZDI3xtxrqQ3/kbRYVGs67KxlQgWKyE5hZGvTFi88khodgCrt3ytzSo5Y5+H7gIlx0XCxFvT35cLgNOS2LHBTjSyBZyku2poT+U1YeXWEL1OFvpWPnAABjQHouviL7fL7JBQpmuvXqYPIbONbRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761904735; c=relaxed/simple;
	bh=V3hG8BzpMh/pCP+5pYVHsS9SYsFsgrpbWinK543RY6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XM7CzUgdsVD+KjhMY2O5pen4jHsPGj7Wv9ArRWeV2z7IbtsdjDQFXNgIe0eFMtavF9nxTYN90cek85UgCiDc0zUs0ARyJOPzVwywmzMU/PYJJG2zYY4N5GDl4n5h0TV3EkDGs2OE3fY+ebIH3gRKdK1+CFwa9vAWCW08RxhwHR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Y6LRvkO0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Y6LRvkO0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62BDEC4CEE7;
	Fri, 31 Oct 2025 09:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761904735;
	bh=V3hG8BzpMh/pCP+5pYVHsS9SYsFsgrpbWinK543RY6g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y6LRvkO0nH4Lrd0R/ZQ4vAlfY/yv/hr+pM6ePE6Cb7iKQ4cYZoY5qF96v/wXXYGmH
	 Hfluq/K+Cq6ZitMw/PkoPYpUDtupRztNUwNmsqh0DvkI257yesZVI0prHygBtEm8Ck
	 WinaWOoDVRkQamzD/LH2XVTI+7SH2BkLqG98PvjY=
Date: Fri, 31 Oct 2025 10:58:52 +0100
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
Message-ID: <2025103155-definite-stays-ebfe@gregkh>
References: <20210818144542.19305-1-hch@lst.de>
 <20210818144542.19305-4-hch@lst.de>
 <43375218-2a80-4a7a-b8bb-465f6419b595@linux.alibaba.com>
 <20251031090925.GA9379@lst.de>
 <ae38c5dc-da90-4fb3-bb72-61b66ab5a0d2@linux.alibaba.com>
 <20251031094552.GA10011@lst.de>
 <7d0d8480-13a2-449f-a46d-d9b164d44089@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d0d8480-13a2-449f-a46d-d9b164d44089@linux.alibaba.com>

On Fri, Oct 31, 2025 at 05:54:10PM +0800, Gao Xiang wrote:
> 
> 
> On 2025/10/31 17:45, Christoph Hellwig wrote:
> > On Fri, Oct 31, 2025 at 05:36:45PM +0800, Gao Xiang wrote:
> > > Right, sorry yes, disk_uevent(KOBJ_ADD) is in the end.
> > > 
> > > >   Do you see that earlier, or do you have
> > > > code busy polling for a node?
> > > 
> > > Personally I think it will break many userspace programs
> > > (although I also don't think it's a correct expectation.)
> > 
> > We've had this behavior for a few years, and this is the first report
> > I've seen.
> > 
> > > After recheck internally, the userspace program logic is:
> > >    - stat /dev/vdX;
> > >    - if exists, mount directly;
> > >    - if non-exists, listen uevent disk_add instead.
> > > 
> > > Previously, for devtmpfs blkdev files, such stat/mount
> > > assumption is always valid.
> > 
> > That assumption doesn't seem wrong.
> 
> ;-) I was thought UNIX mknod doesn't imply the device is
> ready or valid in any case (but dev files in devtmpfs
> might be an exception but I didn't find some formal words)...
> so uevent is clearly a right way, but..

Yes, anyone can do a mknod and attempt to open a device that isn't
present.

when devtmpfs creates the device node, it should be there.  Unless it
gets removed, and then added back, so you could race with userspace, but
that's not normal.

> > But why does the device node
> > get created earlier?  My assumption was that it would only be
> > created by the KOBJ_ADD uevent.  Adding the device model maintainers
> > as my little dig through the core drivers/base/ code doesn't find
> > anything to the contrary, but maybe I don't fully understand it.
> 
> AFAIK, device_add() is used to trigger devtmpfs file
> creation, and it can be observed if frequently
> hotpluging device in the VM and mount.  Currently
> I don't have time slot to build an easy reproducer,
> but I think it's a real issue anyway.

As I say above, that's not normal, and you have to be root to do this,
so I don't understand what you are trying to prevent happening?  What is
the bug and why is it just showing up now (i.e. what changed to cause
it?)

thanks,

greg k-h
