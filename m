Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628DD340A76
	for <linux-block@vger.kernel.org>; Mon, 22 Jun 2026 17:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782150190; cv=none; b=ZZlrv0b2O2CAZ/j6bB7wm2CUr+ZznTDhRVWrq7VJOuftP3LkV6ZLQTMAz39bQXXY1/MNkfn7FJdJLvqyuKCFfBSt61bLlQj+jRa2irXpeNchOjXQ+eGJb+QI4NPCv6vZagJtoGu00snUmaYUhRrSWgvrrGUF4oLPt02Jz3I5Nbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782150190; c=relaxed/simple;
	bh=ciOnInfIrlVNGj9B+H97jY8XeIm5Xq/k7daeId3+lPc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BHoZl5M2Fuy4YulYSaQ9TOa44c1nvu72qiUhidXigEC9SfIMZ95tH+N+9cjdK3fVOzL0638q/Bq4PPAq6cu3vFRjcHCnwWRyi7qsaRezdf9XZ1s9nD7oqVYvNmNRYAriEKTqV+UCTLqnPlooFNQUi5H1w5/No9K5yil7VTcEc3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=VX82u59s; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="VX82u59s"
Received: from pps.filterd (m0528004.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65MHVU572357964
	for <linux-block@vger.kernel.org>; Mon, 22 Jun 2026 10:43:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=7eZT0eaIoKAY4JfubM1+S7MnrycBVHNDXCi+iFHr330=; b=VX82u59s18YF
	+0ZDWvFFkC7uZlSfYZFXkEge4CrBSPAk6ch0L6ZM0+rRyugfANZX90MCIJHPZ9dR
	J/VK412Kt+85WO7VM4sx36VtJivYiUewy2/RqyOOASk9gn5jpSLfGXJ/e0W5K55i
	O7uEB5SGSj++LFseumY7C659b//zy1g/tSpj5t9wDqrWyrNkGHxxvovmm15MaOla
	x8D+YupBykHJsHt4Ncghmc4rzGuCuQp6OHkStTVPr63TN6LA21UrnCaUXFh6wo2O
	BMnPcPhX3d2wRV70gfKvFkSGUk4LdD1C6HyujpCPZaxBROMXbQ30iMsT1qULNKja
	Lic1mL/6ug==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4excgdrh08-10
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Mon, 22 Jun 2026 10:43:08 -0700 (PDT)
Received: from twshared16795.04.snb2.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.41; Mon, 22 Jun 2026 17:43:02 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 5937223A15DDD; Mon, 22 Jun 2026 10:42:46 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
CC: <dm-devel@lists.linux.dev>, <hch@lst.de>, <axboe@kernel.dk>,
        <brauner@kernel.org>, <djwong@kernel.org>, <viro@zeniv.linux.org.uk>,
        Keith
 Busch <kbusch@kernel.org>
Subject: [PATCHv2 2/6] block: report the actual status
Date: Mon, 22 Jun 2026 10:42:37 -0700
Message-ID: <20260622174241.2299563-3-kbusch@meta.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260622174241.2299563-1-kbusch@meta.com>
References: <20260622174241.2299563-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDE3MyBTYWx0ZWRfX5iVTwwjc7VNh
 7WNvaqXGQIsxurQf5waVezBQHdaoRoFTHQKyTDGO+j772FL5hfjLSXAJ9tigYLdWKL2902cag3X
 ZZXULvgmE2Ab2i9fF7w4Ku5w95j4u68=
X-Proofpoint-ORIG-GUID: y6aOiRNygzjBummNGUUmrhUDiqwHv-3g
X-Proofpoint-GUID: y6aOiRNygzjBummNGUUmrhUDiqwHv-3g
X-Authority-Analysis: v=2.4 cv=GK841ONK c=1 sm=1 tr=0 ts=6a39742c cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=GbPsI2Ihf5RTnMjR_gZv:22 a=VwQbUJbxAAAA:8 a=3Jhqao3C4D3DWECJMaUA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDE3MyBTYWx0ZWRfX2ANhBin4I626
 zmzzJUn/KfrVRzjmaGZyqSofvoVfdNxCtUHt78SxODyjsIAvQJ//2Ot9S54cIFD5Ya74zxwi3F7
 6MUUqsPZyabDJtaTcEkjYW29ydptu1lb1QX4MIY8V6v0xcxH8Vy9D57n8/a6F0qDO7DNagpySKD
 qRbrCUOvNqnhy0CFqF14QPOlc9NnwHA9D6cnDFayvskIbgnhVGZJzbZL/pEhM5l97ewU5cKDGhm
 pFqhLSPSP5hNxfYqmsgApPndL4fP6r+iYJSnYeXz1eNPmcJpFkD5r062cAz2XkK4K6tqjniz0zG
 T3LZw4Ath0TCznnrtB9yLHu3PtwgdioCHf9rHXYgg25Lak0/mf4GH/FeXHlv8eVysoV9SJNBtNf
 MdIP9ux5eHr2M/iaCqGAQymB/LAlM/4/SzX6t7WAK8HpzHT21PRkTBJXxsgDOmj80FruRDw1xhF
 ceDgH0h40RDLcs/LFmA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_03,2026-06-22_01,2025-10-01_01

From: Keith Busch <kbusch@kernel.org>

Rather than assume EIO, set the actual reported status for user space
informational purposes.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/fops.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/fops.c b/block/fops.c
index 15783a6180dec..f237d6cab8975 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -218,7 +218,7 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb,=
 struct iov_iter *iter,
=20
 		ret =3D blkdev_iov_iter_get_pages(bio, iter, bdev);
 		if (unlikely(ret)) {
-			bio_endio_status(bio, BLK_STS_IOERR);
+			bio_endio_errno(bio, ret);
 			break;
 		}
 		if (iocb->ki_flags & IOCB_NOWAIT) {
--=20
2.52.0

