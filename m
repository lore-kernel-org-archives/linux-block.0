Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1381F371D0E
	for <linux-block@vger.kernel.org>; Tue, 26 May 2026 15:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779809972; cv=none; b=QllrTN/aBOHWbl+BFbtAjx2/+pRKiq7Tiw4kHUel30GlJxySgjmju7FEjeA4aUFWr2+bmgW6sc+7Zh9xGvncac7foWsP0Fy8YZTjTXmkR76z9Jx+6uLdRe760b3/M3Ed70C1nHzRYt390mz9r3qldniOqTUgsrsXwPavPx8MffM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779809972; c=relaxed/simple;
	bh=Y+dE3Q4ahAq0gGLVcU/Nat84aNx2XvHkctzPWeJBLBI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=te26nnC3DF6LkKXNpqEep7SlE4cbp20Xy0K9LdzKnse960UAAepGB+Ou5oDBpLQkxlLr3ZfECmOpVaxOUoR1rtaUscqwqksRcwMhk7IYB4TdgLQFNEGXkVAJD8SyvhU1b/ZMjDZLnmwmYf/7NyWjraepGNC8MuzMVy2CXEZNEBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=czSKC/v4; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="czSKC/v4"
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64PLZQsL1983916
	for <linux-block@vger.kernel.org>; Tue, 26 May 2026 08:39:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=P/avqlvhJhFA5rGWIt
	vqIGoBfVYSFdFc2WtS7pAl5Eg=; b=czSKC/v4t2w7CY7warP0SdQ7KSXzhJjqUK
	b0LMMeFyMo+ZrZhhQ5m5KnJLzpym9e1XYtBWJMS3Yvg6I1Boz5v+pTa7ySlArkDS
	dSZZYG76hMBDxm4Ppbk8fYCIt/m6CyK/3B0OlUanW4vjQmZpyhhQEgrZsshnJ0/X
	NWKpLYC8Jt6UW1XxjWqtAJB1oxbIYSYx6YnjvZn3jYJVh2mrWoiBC9jaPYvVJI6q
	2vU65oAsEV4wtMiI9F8Peorz6WeCtz/Sm1wkXFrRDuLu3pn850b6FFdW4Ds+17IJ
	4WT0ptdPZlEl98XmOJ0aIS1KT3XudC8QwuqeUBqqc+VQMlIJNV1Q==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4ebmw6vvrn-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Tue, 26 May 2026 08:39:29 -0700 (PDT)
Received: from twshared34426.16.frc2.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.37; Tue, 26 May 2026 15:39:26 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 4313A1CA8D4B3; Tue, 26 May 2026 08:39:22 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>
CC: <axboe@kernel.dk>, <hch@lst.de>, <nilay@linux.ibm.com>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCHv2 0/2] block, nvme: enable passthrough iostats
Date: Tue, 26 May 2026 08:39:19 -0700
Message-ID: <20260526153921.2402015-1-kbusch@meta.com>
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
X-Proofpoint-ORIG-GUID: 5JA_6IEwFQqSWaOt0kmZ6kJix4uczKxJ
X-Authority-Analysis: v=2.4 cv=X5xi7mTe c=1 sm=1 tr=0 ts=6a15beb1 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=wpfVPzegXHpEFt3DAXn9:22 a=VwQbUJbxAAAA:8 a=M_XrtetGi9rww7Nx39AA:9
X-Proofpoint-GUID: 5JA_6IEwFQqSWaOt0kmZ6kJix4uczKxJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDEzNSBTYWx0ZWRfX7zcxmix83X/m
 B91Zk6vFuUy8VXGyuYnaLtGX4OGbEnDdOktDp97Wl/POI5frszHIfTLuIW7Kn6FGjq2N4o7/T3W
 Wg4hKZHh1IZrOoWRHAJQyRts8j1Dp9CEiCvKc1ZfbRxGAEUBMrGSzqnxKNzx8fa+H8mrxVkrIF/
 Xz+8qSsJmP/2m7kRf+DnWuZZF5OdtEnt4LZWji75uk0ute8BtWY1aq0hu7fOCfRP8f7dcZrTiFc
 qy8ytvPqGbhiwCrNM8hKFWZdbWEMoqws2nIrIlMh3u7zeRRwlkHYArKfScRxdTWO1YU5PfZ/Qcq
 wb27fuOAXY3RH4wNEA5Q673j7KKrGGMhob+8A9OaPe2ufRQHlvp8JukgM0kHHWeuXyco9RSopMc
 +MeZa0q4CwkRPt949aWVGCqLqAVyVlDE6PKgjxw1vc37NP7APr8cTPRI56288e1bnAQKUod/SOu
 I5tE8QUHxHISxRsahWQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_03,2026-05-26_03,2025-10-01_01

From: Keith Busch <kbusch@kernel.org>

v1->v2:

  Split the block and nvme parts into separate patches.

  Fixed up the nvme driver to ensure passthrough commands go through the
  multipath start/end functions.

  Have the helper function take a request_queue parameter since the
  queue accumulating the stats for multipath isn't the same as the
  request's queue.=20

Keith Busch (2):
  block: export passthrough stats enabled
  nvme: add support multipath passthrough iostats

 block/blk-mq.c                | 32 +-------------------------------
 drivers/nvme/host/ioctl.c     |  4 ++++
 drivers/nvme/host/multipath.c |  5 ++++-
 include/linux/blk-mq.h        | 30 ++++++++++++++++++++++++++++++
 4 files changed, 39 insertions(+), 32 deletions(-)

--=20
2.53.0-Meta

