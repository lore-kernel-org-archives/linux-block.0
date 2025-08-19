Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D672D8DD4
	for <linux-block@vger.kernel.org>; Tue, 19 Aug 2025 17:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755623455; cv=none; b=pf6Bt9+aTrVKZn1dozVVs6Yx2vPeoqLr7sT2MuY9981b3HB35IFBj+g5kmeqhBlrAHUX2Nlt7tpPa4vhqKFxLOdy+gQH6Kknfnlpc0ckM69I1aOEANh+zKYob6dCeebF7kPt9QNdAxeYHi56srwdNvLVLggN8AR4nAMsOtxfL0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755623455; c=relaxed/simple;
	bh=M8uv3+tX1Bc/AqF/Gxnn//P8yRdLO0PQOdQhXW79ZgU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I82zq1cxL2DWbFTBgSYyE1P4aHfrkAffTrkiEvfLuRGx57vb1UhHGeHb3C7gb8n/09CneRy+NodpqMpFd9aKi+rsQPZnqMUFcDpOXgwOlbCcbpIooqSYhSgJmFeha25M4tUr0vus//AVbwClBdlgKQsQaSA+HPqklKKIA7ccJDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=G2+DU0a3; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="G2+DU0a3"
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 57JGuDxo1754206
	for <linux-block@vger.kernel.org>; Tue, 19 Aug 2025 10:10:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=qbgzTLsmKOO6IxY8LYkqLHvbtmmJs9XqSmr1Rmgw4PY=; b=G2+DU0a3c3db
	2jyQz9RTB2X6MWTZ7k1qpHnCT+OV8ZE2swPCemM20er2X6wugIX+BxCmsGkmaxGl
	xuuIXfxZ6ctpG51MEWFJvE9R3Cj75g5ujaLbzno1gI8MIJQ4jNq7u/Oh5sAXFtzT
	kyV8NeaxmPB0VTfpUZ09osWV04DiBYCsXjc/G3+H3K8gA4SA0lAy+llik70S3rcA
	OGYKBRkZCB8Ef/OqSoLt65KsrkJdRdP9WdsYWGpI2S68zic6/gXuhJmY8v2ypfQm
	ds1attv+g+VcmrTmToZAulMXqxpTDisciL7hZmZWkpoaqSDiQ0PfbvJyHGgGPULZ
	BIZ08IKAwQ==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 48mw7hg5e7-11
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Tue, 19 Aug 2025 10:10:53 -0700 (PDT)
Received: from twshared60001.02.ash8.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.17; Tue, 19 Aug 2025 17:10:47 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 8EC07C89F2A; Tue, 19 Aug 2025 09:49:48 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <snitzer@kernel.org>, <axboe@kernel.dk>, <dw@davidwei.uk>,
        <brauner@kernel.org>, <hch@lst.de>, <martin.petersen@oracle.com>,
        <djwong@kernel.org>, <linux-xfs@vger.kernel.org>,
        <viro@zeniv.linux.org.uk>, Keith Busch <kbusch@kernel.org>,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCHv3 5/8] iomap: simplify direct io validity check
Date: Tue, 19 Aug 2025 09:49:19 -0700
Message-ID: <20250819164922.640964-6-kbusch@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250819164922.640964-1-kbusch@meta.com>
References: <20250819164922.640964-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: fBqmd2eehXivxl3MGmotmvxfXTo3qdUh
X-Proofpoint-ORIG-GUID: fBqmd2eehXivxl3MGmotmvxfXTo3qdUh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDE2MCBTYWx0ZWRfX5NLHlAthtl62
 sYYymie39MXNLD4rrgj6ZkL99z2H+YgjMY3UfE9IXALlRJW0mz910YAgraUqQkjxxsFkCM9Q6j0
 ENridgk7cHabx3kTg7jSFZ9KAoPv1Vn9XRqgcwIVzC8XAwMk9s0BhMZPhTc3chumf39iAMTJMkw
 VmK07Ngo3edKdxhjjMK/emwgt+J3zrfFr0iH0iSx0tdwCd+guKRiLk0lkb2NfSHq3i5tPU1q7ag
 BIvNiSCZ4/mcLA+ABcsxqPm0s4+D/5u1U25ZvS8dhNYjo6Alq0FGWWloqRbtjW+Wvaxh1qC16Ij
 c/M/ezX0vpOrnLIchD8t9YVBFWh6kfB9Jdi8OUHZ7ChJBTJBUHi1zmIC5TJgPoQq7r99hL1d5iU
 7lIXU3+MF3cahl8rr4P6pPgNzcFkL1039Q/G9x/om1btcyJIGlZxbxASEekw+CjxPVRERbne
X-Authority-Analysis: v=2.4 cv=etzfzppX c=1 sm=1 tr=0 ts=68a4b01d cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=yYvhBQMpDZKDIMWT91YA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_02,2025-08-14_01,2025-03-28_01

From: Keith Busch <kbusch@kernel.org>

The block layer checks all the segments for validity later, so no need
for an early check. Just reduce it to a simple position and total length
check, and defer the more invasive segment checks to the block layer.

Signed-off-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
---
 fs/iomap/direct-io.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 213764bdee8f2..33ecdb11e331e 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -337,8 +337,7 @@ static int iomap_dio_bio_iter(struct iomap_iter *iter=
, struct iomap_dio *dio)
 	u64 copied =3D 0;
 	size_t orig_count;
=20
-	if ((pos | length) & (bdev_logical_block_size(iomap->bdev) - 1) ||
-	    !bdev_iter_is_aligned(iomap->bdev, dio->submit.iter))
+	if ((pos | length) & (bdev_logical_block_size(iomap->bdev) - 1))
 		return -EINVAL;
=20
 	if (dio->flags & IOMAP_DIO_WRITE) {
--=20
2.47.3

