Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C6427A11E
	for <linux-block@vger.kernel.org>; Tue,  5 Aug 2025 14:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754403105; cv=none; b=nIClaOs5RLGQA+HQTxj0861WqTNLW3CczVTb4nDpRj2JsSh+weAN6IquL3ysJQQoA5WTLtqQWGR7J9fhCfn4Ih/toEvuiPqBbP79JL1oIv5mrj54QCzAwDXNZFTRZUwQVyAwZqUHl6m8RRltKslf5weUlBrHBJvtZfxqMlRTsuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754403105; c=relaxed/simple;
	bh=T38d36O6jE3OZut66S1BIIGBnUYM/bO7UHb8Lrjuqu0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A25V/g0XqMiZSXzwYQUyip1iZ8duqYpasqNewvvbzTtAXL6qvUNWYWAXPRAow9+mZfiN8EaWVxuzoxK4zJNp4QvJSMKHymih3dRGNrRvVGNL+nj+YTpQ/ufKxdSLyjVn74oo4hpZyWMA2C2HYsLf6/Xd6aq5ri3c3DwtKP1ckDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=PmyZpKkd; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="PmyZpKkd"
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 575CYLgY022527
	for <linux-block@vger.kernel.org>; Tue, 5 Aug 2025 07:11:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=RuONH4h6XBh6KQsjcqoAAXlkSkTgfCY/q+o6rZEieIM=; b=PmyZpKkd6p1k
	bChFn1fBRuLunXGeBBKs4OQPVSevQYML1POFr36ZoZyvbM4JSkaqj2NLYjNPPL/C
	ctYo8o3r47li8mn8nJfk/ofH/g5odGNTXy2yxCKQBUaoGcuHOPz2LaUuur2U7s4Q
	6HCRW0oS57cDM4KrC9BuwS51XtOEngpEQOlQKrqiSHDS8HVHeJZt7CQmttIktpl7
	Yt+zTEYckkiStN7IIrp/rCzjTv6HccH3p9GLTgC/YJdhcK+iOlEJsO4aX1awZllI
	r4yklqJ8FCkC6ggVrnm1r8nd8mh/lbdKZqv7Qi4hzZA9p2AM+AQs82x89I2Z9XfR
	/Z3GnWKPJA==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 48b5t3vthw-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Tue, 05 Aug 2025 07:11:42 -0700 (PDT)
Received: from twshared25333.08.ash9.facebook.com (2620:10d:c0a8:fe::f072) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.17; Tue, 5 Aug 2025 14:11:37 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 000EB4FDD53; Tue,  5 Aug 2025 07:11:23 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <snitzer@kernel.org>, <axboe@kernel.dk>, <dw@davidwei.uk>,
        <brauner@kernel.org>, Keith Busch <kbusch@kernel.org>,
        Hannes Reinecke
	<hare@suse.de>
Subject: [PATCHv2 5/7] block: remove bdev_iter_is_aligned
Date: Tue, 5 Aug 2025 07:11:21 -0700
Message-ID: <20250805141123.332298-6-kbusch@meta.com>
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
X-Authority-Analysis: v=2.4 cv=O9U5vA9W c=1 sm=1 tr=0 ts=6892111e cx=c_pps a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=x-sBDG6hxYFL5DTe09MA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA1MDEwNCBTYWx0ZWRfX3DH1+SBwyv79 iPl6gxAqWhv5AY+7qurmtvhvrKYTXJUHoTaAdXnTFdeqScdmmc8VRLxe9PJpe0qTXpBLC2/OZAt +VV+u4m3HWML3HC5/7cqIcm52vZbMjngGRRXzVmbC4xsIrl34JhpW3VuoIpR8+NOW4+xSBxvgJK
 U0C4lvndQmgWOgRVV/r/AQOR2KcDtYxNrOajkg2POjCd+mxFXqdaVtnRXTOhGqeE/b9o9H/kzIe eaBgUlBV78vMCk2v2SjnmGf1M+SHqdrMCn5R6T4m+FERvoFYoHjJqlUTxxwwpfoBXHznqVehO9J SDoD4BTN6zYj98dEE6ZGVXfhD7bipjdgPUyDLXizXiECuCuQo/focArlKuiBmPRpI4o0ZYN4c5G
 K37TZrzgAkRht+CCzLNexlahnJx00uAjI8hLMnYOxvwHEHbCyBoKwz7BVs0QxNXpGGCs/xUT
X-Proofpoint-GUID: HZLZGbBHjExSRwKnc2HoCIEh2XwvHj1l
X-Proofpoint-ORIG-GUID: HZLZGbBHjExSRwKnc2HoCIEh2XwvHj1l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-05_04,2025-08-04_01,2025-03-28_01

From: Keith Busch <kbusch@kernel.org>

No more callers.

Signed-off-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 include/linux/blkdev.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 95886b404b16b..f86aecbb87385 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1589,13 +1589,6 @@ static inline unsigned int bdev_dma_alignment(stru=
ct block_device *bdev)
 	return queue_dma_alignment(bdev_get_queue(bdev));
 }
=20
-static inline bool bdev_iter_is_aligned(struct block_device *bdev,
-					struct iov_iter *iter)
-{
-	return iov_iter_is_aligned(iter, bdev_dma_alignment(bdev),
-				   bdev_logical_block_size(bdev) - 1);
-}
-
 static inline unsigned int
 blk_lim_dma_alignment_and_pad(struct queue_limits *lim)
 {
--=20
2.47.3

