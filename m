Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24BB2405ED
	for <linux-block@vger.kernel.org>; Fri,  1 Aug 2025 23:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754092075; cv=none; b=VW4o2/PjN8OsQPkl3CTIrk3YQuq+izAXOQBC4nPrqpYxGzR18BcWDYV3ABhoYK7Z4A74Es4oonDt9HhKJAbg6uejFtuLKtcjuXMJOqD+9iBtPiktyijLat44NVY8Zmb6qmvPEAQz1q8sAt7a5Lkx/9m3QuYaSHpdW0JjKpiO1k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754092075; c=relaxed/simple;
	bh=LwfLMBx23lediDy38Qjg9yw1tMW2Thke+PTvuAKHnIw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h0FvyZwq4PQPSyZfA8fSj42pzfIi1bUG48FPlGwce9Rw/7vxtJDZjpr7Q8u3/JEb3uju/QcUbtwVDoh4KKD8qZQOTO+4uXOxk+wAKERI10ePQpTOxtP14eaGU5c+W2w9gTFWUVr7BivXLq8LQA1WZWU4JUy9INXsjY0GtwP/uOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=i3gngBtl; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="i3gngBtl"
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 571Mn2g1002035
	for <linux-block@vger.kernel.org>; Fri, 1 Aug 2025 16:47:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=xevAOEXt3D+HBE/6RPgSfiie3n3mLq2ykCT4rEmyCL0=; b=i3gngBtlYCiq
	YEtmqr/iv/A/VarP+J0KLQ4KiHpba58/NrV5MpjqTSZlJtjtGwJF3c+vz4A4Xe2v
	QMlQ9pFFmNz6Y/WQc8w7wFjgTddVhchUmiWMnLRM/v2dZDV+NNCQQn91xT8tAQQI
	OCMmGOObBQbDsegzPqKaWdQD0Ong46WlVqfQMIm8Qkzky7IHkBkHBgpUhqN2JFgM
	z+FW7iIytTfNHd/qvN+EPJewZHxhW051YA7F/IrJP/N57gCvtnGHMlT91Gty+fef
	tZ0fanjTESwa1hsNsE0Bhy1jEAzFNVK4lfqjr2euHGqc4wDJ8/v9lX4RH1sHPvnH
	7wRw/HX3Zw==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 488rk95hg6-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Fri, 01 Aug 2025 16:47:53 -0700 (PDT)
Received: from twshared42488.16.frc2.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.17; Fri, 1 Aug 2025 23:47:51 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id C30BB3105F4; Fri,  1 Aug 2025 16:47:36 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <snitzer@kernel.org>, <axboe@kernel.dk>, <dw@davidwei.uk>,
        <brauner@kernel.org>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH 5/7] block: remove bdev_iter_is_aligned
Date: Fri, 1 Aug 2025 16:47:34 -0700
Message-ID: <20250801234736.1913170-6-kbusch@meta.com>
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
X-Proofpoint-ORIG-GUID: HDrURuMIiCySNy0ENvVzSvZgQLbvPVKr
X-Authority-Analysis: v=2.4 cv=ZrPtK87G c=1 sm=1 tr=0 ts=688d5229 cx=c_pps a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=x-sBDG6hxYFL5DTe09MA:9
X-Proofpoint-GUID: HDrURuMIiCySNy0ENvVzSvZgQLbvPVKr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAxMDE5MyBTYWx0ZWRfXxoTi1KQObKMA eGPjAMioOIzd+0C9WcxMsY9r8ArLJgwrZwpW1dA7DzDlQCMVoPkLfMYhNL9V0JTfjiXT0OsvME7 5FJZCYkzcCkkcGxIOsX7nnsGzXk1BMHCWvshuITTaPc9QBy9q+mG8pPIhZGWScctOfWhhUuZXhY
 YAA6or3alECK5/KZgiVqCc87DXtQ2+0LfKSq5HNZTEkh4fGt7gFsHlv2LNKGkaxhLqdQ2pJzRRE MOrcsza+YNRH60YqRbI4H/BLr6WSwYuh+jsIMNOsb1kjdZTQhGbqPKVoRxHMilB0g99LoDtGprG VEHEXThS847d/MCbseCyebBniMH2GK8mhkD+dImv8AgBTj+rQ1PGvQn/iqTPX2owz7N33bfatPU
 nB0kBpPnu+tPDn4sl5ANaMO7BjDNqrRpdbQ5kuXHSebYRohvqEIYPMOcQIwsxwx9OcseRacV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-01_08,2025-08-01_01,2025-03-28_01

From: Keith Busch <kbusch@kernel.org>

No more callers.

Signed-off-by: Keith Busch <kbusch@kernel.org>
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

