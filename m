Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE32A8633A
	for <linux-block@vger.kernel.org>; Tue, 10 Dec 2024 20:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733861079; cv=none; b=XvblKacrkmniVHgPesNq49At8p+nIwhC+mqjfZMMevdsPEuww/29TpCUR4bH29o1IjJUkVb9SZnRZA0NWQBzREFz8tBVBnTcJq2rKS2jOMDmFYPT9e6gAlZckLd0QUJt/88Xsbq8tEmP5yTGpvaKyElVBgtQn9LRvn42jePD1F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733861079; c=relaxed/simple;
	bh=x5FAuAHlWfJxZCfiPnAfDv6VsD0ypUIU+reJg7JyMuQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nJSpN2YAYGt6U7sg99n0p09y+rxipDa3OQimJiANnu3w+VOIZQ6JxICN3IX5MEudEKfceRYgzFPMoqZLDQs1/O7tKIXrXiUaNRJfNFEDboYaBJOENDPIfkqQ949puiHTEXRq009S0+84nqDG2d1bN8MeVXddWlb7f7oiqj84o8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=i1/Lxjyt; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="i1/Lxjyt"
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 4BAHYWri021380
	for <linux-block@vger.kernel.org>; Tue, 10 Dec 2024 12:04:36 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2021-q4; bh=ZtDYxbjHiaugtFmzLq
	be9j/YPTnjBLHkM7Z0sBvStvs=; b=i1/LxjytsrUE2esRwd3xvkCBcnoiRiXuyU
	pbeKfuULkMjMu0pa+MTaqto5feRfwEeTIeHQF1QgRbTZfCjzLDfwXgPC27TsvqYV
	5gb2ODWwzrYYP7V57XvJDs/tZROnH8DWmBkW/c74Ms8mnkQ0fcsGn+zzPEPGzTLb
	GnT45+0dFOv9r7UHNNP1fxNDqZXJShVHfCyiixEztSlanHuXDtzRqW8KMzDEtLy/
	T8eSGXHqBDMmmL7RiixMCDLGK2vxfT9zCTyNZkbxKdHdoM0oxaaQOgu/0kF5U78F
	kpTpOMzIyAYV8074XVkLyHhwgAPyd8uZlhFUfG0Mvp2w0artKgAQ==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 43et5dh8cs-12
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Tue, 10 Dec 2024 12:04:36 -0800 (PST)
Received: from twshared9216.15.frc2.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Tue, 10 Dec 2024 20:04:31 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id 207B715D5C7B7; Tue, 10 Dec 2024 11:48:08 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <axboe@kernel.dk>, <hch@lst.de>, <linux-block@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>, <linux-fsdevel@vger.kernel.org>,
        <io-uring@vger.kernel.org>
CC: <sagi@grimberg.me>, <asml.silence@gmail.com>, <anuj20.g@samsung.com>,
        <joshi.k@samsung.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv13 00/11] block write streams with nvme fdp
Date: Tue, 10 Dec 2024 11:47:11 -0800
Message-ID: <20241210194722.1905732-1-kbusch@meta.com>
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
X-Proofpoint-GUID: 7hMb98Q2Diudf5W5SeDMVnHbWdvZ73ss
X-Proofpoint-ORIG-GUID: 7hMb98Q2Diudf5W5SeDMVnHbWdvZ73ss
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01

From: Keith Busch <kbusch@kernel.org>

Previous discussion threads:

  v12: https://lore.kernel.org/linux-nvme/20241206221801.790690-1-kbusch@=
meta.com/T/#u
  v11: https://lore.kernel.org/linux-nvme/20241206015308.3342386-1-kbusch=
@meta.com/T/#u

Changes from v12:

 - Removed statx. We need additional time to consider the best way to
   expose these attributes. Until then, applications can fallback to the
   sysfs block attribute to query write stream settings.

 - More verbose logging on error.

 - Added reviews.

 - Explicitly clear the return value to 0 for unsupported or
   unrecognized FDP configs; while it's not technically needed (it's
   already 0 in these paths), it makes it clear that a non-error return
   wasn't an accidental oversight.

 - Fixed the compiler warnings from unitialized variable; switched the
   do-while to a more clear for-loop.

 - Fixed long-line wrapping

 - Memory leak when cleaning up the namespace head.

 - Don't rescan FDP configuration if we successfully set it up before.
   The namespaces' FDP configuration is static.

 - Better function name querying the size granularity of the FDP reclaim
   unit.

Christoph Hellwig (7):
  fs: add a write stream field to the kiocb
  block: add a bi_write_stream field
  block: introduce a write_stream_granularity queue limit
  block: expose write streams for block device nodes
  nvme: add a nvme_get_log_lsi helper
  nvme: pass a void pointer to nvme_get/set_features for the result
  nvme: add FDP definitions

Keith Busch (4):
  block: introduce max_write_streams queue limit
  io_uring: enable per-io write streams
  nvme: register fdp parameters with the block layer
  nvme: use fdp streams if write stream is provided

 Documentation/ABI/stable/sysfs-block |  15 +++
 block/bio.c                          |   2 +
 block/blk-crypto-fallback.c          |   1 +
 block/blk-merge.c                    |   4 +
 block/blk-sysfs.c                    |   6 +
 block/bounce.c                       |   1 +
 block/fops.c                         |  23 ++++
 drivers/nvme/host/core.c             | 186 ++++++++++++++++++++++++++-
 drivers/nvme/host/nvme.h             |   7 +-
 include/linux/blk_types.h            |   1 +
 include/linux/blkdev.h               |  16 +++
 include/linux/fs.h                   |   1 +
 include/linux/nvme.h                 |  77 +++++++++++
 include/uapi/linux/io_uring.h        |   4 +
 io_uring/io_uring.c                  |   2 +
 io_uring/rw.c                        |   1 +
 16 files changed, 341 insertions(+), 6 deletions(-)

--=20
2.43.5

