Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F84D28FFC6
	for <linux-block@vger.kernel.org>; Fri,  1 Aug 2025 23:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754092081; cv=none; b=iGMHDvKgElovJZD7ybNE9IWr5GpgmO1/cZ8yRfIdDW1CKFEIRQkxjLEZNPMDmwdG7ytaaxY0gtV4sfC2sHjsdZFYqfXN8j8brkjxbrTk8tNawW0HKw/9yuz1raVe6i15/ktdf0ij8QSL3S7cHSNrWY4kGww+1o8UWozKPBaw8Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754092081; c=relaxed/simple;
	bh=mwigh1V2idY6A9SL9/L28WFx/NM7jlg95nqe0sqP/+8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WWQy4/PpZ7olEBXszLrDyLP6CJRiz4yhVBH+dH5vMcgCX6kig9APxrtOe8NpLi5ZOIrw/1e/0YosxWK/scD04PnMBOFB8ulEtXJVzPO/Z3k4p/d7mbQgEwW/FdonT1LAJTyKFc524NwQDPktwKO0VzB7/edDQan0ftNdHhvbgwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=JkS333+4; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="JkS333+4"
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 571MmoZm009340
	for <linux-block@vger.kernel.org>; Fri, 1 Aug 2025 16:47:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=uwipLhSqn5UZC2Kg5fR+JZ+r9AkyBc1BguZBiS8eRTA=; b=JkS333+41vwn
	kPt021BWRQWDXTqSGe9/AzL3B8iDGkPqCU6ubnxO3W/AH47G2If56rMx5286oDEQ
	FiUKNGvaGaIfSGuABE6JWnMyrjNekv5IagiQdJfcmwaNjgUmJatWygsF4f1Kw4ll
	EmaSucgv9zpnIq318SV36w7qyi9CblG9XSloe56KdWPTHtS2MJFOyFouYHnYGV9n
	d9mcrpkmvM0h+EQX3Woa5enwDMagIvyeqZTQotxsuO4QgsC5wOuOFIq8qL6IMWtI
	FqWYNgpJO677xhUVWszpMcfVYF3R+IdIw7fubQfDm1W7rUVIdRuiLeErYfLIMTXv
	+9KjtD4MDQ==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 488rmtwjvt-16
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Fri, 01 Aug 2025 16:47:58 -0700 (PDT)
Received: from twshared31684.07.ash9.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.17; Fri, 1 Aug 2025 23:47:50 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id A54B73105E9; Fri,  1 Aug 2025 16:47:36 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <snitzer@kernel.org>, <axboe@kernel.dk>, <dw@davidwei.uk>,
        <brauner@kernel.org>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH 1/7] block: check for valid bio while splitting
Date: Fri, 1 Aug 2025 16:47:30 -0700
Message-ID: <20250801234736.1913170-2-kbusch@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250801234736.1913170-1-kbusch@meta.com>
References: <20250801234736.1913170-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: tydJv5aAWfmoaIepPntDOZ-OETtv_qkY
X-Authority-Analysis: v=2.4 cv=Vej3PEp9 c=1 sm=1 tr=0 ts=688d522e cx=c_pps a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=-ftljxYXmFZ9yweOdTYA:9
X-Proofpoint-ORIG-GUID: tydJv5aAWfmoaIepPntDOZ-OETtv_qkY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAxMDE5MyBTYWx0ZWRfXxcYlkPBGriPl e3kNaKIuIY439qYrVQth0N2n7qjoIJbmmY57EP4GUazQlWd14tjF5a/1syrYS39XyaMFpvRIEh5 a77AqFopCUnbMKO7ptVj+r4lCOGAXzwG4B9kaf9hgNGjCqnwSjNoB7DZ2oUf5SkHsBL7v05E3PA
 ifaMYN3P7O7QCGWCzNJyscS7dTZh0evBvCJ3zOKKPzBufrlPeUDjrZ6UqYUhzw/f1SrNSFD0mUA kbsmYwuD7nKbo4pB38103D9uIQTihs4SZYH1xybmNb+NfWCgj3NrIBX2A4zjAUAz4RznMSfsr4K +7xnLo0z3Z4a+m3FgjbFXkshE5fCEqbGzqxcn/C1ERfzahk+u9wtWK7yyskNx8nquh93+ltc4kb
 lEv/7WWj7ZexlCn67VVCQHYpBoua45tvnoyuaS12cW36Kb0T4uVyl8nlkYhtoBzSCH59Xn4g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-01_08,2025-08-01_01,2025-03-28_01

From: Keith Busch <kbusch@kernel.org>

We're already iterating every segment, so check alignment for a valid
IO at the same time. We had depended on these constraints were already
checked prior to splitting, but let's put more responsibility here since
splitting iterates each segment before dispatching to the driver anyway.
This way, upper layers don't need to concern themselves with it.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/blk-merge.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 70d704615be52..81bdad915699a 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -298,6 +298,9 @@ int bio_split_rw_at(struct bio *bio, const struct que=
ue_limits *lim,
 	unsigned nsegs =3D 0, bytes =3D 0;
=20
 	bio_for_each_bvec(bv, bio, iter) {
+		if (bv.bv_offset & lim->dma_alignment)
+			return -EINVAL;
+
 		/*
 		 * If the queue doesn't support SG gaps and adding this
 		 * offset would create a gap, disallow it.
@@ -341,6 +344,8 @@ int bio_split_rw_at(struct bio *bio, const struct que=
ue_limits *lim,
 	 * we do not use the full hardware limits.
 	 */
 	bytes =3D ALIGN_DOWN(bytes, bio_split_alignment(bio, lim));
+	if (!bytes)
+		return -EINVAL;
=20
 	/*
 	 * Bio splitting may cause subtle trouble such as hang when doing sync
--=20
2.47.3

