Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6283923F295
	for <linux-block@vger.kernel.org>; Tue,  5 Aug 2025 14:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754403093; cv=none; b=BFw3jIHCk5Ms4nqzgFeY1bLwPdT33NyX8GiCxmE+OsnoRJIDxIYmBp7XytczmLoENFtGdvE5oP2wAY9q7g7gt3XHj4lsd4mx3qO6/DhmE1c/J5h62r+jd3WhmdrzzCeto/WJAzTADIQQ8walTaA9BArDJic4WZIg7Ag4XlCd6Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754403093; c=relaxed/simple;
	bh=Cb/apwBa1XVQidI+ebNpQwF40xzuYGiCtR3Uc6Osrpk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CSB1PeG0o0v39pdV8EXndN9YC7bzvjlC3xUeVm8y5H68rKEPumcjVj7SVfFJt4N3opBxtsRjymJDofFHoeDoHmB0jTjyrkG2I+Tn+Nlhbxe/b6f8sBB5Ybo60M3nT0i3XAwaNQpfROdJunor3xSULgpsJBxmr7H2lLKD97ZrUfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=v6cWwqKn; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="v6cWwqKn"
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 575CYAn5012587
	for <linux-block@vger.kernel.org>; Tue, 5 Aug 2025 07:11:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=9oaQH3kl86GzPCGUrph1aYzlnnowT/NAZF60rXSdYc8=; b=v6cWwqKn2+rg
	meQ7In+yjWjKQ+F9rRcDxVR3Ur35/vOLNoW1APxdJ/i4twLFooen0rfSbeCi+T+x
	67DtpE/Wow7mcQJgxJRSlM6GGHdgraZSzodTRI5uRbdRCMQ3Puhfd4g1HMzzKwZ4
	SxTj59U/VIQXBZxYysdWgLdM86mI+UBDmdsIs1PmxfwcuzvGM4FhZobm1LIT5nqp
	HlsSi604HEuQylBHiUz7eH/X+bxdN96QSfaU5aH3sQuhnEwviGdfA1IPDe32slFN
	cNEPowtnmSrkLbNAntt35DOEBLjZqaH9DDc6fshxaxJEteZwEE9vglT4qYqPKdwj
	2j+8ywwoKg==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 48b5tacu54-16
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Tue, 05 Aug 2025 07:11:31 -0700 (PDT)
Received: from twshared0973.10.ash9.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.17; Tue, 5 Aug 2025 14:11:27 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id A23A44FDD4F; Tue,  5 Aug 2025 07:11:23 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <snitzer@kernel.org>, <axboe@kernel.dk>, <dw@davidwei.uk>,
        <brauner@kernel.org>, Keith Busch <kbusch@kernel.org>,
        Hannes Reinecke
	<hare@suse.de>
Subject: [PATCHv2 3/7] block: simplify direct io validity check
Date: Tue, 5 Aug 2025 07:11:19 -0700
Message-ID: <20250805141123.332298-4-kbusch@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250805141123.332298-1-kbusch@meta.com>
References: <20250805141123.332298-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Yd2I5WiwYtdLE_W8SxkoMS6RmfX9jL2K
X-Authority-Analysis: v=2.4 cv=RJOzH5i+ c=1 sm=1 tr=0 ts=68921113 cx=c_pps a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=IZBY3vBkjIs1pqmLj1YA:9
X-Proofpoint-GUID: Yd2I5WiwYtdLE_W8SxkoMS6RmfX9jL2K
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA1MDEwNCBTYWx0ZWRfX9C+UIsmiSVwN JCRsamn7jT94NVzD+z8aKXYYfYJ+Is2lfJCxAWKBSR+Y+YSSQk2JTowHTgzMkF9rGoeh2xUiFo1 8SZDtC2ngks4/a2cU5uITy9rNe9shU4n+47kdZjm1AXLKsLT78vS7unU+9y2WpLpHvyjZH+7rp2
 oadRlV1qBKiPXc/rMD8DxD7z42t9dzmwVMr1RsROyxPDsKoxncplLf21Thx0zZC9apAqlPVmW1D QnA2+DUknILHKcnI/IDHx7nZVVADTKP9Tuu6qQXyFeyNCj4zm0gdjY+bCPyfdLjKMEcGP4rwKzY JH3za4eeqag7uDy9Tvv2aHVewkc4MJINhtCr6Xe42xSNgf0gDxdR7WMkXP392KkDvV3i9zlCbpB
 CTM9+W5pAsXtePJzrnXr35E8YMDZObY5NDIbFmbAvt6ii43Nc6EhJp9n1YFu8bYwkcDTF3s4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-05_04,2025-08-04_01,2025-03-28_01

From: Keith Busch <kbusch@kernel.org>

The block layer checks all the segments for validity later, so no need
for an early check. Just reduce it to a simple position and total length
and defer the segment checks to the block layer.

Signed-off-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 block/fops.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index 82451ac8ff25d..820902cf10730 100644
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

