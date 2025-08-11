Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CE02D47F6;
	Mon, 11 Aug 2025 19:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.143.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754939548; cv=none; b=ZqOgj40fEOP5B5vw6EdL7pMtbp/jg2EhJ7TQCKArz0tpA0MzJpAAcPKG7lOcOfhBQuxNUKRsTLg9kztSP6/70Hfy7sYMp3YiaEHcIM3yO8x+CYgzUI8zDStIe7c+udEWavkRzi+I0CHPLSx5i5Skz0EjDPTqTaIj6lDzW6Xz4kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754939548; c=relaxed/simple;
	bh=HskehVgjdSLwwTYYXOvinbmzxR4Mrp3ONxhO6Ip+YzA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cVoUVnEqynhKf0CpgMJajK+x748DB+BA4IinWMwIf/6/rUazyZjCHfW09zKYfMICviC4cCZQguujM0666FQubBrJWUzSy+IOS2mFe6zcbu21zUx79tjp7oMqiLL+Mh7pxWiuYlISuhP/Yjz5mlreVlv2CYmiGZSzZhP2yibfrqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=Kvz//tsq; arc=none smtp.client-ip=148.163.143.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="Kvz//tsq"
Received: from pps.filterd (m0134424.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57BH2W3G002363;
	Mon, 11 Aug 2025 19:12:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pps0720; bh=XBvJI1ynONURvoNh6sropnbGepLrGU14xY20c
	ME2H98=; b=Kvz//tsqn78GqSYVUk2r8INkfHcrR/r3pHaeJojqtfLj6J7X+6H2c
	kHW8sHOw5JkSdz+a/fXyEIryewNevrZTo0KW9a5eiNeDJSg+wAo7T2AEZa2hfbsm
	5JLJwj0qos6ZymEK+NzTU7VoEeKS3MiOR8CBrDYHKJkYTY5o55YwRvMuWoVz8BUv
	049VW7r0P8fqkxyD22tZgFpc2VZ9VyBfCaSqNHO/oMJXTJwdbglyntOd7MeahJuF
	Cx/DV0S1TxOxbOHOsW99Y4tM620sz/oOkUESeimZx0yhH0MGV0e6Op7IYQ1izudA
	XseaJwq24kLbT5SlZoBzs7N62PvOjtllA==
Received: from p1lg14879.it.hpe.com ([16.230.97.200])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 48fkw018qp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Aug 2025 19:12:03 +0000 (GMT)
Received: from test-build-fcntl.hpe.com (unknown [192.58.206.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14879.it.hpe.com (Postfix) with ESMTPS id 663C213154;
	Mon, 11 Aug 2025 19:12:02 +0000 (UTC)
Received: by test-build-fcntl.hpe.com (Postfix, from userid 1000)
	id 25CED8800130; Mon, 11 Aug 2025 19:03:06 +0000 (UTC)
From: Rajeev Mishra <rajeevm@hpe.com>
To: axboe@kernel.dk, yukuai1@huaweicloud.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rajeev Mishra <rajeevm@hpe.com>
Subject: [PATCH v2] loop: use vfs_getattr_nosec() for accurate file size
Date: Mon, 11 Aug 2025 19:03:03 +0000
Message-ID: <20250811190303.222802-1-rajeevm@hpe.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=YZu95xRf c=1 sm=1 tr=0 ts=689a4083 cx=c_pps
 a=5jkVtQsCUlC8zk5UhkBgHg==:117 a=5jkVtQsCUlC8zk5UhkBgHg==:17
 a=2OwXVqhp2XgA:10 a=MvuuwTCpAAAA:8 a=5jyyRg2iGYzsEeqDovkA:9
X-Proofpoint-GUID: yL4NFB7u7mdqlEjyiGlFvFqSKptdNxI5
X-Proofpoint-ORIG-GUID: yL4NFB7u7mdqlEjyiGlFvFqSKptdNxI5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDEyNyBTYWx0ZWRfX+qdv0drVJRK9
 xMDnNmZHSKAsMo9lnQ1mPfZFhILqCX1Gr9BOpzmvO3u+kLF79SJ6zSTdA15xAbBt60W/EBR+2du
 kG5u3hbeLK47yJv/0R2uV0JG4+m1LluJRPhdXRInejz9hJ84pwmz2qOTjqt3p7MJ4npQVBoJN/o
 nfYUZqRYrZQw5uUROoGRsMKfzeIvqF7hcSmsn3SVMEc7kG666P0lRe0NC6uw7O1L9v+wEPwfwIX
 HiQSHzel9fRdZ3ykxj9Q3ChPJ14N9bgWCeWHBA/JuAcb+M9+csPvHKIMe1hJaRkVTJPj1dN11Ub
 l033yW9YgwEQSEg/cEqr0a37+BZgZh8JHzuQT8KZE1pwV1nAp/fTKWMVOuSk6WVLM5TPXjsKOXf
 Ms1RhtYrFPlSTl5q+aCwH3+jY8rmkkj/OX2oz4wxXEm53K/abLK9KVyztNt+OQuhKAcakDX7
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-11_03,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 spamscore=0 mlxlogscore=999 adultscore=0
 impostorscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0
 mlxscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2507300000
 definitions=main-2508110127

The get_size() function now uses vfs_getattr_nosec() instead of
i_size_read() to obtain file size information. This provides more
accurate results for network filesystems where cached metadata
may be stale, ensuring the loop device reflects the current file
size rather than potentially outdated cached values.

Signed-off-by: Rajeev Mishra <rajeevm@hpe.com>
---
 drivers/block/loop.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 1b6ee91f8eb9..c418c47db76e 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -137,12 +137,32 @@ static void loop_global_unlock(struct loop_device *lo, bool global)
 static int max_part;
 static int part_shift;
 
+/**
+ * get_size - calculate the effective size of a loop device
+ * @offset: offset into the backing file
+ * @sizelimit: user-specified size limit
+ * @file: the backing file
+ *
+ * Calculate the effective size of the loop device
+ *
+ * Returns: size in 512-byte sectors, or 0 if invalid
+ */
 static loff_t get_size(loff_t offset, loff_t sizelimit, struct file *file)
 {
+	struct kstat stat;
 	loff_t loopsize;
+	int ret;
+
+	/*
+	 * Get the accurate file size. This will prevent caching
+	 * issue that occurs at filesystem layer.
+	 */
+	ret = vfs_getattr_nosec(&file->f_path, &stat, STATX_SIZE, 0);
+	if (ret)
+		return 0;
+
+	loopsize = stat.size;
 
-	/* Compute loopsize in bytes */
-	loopsize = i_size_read(file->f_mapping->host);
 	if (offset > 0)
 		loopsize -= offset;
 	/* offset is beyond i_size, weird but possible */
-- 
2.43.7

