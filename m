Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3A130FF31
	for <linux-block@vger.kernel.org>; Wed, 24 Jun 2026 17:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782322168; cv=none; b=h/9MkkdPViudX9yX3pQZGVQaYLdknRjxY717RvZO7xqUelM6JCvax/zs52pfM/RlJ/BogsMuaxktnNvS8dWgbs1SGV4iPUd5v+N1wTbEqxzbJQVVVHnqQ+m2NBRN1JDz3je7D+I6YH3xIelkmCqXA/Qi8KGHhlI02VypSuCs+Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782322168; c=relaxed/simple;
	bh=md82v5nTc8XTnpQSe3fblUv/07h/vGTvQ6G3iw0BEx0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IdCOIT2p0WNst3JxvW0Z/iQxwzv8GdPXuWhZCh1DqA7n7lKr+r9JUqfdGlKp5t4mn57ptc5+D2tpTWRUAm16Le8I0rJhsaKheK4xpxd2mvePU2f+QO+FnwGFYgv4Hk0hqpSuxQpXV1dwkmQcO4J2yHz5S19bfC8hV0jnmQ6VKaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=cmyX4eQP; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="cmyX4eQP"
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65OEiICO3801225
	for <linux-block@vger.kernel.org>; Wed, 24 Jun 2026 10:29:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=fGtIVAQu0NKnCIpvhzj3m60yyJwuBfFcp94oXfJymWE=; b=cmyX4eQP6ReH
	NQ5SeMPvA61OfSTXZwHqzdXbU9saZR9+flSfdE/8pXeCnRxU+np/6FnDH0iW3F8z
	3e6Pwsdcql8G2HzFxsBt0rcKU9fhbo36yojLhL9zrhsnZkR5CO67hjsu2VxfMC3E
	o11sdbucdECxksIFyT3Lou4ZEEWZYqd8Jj7ywo+KhRsidhaoQqp83aj60QeTV58f
	gVoFHDeeUSWgWmdn2UXgn2yetf3/I++Dc1P9on+OhVageGzCtcEKtMSQcf/yFh9p
	HNDzlbpHE7W6QR0TZ39V56MVvldP5I9Fj7lO7MueO2db09gq7i+nlChaz7BPQ0K1
	SE2dUkZRdg==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4eyumrj0py-20
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Wed, 24 Jun 2026 10:29:25 -0700 (PDT)
Received: from twshared100448.16.frc2.facebook.com (2620:10d:c0a8:fe::f072) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.41; Wed, 24 Jun 2026 17:29:24 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 0A15923C452B9; Wed, 24 Jun 2026 10:09:08 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
CC: <dm-devel@lists.linux.dev>, <hch@lst.de>, <axboe@kernel.dk>,
        <brauner@kernel.org>, <djwong@kernel.org>, <viro@zeniv.linux.org.uk>,
        Keith
 Busch <kbusch@kernel.org>
Subject: [PATCH v3 1/5] block: use blkdev_iov_iter_get_pages status for errors
Date: Wed, 24 Jun 2026 10:09:01 -0700
Message-ID: <20260624170905.3972095-2-kbusch@meta.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260624170905.3972095-1-kbusch@meta.com>
References: <20260624170905.3972095-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 0hJgEZD4GZ6Jc7RYJQSIFN4hYn9KrHxK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDE0NiBTYWx0ZWRfX7fUUDEZflK4T
 MkvyzTbwdZ/+sXTFF53EV/iogdINQHdhnBZ8Ft2h+1CNqblQKN8y82ZUhp9ZzVDbDZ1EM9GaxMP
 +R5itX8uK3Kh06TLbHqbxAyOR0+QFMc/P79tfF5Zi6wAoqjX4XYX/UFG/UwCIXHYIIbLa8VySdf
 X/wJdsoTuTbP//9s98XtAOquwo4f6xpVWZfoJKf61Ivxik2W3912Hztsr/BqmWFvAgIEeYNvOMx
 zNQ6WiO/N9elayNrgGkBcUeOaXzJ6qZRKOLCguN3NRpp+2/0eZmFq3VniuDT1lOdsrg7WKEl/WE
 OT84DObL0HvKLpARSoQGl/MXeuiSSGDmJVUVC0EjR5R4kTPLGhWa0kqY1TNwmxN6q58Q5vrWKRZ
 /z8iGvG0/7dDbOaKLfz8OD8WfvADsg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDE0NiBTYWx0ZWRfX2jw5F+ZyPonQ
 3h3g99TaQR5hhQILCkJaG4OrdYBvPCrNAQCa7MvaZaSEfAL6/hfYUUuWSolBPrQ3nlPMCgu4VpQ
 2fP2X/r7j5l8MQiHUms1D5PoRyDbLas=
X-Authority-Analysis: v=2.4 cv=YbiNIQRf c=1 sm=1 tr=0 ts=6a3c13f5 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=PAz_-FQ8hEVmOPYdF0yf:22 a=VwQbUJbxAAAA:8 a=xbwd-4vLOdmjPcKMbXEA:9
X-Proofpoint-GUID: 0hJgEZD4GZ6Jc7RYJQSIFN4hYn9KrHxK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_03,2026-06-24_01,2025-10-01_01

From: Keith Busch <kbusch@kernel.org>

blkdev_iov_iter_get_pages() can return various error values, including
EIO, EFAULT, and ENOMEM. Set the actual reported status so user space
can know a little more on why an operation failed.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/fops.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/fops.c b/block/fops.c
index 15783a6180dec..0827bb884d473 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -218,7 +218,7 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb,=
 struct iov_iter *iter,
=20
 		ret =3D blkdev_iov_iter_get_pages(bio, iter, bdev);
 		if (unlikely(ret)) {
-			bio_endio_status(bio, BLK_STS_IOERR);
+			bio_endio_status(bio, errno_to_blk_status(ret));
 			break;
 		}
 		if (iocb->ki_flags & IOCB_NOWAIT) {
--=20
2.53.0-Meta

