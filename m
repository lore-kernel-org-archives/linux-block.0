Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B301FC7CB
	for <linux-block@vger.kernel.org>; Mon, 24 Feb 2025 21:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740432702; cv=none; b=FF0F0PozFiq5R0WLNBuvamrNz2otf526IHl5iv14ixBMszGVcjBbBz74vUUi1P+Hq8NVG134YE547gHXBon3iUkwtaPKiBBTH10CfR3PiXKAbAZMYArTiIye0C8Hg6yiLwRGYZgZ4GI5dJBB99ud28d11vU2MSN5DPNOrvG+Oi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740432702; c=relaxed/simple;
	bh=ov23JLGISNFtGAJ3q/hjds5wAHClRaKSX9bv0Ek/R6E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OTD7hcBGYnj6cJcI4mYWHtvyWGq8fFH6Z0ehVtw+mWeh8U9Qh31cHLPX1KCDeiMkVB6voTIHYCO7NxFpR4MFhG4SaBAuUzJgkgobO6N0Kx7dkq+BcfFmx8Q88WnzB+/0XBsoh88LLU5VhobOeIEj2+ia3SemSj1jx3Qz+dR9FAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=ULbSLL0E; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="ULbSLL0E"
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51OFDF2F023467
	for <linux-block@vger.kernel.org>; Mon, 24 Feb 2025 13:31:40 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2021-q4;
	 bh=HVuEJr6UbILHmR6HfKP+QsgqAVu4/LafIuqdsitVN9E=; b=ULbSLL0EqLVN
	+34xp4XPMre42lKcvP7utGBa9oYip3y/c8XF9K5Z0dU2DLaoGxeOaG0ljXCedLTA
	fckAFQ9s+av35SPnMeSSiqAvWBJCgQJ5vR4EbELO5fpfeQhe7l4ut0gUt/mpFbwu
	tYLQ47UBKCS5V6yJEdEb4a/e8GmX9fkXPnZei/d1n8NUlLl4fM7ccidMb8lIO45a
	B3JIFc9WJ2DPZIbIGXLPR+0Kjrjfnvu1iZmBDgJMfm9QfTBGKOkNKz/FjxBKWODY
	K+8/4pF9teJCAhr3J1S++T769duIqFy8HUoyd6tkl5oZoL1C6gIDQxDlL8Mrwpoy
	2bxVpu/eig==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 450tdcufs5-16
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Mon, 24 Feb 2025 13:31:40 -0800 (PST)
Received: from twshared46479.39.frc1.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Mon, 24 Feb 2025 21:31:24 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id 528821868C4E7; Mon, 24 Feb 2025 13:31:17 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <ming.lei@redhat.com>, <asml.silence@gmail.com>, <axboe@kernel.dk>,
        <linux-block@vger.kernel.org>, <io-uring@vger.kernel.org>
CC: <bernd@bsbernd.com>, <csander@purestorage.com>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCHv5 01/11] io_uring/rsrc: remove redundant check for valid imu
Date: Mon, 24 Feb 2025 13:31:06 -0800
Message-ID: <20250224213116.3509093-2-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250224213116.3509093-1-kbusch@meta.com>
References: <20250224213116.3509093-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 4bfh0XQFVrZorRxrlEieXUPThCK_yGoG
X-Proofpoint-ORIG-GUID: 4bfh0XQFVrZorRxrlEieXUPThCK_yGoG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-24_10,2025-02-24_02,2024-11-22_01

From: Keith Busch <kbusch@kernel.org>

The only caller to io_buffer_unmap already checks if the node's buf is
not null, so no need to check again.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 io_uring/rsrc.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
index 20b884c84e55f..efef29352dcfb 100644
--- a/io_uring/rsrc.c
+++ b/io_uring/rsrc.c
@@ -103,19 +103,16 @@ int io_buffer_validate(struct iovec *iov)
=20
 static void io_buffer_unmap(struct io_ring_ctx *ctx, struct io_rsrc_node=
 *node)
 {
+	struct io_mapped_ubuf *imu =3D node->buf;
 	unsigned int i;
=20
-	if (node->buf) {
-		struct io_mapped_ubuf *imu =3D node->buf;
-
-		if (!refcount_dec_and_test(&imu->refs))
-			return;
-		for (i =3D 0; i < imu->nr_bvecs; i++)
-			unpin_user_page(imu->bvec[i].bv_page);
-		if (imu->acct_pages)
-			io_unaccount_mem(ctx, imu->acct_pages);
-		kvfree(imu);
-	}
+	if (!refcount_dec_and_test(&imu->refs))
+		return;
+	for (i =3D 0; i < imu->nr_bvecs; i++)
+		unpin_user_page(imu->bvec[i].bv_page);
+	if (imu->acct_pages)
+		io_unaccount_mem(ctx, imu->acct_pages);
+	kvfree(imu);
 }
=20
 struct io_rsrc_node *io_rsrc_node_alloc(int type)
--=20
2.43.5

