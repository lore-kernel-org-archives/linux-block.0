Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37FE3191B2
	for <linux-block@vger.kernel.org>; Wed, 10 Dec 2025 10:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765363442; cv=none; b=L5rgbxPNfKhoOKv67jFXSXrEZU8JI6cHsBXl44E2bibAylJqHYqkxLi0htuMseb8lSW/I2YyOzTXVNzsyP2co8D5LAdtxEeg9SZZ7rmvgr2oCp+ZsJusFHldjMucgfzO8eOog/YYXAC+8XYGFYASeF3lE1IAIUjNCVbnjJ6X46k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765363442; c=relaxed/simple;
	bh=v39CtsyqInnmRRdo5i3eFhW68DaeayoH0bdC+2G57jo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=L+4bxa0E1/whDmlRFInD6zdhDMhzJsfajdWt2ZzaD8Zl7NQ6WXUsa219BS4RveqshRu9tIxsQLjbiY0HDhp1oNouQxmT/aMTkhob2AQWIqdPN/2fq6jffFa6zNjJ8wYVDRks66Xy3xbiSIzf7/fSJBochENbj3uRVBSlTPw3BNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=g1PGHcJD; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="g1PGHcJD"
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 5BA1VFQY3382175
	for <linux-block@vger.kernel.org>; Wed, 10 Dec 2025 02:43:51 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=rRBI9PSlNB8oPqXwPM
	8z5mkOuWMCwvCRrtzZGsVkIYM=; b=g1PGHcJD1HBJsxQXkHPSWmQPc15FlGi53L
	zzWBzm2uWKb4XluO3L1HI0WnMTyaqAjr08RZNU/HgtmwEbs7HaN2Ui/uSXD89y3I
	5PYg6s7nvXmK93RChgXRhJOGlmjnBgqTDnY+IWkj4DO+8dTHQMJRefM7nbywk+jY
	f9jOe7YTuvMlJSEw0rx+PwtfE8sTdjT/ZVV4/HZwsILvXfmDfRZchvYJrC8QDFkL
	gHHxsrQIKRic1FIpCviQgnwWm0JjRLUTKe0kEs1Qk2H9TD5DbHV5h8ZRmw+gVClx
	psQ8ljZBsP3U2x2mF7CkLj6j2Ldy1oXhXTcjrKCOmw+CuiJLtATA==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 4axy8twfw1-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Wed, 10 Dec 2025 02:43:51 -0800 (PST)
Received: from twshared31947.34.frc3.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.29; Wed, 10 Dec 2025 10:43:50 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 421174AA61F7; Wed, 10 Dec 2025 02:43:49 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <axboe@kernel.dk>, <hch@lst.de>
CC: Keith Busch <kbusch@kernel.org>, Sebastian Ott <sebott@redhat.com>
Subject: [PATCHv2] blk-mq-dma: always initialize dma state
Date: Wed, 10 Dec 2025 02:43:46 -0800
Message-ID: <20251210104346.379106-1-kbusch@meta.com>
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
X-Authority-Analysis: v=2.4 cv=cuOWUl4i c=1 sm=1 tr=0 ts=69394ee7 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8
 a=URAhA_KfexGzZ4cD8C0A:9
X-Proofpoint-GUID: az_USou46heQrXtrRFopMhmtgxNGlnaa
X-Proofpoint-ORIG-GUID: az_USou46heQrXtrRFopMhmtgxNGlnaa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEwMDA4NiBTYWx0ZWRfX1uKFujLGv3Va
 +o9iMi21S1IuVn/MSlYChHoBfi3fhuA7euNXZ3d5TxpbiFvzdKiSec3NB7eydjzY9KN8ynHvcl8
 2KWNEisIzpcArSYu4lRP8BoODeUOjVXrfmVp3F3iQHSW8QFTzNhKatA0xjegzweGcnNSH/vjBxV
 DulB/KQAeH5vGBDhkoSyJ9zkQqVeGPX1t0BJv3buyS1RSvg/Dr+DGhwhfEthFo1B63Bg4tNRXzf
 lih4Y7h6kAY38Ik9+bzPtT6OAB+K2mMIPKUMNvbMZIvs5TNWmD2cytic4n+prqMMzdB3Gy2Q77G
 G4HfA11q3iDpiawFkL0FPCrhFEBtMb12sna6Wvf072JmQ1QGVNHrlKLh/CWNkB7LOrqRXWtoUj4
 m8sAe6nMxxhJ71/byFyT3pnzloQEgQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-09_05,2025-12-09_03,2025-10-01_01

From: Keith Busch <kbusch@kernel.org>

Ensure the dma state is initialized when we're not using the contiguous
iova, otherwise the caller may be using a stale state from a previous
request that could use the coalesed iova allocation.

Fixes: 2f6b2565d43cdb5 ("block: accumulate memory segment gaps per bio")
Reported-by: Sebastian Ott <sebott@redhat.com>
Tested-by: Sebastian Ott <sebott@redhat.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
v1->v2:

  Simpler logic to always do the state initialization

 block/blk-mq-dma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/blk-mq-dma.c b/block/blk-mq-dma.c
index e9108ccaf4b06..6dc7a3c23ac8d 100644
--- a/block/blk-mq-dma.c
+++ b/block/blk-mq-dma.c
@@ -199,6 +199,7 @@ static bool blk_dma_map_iter_start(struct request *re=
q, struct device *dma_dev,
 	if (blk_can_dma_map_iova(req, dma_dev) &&
 	    dma_iova_try_alloc(dma_dev, state, vec.paddr, total_len))
 		return blk_rq_dma_map_iova(req, dma_dev, state, iter, &vec);
+	memset(state, 0, sizeof(*state));
 	return blk_dma_map_direct(req, dma_dev, iter, &vec);
 }
=20
--=20
2.47.3

