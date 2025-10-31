Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB47B1E9B3D;
	Fri, 31 Oct 2025 09:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761903960; cv=none; b=fk39keql2Asl2ssqBjSB46TXgMAVGD1BNaLgYZIGXoIB3bZn0eLKZ171EW95tNvwv6cn0PgH/lWVBaPTw4KwC13D7y55gBAmes14Ap215n507mSC944H2yiRJuqgUBLqV+9dHwU2z4ULQvon03SERd6ldHAZGznjVgIO1cXLAuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761903960; c=relaxed/simple;
	bh=zWRcJ5H8vRxNKTmus9lJ+nByXq+FW9ZgjyNpH27HtoE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MtWTlDA++Ub9iGBF1wDq/k+wXPN6/lXMnbM/GUmHp0dkvMEp4fUdQiTyb/anUWAmifn8khYpLsHbeUHm5J9M8VxvyYlysi1LIpk/7tyXOUDwc5U1ciRyRfBSJxE0/voMxeCXxtpjo3+cw3oGUuTJvNhHRVjdrZsjJhUkynMm38Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id A6346227A88; Fri, 31 Oct 2025 10:45:52 +0100 (CET)
Date: Fri, 31 Oct 2025 10:45:52 +0100
From: Christoph Hellwig <hch@lst.de>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Luis Chamberlain <mcgrof@kernel.org>, linux-block@vger.kernel.org,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	guanghuifeng@linux.alibaba.com, zongyong.wzy@alibaba-inc.com,
	zyfjeff@linux.alibaba.com,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: question about bd_inode hashing against device_add() // Re:
 [PATCH 03/11] block: call bdev_add later in device_add_disk
Message-ID: <20251031094552.GA10011@lst.de>
References: <20210818144542.19305-1-hch@lst.de> <20210818144542.19305-4-hch@lst.de> <43375218-2a80-4a7a-b8bb-465f6419b595@linux.alibaba.com> <20251031090925.GA9379@lst.de> <ae38c5dc-da90-4fb3-bb72-61b66ab5a0d2@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae38c5dc-da90-4fb3-bb72-61b66ab5a0d2@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Oct 31, 2025 at 05:36:45PM +0800, Gao Xiang wrote:
> Right, sorry yes, disk_uevent(KOBJ_ADD) is in the end.
>
>>  Do you see that earlier, or do you have
>> code busy polling for a node?
>
> Personally I think it will break many userspace programs
> (although I also don't think it's a correct expectation.)

We've had this behavior for a few years, and this is the first report
I've seen.

> After recheck internally, the userspace program logic is:
>   - stat /dev/vdX;
>   - if exists, mount directly;
>   - if non-exists, listen uevent disk_add instead.
>
> Previously, for devtmpfs blkdev files, such stat/mount
> assumption is always valid.

That assumption doesn't seem wrong.  But why does the device node
get created earlier?  My assumption was that it would only be
created by the KOBJ_ADD uevent.  Adding the device model maintainers
as my little dig through the core drivers/base/ code doesn't find
anything to the contrary, but maybe I don't fully understand it.

