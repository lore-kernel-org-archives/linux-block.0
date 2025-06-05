Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D079274FF0
	for <linux-block@vger.kernel.org>; Thu,  5 Jun 2025 16:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749142056; cv=none; b=NVK+nhz2g7O/e29jHeyoeyytw28vq1/Qzkq2/3qLlO8xhtYSPigQFhvJBmno/49Eyf8P51ggQi+3p1nsBVVF9f9IJNRPJVqRKqGfH+Z0l2SN3W1ExDLPLDKs05UVl7G/o9iot5kYal4a8K4Z6odKwFn2VGOKircbox22nQTkpxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749142056; c=relaxed/simple;
	bh=Bi0R0f5PD2dLe5rlr7+ocPQbwyo+oE9pViITFmEc+Z8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=iedAq9uMAe6whuofWzEKb0RVkVxfuCQfKAH3wo4xyUNxpUWVDvg0eTrDY8dxz+9RTcDAz/3UvPR2j9iKra9SAhg8pnnDoXBUjKzGWRgaaR2fdnGpOAnnXPhoPOnxJNdt3oSfDui/Z2lQT2ERBIW2kXDzfI29C0fh4jU6CjBby8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=I6O94Fd8; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="I6O94Fd8"
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20250605164727epoutp03d71ac6c4689886db2a97ab38c480db7b~GM2ysRrYb2991229912epoutp03z
	for <linux-block@vger.kernel.org>; Thu,  5 Jun 2025 16:47:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20250605164727epoutp03d71ac6c4689886db2a97ab38c480db7b~GM2ysRrYb2991229912epoutp03z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1749142047;
	bh=YR0PDLL8uMHjI8WNgud2b1l4O2VchN+C0PbvY2VuZUk=;
	h=From:To:Cc:Subject:Date:References:From;
	b=I6O94Fd85KKYWRClfAl5sJD/esQBZV6T6JDeOd6y+zJTc8pzX0hCVtQLyxufUXEkw
	 v4xTCTYEfKClAtjLGy3g+ZYnQqXdzJbOybsyq7UIHyLFZYhtxLZzUNTk5fMcH2yfSI
	 xFWaoq+kz/VNgbntDPf0xOW/4piwYWmu9SRPgBvs=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20250605164726epcas5p3feefee1eeab0b33509d7c71d667a3032~GM2yJL2Uh0580405804epcas5p3v;
	Thu,  5 Jun 2025 16:47:26 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.38.176]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4bCr304g5Cz6B9m4; Thu,  5 Jun
	2025 16:47:24 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20250605150741epcas5p4e5cd0b21137fa714006f44045ff272e2~GLfsW6BN41032710327epcas5p4J;
	Thu,  5 Jun 2025 15:07:41 +0000 (GMT)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250605150739epsmtip1e4c5b39091f5620308195b81190ec0b5~GLfqoonqV0294502945epsmtip1g;
	Thu,  5 Jun 2025 15:07:39 +0000 (GMT)
From: Anuj Gupta <anuj20.g@samsung.com>
To: vincent.fu@samsung.com, jack@suse.cz, anuj1072538@gmail.com,
	axboe@kernel.dk, viro@zeniv.linux.org.uk, brauner@kernel.org,
	hch@infradead.org, martin.petersen@oracle.com, ebiggers@kernel.org,
	adilger@dilger.ca
Cc: linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	joshi.k@samsung.com, Anuj Gupta <anuj20.g@samsung.com>
Subject: [PATCH for-next v2 0/2] add ioctl to query protection info
 capabilities
Date: Thu,  5 Jun 2025 20:37:27 +0530
Message-Id: <20250605150729.2730-1-anuj20.g@samsung.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250605150741epcas5p4e5cd0b21137fa714006f44045ff272e2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250605150741epcas5p4e5cd0b21137fa714006f44045ff272e2
References: <CGME20250605150741epcas5p4e5cd0b21137fa714006f44045ff272e2@epcas5p4.samsung.com>

Hi all,

This patch series adds a new ioctl to query integrity capability.
Patch 1 adds a pi_size field in blk_integrity struct which is later
used to export this value to the user as well.
Patch 2 introduces a new ioctl to query integrity capability.

v1 -> v2
introduce metadata_size, storage_tag_size and ref_tag_size field in the
uapi struct (Martin)
uapi struct fields comment improvements (Martin)
add csum_type definitions to the uapi file (Martin)
add fpc_* prefix to uapi struct fields (Andreas)
bump the size of rsvd and hence the uapi struct to 32 bytes (Andreas)
use correct value for ioctl (Andreas)
use clearer names for CRC (Eric)

Anuj Gupta (2):
  block: introduce pi_size field in blk_integrity
  fs: add ioctl to query protection info capabilities

 block/blk-integrity.c         | 41 +++++++++++++++++++++++++++++++++++
 block/ioctl.c                 |  3 +++
 drivers/nvme/host/core.c      |  1 +
 drivers/scsi/sd_dif.c         |  1 +
 include/linux/blk-integrity.h |  6 +++++
 include/linux/blkdev.h        |  1 +
 include/uapi/linux/fs.h       | 38 ++++++++++++++++++++++++++++++++
 7 files changed, 91 insertions(+)

-- 
2.25.1

