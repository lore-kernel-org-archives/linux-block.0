Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6832F3A3E6F
	for <linux-block@vger.kernel.org>; Mon, 20 Jul 2026 20:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784578288; cv=none; b=dSQY0X0RmBWLyAzUSRNqO6ssbUn0QrsenJ+9ngdLlicUOTSUshGhowO3zsmE9fWg651eJi8eQHfFqCWIMBkA5sEJQuARHEhjdX6cWJSJMJ33nohApIW1Vg+PMoQJOTVRlyUjUPjGd6IOPLhcdmJPI1xJRZG2YpOcceISZVHmCcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784578288; c=relaxed/simple;
	bh=4Ufd1cKEAW/vVKZPyn1hSS7idDIFldZqPDymbVADKpM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bBc+vbRD6jzMIrBW1L2F6JqWqdu5h4dYm3ht+cnmVwhnN01Xy77j89jCauNXguEEVjbkFf0qJ7RpXsq9uIA7ZnN5fik4Q9EHpdCN+iU0Xz+QxDgeaU/hJAy30iY8TxS335RiE5QEqb5GDK864Pdbj0/MVNqcrj8zzK0XjvPdWzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=SolxgFuc; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="SolxgFuc"
Received: from pps.filterd (m0528004.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66KJQkQw2797068
	for <linux-block@vger.kernel.org>; Mon, 20 Jul 2026 13:11:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=jkx678gHemJwfPTUCxVPJsQAnafxbenwVYd+UUmdfN0=; b=SolxgFucmP40
	SHcy9kdnHjCS29JqDUF/nvZIe28lj7xCnBddhYHIcAnLf6a57+R9EfFwAwebpflt
	Ozkn8qilFYwJi2N8tuUWyqOBOTVtVdYg84hcOvtjvE97a6jbcumEGLHn7zhjry4a
	/F2EMl28BU7mpOfLp6IYzzCH/OOEn7MXRueToMX9E3EYme/Hd3AGGKBorKXaUID/
	CElI40Xoz3R1vc2gyD6jzED3J5nkPuja5ZPprRriEpCPmtq41vHgQlJrO65JZb6C
	t8P+Q7TWuTFXK9k4iSJbrd8KPVCG2dRPR0alTWJ7qm/noezhpimk9DQK4z3XpksQ
	m42jhuS+jA==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4fgu4dfyys-16
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Mon, 20 Jul 2026 13:11:26 -0700 (PDT)
Received: from twshared25342.02.snb2.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.41; Mon, 20 Jul 2026 20:11:21 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 8EEB325A00283; Mon, 20 Jul 2026 13:11:03 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
CC: <dm-devel@lists.linux.dev>, <hch@lst.de>, <axboe@kernel.dk>,
        <brauner@kernel.org>, <djwong@kernel.org>, <viro@zeniv.linux.org.uk>,
        Keith
 Busch <kbusch@kernel.org>, Hannes Reinecke <hare@kernel.org>
Subject: [PATCH RESEND 1/5] block: use blkdev_iov_iter_get_pages status for errors
Date: Mon, 20 Jul 2026 13:10:53 -0700
Message-ID: <20260720201057.1862857-2-kbusch@meta.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260720201057.1862857-1-kbusch@meta.com>
References: <20260720201057.1862857-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: TEprmQSNDu5gSpyALBkGfgH3uCYicevu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDIyMCBTYWx0ZWRfX7m7f6FpQVYNr
 Fk3PuJa6HxUhs3/mSjkPX2ZL4LYyTAay7iumD4ZXI3899PufHmcupqRbWGQh2LW0ck6l1Ozqqj5
 +FyGYCJLmCXOHf9gqThxkKBrSe7+5gbArmuGUs9Eqw8CiuAiqPU4Vv3w1KJptwRd0l1Azm56agT
 uX0I61shLk6XVJR6qodTvv3ImHmNaGpo+qOFR5n0gfQz6FxpUkDOfFbRc36ozz7HjVDMaiXeKES
 jvfX90bUkeIuXJjlwr1sAYPv4yVZYZzykd2HKLIdTbGh20tL+t8efNqYsHHhH7FNszlLh6OHnMp
 zVCSb5Hxw2l2CsxWIHvnVbrgm1NjJ/chGzYmUSxuLvZ7JC7isWtpwTO6biG9Tw8tP/9iptQ4Cbz
 CAddxCEHstw6uxWChCsnD8/ZAI7JKWiBbtf9gJ5NhDyE/t9PKwYtPdJHPeY5q+Cqrle3plV42hd
 /udkdBmjAIeL6YcKjvQ==
X-Proofpoint-ORIG-GUID: TEprmQSNDu5gSpyALBkGfgH3uCYicevu
X-Authority-Analysis: v=2.4 cv=NOrlPU6g c=1 sm=1 tr=0 ts=6a5e80ee cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=GbPsI2Ihf5RTnMjR_gZv:22 a=VwQbUJbxAAAA:8 a=xbwd-4vLOdmjPcKMbXEA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDIyMCBTYWx0ZWRfX5GBPuQJu4zDC
 hPv539rmcDT20wMIgk6aGDnx6DCC9tjN4GpnQuyvM7NO9RyGeAYYSId5ku0if789GQfF7Tr3NPd
 P4SDE2B+cgxuLumPdqt37K6ZpOAHXyg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_05,2026-07-20_03,2025-10-01_01

From: Keith Busch <kbusch@kernel.org>

blkdev_iov_iter_get_pages() can return various error values, including
EIO, EFAULT, and ENOMEM. Set the actual reported status so user space
can know why an operation failed.

Reviewed-by: Hannes Reinecke <hare@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
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
2.52.0

