Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424155227
	for <linux-block@vger.kernel.org>; Fri, 31 Oct 2025 07:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761896776; cv=none; b=mPGQeX66rcxrVjYZcWPLXsVbviNZm5Zg9nMyjvEVmGTfwSzozmG7pEoAvh0ijPGEv4KsNTsyFY/Tm4XNc8EGXCH7HGv9FJpaVrlWZ2xgevq4XVpLLatGV9DNXbFAJ4CGPJxInZFbkR2KAf2Sml+/At77C5DPFatGNJP0I2ahGxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761896776; c=relaxed/simple;
	bh=bteYJe/Mga9zUzi/FWVgwxzMKTENUIKJsOe/IQIdUis=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dpzH4WHwdbHVLEgL8V8ehNWnPYfnY2M7YgCEsuwUOmKZAfGL8V5kmPOEP8UH0bNR5XtQ2Qp1okzZBd/ESwW1SNpQ5eKyQAyj8CPI0DtCHRrIgcaij3mvD0zyPIU/D7IwTovEj0PVT9v7XtoCCtmDKR6EofooMPN8RCeQWkFh/tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=RRH5jpzZ; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="RRH5jpzZ"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1761896764; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=+BPEIy3rTzMn7zvznBJ13GoK8nFOkxcTS73Bhzg7tks=;
	b=RRH5jpzZd0+arkf/VmIRuTi+kY1o7KW8QDHuYd93YhP9jphmoG8P2Yy3yyKpKY7UnOuKYfxcRCmwHYbx8UnTronSMViruVIlUOR6cz3QhBAP6OOGrbgiQs7URgwQ9INgSeyUGHtw0c17gFlJ0BTeQb+7iYKFXooZACdm4VpITCo=
Received: from 30.221.132.210(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WrOIJSK_1761896762 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 31 Oct 2025 15:46:03 +0800
Message-ID: <43375218-2a80-4a7a-b8bb-465f6419b595@linux.alibaba.com>
Date: Fri, 31 Oct 2025 15:46:02 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: question about bd_inode hashing against device_add() // Re: [PATCH
 03/11] block: call bdev_add later in device_add_disk
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Luis Chamberlain <mcgrof@kernel.org>, linux-block@vger.kernel.org,
 Joseph Qi <joseph.qi@linux.alibaba.com>, guanghuifeng@linux.alibaba.com,
 zongyong.wzy@alibaba-inc.com, zyfjeff@linux.alibaba.com
References: <20210818144542.19305-1-hch@lst.de>
 <20210818144542.19305-4-hch@lst.de>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20210818144542.19305-4-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Christoph,

On 2021/8/18 22:45, Christoph Hellwig wrote:
> Once bdev_add is called userspace can open the block device.  Ensure
> that the struct device, which is used for refcounting of the disk
> besides various other things, is fully setup at that point.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Sorry for bring up an old commit.

 From my understanding, before this commit, bdev_add() will
be called prior to device_add() so insert_inode_hash()
in bdev_add() will be called before users can see blkdev
in the devtmpfs.

But after this change, blkdev can be seen before
insert_inode_hash(), which opens a race (although I'm not
sure if it's an expected behavior) blkdev_get_no_open() will
find nothing (e.g. mounting) even blkdev in devtmpfs is
there.

Also before commit 22ae8ce8b892 ("block: simplify bdev/disk
lookup in blkdev_get"), the corresponding bd_inode was created
by bdget() so at least it doesn't have such race window too.

One use case is that some userspace applications expect that
once a blkdev is visible in devtmpfs, it can be mounted
immediately. I'm not sure if it's a correct expectation
(or if there is some better way to know when bd_inode is
ready instead of just retring mount operations) or it's
just needed to be fixed.

Such race can be often observed if a virtio-blk device is
hotpluged into a VM and mount immediately at least on
Linux 6.6.

Thanks,
Gao Xiang
