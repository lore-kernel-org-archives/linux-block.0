Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C29F1632C8
	for <linux-block@vger.kernel.org>; Mon, 24 Feb 2025 21:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740432686; cv=none; b=plvT/IYMeWCJXk3FpWzIgnb0W31KZdSKfhthk1hG7Gq2nEXZpbwFbMaEEqhcHRKRbKD8EjNg29l2ddia0XLe8jBvy3G0+qg6ksSuJXXI4EltbUqMSjx8+xDO/IWBW/wuGUPdEoGH2Y8j1K8KieKGKOOBKyjK7P+vu/4I3To+jtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740432686; c=relaxed/simple;
	bh=Ge431Po1ujRaRqKpPyxwV/no1ZsNP+WgRZlxPZWkCAc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IRWpwP8I+Wn4Ud9Cgy8DjGapf0rNzEhyScRYCaOOCPwX2ZDvLPzRwFqItGTHhRxsqgyFY8cX+iMqqC6i/yEq7tM0tyCjAtB90z01oMVe/bkUYYmE3Y9WNTrSbQhLI7ktnn/5qJ62gAqQhJt2tuDeEAkB5p05UckZEHt6P/cASBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=mI1qOJ8u; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="mI1qOJ8u"
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51OIueGS016585
	for <linux-block@vger.kernel.org>; Mon, 24 Feb 2025 13:31:24 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2021-q4;
	 bh=qUmUHHe0j+uWHLe+m4CdCPyVThJx6/A6xtMjccdwVVg=; b=mI1qOJ8ucNXD
	qpn3JCGX/3GKQUjFHlhIvOKojh5R+l1OcKjfPlkPFRcQlShoJY16NhVf3V1w2xGh
	0cw2z6hxBFQazhZtqw/EZ8i7orAnm3G1akV5fAlv4GxEMVf/L6si6sWUuJNfL0mU
	2TIjPGllK6tKMdqtgjw5AfymhMOJKG8dQQ3Suq73ULXK9OuLlfSQMYJ7HyX/mMFH
	wwG5wD0IexIbo5qvkZv0BducOmlVV9VMqHDBMEUcJJEtn1+prRnsz8DogCxwyrAl
	QpW9cOzemlugYwAO4O57fcHGLspDRy/jLWZ//qCfFvUMUKm1ZBQKR29ZlgWpV4H8
	Y+LDEgtK0g==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 450xg0s6s4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Mon, 24 Feb 2025 13:31:23 -0800 (PST)
Received: from twshared9216.15.frc2.facebook.com (2620:10d:c0a8:1c::11) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Mon, 24 Feb 2025 21:31:15 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id 5A97D1868C4EB; Mon, 24 Feb 2025 13:31:17 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <ming.lei@redhat.com>, <asml.silence@gmail.com>, <axboe@kernel.dk>,
        <linux-block@vger.kernel.org>, <io-uring@vger.kernel.org>
CC: <bernd@bsbernd.com>, <csander@purestorage.com>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCHv5 02/11] io_uring/nop: reuse req->buf_index
Date: Mon, 24 Feb 2025 13:31:07 -0800
Message-ID: <20250224213116.3509093-3-kbusch@meta.com>
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
X-Proofpoint-ORIG-GUID: ob87U8_cOlcQn5DFS8U2C1d27A3pM-7g
X-Proofpoint-GUID: ob87U8_cOlcQn5DFS8U2C1d27A3pM-7g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-24_10,2025-02-24_02,2024-11-22_01

From: Keith Busch <kbusch@kernel.org>

There is already a field in io_kiocb that can store a registered buffer
index, use that instead of stashing the value into struct io_nop.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 io_uring/nop.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/io_uring/nop.c b/io_uring/nop.c
index 5e5196df650a1..ea539531cb5f6 100644
--- a/io_uring/nop.c
+++ b/io_uring/nop.c
@@ -16,7 +16,6 @@ struct io_nop {
 	struct file     *file;
 	int             result;
 	int		fd;
-	int		buffer;
 	unsigned int	flags;
 };
=20
@@ -40,9 +39,7 @@ int io_nop_prep(struct io_kiocb *req, const struct io_u=
ring_sqe *sqe)
 	else
 		nop->fd =3D -1;
 	if (nop->flags & IORING_NOP_FIXED_BUFFER)
-		nop->buffer =3D READ_ONCE(sqe->buf_index);
-	else
-		nop->buffer =3D -1;
+		req->buf_index =3D READ_ONCE(sqe->buf_index);
 	return 0;
 }
=20
@@ -69,7 +66,7 @@ int io_nop(struct io_kiocb *req, unsigned int issue_fla=
gs)
=20
 		ret =3D -EFAULT;
 		io_ring_submit_lock(ctx, issue_flags);
-		node =3D io_rsrc_node_lookup(&ctx->buf_table, nop->buffer);
+		node =3D io_rsrc_node_lookup(&ctx->buf_table, req->buf_index);
 		if (node) {
 			io_req_assign_buf_node(req, node);
 			ret =3D 0;
--=20
2.43.5

