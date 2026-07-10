Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8ED3B95F9
	for <linux-block@vger.kernel.org>; Fri, 10 Jul 2026 21:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783718903; cv=none; b=o2jUQxtySeALTmgmiNb3GzSaXbT4ljZ4V9o2T0DWSmcAOGZPvzRTKZ45My3XfAiCipDsXwU6r14Bmd3VXRcq5WkrXuuWN4ffDzwGt4IFnC9jckeIp80zKPHON0F1Xq7F299me5eOjCbgI2dKPe6ir01KAMdFk9ek5DJWsEM0U7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783718903; c=relaxed/simple;
	bh=drvLsIkyjfu268Phst1WyvwriTIYDC4O6PS3gEwt+mM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aZBQMKP/Sh91Ibv5t5AJA8rvaS27qxJ8dm04FBkE0g+fAWBbBSNuk0z5E//ZKFVYJ/ibmy6TNwgPs8esZct569EW0mun2ggjA6EpxlSdt5FinORP2/lzv+b0dZqsGDgqNjpk8Qsh8Wci8WbHamYGKEkga0/+2jI5m8amdiFOHHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=mFgiNiGD; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="mFgiNiGD"
Received: from pps.filterd (m0528006.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66AK3iHV2557521
	for <linux-block@vger.kernel.org>; Fri, 10 Jul 2026 14:28:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=VAsEQB+ej52ISVSeW0
	QY/kgNMdTWYAu3CU+oqE/r7E8=; b=mFgiNiGDQoEhc4WqcH+Oj0O9r3VIaRJzUm
	tnOxDamaVTL5W3YD3aloSGAGkctXg8tL4MZxGUGEJC1gxEIdVx1oXMavdKoQhi4P
	oNql1IfHd+0nCdeN0h0JK2Dt6cji80ishzkA8Fi4thg/7ySexa2eNpWE6kIyc1j5
	5bRT3iAdf1RKrPU4Vi/jX62Z0E6RACSanDWXeqaQxYucY/p9rSqMkKaQ9J4zRZl7
	q/sy7EJnU0/o2CgTyb9Fp/fOgdkYfKhOxKXv7rrgHac6VAMmBsTEuQuL3/m6KaGH
	ChfFf4weqDMEWzDxn//8ph/y23/UOtc0MP1c0ivyPhCemnKHgZbw==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4fahqqqqp0-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Fri, 10 Jul 2026 14:28:21 -0700 (PDT)
Received: from twshared20290.04.snb2.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.41; Fri, 10 Jul 2026 21:28:20 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 46C7024F006F3; Fri, 10 Jul 2026 14:06:47 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-ext4@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-fsdevel@vger.kernel.org>, <linux-xfs@vger.kernel.org>
CC: <axboe@kernel.dk>, <jack@suse.cz>, <brauner@kernel.org>, <cem@kernel.org>,
        <jaegeuk@kernel.org>, <aalbersh@kernel.org>, <tytso@mit.edu>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCHv2 0/5] direct-io file extended attributes
Date: Fri, 10 Jul 2026 14:06:41 -0700
Message-ID: <20260710210646.3576365-1-kbusch@meta.com>
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
X-Authority-Analysis: v=2.4 cv=W5kIkxWk c=1 sm=1 tr=0 ts=6a5163f5 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=kkcUborcUVj0H7zxAXTl:22 a=VwQbUJbxAAAA:8 a=vYknhWM2Pyct8yg2-RQA:9
X-Proofpoint-ORIG-GUID: xbJFLmWOOLkxsnsuPkfrhzDXlyVTbqyC
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDIxNSBTYWx0ZWRfX1RcuhbbgwzV0
 icDIbA7wlulPS+aY9xN1wgXMC/gM8GpgoQdD9vHhLy/j66dGBhBJRQtisvAGtOtDGt0byGG+uYW
 cB1WjyG6OgkLXZSxWElUR7rWxVbsiYI=
X-Proofpoint-GUID: xbJFLmWOOLkxsnsuPkfrhzDXlyVTbqyC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDIxNSBTYWx0ZWRfX7LUEpWy1Yq3M
 JkrXDx4ARFcI+aD9mMkrhrJNTShD+6fbTlZwigpS6IGYlURiXrGxvyjJyV7UDtd7iqgwkLXsMfV
 WWJtuuyHvmIJYhQzrLXRyNK2xF9LtvgNiSGtCdChLoer7Y4uqjnZPGdbwMK6za4fpAi0E6wLRdZ
 MPx9z/s7/z0Xd3/Zc3HwbnqbE5edrA76HS+domTqHWpAsdxlEZaPtNhpWcyf4V2k9/qIeKyo7Mv
 qP2sd39mHL6JRvDt5jO8/1LnJ/gZruZ20nfHZqkcHzxXgaU4sAaEsYXDMpCT+YBECVvGy0qP7fM
 og93wP2cRz3jxrnXgKfTGLpqaELg9yuJraMDT5ZRQTTcHuyDViEaVCfBVjHN5o9KnPVZfsD51gJ
 Oqo/3/WT6uem8/Pywo0TnBsks1NHsfGkspIWW0diYs5cus2GX8QZtGEdEAPpQF18y8FnHKloLuO
 8uEk0PzIZU7FNm26Nmw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_06,2026-07-10_01,2025-10-01_01

From: Keith Busch <kbusch@kernel.org>

The attributes reported through statx are incomplete for applications to
fully know exactly how IO construction is valid or not. The statx call
can report minimum memory alignment and total granularity, but it
doesn't show the underlying gap boundary requirements or max segments
per granule.

This series adds the minimum to the extended file attributes through
file_getattr. I hear this is the preferred interface for reporting such
things over adding more fields to statx. In order to get everything
under a single syscall, some of the attributes are duplicated from
statx.

Keith Busch (5):
  fs: add direct io attributes to file_getattr
  block: report direct io attributes through file_getattr
  xfs: report direct io attributes through file_getattr
  ext4: report direct io attributes through file_getattr
  f2fs: report direct io attributes through file_getattr

 block/bdev.c             | 37 +++++++++++++++++++++++++++++++++++++
 fs/ext4/ioctl.c          | 23 +++++++++++++++++++++++
 fs/f2fs/file.c           | 20 ++++++++++++++++++++
 fs/file_attr.c           | 13 ++++++++++++-
 fs/xfs/xfs_ioctl.c       | 26 ++++++++++++++++++++++++++
 include/linux/blkdev.h   | 14 ++++++++++++++
 include/linux/fileattr.h | 10 ++++++++--
 include/uapi/linux/fs.h  | 10 +++++++++-
 8 files changed, 149 insertions(+), 4 deletions(-)

--=20
2.53.0-Meta

