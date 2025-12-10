Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B112472623
	for <linux-block@vger.kernel.org>; Wed, 10 Dec 2025 06:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765349369; cv=none; b=KWwll+u9UoY94bFUG8emgR+PnrzC/rrAX5m62DB6V3qRG993gFUDAaIPLJSQu7TivOsdk2SaqVCp9FoV0j0GaHX2qCN7ZdcF/Sv1CnUf600IR1TBkz53WEACGPEqLv656sWKbaUx+XGFi82/FZ3cRetaEo/Np0i3W+1LfH2jR9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765349369; c=relaxed/simple;
	bh=ucYn6K4698I4hEq1B6ECF+TDG17sNdhm8GXjpoYK4dA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=marc5w6Eu0AL3XKXjjMlGrR3KzUlq4eJxLTWby5qXp7AJ69KvUwhIjKbwdo4HAAB0n/vWQVwunPiRKT/5EGC75CYxa6dcDQ0RkZ0aLD6iF02Yfhbtxa9LYdDMH9Nyoo3HdFXxvNZ9bNYo7yKF7A4mn+mJo6OwFXAufQA264PPEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=MScUBAgy; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="MScUBAgy"
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B9MTI3c3341281
	for <linux-block@vger.kernel.org>; Tue, 9 Dec 2025 22:49:26 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=J2BFEb2JvkesZ5QnKa
	BD1xADfvvShg++ZS35BOu5DxA=; b=MScUBAgyG0rIdo2jox0oMUFAn+UEp4WMEW
	WaQD1Ndx29xeG40jf9qTRTAJ0YAq3xR3sEUwRvoi6auPiJ8bvGV6pipZ8xnZLYSc
	pBUPCGCXcC/W/EJkcfzwd6504+dfcs5alWRby35RX7OPJezEzqYcf40Zil64cOsH
	O/6maC0bviPLJYgxlEc5BcsA1y8MQ2vfX7lCRs6M955lJLx6yaWmO0xp6XP97hPe
	C6Lndkhm4ggQMW0T11dz2vHsAXSbAvygumQPiKepi153sm6n9o8kfre3G/1b+EBH
	yfcVCvnqkPrTBZKDp9yq9B09j6mEnTVWFz8Y4gO3UFfo6VZ5GMzg==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4axrvdch04-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Tue, 09 Dec 2025 22:49:26 -0800 (PST)
Received: from twshared40939.15.frc2.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.29; Wed, 10 Dec 2025 06:49:24 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id E24824A84EE5; Tue,  9 Dec 2025 22:49:15 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <axboe@kernel.dk>, <hch@lst.de>
CC: Keith Busch <kbusch@kernel.org>, Sebastian Ott <sebott@redhat.com>
Subject: [PATCH] blk-mq-dma: always initialize dma state
Date: Tue, 9 Dec 2025 22:49:15 -0800
Message-ID: <20251210064915.3196916-1-kbusch@meta.com>
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
X-Proofpoint-GUID: QrlpDyZwFzWQ29KwwEyYIBlSY-LOH54T
X-Proofpoint-ORIG-GUID: QrlpDyZwFzWQ29KwwEyYIBlSY-LOH54T
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEwMDA1OCBTYWx0ZWRfX3xiwpLm33Q6P
 yxivYvcIzhOTuh4bSHLpDtDwXZPltAnoqSSTGlm4pJCdAFmURJpC0bidOXGbIhwHO8nV5RcZNQt
 IK9xh/BTS7AZwYK5Y6b4dGB2hrME6C49Ju6G7vOep4uCofydxYy8395G1q0P+Z1L0KMV0TK2QH8
 +td3p1zuqybCPmtp5Daat5Mp7MecfEDZZHDhkPNCYOEc2GTD1PsfHkOFbEmVR9fLfRcS3gozV7m
 z0nK41IjtTB9e8XSLrxsp3HgniIhsvX894z510BC/4+NnjVD/E1uor+lnVCSPBYkg0okUkkssRO
 /bxrQtmnI45OGC+KbA3QqVRfVcSkJ7A1H0YyohmwlndDn6S3UkDJtxst7iyVbvGIAZ7rpCAkEp0
 woPqoLv15uQsK9d4Gh2DGWlu0E4vRw==
X-Authority-Analysis: v=2.4 cv=NPjYOk6g c=1 sm=1 tr=0 ts=693917f6 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8
 a=AxpzScBtZrD1hND8UIcA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-09_05,2025-12-09_03,2025-10-01_01

From: Keith Busch <kbusch@kernel.org>

Ensure the dma state is initialized when we're not using the contiguous
iova, otherwise the caller may be using a stale state from a previous
request that could use the coalesed iova allocation.

Fixes: 2f6b2565d43cdb5 ("block: accumulate memory segment gaps per bio")
Reported-by: Sebastian Ott <sebott@redhat.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/blk-mq-dma.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq-dma.c b/block/blk-mq-dma.c
index e9108ccaf4b06..4ca768e0cc7eb 100644
--- a/block/blk-mq-dma.c
+++ b/block/blk-mq-dma.c
@@ -196,8 +196,9 @@ static bool blk_dma_map_iter_start(struct request *re=
q, struct device *dma_dev,
 		return false;
 	}
=20
-	if (blk_can_dma_map_iova(req, dma_dev) &&
-	    dma_iova_try_alloc(dma_dev, state, vec.paddr, total_len))
+	if (!blk_can_dma_map_iova(req, dma_dev))
+		memset(state, 0, sizeof(*state));
+	else if (dma_iova_try_alloc(dma_dev, state, vec.paddr, total_len))
 		return blk_rq_dma_map_iova(req, dma_dev, state, iter, &vec);
 	return blk_dma_map_direct(req, dma_dev, iter, &vec);
 }
--=20
2.47.3

