Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EFDC230BF5
	for <linux-block@vger.kernel.org>; Tue, 10 Jun 2025 15:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749570277; cv=none; b=B+I7yGs8QIfGVOTR+mmW4WnbdGcfXb27bWtQS2WKyzZ/uLSwzB2jLxa/ZjYvf/fxOcIYhltI3jt8/ALhpFBLijf4KgzKilVqDxjvXT3BNpO2RW+HfJDJsjNc8EjLatLa5ZXh0GaEfMoyb0e+V8Hq165MfD9cJESLxWI55Uj9JWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749570277; c=relaxed/simple;
	bh=ISxoCFCmRXsUpNSGczd1kVqHWNdpvNVaMxoms2JqTlg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=IBPZ9/Z894VeyxGNY2ntprPkAGk7uqRTBDwqVseHODfXVCDIRqm1LibhueiE8jxMfLli6n9Vr9LW3BlKjXKRPM42DurVjvz8NvbAaKqIbaCB/iNOQh7LYd1wYxinLkcxddI+INXKbhFlLCXusljaH4eSLDnp0GIgpoi/sCZcids=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=U4b8AvRQ; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="U4b8AvRQ"
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20250610154432epoutp03792aefba4c8d0d4e36a8b1c333fd7caa~HuOSoJ81Q0751807518epoutp03E
	for <linux-block@vger.kernel.org>; Tue, 10 Jun 2025 15:44:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20250610154432epoutp03792aefba4c8d0d4e36a8b1c333fd7caa~HuOSoJ81Q0751807518epoutp03E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1749570272;
	bh=L8X4hXxhVSuvy6/B9Si9mWggFDjFgBGH46Jro7xLFFU=;
	h=From:To:Cc:Subject:Date:References:From;
	b=U4b8AvRQe7zQDBU71hXLLUFnMVFa6ZLAuJie2moBp1dyCpNjgBJ9Tj4hspm6cDA68
	 V1Uzow3p/EO37U/LSxsr3zVQzfEibA+ToapxrSdTR2ZtQN7ShjtTxNMpqE09lzsLj6
	 QDHJ3/pWPxYbgLXYzeFMf2+3mlyGXjoxMZrfrv+s=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
	20250610154431epcas5p2596c3b632de6acbc0110e76d0504d142~HuORUvCx_2914229142epcas5p2G;
	Tue, 10 Jun 2025 15:44:31 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.38.181]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4bGtQ52TKyz2SSKZ; Tue, 10 Jun
	2025 15:44:29 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20250610132307epcas5p4c6c107e84642a1367600afe9167655b8~HsS0wYsQn0586605866epcas5p41;
	Tue, 10 Jun 2025 13:23:07 +0000 (GMT)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250610132305epsmtip2aec7057574fbe3e85375ba723ad10890~HsSy_dkGh0336803368epsmtip2T;
	Tue, 10 Jun 2025 13:23:05 +0000 (GMT)
From: Anuj Gupta <anuj20.g@samsung.com>
To: vincent.fu@samsung.com, jack@suse.cz, anuj1072538@gmail.com,
	axboe@kernel.dk, viro@zeniv.linux.org.uk, brauner@kernel.org,
	hch@infradead.org, martin.petersen@oracle.com, ebiggers@kernel.org,
	adilger@dilger.ca
Cc: linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	joshi.k@samsung.com, Anuj Gupta <anuj20.g@samsung.com>
Subject: [PATCH for-next v3 0/2] add ioctl to query metadata and protection
 info capabilities
Date: Tue, 10 Jun 2025 18:52:52 +0530
Message-Id: <20250610132254.6152-1-anuj20.g@samsung.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250610132307epcas5p4c6c107e84642a1367600afe9167655b8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250610132307epcas5p4c6c107e84642a1367600afe9167655b8
References: <CGME20250610132307epcas5p4c6c107e84642a1367600afe9167655b8@epcas5p4.samsung.com>

Hi all,

This patch series adds a new ioctl to query metadata and integrity
capability. Patch 1 adds a pi_size field in blk_integrity struct which
is later used to export this value to the user as well.
Patch 2 introduces a new ioctl to query integrity capability.

v2->v3
better naming for uapi struct fields (Martin)
validate integrity fields in blk-settings.c (Christoph)

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
  fs: add ioctl to query metadata and protection info capabilities

 block/blk-integrity.c         | 53 +++++++++++++++++++++++++++++++++++
 block/blk-settings.c          | 37 ++++++++++++++++++++++++
 block/ioctl.c                 |  3 ++
 drivers/nvme/host/core.c      |  1 +
 drivers/scsi/sd_dif.c         |  1 +
 include/linux/blk-integrity.h |  7 +++++
 include/linux/blkdev.h        |  1 +
 include/uapi/linux/fs.h       | 43 ++++++++++++++++++++++++++++
 8 files changed, 146 insertions(+)

-- 
2.25.1

