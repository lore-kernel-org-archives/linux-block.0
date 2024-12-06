Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AAE21D04A4
	for <linux-block@vger.kernel.org>; Fri,  6 Dec 2024 22:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733523853; cv=none; b=UMspn412sRzTP/2mkBuADiZu/XqMczEzs54Y3BsY6WeG7XNfuQ3NOnwVe3aJvtf4nng+4dbiWcyuth0B+af7pmqE5vUvG0IcRQUU8BLmT6zrahFjLdLF5AX/tUFSiIJeHsoLLNmas1utiIDcOa5fF33qN1pUrBOYc94Qyu646KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733523853; c=relaxed/simple;
	bh=r3koaxsuV7KRYMQQuL1iABt/DZExJ5OsjL7aJy+EW8s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=G/ecFXEB8GzQM8b7bMXX/4IxAdHFxcWre2ABnLFhoaXqjdZ+R5miCf2g0WHzzw0xxFTZdLj4BYtI+ZkZ+BCjcCa5EaHJBEh00Fs43vxEBT1laThiR7H8/BOSm47m9GSyiRWKqzbMDuUXdgVbOQJpuuhqonkh9vpvlkhZjimuWLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=eEBHxEti; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="eEBHxEti"
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B6Lh9qM030333
	for <linux-block@vger.kernel.org>; Fri, 6 Dec 2024 14:24:11 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2021-q4; bh=eoz5xj3OlJBjoZHpah
	qecFAxl1o6Z2RPCniU5IcA/qM=; b=eEBHxEti/bAnRVfXulFldRSKPWw0qFq2x3
	c3Pd8K+teNcXkJ43y4Rvw15j6ngrp0yz+2/71PSPPGQ5Q5bI942kZ1oHYMzxAvWn
	3m+AW+p3fSTvcbOnF6luXY34LojeckIwR+c92lK4sxzzjwvLdNqF8gTd+8vgyxRa
	YccmM14u33WBk9tWtmRmSt6+GHtjhEHP59Bvbry4R1VWyTt/m4kRhZsDCMrGPrX9
	KogTkr6c1+Wk/ngVKg9tM+8tsas+SZMQGRysb64IqssiCGNYbpoG9rVrGUV6T3Xq
	VS1p1TLllBFmv0khgSvNLB22T7fpU9hMZ1BTORyh87wynNYE7bPw==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 43c592taq2-15
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Fri, 06 Dec 2024 14:24:10 -0800 (PST)
Received: from twshared3815.08.ash9.facebook.com (2620:10d:c085:208::7cb7) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Fri, 6 Dec 2024 22:24:03 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id E2A8015B8CB67; Fri,  6 Dec 2024 14:18:26 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <axboe@kernel.dk>, <hch@lst.de>, <linux-block@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>, <linux-fsdevel@vger.kernel.org>,
        <io-uring@vger.kernel.org>
CC: <sagi@grimberg.me>, <asml.silence@gmail.com>, <anuj20.g@samsung.com>,
        <joshi.k@samsung.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv12 00/12] block write streams with nvme fdp
Date: Fri, 6 Dec 2024 14:17:49 -0800
Message-ID: <20241206221801.790690-1-kbusch@meta.com>
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
X-Proofpoint-GUID: O1Yyu9TcnErH0vAUkNbZc1l2VPVzSUeD
X-Proofpoint-ORIG-GUID: O1Yyu9TcnErH0vAUkNbZc1l2VPVzSUeD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01

From: Keith Busch <kbusch@kernel.org>

changes from v11:

 - Place the write hint in an unused io_uring SQE field
   - Obviates the need to modify the external "attributes" stuff that
     support PI
   - Make it a u8 to match the type the block layer supports
   - And it's just easier to use for the user

 - Fix the sparse warnings from FDP definitions
   - Just use the patches that Christoph posted a few weeks ago since
     it already defined it in a way that makes sparse happy; I just made
     some minor changes to field names to match what the spec calls them

 - Actually include the first patch in this series

Christoph Hellwig (7):
  fs: add a write stream field to the kiocb
  block: add a bi_write_stream field
  block: introduce a write_stream_granularity queue limit
  block: expose write streams for block device nodes
  nvme: add a nvme_get_log_lsi helper
  nvme: pass a void pointer to nvme_get/set_features for the result
  nvme.h: add FDP definitions

Keith Busch (5):
  fs: add write stream information to statx
  block: introduce max_write_streams queue limit
  io_uring: enable per-io write streams
  nvme: register fdp parameters with the block layer
  nvme: use fdp streams if write stream is provided

 Documentation/ABI/stable/sysfs-block |  15 +++
 block/bdev.c                         |   6 +
 block/bio.c                          |   2 +
 block/blk-crypto-fallback.c          |   1 +
 block/blk-merge.c                    |   4 +
 block/blk-sysfs.c                    |   6 +
 block/bounce.c                       |   1 +
 block/fops.c                         |  23 ++++
 drivers/nvme/host/core.c             | 160 ++++++++++++++++++++++++++-
 drivers/nvme/host/nvme.h             |   9 +-
 fs/stat.c                            |   2 +
 include/linux/blk_types.h            |   1 +
 include/linux/blkdev.h               |  16 +++
 include/linux/fs.h                   |   1 +
 include/linux/nvme.h                 |  77 +++++++++++++
 include/linux/stat.h                 |   2 +
 include/uapi/linux/io_uring.h        |   4 +
 include/uapi/linux/stat.h            |   7 +-
 io_uring/io_uring.c                  |   2 +
 io_uring/rw.c                        |   1 +
 20 files changed, 332 insertions(+), 8 deletions(-)

--=20
2.43.5

