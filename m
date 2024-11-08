Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C976121B451
	for <linux-block@vger.kernel.org>; Fri,  8 Nov 2024 15:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731080823; cv=none; b=HxNdi0O+PLeOMI+Jmu7QPRi4XUP5vwuSv7gQX/7bT/Eb70AEoTTkM0MSLG3sYBLuvqK+jHIophfsFuepqdl/DDszk/WlRexyNiw5qpqQnUC4d8NA/JXUUTfZ6NzMX2oo87YzRRwHM3GNJXaj9AIRHzmUEIpIN6R+qRkAc4WCrS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731080823; c=relaxed/simple;
	bh=88d+6wfb0UrR/42b/sNvn9LX0rVa/mSkNRhBYrGSqVU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h/Ow8FDdAkxsgdJzDzSC4SJlaDoYbJYfzJoaohWRalqr+gvFJYIfThqM6U/VFe1wXLXRPOqP43DI39kgCFH68oj2IpZjaaxoELIic3Kvcai1XR+QGBBv+2SCPEbugu793BdUMllv2+a3EVS/3YKWHJLLsXgFxewZPw1L06wRePQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ozULE6o9; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ozULE6o9"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=a7BBTrefluilffRo02B3nDoKFwKVIGD/Aa03cCIMz18=; b=ozULE6o9tDFMUsJLYJPQ0hg6GK
	MG0lPk8wvTST/+xiLODyU53fYdnXXHDWJGp43dIClIGKM8Dh8H8fAzmo3wq07IFVjsRe+amCGxXxI
	q2KYdeoeUyL2ke9eT1s9eAAeLysILLPBxmisMCkKaKQTjhp7EC+5ct1xx0OCAarjtS42niPkXa1F2
	MsymkOmOwJXM1hLfX7lJpE8hUM1+VsmaroDSX73AD39sREW5DnL63wYDK1OmDZvDppDAz6myYCbJh
	ua52bSMOwxRgm1xAKcx+MG+pMWDWqvxcR0L6xT3QG3pQAdZ3OpdKwiCmbfu+2GhbaFrIDd2pyEw+p
	5WjrrESQ==;
Received: from [212.185.66.19] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t9RCO-0000000B5bU-2Vdb;
	Fri, 08 Nov 2024 15:47:01 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	linux-block@vger.kernel.org
Subject: pre-calculate max_zone_append_sectors v2
Date: Fri,  8 Nov 2024 16:46:50 +0100
Message-ID: <20241108154657.845768-1-hch@lst.de>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Hi Jens,

this series makes max_zone_append behave like the other queue limits in
that the final value to be used for splitting is pre-calculated.

Changes since v1:
 - fold in the previously posted fixup patch
 - add the nvme cleanup patch

Diffstat
 block/blk-core.c               |    2 +-
 block/blk-merge.c              |    3 +--
 block/blk-settings.c           |   27 +++++++++++++--------------
 block/blk-sysfs.c              |   17 +++--------------
 drivers/block/null_blk/zoned.c |    2 +-
 drivers/block/ublk_drv.c       |    2 +-
 drivers/block/virtio_blk.c     |    2 +-
 drivers/md/dm-zone.c           |    4 ++--
 drivers/nvme/host/multipath.c  |    2 --
 drivers/nvme/host/zns.c        |    2 +-
 drivers/scsi/sd_zbc.c          |    2 --
 include/linux/blkdev.h         |   21 +++------------------
 12 files changed, 27 insertions(+), 59 deletions(-)
