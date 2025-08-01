Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5892923D293
	for <linux-block@vger.kernel.org>; Fri,  1 Aug 2025 23:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754092076; cv=none; b=XDhZCKqlt/RJXVmOanjUSOD5MS3MaIM34/1CGZYtn8JyYKFHw8Mx8kLpe3nbgjrrFdIaVhTaduIRLHQwroHuKirkSRxnH51/km45+DZDJ2UXxXDAeakDJFrif4GymLPTDUg2FgKlT8I0PsXbPKbw4/OS6D0VvdexcR9UYVJp1PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754092076; c=relaxed/simple;
	bh=gdIVjT3vlKOt+2mbfWTWwWZ2gPoA7XxoHfplCpsaon8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a1hXpg+sEwFYMO0XNXlzfyLXk87AWYZsAiBhcoq60K56Umr+DXyLgNEh58u7RGDd3Zz8mbCe+BetgbUeoMsy3Ig4Ihm+fAjcwWJDoBkhsS7SsAHUcMPBp2q6VPefMmDL8y2Mfi5kjSvqJHzhlaA86RLrzRpd9ylpSKkhoiPhgZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=dl1NAjHo; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="dl1NAjHo"
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 571MqFEI027978
	for <linux-block@vger.kernel.org>; Fri, 1 Aug 2025 16:47:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=1SMXkSebdaxUaoNdomo0qGyDMDQR8jUQzMvUjgNXeBc=; b=dl1NAjHoKtdf
	40azB8cH8aKrpu4U3nB5u/zuNbF0DRTB8fjdNMKIwt1sD9/ZeCMQdBAP4GcG5Ym+
	x/9j7HeJROiIgrlrGoEyeqLQTcJN+g/S+Yd0S518B8oKpx4uxfMxAoIhY71F4jvx
	5hbH220NfU28MPv8DuCuEmRnOZOWM+ZueLSTdESDWlH8u1I0dcFU4ItUKAJAGhT5
	vCbHMj9VZvn6pZ9R4I3+Pj+Eajbkc9/9bELORqhwDRn4hOxJagchN/iVX0DIDNQI
	z0b/tI4dP7rTs2d6YCdGfQVRnhjHtYNd5854I1HhNYrOKnmPOQTioiEpvV/b8rX6
	n9yiGf6ycg==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 489286t1ts-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Fri, 01 Aug 2025 16:47:54 -0700 (PDT)
Received: from twshared31684.07.ash9.facebook.com (2620:10d:c0a8:fe::f072) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.17; Fri, 1 Aug 2025 23:47:50 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id B2F063105EF; Fri,  1 Aug 2025 16:47:36 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <snitzer@kernel.org>, <axboe@kernel.dk>, <dw@davidwei.uk>,
        <brauner@kernel.org>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH 3/7] block: simplify direct io validity check
Date: Fri, 1 Aug 2025 16:47:32 -0700
Message-ID: <20250801234736.1913170-4-kbusch@meta.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAxMDE5MyBTYWx0ZWRfX4Ko/JZ9nU5N5 fUd6tHZ2D88WP+IHdMvbUeVg3JZxLJ5FrhfghBOPoQFY/Z1spdB4ncHULqFPQYpV61820A/AzUX x+k+tSxxGIunznzxKmhuWvq8HdYIAEA+sVixYc24rCM+eEo1Pmg2RK+IPcBxrPE+aj/CjLzPv4W
 tdyPxrWmJvFhfx7S183qCGe1oRjul4Lor7OWXXhMIIxobS4MQZzuipkZTiQnRjMzhFYmVycl7SC MeIhLXFTqiRayLeCcYiLmoavI3egGBqODbRJUHmS9DFGEG8s3pNanWkA/9P5ySBAfUXXEPLqtsk TO/YEcLBws1IlcilDSr59Tz6DgbmmAXY93Qs3+HJ+9oMMfPkAx/UQMuRM+X1tkCTw2muaWEZrFu
 1dYwR3Zayu/2H6TyBksry8IGXlV84pT4PEj4A4z3IXMvx4Jb6gkOBzjvgtRRR4g+i0rD0Y5R
X-Authority-Analysis: v=2.4 cv=ANL1oDcN c=1 sm=1 tr=0 ts=688d522a cx=c_pps a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=IZBY3vBkjIs1pqmLj1YA:9
X-Proofpoint-GUID: i3abIif9oOotqglJctZEKUoWQTqmkSWm
X-Proofpoint-ORIG-GUID: i3abIif9oOotqglJctZEKUoWQTqmkSWm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-01_08,2025-08-01_01,2025-03-28_01

From: Keith Busch <kbusch@kernel.org>

The block layer checks all the segments for validity later, so no need
for an early check. Just reduce it to a simple position and total length
and defer the segment checks to the block layer.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/fops.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index 82451ac8ff25d..820902cf10730 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -38,8 +38,8 @@ static blk_opf_t dio_bio_write_op(struct kiocb *iocb)
 static bool blkdev_dio_invalid(struct block_device *bdev, struct kiocb *=
iocb,
 				struct iov_iter *iter)
 {
-	return iocb->ki_pos & (bdev_logical_block_size(bdev) - 1) ||
-		!bdev_iter_is_aligned(bdev, iter);
+	return (iocb->ki_pos | iov_iter_count(iter)) &
+			(bdev_logical_block_size(bdev) - 1);
 }
=20
 #define DIO_INLINE_BIO_VECS 4
--=20
2.47.3

