Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C489D3BB4A
	for <linux-block@vger.kernel.org>; Thu, 28 May 2026 01:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779930074; cv=none; b=RKuRzBcoeQN3wTDo+LZmZLhyV+o/Odg9qE+VrjAKvQlRWqUXNn06XlwpOiCv9aB2QwHGh82HJfHd69+i9Kk8M1EVvj+Myg/JMHBsj7eO2UTXbytA8BTVM6S8RTM5vQOPJ5tr50RPrXdzTo8Tu6Q5LwUHkLy4QKnaEQiRvk0XG6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779930074; c=relaxed/simple;
	bh=bS2/5+LYYJaPbbnd1pcag8Lap7p35E/28UnS0i/CVow=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fAcASLRNfZKFyjKBzMrnqlprrDoPDj76CWhrFvGr99AOKoLv+QpE/VQ9r8QQ7EavUluCPiOSYy+M2g3gsL3P4/O3scSdOi5LhIZDatJ2vo72Sp7CbRa4nGnqlI9y4TQlsB/pXMuzCnhKDwC4T4eBrnFyJg3/5BJPlpSefTlpNpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=Dp2LTjlg; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="Dp2LTjlg"
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64RKkthx2812561
	for <linux-block@vger.kernel.org>; Wed, 27 May 2026 18:01:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=u6bDNB2VRw04jTLm2H
	XVwn98cjhg5mUaN35N0g7+xas=; b=Dp2LTjlgi0TNq0k4S2pcL5TfaB2iPFgVXO
	ftBNKMN1yB+l/1IKFDcJYeOfAR8KGikjhqWJdQ5baOWJHQFDSjZsZFuWRdo+g+zt
	K7iYuUT+xJEbSGyfUtNXHwz6kSCWsT4O37xRbgkiqul3oUBfolsanq1pkvIhUXEU
	a9mZf9pjsLMYqPs/+pvC5+j17AEJOOQX5L1r4aY9XRJBqrRvwfnDaj5wjM90ds7J
	vyy2BeWfeGINo5TpEgea4YQU334umy0CDNzwxgf9Wlb22iy5FbcCY91xAM0FLa+m
	lWo/BLvtUiBZxD5zY1IjdUZazG1Bz0d9kTAiT0w9hFbrsUyRsmfw==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4ee7x898pj-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Wed, 27 May 2026 18:01:13 -0700 (PDT)
Received: from twshared12601.02.snb2.facebook.com (2620:10d:c0a8:1c::11) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.41; Thu, 28 May 2026 01:01:11 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 0A07F1D39B573; Wed, 27 May 2026 18:00:58 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>
CC: <axboe@kernel.dk>, <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv3 0/2] block, nvme: enable passthrough iostats
Date: Wed, 27 May 2026 18:00:39 -0700
Message-ID: <20260528010041.1533124-1-kbusch@meta.com>
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
X-Authority-Analysis: v=2.4 cv=GshyPE1C c=1 sm=1 tr=0 ts=6a1793d9 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=PAz_-FQ8hEVmOPYdF0yf:22 a=VwQbUJbxAAAA:8 a=D1VwSchhwDu8_UvpV7sA:9
X-Proofpoint-ORIG-GUID: 7ELE8K5IMYBA5tNhZGKzyfjx1lt8pJYd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDAwNyBTYWx0ZWRfX45s5X0HA3vbB
 fh7hmCLn0CfKQkqMU3vIR81QpM7ySgf8saq78DOi3Qq1eG/lAPH5Hafv82ZyiI1qELMHiTFf1P4
 AJh6Bw6y8kHvJj0iStinNyx6QoJgZYCVYmw41Nn9/awMB4TlnPWvBI/w7jhfYOVCU93KsqAyfXC
 T0JUonBhQwM1n0S2yzk6ACxnDs0t1BJ6kqmNO4x6vSh4uxIX0El6V7+q4+PtpZME8sPbTz2DKt0
 Ui+HgPMwcuAUIphd3eZxBiicTBtTqQurv4xArQr9KvUYr5Suo1Ho2ON/hOuW7R08ZAWhK4okEwD
 skMiK7kN2CRy/TUhfasxR7uKfruIgEgh2tjyGX8atcfNYN/rHb8vvHJO9bBpHFkWy6MKSwVqKv8
 v6PZiksy6jFXcdj7KCxIj5SpDZonATS0ZbxSpzEXMJaKTTDoxXYPkQWJtVl0/jPZfriZ2cyPuGH
 w0Z0LHPDFCcCf5Ou1cA==
X-Proofpoint-GUID: 7ELE8K5IMYBA5tNhZGKzyfjx1lt8pJYd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-27_05,2026-05-26_03,2025-10-01_01

From: Keith Busch <kbusch@kernel.org>

v2->v3:

  Added kerneldoc for the exported API

  Added code comment for the passthrough safety

  Added reviews.

Keith Busch (2):
  block: export passthrough stats enabled
  nvme: add support multipath passthrough iostats

 block/blk-mq.c                | 32 +---------------------------
 drivers/nvme/host/ioctl.c     |  9 ++++++++
 drivers/nvme/host/multipath.c |  5 ++++-
 include/linux/blk-mq.h        | 40 +++++++++++++++++++++++++++++++++++
 4 files changed, 54 insertions(+), 32 deletions(-)

--=20
2.53.0-Meta

