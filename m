Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDD33A1685
	for <linux-block@vger.kernel.org>; Wed,  8 Apr 2026 23:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775689752; cv=none; b=G3VfJ9hrZT/zXX+4Kujs1TBbO8j4FuTnYaODQMWpU0L+N6nCIdUwo7zq8EivyMUIbHQ44WpQZ8nP+ar7iAfl6qD8Jbn0jSzYjbYlSgOIgAO4EhKDWjd0CiLie8KRK+RidDyuHtEIQ+q3NG+kVzezWpkSulWIDohaWbx6cUYRIBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775689752; c=relaxed/simple;
	bh=uxVNlK6BMzyn/Swuex2mcjfTN1L938gYzjb1HF2lqyU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aEyAqXLFXyqJ6mvzrjBF0YzG967uwCXunI21+Z254psrQa7S8C5+GUiB0grh2VKQ+2Rofh8i7HbIGJhcHpd/GwOb4uOShIW/g96E28IlQ4rz4/2bm/4jS/oTGrMLObHd5j9yTE+cD95V4p0Ixxf2P78vldtdPXxyW5+tLoNjGZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=G95NswD+; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="G95NswD+"
Received: from pps.filterd (m0499198.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 638MuQ9g3763929
	for <linux-block@vger.kernel.org>; Wed, 8 Apr 2026 19:09:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=8dsl
	Z9dvpn2QBwNrcJEpfHjycCNypPP7xdaXKfMePho=; b=G95NswD+1AgrwF1KSmuo
	7ejnwnOjIs4ukUSShU1rYQhI+zrg5Ns4e67slikatL5s+3HTdp0Ob+Y3K+es5jKl
	PA+SO8dD5ezEfR+GrDhs9SMAoOHcQS/sWaEWVi+Bc0WYLYSL5qeiOyKsmNwe+1Dy
	x8DB5xHpHsRjQfFhUzF2YM/jsDzZXKmKA6c/euUY1KUgWXso3wAhwiAiDFB9udzF
	NQnlG3OYbqFIe11dVdrc76+R8CC0VBm8h056JDC0GpLqoSxncN/Ipiyl/dFo9skJ
	UXesjWHj5qmY1lJ2eH9Sl53JNd6z/VnObBZyoXey6h30J2sRqT42No8Z4oBUZKtR
	og==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4dda3mgtxk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Wed, 08 Apr 2026 19:09:09 -0400 (EDT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8d3a8df9a52so60273285a.1
        for <linux-block@vger.kernel.org>; Wed, 08 Apr 2026 16:09:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775689749; x=1776294549;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8dslZ9dvpn2QBwNrcJEpfHjycCNypPP7xdaXKfMePho=;
        b=kK28WL4IQkGGB1IyNY+yuhvTSO+ftbtOUmIl8+uY7zuODFk+YiUrMMCUqfkxJyQaa4
         UfTcHTO5OHm68DxMbgANOUPi55+WQzBpyUKmJ7BuyiH5nhWJYhd+Gp9Ppo2t8doB6S8x
         PhBqiy8ffmRNtECwg8/7gh/J3QuC/Zpegy37oru+83aCz3p8sa18hT3VOv0Hsg97HnIu
         FRaHPvE2YvzwIUUflc4oFsBBfJI4a23bigLEzdnHRDyOevN/9xQcl00BOFCXJvpnTHfG
         neAm+nbZNYyxb6CgXSs2KCCPs7f7IBnFo/mkZ+LiTQ8m7XOp2DNc3voIwHEF9cOZoBMQ
         Mo5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUCsFwpESPJ6xzmcMfN5zuBhe5NjfwMisqMeaXvkkFvw/LojNZ/8r/G1mPAsdt+hOzZzSTaFZE96sQSLQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1rKZ6SlbKRVTag3FC854TXz2XZzyjcApLsnyMEBiHPBCcX930
	enRHXpiBQnAMXmZAyugKKQ4KEpnKiRTn0yrXOfgh/1a+4jTkUae+3tf1Fnix/+Pc4n9Ygw8ACeE
	CRWj0qEmZ7DcbEefmivRN2bYb8xLhwEqiJ+nd7NfGCMkpq17BIHro4TJPL2PaSa3FnH/E
X-Gm-Gg: AeBDieuOEh7aFTpVvfdYvmVuJXy3yT3LCZArCgNCAeNBGuWqiL8kH1kZ24XsmtLy1cJ
	bmFkeqD4yNfoD10A1eB8CaTb5hnWrsmRk75zz+jCHT78MLWhSSTxRaEZ9Eped+NttdfRTh/O8zS
	rHhQQ5q7d7H5a9Xzttb9FVM1LvZ9VjWmpltVMJ/fjBEdf2tDe+eg8Vjb1ocxmxdfKIOfgdMtkI/
	Dkg5al/pdhc+IsHO4CszEj1LaE7Alx2snthunr088p/UZEHGntmOVR1hIA+W0Z+345JYyvo3aPq
	G5B08KcPWTnUzAfE6h2gz5nOauE+KCDC6Ug8wfPM59A27Hz32gMhKjw1txhkL+5dPlL5BVR8y+c
	dZh+CmtgQdjC6UVRU81vxU9MlifqvfdY1
X-Received: by 2002:a05:620a:440e:b0:8cd:8f04:50ec with SMTP id af79cd13be357-8dc3b03cfe9mr238711285a.2.1775689748768;
        Wed, 08 Apr 2026 16:09:08 -0700 (PDT)
X-Received: by 2002:a05:620a:440e:b0:8cd:8f04:50ec with SMTP id af79cd13be357-8dc3b03cfe9mr238705885a.2.1775689748199;
        Wed, 08 Apr 2026 16:09:08 -0700 (PDT)
Received: from [127.0.1.1] ([216.158.158.246])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8dc1514d382sm125665485a.4.2026.04.08.16.09.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 16:09:07 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Wed, 08 Apr 2026 19:08:50 -0400
Subject: [PATCH RFC v5 2/3] iomap: use BIO_COMPLETE_IN_TASK for dropbehind
 writeback
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260408-blk-dontcache-v5-2-0f080c20a96f@columbia.edu>
References: <20260408-blk-dontcache-v5-0-0f080c20a96f@columbia.edu>
In-Reply-To: <20260408-blk-dontcache-v5-0-0f080c20a96f@columbia.edu>
To: Jens Axboe <axboe@kernel.dk>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Carlos Maiolino <cem@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>
Cc: Christoph Hellwig <hch@infradead.org>, Dave Chinner <dgc@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.14.3-dev-d7477
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775689745; l=3055;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=uxVNlK6BMzyn/Swuex2mcjfTN1L938gYzjb1HF2lqyU=;
 b=wiuqQGIUXlaDQRyL/2cvKQLeklEvgNwRkNWuSOVmD4QDiAmxSLl8wwsDtLCKaObM2FWAiuPdv
 KjGXMpBW4o4ASxzBvkdeJ8ApER14bjxSNNSrtc8cfpyy9YHBS4vsTeF
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Authority-Analysis: v=2.4 cv=OdWoyBTY c=1 sm=1 tr=0 ts=69d6e015 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=mD05b5UW6KhLIDvowZ5dSQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=x7bEGLp0ZPQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=BpGzv1V74M3SfeTrGa8v:22
 a=tmanUA2hrRIj4wcn57QA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: rouGzHdx8YA6FjbyELnmwIDxkru-6v0X
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDIxNCBTYWx0ZWRfXxjVvg3yYauLM
 n62kowx1zazsJFymS2AWPobddWJfA1WgKe9FXxvvpxMuKuJbt2qZc/4MwYq0Dih9tpTJ1M6dbvk
 7XeePSzQDT718wTE8BGDP/2mwBbAD8Qeccdb4wbgmJcdG4febDCZjDRtXjqGD8iyQWcCW5xnYzl
 4QhhzNYTvYaLWlScWPvhqAgIkfQQVwn9pLb/hILCQ76uEMORUjPsEMpw5Zz3+2A6wXrb5j1Ub2n
 rg2Ub0y+xwT09TJtbgAMi/jai/xvwZIn0VNhjr3f8t3ut/qo6g/OylKqS7FBwAcF1egDiYNWOzM
 NAtQvTMKn7oE8Z4tF+LXrAMmCNwDlj2r/RKmhL6HHrf6OZg/7JgDxcMrwzg/VneldJCMzFSs+cL
 10vNPW0vX6qyDQmbUxXu0hxEg/0Zud6d6qA6/BdWlXsNGSSYPD6RzvS11uPmgqfnh6Z6Lg+ZjjH
 XIA0WxioTsHZ8FAslFA==
X-Proofpoint-GUID: rouGzHdx8YA6FjbyELnmwIDxkru-6v0X
X-Proofpoint-Virus-Version: vendor=nai engine=6800 definitions=11753
 signatures=596818
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 priorityscore=1501 malwarescore=0 bulkscore=10
 impostorscore=10 lowpriorityscore=10 adultscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604080214

Set BIO_COMPLETE_IN_TASK on iomap writeback bios when a dropbehind folio
is added. This ensures that bi_end_io runs in task context, where
folio_end_dropbehind() can safely invalidate folios.

With the bio layer now handling task-context deferral generically,
IOMAP_IOEND_DONTCACHE is no longer needed, as XFS no longer needs to
route DONTCACHE ioends through its completion workqueue. Remove the flag
and its NOMERGE entry.

Without the NOMERGE, regular I/Os that get merged with a dropbehind
folio will also have their completion deferred to task context.

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 fs/iomap/ioend.c      | 5 +++--
 fs/xfs/xfs_aops.c     | 4 ----
 include/linux/iomap.h | 6 +-----
 3 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/fs/iomap/ioend.c b/fs/iomap/ioend.c
index e4d57cb969f1..fe2a4c3dae42 100644
--- a/fs/iomap/ioend.c
+++ b/fs/iomap/ioend.c
@@ -182,8 +182,6 @@ ssize_t iomap_add_to_ioend(struct iomap_writepage_ctx *wpc, struct folio *folio,
 		ioend_flags |= IOMAP_IOEND_UNWRITTEN;
 	if (wpc->iomap.flags & IOMAP_F_SHARED)
 		ioend_flags |= IOMAP_IOEND_SHARED;
-	if (folio_test_dropbehind(folio))
-		ioend_flags |= IOMAP_IOEND_DONTCACHE;
 	if (pos == wpc->iomap.offset && (wpc->iomap.flags & IOMAP_F_BOUNDARY))
 		ioend_flags |= IOMAP_IOEND_BOUNDARY;
 
@@ -200,6 +198,9 @@ ssize_t iomap_add_to_ioend(struct iomap_writepage_ctx *wpc, struct folio *folio,
 	if (!bio_add_folio(&ioend->io_bio, folio, map_len, poff))
 		goto new_ioend;
 
+	if (folio_test_dropbehind(folio))
+		bio_set_flag(&ioend->io_bio, BIO_COMPLETE_IN_TASK);
+
 	/*
 	 * Clamp io_offset and io_size to the incore EOF so that ondisk
 	 * file size updates in the ioend completion are byte-accurate.
diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index 76678814f46f..0d469b91377d 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -510,10 +510,6 @@ xfs_ioend_needs_wq_completion(
 	if (ioend->io_flags & (IOMAP_IOEND_UNWRITTEN | IOMAP_IOEND_SHARED))
 		return true;
 
-	/* Page cache invalidation cannot be done in irq context. */
-	if (ioend->io_flags & IOMAP_IOEND_DONTCACHE)
-		return true;
-
 	return false;
 }
 
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 99b7209dabd7..a5d6401ebd80 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -392,16 +392,12 @@ sector_t iomap_bmap(struct address_space *mapping, sector_t bno,
 #define IOMAP_IOEND_BOUNDARY		(1U << 2)
 /* is direct I/O */
 #define IOMAP_IOEND_DIRECT		(1U << 3)
-/* is DONTCACHE I/O */
-#define IOMAP_IOEND_DONTCACHE		(1U << 4)
-
 /*
  * Flags that if set on either ioend prevent the merge of two ioends.
  * (IOMAP_IOEND_BOUNDARY also prevents merges, but only one-way)
  */
 #define IOMAP_IOEND_NOMERGE_FLAGS \
-	(IOMAP_IOEND_SHARED | IOMAP_IOEND_UNWRITTEN | IOMAP_IOEND_DIRECT | \
-	 IOMAP_IOEND_DONTCACHE)
+	(IOMAP_IOEND_SHARED | IOMAP_IOEND_UNWRITTEN | IOMAP_IOEND_DIRECT)
 
 /*
  * Structure for writeback I/O completions.

-- 
2.39.5

