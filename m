Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00E1199FD0
	for <linux-block@vger.kernel.org>; Mon,  4 Nov 2024 07:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730706000; cv=none; b=RGHjonIeYOgumKtMufubs5nyp4Oe3FtUxpEvxnR8Piofl04e4KEFWpXYLtYPCLqUO8q7lc+JWlVvlZOq/4c8F9HozsPoVwHYN/Tu7u7wTXhmP5b1bNE2J2ACCdLJD4hgpgczmK6jB0y4cdnbA8oKGXD0SdPKezZpfiokrwHNB64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730706000; c=relaxed/simple;
	bh=Pps4OvGHAzfH4LZiuJIJ9mL82NywfPmKNUpT/xuZhrE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aF5tE9I33RBB9Se3jCoxRWx5l4tfRueROqvGCiSuovKO1bT9wQ2VBtqZX8uefMqWUXXX1hGQwHJtcKJPsy+qYl0cPf//d4+s1PutsFQtXHRQKyZciSTEKpVTNaqoP/fHbqKrSbG7LoW5zHuvxMWLBdrgRY4RpYXkWIKjD7g/pWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ewjUeA5+; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ewjUeA5+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=Kxu0R8y4w4mUvNpaw3wPNdPcFJqywKK0lIt3nvUl5hw=; b=ewjUeA5+Ju71Ssdi0R8dn0S6KY
	ngTP2XvMq0AwoUoXdA3wDKMNlewr+1P1AhkOAM5+vrb1/YQ5Qdg9hHabHI5plZpPBE+MRAaXq965b
	x/G8ISN2ZBSGxGl9k1pU3lS4eyqUy4VcXG7HHAVWFxdodF5lKwBv6Ug6TcgHc6qG68X7EhikgAxP2
	maDU+bPqaOHK8nCRs7dqNAhYMr/JQkrPFRzITwSSljOJoW3AEaaM/OTmW29Dz7po+I+S0VVoMw4vZ
	sReWaJ4GPi2LOl5pCTjH+D1MeE2uGqGzKWBdpco1vsdWdXR7rEzMoltVN0DM0sON3lMnyN4ySVS4U
	9A55VuMA==;
Received: from 2a02-8389-2341-5b80-c843-e027-3367-36ce.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:c843:e027:3367:36ce] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t7rgr-0000000Cs99-3NQZ;
	Mon, 04 Nov 2024 07:39:58 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	linux-block@vger.kernel.org
Subject: pre-calculate max_zone_append_sectors
Date: Mon,  4 Nov 2024 08:39:30 +0100
Message-ID: <20241104073955.112324-1-hch@lst.de>
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

Diffstat
 block/blk-core.c               |    2 +-
 block/blk-merge.c              |    3 +--
 block/blk-settings.c           |   25 ++++++++++++-------------
 block/blk-sysfs.c              |   17 +++--------------
 block/blk-zoned.c              |    6 ------
 drivers/block/null_blk/zoned.c |    2 +-
 drivers/block/ublk_drv.c       |    2 +-
 drivers/block/virtio_blk.c     |    2 +-
 drivers/md/dm-zone.c           |    4 ++--
 drivers/nvme/host/multipath.c  |    2 +-
 drivers/nvme/host/zns.c        |    2 +-
 drivers/scsi/sd_zbc.c          |    2 --
 include/linux/blkdev.h         |   21 +++------------------
 13 files changed, 27 insertions(+), 63 deletions(-)
