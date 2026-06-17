Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A7A1DE4F1
	for <linux-block@vger.kernel.org>; Wed, 17 Jun 2026 23:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781739176; cv=none; b=U2EcG039byl19kqeIHla/fXpTynkNDgAioYUmWKOIGwXafwfzWImMHrByn4K+6/c4upI9+l8xC/FMLa+NPJ8D8kOfI85dlzhaYviVjg6b2h0o++7ypLpT5Bb45ddNeh6HzwUGLuBQwmGDM6slAzLzZ9l7xbEfLvwF9RUgNw+xhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781739176; c=relaxed/simple;
	bh=kS9xwUjLnldgYcHIEAQ18+QI4EbGJkRHWK84iFkq9sA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ll4s0VdeNQ6fIkV0WRl4NJoCHOG4NyfsJPbRYP9MCadX90LEr5b2eN7raAB+w5Nw+uUQzYrGVomUseaVlVf+sYNSStMqo2BaGXpLDFHQ3SZdQ/k9YWxc3YrTwvXO8+akmFNVF+lJoMNhETWgUkApkHwLUD+aw2GgNAEeFA6rr/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=ZVZKxZ8N; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="ZVZKxZ8N"
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65HK0fDm830116
	for <linux-block@vger.kernel.org>; Wed, 17 Jun 2026 16:32:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=EjPlW8pUvzxKAdHJAI
	GBSE6xXQLodHaqRM8KkH/e/Zc=; b=ZVZKxZ8NOEcu/WBakF25kY6MyjK+dYzxLM
	ZOYdS8ddNraSrQWS28WgUPVCBOIOOoqm24qUipi5QwZWI2D0n7BMgdQDs0avrfmK
	k29uQTv2sUOk/XyT6D5bF7zzxnmCx6WmxCiYgMmEBuponyGJdeV5TUFEDSYqczNM
	pdgw/NWwRNwB6K0/rJm/ZhjLly6Tct/z8c2NDikSIrppWi2wjbHjduRrJmIZntzV
	usVo+0WnI+DxlQ69XP9P82FrzcEc8ZrvfR/BrXgNsUA2sFhREfFr0h8cXGWwlh2A
	CnkWKdC7SEncH30lmj1qrPNMpz9nS72L7ikd5VYNtOUTofpLIxOA==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4euegcr6xt-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Wed, 17 Jun 2026 16:32:53 -0700 (PDT)
Received: from twshared5319.01.snb2.facebook.com (2620:10d:c085:208::7cb7) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.41; Wed, 17 Jun 2026 23:32:52 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id D98EB23517B59; Wed, 17 Jun 2026 16:32:35 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
CC: <dm-devel@lists.linux.dev>, <hch@lst.de>, <axboe@kernel.dk>,
        <brauner@kernel.org>, <djwong@kernel.org>, <viro@zeniv.linux.org.uk>,
        Keith
 Busch <kbusch@kernel.org>
Subject: [PATCH 0/1] direct-io: validate user space vectors during extraction
Date: Wed, 17 Jun 2026 16:32:34 -0700
Message-ID: <20260617233235.1016063-1-kbusch@meta.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDIyNSBTYWx0ZWRfX4DUNWQNokdfO
 Y04BK70cn89vXImry5MkURywSL5TtjKyjTRx6+jlovSdGSiactBNOEeBLdtRs3ti2rx6MlIZ6u5
 D1mhNZtwD2Dxuyde5/unXjKwQe1D48KNUZQibTp9AsyNjwhGSvaIsSZYm1r/x1WjKvnFt+Wl83D
 jKICN+xy2alvX0xNXJpzy0yl+ZYwmVah+1ftgTXmwMB4CLXM0RPyaQqegBYlGE6v81lYUEC6IGx
 OKUbo7c32faoMVFO+ixOqWdOCdh1zCUSyJqF39w0G2dtx/grRaZwF4temGsJFP/a5odQL7tI79G
 w9zPJ098jNqo9Rw4OkYchcheuX94k6g/FwwnsLr0EkJoyhYGcjzeRUqDiyDYbH2BJJbMhaAVR9z
 86FhpmbY+77NqdMB8v8Ko2Y+1jfGERw6CR21Nrs9OIJvJ/LTgVK6lfizKhXXpf8E0wMotwNZrcB
 1kHCtd9G4y574Vu6hmw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDIyNSBTYWx0ZWRfX53LrXoYu7KDq
 0GiBPptBeyrB69A9VcCjvkZHABuagi/z+aJFlnaPYlncKZ4nlI0OGgMLnkhqmXI2L3RSTaO+u5I
 u74Y2Xs4azVr9LNDZYbe5P9LQnkyQwE=
X-Authority-Analysis: v=2.4 cv=WYE8rUhX c=1 sm=1 tr=0 ts=6a332ea5 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=crHB47gyY4rKiduisYu9:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=VabnemYjAAAA:8
 a=_iIL0Scklw7mknrBnAYA:9 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-ORIG-GUID: G4yzCohvjTbWWkJuDLu7Q_uxAo-uUePZ
X-Proofpoint-GUID: G4yzCohvjTbWWkJuDLu7Q_uxAo-uUePZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_02,2026-06-17_03,2025-10-01_01

From: Keith Busch <kbusch@kernel.org>

This addresses the misaligned direct-io problem behind various threads:

 https://lore.kernel.org/linux-xfs/20260610145218.141369-1-cem@kernel.org=
/
 https://lore.kernel.org/all/CAC_j7i1R7oy+nRhxEjCTba=3DDUgn02w9X+p94DCu0a=
Hv5+5tKnQ@mail.gmail.com/
 https://lore.kernel.org/linux-block/ai7rnH20IYeSmY8s@gallifrey/
 https://lore.kernel.org/linux-block/20260616154009.2123183-1-kbusch@meta=
.com/

The various tested fixes are correct as far as they go, but they treat th=
e
symptom: they only matter because an invalid bio reaches those drivers in=
 the
first place.

The reason it reaches them is an assumption I made when I removed
direct-io alignment checks in 5ff3f74e145a ("block: simplify direct io
validity check") and 7eac331869575 ("iomap: simplify direct io validity
check"): every bio is eventually split to the device limits, and the
upper layers cope with resulting errors once the bio has formed. Both
were optimistic assumptions. Drivers with their own ->submit_bio may
never pass through blk_mq_submit_bio()'s split, so the check never runs
for them, and as numerous threads showed, the consumers don't uniformly
handle this condition.

This patch stops the invalid bio at the source instead. It validates the
buffer's alignment against the alignment limits when the bio is built
from the iov_iter. The check is folded into the bvec extraction that
already walks the vectors, so it adds only a comparison on a path that
is pinning direct-io pages anyway. Misalignment is now uniformly
rejected with EINVAL before submission for every direct-io submission
path.

With this in place, the dm side changes under discussion are no longer
required to fix the bugs: the affected targets simply never see the
invalid bio. The tested patches remain reasonable as defense-in-depth if
desired, but they are not strictly necessary after this.

Keith Busch (1):
  block: validate user space vectors during extraction

 block/bio.c          | 19 ++++++++++++++++---
 block/blk-map.c      |  2 +-
 block/fops.c         |  3 ++-
 fs/iomap/direct-io.c |  3 ++-
 include/linux/bio.h  |  2 +-
 include/linux/uio.h  |  3 ++-
 lib/iov_iter.c       |  9 ++++++++-
 7 files changed, 32 insertions(+), 9 deletions(-)

--=20
2.52.0

