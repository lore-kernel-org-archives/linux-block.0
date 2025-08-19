Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4302D8DD4
	for <linux-block@vger.kernel.org>; Tue, 19 Aug 2025 17:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755623458; cv=none; b=JNE24OhG4Vp3dUnYgfSUKpMKLzbYw5LqGuv7ktQIo0KIUaW70mMI5EEIRhvuLTT9ifGEpP3S813bi0Ee3SWY09bdFhc8i5qVbfQMdsDkFyViUmeASX5XViXPVmblhOwH+CKNbtfbDLVpovKAQVsnb/puBEGsjDKHPqN+Hoh56EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755623458; c=relaxed/simple;
	bh=0rR9OGUY51qyMct0FZI1Vb5AOMdwpXefL2TIzvZmxd0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NvNZ+QaaYdvTKs4tujC5Dy96/hg3ZXgrqV7ZFuqSBxkyA+2alriH65FJJwS408otW1IpH7xV2+hW5PQ7BU5L9gcayVkAukrokvX29MAYAK/RF9w0UM+rOtcr61iDTlwGSaGDeFqeG/eFvTlya2eLvbvHEUTYwWbDaF+Ym5/EGc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=D7AKnHW7; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="D7AKnHW7"
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 57JGuDxt1754206
	for <linux-block@vger.kernel.org>; Tue, 19 Aug 2025 10:10:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=59+Hb9AcNy1cne4phcT5L81KNgHgSLj+KSq3JExrmO0=; b=D7AKnHW7480O
	lsNM4zkHfEpONuMx/e6MUs6dt82dEt9eKpJIpb0KlESc7wImiH8pwobRZ6m8gpF8
	v1pBjQ45NwiI69vWfM5JkpjXJgQlFAV125AhHQ/xGEy4mtCTjpdYlSTr3xcPi+9j
	rZJ3b4jxbehDwoj3I3saz+PkabKCSC2N+3xuhdW5aQVKPC/8t27mOmLMFbYlP7OM
	nU6two7oV5XyjNkdMDvkE+w7uBWVGl2k9TxGNBMKSL3Ws8fjlr3FcoOE1Td0+umO
	27O4RFub2+UeW1GECsVfDJvSav08yzaVUW1blxB1nfVLwPc6m2rT6K+IK5Iey0en
	3zC/oeJxKQ==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 48mw7hg5e7-16
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Tue, 19 Aug 2025 10:10:55 -0700 (PDT)
Received: from twshared60001.02.ash8.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.17; Tue, 19 Aug 2025 17:10:48 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id AAEF5C89F2F; Tue, 19 Aug 2025 09:49:48 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <snitzer@kernel.org>, <axboe@kernel.dk>, <dw@davidwei.uk>,
        <brauner@kernel.org>, <hch@lst.de>, <martin.petersen@oracle.com>,
        <djwong@kernel.org>, <linux-xfs@vger.kernel.org>,
        <viro@zeniv.linux.org.uk>, Keith Busch <kbusch@kernel.org>,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCHv3 7/8] blk-integrity: use simpler alignment check
Date: Tue, 19 Aug 2025 09:49:21 -0700
Message-ID: <20250819164922.640964-8-kbusch@meta.com>
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
X-Proofpoint-GUID: uopU4NhfUtPl2bAQGkJ8Ua5HjcLR4x6n
X-Proofpoint-ORIG-GUID: uopU4NhfUtPl2bAQGkJ8Ua5HjcLR4x6n
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDE2MCBTYWx0ZWRfX/FVcamgGBntF
 /hYG8Ev/JGbERf/EyoaJwMgEwNGqbdNvoAKMtFE301DdhK2gGBAXE2clbz3fJNFG69mR8EQ0zHm
 DCbqbmv9l+prSSRt7YNsisQGACv9nUg2WAzFD8Vyb73R+y1YG6TLftC43BTXIJfHKCEyVZJ5n5i
 lgB+h3OsuHb81TZF1Cmp0K7vASO0bjRfN3TSxPnco/7P8XyYk6RR0cBRmdcrx+MxrhFV7171+9z
 TFxJIFh3vprPmvhdCjWVMvm1jE2k26M6bgE9tyGcQi4gMf/gA094C9ZyafHPzmzVGe4J451r7KH
 LMf2Zv1/zAoCzEkcL576nU2/U1k9ocdQCJP/ah7WZqOhXRFzMDfXKBNbnHj1WjHrlo7NEug66uR
 SWiFOvKBRU8yPoYSkLavPw5eMBoB0JWG7VmS7PAhGHdUo2HyCZ4OFSRSXjKmstKf8ppjw2yk
X-Authority-Analysis: v=2.4 cv=etzfzppX c=1 sm=1 tr=0 ts=68a4b01f cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=yetF5jY7WHH6jeiS1L0A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_02,2025-08-14_01,2025-03-28_01

From: Keith Busch <kbusch@kernel.org>

We're checking length and addresses against the same alignment value, so
use the more simple iterator check.

Signed-off-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
---
 block/bio-integrity.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index 6b077ca937f6b..6d069a49b4aad 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -262,7 +262,6 @@ static unsigned int bvec_from_pages(struct bio_vec *b=
vec, struct page **pages,
 int bio_integrity_map_user(struct bio *bio, struct iov_iter *iter)
 {
 	struct request_queue *q =3D bdev_get_queue(bio->bi_bdev);
-	unsigned int align =3D blk_lim_dma_alignment_and_pad(&q->limits);
 	struct page *stack_pages[UIO_FASTIOV], **pages =3D stack_pages;
 	struct bio_vec stack_vec[UIO_FASTIOV], *bvec =3D stack_vec;
 	size_t offset, bytes =3D iter->count;
@@ -285,7 +284,8 @@ int bio_integrity_map_user(struct bio *bio, struct io=
v_iter *iter)
 		pages =3D NULL;
 	}
=20
-	copy =3D !iov_iter_is_aligned(iter, align, align);
+	copy =3D iov_iter_alignment(iter) &
+			blk_lim_dma_alignment_and_pad(&q->limits);
 	ret =3D iov_iter_extract_pages(iter, &pages, bytes, nr_vecs, 0, &offset=
);
 	if (unlikely(ret < 0))
 		goto free_bvec;
--=20
2.47.3

