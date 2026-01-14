Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376363A0E99
	for <linux-block@vger.kernel.org>; Wed, 14 Jan 2026 15:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768405816; cv=none; b=O0nue9Fy5YjJyT/71wyaHdFhme4VIfUZydpN8o+dNJg2fKyAXCp+j+xf0O3Nqq+4MaWaJePKKygtzSzm3NxXtQsJ8JZATi2ahmjjY/VUYFaIBI4oKAs1ezB9Vomzk6zgImHwGZscaFyWm+m+eCpyMapRS6V8Kg1yM6XuVhKXygg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768405816; c=relaxed/simple;
	bh=byKDfj6MCdpyXcj4HHf5n+mXU1PgMHXT1im0hS+v5bQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=E88q+IaEycANWo130IGMXQ355h0fGuzoWjqezcsbECxNpLzC1pR4LjMNsKlj2sfyxBlHtp+AsM3jVgYwi80AkmfGV8qgrUMmX6NAl4lSJTkyxCzJVKgQAzDRqiw2qSDQ9zju9ouxk0cPHjMFIG/FOj/zpO8c4aD92xSyOtfDWmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=LAa14FUG; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="LAa14FUG"
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60EETCIm3185095
	for <linux-block@vger.kernel.org>; Wed, 14 Jan 2026 07:50:14 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=nnZp9YpASQ1OUGLyup
	A62bMs4vLdr0jc5gOwcDPoE4A=; b=LAa14FUGkehRub3u+28jpMPogFZrr1I+k1
	NTq7TFAdOvQV5MgVkRwUy1UzXsxirLXnS8Zc1g7Vv9VdwzcX60peR0Nw44zMFPAm
	6u37RYF8H2pDRzJC8OvJOLeAeoezxsa+KedysETMeu5byjZP5D55jKd51Xmn+G8j
	LukrgT1pAyHvpZpyCNsLVlyeuNQw2U/fnuL4RxChOBS6Pe3L1nTEJyRdhGUi0ccT
	YX7pdCZ8yUHidd4TYNR+NWDpfTbDRaOm+uOEDDjLchlIoW2Br/TOmAta9F4ECDaJ
	qCaPVf8QavgFGoRv3MpRuDimCmQxOFvkL7Im3P7h4d6ZmgpUP/pQ==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4bp0fy5s5r-8
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Wed, 14 Jan 2026 07:50:14 -0800 (PST)
Received: from twshared26871.17.frc2.facebook.com (2620:10d:c085:208::7cb7) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.29; Wed, 14 Jan 2026 15:50:11 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 1408963A9E12; Wed, 14 Jan 2026 07:50:09 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <dm-devel@lists.linux.dev>, <snitzer@kernel.org>, <hch@lst.de>,
        <ebiggers@kernel.org>
CC: <linux-block@vger.kernel.org>, <axboe@kernel.dk>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [RESEND PATCHv3 0/2] dm-crypt: support relaxed memory alignment
Date: Wed, 14 Jan 2026 07:49:52 -0800
Message-ID: <20260114154954.3282207-1-kbusch@meta.com>
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
X-Authority-Analysis: v=2.4 cv=R/kO2NRX c=1 sm=1 tr=0 ts=6967bb36 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8
 a=vQmTTPZ8llsbAUrI6W4A:9
X-Proofpoint-GUID: 4_HvCiBeZF8GYXLE_hoFp8NE-HY7fOzB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE0MDEzMiBTYWx0ZWRfX+Gj0/QtRehcq
 UMwXSfcE27TbOHh1ZAjeKuvtSmAEk3HZ2pa0DO21ljPOiPUxfZ3g7zrR75RI2Z7SpxkUip3AOfK
 UZhs/03Rtv8NH0madN0bK2gMSHCxt+D0pC+7Bq+6eXVjavlnPsbk2wXzIa6qOCas01vjOoFrWuT
 sYpSw2ixqtptLFF4dow+Vwm3Z4vvBvm85yCWb6sMhr5rDKWkJE9zIPBXuByigS59couA8EQdxjf
 9NGRe/zeugatT2N+th/wQjFl4GQEcdGtTvKsDdJAtSkvji6Lq/52mBRJpgUVPwixfv48JT7lM4m
 YeWJi89qqWx1QMUTkBbZ3XEHpJCjsai4MNIvGTZQgSHa02OvN62L28KdK+JtZP4iBHna7yItQmf
 r5vlrO51dHJaCr5YcVJ64e3RM5kdkE0TApgVIKHHlHgNbppXUl2Xtyh5O6jr0fNBFp8YSqy+FoP
 jOSYA29ImzZn5BiB1ig==
X-Proofpoint-ORIG-GUID: 4_HvCiBeZF8GYXLE_hoFp8NE-HY7fOzB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-14_04,2026-01-14_01,2025-10-01_01

From: Keith Busch <kbusch@kernel.org>

Resending as the previous send was bad timing with the merge window.

Direct-io can support any memory alignment the hardware allows. Device
mappers don't need to impose any software constraints on memory
alignment, so this series removes one of those limitations the dm-crypt
mapper.

Changes from v2:

 * Don't change the default stacking limit to allow the relaxed memory
   alignment requirements; have the caller do it instead.

 * Fixed scatterlist memory leaks when handling the case that can't
   use the inline scatterlist.

 * Fixed segment boundary check to use the crypt_config rather than the
   lower level block device's dma_alignment, which may not be the same
   size as the cc->sector_size which was used before, or the newly
   enabled 4-byte alignment this patch set allows in certain
   circumstances.=20

Keith Busch (2):
  dm-crypt: allow unaligned bio_vecs for direct io
  dm-crypt: dynamic scatterlist for many segments

 drivers/md/dm-crypt.c | 114 ++++++++++++++++++++++++++++++++++--------
 drivers/md/dm-table.c |   1 +
 2 files changed, 94 insertions(+), 21 deletions(-)

--=20
2.47.3

