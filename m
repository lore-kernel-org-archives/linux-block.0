Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859A571B51
	for <linux-block@vger.kernel.org>; Tue,  2 Jul 2024 15:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719933054; cv=none; b=IIFA1zf6hBg/Fdn1k0pELAop1gijb4SeCzwiOP8j29U1hht+dzL5OACuQ6lVmO9Iv8Fg36lOgpZO9DIjemG1zinIKLNAlIUGpG9Z2DrvKCYPDHuyjYEOjjWTQzWb9tp/+hvcYQB1DOFsOLqhWwwP+mWIm2TD6cMb/00x8SeHM50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719933054; c=relaxed/simple;
	bh=r+sA2FkVHZlrGE0E+NOGsx8k0tByT0MbeIv2MCAHOFA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BTI13kGo4waTNbwBd/KNvQSfte+HkEVrb5Yw19RBEgV7WqBbvygwjL2WgatBQ/DRbKfOQri7JfojGZXsnc4eMmFDJr+kfV7IRfegAkLbcAgpQzNXGZDRa9Iqwtjm2D605pyUdyyAcwLS9+ufmy96drAMAImN+47tcps7fZP1g8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=eA4q2Wrb; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eA4q2Wrb"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=Y5Qjwm1FX2Sbd3iwFDEtKhm+rBtic7SLBqwOHCOMh20=; b=eA4q2WrbIbxrWvUVfmR36L0Lvh
	YhlnIWfMu7oSz7dtLwyCSJ4ld51XeZChiIhHxqZ6Z1w1ynMgZepZB13zsMsEdTRKNXxUqPCT7ceZc
	2lbKv44hCwfbpNSFgl5NPfzN9dAXusaSqeZlnw+Xngq9bdawNK0PXuJhVj+jtRWydhCeOV56gPDEZ
	dfxdA8P/qih1232KAXHATjOfBirwTqlA8hZrUpcg3SIMpHbLXO40bTnEMQ0eB7CDOQeO2OfbYi/UZ
	KGYdplGcsTNPB+SJ4l7HWygg+SrwoI/t3fkhMy/mjXk+0F6ApPQM9I7J/2VxZdCU8EAckON97WcVY
	+Z7i+AGA==;
Received: from 2a02-8389-2341-5b80-4c69-cf21-4832-bbca.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:4c69:cf21:4832:bbca] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOf9d-000000079T2-1c0a;
	Tue, 02 Jul 2024 15:10:50 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
	Anuj Gupta <anuj20.g@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	linux-block@vger.kernel.org
Subject: more integrity cleanups v3
Date: Tue,  2 Jul 2024 17:10:18 +0200
Message-ID: <20240702151047.1746127-1-hch@lst.de>
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

This series is based on the block for-next branch as there are
conflicting changes in 6.10-rc but not in the for-6.11/block branch.

Changes since v2:
 - stop calling bio_uninit in bio_endio
 - fix a commit message typo

Changes since v1:
 - rebased to for-next

Diffstat:
 block/bio-integrity.c         |   87 ++++++++---------------
 block/bio.c                   |   16 +++-
 block/blk-map.c               |    3 
 block/blk.h                   |   14 +++
 block/bounce.c                |    2 
 drivers/md/dm.c               |    1 
 drivers/nvme/host/ioctl.c     |   16 +---
 drivers/scsi/sd.c             |    3 
 include/linux/bio-integrity.h |  152 ++++++++++++++++++++++++++++++++++++++++
 include/linux/bio.h           |  156 ------------------------------------------
 include/linux/blk-integrity.h |    1 
 11 files changed, 222 insertions(+), 229 deletions(-)
