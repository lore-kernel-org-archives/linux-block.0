Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACACC577E58
	for <linux-block@vger.kernel.org>; Tue, 22 Sep 2026 17:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790098045; cv=none; b=sFTro4jnTqudTm8s/7RDmO50lfRN4jVKIY3xhzhv0hKosk3Vbo3ss5+ZqD3zd2fXsi2BBmCovkS68jPvifiT3eftrQG3McmmD89uQQczrnqKG/AqN8viBQ7JfIkn6MdXt4IeN31uwNdtjm99PcPRWShRPmHIWuFny5k95l0UjgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790098045; c=relaxed/simple;
	bh=nNq352D6I2xuxjd0vi11xYWOtk+G3eZQb/3pz0ojgaI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DxmGw0QmOWYceI3iutRYDzl4676kQjERK8mZ4VLi3JfBUgFU2tpQoeRXUg4Hs+tWGg6IAESAyksczNsF0ci/lzp0qybUKzUtMuUFcw/BBBphrwqa+cKgoI3AEdHWq2cBxmcqRfUG4fy2lTiHXPTIr8pFyWtfbhXlGzpztwb2Cpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=jFjZrI8U; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="jFjZrI8U"
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 68MH1pkW2628318
	for <linux-block@vger.kernel.org>; Tue, 22 Sep 2026 10:27:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=0g/yDB9JO66buRhjOa2Rq4y+j27hyJBBIMXrY
	URjKkw=; b=jFjZrI8UeH6QArbN39PccmW2cNDvOUcQhNt6W1I2e9phPOV8u4vAH
	50M6YPfhIlf9DdnoXD5c7EXygmwuK+ezwH4+ZGhRdJMmEqHfkWZr2hKYMg71R8sH
	mMOMF0UwyByh6rcC/lrGNlhlBMZsVDHPHLCZ8/JPKYnPqQwMCjm5pL+NEFNqtvMJ
	Ga2ZhEHELJUfQbXSpso7jYKVz6PcSJ4xu+IFrNMNr6Oozg/vKtv2lUSG0+k1K+IZ
	e3osjkwyk8SXINjZCO9/wMv5VfTWJkC7S/Ij6t+k9Lo52Wxtsi56XB3fcLjIX/CP
	BmFHr80WRFBk2MuVcZ7SBnfs8a5uPES4Q==
Received: from mail.thefacebook.com ([163.114.134.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 4gsp29fv7k-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Tue, 22 Sep 2026 10:27:19 -0700 (PDT)
Received: from twshared27354.02.snb1.facebook.com (2620:10d:c085:208::7cb7) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.49; Tue, 22 Sep 2026 17:27:17 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 14C282C3D7B78; Tue, 22 Sep 2026 10:27:12 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <axboe@kernel.dk>, <linux-block@vger.kernel.org>
CC: <hare@kernel.org>, <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv2 2/2] blk-mq: allow cached requests to be used for flush operations
Date: Tue, 22 Sep 2026 10:27:11 -0700
Message-ID: <20260922172711.1573186-2-kbusch@meta.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260922172711.1573186-1-kbusch@meta.com>
References: <20260922172711.1573186-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDI1NSBTYWx0ZWRfX5Y1GSiB2hMA1
 7yveTeBBixjj4kgW/zq9Q5R3l3iH06Abs0vrkTLIw9AONf03IwOATv6FEPKrbUjainhUMtBc3Ir
 QKEC5f7pbk7q+KH3I5lC3I03E4HT2bk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDI1NSBTYWx0ZWRfX18zWaOKp0dOy
 +mhtWOAWs6Au0UU8dUtVCBxnCxJUMW+IJQKsKPAf73PvFrs1Ncmvwdh8VX774jJvYoVnSwrsWw5
 6Y1sZsSQm5JLUFsdANBm5HHDveJU5OnEZybyzgOaNI/FWDGdkwr2iLcZ6y5Gsd/+KkozZJMdNNU
 Ro525bXPDboSPgcJamxatURiePO5k1AAgl4x/wBuimmhlwxM+UgQzju004wXTM32j8J5hcx618W
 PXdKCsk7MoKeC+wzPBW4/6uUYOBF38UlSLMX61LQPklUDyn9FXyBnP4p/erqkrrDRNETHZxMtkD
 VoAhvhShcGJoXfWT8LPEYbHjUn3tooszfGmvAdQlR6VNNxt7eqDffiFNl3wwOGpqJ4n0c9Rq0hN
 bwyu+UNw972iEF15p2UOkJ3XRb3VkKkaTVCZ3TZmmII6bjEHNKT9w7Dwl29gPeKETDAFISlGkbD
 e1XpN3SPuZdNqfEsdtA==
X-Proofpoint-GUID: cbvQujKm6k7x-L6cAQ71hSXmnnNDZ9tn
X-Proofpoint-ORIG-GUID: cbvQujKm6k7x-L6cAQ71hSXmnnNDZ9tn
X-Authority-Analysis: v=2.4 cv=abX0Dhot c=1 sm=1 tr=0 ts=6ab2ba77 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=_78whYxrdx1mplLwxq1U:22 a=VwQbUJbxAAAA:8 a=agf09bV8uAnK7eYYuEwA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_02,2026-09-21_02,2025-10-01_01

From: Keith Busch <kbusch@kernel.org>

The cached request lookups reject a request whose op_is_flush() state doe=
s
not match the incoming operation. That check is from when rq->elv and
rq->flush shared a union, so a request could not be both a scheduler
request and carry flush state. Commit be4c427809b0 ("blk-mq: use the I/O
scheduler for writes from the flush state machine") made them separate
members of struct request.

A cached request now gets its scheduler state when it is claimed by an
operation, so one claimed for a flush is set up exactly as a freshly
allocated request. Drop the check so a cached batch can mix flush and
non-flush operations.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/blk-mq.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 5df6d2244db82..025a799f35b92 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -661,8 +661,6 @@ static struct request *blk_mq_alloc_cached_request(st=
ruct request_queue *q,
=20
 		if (blk_mq_get_hctx_type(opf) !=3D rq->mq_hctx->type)
 			return NULL;
-		if (op_is_flush(rq->cmd_flags) !=3D op_is_flush(opf))
-			return NULL;
=20
 		rq_list_pop(&plug->cached_rqs);
 		rq->cmd_flags =3D opf;
@@ -3075,8 +3073,6 @@ static struct request *blk_mq_get_cached_request(st=
ruct blk_plug *plug,
 	if (type !=3D rq->mq_hctx->type &&
 	    (type !=3D HCTX_TYPE_READ || rq->mq_hctx->type !=3D HCTX_TYPE_DEFAU=
LT))
 		return NULL;
-	if (op_is_flush(rq->cmd_flags) !=3D op_is_flush(opf))
-		return NULL;
 	rq_list_pop(&plug->cached_rqs);
 	return rq;
 }
--=20
2.52.0

