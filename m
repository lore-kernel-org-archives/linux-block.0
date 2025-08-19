Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7100F2E228F
	for <linux-block@vger.kernel.org>; Tue, 19 Aug 2025 17:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755623457; cv=none; b=IfydZ9CkIIVZR14bcX7YXwNIefSxhukRd826yZ6AVUYpek8rk3sq8zcVCXn+HQerpGBfe8qmR8XqnnLgsRPYykkg3V2WoKHD3MDGvgXaJP5F5+8E0NFWLdm0omm2cm3d+JnkAIwOBFerOsMaZmaPJuOIbvvaWSqgZMyNrdNNt8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755623457; c=relaxed/simple;
	bh=RbrhOuJtcgUJ4xVUhXL4NkIPfBy/mVL25lx3D6+LRlI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ngK3EJ6LEu+kMuNv3VebMkE6AN7e7tU6jZfxlgh1eOxao9R/Indb7gIfkRg70hkporxKBQi2/0pW/HCHwquNojCUXhkur3KkTJVuHYPVMDyYc+xCBn5RHUrPNreMXu6O+fSAZUaEZUqX2TQCrUk+WNvifT22+9VOI7ujVOd295E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=ZujSxYNz; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="ZujSxYNz"
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 57JF41SR1371581
	for <linux-block@vger.kernel.org>; Tue, 19 Aug 2025 10:10:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=XutiaynC6eIHmdhILbieOgn8SY0Trp2AHm3YNayem8g=; b=ZujSxYNziiZq
	4PLdFniG/YpNpnlucTFS1uAA3TPLnM4hrPqsAb1pKaiW8j9Us7RDhK1zHDhhNjHZ
	sQMtFAnWjnDkRGyvutNV0bfdvEDzDxtRLNszmykwL4SlxWQwmEW7IKiznI6AUund
	5K7m5IiW+mUIPX8IV+JZjKJZ8tziIEbQWc4xGhzs5hHS3r4Oc2jnajkdWislituT
	ZgGQRgMLT0izsp19+UKXkcg2fsToOeP8458CKuEXEfIIarn6v8i/S5y8vl5WUgTJ
	A5YqKWap3HCT032WoHXY8Z/AGQLYlu37cZiOBFbt4GEjyxvmNGPiu5TraMmiwewc
	hPmDpU/EeQ==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 48mujxs8b6-7
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Tue, 19 Aug 2025 10:10:55 -0700 (PDT)
Received: from twshared17671.07.ash8.facebook.com (2620:10d:c0a8:fe::f072) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.17; Tue, 19 Aug 2025 17:10:50 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 83583C89F27; Tue, 19 Aug 2025 09:49:48 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <snitzer@kernel.org>, <axboe@kernel.dk>, <dw@davidwei.uk>,
        <brauner@kernel.org>, <hch@lst.de>, <martin.petersen@oracle.com>,
        <djwong@kernel.org>, <linux-xfs@vger.kernel.org>,
        <viro@zeniv.linux.org.uk>, Keith Busch <kbusch@kernel.org>,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCHv3 4/8] block: simplify direct io validity check
Date: Tue, 19 Aug 2025 09:49:18 -0700
Message-ID: <20250819164922.640964-5-kbusch@meta.com>
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
X-Proofpoint-ORIG-GUID: kU5lBO_PrVIy69To62ouMYjusFVBkkwF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDE2MCBTYWx0ZWRfXwsvV1zcVIcd6
 Vfpur/H2B/guxcf64D6Yl39SISg9vSktmHsdvtTpoY0/tvnUwbLZhrNiaombmvcDF73J4FyQ0rf
 N38WFKBSKigg/j/7pvqcy+HfwRj642N91rubm2lWpITP+zpMymWYYPKnjEe8RNk9HHKtFqKghsX
 OO05GlB9zik3CzjCetDHxxAnWs39Tr+zkKspPF6mL6tejV0cY5vgjcihuH1g1FT8poLcy4RyC09
 y5Y//bbGqZYyjv/q8qN4CJ4Ay9o1WEx8CuuEpMed2acz3CM8bE+SpQqTqO/F1Bx5RvQNz0tqsB6
 hPGQ0lLXvZC+MMBmArHZmDr6omlWWiSoWLe0qAIvPQMZvvJUEwVNa4SU1o7vDb4P0inJhWkT+PE
 85COVFBZjtT/5w5ZN9UdbaAD9rI77Lb2EKl4Nx5YbRqRE4PoAXhqKmzrflPYYtXW1Pz2YApO
X-Proofpoint-GUID: kU5lBO_PrVIy69To62ouMYjusFVBkkwF
X-Authority-Analysis: v=2.4 cv=VMTdn8PX c=1 sm=1 tr=0 ts=68a4b01f cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=wgemLMbJKI-cAGOf0tMA:9
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
 block/fops.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index 6d5c1e680d4a7..32a8e6fdc7338 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -38,8 +38,8 @@ static blk_opf_t dio_bio_write_op(struct kiocb *iocb)
 static bool blkdev_dio_invalid(struct block_device *bdev, struct kiocb *=
iocb,
 				struct iov_iter *iter)
 {
-	return iocb->ki_pos & (bdev_logical_block_size(bdev) - 1) ||
-		!bdev_iter_is_aligned(bdev, iter);
+	return (iocb->ki_pos | iov_iter_count(iter)) &
+			(bdev_logical_block_size(bdev) - 1);
 }
=20
 #define DIO_INLINE_BIO_VECS 4
--=20
2.47.3

