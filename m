Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A86154434
	for <linux-block@vger.kernel.org>; Fri, 28 Jun 2024 13:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719581263; cv=none; b=cLyBSJPBc3+zSdmEBcowYhB3qqvQ26yfm66VbOEmC3vDwCvGOqnQliLmMkbQdkL+1bhJGjP51HVxUrJGHsaJATEWvdwyySesfoLxDcSHXput/QqgXVaw2pHY6cq0mH2+Rp3/hnbcoXwgIRVmZCJNXWpM0G+UfjY6otFsLz4N9DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719581263; c=relaxed/simple;
	bh=3RYyCve9fBaCd3sVysObzta/9qA1XjoZTMiL8eknpwo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NebOCEnFLEUiac522bCspV5SRXqOjwmuTj6MG7+ryZ0Vmp324x/hSpP+nP6Jja142D0MyvqSvBT1NHJYymvBKHGcrdjpEqmiYKDlWGz0FBOIV+T/HyLPZxiiozQAVdGwwsLOdeIzNTo+IzaW1hX8EFC8nH2l2epvRJzF9Ooz3Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ivIYB52l; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ivIYB52l"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=Zv9YbWEvnorFqc4yX53k0TQvswQLzqz9rivScuYKhpc=; b=ivIYB52lPl8EKIJUE2gerUyVEq
	MoxUSZE2YLithVTbu3I5dKn2vP1z4r2uGIVA/6mQ72wDPqnE44VwvwM89PUjtBBpZyu/kbe7nY3bT
	0j+RAK5pXB3c2UeBFSIVQbkzAAM5YMt6NR0Mc7lQ9KfuD/jPkffMMwRODNC0UtRausWEA0gKxyrew
	70GmfX0CDRLKyQpGRlFLdfKIhCI31WIt9zh4ORiUCpDseMhALKLKetwdK5UHu8wkddmadbFhQ6wKv
	dtPsJA4zmsnyNzrgwvpSdwStYkMF0LXTlWBfyUfX8BUNoCxtEGCY/UdvE+2XnQZM1rBpVKz5RS34l
	udguqTTw==;
Received: from [2001:4bb8:2af:2acb:3b26:86b1:bdec:6790] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sNBdb-0000000Dohm-3ExQ;
	Fri, 28 Jun 2024 13:27:40 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
	Anuj Gupta <anuj20.g@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	linux-block@vger.kernel.org
Subject: more integrity cleanups
Date: Fri, 28 Jun 2024 15:27:16 +0200
Message-ID: <20240628132736.668184-1-hch@lst.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Hi Jens and Martin,

this series has more cleanups to the block layer integrity code.
It splits the bio integrity APIs into their own header as they are
only used by very few source files, cleans up their stubs a little
bit, and then in the last patch change when the bio_integrity_payload
is freed when it is not owned by the block layer.  This avoids having
to know the submitter in the core code and will simplify adding other
consuer of the API like file systems or the io_uring non-passthrough
PI support.

It sits on top of the previously sumitted "integrity cleanups" series.

Diffstat:
 block/bio-integrity.c         |   56 ++++++---------
 block/bio.c                   |    2 
 block/blk-map.c               |    3 
 block/blk.h                   |    5 +
 block/bounce.c                |    2 
 drivers/md/dm.c               |    1 
 drivers/nvme/host/ioctl.c     |    1 
 drivers/scsi/sd.c             |    3 
 include/linux/bio-integrity.h |  153 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/bio.h           |  152 -----------------------------------------
 include/linux/blk-integrity.h |    1 
 11 files changed, 192 insertions(+), 187 deletions(-)
