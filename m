Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF9E29827E
	for <linux-block@vger.kernel.org>; Mon, 25 May 2026 16:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779725284; cv=none; b=qaIAhtwbR/yNLzqFzMwdmRn2l4eIRk7HhhoABJr1NLAWsffhzgoLx2X6BO0R41oHIZP3fQFPUL7fff+oyoqAJ+gUO6+Rzxi65951ky4G+PpWs2Qxakj52SjdKezCfsLrXSsEoIsf0jQD7HT+nkLMOnSCJPEwfcGiP4j8y3P6O7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779725284; c=relaxed/simple;
	bh=4Pn3WzGy7/34NubvElZJgoXIG65+MH2cBs+s1GBU8ck=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jwQR6XdExNuqDLx7/ZaPweRlvqQKukKJGSYQC2YVc4jzLaAJyl8yE4ixDx86fBcgRHV60MN402WXUyKBf/FYa3LdslPxM6zMO/xqldRgo6O5ehmGefX7CpiiiYn/6/6PTpu0RAK0WkP65bmQvvh6pXSbsvsL1T1ow+b13V26Llg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=BdXx4SMb; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="BdXx4SMb"
Received: from pps.filterd (m0528009.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64PCBPcE855984
	for <linux-block@vger.kernel.org>; Mon, 25 May 2026 09:08:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=e8gzSunIm8Ut2KGIYv
	aHMbTYi7k8dz4zx8qwTm7in/w=; b=BdXx4SMbe51O0xvrTZlW5b/+QOJaC32l+W
	aaVaexak4FqE5PqlTj/1DLy56u7BtktbS2FubMf0xBS+nYKl+zpayjNVY377H2N3
	7UgxxAKk5Gip4qjxeuIoRhRpvmgIi+u+KT0FCclLjDm2tYyPB3JUqA/h6XMPq7pH
	V65ShIUrzj+ZPDicMEEuir3+oexw44ZNBFjUDvEa/xg4JrlTjNd7TdbWBO9xCFHI
	EBhQoP0kzfLoOSiSJWito8vxDj2JlZghTbAV0QrgxISCmx8M2E5zOfQy0MUgvltB
	hO3IuAOAd+Sm3NdUH9bOgHrFxOigKRoD0Xy8hhHQS5D89NTz8PKg==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4ebx04nmy3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Mon, 25 May 2026 09:08:01 -0700 (PDT)
Received: from twshared23436.02.snb2.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.37; Mon, 25 May 2026 16:08:00 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 6F5AE1C503076; Mon, 25 May 2026 09:07:44 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <axboe@kernel.dk>
CC: Keith Busch <kbusch@kernel.org>, Ming Lei <tom.leiming@gmail.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH] blk-mq: reinsert cached request to the list
Date: Mon, 25 May 2026 09:07:44 -0700
Message-ID: <20260525160744.896047-1-kbusch@meta.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI1MDE2MiBTYWx0ZWRfX/1VWbT1hcHIh
 g5IgHLGREys7+uQrC1wnsGFOQWhGajC1QqqxGRhdeG7nOglbW70G1xA5x0LSCADvX3BPiFyrmht
 iaHuaWV+bM1BCi3v/DIAriWRYhKMBTvPfTX0Kr85o0oF54rWN3afvViBCZkNznVJA6NRi2e7jII
 aOXAf1TQpuoH0ikrxI/g64IfADVssk+Hyp8qnWCbcEtcdIMqtoizpkqh9TqzZFEf8l0pzwYUCZv
 bxbbz2prNlmT7j6iM/ehTnwMBKRpVVdsNkiYz0wSlVDYPtAVmUh9+vxQ/dDZ3+pqAyWWKLKK2m7
 phHnImAFNHFvEGSdMMR1uwIUwBeMFS3j8WbfYWayB/rzRWGoNywJ+YJ5/iIJqk5iXNv+B4deoPg
 dWbclRdyNgVH/UdrG0bTpevdGQH7PnyzVriL4MuP5DCVd2ZaA+QHDrLRo6YX5hBMTNr8XUDDu9z
 dulUT9m6l63wnabr80w==
X-Authority-Analysis: v=2.4 cv=Sa3HsPRu c=1 sm=1 tr=0 ts=6a1473e1 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=U_y8lYiYyhHBU5rMqhb2:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=HvWbp9H3uqfuRpaB1fwA:9
X-Proofpoint-GUID: ROwcPtu2es9o2W5IaQmCZl1vSZtxT5pF
X-Proofpoint-ORIG-GUID: ROwcPtu2es9o2W5IaQmCZl1vSZtxT5pF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-25_04,2026-05-18_01,2025-10-01_01

From: Keith Busch <kbusch@kernel.org>

A previous commit removed an optimization out of caution for a scenario
that turns out not to be real: all the "queue_exit" goto's are safe to
reinsert the request into the cached_rq's plug list as they are either
from a non-blocking path, or a successful merge that already holds the
queue reference. This optimization is most needed for small sequential
workloads that successfully merge into larger requests.

Fixes: dc278e9bf2b9 ("blk-mq: pop cached request if it is usable")
Suggested-by: Ming Lei <tom.leiming@gmail.com>
Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/blk-mq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 28c2d931e75ea..72c8ac805882c 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3246,7 +3246,7 @@ void blk_mq_submit_bio(struct bio *bio)
 	if (!rq)
 		blk_queue_exit(q);
 	else
-		blk_mq_free_request(rq);
+		rq_list_push(&plug->cached_rqs, rq);
 }
=20
 #ifdef CONFIG_BLK_MQ_STACKING
--=20
2.53.0-Meta

