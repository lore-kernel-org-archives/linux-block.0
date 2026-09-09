Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E734570F9
	for <linux-block@vger.kernel.org>; Wed,  9 Sep 2026 22:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788991240; cv=none; b=VoFMvbfS3wtlpYRDr+50nzODvh0mMEf3KB0pRCKimomovGaoQZYgRp79N9RsRqiaYUTbzCNpBntGKRT65BF99GWlHoR+ai1zMCGvI03I7dCfpy1c4UcKL/986+S31RJwL/Z5lOCAVBDDmDcK6n7lFTtezJ3icLmhHxaBVl1vV3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788991240; c=relaxed/simple;
	bh=1/t2xY5/Mc66wbO/sq4F65kT1qvvPynaI0dLYwruBvM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g/rxNxOUVelhF7VNx6Dm3tsRP21CKglrxg34nKKK/aWU/x5DC4tHnGMkpTOfzXiNC0pgTsj/58leezZctVQV/Slbs3+ho+P48IxGrcU+RJYK2qHMTMbhHRhIYuUpO17YfDKshVwpb1GJ+J7XIOQekTXsIN95TEv9l+GXA67K1Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=ZxnBn1jP; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=0KBXNay3; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="ZxnBn1jP";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="0KBXNay3"
Received: from pps.filterd (m0167071.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 689KYb2c2240428
	for <linux-block@vger.kernel.org>; Wed, 9 Sep 2026 18:00:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=VT8b
	3XXMl8Tl4w2lotxN8pWIW4xBLLg9GmZ5x1w6/Oc=; b=ZxnBn1jPWTaFthTbfbvq
	MyDMY0nNONqwkr0G6NO2lcT+I3oen55ll68re5gVnf1LfjQo3pUoD+OKMV11iN7u
	YwYbYxWVcqyyp3T9yn6nSZfZjFOTZckhZmNBrhSUrGYRYPd/S4eRNfcG3S7L6V1D
	KKPn2e2kxi357H/mjwuG8hGENDqXGpHvkiuZpsxOQ+nd2fGIdzNj3ghURXnmNxNs
	La/07RCvk/lJc3afKv3Cj5jUB3LMZCHiz3KGicxbTrL2JBDPqn0WtqQIwGTl/STY
	MixI5lMHpfdIM6gJnNSgka11klJ9VpIn67wkUVgT0nZoajR0NDFNLgmPro4mzhgw
	6g==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4gkcxyj1sk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Wed, 09 Sep 2026 18:00:32 -0400 (EDT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-9399b66e0e7so806773485a.1
        for <linux-block@vger.kernel.org>; Wed, 09 Sep 2026 15:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1788991232; x=1789596032; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VT8b3XXMl8Tl4w2lotxN8pWIW4xBLLg9GmZ5x1w6/Oc=;
        b=0KBXNay3VG/PIQpm74fW2ukkbOxAv2PgQlCZeU4Xd+qw/NhasPPaiqE4YDJGOG5H6x
         1asvHsFEZzZO4aGBdHN7zIFajURGeViKYyZNDk9ZvZGs/GyYgTdT8DtNkxUczwEbJ+eL
         8yPe6NiVD0R8YvlV+81srIk2HeSQUbqePNTZdqLPrBw+6o0zf40sCdueZ8kX3mwWJygz
         PZUcufnqLBlp5jnDIzoXgW3EILM/gkNoetqPhN/5EoSED6TWlxH45EvERL5TuP+rvB5o
         jWdq3B5aR5ZzP2PltvINwvLUvxhLYnLbJCLSCB+UMRNpFysaybGlpWyqlu0rRVwG2n7C
         qHnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788991232; x=1789596032;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VT8b3XXMl8Tl4w2lotxN8pWIW4xBLLg9GmZ5x1w6/Oc=;
        b=HLKhuIuJi9apuLXNjGHND45ZDzM+OXw6pmjerr39YEiSSAIDBmP6QX46z0F9YSQqpE
         4BqCpcohNEwoWR/TUNyigAg06tPJJYSCyd5E9zFcAbBSqjH+CQliSH5irF5Bz0CRT37X
         UXo29MTfUg3L2btWcZ+RxP5t2/MCenTx0KJP1AAezm/TCS7Cn/k3/4Yj7zd3XelJJ7JD
         9HKkS5jU/9Sf9uICF4q6fIoximZsTpP7SFmfjzuMTHZEMZgU1MOHti2qXSXm8YF8yZjL
         s24hiOfiidexmG+RjHO/5dghpzWisBEzWp0www585mnLCd4cEu4XaF/A6iZnZ5pMF5JF
         uqag==
X-Gm-Message-State: AFuF++nyKMAAcxrL77mkCP15/KSR+WTxUgrYdtzMTWk+3DvkzEQQ3GMS
	VUDjjTtXu9PIExnJjPIkx1q40XgzO98k1uoqzJKwNaNWROTTddV9/eAMWTOUPLDmq0G1scLgxmN
	JOUpQAaKQs9Js7bvvCYmTbxUlscZVTr7iIpAsmsTo4Vmt7inm3gbN0UIafIkF
X-Gm-Gg: AYBFou1PNqURFF3ig4pNWhRpH/Uz9Yj2tDQExHzpCLnL2slzLGGOjwQ8Xf9aRlexJgx
	jKWi1MluS7uIoirLXRwqIVFdaZkj+ZzuhKyxeS8vlCRd+s5RvA1HEQFQ1g0xgevzM11Q/Uss4pV
	LSoBk7e3GgIiZNRF/I3p0WUHKaPpplVARJ4PL0FuohuVxZjIW0esE9jA3HWCe6yYfL9Que6cnif
	NUriW8IZ4uD1V5D8+zt8aOCGewZA3TXgYVBSaaxJzD9F9jxMTdp9QLsdV6G4oUG1RgaLZImwcT9
	fggAHvcQM+5/QfBo3hja2EmM9tZO1gwvQRZO6BklAKSOnhQlNpaCqd7Zhn/MXWQQbQRKXcCvG49
	y/swqUmMtyeEAB7FsLPBlUb8WksfyuZ/EBU4qTW7PP0LmM3Lb
X-Received: by 2002:a05:620a:f05:b0:936:315b:a5f4 with SMTP id af79cd13be357-939803118bcmr4267367185a.5.1788991227346;
        Wed, 09 Sep 2026 15:00:27 -0700 (PDT)
X-Received: by 2002:a05:620a:f05:b0:936:315b:a5f4 with SMTP id af79cd13be357-939803118bcmr4267299785a.5.1788991224191;
        Wed, 09 Sep 2026 15:00:24 -0700 (PDT)
Received: from [127.0.1.1] (nat-128-59-176-193.net.columbia.edu. [128.59.176.193])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9397fbe31c6sm1535326985a.46.2026.09.09.15.00.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 15:00:17 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Wed, 09 Sep 2026 17:59:41 -0400
Subject: [PATCH v3 3/7] block: take i_rwsem for the splice read path
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-blkdev-fixes-v3-3-1a5222c6e8ad@columbia.edu>
References: <20260909-blkdev-fixes-v3-0-1a5222c6e8ad@columbia.edu>
In-Reply-To: <20260909-blkdev-fixes-v3-0-1a5222c6e8ad@columbia.edu>
To: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Hannes Reinecke <hare@kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        John Garry <john.g.garry@oracle.com>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Keith Busch <kbusch@kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788991197; l=2823;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=1/t2xY5/Mc66wbO/sq4F65kT1qvvPynaI0dLYwruBvM=;
 b=WP8Ldf8P1H8oQEK2mjLFXYLu33CPKzboymXkYr30/fCKh1X1Y0WllXFMtkKQ8/aKbfrpmh4lz
 JwrehgekqpiAg27ZCAj3VFWrYtv6bdW+y0tTsyoMgyB47Fl8/wCHNQY
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Authority-Analysis: v=2.4 cv=brnZl0ai c=1 sm=1 tr=0 ts=6aa1d700 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=fJxgZNdXt3opHMdyAp+FXA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=79PYxaXUQd1wl-QFWJnA:22
 a=VwQbUJbxAAAA:8 a=kXXCQoMOyz17bj_MZH4A:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDI0NyBTYWx0ZWRfX6YIqq7D4Y2zN
 UCzo2MZaoKCJGh4M1UTCyNswcfOrrkHYmqRLG+O80VjV0L8UbhQlE4KpBOjE8CrLvMW/GZIELAx
 zSwsMFfiBj6mid7G4jegu8DQ3WRC0NxmAwWHTV+y1Srdpd+Fy6Pb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDI0NyBTYWx0ZWRfX/kiQ0yv0+SM6
 A35PIc9ETpIn13R/S3gHvOqlWkcq/qy2K/hYFMX0Tv4gQoDyOUG0qmS+041QjJWAS6Yo3Wz7+uy
 b7T3RF5MIdLfZptMLoETht5Nw2wmczj+fahfmT58NRimWIhfzI5BrUu8+gJu8snwJ4N2ct5TM/P
 ZgWp6I/X63rX2dhyySCJ7qrT1jjXczjk0Sw6VBiFAdjTs2lve6z7j0i6edx16RSqmclcNtGOc3A
 KNtd9D/9WI+JKdMcnOTVKrwfveA00b8AvKPkbiZB7VMvPK4bRsgOL/NQcEt8LQVV4rZLHlipKIm
 6vvgwBwGOOi91oJzLDZFxktzBUiMRwRxn8drBCeObWp2JP50g6RWiINIprZdcL9qDuMCQJSV6a9
 H5kLt70UkqEMQkz234uonmW1mtsyYVJSAb+YaTFGHvdavMxyXzSOTE6cZndrhZG8GyRRU4O4SKK
 BsApcst632SQf0eA/Iw==
X-Proofpoint-GUID: 0utgUmOPd2bVee89O78DKKEWkJ5uXZL2
X-Proofpoint-ORIG-GUID: 0utgUmOPd2bVee89O78DKKEWkJ5uXZL2
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11900
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 suspectscore=0 impostorscore=10
 malwarescore=0 phishscore=0 lowpriorityscore=10 bulkscore=10
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609090247

def_blk_fops wires ->splice_read directly to filemap_splice_read(),
which allocates folios based on mapping_min_folio_order() without any
lock against set_blocksize(). A splice from a block device can race
set_blocksize() raising the minimum folio order and insert a folio that
is too small for the mapping. blkdev_read_iter() wraps filemap_read()
in inode_lock_shared() for this reason, but the splice path was missed.

Splicing from a block device while toggling the block size between 512
bytes and 64K with BLKBSZSET hits this within seconds on a
CONFIG_DEBUG_VM kernel:

  page dumped because: VM_BUG_ON_FOLIO(folio_order(folio) < mapping_min_folio_order(mapping))
  kernel BUG at mm/filemap.c:858!
  Oops: invalid opcode: 0000 [#1] SMP NOPTI
  RIP: 0010:__filemap_add_folio+0x51c/0x570
  Call Trace:
   filemap_add_folio+0x64/0x140
   page_cache_ra_order+0x1dd/0x3d0
   filemap_get_pages+0x153/0x760
   filemap_splice_read+0x13f/0x300
   splice_file_to_pipe+0xc0/0xd0
   do_splice+0x6a8/0x890
   __do_splice+0xb0/0x210
   __x64_sys_splice+0x80/0x100
   do_syscall_64+0x10e/0x520
   entry_SYSCALL_64_after_hwframe+0x77/0x7f

Take inode_lock_shared() around filemap_splice_read(), like the read
path does.

Fixes: 3c20917120ce ("block/bdev: enable large folio support for large logical block sizes")
Assisted-by: Claude:claude-fable-5
Reviewed-by: Hannes Reinecke <hare@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 block/fops.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/block/fops.c b/block/fops.c
index d5f569333f46..a51814821100 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -855,6 +855,22 @@ static ssize_t blkdev_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	return ret;
 }
 
+/*
+ * Take i_rwsem to avoid racing with set_blocksize changing i_blkbits/folio
+ * order and punching out the pagecache.
+ */
+static ssize_t blkdev_splice_read(struct file *in, loff_t *ppos,
+		struct pipe_inode_info *pipe, size_t len, unsigned int flags)
+{
+	struct inode *bd_inode = bdev_file_inode(in);
+	ssize_t ret;
+
+	inode_lock_shared(bd_inode);
+	ret = filemap_splice_read(in, ppos, pipe, len, flags);
+	inode_unlock_shared(bd_inode);
+	return ret;
+}
+
 #define	BLKDEV_FALLOC_FL_SUPPORTED					\
 		(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE |		\
 		 FALLOC_FL_ZERO_RANGE | FALLOC_FL_WRITE_ZEROES)
@@ -956,7 +972,7 @@ const struct file_operations def_blk_fops = {
 #ifdef CONFIG_COMPAT
 	.compat_ioctl	= compat_blkdev_ioctl,
 #endif
-	.splice_read	= filemap_splice_read,
+	.splice_read	= blkdev_splice_read,
 	.splice_write	= iter_file_splice_write,
 	.fallocate	= blkdev_fallocate,
 	.uring_cmd	= blkdev_uring_cmd,

-- 
2.39.5

