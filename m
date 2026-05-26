Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899EF372ECC
	for <linux-block@vger.kernel.org>; Tue, 26 May 2026 15:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779809985; cv=none; b=sCTMvKdVVhwIL3nzoZkS17yvnT6do90fIatSXhQL7dqxFqghsFyx/CcjLehawCGf1gTby7kyxhSAK1IgU3hYAzym28jL0E+8Nl9BTq0zi7DhG6yIrVBdp4VTgeImuU+iPFz92QKj2rVfXBMGohzww3cSUJuiwq6p1tySx9QdbEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779809985; c=relaxed/simple;
	bh=O3nBZc+EL1VyKCUnUfCFjbrv/bVt/ttlByfhXPljYnA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZgAmp2UWFbThAMZG7TyMSeeQibKWJE7cAqzsDwgYIv0tstHE5tH81vC/uSOk+rS63cuXy3b/OdbGT/i9KR1H6orYWWecXktdBN10puI2rlh5vQE5CM7YrEyHEKb/e0wgUJq5CLnkG7f1JgPDB/kDfYZNJV5wPk5nRo6vrSiZmvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=liak0ri0; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="liak0ri0"
Received: from pps.filterd (m0528007.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64PKuCHx1978827
	for <linux-block@vger.kernel.org>; Tue, 26 May 2026 08:39:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=u7v7SPpPFPV1yDP4KqRuB7xXNIKeDCvwI8hMe3fSdAY=; b=liak0ri0qq4v
	FjM/Sf6SKBlU8oYlEHsCM4wcxMf2YBP0+qIr7946ZaW/2q+TXUNELQxDkIX/O5Fp
	SmKrPp8g9prsmFGUKh3SMtdLAJ00hTjz5tnG4RqqjEUjIeWIh2nwK36UZyCwEadv
	5+Y509kxdFI+c7Q+UDZ5liLxw3JffqP1N2ponmmV74hTeB8lMh4FnqCnqd9amiYb
	UekiX59nJ+1wqgIBqMAB0//4a4Xc5f7F54ionJICKFfknZe+zr8MJ+MWX4EV1qT3
	wwJmSAaZKQ+1ucFxEj850GrCC3EVILWDEz3xJN/mV/oMv+7vKhWW74i2H4DCOsHS
	maQCKatYtw==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4ec08tjvy1-12
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Tue, 26 May 2026 08:39:43 -0700 (PDT)
Received: from twshared10183.03.snb3.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.37; Tue, 26 May 2026 15:39:33 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 4EE7C1CA8D4B9; Tue, 26 May 2026 08:39:22 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>
CC: <axboe@kernel.dk>, <hch@lst.de>, <nilay@linux.ibm.com>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCHv2 2/2] nvme: add support multipath passthrough iostats
Date: Tue, 26 May 2026 08:39:21 -0700
Message-ID: <20260526153921.2402015-3-kbusch@meta.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260526153921.2402015-1-kbusch@meta.com>
References: <20260526153921.2402015-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDEzNSBTYWx0ZWRfX+59XTXYQdACo
 JUGmvFPKlcFWtP/0OuYVvisiyQ8MMLqNwzgTTZi+iKFSr5C42TFhSAGk2PQufrbLNRHYvdcqIkb
 XCY40IDahFD8zcKWfJ+2raHLkXAImjNonR6iW+KFEfOCKpKrj31Hx0+Fw1X4A3W/0P+NltFETeB
 fPmnBxXTuFO/9IUEb6qMP3Ld5V98c2CFiZ9X0F8cB5eyFwvypnU2U7WxBTmR3r4P/uedgm6tJN9
 z5SJcr0lM/mQ1AFGrWHyGfzIh+TJ8UIyVoAFd0k5PxiZGFdMxA+9vISG749QX3HGD7hLFZI9Ivf
 /rZgy+X9+3nwIMGelDf1+0yayrrlYjwdFwm0yniDQgYeEGLDwL2uqXWPePqkFUzvol3ZkgRH5hP
 K1mA9T5aBarrSCENkchtT3kKI/tb2zipGm+MGINKaCHhcadQRP+ozhwHgKCLimp/u3+n5uEsV2V
 /ipiZHB+YDsII2JkgZQ==
X-Proofpoint-GUID: 6ECAsmVIOYo2Z8ahfvf-64JrkpdVuoq2
X-Proofpoint-ORIG-GUID: 6ECAsmVIOYo2Z8ahfvf-64JrkpdVuoq2
X-Authority-Analysis: v=2.4 cv=LvKiDHdc c=1 sm=1 tr=0 ts=6a15bebf cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=4h92JMTCafKA-fb_NiOh:22 a=VwQbUJbxAAAA:8 a=xT7lm6qD1slQ1dElJxQA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_03,2026-05-26_03,2025-10-01_01

From: Keith Busch <kbusch@kernel.org>

Don't skip io accounting for passthrough commands if the user enabled
tracking these.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/ioctl.c     | 4 ++++
 drivers/nvme/host/multipath.c | 5 ++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 08889b20e5d8c..38ca04567406a 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -102,8 +102,12 @@ static struct request *nvme_alloc_user_request(struc=
t request_queue *q,
 		struct nvme_command *cmd, blk_opf_t rq_flags,
 		blk_mq_req_flags_t blk_flags)
 {
+	struct nvme_ns *ns =3D q->queuedata;
 	struct request *req;
=20
+	if (ns && nvme_ns_head_multipath(ns->head))
+		rq_flags |=3D REQ_NVME_MPATH;
+
 	req =3D blk_mq_alloc_request(q, nvme_req_op(cmd) | rq_flags, blk_flags)=
;
 	if (IS_ERR(req))
 		return req;
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.=
c
index 263161cb8ac06..d0a95cde181c4 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -175,9 +175,12 @@ void nvme_mpath_start_request(struct request *rq)
 		nvme_req(rq)->flags |=3D NVME_MPATH_CNT_ACTIVE;
 	}
=20
-	if (!blk_queue_io_stat(disk->queue) || blk_rq_is_passthrough(rq) ||
+	if (!blk_queue_io_stat(disk->queue) ||
 	    (nvme_req(rq)->flags & NVME_MPATH_IO_STATS))
 		return;
+	if (blk_rq_is_passthrough(rq) &&
+	    !blk_rq_passthrough_stats(rq, disk->queue))
+		return;
=20
 	nvme_req(rq)->flags |=3D NVME_MPATH_IO_STATS;
 	nvme_req(rq)->start_time =3D bdev_start_io_acct(disk->part0, req_op(rq)=
,
--=20
2.53.0-Meta

