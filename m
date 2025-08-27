Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3268035AAB6
	for <linux-block@vger.kernel.org>; Wed, 27 Aug 2025 14:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756303998; cv=none; b=YkqxMwyJDPqtjvR5+4hMQBxJIUc5bahu0ohIHCKw7QVpned5JrSaVJIlaRi6ckEI/RbqzoL1wcHSGWaGNxKnLwXRC8lPHKJ9lgRJUEFIuAuU+n05FL6PH8lr/w76IRgcEiRSxC4IF4ottwOjvCC8qcYxOxh2tG6xSbV/tdozH/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756303998; c=relaxed/simple;
	bh=D+qLXcG8rjQNPu/cyOULZd20WAPqIqz3VONd48zdQik=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qdaQohGy2xuMCZ71xDhs2qPHD8SVr21jDHtqTTZsn7aXAc2WI706Rg6Obpa6Gc9Mz62NdF6nA6GeaMHibThilvKRKo7dwhwZ+9bsH4QY8H7pDLo5ztTOaJnyruQjhPEeYEmZId7uLweZE6VSBoGlhr9ii/xi3V68wTA0mzMI6dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=Na4uw6Gd; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="Na4uw6Gd"
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 57R7SJ0W1299130
	for <linux-block@vger.kernel.org>; Wed, 27 Aug 2025 07:13:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=/Qt6QVTxd6TJstz9g1
	J001UpoSAm0PdHWdX38furYnw=; b=Na4uw6GdU0LhMwQBAJgKpuJqv4+Uhp5UMz
	HUpE8Z/ZgSZiDqRM6w21Reo1lSIlX7s8Y5Lk2p1NduHGpH7TtKc3uWpqqEp0sV5S
	cl/fnHrNQ1WiUQ6eOSAwrisiiOqlmJ9Tps1mFOpgSs9zIoo75hgJW+9O7gwcwk/U
	+vO5Ti9iia156k57UnrzFYvXfEcIRVkaLCfbKRP/ZDIr+cYJT49T6xK6+1dAEuNh
	bLZ/L/UazcFVQbmwVOP2fpQUajwT01cueYyUs9pN7YwqjfuAskWaN/3Lqcg1S/jY
	4Gii457ywyb+iHq42No38CXr+kBptAekGZvL0YpXf4sXroUKXfTQ==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 48swmva0at-13
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Wed, 27 Aug 2025 07:13:11 -0700 (PDT)
Received: from twshared0973.10.ash9.facebook.com (2620:10d:c085:208::7cb7) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.17; Wed, 27 Aug 2025 14:13:06 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 7F14810CF611; Wed, 27 Aug 2025 07:13:03 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
CC: <linux-xfs@vger.kernel.org>, <linux-ext4@vger.kernel.org>, <hch@lst.de>,
        <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv4 0/8] 
Date: Wed, 27 Aug 2025 07:12:50 -0700
Message-ID: <20250827141258.63501-1-kbusch@meta.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI3MDEyMSBTYWx0ZWRfX7EdEIjFYm3WD
 39K1zW7tPu9RTkkyyKkf4KowL8i3GCAjiywRrpxAtMX6gt/ZmbHM1pzy2hxhLHo3rmQ9I7yRAdh
 V3Pm1xTbxmNiNBJCciiy6aTNpmzNIIhYIT9Vwpiol/ts+xeg6IVY5MaBwwj9aC5FDMqxEttW/rR
 NdYBzZM9CDtJo5mnBGlN6aVUY/GquEhu5jlXef7/9lDLERmKgo0k4+WLIWv7bWcEpHsQrKzWpch
 ce12xM7RLAveb3FhJjRlUXpJY4FIiDI5upXdCMOfxTLmJA7RJ0fRQ+GZwCJ1ay+7SnG3Q1rK8HZ
 Q/f50MoAfrZjwWIHE7U1qMV10HZs91X0rkamso1QCtaJNjZYBIKVFuY2aKuHpQ=
X-Proofpoint-ORIG-GUID: 92lmDyzfYmM22_i72a-S3evhDExjCpYO
X-Authority-Analysis: v=2.4 cv=NKnV+16g c=1 sm=1 tr=0 ts=68af1277 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8 a=bZ6uR2C94leCsy_9LK0A:9
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: 92lmDyzfYmM22_i72a-S3evhDExjCpYO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-27_03,2025-08-26_01,2025-03-28_01

From: Keith Busch <kbusch@kernel.org>

Previous version:

  https://lore.kernel.org/linux-block/20250819164922.640964-1-kbusch@meta=
.com/

This series removes the direct io requirement that io vector lengths
align to the logical block size. There are two primary benefits from
doing this:

  1. It allows user space more flexibility in what kind of io vectors
     are accepted, removing the need to bounce their data to specially
     aligned buffers.

  2. By moving the alignment checks to later when the segments are
     already being checked, we remove one more iov walk per IO, reducing
     CPU utilization and submission latency.

Same as previously, I've tested direct IO on raw block, xfs, ext4, and bt=
rfs.

Changes from v3:

  - Added reviews

  - Code style and comment updates

Keith Busch (8):
  block: check for valid bio while splitting
  block: add size alignment to bio_iov_iter_get_pages
  block: align the bio after building it
  block: simplify direct io validity check
  iomap: simplify direct io validity check
  block: remove bdev_iter_is_aligned
  blk-integrity: use simpler alignment check
  iov_iter: remove iov_iter_is_aligned

 block/bio-integrity.c  |  4 +-
 block/bio.c            | 64 ++++++++++++++++++----------
 block/blk-map.c        |  2 +-
 block/blk-merge.c      | 21 ++++++++--
 block/fops.c           | 10 ++---
 fs/iomap/direct-io.c   |  5 +--
 include/linux/bio.h    | 13 ++++--
 include/linux/blkdev.h | 21 ++++++----
 include/linux/uio.h    |  2 -
 lib/iov_iter.c         | 95 ------------------------------------------
 10 files changed, 92 insertions(+), 145 deletions(-)

--=20
2.47.3

