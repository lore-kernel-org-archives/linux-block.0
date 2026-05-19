Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC7C3DB33B
	for <linux-block@vger.kernel.org>; Tue, 19 May 2026 17:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779211447; cv=none; b=sm9spUcV3XS5vv66BMkX+sr7gnJcuUac1dhXyXUh9mYDWwHBv3qEKLsrrqF8YI06cYv9zx0LDbizplICJbJZ/oykIMo0OkGvhoWfwddkHXiVIp5sW6OXj/48aMkFVc18CSo32RtSvYkC8XgvEp5DlxdrygB5i6N2fU3mTDuLUQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779211447; c=relaxed/simple;
	bh=4Z844Wx5vy5WEHnGZ49LAjPBn2KTUPSmZyhnG6oNiOk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Cpr/BZt2/upuXlVVd/cTeRWK2UmekOsQD1H0/DgUcIg9FH9MtCAIaWn9UBsP4fbgvJF3x1BGqbw3Q1OXZNyRcv3uj3IJZ3uguIymhtFTwCSneEJ0P5rJe5JDtQ9Xx/rkfy/oTULkDHzoXjAof59WVZlXGYSBYoCxx3wbNfkhipU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=GxE2RR/8; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="GxE2RR/8"
Received: from pps.filterd (m0528006.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64JF5Seu1456212
	for <linux-block@vger.kernel.org>; Tue, 19 May 2026 10:24:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=DgSDBglcHMWndZa8ia
	pvzamBLG1cvjdm8KJL+W9JABU=; b=GxE2RR/8JD5zU7w9Lgemx3/pXoABU3tt4j
	CtJzH2OWlZ9i077DrdPmoqqEW60ZmsP3G8+8BvlsQiBFL9h17piNaq5er6mzTciL
	QTrhyMC1N89a5KmOiAHZzguSaRwKuzEk6KVw/5pfEotipKwZAapl2ij2q0MsUuti
	QJaeuzargJbeamXKq8ULSsGPgBvSDVEWGiUZ2vsXZe7oZnFZCH0UKE5/jTYbSpV+
	Xj4XeiZ8TVJ3fOye0BSIqplZLc5S6YQp7pAdNtItplHZDLZ+HXPeJaoWiPuMkT7p
	lbLK2r6+c28nk+uaLHCiDWfc6XL88GAyqoW9ygODK2un0xMQCBNQ==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4e797hx8ga-11
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Tue, 19 May 2026 10:24:04 -0700 (PDT)
Received: from twshared132777.16.frc2.facebook.com (2620:10d:c0a8:fe::f072) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.37; Tue, 19 May 2026 17:23:54 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 0BCA41A75976E; Tue, 19 May 2026 10:23:31 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>
CC: <axboe@kernel.dk>, <hch@lst.de>, <tom.leiming@gmail.com>,
        <coshi036@gmail.com>, <Igor.Achkinazi@dell.com>, <dlemoal@kernel.org>,
        Keith
 Busch <kbusch@kernel.org>
Subject: [PATCH RFC 0/5] block: validate bios against queue limits in the entered context
Date: Tue, 19 May 2026 10:23:21 -0700
Message-ID: <20260519172326.3462354-1-kbusch@meta.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDE3NCBTYWx0ZWRfX2NyX7w/V5J0L
 +lr/oYW1V2kMn7t9YJaH0tDZCuStm9qZBjUgR+IeCLwfa3dbhSTKPHwGKhbUgXG3wBX9mOkN021
 NmCkscqHR9cXNHosCsI8dfvQWJgA7jEiXu06v5iLlpMhMz2bOzcfbwtwTwpkjeCVCdUBpxYasUt
 4ycJdnafd/w4urUi3frbWMLml80C198ocEbzbspDxJzbpJ4RVlbiGKy9tfH7zSJeBOTp9rPOuab
 rzHt6xJ9eC71SZEDInbkUPzvi035l6n1+ToZgaQcIgn8y1Cimg1CBrLqtSyQJmj2P4tddVyLse/
 5p/q2Vbpte3gTLq9A4AtzCNgcaDUSRStBQBJOWmUX1ROQFvw7MQKNWXGUhYr6hms3eRRCn9XLVC
 bERwxrbH6xczQCpTfUIcelXJmj7LrAGE3JZufLGZvoqw4jnfE2oH8+kXD5i787zlwCvRhm2NZqM
 TbAkLGYW87e84gVXcGg==
X-Proofpoint-GUID: Opw0-XzNI_OwG-vDaCg5VZFAFJsJ2nKb
X-Authority-Analysis: v=2.4 cv=VscTxe2n c=1 sm=1 tr=0 ts=6a0c9cb4 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=kkcUborcUVj0H7zxAXTl:22 a=VwQbUJbxAAAA:8 a=UqCG9HQmAAAA:8 a=pGLkceISAAAA:8
 a=CmBJLTqHQE19MeuuKJcA:9
X-Proofpoint-ORIG-GUID: Opw0-XzNI_OwG-vDaCg5VZFAFJsJ2nKb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_05,2026-05-18_01,2025-10-01_01

From: Keith Busch <kbusch@kernel.org>

The block layer validates bios against various queue limits and device
capacity in submit_bio_noacct(), but these checks run before
bio_queue_enter(). This means they are not serialized against drivers
that update queue limits inside a freeze window. A bio that passes
validation under old limits can enter the queue after the update and
reach the driver with an invalid configuration.

This series moves all limit-dependent validation into
__bio_split_to_limits(), which runs after the queue usage reference has
been acquired. This ensures proper serialization against limit updates.

This changes was motivated by a few recent reports:

  https://lore.kernel.org/linux-nvme/MW5PR19MB548483D1FAE4F322E4C97352FD0=
32@MW5PR19MB5484.namprd19.prod.outlook.com/
  https://lore.kernel.org/linux-nvme/20260517053635.2282446-1-coshi036@gm=
ail.com/

When an NVMe namespace that is reformatted to use extended metadata that
can't be controller generated/stripped, the driver sets capacity to 0
inside a freeze window because the block layer is not able to form a
viable request for this format.  But a bio that passed bio_check_eod()
before the freeze can still reach nvme_setup_rw() after the update,
triggering a WARN that we didn't expect to be possible of reaching.

For NVMe multipath, moving these checks into the entered context
exacerbates a different problem: a bio targeting a path being torn down
(capacity set to 0) would be failed by the block layer before the driver
gets a chance to redirect it to another path. This is a pre-existing
problem, but the initial changes in this series make it easier to hit.
The series addresses this by introducing a new callback to
block_device_operations, called from bio_io_error(), that lets the
driver intercept and redirect failing bios before they are completed.
NVMe multipath uses this to requeue bios back to the head device for
path re-selection when the path is no longer ready.

Note that callers of submit_bio_noacct_nocheck() (bio split, throttle
dispatch) will now hit the validation checks in __bio_split_to_limits()
that they previously bypassed. This is intentional: these checks must
run in the entered context to be properly serialized, and cannot be
skipped so it is a performance cost that can't be avoided.

Keith Busch (5):
  blk-mq: fix status for unaligned bio
  block: fix invalid zone append status codes
  block: validate bio bounds in the queue entered context
  block: move bio operation validation into __bio_split_to_limits
  block, nvme: add failed_bio callback for multipath bio failover

 block/blk-core.c              | 144 ----------------------------------
 block/blk-mq.c                |   3 +-
 block/blk.h                   |  89 ++++++++++++++++++++-
 drivers/nvme/host/core.c      |   1 +
 drivers/nvme/host/multipath.c |  26 ++++++
 drivers/nvme/host/nvme.h      |   2 +
 include/linux/bio.h           |   6 --
 include/linux/blkdev.h        |  16 ++++
 8 files changed, 133 insertions(+), 154 deletions(-)

--=20
2.53.0-Meta

