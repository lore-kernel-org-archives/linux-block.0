Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5EF6335077
	for <linux-block@vger.kernel.org>; Mon, 24 Nov 2025 23:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764028110; cv=none; b=fl77yib0Au3nRhm9LJuCr6uqLXboXhiGOafkwBXS8wbRK4LYi4RlYv6TD5508Pg9wYPeBjjxJ9qWg6qgHbAAGXY4PZoSZJUtR/mefRbxsoROQGNeJEDvIliY8k2KFq4pDeWcDGiRco1fIAWvlIAvp5va50JStoKd3hs0C0k7RtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764028110; c=relaxed/simple;
	bh=Am7Xg6QJV818HftQaQoJheIX+hzBGkDxL1hHod2VREY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=luRJZ9S/x4HvHJIu2pSh3MOExf6u1UeNKw1//W3MV/wC+qrCcrG0IrDqOrUqb+57PsHjgc9dgAsO70d7q+RYFVYvd1VLlSTk9MJ3IER7/va57WrdvUMMgXC5o98uxoB87ljUXth4QHZApsRtMJ932wes6Kq6H62zC1sigG1aOdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j1p+HPxt; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j1p+HPxt"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-29568d93e87so46300115ad.2
        for <linux-block@vger.kernel.org>; Mon, 24 Nov 2025 15:48:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764028108; x=1764632908; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=14mujLSQeTKxSJUy/um1pAgQzTbPorW1qBu/kH6klR8=;
        b=j1p+HPxtmEJXq1utE07WkQkG5flpsDtFoeQM2jUrBDC6qKWM1nLMeIlhSLC9+NpIYi
         n4/q62g+t8PqkUImUcZdYWQ9E+IqnqzXK8BOc4daG66olSGcgd8vESZhU183lgbFGWLw
         bJzyz8FQm1wBtTjkNmWGsBwkrAjSUYPQOuyRvgnuslbcOXS8E7wf8QMGnFn9hXpPg2Uf
         B7kaMI0ZMw6Nc8ClKDSeJUBWafnApBQlQ8Lb1HDdWYiWqtk5yUaH3XIBnavJX/JbYKOZ
         yIoeSjOpsBKfdDTkwXA5EHzUnajxEViGSyFL297Yd+gPgWO5Zs6qAg3Wa4VWJ2hkvR42
         32SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764028108; x=1764632908;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=14mujLSQeTKxSJUy/um1pAgQzTbPorW1qBu/kH6klR8=;
        b=VDNS4GtVmKcXDBlExkWKONt41FOD63sCOQyzHrXJ97eVvePlQ1Mft35FiFPEruH2sS
         ywMoX4zwxl8T6dAsxVr8I1fir7UiwpRBpZ0dw+gtA+YtLju9w1PCt3DXDDFWtM0xQbcu
         lR30kjRf8o+Vd+vX/I5QaRDQSW9fpHlyhXZAGGZuXJ6yyqxtacgntq9mwM/sY5GBCK7l
         wx8MtPful0zfhTkkBpqvVLpPvfLxLJ5d9GzysoTySvI32GvByGuPuRTmX6Jxfu7A0ZTl
         lnSGZ8l2XqHPqYTetwQALVq0cjglAJFJDH989Gcio8eCAoWljorLsGdXAEbK3ajZly2t
         EHqQ==
X-Gm-Message-State: AOJu0YzaCYEjnmqi6avF3VCKm+6lrU37ejcElZeTUyWAmGE0bf+Jo6um
	CEjipt9DImrfqSacpigSjkdXgNoRIAhQiiwrCoOCd4AIoVGVUBnQHX9O
X-Gm-Gg: ASbGncsH5OMn5I3sfB+d1a1QnZI438d4vPGmiE62rWYj8GF8X0wqI8E0MfNuD5ZQ/eT
	T9urSryhB/BmdR2Grw6a91GGK2Ob5u1SNUamP5zamTM/vcDyJa/zFI3fJFU1Iw6mIAfFC61DduK
	kYj34KGvoyPO1cwjzRPtCrN0HjyPzQJQTpwLxXMGsaTTFqAIHm8P9nxsREUtEtqVGYGDTWG0eFb
	VNIO4Lq8VMol+HjLlAsmwDVG3SBnpg7y3vJS7pKg2psudVonOr+C7feq5QNNPjJ+u9jilVXOAZR
	cYLrsQMY8NIkTPGWhxXtMWlKNBsdtRCO6/EEpvfMBZhlMXwSbGONTZQdL8kL/VUy2pO8J7zbX/N
	MikIA14arGNyFF9vLz2BLGG9eWx1SS5coNGnCm332TEWDfc2pLRYc0onO5gyzoJlSq+a1uk6ix+
	TqPApUJvBwetMSguiiq55fr9FWwUpBPBmremhtdaiHuVC7FQw=
X-Google-Smtp-Source: AGHT+IFryzmc/XiOW9LSO9isjtYB1LRYx6LJmKSX/rJnv82E/9f71NMvnHJMZsWalBLPhm0XU6n7Vg==
X-Received: by 2002:a05:7022:ec88:b0:119:e55a:9bf5 with SMTP id a92af1059eb24-11cb3ef2594mr558577c88.17.1764028108043;
        Mon, 24 Nov 2025 15:48:28 -0800 (PST)
Received: from localhost (ip70-175-132-216.oc.oc.cox.net. [70.175.132.216])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11c93de6d5csm50934844c88.4.2025.11.24.15.48.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 15:48:27 -0800 (PST)
From: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
To: axboe@kernel.dk,
	agk@redhat.com,
	snitzer@kernel.org,
	mpatocka@redhat.com,
	song@kernel.org,
	yukuai@fnnas.com,
	hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com,
	jaegeuk@kernel.org,
	chao@kernel.org,
	cem@kernel.org
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dm-devel@lists.linux.dev,
	linux-raid@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-xfs@vger.kernel.org,
	bpf@vger.kernel.org,
	Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH V3 5/6] f2fs: ignore discard return value
Date: Mon, 24 Nov 2025 15:48:05 -0800
Message-Id: <20251124234806.75216-6-ckulkarnilinux@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20251124234806.75216-1-ckulkarnilinux@gmail.com>
References: <20251124234806.75216-1-ckulkarnilinux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__blkdev_issue_discard() always returns 0, making the error assignment
in __submit_discard_cmd() dead code.

Initialize err to 0 and remove the error assignment from the
__blkdev_issue_discard() call to err. Move fault injection code into
already present if branch where err is set to -EIO.

This preserves the fault injection behavior while removing dead error
handling.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
---
 fs/f2fs/segment.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index b45eace879d7..22b736ec9c51 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1343,15 +1343,9 @@ static int __submit_discard_cmd(struct f2fs_sb_info *sbi,
 
 		dc->di.len += len;
 
+		err = 0;
 		if (time_to_inject(sbi, FAULT_DISCARD)) {
 			err = -EIO;
-		} else {
-			err = __blkdev_issue_discard(bdev,
-					SECTOR_FROM_BLOCK(start),
-					SECTOR_FROM_BLOCK(len),
-					GFP_NOFS, &bio);
-		}
-		if (err) {
 			spin_lock_irqsave(&dc->lock, flags);
 			if (dc->state == D_PARTIAL)
 				dc->state = D_SUBMIT;
@@ -1360,6 +1354,8 @@ static int __submit_discard_cmd(struct f2fs_sb_info *sbi,
 			break;
 		}
 
+		__blkdev_issue_discard(bdev, SECTOR_FROM_BLOCK(start),
+				SECTOR_FROM_BLOCK(len), GFP_NOFS, &bio);
 		f2fs_bug_on(sbi, !bio);
 
 		/*
-- 
2.40.0

