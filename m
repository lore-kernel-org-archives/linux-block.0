Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A69C1F37A1
	for <linux-block@vger.kernel.org>; Mon, 20 Oct 2025 20:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760993264; cv=none; b=e9pNqBrXw0uzcoynkjVCUlcQQii9SQmYxhK3Dup4vo+b/+8REkXkp/sg6y006i1K9NaJn7OlgJHv4qS24urXYn5fRZ1H9JJEdt0wHySFTF+Y2Ojxzjisf8kkPB5wnnlaSliwC33M0fJOSVRjv5E7EmyGYz0ajrz/ChwC5LoRz0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760993264; c=relaxed/simple;
	bh=jfqLTCpeSuuM1v9h58hOT3ZFcDD/xYztcforhx3LCPE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lrZj1iAGgVjDUveflVrbsA/aOczfcp9pq6+zdVA57fFOWMEHLP3vza9u5q7dA7zBayzM9CX0JBqfkV6yFedDbWW+59g6jM1AcsLkPj873OY6O/1+KR5vhNQpgXPE0Lm3dUubwUa7bacWLIP8eA1DESe8aiHDYowFigeKAtuDrl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=dZPF3JP+; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="dZPF3JP+"
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59KH5ZqO3594106
	for <linux-block@vger.kernel.org>; Mon, 20 Oct 2025 13:47:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=UuRZQ2TaKG69lThvy+
	/wulAYP25mrd8PP/zenblmYLE=; b=dZPF3JP+Z5UDx6cSMyBjGZ80XexaZta+Gn
	V8/KAex80YMKrj48mzu87z00JD7xjhN79GFV2Vvxy4vhB+cPzJEtpUbpzWe/IxVD
	4kSvfZOewRvH7pT+tWoP88Y5oHfuG8e/U94y8AhoQrforFXybGLZGtqtTtztmEhH
	Ouuwo36z4K/yn5wvdv5oOreQGSrNXYV8rK33vdGFz3PbDwC3V8aqfthlTQUqpEIS
	KXBLay6Ygnx1NtDW5oaW8UEGWIjEJeqkwQHWkMbJtAMc4fH4OJUmOMu+HdC2Ll/1
	TPgi0jC3lBtDdtb63NmVWphafZH983RSyWZILlQ7eu1kv8y6GNOg==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 49ws649w2u-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Mon, 20 Oct 2025 13:47:41 -0700 (PDT)
Received: from twshared51336.15.frc2.facebook.com (2620:10d:c0a8:fe::f072) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.20; Mon, 20 Oct 2025 20:47:39 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id A55072E8C816; Mon, 20 Oct 2025 13:47:26 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <axboe@kernel.dk>
CC: <hch@lst.de>, <ming.lei@redhat.com>, <martin.petersen@oracle.com>,
        Keith
 Busch <kbusch@kernel.org>
Subject: [PATCHv2] block: rename min_segment_size
Date: Mon, 20 Oct 2025 13:47:15 -0700
Message-ID: <20251020204715.3664483-1-kbusch@meta.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIwMDE3MyBTYWx0ZWRfX1YVlHr9y807x
 0X3RzedbSao4oY81V5QkdTLB4+rewUKXJUoS202nag4mXEJZ/07PHWw/PWju2xrUf/zqjMPE8Lc
 xoj9jcVpGLrvj1yZn0Yk2n9/IM0osZpDUbg09eKZ/lMP9/vGG5xOLZx4bzTzG/zsoulDYU4SX6R
 4ffiqY09Z0SwgUEuRDolAjfLjZ3eGy6li0I6unc/CDJ1+XW8/tdJmu+GPIGDtaLhlwREIFcIn3w
 KKCVz/59pl1ov4Oq+/1nfhpuhtZAFcu78pdWx0ERksywoLsFjCj9V7gyVY1VBvf/NOTwCb5iTI4
 nSXiJGInN+WorExLo67B63sHr/4zJKy2oPY8D2xCbmZlkd7GVE77z206hOjHvsbJjLIEQ5Mt8Hl
 tO30rYomWQY6ZC868M+8oIhUyF3I2g==
X-Proofpoint-ORIG-GUID: JQ5rCfMSuczrFIFIJP91OcN0Lmfu5TTB
X-Authority-Analysis: v=2.4 cv=O5k0fR9W c=1 sm=1 tr=0 ts=68f69fed cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8
 a=G1GfqXQxPrWpZ4inVeMA:9
X-Proofpoint-GUID: JQ5rCfMSuczrFIFIJP91OcN0Lmfu5TTB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_06,2025-10-13_01,2025-03-28_01

From: Keith Busch <kbusch@kernel.org>

Despite its name, the block layer is fine with segments smaller that the
"min_segment_size" limit. The value is an optimization limit indicating
the largest segment that can be used without considering boundary
limits. Smaller segments can take a fast path, so give it a name that
reflects that: max_fast_segment_size.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
v1->v2:

  Going with  "max_fast_segment_size" in this version.

 block/blk-merge.c      | 2 +-
 block/blk-settings.c   | 4 ++--
 block/blk.h            | 2 +-
 include/linux/blkdev.h | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 37864c5d287ef..c47d18587a0b6 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -336,7 +336,7 @@ int bio_split_io_at(struct bio *bio, const struct que=
ue_limits *lim,
=20
 		if (nsegs < lim->max_segments &&
 		    bytes + bv.bv_len <=3D max_bytes &&
-		    bv.bv_offset + bv.bv_len <=3D lim->min_segment_size) {
+		    bv.bv_offset + bv.bv_len <=3D lim->max_fast_segment_size) {
 			nsegs++;
 			bytes +=3D bv.bv_len;
 		} else {
diff --git a/block/blk-settings.c b/block/blk-settings.c
index 54cffaae4df49..345b6a271cc35 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -457,12 +457,12 @@ int blk_validate_limits(struct queue_limits *lim)
 			return -EINVAL;
 	}
=20
-	/* setup min segment size for building new segment in fast path */
+	/* setup max segment size for building new segment in fast path */
 	if (lim->seg_boundary_mask > lim->max_segment_size - 1)
 		seg_size =3D lim->max_segment_size;
 	else
 		seg_size =3D lim->seg_boundary_mask + 1;
-	lim->min_segment_size =3D min_t(unsigned int, seg_size, PAGE_SIZE);
+	lim->max_fast_segment_size =3D min_t(unsigned int, seg_size, PAGE_SIZE)=
;
=20
 	/*
 	 * We require drivers to at least do logical block aligned I/O, but
diff --git a/block/blk.h b/block/blk.h
index 170794632135d..32a10024efbaa 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -377,7 +377,7 @@ static inline bool bio_may_need_split(struct bio *bio=
,
 	if (bio->bi_vcnt !=3D 1)
 		return true;
 	return bio->bi_io_vec->bv_len + bio->bi_io_vec->bv_offset >
-		lim->min_segment_size;
+		lim->max_fast_segment_size;
 }
=20
 /**
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 70b671a9a7f77..99be263b31ab5 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -378,7 +378,7 @@ struct queue_limits {
 	unsigned int		max_sectors;
 	unsigned int		max_user_sectors;
 	unsigned int		max_segment_size;
-	unsigned int		min_segment_size;
+	unsigned int		max_fast_segment_size;
 	unsigned int		physical_block_size;
 	unsigned int		logical_block_size;
 	unsigned int		alignment_offset;
--=20
2.47.3

