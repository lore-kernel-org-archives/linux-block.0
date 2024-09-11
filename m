Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A781BC063
	for <linux-block@vger.kernel.org>; Wed, 11 Sep 2024 20:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726085580; cv=none; b=sxH9Woa7zyfWe4hiAhrAEGvZ/gWj6kbpqaSxCJg/SC/ZzzoQjjb1rUBJNbH8lFhm+7AIBZHUMXHfufkK2iebGvRXVxSzNOVdsoSLowaVIrQZGkFPGS8lZZlFPreSPNaYnh2+t6YOwhxudsWdXb6ldYQTKBNDvqa4ElTa6hb3CJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726085580; c=relaxed/simple;
	bh=AxrZkBM4T15MxKMDxb9xeBAgee7VFlRxEGLQfC7Nu+w=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LWehuJw0MpGcFS58kNJwLfld6uOHIGIYaWQObrNipuSitne0uMzJjDTppCH11N6QMmyfwYQxO7Xx1wstnn/eQl8hIsFNnXKyD2l5OLclX3rXSpv5DShBPvT+F9X1zgxL/sIryOR3aSkMVWIJWMJi6k8WruIvP+C60Hs/hn6YCe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=dwO5eQPM; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="dwO5eQPM"
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 48BHjWcI004157
	for <linux-block@vger.kernel.org>; Wed, 11 Sep 2024 13:12:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from
	:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=s2048-2021-q4; bh=LvD
	NngJGsWnatCyWW6vNi4OaEo2CnYyawxAlUHXUK4s=; b=dwO5eQPMAfqEQrJAdFF
	BQlrSXYCdox1DnS1KkpEbEQBR5EeLwwUDKkMnddw9N4Zof64jlTMsxaCUKbZIoj1
	grEUaZLsN49oyz+5IaKqcD6NOPmGFcCsKlS2RiGCoivMqHrd6D3pOx9H6QHfI5ut
	IQA+lHImKmoIkzO1fp6edRzx/nZ1thLlo6rYmT+yRcwAij5SNE/O0vwsSESc3uPl
	7PsrJSs9Y3JvK+nYZDFGfTe39USN9P4DsN6r3If6ouRGCVTjLl7MvWmf4wVICXDq
	swKzFfjiKw0stqYtRQ9F2ZHKC0Pf3dSQgg9Q7yRzVHgEf87GgwjRotdWh9Q5/CYL
	NOQ==
Received: from maileast.thefacebook.com ([163.114.130.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 41k44nnb2x-14
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Wed, 11 Sep 2024 13:12:57 -0700 (PDT)
Received: from twshared18321.17.frc2.facebook.com (2620:10d:c0a8:1b::8e35) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Wed, 11 Sep 2024 20:12:55 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id B204112E5EDA2; Wed, 11 Sep 2024 13:12:41 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <axboe@kernel.dk>, <hch@lst.de>, <martin.petersen@oracle.com>,
        <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <linux-scsi@vger.kernel.org>, <sagi@grimberg.me>
CC: Keith Busch <kbusch@kernel.org>
Subject: [PATCHv4 00/10] block integrity merging and counting
Date: Wed, 11 Sep 2024 13:12:30 -0700
Message-ID: <20240911201240.3982856-1-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: OgWpIRs_U4f43zZAiLovmjxprnSZHQXH
X-Proofpoint-GUID: OgWpIRs_U4f43zZAiLovmjxprnSZHQXH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-11_01,2024-09-09_02,2024-09-02_01

From: Keith Busch <kbusch@kernel.org>

Some fixes and cleanups to counting integrity segments when metadata is
used. This addresses merging issues when integrity data is present.

Changes from v3:

  Unconditionally define nr_integrity_segments. (Christoph)

  Dropped the "simplify" patches and the queue limits checks; they are
  not correct under some conditions. (Christoph)

  Fix a commit message typo. (Anuj)

  Reordered the driver patches to appear after the integrity segment
  count is accurate.

  Added a patch (5/9) that accounts for user mapped integrity segments.

  Added reviews.

Keith Busch (10):
  blk-mq: unconditional nr_integrity_segments
  blk-mq: set the nr_integrity_segments from bio
  blk-integrity: properly account for segments
  blk-integrity: consider entire bio list for merging
  block: provide a request helper for user integrity segments
  block: provide helper for nr_integrity_segments
  scsi: use request helper to get integrity segments
  nvme-rdma: use request helper to get integrity segments
  block: unexport blk_rq_count_integrity_sg
  blk-integrity: improved sg segment mapping

 block/bio-integrity.c         |  1 -
 block/blk-integrity.c         | 36 ++++++++++++++++++++++++-----------
 block/blk-merge.c             |  4 ++++
 block/blk-mq.c                |  5 +++--
 drivers/nvme/host/ioctl.c     |  6 ++----
 drivers/nvme/host/rdma.c      |  6 +++---
 drivers/scsi/scsi_lib.c       | 12 +++---------
 include/linux/blk-integrity.h | 13 +++++++++----
 include/linux/blk-mq.h        |  8 +++++---
 9 files changed, 54 insertions(+), 37 deletions(-)

--=20
2.43.5

