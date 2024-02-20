Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01A214A4E9
	for <linux-block@vger.kernel.org>; Tue, 20 Feb 2024 20:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708461701; cv=none; b=A2sTQ/8XG59CaLhhy6cOAutli16LYirjIEYeC59bNgJ7wdGNelzSL/dr7HFXMShOMVPUZZK963U6+HZ1/GvZ9Fn746Y3Yp33CB/FmVD6zDBe3giJad7iDo469vpNfW804kUg7GaTj/G10i071zHx+a5x/959NunIr6GV4189370=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708461701; c=relaxed/simple;
	bh=n8if/Z28Kw24QLPEyQLvGg5IQkJlx7zrjxgZQMn7UvY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YbIcyJCS6U5ANYSdJLCIpsDAkoCgKbi9/+4Tc38x2CvstuUP4oQbRHoxMrW/BWkodAZS5fJfOGGhujRbQAqDVykyapUnTl02trlg7V5BteaQCY1aAkDcCweVy3146EHHgENOdPwE+y9cmlvHmObgRKuaskg0fHmAuwAS2IQ4ZnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=EN2mfEm2; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="EN2mfEm2"
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41KJ7xod007489
	for <linux-block@vger.kernel.org>; Tue, 20 Feb 2024 12:41:39 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=s2048-2021-q4;
 bh=PEr63iJcm1E4viNIExgUQZdjWiuYFa/a5UCPZGhZjjk=;
 b=EN2mfEm2wldF92ACTSs7O/FsUFnkoDA/gB5yM2cJq9PNuHIxnJRDxPY/UO4B5GY+WjnZ
 OengiN772Khx/5ph+eRhhl2bLpaDKYsrV/OgGMUisRCHB5lxIw9dk1wpGoE8BN/zsOqs
 lxgXrQ2nIQqNANMmnSDzR1FjeopCAp//zpJFr+VfScBhdinRkbxvELfH68M7EGctRfLA
 GEPEt9ubupivCsbyApm6wZdFKDOxDPz+VRtilIA2uDJjhwQy1v+w5G97PxLkdfyWSLnR
 ho+RUWD4GWMKKLlSPlH4LlGOOlnrPGp/AKagGcqM3BkHRfxxqnrtcrrSxzrTHskfXHR8 Og== 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3wcy6221cp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Tue, 20 Feb 2024 12:41:38 -0800
Received: from twshared0949.02.ash9.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a8:82::b) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 20 Feb 2024 12:41:37 -0800
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id A4AA1255C1B1A; Tue, 20 Feb 2024 12:41:29 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>
CC: <axboe@kernel.org>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH] blk-lib: let user kill a zereout process
Date: Tue, 20 Feb 2024 12:41:27 -0800
Message-ID: <20240220204127.1937085-1-kbusch@meta.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: lYcE150EZooCqJ60ND7-3XFYG0GYrhTG
X-Proofpoint-ORIG-GUID: lYcE150EZooCqJ60ND7-3XFYG0GYrhTG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_06,2024-02-20_01,2023-05-22_02

From: Keith Busch <kbusch@kernel.org>

If a user runs something like `blkdiscard -z /dev/sda`, and the device
does not have an efficient write zero offload, the kernel will dispatch
long chains of bio's using the ZERO_PAGE for the entire capacity of the
device. If the capacity is very large, this process could take a long
time in an uninterruptable state, which the user may want to abort.
Check between batches for the user's request to kill the process so they
don't need to wait potentially many hours.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/blk-lib.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/blk-lib.c b/block/blk-lib.c
index e59c3069e8351..d5c334aa98e0d 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -190,6 +190,8 @@ static int __blkdev_issue_zero_pages(struct block_dev=
ice *bdev,
 				break;
 		}
 		cond_resched();
+		if (fatal_signal_pending(current))
+			break;
 	}
=20
 	*biop =3D bio;
--=20
2.34.1

