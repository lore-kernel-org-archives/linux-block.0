Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72AE27E7EC
	for <linux-block@vger.kernel.org>; Mon,  1 Dec 2025 21:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764625276; cv=none; b=Mfn7ySgimqm0p7CymYVeK11iGdprxKxfBSc/v40ZFKVrjfb3sL6v8ESZTtJ7xu2bCIfxto3Uph6BjfYHR9PhWKAkYx7+InXFK6nsMDmLj6KcK+QkK1P7kz0pVnB6gHE5Pbsn5AqPNHoyxd0gC+idOnFVs88QXw0eXKiVktU/CKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764625276; c=relaxed/simple;
	bh=j1NU4+NGiQ7RutjyajLr9mG7Ukgl0BNXMrZuBj/dANI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IRl+kYIsEQRek8CSGAVEVJLlWmOJ8oeiUMyEXoYC8aXrYRDEc75JAmAayhRUmePBjPoL8e56lbhxLkKeI7wqBwBYagG88GtHM3ARva9t7VjcafPJz/eMvjWWIhMINgtvFk9AXMdUkbk1p1D6x8hgrFcW3pUInAinmBR+cDCRLlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=m/c+rAnX; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="m/c+rAnX"
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 5B1LcceM2417578
	for <linux-block@vger.kernel.org>; Mon, 1 Dec 2025 13:41:13 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=NkTsw9i8Jm1BHcUsDq
	jFFna8TOhgouYji46exI5azp8=; b=m/c+rAnXt9SEu4uIVi+Qu2JaGL8ZHEpsfM
	CzzuVwcy8GBKlLsnM5hd23BPx/KkZfVQsAXJ/be9CYigYO6wMQO5BJRWGx6DKLhc
	IxrU+lMqcjarUGtFRNS5WCWIc2VvvvPqFQASCu08kJwTVL5rO1lIzl6APB0VSa6y
	wYVGy2SrbXvHEIIJ/r9ZiNQkH4IHqkwiK3ebOKMatIWJ0fk3jQ8GMUOKGax8jRkx
	F6UPz3A3g1ry+a4Mct2WMFg1swvfKOGPr9CV325ZzqrtTNYCdBUlPi/uV4mKhRiC
	cY1UIGQ1O4DV58HQN2mvbDdSDc/hOCBK5GgfeLR4e8V8L5Vwsscw==
Received: from mail.thefacebook.com ([163.114.134.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 4ask4480p4-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Mon, 01 Dec 2025 13:41:13 -0800 (PST)
Received: from twshared31947.34.frc3.facebook.com (2620:10d:c085:208::7cb7) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.29; Mon, 1 Dec 2025 21:41:11 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id A947E45AA89F; Mon,  1 Dec 2025 13:40:56 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <dm-devel@lists.linux.dev>, <snitzer@kernel.org>, <hch@lst.de>,
        <ebiggers@kernel.org>
CC: <linux-block@vger.kernel.org>, <axboe@kernel.dk>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCHv3 0/2] dm-crypt: support relaxed memory alignment
Date: Mon, 1 Dec 2025 13:40:50 -0800
Message-ID: <20251201214052.1531952-1-kbusch@meta.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjAxMDE3MyBTYWx0ZWRfXwSkZvSne5otO
 4yAn5UTkByF0DZD6+NKiRnkdJFjQ5VbniAPNCMRx8p3c3VqWefRUda+6QQNWWsvcCLOPkLS+CNV
 hnbCZ+xUm5Gr45YLLr9aOY1cpCWWKUGOdDhN2tYR86TcxSiZPpI+xUixFKdPNTPQs5oZN91czIm
 tfJ4k/aY6o+FKU456cKvao+XYFZuFuQGoe6Ah+0Br+gJK79iKIpW3aI5gBlFjO0ayb53g5tWKZq
 HOZVfbofogX5+JZngKr7HGLDae1BICx544hQZcN1OQqtzE4iaLrf9XSG0UcBe/FoZM9tyFYPnIi
 bfYr4Zu1mAWoc5KtNVPi8CT/k4g9dHwU6/SOu/MA6Q46QBMszI2OqwQ5fE+u5DwcZf7OyiQ2w5t
 fh4kLRIs6DRRsagY1F4JkP+n9ZubsA==
X-Authority-Analysis: v=2.4 cv=LYExKzfi c=1 sm=1 tr=0 ts=692e0b79 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8
 a=vQmTTPZ8llsbAUrI6W4A:9
X-Proofpoint-GUID: _O0luuUViqL8RHPutYiXkKMUjuknMsDe
X-Proofpoint-ORIG-GUID: _O0luuUViqL8RHPutYiXkKMUjuknMsDe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-28_08,2025-11-27_02,2025-10-01_01

From: Keith Busch <kbusch@kernel.org>

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

