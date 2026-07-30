Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94883B4E9B
	for <linux-block@vger.kernel.org>; Thu, 30 Jul 2026 06:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785394764; cv=none; b=YnMpQRFNoXCVhF3DII0VoV1gIlMRDPdA3HvJEeFjh/Yq5Fh9XmsVLSP0+moBhDM8pHzefSAqaPxLFIvWO1CKuCePDB5VvHXhy4v21obO+yfTADbh0XX2VuQNz555T2sDpFFCDlsHQsyI/uwGO01Wyv8IQwZgXP2UG1m8eRQFpHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785394764; c=relaxed/simple;
	bh=Tk8jUyrOqQ7WXa1eqV1nq7SPxnPRM7zEp3j/WZJSWC8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h1ahYeivTRwIaksXti5adgA0c0tbQywXLpXcBB4NFHMC/9UTFt0E0fKtrUVSq1/gvz2SC8R+yCaBy1Pe5wu7VUQX3qC73oH8mnfORqtGdxJahBKDD5ikoraSRWo418KenI1tPF4jZwT3yk+Xrh1EnOym8+QktEEexWwpSSIdovo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=i0qRx6nS; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="i0qRx6nS"
Received: from pps.filterd (m0167069.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66U6YRL91774320
	for <linux-block@vger.kernel.org>; Thu, 30 Jul 2026 02:59:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=Wwzd
	h+lefzQ3Mewr3ag7PKLqaiugNuHuZ6D8zRZNNZY=; b=i0qRx6nSvdRp35M11yLi
	zCDL5833R4xWz9ehYcDjCN+iJy81EVfUbRN08bHwKN4Sv0jCdbucXr7pPAXPrQxg
	1n32YTlFzi84Wr18ittxMIrJzVdRnkygO8LEM7xlODihfBD+KKpFhVBicsOyZBR4
	JD+7PIf6HomtCv8bssHFR2jU/sxf0CVVHqPgBDVeubE9hqpuQG2Q/5k475unjLYu
	leSSOvM4xxdsLdk3pxUwcrvIJrrT21ENuMSN5TaP/FL7OVtRqYOQU+/M1DKF509J
	66cfLiS/MOEbOYUmN638Fpjn7j7NmlsYIk9r74XBJWePIIUuy2ZYsp95KPo8t/ry
	nw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4fqrjxt511-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Thu, 30 Jul 2026 02:59:08 -0400 (EDT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-92e55721a8cso206359785a.1
        for <linux-block@vger.kernel.org>; Wed, 29 Jul 2026 23:59:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785394745; x=1785999545;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Wwzdh+lefzQ3Mewr3ag7PKLqaiugNuHuZ6D8zRZNNZY=;
        b=so0ra73jb+H8zB5J0cN35ONxhFsa3hjF4KqC+5+0xW3xKW7/byUovJfZA3bv4rWAxt
         LnEAHngNAA0RvXvZvPsTGq7n8pvORPl2qAg2yED6Cd3U3mo5nbXA74k4LX8/XrDEufbo
         Nk7zY0bdrgbgONPKP/PTF9VawjMHtiyrN7pmd/hvPZL+XnYxKOSj7Mxt+5DwB5afhtxA
         tVfywUDjjMi2dGF7eov36QLJsPFE/0kUmsloftHnzUL3ZlSRll6FybGDkxtfcCNaDvh6
         ugQYnIVzD6io6imhmb2CbuSEHp5izpjIgrrO8GtLEs0FypmFWZX+PR0oT3aCp3UB1z5e
         cI1w==
X-Forwarded-Encrypted: i=1; AHgh+RrqcQuXAllphyeTTYT6s8yQwTZcIuETE2MX89X8RTZRZpoeEwhO4dv71LAFpo1WY6tANsOWNkPL+jjX6Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0x+z8x7WxamAtInira+CFTV0EoK8K55yvuEHi8EqyUSvbsnzW
	DEjs6xb6l5EoczDlTs6eiyHiojIjpvwLv1RLDD7ginCoevpP2SoWQltQv7lnRKUxgeYwwVAQIZm
	ytpMcE+UW1G/h1NkFeA3t8c34sFJnkiAhxWuWih7wzkmJ0UqhDBt17cYvdxrp
X-Gm-Gg: AR+sD11pJUc/bnjQwK6UXSYe54RTtQsqP9/MEFuefMo5NyGn576rOr3fBbj4bkF+ow+
	LYFH90Le4cty+mb+wme7lz/67fyk4Ppyum/ESY+EtvFczREjcOmXcEHVRALaAeE/cTRPV4sO7MG
	AG+S6/JK5EHVdrykVSCWuXlgveu1s8mSzC6kopfM8ruNML0j4b0G2Wsp3B7rNE27AUloshHni35
	VMcazOEMq7AfwYoOxBWr8E0kroEfDH1bOcS/p7Lq101zHYycSxo/g50OhOUk9tbX2n6nUd1RA7x
	W1tKMd2nwTg3abw7GIa95WRDibP7du9ITUiKxiSYHXO8wPm2WQ8ctofFfTH7b7X9zo9YVOLzpMX
	IMBn4iq+5AiIm/QrB9orGaC59LagLmk9ON8tDsxIUmUvOtA==
X-Received: by 2002:a05:620a:2886:b0:8cf:c106:faca with SMTP id af79cd13be357-93485fe35d1mr140937585a.36.1785394745164;
        Wed, 29 Jul 2026 23:59:05 -0700 (PDT)
X-Received: by 2002:a05:620a:2886:b0:8cf:c106:faca with SMTP id af79cd13be357-93485fe35d1mr140935685a.36.1785394744677;
        Wed, 29 Jul 2026 23:59:04 -0700 (PDT)
Received: from [127.0.1.1] (dyn-160-39-33-242.dyn.columbia.edu. [160.39.33.242])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-933d3221bc7sm349752485a.7.2026.07.29.23.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 23:59:03 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Thu, 30 Jul 2026 02:57:55 -0400
Subject: [PATCH v7 5/5] block: enable RWF_DONTCACHE for block devices
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260730-blk-dontcache-v7-5-3e8e6850068d@columbia.edu>
References: <20260730-blk-dontcache-v7-0-3e8e6850068d@columbia.edu>
In-Reply-To: <20260730-blk-dontcache-v7-0-3e8e6850068d@columbia.edu>
To: Jens Axboe <axboe@kernel.dk>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Carlos Maiolino <cem@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@infradead.org>, Gao Xiang <xiang@kernel.org>,
        Chao Yu <chao@kernel.org>, Yue Hu <zbestahu@gmail.com>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Sandeep Dhavale <dhavale@google.com>,
        Hongbo Li <lihongbo22@huawei.com>, Chunhai Guo <guochunhai@vivo.com>
Cc: Dave Chinner <dgc@kernel.org>, Bart Van Assche <bvanassche@acm.org>,
        Hillf Danton <hdanton@sina.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-erofs@lists.ozlabs.org,
        Christoph Hellwig <hch@lst.de>, Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.14.3-dev-d7477
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785394735; l=1234;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=Tk8jUyrOqQ7WXa1eqV1nq7SPxnPRM7zEp3j/WZJSWC8=;
 b=os6OKouVgqku2jRKGVaPk1noDMT3+eXOUJzWQsRazIMJ1bPae/JGJpIYkqGCxir04AYNo7/bT
 w+Brhzebg6AAvdsxWkzbY3bN7osSNAQdnJPqVkijmqj/2VMhvYhfElf
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDA0OCBTYWx0ZWRfXwjrwCllRbu5G
 Fgos3/Exoi8jSkAEkAfLtbD5IPxvsn8z54QNOpQYDUsqErb8G0bAf+fJsy4dYbiz34Ss3AGFK03
 z0kawAVPTRDWKKvcQcjosRK6lWumtjk3QFmQ2JTAaZAGjtIkfo4c
X-Proofpoint-ORIG-GUID: 4RD2uB6BY8Mr_MwEy6vKKPqjwdE5V3Ip
X-Proofpoint-GUID: 4RD2uB6BY8Mr_MwEy6vKKPqjwdE5V3Ip
X-Authority-Analysis: v=2.4 cv=ObCoyBTY c=1 sm=1 tr=0 ts=6a6af63c cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=GaPK54s0Se3oFqK5NkZy0g==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=x7bEGLp0ZPQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=JR4YdQiviy7OQf72WyZ1:22
 a=J9_MS8zF8NN3zyd_QTgA:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDA0OCBTYWx0ZWRfX8tpZWtjfBsNb
 /LSA5WhkzIc1HX8YW3EeYYQbmjNLYBlIRVoNbIX7yC30Xi7Szhx+VATqT7jy2iDkiJoQNAIjczk
 qy6IDU7++PeLfunw132nDKJyiqRFR+hxs7yVk5ibsweYKQ7b2tyeY3lI4sYRlnsOjx+jVJoyRKn
 /4vDhyVMbabqtAhTFPhFxLr4GtyOCllHJujZL9VPgqhqPqEK0JAT8xwGnP7itppeZ+jV0SEbKl5
 9hPTbVqJ7BRIsob6h984KU7c7c3d82dl2v4neAgbYMJ+8ArQeuO1F6MwQ6ErQ2QcNbs8ST0ONGt
 3OS45fNCRH1J1KoKXp6lws7tUWtrZn04hMlOIbhGRIm/THqliS3SU3Mkdx0yaT+Mul+VIluZE8P
 F17KDiuOaUpgDSW04+lJhKlVZ84tEHxDYcA6+DI96YAHyDqobClzT+aCxstTGWjmRLdvs/kziUn
 0wBWfFBgPtIQhNA6V1w==
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11859
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 bulkscore=10 malwarescore=0 impostorscore=10
 adultscore=0 priorityscore=1501 lowpriorityscore=10 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607300048

Block device buffered reads and writes already pass through
filemap_read() and iomap_file_buffered_write() respectively, both of
which handle IOCB_DONTCACHE. Enable RWF_DONTCACHE for block device files
by setting FOP_DONTCACHE in def_blk_fops.

For CONFIG_BUFFER_HEAD=y, writeback goes through buffer_head's
__bh_submit() which sets BIO_COMPLETE_IN_TASK on dropbehind folios. For
CONFIG_BUFFER_HEAD=n, writeback goes through iomap which handles it via
BIO_COMPLETE_IN_TASK on the ioend bio.

This support is useful for databases that operate on raw block devices,
among other userspace applications.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 block/fops.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/fops.c b/block/fops.c
index 15783a6180de..8b39c53b6393 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -941,7 +941,7 @@ const struct file_operations def_blk_fops = {
 	.splice_write	= iter_file_splice_write,
 	.fallocate	= blkdev_fallocate,
 	.uring_cmd	= blkdev_uring_cmd,
-	.fop_flags	= FOP_BUFFER_RASYNC,
+	.fop_flags	= FOP_BUFFER_RASYNC | FOP_DONTCACHE,
 };
 
 static __init int blkdev_init(void)

-- 
2.39.5

