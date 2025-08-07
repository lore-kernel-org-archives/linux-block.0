Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A6C5475E;
	Thu,  7 Aug 2025 23:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.147.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754609681; cv=none; b=eZx8gWLMkNjFAVdJ7dTOY9+EpbjQMa5R1S+DZd5gAZSOwV1q0eolvVAXQe+JaKkGKCGzWqru8pnDk95CN7R1IZMzoDDYWPYqc0AU2obOsQ0Sq0tlaRchicvGrldCylyE/HB+4Lf7pOhFqJn4vzhzEY0z8JHy2jNNnf7tv1xaGC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754609681; c=relaxed/simple;
	bh=+GjCo8mqWli11PkYxbzY8bH0AmMOZ81OFu18PSPNlYc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HAXNsJmlC/A9Hs2LWSJzJ6illrTjTmO3nDuJ15Ybay2g2I4SWtBoDk6oUQT0bipCieWHA9ZPcVLrHkRLhJNzC57X4GecWOFXoM8u1s/FAwcXAbk2SyrZ0kSNiStZrXDEne/KXrxdYdij1LElkfuItmnisn+Kiv34DPSleqQohdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=pRV6ZVsK; arc=none smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="pRV6ZVsK"
Received: from pps.filterd (m0150241.ppops.net [127.0.0.1])
	by mx0a-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 577IL34k029305;
	Thu, 7 Aug 2025 23:34:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pps0720; bh=poHsgaP+YF707V5y9z/iclpM0uKCkrx3EfLqu
	iZMAiw=; b=pRV6ZVsKNgvQFHEXycQsfOmjI12EuZV5hNI+S1VNARpbh/d9bccA+
	W0t7ka9p3MFZe6NXc8JnG8q/WOXEM2iA+P4/gF+6+rkl/BujcTyA+ZXfYNWSk8FW
	0pRBHFBku9pjp3tU+hpIYZghSvr+ximr8UZVOzt8l5m1e9KxKbilVS6LIP0yhniD
	c0AfHOD8YlfMGwaCyajM7pcD7VJV8I1JCos3cIzUfJebgQ4z7VZ9IpYnkkxuaTHA
	AgQkKsBpugaSCWhPx9TM9Il/QT4VNoQ+DW4KG+XNJjuxa5l/oWPvQzWCPeWhvW11
	j8xoGt1lOO53GjuiI7X8cyWFQVfIXFk7A==
Received: from p1lg14879.it.hpe.com ([16.230.97.200])
	by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 48cn351mm4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Aug 2025 23:34:29 +0000 (GMT)
Received: from test-build-fcntl.hpe.com (unknown [192.58.206.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14879.it.hpe.com (Postfix) with ESMTPS id ECCAA1317F;
	Thu,  7 Aug 2025 23:34:03 +0000 (UTC)
Received: by test-build-fcntl.hpe.com (Postfix, from userid 1000)
	id 34D2D8800132; Thu,  7 Aug 2025 23:25:25 +0000 (UTC)
From: Rajeev Mishra <rajeevm@hpe.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rajeev Mishra <rajeevm@hpe.com>
Subject: [PATCH 1/1] loop: sync filesystem cache before getting file size in get_size()
Date: Thu,  7 Aug 2025 23:25:22 +0000
Message-ID: <20250807232522.192898-1-rajeevm@hpe.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA3MDE5NSBTYWx0ZWRfX44fP3CaigCC5
 oGjK3tXUNvrPPorzzydo/vbllI7kWoCMRt0+tvNM6MCw5vaBIv0+y4HvSUp/0fdniVw8lnTZZCo
 OMynil7GrXU5UWl/CbTs+23XgGt9ZfunSeKlWywLzXHlE/eoPRxgbyhKxlA3YIOl2XcrYA+ym2p
 nP9gIl8G1lNqrZmfxRqsPBForOsIgLPfn1a6Q/a17PfT/dxUN30Gv7BSxTzd8B8MowHGYNjnUqo
 WmLaXwOmNRYbZYHbYtXyX+dSfjs4VVisVe3TRfS9oz5+v0P0Jss8UrRjz9YyqWDJmRJfWAdqGMx
 84/sG1sjk5EgKOF2N9ISO4QxO1HoozxDq/x+a/MoHkGXkCzE3m0Vwlv9rTnSJMNu87TtNm4c3x6
 VipM8El/mQzVNrva4Paka2sS76nAZNJz2Fys5Jt91tJVtelyMOBJ0h6lKoRuTC7JjeVpFnHv
X-Proofpoint-GUID: YSvOs_ititAaa6pGdyqAdVq21CBwQJaS
X-Authority-Analysis: v=2.4 cv=UNndHDfy c=1 sm=1 tr=0 ts=68953805 cx=c_pps
 a=5jkVtQsCUlC8zk5UhkBgHg==:117 a=5jkVtQsCUlC8zk5UhkBgHg==:17
 a=2OwXVqhp2XgA:10 a=MvuuwTCpAAAA:8 a=oPlePqoASfxsVqDn9Q0A:9
X-Proofpoint-ORIG-GUID: YSvOs_ititAaa6pGdyqAdVq21CBwQJaS
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-07_06,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 priorityscore=1501 lowpriorityscore=0 mlxscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0 phishscore=0
 impostorscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2507300000
 definitions=main-2508070195

The get_size() function now uses vfs_getattr_nosec() with AT_STATX_SYNC_AS_STAT
to ensure filesystem cache is synchronized before retrieving file size. This
provides more accurate size information, especially when:

- The backing file size has been changed by another process
- The file is on a network filesystem (NFS, CIFS, etc.)
- The file is being modified concurrently
- The most accurate size is needed for loop device setup

The implementation gracefully falls back to i_size_read() if vfs_getattr_nosec()
fails, maintaining backward compatibility.

Signed-off-by: Rajeev Mishra <rajeevm@hpe.com>
---
 drivers/block/loop.c | 31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 1b6ee91f8eb9..15d5edbc69ce 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -137,12 +137,39 @@ static void loop_global_unlock(struct loop_device *lo, bool global)
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
+	 * Get file attributes for validation. We use vfs_getattr() to ensure
+	 * we have up-to-date file size information.
+	 */
+	ret = vfs_getattr_nosec(&file->f_path, &stat, STATX_SIZE, 
+			        AT_STATX_SYNC_AS_STAT);
+	if (ret) {
+		/*
+		 * If we can't get attributes, fall back to i_size_read()
+		 * which should work for most cases.
+		 */
+		loopsize = i_size_read(file->f_mapping->host);
+	} else {
+		/* Use the size from getattr for consistency */
+		loopsize = stat.size;
+	}
 
-	/* Compute loopsize in bytes */
-	loopsize = i_size_read(file->f_mapping->host);
 	if (offset > 0)
 		loopsize -= offset;
 	/* offset is beyond i_size, weird but possible */
-- 
2.43.5

