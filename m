Received: from mta0.migadu.com (out-253.mta0.migadu.com [91.218.175.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649164AC15D
	for <linux-block@vger.kernel.org>; Wed, 16 Sep 2026 09:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.253
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789551956; cv=none; b=TcBx80zSJUOv1IifWckac3M/VrzHPFo/myCn4dJVasYDyW6tt6Rctd6SRyaMkrcPxJUUsnD6jYXpt8iVlow40DHg1yx/nQPP1sw8P5iCW3CCFUzmx7NngowB+NVDwDiwhPwqcLrZ3SdQUSev380KULhn+QBBBn7z6EZtn0hLo6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789551956; c=relaxed/simple;
	bh=mO98Mkuc0nB/Kxdxx3wdKcIT3x3Ro8TrzEDgQ/nqMZs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CsNSgMQeSE/vD+aZlUCHYVzwSX9XW8zcY4uoUBaaucVZj4pdxu0Xk5y2RyNqFJ9L4O9wEk+Ct2tTBpGn6YV2D0ARIPnMonSe3Zm4G2HBQF7Xdwg3eNPY2gvN4vGlrLeqi6MDJ6aqom8k4I9hYlzVoGMJl+rvcZPQlNe0poTa0P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pKMhxyXW; arc=none smtp.client-ip=91.218.175.253
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pKMhxyXW"
X-Envelope-To: linux-block@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=mO98Mkuc0nB/Kxdxx3wdKcIT3x3Ro8TrzEDgQ/nqMZs=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789551933; v=1; x=1790156733;
 b=pKMhxyXWe8GL9GtZWsijKRsN3MO6RUaq1pp8i5zf0joaXNOVqCthb+HZRz6dyuDI8UIUBTvl
 6c7q3Z6WR75YQTdDIVqshB47LWSuCD6BjlptvcCPe9D+QTl5ISo9bIoQqfRBDxNpd2Faq3LGutY
 HQIc1NwmP1A9M11VxOYW/1SY=
X-Envelope-To: linux-block@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id 4e1f0847cc37f286;
	Wed, 16 Sep 2026 09:45:13 +0000
X-Mizu-Trace-ID: 4e1f0847cc37f286
X-Migadu-Flow: FLOW_OUT
Message-ID: <cf378b14-8e59-47c0-af44-c28415a640bf@linux.dev>
Date: Wed, 16 Sep 2026 10:45:12 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 0/3] fix NVMe multipath partition diskstats
To: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20260821084831.4155943-1-john.g.garry@oracle.com>
Content-Language: en-US
From: John Garry <john.garry@linux.dev>
In-Reply-To: <20260821084831.4155943-1-john.g.garry@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/21/26 09:48, John Garry wrote:

Hi guys,

Any opinion on this one? Specifically how to improve the per-path disk 
partition cloning here.

Cheers

> Currently the NVMe multipath partition diskstats are not maintained.
> This is because the functionality to update the diskstats only updates
> for the whole disk (and not per partition).
> 
> As an example:
> $ ./fio_read nvme1n1p1 # run traffic on /dev/nvme1n1p1
> ...
> $ more /proc/diskstats | grep nvme1
>   259       2 nvme1c1n1 49857 0 400344 768565 0 0 0 0 0 2334 768565 0 0 0 0 0 0
>   259       3 nvme1n1 99710 0 800680 1599285 0 0 0 0 0 2346 1599285 0 0 0 0 0 0
>   259       5 nvme1n1p1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
>   259       4 nvme1c2n1 49853 0 400336 831472 0 0 0 0 0 2315 831472 0 0 0 0 0 0
> 
> Notice how all values are 0 for nvme1n1p1.
> 
> This series addresses that problem by first updating the gendisk code to
> create the partition table for hidden disks, as suggested by Keith.
> 
> This is done by cloning the partition table from the multipath disk.
> 
> Secondly the NVMe multipath functionality to handle the diskstats is
> modified to handle the gendisk partition, by looking up this partition
> from the per-path disk partition.
> 
> Setting as RFC as I am not too happy with the block partition cloning
> code.
> 
> Difference to v2:
> - don't scan per-path disk, and clone from multipath disk instead
> 
> John Garry (3):
>    block: support linking disks to clone partitions
>    block: don't show partition diskstats for GENHD_FL_HIDDEN
>    nvme-multipath: fix diskstats for partitions
> 
>   block/blk.h                   |  1 +
>   block/genhd.c                 | 35 +++++++++++++++++++++++-
>   block/partitions/core.c       | 45 +++++++++++++++++++++++++++++++
>   drivers/nvme/host/core.c      |  1 +
>   drivers/nvme/host/multipath.c | 51 ++++++++++++++++++++++++++++-------
>   include/linux/blkdev.h        |  8 ++++++
>   6 files changed, 130 insertions(+), 11 deletions(-)
> 

